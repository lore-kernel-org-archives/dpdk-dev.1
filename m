Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4519C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 06:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 554F440E34;
	Tue,  8 Apr 2025 08:02:35 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
 by mails.dpdk.org (Postfix) with ESMTP id 683C64026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 08:02:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqzH3RcEWrpAydRQUnTHmYmpNtlqcpM2SOOco+pd3rLmnumwAr2wlF5HZrcqI+DxU24CiUBDbhKyAGT+pqytAzvIyS1vf9naUodBiVYn+EakbeF2H59lyY4FQiSBAfeHhu4wwvFYNNTilqlgO28jviWbz29gyw7O5dRWP587iKcIlzLWNOUtmJqTT3plUBKcxMXBkCo3s6k6laUnPHq79pUWNpCzFwSC8zDM8Nlgr4G7zayNViT4QNruWbN0el7WYOILZYqsN+HMPOE6wwXE6nAd90RQtx5wU5zGDuUOPxvJmhWxvF8FXcUZLFHk/7gqnYOOgvtRUkH3mZ89t1kUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9dnoWr7GNOzZAksXdYhbqnm0yl2FwCvxXKyp+gDTlg=;
 b=aCHyGPNgYMmHqDf4c6/FqIRD0447o75K0KObpC3wvrpXmMeO32lTgfnmCq9kVIHfB9L9MqdQcfR5E/+7VR06GhGMyL0SLOdkfQftJ3lj6y7KOJHT41fQO82djvJSWHVYypSz1bRUJcHrhO+Ol1dUv9UOFQlTfPkXx+EUp8d50vzD1QgGPAQg3S0q8r4rqpcnjPiwcR6JZ9rR+7i32ERZyR0WrKgtHynvqIBvJiAQR7UpjcejGoiMbcofmboEkYo2FKf5IgXpDh7ENrhrM48KFGNNi2LsS2SVGRppYiAh61thwB+JFkqBnR4UmoVEvUhEkOh8DdAbF444fpi6IX0roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9dnoWr7GNOzZAksXdYhbqnm0yl2FwCvxXKyp+gDTlg=;
 b=Mt+fu7CKjgTCROCySzL1/MN5YUbzi1Fg84mFFZNjZx3mNH3PjikPVg7X7tphCPqShl/Ayq0vD1ThsfdzZovITijPjRweYmGsf67yJ/s/iqMzVtiXS9RrlOqHH5Gr8HImD0+jRn/NqjD6DPGfxzNdgKPyRsKGrZL3sVcge7J4L3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SJ0PR13MB5918.namprd13.prod.outlook.com (2603:10b6:a03:439::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:02:30 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.043; Tue, 8 Apr 2025
 06:02:30 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 2/3] net/nfp: support get RSS algorithm configuration
