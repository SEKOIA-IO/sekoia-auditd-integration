import time

from pydantic import BaseModel, HttpUrl
import requests
from requests import HTTPError
from sekoia_automation.trigger import Trigger  


class TriggerConfiguration(BaseModel):
    url: HttpUrl


class Entry(BaseModel):
    id: int
    value: str
    timestamp: int


class NewEntries(BaseModel):
    entries: list[Entry]


class NewEntriesTrigger(Trigger):
    configuration: TriggerConfiguration  
    results_model = NewEntries  

    def run(self):  
        while True:
            try:
                response = requests.get(self.configuration.url)
                response.raise_for_status()

                entries = response.json()
                self.send_event(  
                    event_name=f"Pushing {len(entries)} new entries", 
                    event=NewEntries(entries=entries),
                )
            except HTTPError:
                self.log(  
                    f"HTTP Request failed: {self.configuration.url} with {response.status_code}",
                    level="error",
                )
            time.sleep(3600)