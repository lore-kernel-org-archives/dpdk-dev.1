Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D15FC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 09:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECD0B4026C;
	Tue, 29 Apr 2025 11:52:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8867E40263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 11:52:56 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T6fYua028444;
 Tue, 29 Apr 2025 02:52:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 QlbB9mtLwo4tM9nHHh57OlYhMUFnd8E0QRDFuyYNX8=; b=DnyhVV759CmQsFxEK
 f07NnNuV19eRptg2xKzcam8xmg9VbZhN2Tt7+jm0A4+foSvPtjlTwS6ll0/Mx4y4
 sZUpqWoOi2uheHJ/3uOKLm55O4aQ929yE+07sIL9bYwHF4f4AFBS1zsRHDoQguDU
 iqG5pKfMeZ7DIKug4lf8zkh4Wzg4Bt6Xf0kTWSXpEH9Y8885ZChP+WSNLLSJrK/X
 GmjGq+fb4Tx0JCnnQid5fUDJy7eGLhaFu2qHfZ2ulofDBBqbdhb4qRBYK3+acljM
 XooxbV/81LsQeMC1c8Ub1F2SbBCiI13Vj+jNSOGIG0+U3VeN4VNTYSbu7xGWVLIJ
 7CL1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 468y0knmt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 02:52:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Apr 2025 02:52:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Apr 2025 02:52:52 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 6D0153F70B5;
 Tue, 29 Apr 2025 02:52:50 -0700 (PDT)
From: <kirankumark@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH v2 1/2] ethdev: support RSS based on RoCEv2 header
Date: Tue, 29 Apr 2025 15:22:41 +0530
Message-ID: <20250429095242.1861885-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250422051459.661395-1-kirankumark@marvell.com>
References: <20250422051459.661395-1-kirankumark@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XYuJzJ55 c=1 sm=1 tr=0 ts=6810a175 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=8LiFOyen1GoRQCaNSfYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: SPtQP_dODDlRVsUuxKKchW1hz1q0Trz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3MyBTYWx0ZWRfX4petCyhFjPcT
 TwDAaVbTU9J+Eb+hulvAXZHrWJzZurrHsWnlTkNHtcqpbDxyoIBzniMjQ63WuicQN7ixfZTGUkw
 65xyzDKGJ9jUZF5WgSMJeigmlyO/4ByaGdSA3U08XLryqUDB4TOXMYtasGNJ2hSo9FrvAu5Klnf
 f5wp9LzAujogcUVJfO/xgQKpid6o33l6UIql6jrFu6qEBIvqtsMxCDjDwZoItZIj8vLoBywDMBR
 YkA3mUCofw6M5k/Q50oaQGGyVQTR0AVxMYdK1adPHiWviZjiBFuhJEolUTFUF5MJA3DmR/y7v2K
 W55iUdum1OzWNE+Vrr8rZWMkHB2b0xtr/m1Y3j78k5qQZ8S6fFN3jUmLSIUTgla7qDMwPHcoJtR
 eM0ePISDJcGjWNpEE3K8aBb/HgLYwUPVABxErEcUKh8LRyOfGfM0uEVK930qsfSC0L8rTthL