Date: Tue,  8 Apr 2025 14:02:02 +0800
Message-ID: <20250408060203.473733-3-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408060203.473733-1-chaoyong.he@corigine.com>
References: <20250408060203.473733-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SJ0PR13MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3c2878-d899-4d57-e6de-08dd7662f223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?znttBePY9yg+2JhjqIE2jlvZ9nW8ciF0hkpxDSS7oJROegAxR9HsSAkdeX0m?=
 =?us-ascii?Q?ofl4f50DLnXDIyQT49ASu10fgTBBFcRtR7Y79/t36h3rQJCbzeRgb5HsXDEZ?=
 =?us-ascii?Q?Cr8zRaQSb3GtkKtCzzKfhGW0eMq+Au13eJKHrjW12fM//wt65aHGFOj1oC07?=
 =?us-ascii?Q?DFTVlvk44YyaiOVENEkjSn8PbPFNsBlGex39n1UDTeYvOJC0QOFxFwbn/Ec/?=
 =?us-ascii?Q?UQzChyOKwW6dKgcwXNGsQXSKDLLH2Cg9xY2TtxkEF42CVIO5cBMkSGLcxT9D?=
 =?us-ascii?Q?QGv7holIlLx/gGRmGrKMD2bD8BOi772GgXWctLvy/nKPOjWXkj59A9zP2H0i?=
 =?us-ascii?Q?xEzUaIK/kmYT+wZVg3qX3RXhAnxC4fiFTbrveXF/J5Hs/7eFBDTWelpaNVHh?=
 =?us-ascii?Q?yp8AcaHTmwb/duzQBOXHCdPNkSMQrKj5+QeN/dJk6b0Q/Hi5GZNxnLdmy2ml?=
 =?us-ascii?Q?znIkzX/Rg+JED86qumoosT6d7cJKj6tL1M5eI6v465e/fjG/5OyYUfX4UxQG?=
 =?us-ascii?Q?uoFxR9iVDyTaQWboDlSIjOGLDp8TNLruXIyO6JspoZuhVDPPkJ7RwHe03llf?=
 =?us-ascii?Q?wJZYow7hA+SFRXxoAvR/CaGmZOC3+CtPEl55mgzJseAqp0Rf5Sd2ayFxSDQm?=
 =?us-ascii?Q?KA5jdJhv3uCYpFLYDjbEAu1xUym9FVyaJkjDRgplDj48N+5hNt+ndmmGTe8y?=
 =?us-ascii?Q?Vpbp+atD6+2kZDG+n53eI5XhiwaBmVOonplGrrwfK+YUa8tda0jlWMjnqgEc?=
 =?us-ascii?Q?IgJoTyLSPX9BayM2xVt8+7UG/2l2br6EP6w/BzhSlL1W6ZeVopcTubQvomgg?=
 =?us-ascii?Q?XGdYe2OxPnrK3mWwUkGQxdJkYVlMvgVO1V4/iXVWAWAAZMTwzInc2FHAoE0Q?=
 =?us-ascii?Q?pM9hSj6Az6Ze5++ReR9h6x2exWVi1DRhjdXuuxmtU5VLnAeDkdWaVexGLfdP?=
 =?us-ascii?Q?ooIC9T2h6BO7BLkAdAhbHocRLYZlKtOduiVOwLsINcVrqWMpPyHOLW5laJLp?=
 =?us-ascii?Q?BKVnCuiwUEaV/i2gVAEkq3WYbVubN3rsGBZMTULIP41h041ka2rUkjsPgCqh?=
 =?us-ascii?Q?eVDkribgzWzLzPTDBVAHGNX8oA9szW5n7od5/DYEn4tmsPSfyDVUAeujggMX?=
 =?us-ascii?Q?kveDcPBJdH4DW6eUhoeJFTdLVWKnCaxXrvXPGTSQFUZTt9Dk6bgjSoCWTahe?=
 =?us-ascii?Q?pZgAchVUNdQmnH7H2QwSBX+QdLLz3NRFRWUg9JomqzZB2BfruC6Apj73qw9v?=
 =?us-ascii?Q?Bpze59MxxmLjxDnz7B8Jex/et5+MPZMNXdtZN8qWm0/3kLasXnQ78DSVfE02?=
 =?us-ascii?Q?g4TpgEvrL4pYnaIU/GMMR8JKisi3KZJWM1iFiBOs4mjK6hkEOAivpNMlVumf?=
 =?us-ascii?Q?21sMHL+NxFjYLEdfY7PjQ3uJBUgy8KfAtI2FcWrD1ku//ykWNKbIH4Eyk5M4?=
 =?us-ascii?Q?R3n3lS5W3NfND70lFEonrosbNVw9XxKRbwzofY1dkBjGg2AnNaUrnw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3ZOl7dnVHzM/6amYdwTSCpslEN2w51tNPTk5bAw8LrOjnl83GTXSJJUWnqb?=
 =?us-ascii?Q?DjgpLdP71p66e/sKw6eEfbNCPlYsSAr86EuQE0enlxVrKbqRlb2r/D10H7uG?=
 =?us-ascii?Q?km+9cTjPck3IgIt3CGS2LkBCsSS+j1dNTal/BH8PsPWGP7xytt1uXexRILXg?=
 =?us-ascii?Q?joGkv4OeATcFN+RBpZ2VuHOPf3+KqmqHXPNe1h4lF4+P5juTWJkykicRGPQa?=
 =?us-ascii?Q?RFk74mANroswV3h7gIBkYuQuwo+Doz8z97jC9k9endKMCP2DyPGuBj/CpR47?=
 =?us-ascii?Q?MoXuuIAAI50PjIvZOdG2vMmkPgBDhaIymSwZZXBlxBJQ67rkemkB0wzIWo+y?=
 =?us-ascii?Q?TbotdCej9eOXkPc8qUFD6G4+7h7v7r3NvanQpzYM5u/7RB5839TgaA7OV0/R?=
 =?us-ascii?Q?NmUQ2QfEm1z1QXvnEqG1h6OGT9/PJsqSaCQWueEKJdeMS4L5X4nbXXbejDos?=
 =?us-ascii?Q?Kmmr+iWcTsVbOQk7D5gH3oMe6BGhZ4f659h1E4eJY7bE3D0NIY+tyfpeAVJB?=
 =?us-ascii?Q?7vo5W9lRFFS4/tpPhiaNb7vv1qIrT6I2Pbz8L+UK0+LBTck/LllKou/crL4B?=
 =?us-ascii?Q?S1vZ+x3KrLwziQQDh9OYoBM3xH9bcskOBWUy0Q+lwSdHL9c1Z1Lt5BDYXvG1?=
 =?us-ascii?Q?rmNnT+YSUnHLRkC6L4mlLUgq4YYgiNPo6j5ojR+6WuTr2UmPDq0xXZg6nIm0?=
 =?us-ascii?Q?Yi22WEDJZyYR2mDMK1113KnGVD02zmn3yIxrvrkgxKqsHEkgyHR7LoR+EM77?=
 =?us-ascii?Q?xcnaebfcHTRbS5Pq/PX9wpD3zxsJjn39JlOWYZHI4jQSmoOEye5IlEsr8LE9?=
 =?us-ascii?Q?K01oY6deYcMgWPlCtTDl4ii/gEGJMYEU7j5slhVlIQWJ52IcbiWORpNjM0nk?=
 =?us-ascii?Q?4xVwFIA0rzdCzQS7OLV9wJ++lJLoIDxSQ9/x9qrxM2ctf4FYPQJo/DGA5ucn?=
 =?us-ascii?Q?LcBOaA9OgxXgMBDN6dEcXwwW2Bnip6THQlSQ9351ISyicVsnl9pU1h9o3q1g?=
 =?us-ascii?Q?nAlo6ymaGV8L6AtC5owSElrSYKo9lcTiWU+rJJTun8TOs2QO0EId8lu0QhNX?=
 =?us-ascii?Q?37eZfxVB3iE0Tw/TJ1Fwunvj0EOPWaRs1do979lY/Lv6N5ZlOdK2+/znWgKf?=
 =?us-ascii?Q?vQPoQrl0YLbzoxtiNeZenhZexR4iWXgDnkCcxjTpFhzK69y0+PQf5X3zjsgz?=
 =?us-ascii?Q?Xvh66XuSP0EnUO+1uTF/5Q1rIj3oQV7sLpJFdgcjkOZyKUYa7lW3TLKKZqjQ?=
 =?us-ascii?Q?ft9L+nRzDsb9oRGyEfJUhpKL/JFjzgVtHFLFHvn1xmlj01LQrrUfGt77G3TA?=
 =?us-ascii?Q?lnVLqv5IZlezJMTmTPhD/zH3tefMbBX8XgRq4T16HCoJM+cmOP1tgkUGAuVy?=
 =?us-ascii?Q?XfORO4zWq32svQQWQWtUQ634xHAClJqgah3mKj8LYiYgtloOBn4z6JHJKpOh?=
 =?us-ascii?Q?da5GwvDnmRWyAeycwAzSC6pPr6NCkzr3xBqZ1Fn7DHdQIxd7MbcRXJyx+I8N?=
 =?us-ascii?Q?HKzzJ/0Cn5Ef/h1U5JANGFgBw2ueHzYsBg9s4pDdQzToVBq4M/JcZDfm4/4F?=
 =?us-ascii?Q?qVTkgHHXWp3xvPTW8+XyCx2KhV52O3ncEjTetzs5C/KThUCC9XRiIqYXDmDe?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3c2878-d899-4d57-e6de-08dd7662f223
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:02:29.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4FAwk2YdcUrWHkqccEZgVwJfahrGFriPfdWsH+Wkj8vZ8tNg2RRnRgKGchPGDsP7Y3ED8iXjMtZcmHfp6eivqPsaClHRg5BpFHCFAHJiIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5918
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

