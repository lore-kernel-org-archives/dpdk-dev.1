Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F25EFF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 03:51:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C93040651;
	Mon,  4 May 2026 05:51:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2C2B84026C
 for <dev@dpdk.org>; Mon,  4 May 2026 05:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777866681; x=1809402681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9kndcDvjsQ4euBdDO/fe2nMm4RSoofbCTg90E+GZJXE=;
 b=ZE67MbTCCjHnnFj3uAXIpS3a1BYmqWAlYxQNmxbf8JFGAYnWyA8By7qa
 ZGxyHF0uB+U0eyNzNvFH5fmTTPPXK4WsKpcc2yaGQhhaVpfXQdm2qd9Ge
 /yTbxbhm8R/X5qpFrEAcXe0myW4VSZ8vCzAyCpksU94Op3av+alQasXO6
 zgU0N7i8xl4dDAt+NyeG6CcPycRrVAXNLGRv8cIH3oaqwy4e5nEHbOeXx
 gZx+DvkBtwUIQUYV/SW0xj2L0cBRbU01I4VF9LG572x/WOvIQL0D9a3gJ
 4sZzQAQy+8Qxi6MoZsojRVtaqxC5pTOfmd/N2SfFRiSyL44ZW3PWy5GTT g==;
X-CSE-ConnectionGUID: ekl2mUMlT2W5dAPi4Fzhtw==
X-CSE-MsgGUID: Plu5hkjCQfaPYoPyXbDBXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101389202"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="101389202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 20:51:20 -0700
X-CSE-ConnectionGUID: oMrgBvRzS8aee5igOevorA==
X-CSE-MsgGUID: UUx188ZgTM2ZO7C9duVp0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="235282219"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa008.jf.intel.com with ESMTP; 03 May 2026 20:51:17 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC v3 1/6] ptp: introduce PTP protocol library
Date: Mon,  4 May 2026 14:47:17 +0530
Message-ID: <20260504091728.1406661-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504091728.1406661-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260504091728.1406661-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
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

Add IEEE 1588-2019 Precision Time Protocol (PTP) processing library.

The library provides packet classification, header structures, and
helper functions for PTP packet processing in DPDK. This avoids
duplicate PTP header definitions across multiple applications and
drivers.

Supported transports:
1. L2 PTP (EtherType 0x88F7)
2. VLAN-tagged L2 PTP (single and QinQ)
3. PTP over UDP/IPv4 (ports 319/320)
4. PTP over UDP/IPv6 (ports 319/320)

Public APIs:
1. rte_ptp_classify()
2. rte_ptp_hdr_get()
3. rte_ptp_msg_type_str()

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 MAINTAINERS                            |   7 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 lib/meson.build                        |   1 +
 lib/ptp/meson.build                    |   6 +
 lib/ptp/rte_ptp.c                      | 185 ++++++++++++++
 lib/ptp/rte_ptp.h                      | 339 +++++++++++++++++++++++++
 6 files changed, 545 insertions(+)
 create mode 100644 lib/ptp/meson.build
 create mode 100644 lib/ptp/rte_ptp.c
 create mode 100644 lib/ptp/rte_ptp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..665e08dc90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,6 +1665,13 @@ F: doc/guides/prog_guide/ipsec_lib.rst
 M: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
 F: app/test-sad/
 
+PTP - EXPERIMENTAL
+M: Rajesh Kumar <rajesh3.kumar@intel.com>
+F: lib/ptp/
+F: doc/guides/prog_guide/ptp_lib.rst
+F: examples/ptp_tap_relay_sw/
+F: doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
+
 PDCP - EXPERIMENTAL
 M: Anoob Joseph <anoobj@marvell.com>
 M: Volodymyr Fialko <vfialko@marvell.com>
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..b2208d6fb3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,13 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added PTP protocol library.**
+
+  Added a new library ``rte_ptp`` for IEEE 1588 Precision Time Protocol
+  packet processing. The library provides packet classification, header
+  parsing, and correctionField manipulation across L2, VLAN-tagged,
+  UDP/IPv4, and UDP/IPv6 transports.
+
 
 Removed Items
 -------------
