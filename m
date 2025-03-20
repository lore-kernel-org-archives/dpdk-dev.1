Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DCFC36000
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 08:37:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 209434060C;
	Thu, 20 Mar 2025 09:37:29 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
 by mails.dpdk.org (Postfix) with ESMTP id DF9DB402AF;
 Thu, 20 Mar 2025 09:37:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBGCFrVkGysaOdbB+5a6oaJCjqYIdrOnMLkjadQ1qcXPdYUC+TIcqxA7c9DogIFjF9cQkF70RaclkK+EzebL2+r9c/toV080fMACsT9cPw5LCIoOMcGX88E/aMmOojiUrseqQ9AYOXxyBVmTbk6v2pwqJW04lod8tVquasDZoXUKeJ/0WsbnmgQH1gnvAmovqnPVu7M9OH4kdyYAZVvrYrnhZCqhzFmi+H09401AfJHhN9COfoClrAVSwqkV35obU0u4ZLFfrtiVeB+jN8SKDrmyTWfuSZoIBacDHEimEeAT1899WBvDnpa5fpdYyKRwxRiMt2qaiIN7Wh9vGnJwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhVkM4hWWblkTP5F8MS4WKArVFE8H821gWHkUccrwSI=;
 b=b8TYRIO/g4YsrbCwf05oAEZoM/g2b4ktUrhyvDUKKW1lH56aHeaxSGOj/QcGG6Fqd5LAYk0XBZyCiZNvAHYpp/wSM8LRZyCgGlNyu/QXu9FCPRMuczpu4lbSDTrENpV5NtsshNqelk/7dQfnDbEEplXVwoNLe4PWAZplz8n8h3L5r4m7MY5t2F/1t8MpNebIjORaUfmExpby6eh+P+NqtfwT5ecpuUVwj+sAWoywmo9FfTZhH33Zs4v3QvgQebu9tLfAxHnRFsr/1jMdVbeXb5T4AEFBwiw3q+PxtoJWw6LWM54gunOHFgWRVdgvq48HzlChiZmsYvE/DbPmNcNX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhVkM4hWWblkTP5F8MS4WKArVFE8H821gWHkUccrwSI=;
 b=gkny5WmrSZScrQVQivRU268P9SlCU3GZfkZDpPoSKbN/ztAivIEdU4Y6lAhA5bX2MK23MlbNK6QHY201nW8B1Ah3M1MFwOLzweP+S8AE2i2Ik2twdlG0SZWNwE18/49tV21dzCUOjO8T13ssmTpRYfOWMx+LZVWp2P49+WzMNmTgbKbHL/JxFqUyiqoT7WuAE8Q6WQayyTKXL+cLbK8ahShU+619RA0sjJn09SQFcr9gd7B7FsrNWBPzOR8V9VHS2DA29567epvmz0mBtMVypYkWr/OY3WO4uyCyIEK5fU980nFWZug5BQCJHpwIe7se3kagqIt+HBJRdktNYGXHnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by SEYPR06MB6932.apcprd06.prod.outlook.com (2603:1096:101:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:37:25 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:37:25 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: linville@tuxdriver.com, stable@dpdk.org,
 Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH v2 1/1] net/af_packet: register supported param fanout mode