Implement the logic of get RSS algorithm configuration, also do little
refactor to related functions.

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/net/nfp/nfp_net_common.c | 84 ++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index 6284c54f5b..7f1ab70d9b 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -1919,6 +1919,55 @@ nfp_net_reta_query(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static void
+nfp_net_rss_hf_get(uint32_t cfg_rss_ctrl,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	uint64_t rss_hf = 0;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4) != 0)
+		rss_hf |= RTE_ETH_RSS_IPV4;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4_TCP) != 0)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6_TCP) != 0)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4_UDP) != 0)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6_UDP) != 0)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6) != 0)
+		rss_hf |= RTE_ETH_RSS_IPV6;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4_SCTP) != 0)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6_SCTP) != 0)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
+
+	rss_conf->rss_hf = rss_hf;
+}
+
+static int
+nfp_net_rss_algo_conf_get(uint32_t cfg_rss_ctrl,
+		struct rte_eth_rss_conf *rss_conf)
+{
+	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_TOEPLITZ) != 0)
+		rss_conf->algorithm = RTE_ETH_HASH_FUNCTION_TOEPLITZ;
+	else if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_XOR) != 0)
+		rss_conf->algorithm = RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
+	else if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_CRC32) != 0)
+		rss_conf->algorithm = RTE_ETH_HASH_FUNCTION_DEFAULT;
+	else
+		return -EIO;
+
+	return 0;
+}
+
 static int
 nfp_net_rss_hash_write(struct rte_eth_dev *dev,
 		struct rte_eth_rss_conf *rss_conf)
