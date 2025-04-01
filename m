Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69227C36018
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 08:13:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 356DF40DCE;
	Tue,  1 Apr 2025 10:13:07 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2137.outbound.protection.outlook.com [40.107.236.137])
 by mails.dpdk.org (Postfix) with ESMTP id 2D2044067E;
 Tue,  1 Apr 2025 10:13:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSgOjOemX4n/lHTncsQ4WHKSnbnOXd57hhX+tyrqCs+B3XdWgq5E/ALBoFe9M5n3EAUcrK6JeN02ONHEyHD0JohakI570kH3+OhGRM3rDgOArBmiYJ13uKkP8IA9mVEvdygw6QqIXxqnD6Z4WHi219zUXrdQk3See2tNivXxHTxz5ip6SeqbbEZTEIAX0yaQhxKgtkJFmSRDURDCqIGFXP1kp+dJYGf+TV1wIzgpeqgv8oJC0LUU/LjWJawoC7hlSQrteBYT0/+A+A04YpxUd+cIV3aoIdtHFAReaBJz7OzVmgiRnM3GlKJhqLfm1n8zT46IwnFYowCIN+JvPK3txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvca402u7BPQulmY4fgTMOlDr+JbUTQ9UC9d79J4E94=;
 b=X2YoZhNXEIecJv/m9CvdLjqxwXWrKF8g4kTm5a7ac2X7//FboLEo6YS/j5+4dXl7PKCi8ZPuBeNmgbv9bapyIuow4PumqrymQDfynpanurB23Nl7ruwG7gnyQnGLUeYHkh/L+bXfwF95GTDQTXdZFGQPR/fMKywZFaOdQUYhIRiczphjsfwSvCziluSXKrU2atjWEL7qF4jdrUx/9U5LHMckq3P5KNui57RvDNp+JYfHKOz4cOLG0phjf5N42IaKZa2+mw5pRyxiEpvfWqpPMqTWWlo2AVbY60+rfRa6/l7DQKeIvUYAxEVuaAiLlR5LRX54CHwZlv0d8lB5mQP01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvca402u7BPQulmY4fgTMOlDr+JbUTQ9UC9d79J4E94=;
 b=YFGt803k4VO2ul8aoQ/cBgKEy7/5h5Eg6KyFafy2BoxlqviAnIOwivKHX7Sm/Brk1cvQUy6fwyWvlKu36p+pZ4yRed21wJhu/oZA8mZQCQZPPaK9dDUEZeR7WBEJunB9gc9R2hP44GTu5thTTKFLeO9ZGtTZ0irqXlPTH9P71aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by PH0PR13MB6107.namprd13.prod.outlook.com (2603:10b6:510:29d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Tue, 1 Apr
 2025 08:13:02 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.030; Tue, 1 Apr 2025
 08:13:02 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 stable@dpdk.org, Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH] net/nfp: fix the hash key length logic problem
