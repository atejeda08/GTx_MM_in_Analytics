# Movie Theather Simulation 

# Goal - Average Wait - 10 min or less

# Steps: 
# arrive at theather
# get in line to buy a ticket
# buy a ticket
# wait in line to buy a ticket
# buy a ticket
# wait in line to have their tocket checked 
# have their ticket checked
# decide to buy concessions or not
# buy concessions or go directly to seat. 

# Start defining simulation
import simpy
import random
import statistics

wait_times = []


class Theater(object):
    def __init__(self, env, num_cashiers, num_servers, num_ushers):
        self.env = env
        self.num_cashiers = simpy.Resource(env, num_cashiers)
        self.num_servers = simpy.Resource(env, num_servers)
        self.num_ushers = simpy.Resource(env, num_ushers)
    
    def purchase_ticket(self, moviegoer):
        yield self.env.timeout(random.randint(1,3)) # assuming it takes between **1 to 2 minutes** to purchase_ticket. 
                                                    # this will trigger an event after the timeout period.
    
    def check_tickets(self, moviegoer): # manager says 3 seconds 
        yield self.env.timeout(3/60)
        
    def sell_food(self, moviegoer): # manager says 1 and 5 minutes 
        yield self.env.timeout(random.randint(1,6))

def go_to_movies(env,moviegoer, Theater):        
    # arrive at theater
    arrival_time = env.now 
    
    # buy ticket
    with theater.cashier.request() as request: # this is a generator. Checks if there is a cashier available or else moviegoer waits. 
        yield request
        yield env.process(theater.purchase_ticket(moviegoer)) # when one is available, calls purchase_ticket function into action.  
    
    # check ticket    
    with theater.usher.request() as request:
        yield request
        yield env.process(theater.check_ticket(moviegoer))
    
    # decide whether to get food or not 
    if random.choice([True, False]): # add randomness. Pass on a list of true and false assuming 50:50 splits.
        with theater.server.request() as request: # check if server is available
            yield request 
            yield env.process(theater.sell_food(moviegoer)) # call the serving function 
            
    # go to their seats
    wait_times.append(env.now - arrival_time) # this appends time_now - arrival_time
    
# define a function that runs the simulation.     
 def run_theater(env, num_cashiers, num_servers, num_ushers): 
     theater = Theater(env, num_cashiers, num_servers, num_ushers)

    
    
    
    
    
          
        
        
