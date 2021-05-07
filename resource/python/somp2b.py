# This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

from pkg_resources import parse_version
import kaitaistruct
from kaitaistruct import KaitaiStruct, KaitaiStream, BytesIO


if parse_version(kaitaistruct.__version__) < parse_version('0.9'):
    raise Exception("Incompatible Kaitai Struct Python API: 0.9 or later is required, but you have %s" % (kaitaistruct.__version__))

class Somp2b(KaitaiStruct):
    """:field influxdb_field: katai_field
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
    :field bat1_i_charge_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_i_charge_raw
    :field bat1_temp_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_temp_raw
    :field bat1_soc: ax25_frame.payload.ax25_info.beacon_payload.bat1_soc
    :field bat2_voltage_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_voltage_raw
    :field bat2_i_charge_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_i_charge_raw
    :field bat2_temp_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_temp_raw
    :field bat2_soc: ax25_frame.payload.ax25_info.beacon_payload.bat2_soc
    :field pnl_i_bat_ym_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_ym_raw
    :field pnl_i_bat_xm_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_xm_raw
    :field pnl_i_bat_yp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_yp_raw
    :field pnl_i_bat_xp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_xp_raw
    :field pnl_i_bat_z_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_z_raw
    :field pnl_temp_ym_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_ym_raw
    :field pnl_temp_xm_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_xm_raw
    :field pnl_temp_yp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_yp_raw
    :field pnl_temp_xp_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_xp_raw
    :field pnl_temp_z_raw: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_z_raw
    :field v3v3_bus_voltage_raw: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_voltage_raw
    :field v3v3_bus_i_tot: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_i_tot
    :field v3v3_bus_i_c1: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_i_c1
    :field v3v3_bus_i_c2: ax25_frame.payload.ax25_info.beacon_payload.v3v3_bus_i_c2
    :field cs_temp_raw: ax25_frame.payload.ax25_info.beacon_payload.cs_temp_raw
    :field cs_status: ax25_frame.payload.ax25_info.beacon_payload.cs_status
    :field cs_beacon_time: ax25_frame.payload.ax25_info.beacon_payload.cs_beacon_time
    :field obc_rst_cnt: ax25_frame.payload.ax25_info.beacon_payload.obc_rst_cnt
    :field obc_telem_packet_id: ax25_frame.payload.ax25_info.beacon_payload.obc_telem_packet_id
    :field obc_temp_raw: ax25_frame.payload.ax25_info.beacon_payload.obc_temp_raw
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
    :field q_ib_i_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_i_raw
    :field q_ib_j_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_j_raw
    :field q_ib_k_raw: ax25_frame.payload.ax25_info.beacon_payload.q_ib_k_raw
    :field angular_rate_x_raw: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_x_raw
    :field angular_rate_y_raw: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_y_raw
    :field angular_rate_z_raw: ax25_frame.payload.ax25_info.beacon_payload.angular_rate_z_raw
    :field science_pld_info: ax25_frame.payload.ax25_info.beacon_payload.science_pld_info
    :field bat1_voltage: ax25_frame.payload.ax25_info.beacon_payload.bat1_voltage
    :field bat1_i_charge: ax25_frame.payload.ax25_info.beacon_payload.bat1_i_charge
    :field bat1_temp: ax25_frame.payload.ax25_info.beacon_payload.bat1_temp
    :field bat2_voltage: ax25_frame.payload.ax25_info.beacon_payload.bat2_voltage
    :field bat2_i_charge: ax25_frame.payload.ax25_info.beacon_payload.bat2_i_charge
    :field bat2_temp: ax25_frame.payload.ax25_info.beacon_payload.bat2_temp
    :field pnl_i_bat_ym: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_ym
    :field pnl_i_bat_xm: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_xm
    :field pnl_i_bat_yp: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_yp
    :field pnl_i_bat_xp: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_xp
    :field pnl_i_bat_z: ax25_frame.payload.ax25_info.beacon_payload.pnl_i_bat_z
    :field pnl_temp_ym: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_ym
    :field pnl_temp_xm: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_xm
    :field pnl_temp_yp: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_yp
    :field pnl_temp_xp: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_xp
    :field pnl_temp_z: ax25_frame.payload.ax25_info.beacon_payload.pnl_temp_z
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
    :field bat1_int_temp_raw: ax25_frame.payload.ax25_info.beacon_payload.bat1_int_temp_raw
    :field bat1_rc: ax25_frame.payload.ax25_info.beacon_payload.bat1_rc
    :field bat1_imax: ax25_frame.payload.ax25_info.beacon_payload.bat1_imax
    :field bat1_pow_avg: ax25_frame.payload.ax25_info.beacon_payload.bat1_pow_avg
    :field bat1_fac: ax25_frame.payload.ax25_info.beacon_payload.bat1_fac
    :field bat1_cyc: ax25_frame.payload.ax25_info.beacon_payload.bat1_cyc
    :field bat1_soh: ax25_frame.payload.ax25_info.beacon_payload.bat1_soh
    :field bat1_tte: ax25_frame.payload.ax25_info.beacon_payload.bat1_tte
    :field bat1_stat_flags: ax25_frame.payload.ax25_info.beacon_payload.bat1_stat_flags
    :field bat1_pc: ax25_frame.payload.ax25_info.beacon_payload.bat1_pc
    :field bat2_int_temp_raw: ax25_frame.payload.ax25_info.beacon_payload.bat2_int_temp_raw
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
    """
    def __init__(self, _io, _parent=None, _root=None):
        self._io = _io
        self._parent = _parent
        self._root = _root if _root else self
        self._read()

    def _read(self):
        self.ax25_frame = Somp2b.Ax25Frame(self._io, self, self._root)

    class Ax25Frame(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.ax25_header = Somp2b.Ax25Header(self._io, self, self._root)
            _on = (self.ax25_header.ctl & 19)
            if _on == 0:
                self.payload = Somp2b.IFrame(self._io, self, self._root)
            elif _on == 3:
                self.payload = Somp2b.UiFrame(self._io, self, self._root)
            elif _on == 19:
                self.payload = Somp2b.UiFrame(self._io, self, self._root)
            elif _on == 16:
                self.payload = Somp2b.IFrame(self._io, self, self._root)
            elif _on == 18:
                self.payload = Somp2b.IFrame(self._io, self, self._root)
            elif _on == 2:
                self.payload = Somp2b.IFrame(self._io, self, self._root)


    class Ax25Header(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.dest_callsign_raw = Somp2b.CallsignRaw(self._io, self, self._root)
            self.dest_ssid_raw = Somp2b.SsidMask(self._io, self, self._root)
            self.src_callsign_raw = Somp2b.CallsignRaw(self._io, self, self._root)
            self.src_ssid_raw = Somp2b.SsidMask(self._io, self, self._root)
            self.ctl = self._io.read_u1()


    class UiFrame(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.pid = self._io.read_u1()
            self._raw_ax25_info = self._io.read_bytes_full()
            _io__raw_ax25_info = KaitaiStream(BytesIO(self._raw_ax25_info))
            self.ax25_info = Somp2b.Beacon(_io__raw_ax25_info, self, self._root)


    class Bitmap16SubsystemStatus(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.beacon_payload_subsystem_status_bitmap = self._io.read_u2le()


    class Callsign(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.callsign = (self._io.read_bytes(6)).decode(u"utf-8")


    class BeaconLegacy(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.ant_1 = self._io.read_u1()
            self.ant_2 = self._io.read_u1()
            self.bat1_voltage = self._io.read_u2le()
            self.bat1_i_charge = self._io.read_s2le()
            self.bat1_temp_raw = self._io.read_s2le()
            self.bat1_int_temp_raw = self._io.read_s2le()
            self.bat1_rc = self._io.read_u2le()
            self.bat1_soc = self._io.read_u2le()
            self.bat1_imax = self._io.read_s2le()
            self.bat1_pow_avg = self._io.read_s2le()
            self.bat1_fac = self._io.read_u2le()
            self.bat1_cyc = self._io.read_u2le()
            self.bat1_soh = self._io.read_u2le()
            self.bat1_tte = self._io.read_u2le()
            self.bat1_stat_flags = self._io.read_u2le()
            self.bat1_pc = self._io.read_s2le()
            self.bat2_voltage = self._io.read_u2le()
            self.bat2_i_charge = self._io.read_s2le()
            self.bat2_temp_raw = self._io.read_s2le()
            self.bat2_int_temp_raw = self._io.read_s2le()
            self.bat2_rc = self._io.read_u2le()
            self.bat2_soc = self._io.read_u2le()
            self.bat2_imax = self._io.read_s2le()
            self.bat2_pow_avg = self._io.read_s2le()
            self.bat2_fac = self._io.read_u2le()
            self.bat2_cyc = self._io.read_u2le()
            self.bat2_soh = self._io.read_u2le()
            self.bat2_tte = self._io.read_u2le()
            self.bat2_stat_flags = self._io.read_u2le()
            self.bat2_pc = self._io.read_s2le()
            self.cs_op_cnt = self._io.read_u2le()
            self.cs_temp = self._io.read_s2le()
            self.cs_time_1 = self._io.read_u1()
            self.cs_time_2 = self._io.read_u1()
            self.cs_time_3 = self._io.read_u1()
            self.rssi = self._io.read_u1()
            self.bytes_rx = self._io.read_u4le()
            self.bytes_tx = self._io.read_u4le()
            self.v3v3_bus_i_tot = self._io.read_s2le()
            self.v3v3_bus_i_c1 = self._io.read_s2le()
            self.v3v3_bus_i_c2 = self._io.read_s2le()
            self.v3v3_bus_voltage = self._io.read_s2le()
            self.v3v3_bus_v_c1 = self._io.read_s2le()
            self.v3v3_bus_v_c2 = self._io.read_s2le()
            self.obc_rst_cnt = self._io.read_u4le()
            self.obc_boot_utc = self._io.read_u4le()
            self.beacon_on_time = self._io.read_u4le()

        @property
        def bat2_int_temp(self):
            if hasattr(self, '_m_bat2_int_temp'):
                return self._m_bat2_int_temp if hasattr(self, '_m_bat2_int_temp') else None

            self._m_bat2_int_temp = (self.bat2_temp_raw / 10.0)
            return self._m_bat2_int_temp if hasattr(self, '_m_bat2_int_temp') else None

        @property
        def bat2_temp(self):
            if hasattr(self, '_m_bat2_temp'):
                return self._m_bat2_temp if hasattr(self, '_m_bat2_temp') else None

            self._m_bat2_temp = (self.bat2_temp_raw / 10.0)
            return self._m_bat2_temp if hasattr(self, '_m_bat2_temp') else None

        @property
        def bat1_temp(self):
            if hasattr(self, '_m_bat1_temp'):
                return self._m_bat1_temp if hasattr(self, '_m_bat1_temp') else None

            self._m_bat1_temp = (self.bat1_temp_raw / 10.0)
            return self._m_bat1_temp if hasattr(self, '_m_bat1_temp') else None

        @property
        def bat1_int_temp(self):
            if hasattr(self, '_m_bat1_int_temp'):
                return self._m_bat1_int_temp if hasattr(self, '_m_bat1_int_temp') else None

            self._m_bat1_int_temp = (self.bat1_int_temp_raw / 10.0)
            return self._m_bat1_int_temp if hasattr(self, '_m_bat1_int_temp') else None

        @property
        def beacon_utc(self):
            if hasattr(self, '_m_beacon_utc'):
                return self._m_beacon_utc if hasattr(self, '_m_beacon_utc') else None

            self._m_beacon_utc = (self.obc_boot_utc + self.beacon_on_time)
            return self._m_beacon_utc if hasattr(self, '_m_beacon_utc') else None


    class Beacon60s(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.beacon_utc = self._io.read_u4le()
            self.beacon_on_time = self._io.read_u4le()
            self.bat1_voltage_raw = self._io.read_bits_int_le(12)
            self.bat1_i_charge_raw = self._io.read_bits_int_le(12)
            self.bat1_temp_raw = self._io.read_bits_int_le(10)
            self.bat1_soc = self._io.read_bits_int_le(8)
            self.bat2_voltage_raw = self._io.read_bits_int_le(12)
            self.bat2_i_charge_raw = self._io.read_bits_int_le(12)
            self.bat2_temp_raw = self._io.read_bits_int_le(10)
            self.bat2_soc = self._io.read_bits_int_le(8)
            self.pnl_i_bat_ym_raw = self._io.read_bits_int_le(10)
            self.pnl_i_bat_xm_raw = self._io.read_bits_int_le(10)
            self.pnl_i_bat_yp_raw = self._io.read_bits_int_le(10)
            self.pnl_i_bat_xp_raw = self._io.read_bits_int_le(10)
            self.pnl_i_bat_z_raw = self._io.read_bits_int_le(10)
            self.pnl_temp_ym_raw = self._io.read_bits_int_le(10)
            self.pnl_temp_xm_raw = self._io.read_bits_int_le(10)
            self.pnl_temp_yp_raw = self._io.read_bits_int_le(10)
            self.pnl_temp_xp_raw = self._io.read_bits_int_le(10)
            self.pnl_temp_z_raw = self._io.read_bits_int_le(10)
            self.v3v3_bus_voltage_raw = self._io.read_bits_int_le(12)
            self.v3v3_bus_i_tot = self._io.read_bits_int_le(10)
            self.v3v3_bus_i_c1 = self._io.read_bits_int_le(10)
            self.v3v3_bus_i_c2 = self._io.read_bits_int_le(10)
            self.cs_temp_raw = self._io.read_bits_int_le(10)
            self.cs_status = self._io.read_bits_int_le(8)
            self.cs_beacon_time = self._io.read_bits_int_le(8)
            self.obc_rst_cnt = self._io.read_bits_int_le(16)
            self.obc_telem_packet_id = self._io.read_bits_int_le(16)
            self.obc_temp_raw = self._io.read_bits_int_le(10)
            self.obc_load = self._io.read_bits_int_le(8)
            self.obc_last_reboot_y = self._io.read_bits_int_le(8)
            self.obc_adcs_mode = self._io.read_bits_int_le(8)
            self.b_field_x_raw = self._io.read_bits_int_le(12)
            self.b_field_y_raw = self._io.read_bits_int_le(12)
            self.b_field_z_raw = self._io.read_bits_int_le(12)
            self.sun_vect_x_raw = self._io.read_bits_int_le(12)
            self.sun_vect_y_raw = self._io.read_bits_int_le(12)
            self.sun_vect_z_raw = self._io.read_bits_int_le(12)
            self.q_ib_w_raw = self._io.read_bits_int_le(16)
            self.q_ib_i_raw = self._io.read_bits_int_le(16)
            self.q_ib_j_raw = self._io.read_bits_int_le(16)
            self.q_ib_k_raw = self._io.read_bits_int_le(16)
            self.angular_rate_x_raw = self._io.read_bits_int_le(12)
            self.angular_rate_y_raw = self._io.read_bits_int_le(12)
            self.angular_rate_z_raw = self._io.read_bits_int_le(12)
            self.stuffingbits = self._io.read_bits_int_be(6)
            self.science_pld_info = self._io.read_bits_int_le(32)

        @property
        def q_ib_w(self):
            if hasattr(self, '_m_q_ib_w'):
                return self._m_q_ib_w if hasattr(self, '_m_q_ib_w') else None

            self._m_q_ib_w = ((self.q_ib_w_raw / 32767.0) - 1)
            return self._m_q_ib_w if hasattr(self, '_m_q_ib_w') else None

        @property
        def pnl_temp_xm(self):
            """currently not useful due to calculation error on board."""
            if hasattr(self, '_m_pnl_temp_xm'):
                return self._m_pnl_temp_xm if hasattr(self, '_m_pnl_temp_xm') else None

            self._m_pnl_temp_xm = ((self.pnl_temp_xm_raw / 0.7) - 400)
            return self._m_pnl_temp_xm if hasattr(self, '_m_pnl_temp_xm') else None

        @property
        def ant_2(self):
            if hasattr(self, '_m_ant_2'):
                return self._m_ant_2 if hasattr(self, '_m_ant_2') else None

            self._m_ant_2 = (self.cs_status & 2) // 2
            return self._m_ant_2 if hasattr(self, '_m_ant_2') else None

        @property
        def pnl_temp_yp(self):
            """currently not useful due to calculation error on board."""
            if hasattr(self, '_m_pnl_temp_yp'):
                return self._m_pnl_temp_yp if hasattr(self, '_m_pnl_temp_yp') else None

            self._m_pnl_temp_yp = ((self.pnl_temp_yp_raw / 0.7) - 400)
            return self._m_pnl_temp_yp if hasattr(self, '_m_pnl_temp_yp') else None

        @property
        def b_field_x(self):
            if hasattr(self, '_m_b_field_x'):
                return self._m_b_field_x if hasattr(self, '_m_b_field_x') else None

            self._m_b_field_x = ((self.b_field_x_raw / 2.0) - 1023)
            return self._m_b_field_x if hasattr(self, '_m_b_field_x') else None

        @property
        def angular_rate_z(self):
            if hasattr(self, '_m_angular_rate_z'):
                return self._m_angular_rate_z if hasattr(self, '_m_angular_rate_z') else None

            self._m_angular_rate_z = ((self.angular_rate_z_raw / 59.0) - 35)
            return self._m_angular_rate_z if hasattr(self, '_m_angular_rate_z') else None

        @property
        def cs_module(self):
            if hasattr(self, '_m_cs_module'):
                return self._m_cs_module if hasattr(self, '_m_cs_module') else None

            self._m_cs_module = (self.cs_status & 12) // 4
            return self._m_cs_module if hasattr(self, '_m_cs_module') else None

        @property
        def pnl_temp_z(self):
            """currently not useful due to calculation error on board."""
            if hasattr(self, '_m_pnl_temp_z'):
                return self._m_pnl_temp_z if hasattr(self, '_m_pnl_temp_z') else None

            self._m_pnl_temp_z = ((self.pnl_temp_z_raw / 0.7) - 400)
            return self._m_pnl_temp_z if hasattr(self, '_m_pnl_temp_z') else None

        @property
        def sun_vect_z(self):
            if hasattr(self, '_m_sun_vect_z'):
                return self._m_sun_vect_z if hasattr(self, '_m_sun_vect_z') else None

            self._m_sun_vect_z = ((self.sun_vect_z_raw / 2047.0) - 1)
            return self._m_sun_vect_z if hasattr(self, '_m_sun_vect_z') else None

        @property
        def bat2_temp(self):
            if hasattr(self, '_m_bat2_temp'):
                return self._m_bat2_temp if hasattr(self, '_m_bat2_temp') else None

            self._m_bat2_temp = (((self.bat2_temp_raw / 0.7) - 400) / 10)
            return self._m_bat2_temp if hasattr(self, '_m_bat2_temp') else None

        @property
        def bat2_voltage(self):
            if hasattr(self, '_m_bat2_voltage'):
                return self._m_bat2_voltage if hasattr(self, '_m_bat2_voltage') else None

            self._m_bat2_voltage = (self.bat2_voltage_raw // 2 + 2500)
            return self._m_bat2_voltage if hasattr(self, '_m_bat2_voltage') else None

        @property
        def sun_vect_y(self):
            if hasattr(self, '_m_sun_vect_y'):
                return self._m_sun_vect_y if hasattr(self, '_m_sun_vect_y') else None

            self._m_sun_vect_y = ((self.sun_vect_y_raw / 2047.0) - 1)
            return self._m_sun_vect_y if hasattr(self, '_m_sun_vect_y') else None

        @property
        def bat1_temp(self):
            if hasattr(self, '_m_bat1_temp'):
                return self._m_bat1_temp if hasattr(self, '_m_bat1_temp') else None

            self._m_bat1_temp = (((self.bat1_temp_raw / 0.7) - 400) / 10)
            return self._m_bat1_temp if hasattr(self, '_m_bat1_temp') else None

        @property
        def angular_rate_y(self):
            if hasattr(self, '_m_angular_rate_y'):
                return self._m_angular_rate_y if hasattr(self, '_m_angular_rate_y') else None

            self._m_angular_rate_y = ((self.angular_rate_y_raw / 59.0) - 35)
            return self._m_angular_rate_y if hasattr(self, '_m_angular_rate_y') else None

        @property
        def pnl_i_bat_ym(self):
            if hasattr(self, '_m_pnl_i_bat_ym'):
                return self._m_pnl_i_bat_ym if hasattr(self, '_m_pnl_i_bat_ym') else None

            self._m_pnl_i_bat_ym = (self.pnl_i_bat_ym_raw / 0.5)
            return self._m_pnl_i_bat_ym if hasattr(self, '_m_pnl_i_bat_ym') else None

        @property
        def b_field_y(self):
            if hasattr(self, '_m_b_field_y'):
                return self._m_b_field_y if hasattr(self, '_m_b_field_y') else None

            self._m_b_field_y = ((self.b_field_y_raw / 2.0) - 1023)
            return self._m_b_field_y if hasattr(self, '_m_b_field_y') else None

        @property
        def q_ib_k(self):
            if hasattr(self, '_m_q_ib_k'):
                return self._m_q_ib_k if hasattr(self, '_m_q_ib_k') else None

            self._m_q_ib_k = ((self.q_ib_k_raw / 32767.0) - 1)
            return self._m_q_ib_k if hasattr(self, '_m_q_ib_k') else None

        @property
        def angular_rate_x(self):
            if hasattr(self, '_m_angular_rate_x'):
                return self._m_angular_rate_x if hasattr(self, '_m_angular_rate_x') else None

            self._m_angular_rate_x = ((self.angular_rate_x_raw / 59.0) - 35)
            return self._m_angular_rate_x if hasattr(self, '_m_angular_rate_x') else None

        @property
        def q_ib_i(self):
            if hasattr(self, '_m_q_ib_i'):
                return self._m_q_ib_i if hasattr(self, '_m_q_ib_i') else None

            self._m_q_ib_i = ((self.q_ib_i_raw / 32767.0) - 1)
            return self._m_q_ib_i if hasattr(self, '_m_q_ib_i') else None

        @property
        def cs_temp(self):
            if hasattr(self, '_m_cs_temp'):
                return self._m_cs_temp if hasattr(self, '_m_cs_temp') else None

            self._m_cs_temp = ((self.cs_temp_raw / 0.7) - 400)
            return self._m_cs_temp if hasattr(self, '_m_cs_temp') else None

        @property
        def pnl_temp_ym(self):
            """currently not useful due to calculation error on board."""
            if hasattr(self, '_m_pnl_temp_ym'):
                return self._m_pnl_temp_ym if hasattr(self, '_m_pnl_temp_ym') else None

            self._m_pnl_temp_ym = ((self.pnl_temp_ym_raw / 0.7) - 400)
            return self._m_pnl_temp_ym if hasattr(self, '_m_pnl_temp_ym') else None

        @property
        def pnl_temp_xp(self):
            """currently not useful due to calculation error on board."""
            if hasattr(self, '_m_pnl_temp_xp'):
                return self._m_pnl_temp_xp if hasattr(self, '_m_pnl_temp_xp') else None

            self._m_pnl_temp_xp = ((self.pnl_temp_xp_raw / 0.7) - 400)
            return self._m_pnl_temp_xp if hasattr(self, '_m_pnl_temp_xp') else None

        @property
        def obc_temp(self):
            if hasattr(self, '_m_obc_temp'):
                return self._m_obc_temp if hasattr(self, '_m_obc_temp') else None

            self._m_obc_temp = (((self.obc_temp_raw / 0.7) - 400) / 10)
            return self._m_obc_temp if hasattr(self, '_m_obc_temp') else None

        @property
        def pnl_i_bat_yp(self):
            if hasattr(self, '_m_pnl_i_bat_yp'):
                return self._m_pnl_i_bat_yp if hasattr(self, '_m_pnl_i_bat_yp') else None

            self._m_pnl_i_bat_yp = (self.pnl_i_bat_yp_raw / 0.5)
            return self._m_pnl_i_bat_yp if hasattr(self, '_m_pnl_i_bat_yp') else None

        @property
        def ant_1(self):
            if hasattr(self, '_m_ant_1'):
                return self._m_ant_1 if hasattr(self, '_m_ant_1') else None

            self._m_ant_1 = (self.cs_status & 1)
            return self._m_ant_1 if hasattr(self, '_m_ant_1') else None

        @property
        def eclipsed(self):
            if hasattr(self, '_m_eclipsed'):
                return self._m_eclipsed if hasattr(self, '_m_eclipsed') else None

            self._m_eclipsed = (self.obc_adcs_mode & 1)
            return self._m_eclipsed if hasattr(self, '_m_eclipsed') else None

        @property
        def pnl_i_bat_z(self):
            if hasattr(self, '_m_pnl_i_bat_z'):
                return self._m_pnl_i_bat_z if hasattr(self, '_m_pnl_i_bat_z') else None

            self._m_pnl_i_bat_z = (self.pnl_i_bat_z_raw / 0.5)
            return self._m_pnl_i_bat_z if hasattr(self, '_m_pnl_i_bat_z') else None

        @property
        def v3v3_bus_voltage(self):
            if hasattr(self, '_m_v3v3_bus_voltage'):
                return self._m_v3v3_bus_voltage if hasattr(self, '_m_v3v3_bus_voltage') else None

            self._m_v3v3_bus_voltage = (self.v3v3_bus_voltage_raw + 2789)
            return self._m_v3v3_bus_voltage if hasattr(self, '_m_v3v3_bus_voltage') else None

        @property
        def adcs_mode(self):
            if hasattr(self, '_m_adcs_mode'):
                return self._m_adcs_mode if hasattr(self, '_m_adcs_mode') else None

            self._m_adcs_mode = (self.obc_adcs_mode & 14) // 2
            return self._m_adcs_mode if hasattr(self, '_m_adcs_mode') else None

        @property
        def pnl_i_bat_xp(self):
            if hasattr(self, '_m_pnl_i_bat_xp'):
                return self._m_pnl_i_bat_xp if hasattr(self, '_m_pnl_i_bat_xp') else None

            self._m_pnl_i_bat_xp = (self.pnl_i_bat_xp_raw / 0.5)
            return self._m_pnl_i_bat_xp if hasattr(self, '_m_pnl_i_bat_xp') else None

        @property
        def q_ib_j(self):
            if hasattr(self, '_m_q_ib_j'):
                return self._m_q_ib_j if hasattr(self, '_m_q_ib_j') else None

            self._m_q_ib_j = ((self.q_ib_j_raw / 32767.0) - 1)
            return self._m_q_ib_j if hasattr(self, '_m_q_ib_j') else None

        @property
        def obc_mode(self):
            if hasattr(self, '_m_obc_mode'):
                return self._m_obc_mode if hasattr(self, '_m_obc_mode') else None

            self._m_obc_mode = (self.obc_adcs_mode & 240) // 16
            return self._m_obc_mode if hasattr(self, '_m_obc_mode') else None

        @property
        def bat1_i_charge(self):
            if hasattr(self, '_m_bat1_i_charge'):
                return self._m_bat1_i_charge if hasattr(self, '_m_bat1_i_charge') else None

            self._m_bat1_i_charge = ((self.bat1_i_charge_raw / 0.5) - 4094)
            return self._m_bat1_i_charge if hasattr(self, '_m_bat1_i_charge') else None

        @property
        def bat2_i_charge(self):
            if hasattr(self, '_m_bat2_i_charge'):
                return self._m_bat2_i_charge if hasattr(self, '_m_bat2_i_charge') else None

            self._m_bat2_i_charge = ((self.bat2_i_charge_raw / 0.5) - 4094)
            return self._m_bat2_i_charge if hasattr(self, '_m_bat2_i_charge') else None

        @property
        def sun_vect_x(self):
            if hasattr(self, '_m_sun_vect_x'):
                return self._m_sun_vect_x if hasattr(self, '_m_sun_vect_x') else None

            self._m_sun_vect_x = ((self.sun_vect_x_raw / 2047.0) - 1)
            return self._m_sun_vect_x if hasattr(self, '_m_sun_vect_x') else None

        @property
        def b_field_z(self):
            if hasattr(self, '_m_b_field_z'):
                return self._m_b_field_z if hasattr(self, '_m_b_field_z') else None

            self._m_b_field_z = ((self.b_field_z_raw / 2.0) - 1023)
            return self._m_b_field_z if hasattr(self, '_m_b_field_z') else None

        @property
        def pnl_i_bat_xm(self):
            if hasattr(self, '_m_pnl_i_bat_xm'):
                return self._m_pnl_i_bat_xm if hasattr(self, '_m_pnl_i_bat_xm') else None

            self._m_pnl_i_bat_xm = (self.pnl_i_bat_xm_raw / 0.5)
            return self._m_pnl_i_bat_xm if hasattr(self, '_m_pnl_i_bat_xm') else None

        @property
        def bat1_voltage(self):
            if hasattr(self, '_m_bat1_voltage'):
                return self._m_bat1_voltage if hasattr(self, '_m_bat1_voltage') else None

            self._m_bat1_voltage = (self.bat1_voltage_raw // 2 + 2500)
            return self._m_bat1_voltage if hasattr(self, '_m_bat1_voltage') else None


    class IFrame(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.pid = self._io.read_u1()
            self.ax25_info = self._io.read_bytes_full()


    class SsidMask(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.ssid_mask = self._io.read_u1()

        @property
        def ssid(self):
            if hasattr(self, '_m_ssid'):
                return self._m_ssid if hasattr(self, '_m_ssid') else None

            self._m_ssid = ((self.ssid_mask & 15) >> 1)
            return self._m_ssid if hasattr(self, '_m_ssid') else None


    class Beacon(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            _on = self.is_valid_source
            if _on == True:
                self.beacon_header = Somp2b.BeaconHeader(self._io, self, self._root)
            if self.is_valid_payload:
                _on = self.beacon_header.beacon_header_flags2
                if _on == 48:
                    self.beacon_payload = Somp2b.Beacon60s(self._io, self, self._root)
                elif _on == 49:
                    self.beacon_payload = Somp2b.BeaconLegacy(self._io, self, self._root)


        @property
        def is_valid_source(self):
            """This is work in progress as it never returns `true` without the
            `(1 == 1)` statement. It DOES NOT check the source for now!
            """
            if hasattr(self, '_m_is_valid_source'):
                return self._m_is_valid_source if hasattr(self, '_m_is_valid_source') else None

            self._m_is_valid_source =  ((1 == 1) or (self._root.ax25_frame.ax25_header.src_callsign_raw.callsign_ror.callsign == u"DP0TUD")) 
            return self._m_is_valid_source if hasattr(self, '_m_is_valid_source') else None

        @property
        def is_valid_payload(self):
            if hasattr(self, '_m_is_valid_payload'):
                return self._m_is_valid_payload if hasattr(self, '_m_is_valid_payload') else None

            self._m_is_valid_payload =  (( ((self.beacon_header.beacon_header_flags1 == 84) and (self.beacon_header.beacon_header_flags2 == 48)) ) or ( ((self.beacon_header.beacon_header_flags1 == 84) and (self.beacon_header.beacon_header_flags2 == 49)) )) 
            return self._m_is_valid_payload if hasattr(self, '_m_is_valid_payload') else None


    class BeaconHeader(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self.beacon_header_flags1 = self._io.read_u1()
            self.beacon_header_flags2 = self._io.read_u1()


    class CallsignRaw(KaitaiStruct):
        def __init__(self, _io, _parent=None, _root=None):
            self._io = _io
            self._parent = _parent
            self._root = _root if _root else self
            self._read()

        def _read(self):
            self._raw__raw_callsign_ror = self._io.read_bytes(6)
            self._raw_callsign_ror = KaitaiStream.process_rotate_left(self._raw__raw_callsign_ror, 8 - (1), 1)
            _io__raw_callsign_ror = KaitaiStream(BytesIO(self._raw_callsign_ror))
            self.callsign_ror = Somp2b.Callsign(_io__raw_callsign_ror, self, self._root)