Date: Thu, 20 Mar 2025 16:37:07 +0800
Message-ID: <20250320083707.5594-2-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250320083707.5594-1-felix.zhang@jaguarmicro.com>
References: <20250320081503.5505-1-felix.zhang@jaguarmicro.com>
 <20250320083707.5594-1-felix.zhang@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|SEYPR06MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ea8d55-5963-4d30-db22-08dd678a708e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJkA6WrN6P1IxWrPqouTrrFXoizzBqCk81uigdlYQEMJb+h9D8oXVbnsjFKP?=
 =?us-ascii?Q?sucZkQPfaMtqC6IaqxlHQnwtOP4t+veSjb9SpH8IRNQJyvCWNs2f/BGtb4Tn?=
 =?us-ascii?Q?KGvzWrF+nBgfs8sGNuwoWt9ZJ6u7yq46vOWMJKSTp/ng8Zh4wojjBOowk+KK?=
 =?us-ascii?Q?yQ1DzC0RsQ4xNiKMNKuAg17zHK2orKUs7DLoR7gdR53pNkwkuVhSr1Ll2pB8?=
 =?us-ascii?Q?enfmuwWQIVixQ4+XbCscNRsl/XvpyaHTCxElbXNyvpx6jsfRFCugIYbSL0Bs?=
 =?us-ascii?Q?vD69FdoHbM+cuV14xmRKq882IPIs2BzaToy42l/1+0NmDprmqR4sN7MhhtKy?=
 =?us-ascii?Q?TNFx+HmI9FKLI3naCc4uMOwD3lWAzR69uMwJH1DuCNavUxvoIPWNXQp0quIv?=
 =?us-ascii?Q?+nqaPWwuwsje87b7nla672rysjONEc7dTIA18haIPG7UJrppZkgOR3GyHzIB?=
 =?us-ascii?Q?KLNQYobp0UVZ+4QZLHdGOM2m9G0E4R4MaLbKO6iFqCZTJSklZH1cmnMhh3Qe?=
 =?us-ascii?Q?5LkbNsu0fX/nBm2x+7nIf7itwEaAIFJmT5zYW85x4740uRGDJGt+17WPX2Wu?=
 =?us-ascii?Q?h3ae7hVqPphpxFZao79j7B/i/U01uVIisOBcMa8vOJT18ea9Ctdr7ZOzk/0x?=
 =?us-ascii?Q?ZvCp36+XQX6ngDtV4T8/f39ajabEnO8tgdXCU1DRm0/QcuAjVLDwozokm3aS?=
 =?us-ascii?Q?a/7O167dgRqh+4ag4AHRSiJuWn/ZMHDv09DD0Tdyy0xrR+KhG5zrikNNKdNH?=
 =?us-ascii?Q?4IGRhN4d5yElurxmmFQspr9KR209tbIcRftDTDMTspXbDxENFj8LRIgstz5l?=
 =?us-ascii?Q?ZVgtcyiZ85rCKcH39qWy6o2Dqxfo8F1z4LUmnYuoiRO108Se2U2Qyh/xbXHa?=
 =?us-ascii?Q?lkRBZDJrxEw2KVzi3eqgAEnAc5aWX9jy0gb+zLtDfFdYWNIU6l+VFHThuJeg?=
 =?us-ascii?Q?CF2VHINsGJW6K9bJvTYHExWBpY9QoEJW1Dc/5EgzgkmKOGgIozz/Q0jyd+nA?=
 =?us-ascii?Q?AH9lX1iPHdR+nSRoOuN2xXJrCD1NNrjbkEPpXcSZgMUfb0r64ctWV61xACov?=
 =?us-ascii?Q?jf+e+rBxXOGsuqHJ4bu0xNb3p0ZW9tJ76SYFGwnrozq0fTRaB+VWJPn9fTxh?=
 =?us-ascii?Q?IoEhKWWzq6WY4JuIq5K+D18Y2K0Xh9JuI0LVnL+9C/BhKCnGjEmb/IbGK9PU?=
 =?us-ascii?Q?PulONgDogNsTZ3b5mB4z/nxGCBBKqQNVfBqNl28dcChWC5guBfL4+XSlynr+?=
 =?us-ascii?Q?y/8Xe4TjKer2esLeGY0hOZ3jzeHZdIhZ6hqCkmvDgVMcylhZ+mj7R9XvHdn8?=
 =?us-ascii?Q?Kg/32ZfoJOjFkuG43PMeVHRC4ZANYwaGJrL5oTlzIMHtbB/H5kgRGHEbbJsI?=
 =?us-ascii?Q?UrfqSlkdeK6lGlF59vBsMME1BjTUCG8lKbWbALmUxj6u4gSbVcf1Xj6mnXO1?=
 =?us-ascii?Q?ju5yaJvmiz5I9lCmyGIV4Kj6rsQC98mL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TEKgSCEek85SM2kS2YPIOFBUyuQYBS6vS6fYDDZbzEIi7HhlWulPVIRMRNeM?=
 =?us-ascii?Q?yAmnA7i3O+ZyiPkrCy8+yZ2by1udPixkXbAeVgir97k+0tj0rvKB5BcfE0xf?=
 =?us-ascii?Q?lwaWSaQe2x+ITHIqBONAy3An9nSng5cLtYAk+7UP3c+BaA50NzKUi/Rup/j0?=
 =?us-ascii?Q?lp+uywCvI+yC9HNExD9nx5Lo+LXXY9OysPszw6Zh0yt6lcY0HNUzLXbYVXhq?=
 =?us-ascii?Q?ACnsEFrZ+oOrUEpSehnKkZXGA7DSNhuJyBn9AJKtVRgSZV2DlZ/IxHl6XJV/?=
 =?us-ascii?Q?NV8I07TOOqHVcztqPppRcNrE61rYFJRYaqCWw+PSPZESdvOZeyCtwms6bdSY?=
 =?us-ascii?Q?OZBkzruWeOLPsAUcdJi7Pj7ScPhYD9Ms1b1kJnLVIMUaYAFLYQgrfmiNLRdA?=
 =?us-ascii?Q?7btFTbHm7nS2bT/u5CPMd+R9t/c7TjUxq3TnzQ8N0n93tKTaI+xBWfL8eOoq?=
 =?us-ascii?Q?Ryjgccbmn+7TCuMs44XWJRbogzMMgG/BzOigSMeIdNHDHr2cSnOyCCUghTcQ?=
 =?us-ascii?Q?8sLSxtgv62l7Wl6s9XxRKXeJl8x95Ev+6O4vUc+/FnDpAXLrsGJFH2yAJhre?=
 =?us-ascii?Q?+ImqFbr5MG06ly02FoPWMURY2vN8O+ZqilTftezZQhFtcx2Q1f0ie66hhDjL?=
 =?us-ascii?Q?FNBROXeAqbLJ2hdJJC/A14Nu7mdxYdvLgDGimt3k6mFG3Tn2yeARIAhNQg/W?=
 =?us-ascii?Q?ynG7KLwZpdnqqxN+bKe4vPQirH674nKtMLhyplhfuEvMas0gKuAqhYIbW1sn?=
 =?us-ascii?Q?kpHk8dU19gALzMqXutueezghDOt1IhcebNo1gcruYWPZ2ncHOzsQxVe9g4si?=
 =?us-ascii?Q?NrCOYEzvKUgy+42bprrdmVSsfPfAojz89zdA8mnhQSPT/zgsD2vtFQnGooyT?=
 =?us-ascii?Q?wX8R49wjalmM6I7VsRp89QF9SrCaivj3K04S2JmY7TN38TCwBWdL4rs0FAj0?=
 =?us-ascii?Q?ExiL3PwizmvJl8689LW4aHYTfu0YovODg0BCAv9eQ/ouTZpkxRZbZDXvA5ww?=
 =?us-ascii?Q?ENujT18dPqWlulG9lDSjpbqJGjtt7YmFuHqQwx2zMg5BSz3AXNBWJKRrGXbX?=
 =?us-ascii?Q?vbpS+3d9/OIUaSH9C3KE5k1DKnOyW7b9/n7jxchH+Nt5t/c3pgJ0g/9qvjls?=
 =?us-ascii?Q?ly1aFua/XLfVn35xcDxasRQcoH7YMT7daaBzrsPGeCw3A1BvKZ9cHkJQp6B0?=
 =?us-ascii?Q?E9lDI2bzM06RkvVwfeELXlfNt91mxRzXBhZvtvUMUTI68eA2gYlZFE0WOLvf?=
 =?us-ascii?Q?YanKKwTOoDdtb1Vr3/CqEhpbwbbI0zhzda0Tnm/LtCN9ivykRP0xKPd/6KJE?=
 =?us-ascii?Q?KKAoA4ycL5F2dBs0My+eridav5hj1geJIUstN/6AWDaW/3sq1QhZmIsxM3kX?=
 =?us-ascii?Q?71+BM7JyszovYFDCfcNVN443rjE68kmIR08cqZsURnkOKGA4eXOXOnhjNj4c?=
 =?us-ascii?Q?TaBWqWi0orGEyiSf8vx+FLECczvW9uI4l1RaS+5EVk2wfUX38FnPV/gO6NcT?=
 =?us-ascii?Q?du4zchBlOvZgNa+pHt5AQIoiSt6S5xUnI0Kj1mEERdfCTqZWUGfuPSqrPMag?=
 =?us-ascii?Q?yERZUq7vVzns65njD/L7qM0GTXhb3a9Nm9JaqhUV+KIZAH304XRk3ErLYOVG?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ea8d55-5963-4d30-db22-08dd678a708e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:37:24.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIVpP99CTpUNFhRTTFreHVOeAX6lWDaNCakWcPpKI4RWkXZod4Y1XOKXcFV6eKBWNtjgJnHtU24BxKxpS/Bux8HrkyoFOrkCh/nShGlFH5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6932
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

