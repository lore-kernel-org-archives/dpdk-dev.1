Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D83C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 10:20:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFDBD402A7;
	Wed, 30 Apr 2025 12:20:21 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 39F74402A3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 12:20:20 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U5cHs0020082;
 Wed, 30 Apr 2025 03:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 Zh1A2tvpFIdNygMJen2VRMW3lklmTDq2uRhXP86oaM=; b=WWgfXW61sRoDg3Eht
 qAxxlKv/hMpPBmzI8Bb9ed953lBUlFXK5y4VoIFOk+ycV6fIcvkdu4M0KztPgwSU
 OQ4LH6AOUTzywNj2wb1pSruWD2cIF/LgSiDYV3sH39+PBvlGnXtVkcIBsyjiyFX5
 sOEjYBFoOqYjH46XONFo+HvaO+fEg1ZyLOEaahraKbIeHDt4nZhIXRvkdzL+//lW
 Up6jWFZMn+UgAD1bbUh19RRULTu+mKOjm0Sy2Qv1vIVO5M4VhLSQpVZwRP8z7Adm
 NODHcgo82usMlP5ADf81kz9oqr/9YOlAK553GZnG5UCDSODctKQro01rAS8K0BXp
 GenHA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46bdvm0dj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 03:20:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Apr 2025 03:20:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Apr 2025 03:20:16 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 6CA8D5B6944;
 Wed, 30 Apr 2025 03:20:14 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH v4 1/2] ethdev: support RSS based on RoCEv2 header
Date: Wed, 30 Apr 2025 15:50:10 +0530
Message-ID: <20250430102011.991865-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250430091051.789240-1-kirankumark@marvell.com>
References: <20250430091051.789240-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2IGeiKvXLeAaDwnFjLT8xA8_gXpMPqR-
X-Proofpoint-ORIG-GUID: 2IGeiKvXLeAaDwnFjLT8xA8_gXpMPqR-
X-Authority-Analysis: v=2.4 cv=acZhnQot c=1 sm=1 tr=0 ts=6811f961 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=MUTd60XSKecb_B-SAzQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA3MyBTYWx0ZWRfX1+DPMnuBHY2S
 9uP3pslq/T1ioHt6dSJPvjl3qnoJ7k9B+8+hTp6yL+aanl3EPCSm8gK3ieyYOxUEn/biF0LIuMK
 XTBQJfTLgD7DiixHmJPwIHPlyoxj97C6/BrBf0j6nlhep6J0QqWqitI6Eku7D39brAvj+nvqVit
 rt4w8g0AhzaFvi5hkjlea3yDT5ZZcDl51IUg9lQBc/cG87XBknbIWto7K3uoxYi1iVw/2xHzR2l
 DYMMjWosHHVB9BLSm3B3ZCH2GyXVCaigqRB89qD6jXkaSDprWbxSCHMKi/8h56w1zACoHm66gqy
 Wge+B69bMRyz5uWGBf9DVSsCh9y/wnMgpb692//c2LK8arK1F/NSWgraet7lSQtpIPBWNCsOLvC
 DLIXeWtbvifXiOGACVx6pVAu5PFZ/Y621DtgeC8NYeDq97Zj3Hmskw/Ql7pmHBByi+eWLdjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_03,2025-04-24_02,2025-02-21_01
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
* v4 Changes:
 - Fix checkpatch issues

 app/test-pmd/config.c                  | 5 ++++-
 doc/guides/rel_notes/release_25_07.rst | 3 +++
 lib/ethdev/rte_ethdev.h                | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index 093b85d206..1da999685f 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -54,6 +54,9 @@ New Features
      This section is a comment. Do not overwrite or remove it.
      Also, make sure to start the actual text at the margin.
      =======================================================
+* **Added new RSS offload types for IB_BTH in RSS flow.**
+
+     Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be used as input set for RSS.


 Removed Items
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

