Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697AC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 15:39:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8D64278E;
	Thu, 29 May 2025 17:39:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E662C4021F
 for <dev@dpdk.org>; Thu, 29 May 2025 17:39:18 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDsDj0030085;
 Thu, 29 May 2025 08:39:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 F1ZrDhJZh5i2gvm86gZ5HzXp54ID8SUo9Np7SX1oQE=; b=e9qA028ztuf+EHEaG
 xw0PR01Pp6m8/foazMiHg5vHLBvwQlBZ2QXlmAbYukem9eXy9SWI2bJkSus8aI2a
 Dzed05tq+Eq9lHSVtgSwkPHwUfQTu20cN3oBvAEXf+LjodB0T8+DsdPcLsvli7jE
 xF0E5THtnjE4t+Nn6ItOcArSX2kEhUiBcaA9Er1RBuUyGFh7BARHGNvSxQdxN6ey
 cBb6YUV6VNRgt5RSeRxTiEz2uDOcolH1Q8JmoaBiuSn8vijknLJDGX4owiDruoYn
 +J3pbTPBIsA4J9dgHqnVZtxSXD/1LUkcUQOHCIzMfYQ8dJsS5hUrq40ymgaMGZm2
 Wi1Mg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46xruv8893-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 08:39:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 May 2025 08:39:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 May 2025 08:39:13 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id D23303F70AB;
 Thu, 29 May 2025 08:39:10 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH v8 1/2] ethdev: support RSS based on RoCEv2 header
Date: Thu, 29 May 2025 21:09:06 +0530
Message-ID: <20250529153908.1571050-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250529153451.1552174-1-kirankumark@marvell.com>
References: <20250529153451.1552174-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lBnBKu0gm-WU_uo9HOIQxvwoyQ5MUtoz
X-Authority-Analysis: v=2.4 cv=QaNmvtbv c=1 sm=1 tr=0 ts=68387fa2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=P5Amv12X2xCUNasB97oA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lBnBKu0gm-WU_uo9HOIQxvwoyQ5MUtoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1MSBTYWx0ZWRfX2a+jH+SeqDl4
 ctf4IjXOVohXVDTxQV6/NtKQVxlrir1DKKyDOn2V7rflphlfU20iK9LhnCMXwbvtDAtaeFamyuC
 /dpNyfoBo4ZAKfMT+6TihUMEf8v5Amjo26VlXzngeoOaC4IiWZaNUSbA/uXzr3eqFODKWWX+eIa
 d7IjfNaslE14eiuVJNfS/TsJAk1PWMkQuEGFty0/LQK/ouaHKsR4rAkBGnZ9bAFnoQdmvNUeQ98
 h5xghjwmT7JrUJuIwUoIFrPmept+0qqyX8Yo3gbmU4T93z7XE0lm2rBmDq4xSu/qleNiRIZMePa
 mmQnfhM66efaTYcOMKSqZDz3Wm8ne7l0CVPBVUD65zbw9wFgFOpDeAc9N7ZV+k91oK82wgyfMlb
 uyGfpk8U1CArLxoZwbei+rsCokTSqTc0NXANAu5y6IBaRd5qPvxmhTBg2aFnACtOQ9DSHcGK
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
V8 Changes:
* Fixed doc
V7 Changes;
* Addressed review comments related to rss_type_table.

 app/test-pmd/config.c                  | 4 +++-
 doc/guides/rel_notes/release_25_07.rst | 5 +++++
 lib/ethdev/rte_ethdev.h                | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..5cc82a68aa 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -92,7 +92,8 @@ const struct rss_type_info rss_type_table[] = {
 	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
 		RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
 		RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
-		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2},
+		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2 |
+	        RTE_ETH_RSS_IB_BTH},
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

