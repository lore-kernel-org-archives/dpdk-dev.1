Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DCA606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BCv4w8am
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26FEA402CC;
	Mon, 23 Nov 2026 13:26:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id E207540262;
 Mon, 23 Nov 2026 13:26:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795436793; x=1826972793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WHOb2cBz6SUJkC+boU0C3XkzQstXzPMRxowXolddDfw=;
 b=BCv4w8amOQmtnlVZdG71RcmEotMlk1SqkSIT8+sUCdf8QoiU+WyDLYoX
 dsY7GjeFkycAdETxECAUhbxas2B8cbTxHtWBgUCiUvdT7IW6xSj+gCqBk
 nYio/iVKFGIZ+WY/yOrnnrhiGll3dOlorHIpGnIm/tkkUCqFjHPpzYv4+
 CnqmFCmKvzp9HmjScAxwr0kUx6DRNi1GgIdPAIhxEhU5nQexcZon4VAGq
 jzXgRCtH72pDaCWWC1gCyDph7HqURGiy80yK8sOtOqcG1lPitUfirlwI6
 YP0hnSbsl/EZgruPNVy+OjxPWNeRPOwX7nd2724r3SErOaoeclgbe//z6 A==;
X-CSE-ConnectionGUID: HOtJvb+kTMW9EfvUZBYWSA==
X-CSE-MsgGUID: UGG1tT8/SrCIsFevyeQvDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4292701"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4292701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:26:31 -0800
X-CSE-ConnectionGUID: emY8rSMnR720T7yxz6Y8cw==
X-CSE-MsgGUID: bpO1Ll1PTbi9lqiYsqn4EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11225128"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 23 Nov 2026 04:26:30 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] app/testpmd: use burst IO for IEEE1588 forwarding
Date: Mon, 23 Nov 2026 12:26:26 +0000
Message-ID: <20261123122626.2253504-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118151155.2740034-1-bruce.richardson@intel.com>
References: <20261118151155.2740034-1-bruce.richardson@intel.com>
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

The IEEE1588 forwarder in test-pmd read a single packet at a time rather
than using the burst size configuration parameter. This meant that it
cannot be used with vector driver paths which require a minimum burst
size for calling the Rx function.

Make the forwarding function respect the configured burst size and only
process packets one at a time, not Rx them one-at-a-time.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V2: align return value from ieee_packet_fwd() with other fwd fns.
---
 app/test-pmd/ieee1588fwd.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/app/test-pmd/ieee1588fwd.c b/app/test-pmd/ieee1588fwd.c
index afea7735c7..57c426e819 100644
--- a/app/test-pmd/ieee1588fwd.c
+++ b/app/test-pmd/ieee1588fwd.c
@@ -34,10 +34,10 @@ struct ptpv2_msg {
 /*
  * Forwarding of IEEE1588 Precise Time Protocol (PTP) packets.
  *
- * In this mode, packets are received one by one and are expected to be
- * PTP V2 L2 Ethernet frames (with the specific Ethernet type "0x88F7")
- * containing PTP "sync" messages (version 2 at offset 1, and message ID
- * 0 at offset 0).
+ * In this mode, packets are received in bursts and processed one by one.
+ * They are expected to be PTP V2 L2 Ethernet frames (with the specific
+ * Ethernet type "0x88F7") containing PTP "sync" messages (version 2 at
+ * offset 1, and message ID 0 at offset 0).
  *
  * Check that each received packet is a IEEE1588 PTP V2 packet of type
  * PTP_SYNC_MESSAGE, and that it has been identified and timestamped
@@ -90,21 +90,14 @@ port_ieee1588_tx_timestamp_check(portid_t pi)
 }
 
 static bool
-ieee1588_packet_fwd(struct fwd_stream *fs)
+ieee1588_process_packet(struct fwd_stream *fs, struct rte_mbuf *mb)
 {
-	struct rte_mbuf  *mb;
 	struct rte_ether_hdr *eth_hdr;
 	struct rte_ether_addr addr;
 	struct ptpv2_msg *ptp_hdr;
 	uint16_t eth_type;
 	uint32_t timesync_index;
 
-	/*
-	 * Receive 1 packet at a time.
-	 */
-	if (common_fwd_stream_receive(fs, &mb, 1) == 0)
-		return false;
-
 	/*
 	 * Check that the received packet is a PTP packet that was detected
 	 * by the hardware.
@@ -194,6 +187,18 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
 	return true;
 }
 
+static bool
+ieee1588_packet_fwd(struct fwd_stream *fs)
+{
+	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
+
+	const uint16_t nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
+	for (uint16_t i = 0; i < nb_rx; i++)
+		(void)ieee1588_process_packet(fs, pkts_burst[i]);
+
+	return nb_rx > 0;
+}
+
 static int
 port_ieee1588_fwd_begin(portid_t pi)
 {
-- 
2.55.0

