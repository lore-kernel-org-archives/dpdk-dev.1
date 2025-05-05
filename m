Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604E4C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 05:33:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0BEA40650;
	Mon,  5 May 2025 07:33:18 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 10BFD4025D
 for <dev@dpdk.org>; Mon,  5 May 2025 07:33:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5450Tcfq002540;
 Sun, 4 May 2025 22:33:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 Wh8QYKHUoCqnw3QuKv2kDv5LeSMafB8oYsWx1B7Wu0=; b=OsaxDOIEKYu//uc7a
 W24QiwDh6eHZxsxapmcI/5cDQRr3hilGqYFxN/1CKa1tj3LRPFgQHQGBJraszdUy
 aShPFKKBet8zqFQpi4TVI9MfemU2AdT44xmHAe8Wzd2AUSe7IYAQpiu8+kV4PRp9
 xrxZgJ5xRcbeeMWOtBM8zve+B3aQBas6dxlDJFc3Dm4G4RY4P4qYAN3rmxuQFBKK
 ijce62GoULJW1MgqJmlDl7A5nSvhRRW7zKenANHsaWQQtgygeLy6t/WhTTkBV3Du
 oab6suQoZ8BMRxF6lC9JIcrewgXU8jl/0fee8+b9hcxKKzSw+JsA6j9m+RrnB86p
 vn/1A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46ehxprdtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 May 2025 22:33:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 4 May 2025 22:33:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 4 May 2025 22:33:09 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 8CE203F7073;
 Sun,  4 May 2025 22:33:07 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH v5 1/2] ethdev: support RSS based on RoCEv2 header
Date: Mon, 5 May 2025 11:03:03 +0530
Message-ID: <20250505053304.3288290-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250430102011.991865-1-kirankumark@marvell.com>
References: <20250430102011.991865-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: If6gLsYeQdvfCERBW5XHVUFmEmUyif0j
X-Proofpoint-ORIG-GUID: If6gLsYeQdvfCERBW5XHVUFmEmUyif0j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA0OSBTYWx0ZWRfX+aBfIT+weySY
 AgYe2uimBJ+5Lv18C6lZtUpjTxNi4CzEOizqo4Besch2o2djV6rXE5opVA9WeSfpBI3yszuI7Ys
 5b4dyVmTSop+f9n56Le6tAjS340cpnJIhGULnrcGUwpSXZuDm4Y8cjoZuesh8LJlSnA9G6QsfKr
 v+COBzUlojHduFDg0ON6KNB8y6eHy4PuM/7fk0iRDkCZINty365zUaJr3CjytJOJ+5p3iCxfmNq
 MuROkg/wpv/eAaanxaeQU7qRZTjb8o4zJhpo0Em4bsiEZfDWD/9jIr5ar3E0kW/6wfUavGh5M09
 xwR9v7s54qgihyglcXNHdreHnx7yRa1tEF/E5IMkr+niSEy7OkCJEFl/DU8aXNAgOR0Kfan/xr/
 kCsPeFj1g8Ik16UUCAklfSeN39Ekq9JIIxPH9XVRljgbTe/eidzt3vCDBmhKGE6MTbBpSVbW
X-Authority-Analysis: v=2.4 cv=U+mSDfru c=1 sm=1 tr=0 ts=68184d99 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=BX_ChJz85cp3RHIlamYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
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
 app/test-pmd/config.c                  | 5 ++++-
 doc/guides/rel_notes/release_25_07.rst | 4 ++++
 lib/ethdev/rte_ethdev.h                | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..043d5ec5fb 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -92,7 +92,9 @@ const struct rss_type_info rss_type_table[] = {
 	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
 		RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
 		RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
-		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2},
+		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2 |
+		RTE_ETH_RSS_IB_BTH },
+
 	{ "none", 0 },
 	{ "ip", RTE_ETH_RSS_IP },
 	{ "udp", RTE_ETH_RSS_UDP },
@@ -149,6 +151,7 @@ const struct rss_type_info rss_type_table[] = {
 	{ "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },
 	{ "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },
 	{ "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },
+	{ "ib_bth", RTE_ETH_RSS_IB_BTH },
 	{ NULL, 0},
 };
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..d1293893be 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added new RSS offload types for IB_BTH in RSS flow.**
+
+     Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be used as input set for RSS.
+
 
 Removed Items
 -------------
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..edcd6b75b5 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -602,6 +602,7 @@ struct rte_eth_rss_conf {
 
 #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)
 #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)
+#define RTE_ETH_RSS_IB_BTH		RTE_BIT64(38)
 
 /*
  * We use the following macros to combine with above RTE_ETH_RSS_* for
-- 
2.48.1

