Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CFCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DF3840678;
	Mon,  6 Oct 2025 10:04:50 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
 by mails.dpdk.org (Postfix) with ESMTP id 67323406B4;
 Mon,  6 Oct 2025 10:04:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy4Y+YbhPvVxjooLKoOv70rgp6b1mlLeTJ02jQUbL3wkd/IXRCFUpSfxwmk3D/pB0ufEBvO63Ysnlm4xHDgwuikwyOZ37NDgmo6/VhZQpMYQtKa2Q//i+1xJ3cYAqZfdETsWzH0hXtQHUD3hLrr0almNyVMFOe4nLTt2+vKnYw97Xl6nkH06eU+xyXzmm3W+QfcO9btHs0tJj/waWieQbfx0cwSfgpFw63WcyA5q93RFWfMHNAxp3eNMZv7fewPC36GGDOKjD6ldcdvlBKI138ThFu4AdysXU54WSBVS2RnCQcZAePlV2/Y7ciwrJz+G6bSR07C7A8JKL7ORpNcxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTKBx1SHxo5Y1UvqkVlbKuiO/pz3NmmBAMSwxAQkuNs=;
 b=AkYSDmLDZizmyegRm0TLq1u4ptS/pFu2mSzVgEZe3lWMylDN8zeLcuqmWA6JSN1xqVJ4pT2/fahath8i5Re1N7WKi25WF8Z9f5AVzCmev7/Vk87jFe3SYHOOA8HXo1zmYle7nuL6swEr18O+HhD3Me+4TZhSf04JGkZGaO4Kvtb5oUqPN3IGGBmc2dfzTkFJT/nJpQuZJTMmM5g561Qr2D08c14FunAMGwzK0iPkXXFNUhDaikjMbbfwe73W8k+fkydN903uR4CuB6KXs9BxQ7E7UQrnXFHQG444dwt8pJVCc/Jrq08ZdJvhzqGzc+/sGNTwj/GnlR/CDbTTUyBllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTKBx1SHxo5Y1UvqkVlbKuiO/pz3NmmBAMSwxAQkuNs=;
 b=SC9cvtF/XvHOQBgFMAvSmcT6a0pvCga1ZceWb8kWCv1qCfBZanB9RqguC5z1PTbWiUa4EaZ2+Urm0e9xLBhwvQW1Tk9M0HXPV4AALVvNLLY6RmOPKUlsOvpJKfIjFgxHgSYgCtXidJGisbFP8LR02MzZxhDIBLE/rAaTe9KYOSXy0hQ2j/raOB9CWnfxx1FBGwcGLbTo880R5XSlVj++mvvY8zarc7vms1bDSXwHvz4e0bzcq9C9L9VqjIJj9/O9b8wpSKYjVJKEYRYu1kBi4/AQ3oGN5OiSNP133ZlZPysiF6r3lk8uqhzwiF77O1hxD0EKmJGVChn33Z7p2LJEbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:42 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:42 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 07/11] net/enetfec: fix memory leak in Rx buffer cleanup
