class Utils:
    def __init__(self):
        pass
    def portObserver(self, newlist, oldlist):

        if(len(newlist)and len(oldlist)):
            if(len(newlist)>len(oldlist)):
                device = [x for x in newlist if x not in oldlist]
                return "The device {} has connected on port {}".format(device[0]['name'], device[0]['port'])
            else:
                device = [x for x in oldlist if x not in newlist]
                return "The device {} has disconnected".format(device[0]['name'])


        