Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D13606A32C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gAKaeT05
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 963E840374;
	Thu, 19 Nov 2026 06:15:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 963F1402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 06:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795065298; x=1826601298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ApGDGEvIz9B3Q4HegRRDwJh7Igo8K+fOW01M+ram9fs=;
 b=gAKaeT05Q3NtHlUCoN/3IIB+tT8EHp/mghwD2K85yuzfWwEAXeoSyrcg
 gopa6Fa128ory33yos5sg2hE14yY9DKCMC1ncYkPzNs2OaW8EWHJKEwVV
 wPRpdm/gamJisiHovLCwU2UyMY7b3d7rj8AwsxeUBhjYIOAipNCXLXWVx
 pd11UNZ9DEBTFPb8pNjWLHHqJ9d19y2IWOnavwD8rJGUbF2+wTP0C+nkA
 R1tJMfRKpMCwU5G4TcHbWqY0Dst/LmMcVhXddBEdLEvOhzU8W/TfuWiZR
 ASRi80tBWZXaURP1F5AQz4nxBrWYioQVLz8uwzU9uWxkfDhIATHecA7yU Q==;
X-CSE-ConnectionGUID: ARAymLYvRlu/G73Dj0p9yA==
X-CSE-MsgGUID: Qx1PRkM0TAKCbnaCe5CDDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3929085"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3929085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 21:14:56 -0800
X-CSE-ConnectionGUID: BIh/N0WLQkCYMrbtO9FaYw==
X-CSE-MsgGUID: EEHp3SZtQ6e/jqhb2z6Tvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10328885"
Received: from gnrd03.iind.intel.com ([10.190.213.135])
 by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2026 21:14:53 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 2/2] examples/ptpclient: support vector Rx paths
Date: Thu, 19 Nov 2026 10:44:00 +0530
Message-ID: <20261119051418.2852033-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119051418.2852033-1-soumyadeep.hore@intel.com>
References: <20261119051418.2852033-1-soumyadeep.hore@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The application received one packet per rte_eth_rx_burst() call.
Vector Rx paths process descriptors in groups and return no packet
for such small bursts, so on a port using a vector Rx path with
timestamp offload (e.g. ice AVX2/AVX512) no PTP frame was received
and no T1-T4 timestamps were printed.

Receive packets in bursts of 32 instead.

With bursts, several PTP frames can be received in a single call,
and the per-queue value returned by
rte_eth_timesync_read_rx_timestamp() may then belong to a later
frame than the SYNC message. When the Rx timestamp offload is
enabled, take the SYNC receive time from the per-packet mbuf
timestamp field instead.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 doc/guides/sample_app_ug/ptpclient.rst |  7 +++-
 examples/ptpclient/ptpclient.c         | 52 +++++++++++++++++++-------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 8d802ac08b..83ebc154a7 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -154,8 +154,11 @@ The main work of the application is done within the loop:
     :end-before: >8 End of read packets from RX queues.
     :dedent: 2
 
-Packets are received one by one on the RX ports and, if required, PTP response
+Packets are received in bursts on the RX ports and, if required, PTP response
 packets are transmitted on the TX ports.
+When the Rx timestamp offload is available, the SYNC receive time is taken
+from the per-packet mbuf timestamp field, so that it stays correct when several
+PTP frames are received in the same burst.
 
 If the offload flags in the mbuf indicate that the packet is a PTP packet then
 the packet is parsed to determine which type:
@@ -164,7 +167,7 @@ the packet is parsed to determine which type:
     :language: c
     :start-after: Packet is parsed to determine which type. 8<
     :end-before: >8 End of packet is parsed to determine which type.
-    :dedent: 3
+    :dedent: 4
 
 
 All packets are freed explicitly using ``rte_pktmbuf_free()``.
diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 59ce892742..7eb687eb49 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -16,8 +16,10 @@
 #include <rte_cycles.h>
 #include <rte_lcore.h>
 #include <rte_mbuf.h>
+#include <rte_mbuf_dyn.h>
 #include <rte_ip.h>
 #include <rte_ptp.h>
+#include <rte_time.h>
 #include <limits.h>
 #include <sys/time.h>
 #include <getopt.h>