Date: Tue,  1 Apr 2025 16:12:35 +0800
Message-ID: <20250401081235.4127956-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0182.apcprd06.prod.outlook.com (2603:1096:4:1::14)
 To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|PH0PR13MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: c6467648-c7cf-454f-6162-08dd70f505aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PbmWMBcS/81LPwvHVInanULzh9I6Rxm17J52aBV73nVuLgYbOCqJd25W7e7l?=
 =?us-ascii?Q?YfyHey05shd+5IAcp73W3bwbJ8bsjczrTPq7rZj6aCjxtFtffc8xntIOXovO?=
 =?us-ascii?Q?zbrAKP6fm+nlS34tXlCmXk042hZatZzAos3M2p42pzQWtP4MbNfIAz/X0+8h?=
 =?us-ascii?Q?GH5woS3aPpEFtrW5JbeQ8/wsXmy7dsjAI0Tq1606mk3p88/IDyvIlgLHDsFM?=
 =?us-ascii?Q?mKO5/55rEiK+LAGGoP3BdEP3Bzjg6ZWM0GWpiOu9TjoFdnQwXtpLph59+shp?=
 =?us-ascii?Q?gQ2l1id5ikgQmjgOsY9TFnl3HyXziX1pt+abvbCAz4CYi5QHCrQWWx0c11qv?=
 =?us-ascii?Q?XgEdiCSbpJxAPUeMwtO/xQCpdzkDkFht8/6n18BaUdSPQznRkv2lhDHxws1i?=
 =?us-ascii?Q?TxR/GNbSyELaA9vvXuWKngmX3gJH0bJpurStU2UVs8QMl2075HWr421nu8dc?=
 =?us-ascii?Q?o/X9aYvJE+SgmdwcDWHfjHDYatGwwaS10RnR7+vqkElA1ceTYBOOXriC1tQH?=
 =?us-ascii?Q?WhUYHtUBnmWx/w25C6fzvU8QeuMeggAEESwCl+NY6QU2A1vuYnOLDCzgU5DB?=
 =?us-ascii?Q?CynxFKTq7yJ4eirvkZgEqOp2UETxnfjSxQlVigNUUZEMAtkvH9BJHY199lw9?=
 =?us-ascii?Q?qcGtydtiYL3ljtESyKPldz2oDoAiLiKp4ZzZbiPG0CwpzdPqXqccKCxaTQfC?=
 =?us-ascii?Q?crNQVPBjaTAar4udXoLa4aqCV0I4h0G6e5U7tR4va5cljyaliwGZo6csS1X7?=
 =?us-ascii?Q?WFYN9TYRyVgfrvG/BNyXSGEpkXLy9sc6/XOFA+zAQO4hJZmzCyEpdOXTBqbh?=
 =?us-ascii?Q?x0fCPXKypEg58+7UAr5WLp9RsZvYC0FC30m7EJEe6ZRriSTcWFTFEnYQtmjw?=
 =?us-ascii?Q?P6qk0gOjWqJ9+lR1GU7VeCOOS8X7ygmsm6zvtVu1Hgcs3/xn9NdXGxslCbiD?=
 =?us-ascii?Q?2h4F/EcHPMspoDkCGZmnCYSLGKBidmChLZRpqWKCoRQx8vZG/EmF64EiROrh?=
 =?us-ascii?Q?XX6am5oTiDrnELGyywONyIJQRPE7L7QiYltK3O0OhRGLkAXMWuioKei0kGKf?=
 =?us-ascii?Q?k5BfsalpOt9AtT/wCVxk6+Rnj6OWOTu/G8q6rcvaXG9GvdMlZBPkk7y3XVF4?=
 =?us-ascii?Q?9YpVgNROwD/O7R7e2UvGkl/dcUXi1HApchaXvGeOsU1HvC+5ICRGghz4E2Mt?=
 =?us-ascii?Q?TUmfDtsT9iJRg9xR+UScot+n8JzlxNvwqgSIU6aKF10Q7cQ0t6R3O/YC/lIb?=
 =?us-ascii?Q?MbWfEqYbpbSQG6iZ+TrmstD7qHqgcvlZQJn6x1rpK4c0wqrlhhmt5oZ5D6OM?=
 =?us-ascii?Q?j/zE1Y8eQmbyNe0RpVwmcOTZ5NehXNGmuYcagLUVqFIARARvaXz9d0GBBFm6?=
 =?us-ascii?Q?4qDS3nhBYvot/WJw9O9jhohn7is9C8eXO7AlkFpt670j8YGOpGTVt1wSsEH2?=
 =?us-ascii?Q?H8qZlpeS2ZmPuM8e/KEclpzgAnCcjq1+xSfOsI9Iq2ibkNfkrnBM0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YONyf9B6D95vMZLqM9sxad/s1MV5WPFPpSPBYOCsmR2ltQPIVpVGQTnAuwXu?=
 =?us-ascii?Q?9H5U2P0o2zSIqu5nUeqaQDvl1Y68P+1F1uSEfpB636Lk9InTsBY8yzdMaZL5?=
 =?us-ascii?Q?oHvvykfJh20WjTzbJv1ke/h67ppSlxm1qX3KN4evpvtu1sQ3YHaECrhMHTgC?=
 =?us-ascii?Q?2oAAVfMwt7h1hg0/n4Y/ykh24S1VSLGWJEoAJPpLSra4hnNtRjPfgcBxKBgU?=
 =?us-ascii?Q?ZoTVpVw1FbEEaFes8x0TTxOQ11owN4Ozo9Nqx4zGhg/aV3JvE9OEB7g0sgbr?=
 =?us-ascii?Q?IEWVTLUjXiDBlk/IuSzBzDGG9z0tVSX8eGq9xh0VXS6HKBuwkhgUwg4D46TF?=
 =?us-ascii?Q?tgX60hCfdSTDcI+vxQZJj5ycbWm17xNxLJUhwGAU+py+NsNMYWRhNrkS/rpu?=
 =?us-ascii?Q?eKIWVy6haQOcwgh+kZZiZQY3wK9iVOA5x5WWjYgCkePs58Wxlde5FXoe6y9V?=
 =?us-ascii?Q?yaS86FwCpBKgkxjXBxqrn7ixsfIFwjgB5JALuaUTJPVPnUtVwvUUZ0z/CRan?=
 =?us-ascii?Q?voZR/xt+8RnZYyPNYrywlGSom0zog+6Nj5yTFD0h0v++2NUM4bFCDdpStx+U?=
 =?us-ascii?Q?d3AI2AqDoHY8vJBMdHA2Ia0+qVwCDAIbESY/8kLE/2INao/TeB1Iukdv4KIn?=
 =?us-ascii?Q?nOTDJt2Gs0KCbGZYxVaDmNr/pXQKFJJ1raj+PlPmr8C4ycCJRC2lfKzcx8Gx?=
 =?us-ascii?Q?Jsgmhvy53DM5VoopQKsQiOFIo32+AcpUXfCAafx82uL5RKkThTIeMNGPVaq0?=
 =?us-ascii?Q?vIXUmvvw5ANsRLhNeJVeEVwWr62ugwTKR3jW1UU3grRFxOiqrP2DPpViO3W/?=
 =?us-ascii?Q?3z48Jr6pI6xDcY88vcv/AGbMZCcU/pgTr5NhY/Nw3ujCsc8C2dCSJ8ONk3mn?=
 =?us-ascii?Q?4IOvIP+zXX5XryDe/MT1dj6k/euIGrta6UaqVauDLIjp62UwZ5y7G9K4u1SK?=
 =?us-ascii?Q?B3dcrrlutc+wEglZ2Dq+teVMgyxGgqRtdAPuNX3KYEx4QLkffIFzO1gLa4ud?=
 =?us-ascii?Q?JvQmS4X+kxzuApuZ3wgezSlWEwZgJL2gMJxZUh7ZHB+9m+so8xvLxm9bFuwm?=
 =?us-ascii?Q?u7q83d3tEKLrDdTuhg89kwyhRDOyzGGB45glZW3R03cY3khD/nXAhG+c0Oo5?=
 =?us-ascii?Q?fv8mX8sI88/oLCZ8YCutEdkNLiM6babTewgX+m7jAnlbdEnj30FkKKeyuJ0j?=
 =?us-ascii?Q?Ddxa3p/MBpgPvuSFCmG8+EUSU57CqGgvQI/DgQhdbAJMjsYacE1hYWQSfvOR?=
 =?us-ascii?Q?Blvv88unDthsmhoTv2lVNFlH/4yyO1pJhOu3k8V1txRMwh+J5A+8NAw1xV4+?=
 =?us-ascii?Q?+jI/5P9febwNyIZVqQqo2efhoJdmSmM4aqVQ3WGnkAjcPJ3+XTUI5Qn5Jo9Q?=
 =?us-ascii?Q?5mbTB4RpoxeJUaiTMIuc6cavVi78gNqXKo3AaJ+Dwi5Rjdz5jWAnUxc2B3gc?=
 =?us-ascii?Q?iyfIfq3VS719ZhMcMzZ3OGlcLOGboFb0NY2eXcz5LHKCo4csUAlLri6zRC8L?=
 =?us-ascii?Q?tQejnPHL8CiJVouXeZcSc2ZZVWGyG49t01UGx5Vv3X2pqjUuUvcA8mgrWa40?=
 =?us-ascii?Q?WOSJ8Gr5TK0/qXLEwNmy1hr0Amm3eZeLHgTHDpf/7ORhbOP+iL5FZASv0jmQ?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6467648-c7cf-454f-6162-08dd70f505aa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 08:13:02.2967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAgma67yR6w1CZUfrTwpbWvaAaeqOq61Ltu05ZtHnq6mRVwgcWUqJqsK2PfcqSRWeEhRlD3daSlAajVK4w5Dw/FDDTPr56/u+tClG769WOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6107
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

