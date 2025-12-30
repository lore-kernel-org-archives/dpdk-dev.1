Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB4CE9412D
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 08:57:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1214402A0;
	Tue, 30 Dec 2025 09:57:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 73E9340267
 for <dev@dpdk.org>; Tue, 30 Dec 2025 09:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767085078; x=1798621078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uzunU+Jt82RZvinkgIpOEjTbLfk0ppR7Dc7cULoSHKk=;
 b=ewCPH0bJYeFfAVDtPviSXePJ+76fAw3me1F2Q48qpRvm9QipY7TnJvFJ
 wekq54Mj9Wgw1X9vQpFkGUd66lsseYlvek3DBvBJ4UZpsUK2bBDco+z+b
 1xsBx96fqJjh8HaXsOzPih+yEJXLbpE1ZV7w+cojuyl8qH6BjUiY4Eg+A
 p2HE+5Z8PNq1+9+9Kc9NP5FtHuAANZQhGKNuROWC0jOHF6MWO+Bx2CYd5
 7NPlA+rFnF2UJB8iFKajApZthvlZemrrv2Qp8JxErAulI9H8FHDJARRmp
 0rcUhui+9QDw7Qx1mI/qx8rOftrqf6eSeLMPqPg62H7ljO0I8IMpAdrd5 g==;
X-CSE-ConnectionGUID: 52pvNwfATlW5wAXaO/EFEg==
X-CSE-MsgGUID: aiP5/84MR6yTxlNPLEhFRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="80047133"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; d="scan'208";a="80047133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2025 00:57:56 -0800
X-CSE-ConnectionGUID: 5v3PIZa6SyaAg8A4qkplxQ==
X-CSE-MsgGUID: VPtWBp+vSZajGcAZhY19Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; d="scan'208";a="205649631"
Received: from unknown (HELO srv14.iind.intel.com) ([10.190.212.243])
 by fmviesa005.fm.intel.com with ESMTP; 30 Dec 2025 00:57:53 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	aman.deep.singh@intel.com,
	bruce.richardson@intel.com
Subject: [RFC PATCH v3] ethdev: update read time API in PMD to enable
 crosstimestamp
Date: Tue, 30 Dec 2025 08:57:19 +0000
Message-ID: <20251230085719.119058-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224073317.68784-1-soumyadeep.hore@intel.com>
References: <20251224073317.68784-1-soumyadeep.hore@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This RFC proposes adding PTP cross timestamping support in DPDK by
extending the existing PTP read_time API in ethdev. The goal is to
enable accurate correlation between NIC PTP hardware clocks (PHCs)
and the system clock without introducing a standalone, parallel API.

Motivation
----------
DPDK currently exposes PTP clock access via rte_eth_read_clock() and
related APIs, allowing applications to read the NIC PHC. However,
there is no mechanism to retrieve a system timestamp that is
sufficiently synchronized with the PHC read operation.

Many applications require a cross timestamp pair (PHC time + system
time) to:
- Convert hardware packet timestamps into system time
- Synchronize DPDK-based processing with non-DPDK applications
- Support telecom, TSN, and 5G time-sensitive workloads

Extending the read_time API allows reuse of existing PTP infrastructure
while preserving a single, consistent model for clock access.

Background
----------
PTP cross timestamping captures a PHC timestamp and a system clock
timestamp taken as close together as possible. Hardware may support
atomic cross timestamping, while software implementations rely on
serialized reads.

Linux exposes similar functionality via PHC cross timestamping
interfaces, which many applications already depend on.

Proposed Design
---------------
This RFC proposes extending the PTP read_time API to optionally return
a cross timestamp.

Key points:
1. Backward-compatible extension of the existing read_time API
2. Optional driver support depending on hardware capabilities
3. Capability discovery via ethdev

API Proposal
------------
Proposed updating timesync_read_time() API:

Proposed new API:

typedef int (*eth_timesync_read_time)(struct rte_eth_dev *dev,
                      struct timespec *timestamp, uint8_t flags);

Behavior:
- timestamp will now be an pointer to an array of timespec
- flags indicates cross timestamp is enabled or not

For backward compatibility:
- Existing rte_eth_read_clock() remains unchanged
- Drivers may implement either or both APIs

Capability Discovery
-------------------
Will  be enabled via traditional way of enabling PTP

Driver Implementation
---------------------
Drivers implementing timesync_read_time() API may:
- Use hardware-assisted cross timestamping if available
- Fall back to serialized software reads of PHC and system clock

Drivers that do not support cross timestamping may:
- Fill only device_time_ns
- Return 0 to indicate a successful PHC read

ABI / API Impact
----------------
This change introduces:
- A new flag
- A change in existing API
- A new device capability flag

No existing APIs or structures are modified, preserving ABI
compatibility.

Alternatives Considered
----------------------
A separate cross timestamp API was considered but rejected to avoid
duplication and to keep PTP clock access consolidated under read_time.

Another option was to extend rte_eth_read_clock() directly, but this
would break ABI and existing applications.

Performance and Risks
---------------------
The extended read_time API is expected to be called infrequently and
does not affect the packet data path.

Accuracy depends on hardware support. Software-based cross timestamping
may introduce jitter, which should be documented by drivers.

Future Work
-----------
- Exposing estimated error bounds in flags or an extended structure
- Alignment with Linux PHC cross timestamp semantics
- Support for multiple system clock domains (TAI, REALTIME)

