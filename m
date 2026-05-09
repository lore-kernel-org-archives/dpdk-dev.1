Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795ACD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 18:00:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7EB740431;
	Sat,  9 May 2026 20:00:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DF83240151
 for <dev@dpdk.org>; Sat,  9 May 2026 20:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778349611; x=1809885611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uq1TGF/oDFqho2ITSASCY82QvZYntkjgf3rVmvfkAvo=;
 b=Eir+L0V1as+Vi3NGoeqwpoNP0NL+A38iw+ZrHYK6fVOITSqKM2gvnjDg
 8ZbazzSWq0C2M0zvwIx5Pe9g+PCtnBixCVWxVjmrHi/oT7LxelY/sXtbC
 darx6CqoinHLnC/RXrxVrPDhZ/6C0Jm6vHCNFmJRtH66isu5E95hU22at
 uFT+Jy0zkP2jy0duEvHTHW+TW+GD8dFJG3oOuNhHLD09OW9iL3a0k2Vqp
 kppst1VZudX8J5eKQ7v86foQVsITKjBsn3fh7oCAU3Dub9YfSOUD2z+Hm
 c0c6th885FQ/n41rBHzCGSSYg/KIBL+ZSPW2aq/PdG6He/m6J1QaBXwxS Q==;
X-CSE-ConnectionGUID: LcHp0PpNR1ONcqui75l0Ag==
X-CSE-MsgGUID: whNhrcgYTvuU9GsA8znhQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96865018"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="96865018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 11:00:10 -0700
X-CSE-ConnectionGUID: amrKN2z7Qu+dBUViC4Imnw==
X-CSE-MsgGUID: PNpFBTE4SpS34+/wCphqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="267426413"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa002.jf.intel.com with ESMTP; 09 May 2026 11:00:08 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v8 1/4] lib/net: add IEEE 1588 PTP v2 protocol header
 definitions
Date: Sun, 10 May 2026 04:55:48 +0530
Message-ID: <20260509232551.2844201-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509232551.2844201-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add PTP (Precision Time Protocol) header structures and inline helper
functions to lib/net following DPDK conventions for protocol libraries
(similar to rte_tcp.h, rte_ip.h).

Provides wire-format structures with endian-annotated types:
  - rte_ptp_port_id: 10-byte port identity with EUI-64 clock ID
  - rte_ptp_hdr: 34-byte common message header with nibble bitfields
    for msg_type/transportSpecific and version/minorVersion
  - rte_ptp_timestamp: 10-byte nanosecond-precision timestamp

PTP message type constants for all IEEE 1588-2019 message types
(Sync, Delay_Req, Announce, Management, etc.) and flag field bits
(two-step, unicast, leap indicator).

Inline utility functions:
  - rte_ptp_is_event(), rte_ptp_is_two_step()
  - rte_ptp_add_correction(), rte_ptp_timestamp_to_ns()

Supports all PTP encapsulations: L2 (EtherType 0x88F7), VLAN/QinQ,
UDP/IPv4, and UDP/IPv6 (ports 319/320).

All inline functions — zero function call overhead, suitable for
real-time packet processing.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 MAINTAINERS         |   6 ++
 lib/net/meson.build |   1 +
 lib/net/rte_ptp.h   | 205 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 lib/net/rte_ptp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..516960a189 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,6 +1665,12 @@ F: doc/guides/prog_guide/ipsec_lib.rst
 M: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
 F: app/test-sad/
 
+PTP (IEEE 1588 Precision Time Protocol)
+M: Rajesh Kumar <rajesh3.kumar@intel.com>
+F: lib/net/rte_ptp.h
+F: examples/ptp_tap_relay_sw/
+F: doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
+
 PDCP - EXPERIMENTAL
 M: Anoob Joseph <anoobj@marvell.com>
 M: Volodymyr Fialko <vfialko@marvell.com>
diff --git a/lib/net/meson.build b/lib/net/meson.build
index 3fad5edc5b..63d13719f3 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -28,6 +28,7 @@ headers = files(
         'rte_geneve.h',
         'rte_l2tpv2.h',
         'rte_ppp.h',
+        'rte_ptp.h',
         'rte_ib.h',
 )
 
