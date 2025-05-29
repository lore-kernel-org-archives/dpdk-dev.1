Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07737C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 15:43:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28F4E4278E;
	Thu, 29 May 2025 17:43:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EFFEC402C1
 for <dev@dpdk.org>; Thu, 29 May 2025 17:43:53 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDrJ74028761;
 Thu, 29 May 2025 08:43:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 Hyx6i5wQZQjvvw7zD62WD7wRisr73RfIdaj1dU0cao=; b=jNq6SB5mVdrz3FSqS
 k4NwPww9Per3X3EwMvuKhR1XGXM1ULdGiD3/smTOsDtOCwEJk/8GrleQhD5LokfK
 DH883b6Tkvn5DBrnmwK9Bo1F5M5/lJZ4VzrPWYF09CN/h8BSwFSMVu9DgornT+pT
 K+Bro5O3JZDKedGdnM4wtpM1dfhicDNlAPOFvtCunEfgRQT92ZO92Eo+1NzorDNh
 IQgGELCWjoHeRUubdAmL7xN0CF1GP7PXfDtAI5LRHLr0zFppVo0axJNCISCIdPeW
 Q2ph1hlNEVek/3IXuhPeU8SSEc6g7V5r/eAHCaQ+17dfGs6VwhfEFO39Ouoj+/ot
 u+Vzg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46xruv88mu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 08:43:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 May 2025 08:43:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 May 2025 08:43:50 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id B4C5E3F70AB;
 Thu, 29 May 2025 08:43:48 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH v9 1/2] ethdev: support RSS based on RoCEv2 header
Date: Thu, 29 May 2025 21:13:42 +0530
Message-ID: <20250529154343.1589903-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250529153908.1571050-1-kirankumark@marvell.com>
References: <20250529153908.1571050-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _4Q-wBJEaHcagnT848n2oZjkVBD8eVhu
X-Authority-Analysis: v=2.4 cv=QaNmvtbv c=1 sm=1 tr=0 ts=683880b7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=P5Amv12X2xCUNasB97oA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: _4Q-wBJEaHcagnT848n2oZjkVBD8eVhu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1MiBTYWx0ZWRfX6GGAeipKcH8Q
 7afTXgKDMMFIkyX+3Uk4Qhvb/MjJj2biWlf96NyrB9bljBUAEoMzJ7Xkx3c3Xj7qrR/d00HN01f
 LV+vowfC55mLxazEeivQ74mf21dzc9xx6QLL7NkBK5AXNOUPB0XGts24/txZFGjFApI8/ez0nFf
 GAewRnmoKqigPq2SWnJhyythWXRK0b4yjADsWIi529UAPKVJDpQYFWJaP02T09H+Q67blPrVF38
 A/lSr+ptN3AwwgYc2qRfJBdE+GVuTC/q4+UMAKFe4K3JWmcoel0Ye3NuMrhodbgitDSd5JW5+3Y
 zHwFCVm2HXcVHbyDjsiliY4aCKjCBi1BWZaz+dOmKJZr/icDJJBZniR/2uWQhwX8A1bnH56YRL3
 WVwWanG0GhAJ+cl/dsVqZV+RKPzVIa74TnkPZ9LrL1d3eS8oUrqZO7GBtLl2j7yGNHPtnrHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
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

From: Kiran Kumar K <kirankumark@marvell.com>

On supporting hardware, RoCEv2 header can be used to
perform RSS in the ingress path.

Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
---
V9 Changes:
* Fix checkpatch warnings.
V8 Changes:
* Fixed doc
V7 Changes;
* Addressed review comments related to rss_type_table.
 app/test-pmd/config.c                  | 4 +++-
 doc/guides/rel_notes/release_25_07.rst | 5 +++++
 lib/ethdev/rte_ethdev.h                | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..26fd920a36 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -92,7 +92,8 @@ const struct rss_type_info rss_type_table[] = {
 	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
 		RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
 		RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
-		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2},
+		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2 |
+		RTE_ETH_RSS_IB_BTH},
 	{ "none", 0 },
 	{ "ip", RTE_ETH_RSS_IP },
 	{ "udp", RTE_ETH_RSS_UDP },
@@ -149,6 +150,7 @@ const struct rss_type_info rss_type_table[] = {
 	{ "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },
 	{ "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },
 	{ "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },
+	{ "ib-bth", RTE_ETH_RSS_IB_BTH },
 	{ NULL, 0},
 };

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 6b070801de..9a3677f972 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================

+* **Added new RSS offload types for IB_BTH in RSS flow.**
+
+  Added ``RTE_ETH_RSS_IB_BTH`` macro so that the RoCE Infiniband base transport header
+  can be used as input set for RSS.
+
 * **Added burst mode query function to Intel drivers.**

   Added support for Rx and Tx burst mode query to the following drivers:
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..8e0c89581e 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -602,6 +602,8 @@ struct rte_eth_rss_conf {

 #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)
 #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)
+/** RoCE InfiniBand Base Transport Header */
+#define RTE_ETH_RSS_IB_BTH RTE_BIT64(38)

 /*
  * We use the following macros to combine with above RTE_ETH_RSS_* for
--
2.48.1

