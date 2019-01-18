# Tektronix Keithley 2634B 电源表

* 26xx系列可用Test Script Builder控制TS处理器，而模拟2400系列模式下的SCPI命令只能控制A通道。
* 下载TSB正在审查。

## Switching Between SCPI and TSP modes

### Model 2400 Emulation mode

To load the script into the internal memory:
1. Plug the USB drive (provided with the Series 2600B) into the front panel USB port.
2. Load the Persona2400 script (2600B-800A.tsp) and save the script to the Series 2600B
  internal nonvolatile memory.
  a. From the front panel, press the `MENU` key, and then select `SCRIPT > LOAD > USB1`.
  c. Use the navigation wheel to select the Persona2400.tsp script. If prompted to overwrite an existing
  script, select `YES` to overwrite (it may take a few seconds to complete loading the script).
  d. Turn the navigation wheel to select `SAVE-INTERNAL` and then press the navigation wheel (or
  the `ENTER` key).
  e. Select `YES` and then press the navigation wheel (or the `ENTER` key) to save the script internally (it
  may take a few seconds to complete the save).
  f. Press the `EXIT` key as needed to leave the menu structure.

To start Model 2400 emulation:
1. Press the `LOAD` key and then select `USER` from the menu.
2. Select `Run2400` and press the `ENTER` key (if this test is not loaded, you must load the script into
  internal nonvolatile memory).
3. Press the `RUN` key. You will notice the `REM` indicator lights (the script places the instrument in
  remote).

To configure options for the Model 2400 emulation:

1. If a script is running, press the `EXIT` key to abort.
2. Press the `LOAD` key, then select `USER` from the menu and then press the `ENTER` key.
3. Select `Configure2400` and then press the `ENTER` key.
4. Press the `RUN` key.
5. Select a menu item to configure the emulation. The available menu items are:
  • RunAtPowerON: Select `ENABLE` to configure the Series 2600B so it automatically starts in Model
  2400 emulation mode after the next power cycle. Select `DISABLE` to disable this option (disables the
  autorun for the next power cycle). This option does not place the Series 2600B into Model 2400
  emulation immediately.
  • DisplayErrors: Select `YES` to display error messages on the front panel as they occur; select `NO` to
  disable this option. This setting is not retained through power cycles. This option (when enabled) will
  delay the script execution by approximately 2 seconds when there is an error.
  • DeleteScript: To delete the Persona2400 script from Series 2600B, select `YES` and then turn the
  instrument off and back on. This step must be performed before reloading the Persona2400 script.
  Select `NO` to cancel.
  • Version: Select this menu item to display the Persona2400 script version.

Operating the Series 2600B as a Model 2400

1. When the script is loaded and running, the Series 2600B is ready to accept Model 2400 SCPI
   commands.
2. To exit out of Model 2400 emulation mode and return to Series 2600B normal operation, send the
   `DIAG:EXIT` command. You can also press the `EXIT` key to abort the script.

### Execute SCPI commands when not in Model 2400 emulation mode
You can execute SCPI commands when not in Model 2400 emulation mode. To accomplish this, send the `Initialize2400()` command once and then send the `Execute2400()` command with the SCPI command as a parameter in quotes. For example to execute the SCPI command `:SOURCE:VOLTAGE 1`, send  `Execute2400(":SOURCE:VOLTAGE 1")`. If quotes are needed in the SCPI command, use single quotes or use '`\`' as an escape character. For example, send one of the following commands to execute the SCPI command `:SENSE:FUNCTION "VOLT:DC"`:

```
Execute2400(":sens:func 'VOLT:DC'")
Execute2400(":sens:func \"VOLT:DC\"")
```
To return back to the Model 2400 emulation mode, send the `Engine2400()` command. After returning to the Model 2400 emulation mode, you must execute a `*RST` before running any further commands.

## Using TSP in *pyvisa*

In general the approach is to encapsulate your script into one or more functions.

Use the loadandrunscript/endscript construct to load the function into the runtime memory of the Test Script Processor.

Then call your function.

The very simple code below illustrates the concept:

CODE: [SELECT ALL](https://forum.tek.com/viewtopic.php?t=121440#)

```
    import visa

    mysmu=visa.instrument('gpib0::26::instr')

    mysmu.write('reset()')
    mysmu.write('errorqueue.clear()')

    mysmu.write('loadandrunscript')
    mysmu.write('function DoMyThing(duration, frequency)')
    mysmu.write('beeper.beep(duration, frequency)')
    mysmu.write('end')
    mysmu.write('endscript')

    # call custom function
    mysmu.write('DoMyThing(1, 800)')

    mysmu.close()
```