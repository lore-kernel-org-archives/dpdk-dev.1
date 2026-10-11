Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EECA9EC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 07:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E6B4060B;
	Sun, 11 Oct 2026 09:41:46 +0200 (CEST)
Received: from osiris.dvbcontrol.com (osiris.rtss.eu [62.84.245.17])
 by mails.dpdk.org (Postfix) with ESMTP id 39114400D7
 for <dev@dpdk.org>; Sun, 11 Oct 2026 06:52:44 +0200 (CEST)
Received: from 77-164-175-181.fixed.kpn.net ([77.164.175.181]
 helo=[192.168.20.155])
 by osiris.dvbcontrol.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <rob@dvbcontrol.com>)
 id 1xFlYB-000000005vP-32KZ; Sun, 11 Oct 2026 06:52:43 +0200
Date: Sun, 11 Oct 2026 06:52:37 +0200
Message-ID: <787e4b6c39fcb1322bc92f8bca1153d31006a3ac.1791550671.git.rob@dvbcontrol.com>
From: Rob Peters <rob@dvbcontrol.com>
Subject: [PATCH] net/ice: add chip temperature to xstats
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Authenticated-Id: rob@dvbcontrol.com
X-Mailman-Approved-At: Sun, 11 Oct 2026 09:41:40 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The E810 firmware reports the internal chip temperature, together with
its warning, critical and fatal thresholds, through the admin queue
command "Get Sensor Reading" (0x0632). The base code already provides
ice_aq_get_sensor_reading() and parses the sensor capability into
hw->dev_caps.supported_sensors, but the PMD never calls it, so an
application that drives the port through vfio-pci cannot see the chip
temperature. The Linux kernel ice driver exposes the same reading
through hwmon.

Add four extended statistics, in whole degrees Celsius, when the
firmware announces the internal temperature sensor:
chip_temperature_celsius, chip_temperature_warning_celsius,
chip_temperature_critical_celsius and chip_temperature_fatal_celsius.

The command is sent only from the xstats_get callback, never in the
data path, and the result is kept for one second so that frequent
polling does not load the firmware. If the command fails, the values
are 0 and the error is logged at debug level. Firmware without the
sensor capability does not report these statistics.

Unlike the kernel driver, which registers the sensor on PF 0 only, every
PF reports it, since a DPDK application may own only some ports of a
device.

Signed-off-by: Rob Peters <rob@dvbcontrol.com>
---

Notes:
    Tested with dpdk-testpmd "show port xstats" on an E810-XXV (firmware
    4.30 0x8001af27 1.3429.0, DDP 1.3.43.0): 69-70 C, thresholds 95/105/115.
    Earlier the same day, on the same card, the kernel ice hwmon and the same
    admin queue command sent from a DPDK application both read 78 C.
    
    Not tested: firmware without the sensor capability, E830.
    
    No PMD reports a temperature in xstats yet, so the names follow the
    ethdev naming scheme with the unit last. I am happy to rename them if
    another convention is preferred.
    
    The patch is based on dpdk-next-net-intel; on main only the release
    notes context differs.

 .mailmap                               |  1 +
 doc/guides/nics/ice.rst                | 22 +++++++
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/intel/ice/ice_ethdev.c     | 87 ++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h     | 10 +++
 5 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index b9137b5046..49c42078f0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1427,6 +1427,7 @@ Ricky Li <ricky.li@intel.com>
 Riley Fletcher <rileyf@linux.ibm.com>
 Rita Ruvinsky <rita.ruvinsky@weka.io>
 Rob Miller <rob.miller@broadcom.com>
+Rob Peters <rob@dvbcontrol.com>
 Rob Scheepens <rob.scheepens@nutanix.com>
 Robert Konklewski <robertx.konklewski@intel.com>
 Robert Malz <robertx.malz@intel.com>
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index ba598742c5..d362f9ba49 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -1021,6 +1021,28 @@ To start ``testpmd``, and add vlan 10 to port 0:
 Diagnostic Utilities
 --------------------
 
+Chip Temperature
+~~~~~~~~~~~~~~~~
+
+When the firmware supports the internal temperature sensor,
+the extended statistics of each port include the chip temperature
+and the warning, critical and fatal thresholds set by the firmware,
+in whole degrees Celsius:
+
+* ``chip_temperature_celsius``
+* ``chip_temperature_warning_celsius``
+* ``chip_temperature_critical_celsius``
+* ``chip_temperature_fatal_celsius``
+
+The sensor is read with a firmware command at most once per second;
+in between, the last reading is reported.
+If the reading fails, all four values are 0.
+Firmware without the sensor support does not report these statistics.
+
+Usage::
+
+    testpmd> show port xstats <port_id>
+
 Dump DDP Package
 ~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 3fb7eac25d..c93b5bb960 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -86,6 +86,7 @@ New Features
 
 * **Updated Intel ice driver.**
 