diff --git a/lib/net/rte_ptp.h b/lib/net/rte_ptp.h
new file mode 100644
index 0000000000..29cab5c2e4
--- /dev/null
+++ b/lib/net/rte_ptp.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _RTE_PTP_H_
+#define _RTE_PTP_H_
+
+/**
+ * @file
+ *
+ * PTP (IEEE 1588) protocol definitions
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * PTP Constants
+ */
+
+/** PTP over UDP event port (Sync, Delay_Req, PDelay_Req, PDelay_Resp). */
+#define RTE_IPPORT_PTP_EVENT        319
+
+/** PTP over UDP general port (Follow_Up, Delay_Resp, Announce, etc.). */
+#define RTE_IPPORT_PTP_GENERAL      320
+
+/** PTP multicast MAC address: 01:1B:19:00:00:00. */
+#define RTE_ETHER_ADDR_PTP_MULTICAST     { 0x01, 0x1B, 0x19, 0x00, 0x00, 0x00 }
+
+/** PTP peer delay multicast MAC: 01:80:C2:00:00:0E. */
+#define RTE_ETHER_ADDR_PTP_MULTICAST_PDELAY { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x0E }
+
+/*
+ * PTP Message Types (IEEE 1588-2019 Table 36)
+ */
+
+#define RTE_PTP_MSGTYPE_SYNC            0x0  /**< Sync (event). */
+#define RTE_PTP_MSGTYPE_DELAY_REQ       0x1  /**< Delay_Req (event). */
+#define RTE_PTP_MSGTYPE_PDELAY_REQ      0x2  /**< Peer_Delay_Req (event). */
+#define RTE_PTP_MSGTYPE_PDELAY_RESP     0x3  /**< Peer_Delay_Resp (event). */
+#define RTE_PTP_MSGTYPE_FU              0x8  /**< Follow_Up (general). */
+#define RTE_PTP_MSGTYPE_DELAY_RESP      0x9  /**< Delay_Resp (general). */
+#define RTE_PTP_MSGTYPE_PDELAY_RESP_FU  0xA  /**< Peer_Delay_Resp_Follow_Up (general). */
+#define RTE_PTP_MSGTYPE_ANNOUNCE        0xB  /**< Announce (general). */
+#define RTE_PTP_MSGTYPE_SIGNALING       0xC  /**< Signaling (general). */
+#define RTE_PTP_MSGTYPE_MANAGEMENT      0xD  /**< Management (general). */
+
+/*
+ * PTP Flag Field Bits (IEEE 1588-2019 Table 37)
+ *
+ * These constants are for use after rte_be_to_cpu_16(hdr->flags).
+ * flagField[0] (octet 6) maps to host bits 8-15.
+ * flagField[1] (octet 7) maps to host bits 0-7.
+ */
+
+#define RTE_PTP_FLAG_TWO_STEP    (UINT16_C(1) << 9)   /**< Two-step flag. */
+#define RTE_PTP_FLAG_UNICAST     (UINT16_C(1) << 10)  /**< Unicast flag. */
+#define RTE_PTP_FLAG_LI_61       (UINT16_C(1) << 0)   /**< Leap indicator 61. */
+#define RTE_PTP_FLAG_LI_59       (UINT16_C(1) << 1)   /**< Leap indicator 59. */
+
+/*
+ * PTP Header Structures (IEEE 1588-2019)
+ */
+
+/**
+ * PTP Port Identity (10 bytes).
+ */
+struct __rte_packed_begin rte_ptp_port_id {
+	uint8_t    clock_id[8]; /**< clockIdentity (EUI-64). */
+	rte_be16_t port_number; /**< portNumber. */
+} __rte_packed_end;
+
+/**
+ * PTP Common Message Header (34 bytes).
+ */
+struct __rte_packed_begin rte_ptp_hdr {
+	__extension__
+	union {
+		uint8_t ts_msgtype;     /**< transportSpecific | messageType. */
+		struct {
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+			uint8_t msg_type:4; /**< messageType. */
+			uint8_t ts:4;       /**< transportSpecific. */
+#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+			uint8_t ts:4;       /**< transportSpecific. */
+			uint8_t msg_type:4; /**< messageType. */
+#endif
+		};
+	};
+	__extension__
+	union {
+		uint8_t ver;            /**< minorVersionPTP | versionPTP. */
+		struct {
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+			uint8_t version:4;       /**< versionPTP. */
+			uint8_t minor_version:4; /**< minorVersionPTP. */
+#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+			uint8_t minor_version:4; /**< minorVersionPTP. */
+			uint8_t version:4;       /**< versionPTP. */
+#endif
+		};
+	};
+	rte_be16_t msg_length;     /**< Total message length in bytes. */
+	uint8_t    domain_number;  /**< PTP domain (0-255). */
+	uint8_t    minor_sdo_id;   /**< minorSdoId (IEEE 1588-2019). */
+	rte_be16_t flags;          /**< Flag field (see RTE_PTP_FLAG_*). */
+	rte_be64_t correction;     /**< correctionField (scaled ns, 48.16 fixed). */
+	rte_be32_t msg_type_specific; /**< messageTypeSpecific. */
+	struct rte_ptp_port_id source_port_id; /**< sourcePortIdentity. */
+	rte_be16_t sequence_id;    /**< sequenceId. */
+	uint8_t    control;        /**< controlField (deprecated in 1588-2019). */
+	int8_t     log_msg_interval; /**< logMessageInterval. */
+} __rte_packed_end;
+
+/**
+ * PTP Timestamp (10 bytes, used in Sync/Delay_Req/Follow_Up bodies).
+ * Seconds since PTP epoch (1 January 1970 00:00:00 TAI).
+ */
+struct __rte_packed_begin rte_ptp_timestamp {
+	rte_be16_t seconds_hi;   /**< Upper 16 bits of seconds. */
+	rte_be32_t seconds_lo;   /**< Lower 32 bits of seconds. */
+	rte_be32_t nanoseconds;  /**< Nanoseconds (0-999999999). */
+} __rte_packed_end;
+
+/*
+ * Inline Helpers
+ */
+
+/**
+ * Check if PTP message type is an event message.
+ * Event messages (msg_type 0x0-0x3) require timestamps.
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   true if event message, false otherwise.
+ */
+static inline bool
+rte_ptp_is_event(const struct rte_ptp_hdr *hdr)
+{
+	return hdr->msg_type <= RTE_PTP_MSGTYPE_PDELAY_RESP;
+}
+
+/**
+ * Check if the two-step flag is set in a PTP header.
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   true if two-step flag is set.
+ */
+static inline bool
+rte_ptp_is_two_step(const struct rte_ptp_hdr *hdr)
+{
+	return (hdr->flags & RTE_BE16(RTE_PTP_FLAG_TWO_STEP)) != 0;
+}
+
+/**
+ * Add a residence time (in nanoseconds) to the correctionField.
+ * Used by Transparent Clocks to account for relay transit delay.
+ * The correctionField uses IEEE 1588 scaled nanoseconds (48.16 fixed-point).
+ *
+ * @param hdr
+ *   Pointer to PTP header (will be modified in-place).
+ * @param residence_ns
+ *   Residence time in nanoseconds to add.
+ */
+static inline void
+rte_ptp_add_correction(struct rte_ptp_hdr *hdr, uint64_t residence_ns)
+{
+	uint64_t cf = rte_be_to_cpu_64(hdr->correction);
+
+	cf += residence_ns << 16;
+	hdr->correction = rte_cpu_to_be_64(cf);
+}
+
+/**
+ * Convert a PTP timestamp structure to nanoseconds since epoch.
+ *
+ * @param ts
+ *   Pointer to PTP timestamp.
+ * @return
+ *   Time in nanoseconds since PTP epoch.
+ */
+static inline uint64_t
+rte_ptp_timestamp_to_ns(const struct rte_ptp_timestamp *ts)
+{
+	uint64_t sec = ((uint64_t)rte_be_to_cpu_16(ts->seconds_hi) << 32) |
+		       rte_be_to_cpu_32(ts->seconds_lo);
+
+	return sec * UINT64_C(1000000000) + rte_be_to_cpu_32(ts->nanoseconds);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_PTP_H_ */
-- 
2.53.0

