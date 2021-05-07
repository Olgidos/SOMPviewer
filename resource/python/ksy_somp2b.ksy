---
meta:
  id: somp2b
  endian: le
doc: |
  :field influxdb_field: katai_field
  :field callsign: ax25_frame.ax25_header.dest_callsign_raw.callsign_ror.callsign
  :field ssid_mask: ax25_frame.ax25_header.dest_ssid_raw.ssid_mask
  :field ssid: ax25_frame.ax25_header.dest_ssid_raw.ssid
  :field src_callsign_raw_callsign: ax25_frame.ax25_header.src_callsign_raw.callsign_ror.callsign
  :field src_ssid_raw_ssid_mask: ax25_frame.ax25_header.src_ssid_raw.ssid_mask
  :field src_ssid_raw_ssid: ax25_frame.ax25_header.src_ssid_raw.ssid
  :field ctl: ax25_frame.ax25_header.ctl
  :field pid: ax25_frame.payload.pid
  :field beacon_header_flags1: ax25_frame.payload.ax25_info.beacon_header.beacon_header_flags1
  :field beacon_header_flags2: ax25_frame.payload.ax25_info.beacon_header.beacon_header_flags2
  :field beacon_utc: ax25_frame.payload.ax25_info.beacon_payload.beacon_utc
  :field beacon_on_time: ax25_frame.payload.ax25_info.beacon_payload.beacon_on_time
  :field bat1_voltage_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_voltage_raw
  :field bat1_current_charge_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_current_charge_raw
  :field bat1_temperature_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_temperature_raw
  :field bat1_soc: ax25_frame.payload.ax25_info.beacon_payload.bat1_soc
  :field bat2_voltage_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_voltage_raw
  :field bat2_current_charge_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_current_charge_raw
  :field bat2_temperature_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_temperature_raw
  :field bat2_soc: ax25_frame.payload.ax25_info.beacon_payload.bat2_soc
  :field pnl_current_bat_ym_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_ym_raw
  :field pnl_current_bat_xm_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_xm_raw
  :field pnl_current_bat_yp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_yp_raw
  :field pnl_current_bat_xp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_xp_raw
  :field pnl_current_bat_z_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_z_raw
  :field pnl_temperature_ym_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_ym_raw
  :field pnl_temperature_xm_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_xm_raw
  :field pnl_temperature_yp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_yp_raw
  :field pnl_temperature_xp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_xp_raw
  :field pnl_temperature_z_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_z_raw
  :field v3v3_bus_voltage_raw: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_voltage_raw
  :field v3v3_bus_current_tot: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_current_tot
  :field v3v3_bus_current_c1: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_current_c1
  :field v3v3_bus_current_c2: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_current_c2
  :field cs_temperature_raw: ax25_frame.payload.ax25_info.beacon_payload.cs_temperature_raw
  :field cs_status: ax25_frame.payload.ax25_info.beacon_payload.cs_status
  :field cs_beacon_time: ax25_frame.payload.ax25_info.beacon_payload.cs_beacon_time
  :field obc_rst_cnt: ax25_frame.payload.ax25_info.beacon_payload.obc_rst_cnt
  :field obc_telem_packet_id: ax25_frame.payload.ax25_info.beacon_payload.obc_telem_packet_id
  :field obc_temperature_raw: ax25_frame.payload.ax25_info.beacon_payload.obc_temperature_raw
  :field obc_load: ax25_frame.payload.ax25_info.beacon_payload.obc_load
  :field obc_last_reboot_y: ax25_frame.payload.ax25_info.beacon_payload.obc_last_reboot_y
  :field obc_mode: ax25_frame.payload.ax25_info.beacon_payload.obc_mode
  :field adcs_mode: ax25_frame.payload.ax25_info.beacon_payload.adcs_mode
  :field b_field_x_raw: ax25_frame.payload.ax25_info.beacon_payload.b_field_x_raw
  :field b_field_y_raw: ax25_frame.payload.ax25_info.beacon_payload.b_field_y_raw
  :field b_field_z_raw: ax25_frame.payload.ax25_info.beacon_payload.b_field_z_raw
  :field sun_vect_x_raw: ax25_frame.payload.ax25_info.beacon_payload.sun_vect_x_raw
  :field sun_vect_y_raw: ax25_frame.payload.ax25_info.beacon_payload.sun_vect_y_raw
  :field sun_vect_z_raw: ax25_frame.payload.ax25_info.beacon_payload.sun_vect_z_raw
  :field q_ib_w_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_w_raw
  :field q_ib_current_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_current_raw
  :field q_ib_j_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_j_raw
  :field q_ib_k_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_k_raw
  :field angular_rate_x_raw: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_x_raw
  :field angular_rate_y_raw: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_y_raw
  :field angular_rate_z_raw: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_z_raw
  :field science_pld_info: ax25_frame.payload.ax25_info.beacon_payload.science_pld_info
  :field bat1_voltage: ax25_frame.payload.ax25_info.beacon_payload.bat1_voltage
  :field bat1_current_charge: ax25_frame.payload.ax25_info.beacon_payload.bat1_current_charge
  :field bat1_temp: ax25_frame.payload.ax25_info.beacon_payload.bat1_temp
  :field bat2_voltage: ax25_frame.payload.ax25_info.beacon_payload.bat2_voltage
  :field bat2_current_charge: ax25_frame.payload.ax25_info.beacon_payload.bat2_current_charge
  :field bat2_temp: ax25_frame.payload.ax25_info.beacon_payload.bat2_temp
  :field pnl_current_bat_ym: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_ym
  :field pnl_current_bat_xm: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_xm
  :field pnl_current_bat_yp: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_yp
  :field pnl_current_bat_xp: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_xp
  :field pnl_current_bat_z: ax25_frame.payload.ax25_info.beacon_payload.pnl_current_bat_z
  :field pnl_temperature_ym: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_ym
  :field pnl_temperature_xm: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_xm
  :field pnl_temperature_yp: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_yp
  :field pnl_temperature_xp: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_xp
  :field pnl_temperature_z: ax25_frame.payload.ax25_info.beacon_payload.pnl_temperature_z
  :field v3v3_bus_voltage: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_voltage
  :field cs_temp: ax25_frame.payload.ax25_info.beacon_payload.cs_temp
  :field obc_temp: ax25_frame.payload.ax25_info.beacon_payload.obc_temp
  :field b_field_x: ax25_frame.payload.ax25_info.beacon_payload.b_field_x
  :field b_field_y: ax25_frame.payload.ax25_info.beacon_payload.b_field_y
  :field b_field_z: ax25_frame.payload.ax25_info.beacon_payload.b_field_z
  :field sun_vect_x: ax25_frame.payload.ax25_info.beacon_payload.sun_vect_x
  :field sun_vect_y: ax25_frame.payload.ax25_info.beacon_payload.sun_vect_y
  :field sun_vect_z: ax25_frame.payload.ax25_info.beacon_payload.sun_vect_z
  :field q_ib_w: ax25_frame.payload.ax25_info.beacon_payload.q_ib_w
  :field q_ib_i: ax25_frame.payload.ax25_info.beacon_payload.q_ib_i
  :field q_ib_j: ax25_frame.payload.ax25_info.beacon_payload.q_ib_j
  :field q_ib_k: ax25_frame.payload.ax25_info.beacon_payload.q_ib_k
  :field angular_rate_x: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_x
  :field angular_rate_y: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_y
  :field angular_rate_z: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_z
  :field ant1_stat: ax25_frame.payload.ax25_info.beacon_payload.ant1_stat
  :field ant2_stat: ax25_frame.payload.ax25_info.beacon_payload.ant2_stat
  :field bat1_int_temperature_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_int_temperature_raw
  :field bat1_rc: ax25_frame.payload.ax25_info.beacon_payload.bat1_rc
  :field bat1_imax: ax25_frame.payload.ax25_info.beacon_payload.bat1_imax
  :field bat1_pow_avg: ax25_frame.payload.ax25_info.beacon_payload.bat1_pow_avg
  :field bat1_fac: ax25_frame.payload.ax25_info.beacon_payload.bat1_fac
  :field bat1_cyc: ax25_frame.payload.ax25_info.beacon_payload.bat1_cyc
  :field bat1_soh: ax25_frame.payload.ax25_info.beacon_payload.bat1_soh
  :field bat1_tte: ax25_frame.payload.ax25_info.beacon_payload.bat1_tte
  :field bat1_stat_flags: ax25_frame.payload.ax25_info.beacon_payload.bat1_stat_flags
  :field bat1_pc: ax25_frame.payload.ax25_info.beacon_payload.bat1_pc
  :field bat2_int_temperature_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_int_temperature_raw
  :field bat2_rc: ax25_frame.payload.ax25_info.beacon_payload.bat2_rc
  :field bat2_imax: ax25_frame.payload.ax25_info.beacon_payload.bat2_imax
  :field bat2_pow_avg: ax25_frame.payload.ax25_info.beacon_payload.bat2_pow_avg
  :field bat2_fac: ax25_frame.payload.ax25_info.beacon_payload.bat2_fac
  :field bat2_cyc: ax25_frame.payload.ax25_info.beacon_payload.bat2_cyc
  :field bat2_soh: ax25_frame.payload.ax25_info.beacon_payload.bat2_soh
  :field bat2_tte: ax25_frame.payload.ax25_info.beacon_payload.bat2_tte
  :field bat2_stat_flags: ax25_frame.payload.ax25_info.beacon_payload.bat2_stat_flags
  :field bat2_pc: ax25_frame.payload.ax25_info.beacon_payload.bat2_pc
  :field cs_op_cnt: ax25_frame.payload.ax25_info.beacon_payload.cs_op_cnt
  :field cs_time_1: ax25_frame.payload.ax25_info.beacon_payload.cs_time_1
  :field cs_time_2: ax25_frame.payload.ax25_info.beacon_payload.cs_time_2
  :field cs_time_3: ax25_frame.payload.ax25_info.beacon_payload.cs_time_3
  :field rssi: ax25_frame.payload.ax25_info.beacon_payload.rssi
  :field bytes_rx: ax25_frame.payload.ax25_info.beacon_payload.bytes_rx
  :field bytes_tx: ax25_frame.payload.ax25_info.beacon_payload.bytes_tx
  :field v3v3_bus_v_tot: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_v_tot
  :field v3v3_bus_v_c1: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_v_c1
  :field v3v3_bus_v_c2: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_v_c2
  :field obc_boot_utc: ax25_frame.payload.ax25_info.beacon_payload.obc_boot_utc
  :field bat1_int_temp: ax25_frame.payload.ax25_info.beacon_payload.bat1_int_temp
  :field bat2_int_temp: ax25_frame.payload.ax25_info.beacon_payload.bat2_int_temp
  :field is_valid_source: ax25_frame.payload.ax25_info.is_valid_source
  :field is_valid_payload: ax25_frame.payload.ax25_info.is_valid_payload
  :field ax25_info: ax25_frame.payload.ax25_info

