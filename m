Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EDFF886D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 19:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D197740658;
	Mon, 27 Apr 2026 21:35:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9FD184065E
 for <dev@dpdk.org>; Mon, 27 Apr 2026 21:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777318536; x=1808854536;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4hpJ6g7OCEC/ZZupGF51pQVRPRD7tFxxB4iWWOZ/7/w=;
 b=YS3M+hH/TruqLyhNtNxGqE7EUsNpwAsCCob0/iAy0C0ilFlPWo0nl9a2
 JhAHSl0qHgFj2cw2aUB2U+0qbwJs/q4Q/u22eaUk4HE99d01jVuuImt50
 J8udkRN+5BAOSbbqqfU7jWx1HFySZb0V8m9aCZuzZnK4msG4BNbNzNqJX
 mlk2P7ur3//XVfrL/6HzeHaL6+hx1zK7309MhsV8REswq3H88y2MBOCKV
 5avvcU5ZqgxF2JN4TZliqTyGJNtK+bzTKMV+NLLIrtNRbYzZP+3qONXWI
 6MiS7Y4RjpQk8zwFRsXzUTen3wCiO+6iSSROEuUys6iRSSqujbj14o/h6 g==;
X-CSE-ConnectionGUID: J6B0SzX6TZqLCwP8MMdt9A==
X-CSE-MsgGUID: NgAS341iThWcmfsIBLUYOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="81826670"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="81826670"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 12:35:35 -0700
X-CSE-ConnectionGUID: xVuIvPF6RYuvdobovzzNgw==
X-CSE-MsgGUID: loWHux0FQuS5RIDBmkJL6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="227210661"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa009.fm.intel.com with ESMTP; 27 Apr 2026 12:35:33 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 rajesh3.kumar@intel.com
Subject: [RFC v1 2/4] doc: add PTP library programmer's guide
Date: Tue, 28 Apr 2026 06:31:04 +0530
Message-ID: <20260428010117.692626-3-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428010117.692626-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
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

Add programmer's guide for the PTP protocol library covering
message types, header structures, packet classification API,
inline helpers, and usage examples.

Add PTP header to Doxygen API index under layers section.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/api/doxy-api-index.md         |   1 +
 doc/api/doxy-api.conf.in          |   1 +
 doc/guides/prog_guide/index.rst   |   1 +
 doc/guides/prog_guide/ptp_lib.rst | 195 ++++++++++++++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 doc/guides/prog_guide/ptp_lib.rst

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..bbc79168bb 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -137,6 +137,7 @@ The public API headers are grouped by topics:
   [eCPRI](@ref rte_ecpri.h),
   [PDCP hdr](@ref rte_pdcp_hdr.h),
   [PDCP](@ref rte_pdcp.h),
+  [PTP](@ref rte_ptp.h),
   [L2TPv2](@ref rte_l2tpv2.h),
   [PPP](@ref rte_ppp.h),
   [IB](@ref rte_ib.h)
diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index bedd944681..f15d962733 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -72,6 +72,7 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/lib/pmu \
                           @TOPDIR@/lib/port \
                           @TOPDIR@/lib/power \
+                          @TOPDIR@/lib/ptp \
                           @TOPDIR@/lib/ptr_compress \
                           @TOPDIR@/lib/rawdev \
                           @TOPDIR@/lib/rcu \
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index e6f24945b0..60dad4475c 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -97,6 +97,7 @@ Protocol Processing Libraries
     :maxdepth: 1
     :numbered:
 
+    ptp_lib
     pdcp_lib
     ipsec_lib
 