Although af_packet PMD supports setting the fanout algorithm, it is not
explicitly declared during registration. Add fanout parameter registration
to facilitate users in quickly obtaining supported fanout algorithms.

Additionally, add configuration parameter printing during initialization.

Fixes: d3bc77ab05a4 ("net/af_packet: allow changing fanout mode")
Cc: stable@dpdk.org

Signed-off-by: Shaokai Zhang <felix.zhang@jaguarmicro.com>
Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ab34285ed9..55171944cc 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1172,6 +1172,11 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	PMD_LOG(INFO, "%s:\tblock count %d", name, blockcount);
 	PMD_LOG(INFO, "%s:\tframe size %d", name, framesize);
 	PMD_LOG(INFO, "%s:\tframe count %d", name, framecount);
+	PMD_LOG(INFO, "%s:\tqdisc bypass %d", name, qdisc_bypass);
+	if (fanout_mode)
+		PMD_LOG(INFO, "%s:\tfanout mode %s", name, fanout_mode);
+	else
+		PMD_LOG(INFO, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
 
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
@@ -1274,4 +1279,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"blocksz=<int> "
 	"framesz=<int> "
 	"framecnt=<int> "
-	"qdisc_bypass=<0|1>");
+	"qdisc_bypass=<0|1> "
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
-- 
2.47.1.windows.2

