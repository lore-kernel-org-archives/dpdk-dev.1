Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B1CD343B
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 08:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E92514065E;
	Thu,  7 May 2026 10:20:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id DC0E2402F1
 for <dev@dpdk.org>; Thu,  7 May 2026 10:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778142000; x=1809678000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0gIqbPxzsYAJ2TUGNy3+IzAlqQZ22cTiIabYW62Rkz8=;
 b=NdtSSxcJnxkLVyLdM8B5M+bDEvXkO10sLesPkWKLc6YKyBIwS6JaHENo
 oUIY9AvFL1vOC/Rfc3IXNEstqZcWqhOs6PU21m3spLYTB1QCqN1UgREPQ
 cCx9terVaJtq4i/uDvmzNYcURO2AyMNecubKUXB1mfstpTbnc36GEFzon
 I5FaBExokJGDq/8qMBsoPfvTNZoxhrQfssrRZoqHIxCreaub0Q5m+8k1A
 vIFGCKg3zI3wXOY80UEXhkg0gFGo+KB9BbwBxDwxu+bPYCbJ3AveMrPRU
 hTcT7cZpc0iyt/airYhQYDol42U2q10V4yvcFCaOwTsKfqdHWBLch2VGs g==;
X-CSE-ConnectionGUID: 6U3eYZoQRcCDYnv0R5qcmA==
X-CSE-MsgGUID: B90WUPxBSjuRKZa3HUS7sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79075743"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79075743"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:19:59 -0700
X-CSE-ConnectionGUID: hYaf/J/NQ8OzO/2OJzZ5Tw==
X-CSE-MsgGUID: kZvdTUPNS7u5xWwq4p2nOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="236313762"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa008.jf.intel.com with ESMTP; 07 May 2026 01:19:58 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v7 1/4] lib/net: add IEEE 1588 PTP v2 protocol header
 definitions
Date: Thu,  7 May 2026 19:15:26 +0530
Message-ID: <20260507134529.2573300-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507134529.2573300-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260507134529.2573300-1-rajesh3.kumar@intel.com>
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
  - rte_ptp_hdr: 34-byte common message header with correctionField
  - rte_ptp_timestamp: 10-byte nanosecond-precision timestamp

PTP message type constants for all IEEE 1588-2019 message types
(Sync, Delay_Req, Announce, Management, etc.) and flag field bits
(two-step, unicast, leap indicator).

Inline accessor and utility functions for performance:
  - rte_ptp_msg_type(), rte_ptp_version(), rte_ptp_domain()
  - rte_ptp_seq_id(), rte_ptp_is_event(), rte_ptp_is_two_step()
  - rte_ptp_correction_ns(), rte_ptp_add_correction()
  - rte_ptp_timestamp_to_ns() for timestamp conversion

Supports all PTP encapsulations: L2 (EtherType 0x88F7), VLAN/QinQ,
UDP/IPv4, and UDP/IPv6 (ports 319/320).

All inline functions — zero function call overhead, suitable for
real-time packet processing.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 MAINTAINERS         |   6 +
 lib/net/meson.build |   1 +
 lib/net/rte_ptp.h   | 264 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 lib/net/rte_ptp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..da31ada871 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,6 +1665,12 @@ F: doc/guides/prog_guide/ipsec_lib.rst
 M: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
 F: app/test-sad/
 