seq:
  - id: ax25_frame
    type: ax25_frame
    doc-ref: 'https://www.tapr.org/pub_ax25.html'

types:
  ax25_frame:
    seq:
      - id: ax25_header
        type: ax25_header
      - id: payload
        type:
          switch-on: ax25_header.ctl & 0x13
          cases:
            0x03: ui_frame
            0x13: ui_frame
            0x00: i_frame
            0x02: i_frame
            0x10: i_frame
            0x12: i_frame

  ax25_header:
    seq:
      - id: dest_callsign_raw
        type: callsign_raw
      - id: dest_ssid_raw
        type: ssid_mask
      - id: src_callsign_raw
        type: callsign_raw
      - id: src_ssid_raw
        type: ssid_mask
      - id: ctl
        type: u1

  callsign_raw:
    seq:
      - id: callsign_ror
        process: ror(1)
        size: 6
        type: callsign

  callsign:
    seq:
      - id: callsign
        type: str
        encoding: utf-8
        size: 6

  ssid_mask:
    seq:
      - id: ssid_mask
        type: u1
    instances:
      ssid:
        value: (ssid_mask & 0x0f) >> 1

  i_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        size-eos: true

  ui_frame:
    seq:
      - id: pid
        type: u1
      - id: ax25_info
        type: beacon
        size-eos: true

  beacon:
    seq:
      - id: beacon_header
        type:
          switch-on: is_valid_source
          cases:
            true: beacon_header
      - id: beacon_payload
        if: is_valid_payload
        type:
          switch-on: beacon_header.beacon_header_flags2
          cases:
            48: beacon_60s
            49: beacon_legacy
    instances:
      is_valid_source:
        value: >-
          (_root.ax25_frame.ax25_header.src_callsign_raw.callsign_ror.callsign
          == 'DP2TUD')

      is_valid_payload:
        value: >-
          (
          (beacon_header.beacon_header_flags1 == 0x54)
          and (beacon_header.beacon_header_flags2 == 0x30)
          or
          (beacon_header.beacon_header_flags1 == 0x54)
          and (beacon_header.beacon_header_flags2 == 0x31)
          )
          
  bitmap16_subsystem_status:
    seq:
      - id: beacon_payload_subsystem_status_bitmap
        type: u2le

  beacon_header:
    seq:
      - id: beacon_header_flags1
        type: u1
      - id: beacon_header_flags2
        type: u1

  beacon_60s:
    seq:
      - id: beacon_utc
        type: u4
        doc: 'OBC Time Stamp [s]'
      - id: beacon_on_time
        type: u4
        doc: 'Uptime since last reboot [s]'
      - id: bat1_voltage_raw
        type: b12le
        doc: 'Battery1 - Voltage [mV]'
      - id: bat1_current_charge_raw
        type: b12le
        doc: 'Battery1 - Charge current [mA]'
      - id: bat1_temperature_raw
        type: b10le
        doc: 'Battery1 - Battery Temperature [0.1 °C]'
      - id: bat1_soc
        type: b8le
        doc: 'Battery1 - State of Charge [%]'
      - id: bat2_voltage_raw
        type: b12le
        doc: 'Battery2 - Voltage [mV]'
      - id: bat2_current_charge_raw
        type: b12le
        doc: 'Battery2 - Charge current [mA]'
      - id: bat2_temperature_raw
        type: b10le
        doc: 'Battery2 - Battery Temperature [0.1 °C]'
      - id: bat2_soc
        type: b8le
        doc: 'Battery2 - State of Charge [%]'
      - id: pnl_current_bat_ym_raw
        type: b10le
        doc: 'Y- Panel - Current from SCs to Battery [mA]'
      - id: pnl_current_bat_xm_raw
        type: b10le
        doc: 'X- Panel - Current from SCs to Battery [mA]'
      - id: pnl_current_bat_yp_raw
        type: b10le
        doc: 'Y+ Panel - Current from SCs to Battery [mA]'
      - id: pnl_current_bat_xp_raw
        type: b10le
        doc: 'X+ Panel - Current from SCs to Battery [mA]'
      - id: pnl_current_bat_z_raw
        type: b10le
        doc: 'Z+ Panel - Current from SCs to Battery [mA]'
      - id: pnl_temperature_ym_raw
        type: b10le
        doc: 'Y- Panel - Temperature [0.1 °C]'
      - id: pnl_temperature_xm_raw
        type: b10le
        doc: 'X- Panel - Temperature [0.1 °C]'
      - id: pnl_temperature_yp_raw
        type: b10le
        doc: 'Y+ Panel - Temperature [0.1 °C]'
      - id: pnl_temperature_xp_raw
        type: b10le
        doc: 'X+ Panel - Temperature [0.1 °C]'
      - id: pnl_temperature_z_raw
        type: b10le
        doc: 'Z+ Panel - Temperature [0.1 °C]'
      - id: v3v3_bus_voltage_raw
        type: b12le
        doc: '3V3 Bus - Voltage [mV]'
      - id: v3v3_bus_current_tot
        type: b10le
        doc: '3V3 Bus - Current Total [mA]'
      - id: v3v3_bus_current_c1
        type: b10le
        doc: '3V3 Bus - Current Converter 1 [mA]'
      - id: v3v3_bus_current_c2
        type: b10le
        doc: '3V3 Bus - Current Converter 2 [mA]'
      - id: cs_temperature_raw
        type: b10le
        doc: 'CS Module - Temperature [0.1 °C]'
      - id: cs_status
        type: b8le
        doc: |
          CS Module - Antenna Deployment  [ - ]
          Bit 0: Antenna1
          Bit 1: Antenna2 (Bit set if deployed)
          Bit 2: CS Module 1 active
          Bit 3: CS Module 2 active
      - id: cs_beacon_time
        type: b8le
        doc: 'CS Beacon Interval [s]'
      - id: obc_rst_cnt
        type: b16le
        doc: 'OBC Reset Counter [ - ]'
      - id: obc_telem_packet_id
        type: b16le
        doc: 'OBC Telemetry Packet ID [ - ]'
      - id: obc_temperature_raw
        type: b10le
        doc: 'OBC Temperature [0.1 °C]'
      - id: obc_load
        type: b8le
        doc: 'OBC CPU Load [%]'
      - id: obc_last_reboot_y
        type: b8le
        doc: 'OBC Last Reboot Reason [ - ]'
      - id: obc_adcs_mode
        type: b8le
        doc: |
          'OCB and ADCS Mode [ - ]'
          Bit 0: Eclipsed
          Bit 1…3: ADCS Mode (0x0 - off, 0x1 - ADS, 0x2 - ADCS, 0x3 - Detumbling)
          Bit 4…7: OBC Mode
      - id: b_field_x_raw
        type: b12le
        doc: 'ADCS Magnetic Field X (normalised) [ - ]'
      - id: b_field_y_raw
        type: b12le
        doc: 'ADCS Magnetic Field Y (normalised) [ - ]'
      - id: b_field_z_raw
        type: b12le
        doc: 'ADCS Magnetic Field Z (normalised) [ - ]'
      - id: sun_vect_x_raw
        type: b12le
        doc: 'ADCS Sun Vector X  [ - ]'
      - id: sun_vect_y_raw
        type: b12le
        doc: 'ADCS Sun Vector Y  [ - ]'
      - id: sun_vect_z_raw
        type: b12le
        doc: 'ADCS Sun Vector Z  [ - ]'
      - id: q_ib_w_raw
        type: b16le
        doc: 'ADCS qECI w [ - ]'
      - id: q_ib_current_raw
        type: b16le
        doc: 'ADCS qECI i [ - ]'
      - id: q_ib_j_raw
        type: b16le
        doc: 'ADCS qECI j [ - ]'
      - id: q_ib_k_raw
        type: b16le
        doc: 'ADCS qECI k [ - ]'
      - id: angular_rate_x_raw
        type: b12le
        doc: 'ADCS Angular Rate X [deg/s]'
      - id: angular_rate_y_raw
        type: b12le
        doc: 'ADCS Angular Rate Y [deg/s]'
      - id: angular_rate_z_raw
        type: b12le
        doc: 'ADCS Angular Rate Z [deg/s]'
      - id: stuffingbits
        type: b6
      - id: science_pld_info
        type: b32le
    instances:
      bat1_voltage:
        value: bat1_voltage_raw / 2 + 2500
      bat1_current_charge:
        value: bat1_current_charge_raw / 0.5 - 4094
      bat1_temp:
        value: (bat1_temperature_raw / 0.7 - 400) / 10
      bat2_voltage:
        value: bat2_voltage_raw / 2 + 2500
      bat2_current_charge:
        value: bat2_current_charge_raw / 0.5 - 4094
      bat2_temp:
        value: (bat2_temperature_raw / 0.7 - 400) / 10
      pnl_current_bat_ym:
        value: pnl_current_bat_ym_raw / 0.5
      pnl_current_bat_xm:
        value: pnl_current_bat_xm_raw / 0.5
      pnl_current_bat_yp:
        value: pnl_current_bat_yp_raw / 0.5
      pnl_current_bat_xp:
        value: pnl_current_bat_xp_raw / 0.5
      pnl_current_bat_z:
        value: pnl_current_bat_z_raw / 0.5
      pnl_temperature_ym:
        value: pnl_temperature_ym_raw / 0.7 - 400
      pnl_temperature_xm:
        value: pnl_temperature_xm_raw / 0.7 - 400
      pnl_temperature_yp:
        value: pnl_temperature_yp_raw / 0.7 - 400
      pnl_temperature_xp:
        value: pnl_temperature_xp_raw / 0.7 - 400
      pnl_temperature_z:
        value: pnl_temperature_z_raw / 0.7 - 400
      v3v3_bus_voltage:
        value: v3v3_bus_voltage_raw + 2789
      ant_1:
        value: cs_status & 1
      ant_2:
        value: (cs_status & 2) / 2
      cs_module:
        value: (cs_status & 12) / 4
      obc_mode:
        value: (obc_adcs_mode & 240) / 16
      adcs_mode:
        value: (obc_adcs_mode & 14) / 2
      eclipsed:
        value: obc_adcs_mode & 1
      cs_temp:
        value: cs_temperature_raw / 0.7 - 400
      obc_temp:
        value: (obc_temperature_raw / 0.7 - 400) / 10
      b_field_x:
        value: b_field_x_raw / 2.0 -1023
      b_field_y:
        value: b_field_y_raw / 2.0 -1023
      b_field_z:
        value: b_field_z_raw / 2.0 -1023
      sun_vect_x:
        value: sun_vect_x_raw / 2047.0 - 1
      sun_vect_y:
        value: sun_vect_y_raw / 2047.0 - 1
      sun_vect_z:
        value: sun_vect_z_raw / 2047.0 - 1
      q_ib_w:
        value: q_ib_w_raw / 32767.0 - 1
      q_ib_i:
        value: q_ib_current_raw / 32767.0 - 1
      q_ib_j:
        value: q_ib_j_raw / 32767.0 - 1
      q_ib_k:
        value: q_ib_k_raw / 32767.0 - 1
      angular_rate_x:
        value: (angular_rate_x_raw / 59.0 -35)*180/3.14159
      angular_rate_y:
        value: (angular_rate_y_raw / 59.0 -35)*180/3.14159
      angular_rate_z:
        value: (angular_rate_z_raw / 59.0 -35)*180/3.14159

  beacon_legacy:
    seq:
      - id: ant_1
        type: u1
        doc: 'Antenna 1 deployed [0 - No]'
      - id: ant_2
        type: u1
        doc: 'Antenna 2 deployed [0 - No]'
      - id: bat1_voltage
        type: u2
        doc: 'Battery1 - Voltage	[mV]'
      - id: bat1_current_charge
        type: s2
        doc: 'Battery1 - Charge current	[mA]'
      - id: bat1_temperature_raw
        type: s2
        doc: 'Battery1 - Battery Temperature	[0.1°C]'
      - id: bat1_int_temperature_raw
        type: s2
        doc: 'Battery1 - IC Temperature	[0.1°C]'
      - id: bat1_rc
        type: u2
        doc: 'Battery1 - Remaining Capacity 	[mAh]'
      - id: bat1_soc
        type: u2
        doc: 'Battery1 - State of Charge	[%]'
      - id: bat1_imax
        type: s2
        doc: 'Battery1 - Maximum Charge Current	[mA]'
      - id: bat1_pow_avg
        type: s2
        doc: 'Battery1 - Average Power	[mWh]'
      - id: bat1_fac
        type: u2
        doc: 'Battery1 - Full Available Capacity	[mAh]'
      - id: bat1_cyc
        type: u2
        doc: 'Battery1 - Cycle Count of Charge Cycles [ ]'
      - id: bat1_soh
        type: u2
        doc: 'Battery1 - State of Health	[%]'
      - id: bat1_tte
        type: u2
        doc: 'Battery1 - Time to Empty in min	[min]'
      - id: bat1_stat_flags
        type: u2
      - id: bat1_pc
        type: s2
        doc: 'Battery1 - Passed Charge	[mAh]'
      - id: bat2_voltage
        type: u2
        doc: 'Battery2 - Voltage	[mV]'
      - id: bat2_current_charge
        type: s2
        doc: 'Battery2 - Charge current	[mA]'
      - id: bat2_temperature_raw
        type: s2
        doc: 'Battery2 - Battery Temperature	[0.1°C]'
      - id: bat2_int_temperature_raw
        type: s2
        doc: 'Battery2 - IC Temperature	[0.1°C]'
      - id: bat2_rc
        type: u2
        doc: 'Battery2 - Remaining Capacity 	[mAh]'
      - id: bat2_soc
        type: u2
        doc: 'Battery2 - State of Charge	[%]'
      - id: bat2_imax
        type: s2
        doc: 'Battery2 - Maximum Charge Current	[mA]'
      - id: bat2_pow_avg
        type: s2
        doc: 'Battery2 - Average Power	[mWh]'
      - id: bat2_fac
        type: u2
        doc: 'Battery2 - Full Available Capacity	[mAh]'
      - id: bat2_cyc
        type: u2
        doc: 'Battery2 - Cycle Count of Charge Cycles [ ]'
      - id: bat2_soh
        type: u2
        doc: 'Battery2 - State of Health	[%]'
      - id: bat2_tte
        type: u2
        doc: 'Battery2 - Time to Empty in min	[min]'
      - id: bat2_stat_flags
        type: u2
      - id: bat2_pc
        type: s2
        doc: 'Battery2 - Passed Charge	[mAh]'
      - id: cs_op_cnt
        type: u2
        doc: 'CS module - Operation Counter [ ]'
      - id: cs_temp
        type: s2
        doc: 'CS module - Temperature [°C]'
      - id: cs_time_1
        type: u1
      - id: cs_time_2
        type: u1
      - id: cs_time_3
        type: u1
      - id: rssi
        type: u1
        doc: 'CS module - RSSI [ ]'
      - id: bytes_rx
        type: u4
        doc: 'CS module - [Received Bytes]'
      - id: bytes_tx
        type: u4
        doc: 'CS module - [Transmitted Bytes]'
      - id: v3v3_bus_current_tot
        type: s2
        doc: '3V3 Bus - Total Current 	[mA]' 
      - id: v3v3_bus_current_c1
        type: s2
        doc: '3V3 Converter 1 - Current	[mA]'
      - id: v3v3_bus_current_c2
        type: s2
        doc: '3V3 Converter 2 - Current	[mA]'
      - id: v3v3_bus_voltage
        type: s2
        doc: '3V3 Bus - Voltage	[mV]'
      - id: v3v3_bus_v_c1
        type: s2
        doc: '3V3 Converter 1 - Voltage	[mV]'
      - id: v3v3_bus_v_c2
        type: s2
        doc: '3V3 Converter 2 - Voltage	[mV]'
      - id: obc_rst_cnt
        type: u4
        doc: 'Reset Counter [ ]'
      - id: obc_boot_utc
        type: u4
        doc: 'Time Stamp from last Reboot [Unix UTC since 2000]'
      - id: beacon_on_time
        type: u4
        doc: 'Time since last Reboot	[s]'
    instances:
      bat1_temp:
        value: bat1_temperature_raw / 10.0
      bat1_int_temp:
        value: bat1_int_temperature_raw / 10.0
      bat2_temp:
        value: bat2_temperature_raw / 10.0
      bat2_int_temp:
        value: bat2_temperature_raw / 10.0
      beacon_utc:
        value: obc_boot_utc + beacon_on_time
        