diff --git a/doc/guides/prog_guide/ptp_lib.rst b/doc/guides/prog_guide/ptp_lib.rst
new file mode 100644
index 0000000000..46770f1bd7
--- /dev/null
+++ b/doc/guides/prog_guide/ptp_lib.rst
@@ -0,0 +1,195 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+PTP Protocol Library
+====================
+
+The DPDK PTP library provides IEEE 1588 / Precision Time Protocol (PTP)
+packet structures, constants, and helper functions for PTP packet processing.
+
+The library supports classification and header parsing of PTP messages
+across multiple transport encapsulations:
+
+- L2 PTP (EtherType 0x88F7)
+- VLAN-tagged L2 PTP (single and double/QinQ)
+- PTP over UDP/IPv4 (destination ports 319 and 320)
+- PTP over UDP/IPv6 (destination ports 319 and 320)
+
+The library conforms to
+`IEEE 1588-2019 <https://standards.ieee.org/ieee/1588/6825/>`_
+(Precision Time Protocol).
+
+Overview
+--------
+
+PTP is the foundation of time synchronization in networking.
+DPDK applications that relay, classify, or timestamp PTP packets
+currently duplicate header definitions and parsing logic.
+This library provides a shared, tested implementation.
+
+The library provides:
+
+#. Packed header structures matching the IEEE 1588-2019 wire format
+#. Constants for message types, flags, ports, and multicast addresses
+#. Inline helpers for common field extraction and manipulation
+#. Packet classification across L2, VLAN, UDP/IPv4, and UDP/IPv6 transports
+#. Correction field manipulation for Transparent Clock residence time
+
+PTP Message Types
+-----------------
+
+IEEE 1588-2019 defines the following message types, all supported by the library:
+
+.. csv-table:: PTP Message Types
+   :header: "Type", "Name", "Category", "Macro"
+   :widths: 5, 20, 10, 30
+
+   "0x0", "Sync", "Event", "``RTE_PTP_MSGTYPE_SYNC``"
+   "0x1", "Delay_Req", "Event", "``RTE_PTP_MSGTYPE_DELAY_REQ``"
+   "0x2", "Peer_Delay_Req", "Event", "``RTE_PTP_MSGTYPE_PDELAY_REQ``"
+   "0x3", "Peer_Delay_Resp", "Event", "``RTE_PTP_MSGTYPE_PDELAY_RESP``"
+   "0x8", "Follow_Up", "General", "``RTE_PTP_MSGTYPE_FOLLOW_UP``"
+   "0x9", "Delay_Resp", "General", "``RTE_PTP_MSGTYPE_DELAY_RESP``"
+   "0xA", "PDelay_Resp_Follow_Up", "General", "``RTE_PTP_MSGTYPE_PDELAY_RESP_FU``"
+   "0xB", "Announce", "General", "``RTE_PTP_MSGTYPE_ANNOUNCE``"
+   "0xC", "Signaling", "General", "``RTE_PTP_MSGTYPE_SIGNALING``"
+   "0xD", "Management", "General", "``RTE_PTP_MSGTYPE_MANAGEMENT``"
+
+Event messages (types 0x0–0x3) require hardware timestamps for accurate
+time transfer.
+
+Header Structures
+-----------------
+
+The library defines the following packed structures that map directly to
+the IEEE 1588-2019 wire format:
+
+``struct rte_ptp_hdr``
+   Common PTP message header (34 bytes). All PTP messages begin with this header.
+   Contains message type, version, flags, correction field, source port identity,
+   sequence ID, and log message interval.
+
+``struct rte_ptp_timestamp``
+   PTP timestamp (10 bytes). Used in Sync, Delay_Req, and Follow_Up message bodies.
+   Contains seconds (48-bit) and nanoseconds (32-bit).
+
+``struct rte_ptp_port_id``
+   PTP port identity (10 bytes). Contains an EUI-64 clock identity and a
+   16-bit port number.
+
+Packet Classification API
+--------------------------
+
+``rte_ptp_classify()``
+~~~~~~~~~~~~~~~~~~~~~~
+
+Classify a packet and return the PTP message type.
+
+.. code-block:: C
+
+   int rte_ptp_classify(const struct rte_mbuf *m);
+
+Examines the mbuf to determine if it contains a PTP message.
+Returns the PTP message type (0x0–0xF) on success,
+or ``RTE_PTP_MSGTYPE_INVALID`` (-1) if the packet is not PTP.
+
+Supported encapsulations:
+
+- EtherType 0x88F7 (L2 PTP)
+- Single VLAN + EtherType 0x88F7
+- Double VLAN (QinQ) + EtherType 0x88F7
+- IPv4 + UDP destination port 319 or 320
+- IPv6 + UDP destination port 319 or 320
+
+``rte_ptp_hdr_get()``
+~~~~~~~~~~~~~~~~~~~~~
+
+Get a pointer to the PTP header inside a packet.
+
+.. code-block:: C
+
+   struct rte_ptp_hdr *rte_ptp_hdr_get(const struct rte_mbuf *m);
+
+Returns a pointer to the PTP header, or NULL if the packet is not PTP.
+Handles the same set of encapsulations as ``rte_ptp_classify()``.
+
+``rte_ptp_msg_type_str()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Convert a PTP message type to a human-readable string.
+
+.. code-block:: C
+
+   const char *rte_ptp_msg_type_str(int msg_type);
+
+Returns a string such as ``"Sync"``, ``"Delay_Req"``, ``"Follow_Up"``, etc.
+Returns ``"Not_PTP"`` for invalid message types.
+
+Inline Helpers
+--------------
+
+The following inline functions operate on ``struct rte_ptp_hdr`` and require
+no function call overhead:
+
+.. csv-table:: Inline Helper Functions
+   :header: "Function", "Returns", "Description"
+   :widths: 30, 15, 40
+
+   "``rte_ptp_msg_type()``", "``uint8_t``", "Extract message type (lower nibble)"
+   "``rte_ptp_transport_specific()``", "``uint8_t``", "Extract transport-specific field (upper nibble)"
+   "``rte_ptp_version()``", "``uint8_t``", "Extract PTP version number"
+   "``rte_ptp_seq_id()``", "``uint16_t``", "Get sequence ID in host byte order"
+   "``rte_ptp_domain()``", "``uint8_t``", "Get PTP domain number"
+   "``rte_ptp_is_event()``", "``bool``", "Check if message type is an event (0x0–0x3)"
+   "``rte_ptp_is_two_step()``", "``bool``", "Check if two-step flag is set"
+   "``rte_ptp_correction_ns()``", "``int64_t``", "Get correctionField in nanoseconds (from 48.16 fixed-point)"
+   "``rte_ptp_add_correction()``", "``void``", "Add residence time to correctionField (for Transparent Clocks)"
+   "``rte_ptp_timestamp_to_ns()``", "``uint64_t``", "Convert PTP timestamp struct to nanoseconds"
+
+Usage Example
+-------------
+
+Classifying and processing PTP packets:
+
+.. code-block:: C
+
+   #include <rte_ptp.h>
+
+   void process_packets(struct rte_mbuf **pkts, uint16_t nb_pkts)
+   {
+       for (uint16_t i = 0; i < nb_pkts; i++) {
+           int ptp_type = rte_ptp_classify(pkts[i]);
+           if (ptp_type == RTE_PTP_MSGTYPE_INVALID)
+               continue;
+
+           struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(pkts[i]);
+
+           printf("PTP %s seq=%u domain=%u\n",
+                  rte_ptp_msg_type_str(ptp_type),
+                  rte_ptp_seq_id(hdr),
+                  rte_ptp_domain(hdr));
+
+           if (rte_ptp_is_event((uint8_t)ptp_type)) {
+               /* Event message — needs hardware timestamp */
+           }
+       }
+   }
+
+Adding residence time for a Transparent Clock:
+
+.. code-block:: C
+
+   struct rte_ptp_hdr *hdr = rte_ptp_hdr_get(pkt);
+   if (hdr != NULL) {
+       int64_t residence_ns = egress_ts - ingress_ts;
+       rte_ptp_add_correction(hdr, residence_ns);
+   }
+
+Limitations
+-----------
+
+- IPv6 extension headers are not traversed. Only the base IPv6 header
+  with ``next_header == UDP`` is handled.
+- Multi-segment mbufs are not supported. PTP event messages are
+  typically less than 128 bytes and fit in a single segment.
+- PTP over MPLS or other tunneling protocols is not supported.
-- 
2.52.0