Date: Mon,  6 Oct 2025 13:34:06 +0530
Message-Id: <20251006080410.1433284-8-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad7de15-27c1-47b1-2349-08de04af013f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zkn3wVHXLRNTEtsfo08ORoY52wO1Kfsq7ksZSBwD/lR0qP7rX9uHjclV6sUv?=
 =?us-ascii?Q?tQkrPw+9t1uSZ2zzuUSAK/UB8bR+54dTspSj1MGZ9Xd1h4AQ+YUz7Q8ZdjZI?=
 =?us-ascii?Q?6dZdCUZ3Q75YJjzN0EHwC1Vz7ejQJybLhOtE3qQp6ozpxl6auSPz7rZn1ssT?=
 =?us-ascii?Q?weI58KJLGR6pESGgCfM72SkAZML/9z2HEVfNFag+kmfvz4m4vrROwtNsV2mU?=
 =?us-ascii?Q?L4yadYxIc7w4IV13a6FfT3OS7BmNziet4Li4TqWCd2RS/9amcEJ2YLZpM1ae?=
 =?us-ascii?Q?s64C2Abd7B/Kn2XE2lVZRTRrMMaNrPv/Lkzsej/uwytftoM22ePB01MZoUPr?=
 =?us-ascii?Q?ctcCWdh0uTkSkzELJCajHMkQc4d7BWBG+9HDFDlel1APNEQaPPtVG3pG7EFv?=
 =?us-ascii?Q?hZQbJINNkAZS43TiDY/GU2IbQDS5CIJztZH59BWuzdbajM3c0ItNt2Gg7d2c?=
 =?us-ascii?Q?oWuExva8TdGTGfwkCxAzFkG9pCIGaTaRp2tyZ2Awijn4IEIdw2Om051kvYIJ?=
 =?us-ascii?Q?iQbF3wACwh5k7gw2jARFGlSy48pvL9ARvM2bS0261Cr93fiFNCK/xAZXn07Q?=
 =?us-ascii?Q?IyD6U+brqCjULVskTze2L5nEQ4zwBN1xTrwv24IrlvD4eHfNWLz0oRBxvl+I?=
 =?us-ascii?Q?MCd+QB8JO44IqxfEVKdUYxLGgbtNMiiYcjofBq0lt63i7XtGidp/IVb2DF/4?=
 =?us-ascii?Q?1RtGXVrutzWohr4NZm1aGKZdJNpmmQsJ7nFJqp+ffoAqBR7z0QITAy/O8qcg?=
 =?us-ascii?Q?xIYJQn80utyoUEKpBRizJpoD4jXi5xaYMeI9WyCA3IzgiLO+xDO/qq8AkaAg?=
 =?us-ascii?Q?KoN5QrdpOv8UijJTCLqasL7cUiTVh4T7GIGu4m6lsNpkO6ipfaprDFn3GGOg?=
 =?us-ascii?Q?lhgAkZTb7HwJu0h9aPOe3d5ak+u8InJ/IaeXk44lSHYuC1iIlYG5aJ0gQcRp?=
 =?us-ascii?Q?s2fgnNKCcmI0Q7nCn89debBIrZ6H8d0jPeSTJl7shPRVDLXrNF5U4DoHdotC?=
 =?us-ascii?Q?SCJxdcNvE3kBCrJnLZwTgEELfN2GuRId6Nt/gqh5D6sVMnEGnyE4bf4r3GnD?=
 =?us-ascii?Q?gj8aokim7MeW22Mts7JXPATMruFyHCkzZ1aKHTfS03orqNrTPLa9YLhSoVJN?=
 =?us-ascii?Q?8XGjW7mw16UKMvIRe/0WMdZnF4v4fGrXaYSQeqV4JontHq0e4QgX6QRu1/vg?=
 =?us-ascii?Q?o5FxnPkoyjXXHccTE11JBIcr1eK3GOpQ333XthHEB8gLhuAM7gLfGglrROZz?=
 =?us-ascii?Q?5v2Io4m/jYIC1kJ0YwptaHaZBaeRUrMmV1kjFh1bhxvwVukbX/lt/2eeGD9c?=
 =?us-ascii?Q?99k2+MUkp+LOOTuHIp/gQadgDCdcyF7mzpT/3P6MeaPUmg5Bh8BWmH6RgNag?=
 =?us-ascii?Q?dExY+0cJEMMmWpPto3ZZjAxH0IzbTY1nyHfH5DrotGZ58cqVDjm5nILpNUwn?=
 =?us-ascii?Q?HiAA8PrHiL0vKBWFn1zsv4ylJTJzfoItyA2PBkt0cAvpyjNKXRgfmLsJEDUt?=
 =?us-ascii?Q?Oa341zxUu2iJ61b7oS2jD7FQx7bEPei8bn9q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MutlZ4tlrUSeQUiC1C8/Aubx93rp0eps3Rdf/VeBY83uSIPNMsFJNG7CUQ6W?=
 =?us-ascii?Q?D4Jx4EIwhrLm2sN6rypWeNDwpvAjvXMHjhiqVPm8FJ3omxi9svcnGTO5IU7f?=
 =?us-ascii?Q?AcoCGQ0L69O7kywV8eotmCn/ehBaLAuLiMjv4NlnH1j0U/JJYyXKvqp6z/+D?=
 =?us-ascii?Q?hyCH5xLxTbhfFPo48Nh5QUwotNS3fIqIC/tTTM4Rp8L65L/MTG0n02NMpv6O?=
 =?us-ascii?Q?y2auZ4HhktTVoQNx587nJlvAbbIZh1xyVglRiFmXcTzba1ZtsiE1YUzyNOGi?=
 =?us-ascii?Q?yABZMyAGwk1kGQgTrCeNQFjnS3IgW+3s1i31+GRTOcHHvtoIwbnzKhL3U4JR?=
 =?us-ascii?Q?A5RLMZA6eAdI2X3KR/dbpAWodp4AUTJ1MusVYpiWM8XiRzMgQhtrln/kusEu?=
 =?us-ascii?Q?tBClWINYZ/GGmurig2Y6TzPTGjm67YqeXmNBKZCV1rV7NKYBgIfsV91OQOEo?=
 =?us-ascii?Q?m3rF5zBAnyHOJRc2ji9BK49dx0sNStGrZRbewcHg6ZgZ8NcGVrBOFL8+sHOg?=
 =?us-ascii?Q?ggyGfO8rLIs0na5z+JvDbH/kxqiwgpmzQ/Qy8YqpOKYtsirYWqd0V0l3IF/A?=
 =?us-ascii?Q?2vyNrjqsrvOCs9wWugfI+UC7UpVNvPYvA6MgcZ9plA5yWwKHJ+0va/phTsKm?=
 =?us-ascii?Q?VEnoIrM8yrrqs4aLm3GiXI37TSVTAUv0u6scQ1OSGI4wkCjkfeJn1VbbHujs?=
 =?us-ascii?Q?ZI3Z61dE7btcNTRzyV2YcTlqua6fgWmW2GrvHCLyPlzv+hf+Zw5SuCgZWiK+?=
 =?us-ascii?Q?T3LzFSNEY9fVh1Ik8xkeugG/wYULWJtY1ANC/G0H1g3+DMmmjw72bGT/S7mL?=
 =?us-ascii?Q?lT7D09rC/7CttLqFkMURJuEMngDp/jchBdHS5+LmJQY+LjKxgp12+mAEiAwR?=
 =?us-ascii?Q?N23/5vzH31au/EKRHVa14hubssqKPfjS1U16ZH5/MZ9OyfXvy5t/wfLk9gDM?=
 =?us-ascii?Q?CbBmiYC2jDVdIjLOOum8FyWURC8vFKRdUmoM5hERx1Jx2NqupT9sBuS2dDlh?=
 =?us-ascii?Q?0OlhpSYplKYyPpGEXZjWmtOL4CdCQhWj1Q/Qb/8E0vWrlFiplzGM0sbgunaa?=
 =?us-ascii?Q?rphonS3wmgXSsYPb510ZXaSZpJ9FhE/3ITXoPgSp1kc2VkONXOEZUBbtFqyb?=
 =?us-ascii?Q?QrswTZuzoRqvUQqEwLE371XV9LZXnzHg757zvboOQ2jnSMkrwIf2M/uaVfWP?=
 =?us-ascii?Q?myLJJfg3td6JxIthcZiqm+8ZnkC8Sed+5icK9HktDJwoHVzS9Z9oL/0soQZt?=
 =?us-ascii?Q?nvks5Skj2vGXqKKTGWWulfAgF4lJYGpfANZ4AWNiDRrDhs+WbeNoS+t2M1K3?=
 =?us-ascii?Q?td0P/zKhl5hIq5xymVJ7X5ao5p6pqVmFhUvPHoW2mUgcKH4QtJ4QwJUxe0DB?=
 =?us-ascii?Q?zsxMqS3yWPGMwQ6RUBZMUcMNpBPG5XFbDmIr1GybH3tEaPN8HdB8qPNZXcPW?=
 =?us-ascii?Q?4wtMlTwcUrdHS4xrduOfH1bXoK1LwSOyuTXdDZalciCzxFapT6YZ/+7Lkt1/?=
 =?us-ascii?Q?Ui7Qmq1Z8LOqYXySzDEMl2brj8RL4DMCWQvYnug8eG17fhC9ipqOQZX/LY09?=
 =?us-ascii?Q?yrD0sELhDmCGBuBT7g4CXWwxoKV60SCoXRpfp1E0ZDajbRjTNK8f/jRHIJNM?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad7de15-27c1-47b1-2349-08de04af013f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:42.3978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwgHTUycgbcLxrIrlXS1gw/mg4FlGA6YSgppjzQMq10xgBUPciz8xcIb7M+bvnLyhtwuKr9pj3rmx8lwugv1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