diff --git a/lib/meson.build b/lib/meson.build
index 8f5cfd28a5..78d694f951 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -50,6 +50,7 @@ libraries = [
         'member',
         'pcapng',
         'power',
+        'ptp',
         'rawdev',
         'regexdev',
         'mldev',
diff --git a/lib/ptp/meson.build b/lib/ptp/meson.build
new file mode 100644
index 0000000000..05f9d87cbe
--- /dev/null
+++ b/lib/ptp/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+sources = files('rte_ptp.c')
+headers = files('rte_ptp.h')
+deps += ['mbuf', 'net']
diff --git a/lib/ptp/rte_ptp.c b/lib/ptp/rte_ptp.c
new file mode 100644
index 0000000000..5e4fc666fb
--- /dev/null
+++ b/lib/ptp/rte_ptp.c
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ *
+ * IEEE 1588 / PTP Protocol Library — Implementation
+ */
+
+#include <eal_export.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+
+#include "rte_ptp.h"
+
+/*
+ * Internal: find PTP header offset within a packet.
+ * Returns pointer to PTP header or NULL.
+ */
+static struct rte_ptp_hdr *
+ptp_hdr_find(const struct rte_mbuf *m)
+{
+	const struct rte_ether_hdr *eth;
+	uint16_t ether_type;
+	uint32_t offset;
+
+	if (rte_pktmbuf_data_len(m) < sizeof(struct rte_ether_hdr))
+		return NULL;
+
+	eth = rte_pktmbuf_mtod(m, const struct rte_ether_hdr *);
+	ether_type = rte_be_to_cpu_16(eth->ether_type);
+	offset = sizeof(struct rte_ether_hdr);
+
+	/* Strip VLAN / QinQ tags to reach the inner EtherType */
+	if (ether_type == RTE_ETHER_TYPE_VLAN ||
+	    ether_type == RTE_ETHER_TYPE_QINQ) {
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_vlan_hdr))
+			return NULL;
+		const struct rte_vlan_hdr *vlan =
+			rte_pktmbuf_mtod_offset(m,
+				const struct rte_vlan_hdr *, offset);
+		ether_type = rte_be_to_cpu_16(vlan->eth_proto);
+		offset += sizeof(struct rte_vlan_hdr);
+
+		/* Second tag (QinQ inner or stacked VLAN) */
+		if (ether_type == RTE_ETHER_TYPE_VLAN ||
+		    ether_type == RTE_ETHER_TYPE_QINQ) {
+			if (rte_pktmbuf_data_len(m) <
+			    offset + sizeof(struct rte_vlan_hdr))
+				return NULL;
+			vlan = rte_pktmbuf_mtod_offset(m,
+				const struct rte_vlan_hdr *, offset);
+			ether_type = rte_be_to_cpu_16(vlan->eth_proto);
+			offset += sizeof(struct rte_vlan_hdr);
+		}
+	}
+
+	/* L2 PTP: EtherType 0x88F7 (plain, VLAN, or QinQ) */
+	if (ether_type == RTE_PTP_ETHERTYPE) {
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ptp_hdr))
+			return NULL;
+		return rte_pktmbuf_mtod_offset(m,
+			struct rte_ptp_hdr *, offset);
+	}
+
+	/* PTP over UDP/IPv4 (plain or VLAN-tagged) */
+	if (ether_type == RTE_ETHER_TYPE_IPV4) {
+		const struct rte_ipv4_hdr *iph;
+		uint16_t ihl;
+
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ipv4_hdr))
+			return NULL;
+
+		iph = rte_pktmbuf_mtod_offset(m,
+			const struct rte_ipv4_hdr *, offset);
+		if (iph->next_proto_id != IPPROTO_UDP)
+			return NULL;
+
+		ihl = (iph->version_ihl & 0x0F) * 4;
+		if (ihl < 20)
+			return NULL;
+		offset += ihl;
+
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_udp_hdr))
+			return NULL;
+
+		const struct rte_udp_hdr *udp =
+			rte_pktmbuf_mtod_offset(m,
+				const struct rte_udp_hdr *, offset);
+		uint16_t dst_port = rte_be_to_cpu_16(udp->dst_port);
+
+		if (dst_port != RTE_PTP_EVENT_PORT &&
+		    dst_port != RTE_PTP_GENERAL_PORT)
+			return NULL;
+
+		offset += sizeof(struct rte_udp_hdr);
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ptp_hdr))
+			return NULL;
+
+		return rte_pktmbuf_mtod_offset(m,
+			struct rte_ptp_hdr *, offset);
+	}
+
+	/* PTP over UDP/IPv6 (plain or VLAN-tagged) */
+	if (ether_type == RTE_ETHER_TYPE_IPV6) {
+		const struct rte_ipv6_hdr *ip6h;
+
+		if (rte_pktmbuf_data_len(m) <
+		    offset + sizeof(struct rte_ipv6_hdr))
+			return NULL;
+
+		ip6h = rte_pktmbuf_mtod_offset(m,
+			const struct rte_ipv6_hdr *, offset);
+		if (ip6h->proto != IPPROTO_UDP)
+			return NULL;
+
+		offset += sizeof(struct rte_ipv6_hdr);
+
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_udp_hdr))
+			return NULL;
+
+		const struct rte_udp_hdr *udp =
+			rte_pktmbuf_mtod_offset(m,
+				const struct rte_udp_hdr *, offset);
+		uint16_t dst_port = rte_be_to_cpu_16(udp->dst_port);
+
+		if (dst_port != RTE_PTP_EVENT_PORT &&
+		    dst_port != RTE_PTP_GENERAL_PORT)
+			return NULL;
+
+		offset += sizeof(struct rte_udp_hdr);
+		if (rte_pktmbuf_data_len(m) < offset + sizeof(struct rte_ptp_hdr))
+			return NULL;
+
+		return rte_pktmbuf_mtod_offset(m,
+			struct rte_ptp_hdr *, offset);
+	}
+
+	return NULL;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ptp_classify, 26.07)
+int
+rte_ptp_classify(const struct rte_mbuf *m)
+{
+	struct rte_ptp_hdr *hdr = ptp_hdr_find(m);
+
+	if (hdr == NULL)
+		return RTE_PTP_MSGTYPE_INVALID;
+
+	return rte_ptp_msg_type(hdr);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ptp_hdr_get, 26.07)
+struct rte_ptp_hdr *
+rte_ptp_hdr_get(struct rte_mbuf *m)
+{
+	return ptp_hdr_find(m);
+}
+
+static const char * const ptp_msg_names[] = {
+	[RTE_PTP_MSGTYPE_SYNC]           = "Sync",
+	[RTE_PTP_MSGTYPE_DELAY_REQ]      = "Delay_Req",
+	[RTE_PTP_MSGTYPE_PDELAY_REQ]     = "PDelay_Req",
+	[RTE_PTP_MSGTYPE_PDELAY_RESP]    = "PDelay_Resp",
+	[0x4]                            = "Reserved_4",
+	[0x5]                            = "Reserved_5",
+	[0x6]                            = "Reserved_6",
+	[0x7]                            = "Reserved_7",
+	[RTE_PTP_MSGTYPE_FOLLOW_UP]      = "Follow_Up",
+	[RTE_PTP_MSGTYPE_DELAY_RESP]     = "Delay_Resp",
+	[RTE_PTP_MSGTYPE_PDELAY_RESP_FU] = "PDelay_Resp_Follow_Up",
+	[RTE_PTP_MSGTYPE_ANNOUNCE]       = "Announce",
+	[RTE_PTP_MSGTYPE_SIGNALING]      = "Signaling",
+	[RTE_PTP_MSGTYPE_MANAGEMENT]     = "Management",
+	[0xE]                            = "Reserved_E",
+	[0xF]                            = "Reserved_F",
+};
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_ptp_msg_type_str, 26.07)
+const char *
+rte_ptp_msg_type_str(int msg_type)
+{
+	if (msg_type < 0 || msg_type > 0xF)
+		return "Not_PTP";
+	return ptp_msg_names[msg_type];
+}
diff --git a/lib/ptp/rte_ptp.h b/lib/ptp/rte_ptp.h
new file mode 100644
index 0000000000..b13dc54d43
--- /dev/null
+++ b/lib/ptp/rte_ptp.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ *
+ * IEEE 1588 / PTP Protocol Library
+ *
+ * Provides header structures, packet classification, and helper functions
+ * for Precision Time Protocol (IEEE 1588-2019) packet processing in DPDK.
+ *
+ * Supports:
+ *   - L2 PTP (EtherType 0x88F7)
+ *   - VLAN-tagged L2 PTP (single or double VLAN, TPIDs 0x8100/0x88A8)
+ *   - PTP over UDP/IPv4 (ports 319/320)
+ *   - PTP over UDP/IPv6 (ports 319/320)
+ *   - VLAN-tagged PTP over UDP/IPv4 or UDP/IPv6
+ *   - Two-step and one-step message identification
+ *   - correctionField manipulation (scaled nanoseconds, 48.16 fixed-point)
+ *
+ * Limitations:
+ *   - IPv6 extension headers are not traversed.
+ */
+
+#ifndef _RTE_PTP_H_
+#define _RTE_PTP_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <rte_byteorder.h>
+#include <rte_ether.h>
+#include <rte_mbuf.h>
+#include <rte_common.h>
+
+/**
+ * @file
+ * IEEE 1588 PTP protocol definitions and helpers.
+ */
+
+/* ============================================================
+ *  PTP Constants
+ * ============================================================
+ */
+
+/** PTP EtherType (IEEE 802.1AS / IEEE 1588) */
+#define RTE_PTP_ETHERTYPE         RTE_ETHER_TYPE_1588
+
+/** PTP over UDP event port (Sync, Delay_Req, PDelay_Req, PDelay_Resp) */
+#define RTE_PTP_EVENT_PORT        319
+
+/** PTP over UDP general port (Follow_Up, Delay_Resp, Announce, etc.) */
+#define RTE_PTP_GENERAL_PORT      320
+
+/** PTP multicast MAC address: 01:1B:19:00:00:00 */
+#define RTE_PTP_MULTICAST_MAC     { 0x01, 0x1B, 0x19, 0x00, 0x00, 0x00 }
+
+/** PTP peer delay multicast MAC: 01:80:C2:00:00:0E */
+#define RTE_PTP_PDELAY_MULTICAST_MAC { 0x01, 0x80, 0xC2, 0x00, 0x00, 0x0E }
+
+/* ============================================================
+ *  PTP Message Types (IEEE 1588-2019 Table 36)
+ * ============================================================
+ */
+
+#define RTE_PTP_MSGTYPE_SYNC            0x0  /**< Sync (event) */
+#define RTE_PTP_MSGTYPE_DELAY_REQ       0x1  /**< Delay_Req (event) */
+#define RTE_PTP_MSGTYPE_PDELAY_REQ      0x2  /**< Peer_Delay_Req (event) */
+#define RTE_PTP_MSGTYPE_PDELAY_RESP     0x3  /**< Peer_Delay_Resp (event) */
+#define RTE_PTP_MSGTYPE_FOLLOW_UP       0x8  /**< Follow_Up (general) */
+#define RTE_PTP_MSGTYPE_DELAY_RESP      0x9  /**< Delay_Resp (general) */
+#define RTE_PTP_MSGTYPE_PDELAY_RESP_FU  0xA  /**< Peer_Delay_Resp_Follow_Up */
+#define RTE_PTP_MSGTYPE_ANNOUNCE        0xB  /**< Announce (general) */
+#define RTE_PTP_MSGTYPE_SIGNALING       0xC  /**< Signaling (general) */
+#define RTE_PTP_MSGTYPE_MANAGEMENT      0xD  /**< Management (general) */
+
+/** Invalid / not a PTP packet */
+#define RTE_PTP_MSGTYPE_INVALID         (-1)
+
+/* ============================================================
+ *  PTP Flag Field Bits (IEEE 1588-2019 Table 37)
+ *
+ *  These constants are for use after rte_be_to_cpu_16(hdr->flags).
+ *  flagField[0] (octet 6) maps to host bits 8-15.
+ *  flagField[1] (octet 7) maps to host bits 0-7.
+ * ============================================================
+ */
+
+#define RTE_PTP_FLAG_TWO_STEP    (1 << 9)   /**< Two-step flag (flagField[0] bit 1) */
+#define RTE_PTP_FLAG_UNICAST     (1 << 10)  /**< Unicast flag (flagField[0] bit 2) */
+#define RTE_PTP_FLAG_LI_61       (1 << 0)   /**< Leap indicator 61 (flagField[1] bit 0) */
+#define RTE_PTP_FLAG_LI_59       (1 << 1)   /**< Leap indicator 59 (flagField[1] bit 1) */
+
+/* ============================================================
+ *  PTP Header Structures (IEEE 1588-2019)
+ * ============================================================
+ */
+
+/**
+ * PTP Port Identity (10 bytes).
+ */
+struct __rte_packed_begin rte_ptp_port_id {
+	uint8_t  clock_id[8];   /**< clockIdentity (EUI-64) */
+	uint16_t port_number;   /**< portNumber */
+} __rte_packed_end;
+
+/**
+ * PTP Common Message Header (34 bytes).
+ * All PTP messages begin with this header.
+ */
+struct __rte_packed_begin rte_ptp_hdr {
+	uint8_t  msg_type;       /**< transportSpecific (4) | messageType (4) */
+	uint8_t  version;        /**< minorVersionPTP (4) | versionPTP (4) */
+	uint16_t msg_length;     /**< Total message length in bytes */
+	uint8_t  domain_number;  /**< PTP domain (0-255) */
+	uint8_t  minor_sdo_id;   /**< minorSdoId (IEEE 1588-2019) */
+	uint16_t flags;          /**< Flag field (see RTE_PTP_FLAG_*) */
+	int64_t  correction;     /**< correctionField (scaled ns, 48.16 fixed) */
+	uint32_t msg_type_specific; /**< messageTypeSpecific */
+	struct rte_ptp_port_id source_port_id; /**< sourcePortIdentity */
+	uint16_t sequence_id;    /**< sequenceId */
+	uint8_t  control;        /**< controlField (deprecated in 1588-2019) */
+	int8_t   log_msg_interval; /**< logMessageInterval */
+} __rte_packed_end;
+
+/**
+ * PTP Timestamp (10 bytes, used in Sync/Delay_Req/Follow_Up bodies).
+ */
+struct __rte_packed_begin rte_ptp_timestamp {
+	uint16_t seconds_hi;     /**< Upper 16 bits of seconds */
+	uint32_t seconds_lo;     /**< Lower 32 bits of seconds */
+	uint32_t nanoseconds;    /**< Nanoseconds (0-999999999) */
+} __rte_packed_end;
+
+/* ============================================================
+ *  Inline Helpers
+ * ============================================================
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
+ * Event messages (msg_type 0x0-0x3) require hardware timestamps.
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
+	return sec * 1000000000ULL + rte_be_to_cpu_32(ts->nanoseconds);
+}
+
+/* ============================================================
+ *  Packet Classification Functions (implemented in rte_ptp.c)
+ * ============================================================
+ */
+
+/**
+ * Classify a packet as PTP and return the message type.
+ *
+ * Examines the mbuf to determine if it contains a PTP message.
+ * Supports L2 (EtherType 0x88F7), VLAN-tagged L2 (single/double,
+ * TPIDs 0x8100/0x88A8), PTP over UDP/IPv4, PTP over UDP/IPv6,
+ * and VLAN-tagged UDP/IPv4 or UDP/IPv6 (ports 319/320).
+ *
+ * @param m
+ *   Pointer to the mbuf to classify.
+ * @return
+ *   PTP message type (0x0-0xF) on success, RTE_PTP_MSGTYPE_INVALID (-1)
+ *   if the packet is not PTP.
+ */
+__rte_experimental
+int rte_ptp_classify(const struct rte_mbuf *m);
+
+/**
+ * Get a pointer to the PTP header inside an mbuf.
+ *
+ * Locates the PTP header within the packet, handling L2, VLAN-tagged L2
+ * (single/double, TPIDs 0x8100/0x88A8), PTP over UDP/IPv4,
+ * PTP over UDP/IPv6, and VLAN-tagged UDP variants.
+ *
+ * @param m
+ *   Pointer to the mbuf.
+ * @return
+ *   Pointer to the PTP header, or NULL if not a PTP packet.
+ */
+__rte_experimental
+struct rte_ptp_hdr *rte_ptp_hdr_get(struct rte_mbuf *m);
+
+/**
+ * Get a human-readable name for a PTP message type.
+ *
+ * @param msg_type
+ *   PTP message type (0x0-0xF or RTE_PTP_MSGTYPE_INVALID).
+ * @return
+ *   Static string with the message type name (e.g., "Sync", "Follow_Up").
+ */
+__rte_experimental
+const char *rte_ptp_msg_type_str(int msg_type);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_PTP_H_ */
-- 
2.53.0