There does not exist an API for driver to get/set the hash key length
from/to the firmware.

---
	#define NFP_NET_CFG_RSS_KEY_SZ          0x28
	#define NFP_NET_CFG_MACADDR             0x0024
---

The original logic try to use the 'NFP_NET_CFG_RSS_KEY_SZ' as the
inexistent API, read from this address will get wrong hash key length
and write to this address will overwrite the MAC address unexpected,
which will cause very strange problem.

Fixes: 934e4c60fbff ("nfp: add RSS")
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/nfp_net_common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index aaa515bac2..62550e4cad 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -1966,9 +1966,6 @@ nfp_net_rss_hash_write(struct rte_eth_dev *dev,
 	/* Configuring where to apply the RSS hash */
 	nn_cfg_writel(hw, NFP_NET_CFG_RSS_CTRL, cfg_rss_ctrl);
 
-	/* Writing the key size */
-	nn_cfg_writeb(hw, NFP_NET_CFG_RSS_KEY_SZ, rss_conf->rss_key_len);
-
 	return 0;
 }
 
@@ -2059,7 +2056,7 @@ nfp_net_rss_hash_conf_get(struct rte_eth_dev *dev,
 	rss_conf->rss_hf = rss_hf;
 
 	/* Reading the key size */
-	rss_conf->rss_key_len = nn_cfg_readl(hw, NFP_NET_CFG_RSS_KEY_SZ);
+	rss_conf->rss_key_len = NFP_NET_CFG_RSS_KEY_SZ;
 
 	/* Reading the key byte a byte */
 	for (i = 0; i < rss_conf->rss_key_len; i++) {
-- 
2.43.5