The RX buffer cleanup logic did not check for NULL before freeing mbufs,
which could lead to undefined behavior. This patch adds a NULL check
before freeing each mbuf.

Fixes: ecae71571b0d ("net/enetfec: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index bcecab828e..60bb4f7ebd 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2021,2023 NXP
+ * Copyright 2020-2021,2023-2024 NXP
  */
 
 #include <inttypes.h>
@@ -172,8 +172,10 @@ enet_free_buffers(struct rte_eth_dev *dev)
 		bdp = rxq->bd.base;
 		for (i = 0; i < rxq->bd.ring_size; i++) {
 			mbuf = rxq->rx_mbuf[i];
-			rxq->rx_mbuf[i] = NULL;
-			rte_pktmbuf_free(mbuf);
+			if (mbuf) {
+				rxq->rx_mbuf[i] = NULL;
+				rte_pktmbuf_free(mbuf);
+			}
 			bdp = enet_get_nextdesc(bdp, &rxq->bd);
 		}
 	}
@@ -547,7 +549,7 @@ enetfec_rx_queue_setup(struct rte_eth_dev *dev,
 		}
 	}
 	rte_free(rxq);
-	return errno;
+	return -ENOMEM;
 }
 
 static const struct eth_dev_ops enetfec_ops = {
-- 
2.25.1