+PTP - lib/net
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
index 0000000000..649b944d29
--- /dev/null
+++ b/lib/net/rte_ptp.h
@@ -0,0 +1,264 @@
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
+#define RTE_PTP_EVENT_PORT        319
+
+/** PTP over UDP general port (Follow_Up, Delay_Resp, Announce, etc.). */
+#define RTE_PTP_GENERAL_PORT      320
+
+/** PTP multicast MAC address: 01:1B:19:00:00:00. */
+#define RTE_PTP_MULTICAST_MAC     { 0x01, 0x1B, 0x19, 0x00, 0x00, 0x00 }
+
+/** PTP peer delay multicast MAC: 01:80:C2:00:00:0E. */
+#define RTE_PTP_PDELAY_MULTICAST_MAC { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x0E }
+
+/*
+ * PTP Message Types (IEEE 1588-2019 Table 36)
+ */
+
+#define RTE_PTP_MSGTYPE_SYNC            0x0  /**< Sync (event). */
+#define RTE_PTP_MSGTYPE_DELAY_REQ       0x1  /**< Delay_Req (event). */
+#define RTE_PTP_MSGTYPE_PDELAY_REQ      0x2  /**< Peer_Delay_Req (event). */
+#define RTE_PTP_MSGTYPE_PDELAY_RESP     0x3  /**< Peer_Delay_Resp (event). */
+#define RTE_PTP_MSGTYPE_FOLLOW_UP       0x8  /**< Follow_Up (general). */
+#define RTE_PTP_MSGTYPE_DELAY_RESP      0x9  /**< Delay_Resp (general). */
+#define RTE_PTP_MSGTYPE_PDELAY_RESP_FU  0xA  /**< Peer_Delay_Resp_Follow_Up. */
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
+#define RTE_PTP_FLAG_TWO_STEP    (1 << 9)   /**< Two-step flag. */
+#define RTE_PTP_FLAG_UNICAST     (1 << 10)  /**< Unicast flag. */
+#define RTE_PTP_FLAG_LI_61       (1 << 0)   /**< Leap indicator 61. */
+#define RTE_PTP_FLAG_LI_59       (1 << 1)   /**< Leap indicator 59. */
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
+	uint8_t    msg_type;       /**< transportSpecific (4) | messageType (4). */
+	uint8_t    version;        /**< minorVersionPTP (4) | versionPTP (4). */
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
+ * Extract PTP message type from header.
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   Message type (0x0-0xF).
+ */
+static inline uint8_t
+rte_ptp_msg_type(const struct rte_ptp_hdr *hdr)
+{
+	return hdr->msg_type & 0x0F;
+}
+
+/**
+ * Extract transport-specific field from header.
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   Transport-specific value (upper nibble, 0x0-0xF).
+ */
+static inline uint8_t
+rte_ptp_transport_specific(const struct rte_ptp_hdr *hdr)
+{
+	return (hdr->msg_type >> 4) & 0x0F;
+}
+
+/**
+ * Extract PTP version from header.
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   PTP version number (typically 2).
+ */
+static inline uint8_t
+rte_ptp_version(const struct rte_ptp_hdr *hdr)
+{
+	return hdr->version & 0x0F;
+}
+
+/**
+ * Get sequence ID from PTP header (host byte order).
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   Sequence ID in host byte order.
+ */
+static inline uint16_t
+rte_ptp_seq_id(const struct rte_ptp_hdr *hdr)
+{
+	return rte_be_to_cpu_16(hdr->sequence_id);
+}
+
+/**
+ * Get PTP domain number.
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   Domain number (0-255).
+ */
+static inline uint8_t
+rte_ptp_domain(const struct rte_ptp_hdr *hdr)
+{
+	return hdr->domain_number;
+}
+
+/**
+ * Check if PTP message type is an event message.
+ * Event messages (msg_type 0x0-0x3) require timestamps.
+ *
+ * @param msg_type
+ *   PTP message type value (0x0-0xF).
+ * @return
+ *   true if event message, false otherwise.
+ */
+static inline bool
+rte_ptp_is_event(int msg_type)
+{
+	return msg_type >= 0 && msg_type <= RTE_PTP_MSGTYPE_PDELAY_RESP;
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
+	return (rte_be_to_cpu_16(hdr->flags) & RTE_PTP_FLAG_TWO_STEP) != 0;
+}
+
+/**
+ * Get correctionField value in nanoseconds (from 48.16 fixed-point).
+ *
+ * @param hdr
+ *   Pointer to PTP header.
+ * @return
+ *   Correction value in nanoseconds.
+ */
+static inline int64_t
+rte_ptp_correction_ns(const struct rte_ptp_hdr *hdr)
+{
+	return (int64_t)rte_be_to_cpu_64(hdr->correction) >> 16;
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
+rte_ptp_add_correction(struct rte_ptp_hdr *hdr, int64_t residence_ns)
+{
+	int64_t cf = (int64_t)rte_be_to_cpu_64(hdr->correction);
+
+	cf += (int64_t)((uint64_t)residence_ns << 16);
+	hdr->correction = rte_cpu_to_be_64(cf);
+}
+
+/**
+ * Convert a PTP timestamp structure to nanoseconds since epoch.
+ *
+ * @param ts
+ *   Pointer to PTP timestamp.
+ * @return
+ *   Time in nanoseconds since epoch.
+ */
+static inline uint64_t
+rte_ptp_timestamp_to_ns(const struct rte_ptp_timestamp *ts)
+{
+	uint64_t sec = ((uint64_t)rte_be_to_cpu_16(ts->seconds_hi) << 32) |
+		       rte_be_to_cpu_32(ts->seconds_lo);
+
+	return sec * 1000000000ULL + rte_be_to_cpu_32(ts->nanoseconds);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_PTP_H_ */
-- 
2.53.0