@@ -2024,9 +2073,9 @@ int
 nfp_net_rss_hash_conf_get(struct rte_eth_dev *dev,
 		struct rte_eth_rss_conf *rss_conf)
 {
+	int ret;
 	uint8_t i;
 	uint8_t key;
-	uint64_t rss_hf;
 	struct nfp_hw *hw;
 	uint32_t cfg_rss_ctrl;
 	struct nfp_net_hw *net_hw;
@@ -2037,35 +2086,10 @@ nfp_net_rss_hash_conf_get(struct rte_eth_dev *dev,
 	if ((hw->ctrl & NFP_NET_CFG_CTRL_RSS_ANY) == 0)
 		return -EINVAL;
 
-	rss_hf = rss_conf->rss_hf;
 	cfg_rss_ctrl = nn_cfg_readl(hw, NFP_NET_CFG_RSS_CTRL);
 
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4) != 0)
-		rss_hf |= RTE_ETH_RSS_IPV4;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4_TCP) != 0)
-		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6_TCP) != 0)
-		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4_UDP) != 0)
-		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6_UDP) != 0)
-		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6) != 0)
-		rss_hf |= RTE_ETH_RSS_IPV6;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV4_SCTP) != 0)
-		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
-
-	if ((cfg_rss_ctrl & NFP_NET_CFG_RSS_IPV6_SCTP) != 0)
-		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
-
 	/* Propagate current RSS hash functions to caller */
-	rss_conf->rss_hf = rss_hf;
+	nfp_net_rss_hf_get(cfg_rss_ctrl, rss_conf);
 
 	/* Reading the key size */
 	rss_conf->rss_key_len = nn_cfg_readl(hw, NFP_NET_CFG_RSS_KEY_SZ);
@@ -2076,6 +2100,12 @@ nfp_net_rss_hash_conf_get(struct rte_eth_dev *dev,
 		memcpy(&rss_conf->rss_key[i], &key, 1);
 	}
 
+	ret = nfp_net_rss_algo_conf_get(cfg_rss_ctrl, rss_conf);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Fail to get rss algorithm configuration.");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.5