X-Proofpoint-GUID: SPtQP_dODDlRVsUuxKKchW1hz1q0Trz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
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
 app/test-pmd/config.c                  | 120 +++++++++++++------------
 doc/guides/rel_notes/release_25_07.rst |  32 +------
 lib/ethdev/rte_ethdev.h                |   1 +
 3 files changed, 65 insertions(+), 88 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index e89af21cec..444e4b0388 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -89,67 +89,69 @@ static const struct {
 
 const struct rss_type_info rss_type_table[] = {
 	/* Group types */
-	{ "all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
-		RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
-		RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
-		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS | RTE_ETH_RSS_L2TPV2},
-	{ "none", 0 },
-	{ "ip", RTE_ETH_RSS_IP },
-	{ "udp", RTE_ETH_RSS_UDP },
-	{ "tcp", RTE_ETH_RSS_TCP },
-	{ "sctp", RTE_ETH_RSS_SCTP },
-	{ "tunnel", RTE_ETH_RSS_TUNNEL },
-	{ "vlan", RTE_ETH_RSS_VLAN },
+	{"all", RTE_ETH_RSS_ETH | RTE_ETH_RSS_VLAN | RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP |
+			RTE_ETH_RSS_UDP | RTE_ETH_RSS_SCTP | RTE_ETH_RSS_L2_PAYLOAD |
+			RTE_ETH_RSS_L2TPV3 | RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_PFCP |
+			RTE_ETH_RSS_GTPU | RTE_ETH_RSS_ECPRI | RTE_ETH_RSS_MPLS |
+			RTE_ETH_RSS_L2TPV2 | RTE_ETH_RSS_IB_BTH},
+	{"none", 0},
+	{"ip", RTE_ETH_RSS_IP},
+	{"udp", RTE_ETH_RSS_UDP},
+	{"tcp", RTE_ETH_RSS_TCP},
+	{"sctp", RTE_ETH_RSS_SCTP},
+	{"tunnel", RTE_ETH_RSS_TUNNEL},
+	{"vlan", RTE_ETH_RSS_VLAN},
 
 	/* Individual type */
-	{ "ipv4", RTE_ETH_RSS_IPV4 },
-	{ "ipv4-frag", RTE_ETH_RSS_FRAG_IPV4 },
-	{ "ipv4-tcp", RTE_ETH_RSS_NONFRAG_IPV4_TCP },
-	{ "ipv4-udp", RTE_ETH_RSS_NONFRAG_IPV4_UDP },
-	{ "ipv4-sctp", RTE_ETH_RSS_NONFRAG_IPV4_SCTP },
-	{ "ipv4-other", RTE_ETH_RSS_NONFRAG_IPV4_OTHER },
-	{ "ipv6", RTE_ETH_RSS_IPV6 },
-	{ "ipv6-frag", RTE_ETH_RSS_FRAG_IPV6 },
-	{ "ipv6-tcp", RTE_ETH_RSS_NONFRAG_IPV6_TCP },
-	{ "ipv6-udp", RTE_ETH_RSS_NONFRAG_IPV6_UDP },
-	{ "ipv6-sctp", RTE_ETH_RSS_NONFRAG_IPV6_SCTP },
-	{ "ipv6-other", RTE_ETH_RSS_NONFRAG_IPV6_OTHER },
-	{ "l2-payload", RTE_ETH_RSS_L2_PAYLOAD },
-	{ "ipv6-ex", RTE_ETH_RSS_IPV6_EX },
-	{ "ipv6-tcp-ex", RTE_ETH_RSS_IPV6_TCP_EX },
-	{ "ipv6-udp-ex", RTE_ETH_RSS_IPV6_UDP_EX },
-	{ "port", RTE_ETH_RSS_PORT },
-	{ "vxlan", RTE_ETH_RSS_VXLAN },
-	{ "geneve", RTE_ETH_RSS_GENEVE },
-	{ "nvgre", RTE_ETH_RSS_NVGRE },
-	{ "gtpu", RTE_ETH_RSS_GTPU },
-	{ "eth", RTE_ETH_RSS_ETH },
-	{ "s-vlan", RTE_ETH_RSS_S_VLAN },
-	{ "c-vlan", RTE_ETH_RSS_C_VLAN },
-	{ "esp", RTE_ETH_RSS_ESP },
-	{ "ah", RTE_ETH_RSS_AH },
-	{ "l2tpv3", RTE_ETH_RSS_L2TPV3 },
-	{ "pfcp", RTE_ETH_RSS_PFCP },
-	{ "pppoe", RTE_ETH_RSS_PPPOE },
-	{ "ecpri", RTE_ETH_RSS_ECPRI },
-	{ "mpls", RTE_ETH_RSS_MPLS },
-	{ "ipv4-chksum", RTE_ETH_RSS_IPV4_CHKSUM },
-	{ "l4-chksum", RTE_ETH_RSS_L4_CHKSUM },
-	{ "l2tpv2", RTE_ETH_RSS_L2TPV2 },
-	{ "l3-pre96", RTE_ETH_RSS_L3_PRE96 },
-	{ "l3-pre64", RTE_ETH_RSS_L3_PRE64 },
-	{ "l3-pre56", RTE_ETH_RSS_L3_PRE56 },
-	{ "l3-pre48", RTE_ETH_RSS_L3_PRE48 },
-	{ "l3-pre40", RTE_ETH_RSS_L3_PRE40 },
-	{ "l3-pre32", RTE_ETH_RSS_L3_PRE32 },
-	{ "l2-dst-only", RTE_ETH_RSS_L2_DST_ONLY },
-	{ "l2-src-only", RTE_ETH_RSS_L2_SRC_ONLY },
-	{ "l4-dst-only", RTE_ETH_RSS_L4_DST_ONLY },
-	{ "l4-src-only", RTE_ETH_RSS_L4_SRC_ONLY },
-	{ "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },
-	{ "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },
-	{ "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },
-	{ NULL, 0},
+	{"ipv4", RTE_ETH_RSS_IPV4},
+	{"ipv4-frag", RTE_ETH_RSS_FRAG_IPV4},
+	{"ipv4-tcp", RTE_ETH_RSS_NONFRAG_IPV4_TCP},
+	{"ipv4-udp", RTE_ETH_RSS_NONFRAG_IPV4_UDP},
+	{"ipv4-sctp", RTE_ETH_RSS_NONFRAG_IPV4_SCTP},
+	{"ipv4-other", RTE_ETH_RSS_NONFRAG_IPV4_OTHER},
+	{"ipv6", RTE_ETH_RSS_IPV6},
+	{"ipv6-frag", RTE_ETH_RSS_FRAG_IPV6},
+	{"ipv6-tcp", RTE_ETH_RSS_NONFRAG_IPV6_TCP},
+	{"ipv6-udp", RTE_ETH_RSS_NONFRAG_IPV6_UDP},
+	{"ipv6-sctp", RTE_ETH_RSS_NONFRAG_IPV6_SCTP},
+	{"ipv6-other", RTE_ETH_RSS_NONFRAG_IPV6_OTHER},
+	{"l2-payload", RTE_ETH_RSS_L2_PAYLOAD},
+	{"ipv6-ex", RTE_ETH_RSS_IPV6_EX},
+	{"ipv6-tcp-ex", RTE_ETH_RSS_IPV6_TCP_EX},
+	{"ipv6-udp-ex", RTE_ETH_RSS_IPV6_UDP_EX},
+	{"port", RTE_ETH_RSS_PORT},
+	{"vxlan", RTE_ETH_RSS_VXLAN},
+	{"geneve", RTE_ETH_RSS_GENEVE},
+	{"nvgre", RTE_ETH_RSS_NVGRE},
+	{"gtpu", RTE_ETH_RSS_GTPU},
+	{"eth", RTE_ETH_RSS_ETH},
+	{"s-vlan", RTE_ETH_RSS_S_VLAN},
+	{"c-vlan", RTE_ETH_RSS_C_VLAN},
+	{"esp", RTE_ETH_RSS_ESP},
+	{"ah", RTE_ETH_RSS_AH},
+	{"l2tpv3", RTE_ETH_RSS_L2TPV3},
+	{"pfcp", RTE_ETH_RSS_PFCP},
+	{"pppoe", RTE_ETH_RSS_PPPOE},
+	{"ecpri", RTE_ETH_RSS_ECPRI},
+	{"mpls", RTE_ETH_RSS_MPLS},
+	{"ipv4-chksum", RTE_ETH_RSS_IPV4_CHKSUM},
+	{"l4-chksum", RTE_ETH_RSS_L4_CHKSUM},
+	{"l2tpv2", RTE_ETH_RSS_L2TPV2},
+	{"l3-pre96", RTE_ETH_RSS_L3_PRE96},
+	{"l3-pre64", RTE_ETH_RSS_L3_PRE64},
+	{"l3-pre56", RTE_ETH_RSS_L3_PRE56},
+	{"l3-pre48", RTE_ETH_RSS_L3_PRE48},
+	{"l3-pre40", RTE_ETH_RSS_L3_PRE40},
+	{"l3-pre32", RTE_ETH_RSS_L3_PRE32},
+	{"l2-dst-only", RTE_ETH_RSS_L2_DST_ONLY},
+	{"l2-src-only", RTE_ETH_RSS_L2_SRC_ONLY},
+	{"l4-dst-only", RTE_ETH_RSS_L4_DST_ONLY},
+	{"l4-src-only", RTE_ETH_RSS_L4_SRC_ONLY},
+	{"l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY},
+	{"l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY},
+	{"ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL},
+	{"ib_bth", RTE_ETH_RSS_IB_BTH},
+	{NULL, 0},
 };
 
 static const struct {
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..1b8ba5ab90 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -24,36 +24,10 @@ DPDK Release 25.07
 New Features
 ------------
 
-.. This section should contain new features added in this release.
-   Sample format:
+* **Added new RSS offload types for IB_BTH in RSS flow.**
 
-   * **Add a title in the past tense with a full stop.**
-
-     Add a short 1-2 sentence description in the past tense.
-     The description should be enough to allow someone scanning
-     the release notes to understand the new feature.
-
-     If the feature adds a lot of sub-features you can use a bullet list
-     like this:
-
-     * Added feature foo to do something.
-     * Enhanced feature bar to do something else.
-
-     Refer to the previous release notes for examples.
-
-     Suggested order in release notes items:
-     * Core libs (EAL, mempool, ring, mbuf, buses)
-     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
-       - ethdev (lib, PMDs)
-       - cryptodev (lib, PMDs)
-       - eventdev (lib, PMDs)
-       - etc
-     * Other libs
-     * Apps, Examples, Tools (if significant)
-
-     This section is a comment. Do not overwrite or remove it.
-     Also, make sure to start the actual text at the margin.
-     =======================================================
+  Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be used as
+  input set for RSS.
 
 
 Removed Items
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..3f5317c489 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -602,6 +602,7 @@ struct rte_eth_rss_conf {
 
 #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)
 #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)
+#define RTE_ETH_RSS_IB_BTH RTE_BIT64(38)
 
 /*
  * We use the following macros to combine with above RTE_ETH_RSS_* for
-- 
2.48.1