Feedback Requested
------------------
Feedback is requested on:
- Whether extending read_time is preferred over a standalone API
- Structure and flag naming
- Expected semantics when system_time is unavailable

v3
---
- Addressed Stephen's comments
- Added new compiler flag
---
v2
---
- Fixed the comment typo in behaviour

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c |  9 +++++++--
 examples/ptpclient/ptpclient.c     | 23 +++++++++++++++++++++++
 lib/ethdev/ethdev_driver.h         |  2 +-
 lib/ethdev/rte_ethdev.c            |  6 +++++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c721d135f5..7db038801e 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -192,7 +192,7 @@ static int ice_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 static int ice_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta);
 static int ice_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm);
 static int ice_timesync_read_time(struct rte_eth_dev *dev,
-				  struct timespec *timestamp);
+				  struct timespec *timestamp, bool enable_crosstimestamp);
 static int ice_timesync_write_time(struct rte_eth_dev *dev,
 				   const struct timespec *timestamp);
 static int ice_timesync_disable(struct rte_eth_dev *dev);
@@ -7304,13 +7304,18 @@ ice_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 }
 
 static int
-ice_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
+ice_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts,
+				bool enable_crosstimestamp)
 {
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint8_t tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
 	uint32_t hi, lo, lo2;
 	uint64_t time;
 
+	if (enable_crosstimestamp)
+		PMD_DRV_LOG(WARNING,
+			"Cross timestamp is not supported in ice driver");
+
 	lo = ICE_READ_REG(hw, GLTSYN_TIME_L(tmr_idx));
 	hi = ICE_READ_REG(hw, GLTSYN_TIME_H(tmr_idx));
 	lo2 = ICE_READ_REG(hw, GLTSYN_TIME_L(tmr_idx));
diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index c344e7db1e..67985819fa 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -269,6 +269,10 @@ static void
 print_clock_info(struct ptpv2_time_receiver_ordinary *ptp_data)
 {
 	int64_t nsec;
+#ifdef RTE_LIBRTE_CROSSTIMESTAMP
+	struct timespec crosstimestamp[2];
+	struct timespec *timestamp = &crosstimestamp[0];
+#endif
 	struct timespec net_time, sys_time;
 
 	printf("time transmitter clock id: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
@@ -300,9 +304,17 @@ print_clock_info(struct ptpv2_time_receiver_ordinary *ptp_data)
 	printf("\nDelta between transmitter and receiver clocks:%"PRId64"ns\n",
 		ptp_data->delta);
 
+#ifdef RTE_LIBRTE_CROSSTIMESTAMP
+	/* Read cross timestamp from NIC */
+	rte_eth_timesync_read_time(ptp_data->current_ptp_port,
+				   timestamp);
+	net_time = crosstimestamp[0];
+	sys_time = crosstimestamp[1];
+#else
 	clock_gettime(CLOCK_REALTIME, &sys_time);
 	rte_eth_timesync_read_time(ptp_data->current_ptp_port,
 					&net_time);
+#endif
 
 	time_t ts = net_time.tv_sec;
 
@@ -501,10 +513,21 @@ static inline void
 update_kernel_time(void)
 {
 	int64_t nsec;
+#ifdef RTE_LIBRTE_CROSSTIMESTAMP
+	struct timespec crosstimestamp[2];
+	struct timespec *timestamp = &crosstimestamp[0];
+#endif
 	struct timespec net_time, sys_time;
 
+#ifdef RTE_LIBRTE_CROSSTIMESTAMP
+	/* Read cross timestamp from NIC */
+	rte_eth_timesync_read_time(ptp_data.current_ptp_port, timestamp);
+	net_time = crosstimestamp[0];
+	sys_time = crosstimestamp[1];
+#else
 	clock_gettime(CLOCK_REALTIME, &sys_time);
 	rte_eth_timesync_read_time(ptp_data.current_ptp_port, &net_time);
+#endif
 
 	nsec = (int64_t)timespec64_to_ns(&net_time) -
 	       (int64_t)timespec64_to_ns(&sys_time);
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 1255cd6f2c..67efd9b427 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -798,7 +798,7 @@ typedef int (*eth_timesync_adjust_freq)(struct rte_eth_dev *dev, int64_t);
 
 /** @internal Function used to get time from the device clock. */
 typedef int (*eth_timesync_read_time)(struct rte_eth_dev *dev,
-				      struct timespec *timestamp);
+				      struct timespec *timestamp, bool enable_crosstimestamp);
 
 /** @internal Function used to get time from the device clock. */
 typedef int (*eth_timesync_write_time)(struct rte_eth_dev *dev,
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..3167e1b1b9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6703,7 +6703,11 @@ rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 
 	if (dev->dev_ops->timesync_read_time == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, dev->dev_ops->timesync_read_time(dev, timestamp));
+#ifdef RTE_LIBRTE_CROSSTIMESTAMP
+	ret = eth_err(port_id, dev->dev_ops->timesync_read_time(dev, timestamp, true));
+#else	
+	ret = eth_err(port_id, dev->dev_ops->timesync_read_time(dev, timestamp, false));
+#endif
 
 	rte_eth_trace_timesync_read_time(port_id, timestamp, ret);
 
-- 
2.43.0

