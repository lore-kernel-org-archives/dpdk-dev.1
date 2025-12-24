Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8150E7491C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 07:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 177F14029C;
	Wed, 24 Dec 2025 08:33:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7F1564025A
 for <dev@dpdk.org>; Wed, 24 Dec 2025 08:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766561632; x=1798097632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u6BjF2LV8S7igIg1SJ4JumG3w7r9AmVNIMfiL8sTtYk=;
 b=QhQQqx7tz4RxKYBzMSlTEfObCL9Q2nVsIt8N/0ID4+1W77rYPNaXOXaZ
 1z8dkG3YYo3FXKPYH+bIO4jhq3lUy3xFPVj6wk97hFNXLZ4tEVRCsUuwZ
 uc+7JkUNJ7RPTtt5+JLwUhsD+pepT8woO/sjgguIGqTj0d+LoonF4THfb
 S3vVAPZCDwZwSMt3OKjGZnPP7jiySR4cF27kOiqGY57vYEfhZuvuq8T/p
 koHsXOnwVP4HfTTqu+K2KUBUQKwTljuXy+rj1jkIAUSXTeaRTp+gYWVwO
 4GJzvQ5BSrV7drcbJTS1yXnuEpbyXsO8dAtOcyrqi/uwDWoO5n0PoxO/v Q==;
X-CSE-ConnectionGUID: /jPlitb3Tja86U2BLAjsNw==
X-CSE-MsgGUID: JT10FY9BSeyGf34giDAS7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79124430"
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; d="scan'208";a="79124430"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2025 23:33:51 -0800
X-CSE-ConnectionGUID: iIWXfEmDRMWwa/q2X8Ue8w==
X-CSE-MsgGUID: uCthB0+wSPyQoLdezXZInQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,173,1763452800"; d="scan'208";a="199941185"
Received: from unknown (HELO srv14.iind.intel.com) ([10.190.213.156])
 by orviesa007.jf.intel.com with ESMTP; 23 Dec 2025 23:33:45 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: thomas@monjalon.net, stephen@networkplumber.org,
 ajit.khaparde@broadcom.com, bruce.richardson@intel.com, jerinj@marvell.com,
 rasland@nvidia.com
Cc: dev@dpdk.org,
	aman.deep.singh@intel.com
Subject: [RFC PATCH v2] ethdev: update read time API in PMD to enable
 crosstimestamp
Date: Wed, 24 Dec 2025 07:33:17 +0000
Message-ID: <20251224073317.68784-1-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://patches.dpdk.org/project/dpdk/patch/20251224064010.66586-1-soumyadeep.hore@intel.com/>
References: <https://patches.dpdk.org/project/dpdk/patch/20251224064010.66586-1-soumyadeep.hore@intel.com/>
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

v2
---
- Fixed the comment typo in behaviour

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 9 +++++++--
 lib/ethdev/ethdev_driver.h         | 2 +-
 lib/ethdev/rte_ethdev.c            | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c721d135f5..1a0554eb6d 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -192,7 +192,7 @@ static int ice_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 static int ice_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta);
 static int ice_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm);
 static int ice_timesync_read_time(struct rte_eth_dev *dev,
-				  struct timespec *timestamp);
+				  struct timespec *timestamp, uint8_t is_cross_ts_en);
 static int ice_timesync_write_time(struct rte_eth_dev *dev,
 				   const struct timespec *timestamp);
 static int ice_timesync_disable(struct rte_eth_dev *dev);
@@ -7304,13 +7304,18 @@ ice_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 }
 
 static int
-ice_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
+ice_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts,
+				uint8_t is_cross_ts_en)
 {
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint8_t tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
 	uint32_t hi, lo, lo2;
 	uint64_t time;
 
+	if (is_cross_ts_en)
+		PMD_DRV_LOG(WARNING,
+			"Cross timestamp is not supported in ice driver");
+
 	lo = ICE_READ_REG(hw, GLTSYN_TIME_L(tmr_idx));
 	hi = ICE_READ_REG(hw, GLTSYN_TIME_H(tmr_idx));
 	lo2 = ICE_READ_REG(hw, GLTSYN_TIME_L(tmr_idx));
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 1255cd6f2c..000598b380 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -798,7 +798,7 @@ typedef int (*eth_timesync_adjust_freq)(struct rte_eth_dev *dev, int64_t);
 
 /** @internal Function used to get time from the device clock. */
 typedef int (*eth_timesync_read_time)(struct rte_eth_dev *dev,
-				      struct timespec *timestamp);
+				      struct timespec *timestamp, uint8_t is_cross_ts_en);
 
 /** @internal Function used to get time from the device clock. */
 typedef int (*eth_timesync_write_time)(struct rte_eth_dev *dev,
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..0a8542cd85 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6703,7 +6703,7 @@ rte_eth_timesync_read_time(uint16_t port_id, struct timespec *timestamp)
 
 	if (dev->dev_ops->timesync_read_time == NULL)
 		return -ENOTSUP;
-	ret = eth_err(port_id, dev->dev_ops->timesync_read_time(dev, timestamp));
+	ret = eth_err(port_id, dev->dev_ops->timesync_read_time(dev, timestamp, 0));
 
 	rte_eth_trace_timesync_read_time(port_id, timestamp, ret);
 
-- 
2.43.0

