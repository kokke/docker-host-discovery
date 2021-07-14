import time
import paho
import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    if rc==0:
        print("connected OK Returned code=",rc)
    else:
        print("Bad connection Returned code=",rc)

def on_message(client, userdata, msg):
    print("topic='%s', msg='%s'" % (msg.topic, str(msg.payload.decode("utf-8"))))




if __name__ == "__main__":


    client = mqtt.Client("c2", transport="tcp")
    client.on_message = on_message
    client.on_connect = on_connect
    client.connect(host="mosquitto", port=1883, keepalive=10)
    client.loop_start()

    while True:

        client.publish("hej", "mor")
        time.sleep(1)
