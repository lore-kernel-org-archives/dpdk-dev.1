Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C6C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 05:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0529A40A75;
	Fri,  7 Mar 2025 06:40:37 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
 by mails.dpdk.org (Postfix) with ESMTP id E98F94029E;
 Fri,  7 Mar 2025 06:40:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVYGcpw4yXw9MnZPGyDFvhKG0Q1RTN+LQxRR1xqtpDVbZYOn0NWowAkEiEw+9/FhwilbA4GL+HcDriiNh7X6OTzILW+FUs6p/7gu5qg7wDLRScCgR8y11/bq1J1o0x7q4Jh0J5h3JpmRi+xxduUW4iZ/LIR488wkmgmqaB62ruVW7mhsFWkPChzV/oOXKs4GnlWdkybS91yU5EUZ/MVADYSVRSQFHrd4zgHyKQrD9PHVRMI6EewzoqDjyGlL+ixvbU+kfKNvCaPEx3fHbHRKTpqfXVqpi8XYaEHrQzwJyq+Ba8VocYPtthzdHUjtEXplg1YU3YYBexR8FL4NitY5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wf7I2Z83lozUWL8168NIDYWfdBVSt4fCjAuZN+jR6c=;
 b=Qay1xvsqI2k0F3hYBcEx8jLz4BwFkt5y4r3Ga3hz0FHGcUYLPEND1jcONWkUHNLMf7/DnJg+yLIUOAPaJGdslRLUWZ55lxlXrIVSZT+Jo6xm9S+x0TwAWwwx4fvzkN+3c6JN4YwK2omY67k/V4vRxsE+L78FoTi/cvpE4rqhT7rM3XFPyyAEFRRCbQWhGH1ARzrytWY/1tZiEF0m2QWPLNDYp7+jvGmQNa9NIXYM8nlkxnmhA1/4kuWkob1FIqehyEQqVdxqFKjJexIrkOmFAXgX882MSXzJBGg8xlrPVkp1iRXhaYaY1t5OUfCXfjcKUnf5745DmJcH5Qkk7hyrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wf7I2Z83lozUWL8168NIDYWfdBVSt4fCjAuZN+jR6c=;
 b=G/Bm133o3NJGShpqySXBMRLTUVuKJ0ciWwEQE7f4l5Yr90mOZRILfUpQOdzVtPIYW9951sK/FppP+IE2wic1Wd7bdiiopwP18hfWcOpwRCNLZ4iRWb8bGIfmSW/NLwBHWsHYpsIsjKl0u4wqE4jrs2WBqZxU3GGe8tcj/vfXTfaIeeVw1uy/LsJhk9z+g3fRH1Nr8zCT6f8HRKGMJgOdIulxvQnqyXeqteVxwrs2d4ApI/cJ6d5LXhbO/R8S1UPXyf9cS19Fo3M7Jh0HWab3JgqvSjCtroFlK7gfqqFY1lJezn13iWFHjlyj8gfV+zmXMGOFNVLP8D6lowjH5rc1aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by PA4PR07MB7614.eurprd07.prod.outlook.com (2603:10a6:102:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Fri, 7 Mar
 2025 05:40:33 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 05:40:33 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Ke Zhang <ke1x.zhang@intel.com>
Cc: dev@dpdk.org,
	Yang Ming <ming.1.yang@nokia-sbell.com>,
	stable@dpdk.org
Subject: [PATCH] net/iavf: fix mbuf release bug for ARM Architecture
Date: Fri,  7 Mar 2025 13:40:22 +0800
Message-Id: <20250307054023.911-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|PA4PR07MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 30441361-4ca2-41f2-002d-08dd5d3a9436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gsPZOoeXSevhWw6j7Ew2X7DE+Zk2l+onyB0arunsgdLCjEd5mXChc2rJ5irI?=
 =?us-ascii?Q?uRZ4zAabQ9jRSTWNb/z45A5jcSUUQbR7Ka1GrWGyWx0vPnp4d7ELqSZDvp4X?=
 =?us-ascii?Q?lsb3nGSxIHra4fAe+PtNmIipifQLCnfM+AxVDJkX2Odggxd7cJT0srhd2yGx?=
 =?us-ascii?Q?mzkTYwvdNBmz7FOy8CM9XXtve0RCumnQRr2UPez+ORTwceUt95dbt0z4AUsj?=
 =?us-ascii?Q?aSJQEa9JCc58XedzI4gSTAYnAyJ5amTWKdLFC5+hS3MB0TleNbRJyGwrvLhP?=
 =?us-ascii?Q?OhPn4ML/dRZT5vQaLFBtWPBR43vpc2NO3+Plb4wkx5joymLggE6/7JVM1kQ1?=
 =?us-ascii?Q?lpvKiw9lq2bEEpX0DX8qBtqIH4iAr42W2PSNo24/w1x+bDWOZ74s5WRMAO+4?=
 =?us-ascii?Q?OJJa7pxIFDaEnH0i6umnJiTsuaJqyCQzxAJOVJG3mLSyYdgqmw8fponoElHz?=
 =?us-ascii?Q?TudFeU7Z7fWUFRQDeqYzJd0L7YnjxouYQ0xrPOaL7WU9OCLavb94fUVofNhz?=
 =?us-ascii?Q?0ZQIGfWCrBKzROLG4snlpDjRkflEoJJRvuT/5fsfO9KyLkwaxQqVcAg4P0uL?=
 =?us-ascii?Q?S2ayrnEArM0Mkq1dna5bxgSfAgLJxQtkKyqaf97a4UJkFv/ZZcqnMwBQQei7?=
 =?us-ascii?Q?ZHDzjbH3fHq7KrnQ6t1247GADjT8yYdHzlaznfWUhlew7sYN/jd7bPrQ7bmp?=
 =?us-ascii?Q?s6g2qJt6N3cw87ca91lt4wQZuCRaFo8SXpjIffHZZUcLJQZCwNLT/Dl1IkdP?=
 =?us-ascii?Q?P7WZIa1oQZlHCss6lmWhAEm9sxDA7pqd5AF7PeO8yk0mCM3Y6GIsLNN7IyeB?=
 =?us-ascii?Q?rx9LVrcRzRF+VBeexKgh1hGR7nh0uwWLzeHK0dyFS+E4EjUsWHHSJqk6Zq+N?=
 =?us-ascii?Q?6AUEX5LUIetv60NRaJAHlUbHnKcyqTlVZmN57NK79/Ec/1jbW/GLCcFJY1Dz?=
 =?us-ascii?Q?4mFR82IGjLtoBZY8PK/qhN0Q74bD3xCexpI5zV5NJgiZRe7jcJSSPOkB+vMI?=
 =?us-ascii?Q?c6wjuSAX/BrmAmj6Ofo/Bmuv6Ad+ZQt10qHMRrbuMV7TTJ7wQ9lYAxAHubZH?=
 =?us-ascii?Q?sshxKf68GZmkj9SLfN+YuSbYotaaeGOdBgTzUdo/2qHBLGPXg7ODAcIWtDDF?=
 =?us-ascii?Q?qru80pcbWH4BR7Iz9DXY63u+SpMpsmCBFWeC0MGAxmgXlGc3ehLgUfy2mtGr?=
 =?us-ascii?Q?7D85g8221WWZ341K+n2Nr5PVJPOOmZK4YoZwLAQbcPrch142gmcWsfpOu6SO?=
 =?us-ascii?Q?mQQxF0gkg0IE+OXcSMdNYfoZeQHosINDQvJLWpupQoTos6URloM3eyjJUF/m?=
 =?us-ascii?Q?R2L6OzUrFtIDRSKZ3+KaJ6RF9AdXXRTzn9CySGenf/BrMD41ltaJIBrskX+0?=
 =?us-ascii?Q?fY9q2WHj9MwA/CimVrnv/CY2WF5L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gUhsIyR7zEErMnKqfGL7l95i13DgYr9xv2Mf+90vJHS0ICdkkcXBhOzS36Sa?=
 =?us-ascii?Q?Y8ytFwlepb3czEC9eYuTYU9i3ioZSFd2pkbUJiVd/bnQ/hCyIMAnnYGz+RYP?=
 =?us-ascii?Q?CoVI3js3bZq/n8dqWRWnGUYWoq0aef9f2z05VbbuxcBZmKYCYV80D2WbGUPz?=
 =?us-ascii?Q?9FiRiLA+sJozsCE7b9/ME7zHXAVxzBB07c+s5hfMPgxulzhgUjzO9+dDV5hm?=
 =?us-ascii?Q?G5OBzhI+FGqN/nytsTmLjaPX3IrgTTsNgiR4CIRlzT+QN9zUBQ93/TqOCxK4?=
 =?us-ascii?Q?AW2aUEl6RKpRIDfJlN/26GNq1Mbr1EsBtkq4eHqskQ79CW5Sy+Wz//5qTUsQ?=
 =?us-ascii?Q?brXlcBrMd/Xable26zJ75y5+2OG0RhDkCicwVbTs1ObjxNisezmDsE7SZ6Qw?=
 =?us-ascii?Q?GaIM8W0+WPvGIgVQeo5gu8N+0O0MK94St8WLBRCytkt3vQNHjn4Yenmu0XuQ?=
 =?us-ascii?Q?p19HvueAHHLYP+NRxPgruiAiSICtCGJ+dKRJqWX+tqqcyQMdphqLI+2cElU9?=
 =?us-ascii?Q?kqfIGMrKjIVGe8dhJuul30wh3h7qnob8WfCnq+eWnKQpE8hALBTUIy4uQGm3?=
 =?us-ascii?Q?7N/DWw1ujsAQfueL+DfaoilfKBmlX1/fKJloAulIQm6ARM1jvklAqp31Kcue?=
 =?us-ascii?Q?XMFfRVvcmE6R2FT9hYxGBsbOKGGpMNgPqfiY2ELGuPfmQtcX7EbJJ9UpnVdd?=
 =?us-ascii?Q?YLHX+6C/HuysiiWcxc3DRdhiduhS3aQ13IOgxXh7Vizp36WfyVF3iz8T6sel?=
 =?us-ascii?Q?nLG+Ux/FlV5yJgvG3Ily+OGWLI+8rAJZDGlk+IW/iU6PBtiL9rbXsn/368e3?=
 =?us-ascii?Q?x2JngBD8339ljws8ZYhYprtX3f8bCOIGqDrDYYflZ7jR8bXtZDKJGue3botF?=
 =?us-ascii?Q?wRo1GOdhMILmhQn/42bx/TqL0l8NtZ45CTzm1tuR28aNoJFJXqlSJYtkmcDW?=
 =?us-ascii?Q?IXCqNNGK3rZH/TcBxbbuXLP8+43+G0Myu7KpmGgNXc4MZ6+VJWr64cSpwJ3k?=
 =?us-ascii?Q?txXx2RfW23aXBv160sfqQHfBSQ+Vq7FaKTSMBNZq+8jCV2tzTl5ofeaHJAUf?=
 =?us-ascii?Q?WgMeMC5DtZR8FAQp9eFL6fsWUro8ExVpZ/T9UB/I0OWpArjSViZYhMyE7r/p?=
 =?us-ascii?Q?AC9QQEFHJY1Usq374TI3omSGvWfE2eEEXDmrPXe4ibUK2v8ggYB4zlYiQoA1?=
 =?us-ascii?Q?I0I3rzeYnn40WDwNfyqdbAXLw5pOayvY1tXmZWjmiGq0GFNvyyv+QaUD1d+p?=
 =?us-ascii?Q?EgVxjyngBlk37NYEOPsNACoVuaablAXMDx1HSS26MLto7BmthrIkf3PSHrw8?=
 =?us-ascii?Q?FadXWuf9umO9XaxqK9sZK75nOnajMOm8iPDIm1L8Y8AhZ+Ug7vWcVhkElooS?=
 =?us-ascii?Q?eW496vh20TLdZr8bcb5g16lGMFv73vk35NVvM4lvbzjJ/F36OjswKrfdEhP3?=
 =?us-ascii?Q?P85HhSPZj9/l//nIYp5qtYTh4U6K/53REz/xcR8S6LGHfiuXrxx9qwbhSsqu?=
 =?us-ascii?Q?9VafqemAu6bZlSB7kODBjpm3JGkS68iOYG7jRy720EmXOaKZkGeF0mEkeJuK?=
 =?us-ascii?Q?yvrYG3vX+U+vNvE1LgtOaFLRfMZJhu2x0jZjAmLM9WM9k6u9P8cdn1DSXMKu?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30441361-4ca2-41f2-002d-08dd5d3a9436
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:40:33.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N2WKp78JdZDHFUGmoFBtPoFMJRynyOkbjikqkkuGJDOFujILNujZa9lIbBP4B+6xn2SyrYZzJFyS7PdyLsClkAqqfsHQPlGUDtthxcbgDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7614
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

This patch addresses a bug related to mbuf release in the ARM
architecture. The previous patch resolved the mbuf release issue
in a multi-process environment but was only applicable to the
x86 architecture, leaving ARM unaddressed.
This patch extends the fix to include the ARM architecture,
ensuring consistent behavior across both x86 and ARM platforms.

Fixes: fced83c1229e ("net/iavf: fix mbuf release in multi-process")
Cc: ke1x.zhang@intel.com
Cc: stable@dpdk.org

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c          | 3 +++
 drivers/net/intel/iavf/iavf_rxtx.h          | 2 ++
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 8 ++------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 657963750d..a999073691 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -380,6 +380,9 @@ struct iavf_rxq_ops iavf_rxq_release_mbufs_ops[] = {
 #ifdef RTE_ARCH_X86
 	[IAVF_REL_MBUFS_SSE_VEC].release_mbufs = iavf_rx_queue_release_mbufs_sse,
 #endif
+#ifdef RTE_ARCH_ARM64
+	[IAVF_REL_MBUFS_NEON_VEC].release_mbufs = iavf_rx_queue_release_mbufs_neon,
+#endif
 };
 
 static inline void
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 6a54b446cf..823a6efa9a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -404,6 +404,7 @@ enum iavf_rxtx_rel_mbufs_type {
 	IAVF_REL_MBUFS_DEFAULT		= 0,
 	IAVF_REL_MBUFS_SSE_VEC		= 1,
 	IAVF_REL_MBUFS_AVX512_VEC	= 2,
+	IAVF_REL_MBUFS_NEON_VEC		= 3,
 };
 
 /* Receive Flex Descriptor profile IDs: There are a total
@@ -729,6 +730,7 @@ void iavf_set_default_ptype_table(struct rte_eth_dev *dev);
 void iavf_tx_queue_release_mbufs_avx512(struct ci_tx_queue *txq);
 void iavf_rx_queue_release_mbufs_sse(struct iavf_rx_queue *rxq);
 void iavf_tx_queue_release_mbufs_sse(struct ci_tx_queue *txq);
+void iavf_rx_queue_release_mbufs_neon(struct iavf_rx_queue *rxq);
 
 static inline
 void iavf_dump_rx_descriptor(struct iavf_rx_queue *rxq,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 6bc8e1db2a..a583340f15 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -393,20 +393,16 @@ iavf_recv_pkts_vec(void *__rte_restrict rx_queue,
 	return _recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
 }
 
-static void __rte_cold
+void __rte_cold
 iavf_rx_queue_release_mbufs_neon(struct iavf_rx_queue *rxq)
 {
 	_iavf_rx_queue_release_mbufs_vec(rxq);
 }
 
-static const struct iavf_rxq_ops neon_vec_rxq_ops = {
-	.release_mbufs = iavf_rx_queue_release_mbufs_neon,
-};
-
 int __rte_cold
 iavf_rxq_vec_setup(struct iavf_rx_queue *rxq)
 {
-	rxq->ops = &neon_vec_rxq_ops;
+	rxq->rel_mbufs_type = IAVF_REL_MBUFS_NEON_VEC;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
-- 
2.34.1