+  * Added chip temperature to the extended statistics.
   * Added Tx context descriptor support to the AVX2 and AVX512 vector Tx paths,
     enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
   * Added support for getting and setting link (802.3x) flow control.
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 11b549a452..695c3bb2d7 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -397,6 +397,18 @@ static const struct ice_xstats_name_off ice_mbuf_strings[] = {
 
 #define ICE_NB_MBUF_XSTATS (sizeof(ice_mbuf_strings) / sizeof(ice_mbuf_strings[0]))
 
+static const struct ice_xstats_name_off ice_temp_strings[] = {
+	{"chip_temperature_celsius", offsetof(struct ice_temp_stats, temp)},
+	{"chip_temperature_warning_celsius",
+		offsetof(struct ice_temp_stats, warning)},
+	{"chip_temperature_critical_celsius",
+		offsetof(struct ice_temp_stats, critical)},
+	{"chip_temperature_fatal_celsius",
+		offsetof(struct ice_temp_stats, fatal)},
+};
+
+#define ICE_NB_TEMP_XSTATS RTE_DIM(ice_temp_strings)
+
 static const struct ice_xstats_name_off ice_hw_port_strings[] = {
 	{"tx_link_down_dropped", offsetof(struct ice_hw_port_stats,
 		tx_dropped_link_down)},
@@ -7265,12 +7277,56 @@ ice_stats_reset(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static bool
+ice_temp_sensor_supported(struct ice_hw *hw)
+{
+	return (hw->dev_caps.supported_sensors &
+		ICE_SENSOR_SUPPORT_E810_INT_TEMP) != 0;
+}
+
+/*
+ * Read the internal temperature sensor with the admin queue command
+ * "Get Sensor Reading". The result is kept for one second so that frequent
+ * xstats polling does not load the firmware. On failure all values are 0.
+ */
+static void
+ice_update_temp_stats(struct ice_pf *pf, struct ice_hw *hw)
+{
+	struct ice_aqc_get_sensor_reading_resp resp;
+	struct ice_temp_stats *ts = &pf->temp_stats;
+	uint64_t now = rte_get_timer_cycles();
+	int ret;
+
+	if (pf->temp_read_tsc != 0 &&
+	    now - pf->temp_read_tsc < rte_get_timer_hz())
+		return;
+	pf->temp_read_tsc = now;
+
+	memset(&resp, 0, sizeof(resp));
+	ret = ice_aq_get_sensor_reading(hw, ICE_AQC_INT_TEMP_SENSOR,
+					ICE_AQC_INT_TEMP_FORMAT, &resp, NULL);
+	if (ret != 0) {
+		PMD_DRV_LOG(DEBUG, "Failed to read chip temperature: %d", ret);
+		memset(ts, 0, sizeof(*ts));
+		return;
+	}
+
+	/* the reading is signed, report below zero as 0 */
+	ts->temp = resp.data.s0f0.temp > 0 ? (uint64_t)resp.data.s0f0.temp : 0;
+	ts->warning = resp.data.s0f0.temp_warning_threshold;
+	ts->critical = resp.data.s0f0.temp_critical_threshold;
+	ts->fatal = resp.data.s0f0.temp_fatal_threshold;
+}
+
 static uint32_t
-ice_xstats_calc_num(void)
+ice_xstats_calc_num(struct rte_eth_dev *dev)
 {
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t num;
 
 	num = ICE_NB_ETH_XSTATS + ICE_NB_MBUF_XSTATS + ICE_NB_HW_PORT_XSTATS;
+	if (ice_temp_sensor_supported(hw))
+		num += ICE_NB_TEMP_XSTATS;
 
 	return num;
 }
@@ -7301,7 +7357,7 @@ ice_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 	unsigned int count;
 	struct ice_hw_port_stats *hw_stats = &pf->stats;
 
-	count = ice_xstats_calc_num();
+	count = ice_xstats_calc_num(dev);
 	if (n < count)
 		return count;
 
@@ -7341,18 +7397,31 @@ ice_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 		count++;
 	}
 
+	/* Get chip temperature from ice_temp_stats struct */
+	if (ice_temp_sensor_supported(hw)) {
+		ice_update_temp_stats(pf, hw);
+		for (i = 0; i < ICE_NB_TEMP_XSTATS; i++) {
+			xstats[count].value =
+				*(uint64_t *)((char *)&pf->temp_stats +
+					      ice_temp_strings[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+	}
+
 	return count;
 }
 
-static int ice_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
+static int ice_xstats_get_names(struct rte_eth_dev *dev,
 				struct rte_eth_xstat_name *xstats_names,
 				__rte_unused unsigned int limit)
 {
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	unsigned int count = 0;
 	unsigned int i;
 
 	if (!xstats_names)
-		return ice_xstats_calc_num();
+		return ice_xstats_calc_num(dev);
 
 	/* Note: limit checked in rte_eth_xstats_names() */
 
@@ -7377,6 +7446,16 @@ static int ice_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
 		count++;
 	}
 
+	/* Get chip temperature from ice_temp_stats struct */
+	if (ice_temp_sensor_supported(hw)) {
+		for (i = 0; i < ICE_NB_TEMP_XSTATS; i++) {
+			strlcpy(xstats_names[count].name,
+				ice_temp_strings[i].name,
+				sizeof(xstats_names[count].name));
+			count++;
+		}
+	}
+
 	return count;
 }
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8d5e17e2df..503501ca80 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -547,6 +547,14 @@ struct ice_mbuf_stats {
 	uint64_t tx_pkt_errors;
 };
 
+/* Chip temperature and the firmware thresholds, in degrees Celsius */
+struct ice_temp_stats {
+	uint64_t temp;
+	uint64_t warning;
+	uint64_t critical;
+	uint64_t fatal;
+};
+
 
 /**
  * Used to store previous values of fields reported by ice_stats_get that can overflow
@@ -597,6 +605,8 @@ struct ice_pf {
 	struct ice_hw_port_stats stats_offset;
 	struct ice_hw_port_stats stats;
 	struct ice_mbuf_stats mbuf_stats;
+	struct ice_temp_stats temp_stats;
+	uint64_t temp_read_tsc; /* timer cycles of the last sensor read */
 	/* internal packet statistics, it should be excluded from the total */
 	struct ice_eth_stats internal_stats_offset;
 	struct ice_eth_stats internal_stats;

base-commit: 65fcbc568a1d32223209d787e189bad22c1962c3
-- 
2.53.0

