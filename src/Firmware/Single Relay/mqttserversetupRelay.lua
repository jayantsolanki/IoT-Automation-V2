--creating client with the macid as the client id 
m = mqtt.Client(wifi.sta.getmac(), 10)   --10sec keep alive
--lwt function sends the last will and testament message to tbe sent to the broker in case it goes offline
--m:lwt('lwt','offline',0,0)    

--mqtt offline function keeps checking whether the device has gone offline or not
m:on('offline',function(con) c = false end) 
-- on publish message receive event print the topic and data and do the task
m:on('message', function(conn, topic, data)
    print(topic .. ':')
    if data ~= nil then
      print(data)
    end 
  -- Use the data to turn the valve ON or OFF 
    
    if data == "1" then 
      startSwitch1()
    elseif data == "3" then 
      startSwitch2()
    elseif data == "0" then 
      stopSwitch1()
    elseif data == "2" then 
      stopSwitch2()
    elseif data == "R" then   
      payload=macid..','..'2'
      m:publish('register',payload,0,0, function(conn) end)
      print("Device Information sent")  
  --to give the user the battery status 
    elseif data == "B" then   
      -- paylaod format identifier,bat3,bat6
      --payload='1,'..tostring(bat3)..','..tostring(adc.read(0))
      payload=macid..','..'2,'..tostring(0)..','..tostring(0)
      m:publish('battery',payload,0,0, function(conn) end)--print('battery status sent') end)
      print("Battery status sent ")  
      --tweaked for pin2
      -- gpio.write(pin4,gpio.LOW)
      
    else
  end
end)

function startSwitch1()
    -- gpio.write(pin12,gpio.HIGH)
    gpio.write(pin4,gpio.LOW)
    -- doValve()
end
function startSwitch2()
    -- gpio.write(pin12,gpio.HIGH)
    gpio.write(pin2,gpio.LOW)
    -- doValve()
end
function stopSwitch1()
    gpio.write(pin4,gpio.HIGH)
end
function stopSwitch2()
    gpio.write(pin2,gpio.HIGH)
end
-- function doValve()
--   gpio.write(pin13,gpio.HIGH) 
--   tmr.delay(1000000)
--   gpio.write(pin13,gpio.LOW)
-- end
