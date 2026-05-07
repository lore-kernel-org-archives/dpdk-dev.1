Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD3CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 04:48:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99D984067B;
	Thu,  7 May 2026 06:47:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 937E54067D
 for <dev@dpdk.org>; Thu,  7 May 2026 06:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778129271; x=1809665271;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5gY7P3v7XYnlMyS5FHk+s96U6AtjQdP0zUfAOHIwoFc=;
 b=BDX+vYMZqKhtTFM9Zraf0elKT/AeuVHLBSeeVr/XY85BkAxssJcC5yjy
 7aM0IfzicK2HMg2TzJs1pJUdXZeqDmf80ktuMsUAoJlD5gyrI0OCf9rDl
 3P9toixVkZ5tbuKIIhd/yn/6RJmeI+X4/N2YYvb4W++2OzBCLsVdkaho8
 F28yBW1sHDL9mNCKGsGBAJkbpkoPZ44kGmsQiJvKug/HQIInxZ0gcLxlz
 QTiCCGI5m7xN9s+sI3uaKCwue+p8F//8YLmTmC19DMgrJbs3agATWmujd
 N2Khp+drvQGbpuj8vn237uIAM1FEzCyHt1cDwJPOs4ngLZHfY6qhU2T+/ A==;
X-CSE-ConnectionGUID: eIvU9VBFQ06J1NR4VE8fOA==
X-CSE-MsgGUID: 1p/XUGl0QPGgAvxYolEwrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79180253"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="79180253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 21:47:50 -0700
X-CSE-ConnectionGUID: rZ8wRx8gTbe+5ekze1AUFw==
X-CSE-MsgGUID: D4y/KY4KRYKIQ6OBogg+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="233680767"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2026 21:47:48 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v6 4/4] examples/ptpclient: use shared PTP library definitions
Date: Thu,  7 May 2026 15:43:14 +0530
Message-ID: <20260507101314.2456467-5-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507101314.2456467-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260507101314.2456467-1-rajesh3.kumar@intel.com>
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

Update ptpclient example to use IEEE 1588 PTP definitions from lib/net:
  - Replace PTP_PROTOCOL macro with standard RTE_ETHER_TYPE_1588
  - Remove local duplicate PTP header definitions
  - Add net library dependency in meson.build
  - Leverage rte_ptp.h inline helpers for header access

This aligns with DPDK library patterns and reduces code duplication.
The example remains compatible with standard linuxptp (ptp4l) tooling
for time synchronization.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 examples/ptpclient/meson.build | 1 +
 examples/ptpclient/ptpclient.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/examples/ptpclient/meson.build b/examples/ptpclient/meson.build
index 2e9b7625fc..9087c987d5 100644
--- a/examples/ptpclient/meson.build
+++ b/examples/ptpclient/meson.build
@@ -7,6 +7,7 @@
 # DPDK instance, use 'make'
 
 allow_experimental_apis = true
+deps += ['net']
 sources = files(
         'ptpclient.c',
 )
diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 174ca5dd70..ec6f316139 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -441,7 +441,7 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 		/* Set multicast address 01-1B-19-00-00-00. */
 		rte_ether_addr_copy(&eth_multicast, &eth_hdr->dst_addr);
 
-		eth_hdr->ether_type = htons(PTP_PROTOCOL);
+		eth_hdr->ether_type = htons(RTE_ETHER_TYPE_1588);
 		req_msg = rte_pktmbuf_mtod_offset(created_pkt,
 			struct delay_req_msg *, sizeof(struct
 			rte_ether_hdr));
@@ -582,7 +582,7 @@ parse_ptp_frames(uint16_t portid, struct rte_mbuf *m) {
 	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
 	eth_type = rte_be_to_cpu_16(eth_hdr->ether_type);
 
-	if (eth_type == PTP_PROTOCOL) {
+	if (eth_type == RTE_ETHER_TYPE_1588) {
 		ptp_data.m = m;
 		ptp_data.portid = portid;
 		ptp_hdr = rte_pktmbuf_mtod_offset(m, struct ptp_header *,
-- 
2.53.0