@@ -30,6 +32,7 @@ static volatile bool force_quit;
 
 #define NUM_MBUFS            8191
 #define MBUF_CACHE_SIZE       250
+#define BURST_SIZE             32
 
 #define NSEC_PER_SEC        1000000000L
 #define KERNEL_TIME_ADJUST_LIMIT  20000
@@ -39,6 +42,10 @@ uint32_t ptp_enabled_port_mask;
 uint8_t ptp_enabled_port_nb;
 static uint8_t ptp_enabled_ports[RTE_MAX_ETHPORTS];
 
+/* Rx timestamp mbuf dynamic field, valid when timestamp offload is enabled. */
+static int rx_tstamp_offset = -1;
+static uint64_t rx_tstamp_flag;
+
 static const struct rte_ether_addr ether_multicast = {
 	.addr_bytes = {0x01, 0x1b, 0x19, 0x0, 0x0, 0x0}
 };
@@ -155,8 +162,16 @@ port_init(uint16_t port, struct rte_mempool *mp)
 		return retval;
 	}
 
-	if (dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
+	if (dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		retval = rte_mbuf_dyn_rx_timestamp_register(&rx_tstamp_offset,
+				&rx_tstamp_flag);
+		if (retval != 0) {
+			printf("Cannot register Rx timestamp field: %s\n",
+				rte_strerror(rte_errno));
+			return retval;
+		}
+	}
 
 	if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
 		port_conf.txmode.offloads |=
@@ -330,9 +345,20 @@ parse_sync(struct ptpv2_time_receiver_ordinary *ptp, uint16_t rx_tstamp_idx)
 			ptp_hdr->source_port_id.clock_id,
 			8) == 0) {
 
-		if (ptp->ptpset == 1)
+		if (ptp->ptpset == 1) {
+			/* Always read: some NICs latch until the register is read. */
 			rte_eth_timesync_read_rx_timestamp(ptp->portid,
 					&ptp->tstamp2, rx_tstamp_idx);
+			/*
+			 * The per-packet timestamp stays correct when several PTP
+			 * frames arrive in one burst; the per-queue latch does not.
+			 */
+			if (rx_tstamp_offset >= 0 &&
+					(ptp->m->ol_flags & rx_tstamp_flag) != 0)
+				ptp->tstamp2 = rte_ns_to_timespec(
+					*RTE_MBUF_DYNFIELD(ptp->m, rx_tstamp_offset,
+						rte_mbuf_timestamp_t *));
+		}
 	}
 
 }
@@ -570,8 +596,8 @@ static void
 lcore_main(void)
 {
 	uint16_t portid;
-	unsigned nb_rx;
-	struct rte_mbuf *m;
+	uint16_t nb_rx, i;
+	struct rte_mbuf *bufs[BURST_SIZE];
 
 	printf("\nCore %u Waiting for SYNC packets. [Ctrl+C to quit]\n",
 			rte_lcore_id());
@@ -583,17 +609,17 @@ lcore_main(void)
 		for (portid = 0; portid < ptp_enabled_port_nb; portid++) {
 
 			portid = ptp_enabled_ports[portid];
-			nb_rx = rte_eth_rx_burst(portid, 0, &m, 1);
+			/* Vector Rx paths may return nothing for small bursts. */
+			nb_rx = rte_eth_rx_burst(portid, 0, bufs, BURST_SIZE);
 
-			if (likely(nb_rx == 0))
-				continue;
+			for (i = 0; i < nb_rx; i++) {
+				/* Packet is parsed to determine which type. 8< */
+				if (bufs[i]->ol_flags & RTE_MBUF_F_RX_IEEE1588_PTP)
+					parse_ptp_frames(portid, bufs[i]);
+				/* >8 End of packet is parsed to determine which type. */
 
-			/* Packet is parsed to determine which type. 8< */
-			if (m->ol_flags & RTE_MBUF_F_RX_IEEE1588_PTP)
-				parse_ptp_frames(portid, m);
-			/* >8 End of packet is parsed to determine which type. */
-
-			rte_pktmbuf_free(m);
+				rte_pktmbuf_free(bufs[i]);
+			}
 		}
 		/* >8 End of read packets from RX queues. */
 	}
-- 
2.43.0

