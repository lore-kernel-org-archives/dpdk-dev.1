Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48637CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 05:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71A674067C;
	Tue,  7 Oct 2025 07:00:48 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
 by mails.dpdk.org (Postfix) with ESMTP id 4B17840689
 for <dev@dpdk.org>; Tue,  7 Oct 2025 07:00:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQae4elNXqqOQmSjoGXojnQwi3sxRDxiaF0kbW20DSTd8AQfNLi2BQSj0Xer5WImHCMwz39vAr2SaWYCU/Uo1q3rlzEEDmtx77B8Tn2UgGRUpoM8TQebi/hLy+HDZSZtDU0eKfPu+ZWHNeXTlPKFXESdq4IfBocrkrmJ1dAvJNHnI6EmNA2iomxp13X1IrmJXa7VWHzeFWv/QXveRzOLLcGsfmes6XwVDJF8bXVnvBAI/sTpnvo7h947TUPndHyD/Mncr15+4cnlfvpuaGc7R1i+W0G8eUTP2oFtTZnm9lrZkFvGAfsewlUKRpu84wULRYRBK+jA51Jo4eZ9r8RMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9aPcVSzrgRkhg+2y4j44YaJlogxmlNhn1RmuP+2zI8=;
 b=VQtS7pd8GClKNxPoqyDNiuJdxGYNoVM9uIm3sU5G4R9Z92NvWBxVQienDAD3GeVYJRkrYmzMAkbB0EPlWZHSTLzEcs8A5/AhomHl1PuS3xyH6K11zAdoC21hT3Ble6aurbt8WCynjM5pwRN4iTZQT8n3pYENMqoLRpWwx6oaVmnYlbHHjJEpUctFZFB6MtsJSEbIu7skG5lDG5EEDtSXdBpYlrErjnksCvly2L3S5Sv72bNg6LhqdjfqnZv1LCJknWSNzNawXjdZiIYFrnu5AmX41FW8VzhnPtOwfe+GsM3TpkI0g2op14BXqp+Wa7aJsWXvN6gm8iiYjDUNjQYGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9aPcVSzrgRkhg+2y4j44YaJlogxmlNhn1RmuP+2zI8=;
 b=asMkd0RI+EGarsnYjAUvAVpiWPX9et2XkoEFeMFfz8zADa9owx3GHvp1XSlGyd2HgXZLI9TqwLTOCa7SuftI3jgLTEI7vwO33Yt4x0TXYf8nTYhN7EHrTBb3+4fB57lDRKxnEE8h4//YtIkjrfZph/l1FX5eolhLgFqOOdH/Cvyfiono/3CmexRHAK4XAAqVQj3QSlm5iXw8a/LQnG5sdLRE250EpHJgaRIQDCiCHMUKC/xWWOudqcp/7C0BJ1xOjIlxzDzkPBhKuSQ3KZRIsDuygNeO+JMDchiHnRPvDOMKW8d1w7ubyQu5pEtV8BJpxJI0B+lQQb4MwlJpM0L/Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 05:00:41 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 05:00:40 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 5/5] net/dpaa: Fix coverity issue
Date: Tue,  7 Oct 2025 10:30:12 +0530
Message-Id: <20251007050012.2432449-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251007050012.2432449-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c627000-efb7-4df8-aa61-08de055e7677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3WbK0xNHvJdFXteDzcabkQDFT4t2/B9k3mzZQ5tk/oQ+m2aPZEaoC0NvsnDh?=
 =?us-ascii?Q?IOxF8pzICUMimJg5wqNRjta+8bjFWvnWhyRdudSNpQLWuP/wR6uqYVKWZ4iL?=
 =?us-ascii?Q?MgDP02iuUvAIN1BaWBb41ZpAdt7ydhkW6mQGSgzRRuncaZMTC59nxvYGl5k1?=
 =?us-ascii?Q?o17LLqK2WgWmz/rNmm1PFA2kFrTFgTGHJ9MVqbd6uwCGOWEKj81sp51ZWWar?=
 =?us-ascii?Q?4/iqpYuaAILn7AEvZndeGGMZI+ZV3ZOAYgKfchkjz6v/QwRVrG0OYXb0I++w?=
 =?us-ascii?Q?KIlNwU0tmAseuNsylGxLMytQD1k8PyHgO+tktIm41QqR0/9cw1vh3CXSySPA?=
 =?us-ascii?Q?X6hReuLxT79HzMLzkWbPw2DvI8j8yRsIV5SUbS3zcGzATLzDyv5v3S/CscMb?=
 =?us-ascii?Q?GuGCM71BP9CcaM26qv6GhaUqQr/eG4vTxzRfHWTtNVA5JYxE8qj0oW9DqgZm?=
 =?us-ascii?Q?wITSwkPjIPA8IO+m5knVX95eMx7by4qOJrQkXj6TDOmAHfldNHLxqkMjdb98?=
 =?us-ascii?Q?+E3gMfbZdph1jqnW36gkAt3NL+Oasxd6DGk3U4MEUDDJSbeMGEfptk/R7VVe?=
 =?us-ascii?Q?8Vxi4jMTju2azI13gM7oFP7aM0RciPwu/4rhcoaGJB7g+fY/6BRALpmEQJaz?=
 =?us-ascii?Q?psRe1sGtBASHWa2+w/Sj/ScjrpJRrN5G5uMcm1ZaJ01WOTyEmKoXtDDgkztD?=
 =?us-ascii?Q?wbf7DkvsQzF26OMmRYkQ23g20t1dmlrgtXNfWa2Z2sYZ87F5SIXRwQpbXRAN?=
 =?us-ascii?Q?QAJzbvfj5wwuShR4StGqHweuQU0q7ltsBD2t6T9rRa2xMSUULVZ9/JQiqcd1?=
 =?us-ascii?Q?opwmdHLaz1OTaLBDxAhDoxbJdUwSf3P7B0DCnhiTKyD+1P0JRz3AE2Xkg0VU?=
 =?us-ascii?Q?7dZUyNDjqLbbtEu5P0nAYcMGWIW0yDE6VIwdrersPW1aQ+6wzjMxbeLHvh+T?=
 =?us-ascii?Q?brxdR9iApyqgKlkw1tL3Q3+E6uAOKadQevtxdHZ+YJffd3mMLxZU+P7O8d3L?=
 =?us-ascii?Q?n45Osen+EdykvYQ3BSEk9fre/r0sYP0pPX6HDHVvSESyekumzN3iY7PiuTPP?=
 =?us-ascii?Q?xPieivnyJouBzy8B8ol4eDQ1zQ+H42T7taAZNqeqXeT2Nm/vNhReN3Kq0MrH?=
 =?us-ascii?Q?4RGnkdyUWFBZ5M/OTJYhasQM2/RrUMiZ+iB34z0e6MQg+kgnRkKJvxID+sv2?=
 =?us-ascii?Q?4jLkHF2LVJWnGsxeDXhsUDePdYy3icINaO0rFMeG+DBIwwboxj/rZKrKU15Z?=
 =?us-ascii?Q?MiqLSaFq13Dxi5/QSKyQOzHTdvGUWtMHyZ3f5ddDWkhxlZB56PmPXfqFdjHO?=
 =?us-ascii?Q?Pwof1Gp4eUEwP6IAhlBDxaNAOGZRGq3UPLaUL1eYBVv0VpdPGfg+YZ/Xmfda?=
 =?us-ascii?Q?Z83JHDWAjyJrxc/PR2UQq9rl2WLOdKtqsf0F9GFb1N5D5qKkYQ44u/mc3VAO?=
 =?us-ascii?Q?/88AnQLz/MHGpJFETe5ff1Yx7dHbeE1OAyIyn00zWXvr45cLtmyFSZQcxt1q?=
 =?us-ascii?Q?ErN0RBcv6jzrU0MFUrbpEKhBmAq2tgv+HvND?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nh0UY7UQqF2+CMTaIj1+cjs6qod+K1ZulXXY//rAalWddv3/hhzebMih7LFG?=
 =?us-ascii?Q?YtELGKJoMh1HqIHEeIKt0O5SW8U09sQLS3BPUVfXpQxtkRfMPYE3Kxk116BD?=
 =?us-ascii?Q?jlwRVhnoeblJgJCBgG/iheuj2IPjnjxsbZfU1XrRjy9x9+7CZ5jlXLOvEJlt?=
 =?us-ascii?Q?IUm5poUVs3q65rNqJRM9Gh0oGimfjOu/Zp3hJawsXbnnP/A/0nYnpbRD8oC6?=
 =?us-ascii?Q?v6LJ5326m3b6RtC+ds6G4w7Fdju6UC8c6CbzJ5/Ikx4N3D+OMedAydEX+ob6?=
 =?us-ascii?Q?z3AuUmvCipdzhVAXxB9rRVyvFffbYSq118NxcAtKOcwAOcE1BAWybe3z7ztp?=
 =?us-ascii?Q?chPJFkkdiaTVZBtjELi65RU0RJJbYfz3cPfsUR5yPtI7BlG/Ynt3lNSTGp4W?=
 =?us-ascii?Q?oRdO16lfKWRoPtTgQBjUoxamuQATiF+4P1GoXaR4ryNh+1uhMFYN6H2S8+JE?=
 =?us-ascii?Q?kSVa2g37AYAVF3XrM5fCq/BG02TmY84e8Noal9CYdnLkozi/YiUEHQHnb1/a?=
 =?us-ascii?Q?dA79LOybFSWt8PcKWN/hYpAdvTb8tmmkHZ7YtieT0zHXId+U3/yNwhKLinN9?=
 =?us-ascii?Q?toUD4UMbOdbzdZod0m7wC+amJgFNoC3uf4UxKluk/5E25XLyB/pfvIkAylDe?=
 =?us-ascii?Q?UvYtrwTCWZ4hsu2/nhR7NqB9BlpcQjjRZNhFvjx19tqc660ElnKcyl7LjKgl?=
 =?us-ascii?Q?o4Pw79jYzix6LaZbBxqoHB5gnQosH7jaYubvGxXQa5WlYeACKXKyxAg/4AC/?=
 =?us-ascii?Q?28GVHJR3lPLOU+AOxx+zUyiAZ4cjs0AK1Z2RcE0uXip9B2mkZxkoz0esMexk?=
 =?us-ascii?Q?ewyQnygaeBZd6b3/bLfEWzLWk94rAPX2IWLPOwXATQP2M6tSac5vtFKfGM10?=
 =?us-ascii?Q?9RB6TiX8oGw2n+QgLVM3Ec7IdScXuECzgzsMCdD80SZwqyGa5TbRpFtxDhOS?=
 =?us-ascii?Q?Bej3iQVf4TK3BMn3vOub/EeA5dyDv7Zv5m+aV1T4hsOVAD4czahczuDgrQoc?=
 =?us-ascii?Q?o43zHtTf9GwnqH4Tj4l16WYBAnhKOEcTManaylH9p3weVlFgcxfDRz+KDsgR?=
 =?us-ascii?Q?U4zEkmrvc1oNgm7qNc1D/clWGUUNCm7R0XgFlha3AeFsRFgCIH1B1/2zNb6x?=
 =?us-ascii?Q?nZ0oPicyPlTupmBr8v05gQMYu5B9YnEYVKPnk4DDwvGonEikASVZHCgxmv61?=
 =?us-ascii?Q?WFTML/OSYbwCzhSJQgKnYTR1WMEVxPUFshnitHqHB5z1XW5HKIsq5Y0IE79l?=
 =?us-ascii?Q?8fwXjyObs47DW05qo6cBAIPGSSQ6P/JZka8K7ZEPwnfXlc4uCFjytj1H4r3t?=
 =?us-ascii?Q?94SKsgk6rw7I6nFH1oqtYAd+6Nt0iNlPUDzb1UAn7FCVcqOjLzVRCukUcYoM?=
 =?us-ascii?Q?Ts+jhRIEWlg3HWaub4lcjmOs6ERjGIK/1GI87bvREMpJPAoZkhBaPFXp4jFS?=
 =?us-ascii?Q?8y0OqK7cOMMhfIu0I26Zur/YJM5jY42ZRYhfxNqtcCBQVCGzJmXL4mUqbAAf?=
 =?us-ascii?Q?+MB10BfKPG/xtKmGZ8lNZPwwuew4FIzHi5Rd84258EPVgeom5JrX0BMRFgDV?=
 =?us-ascii?Q?QOFhSzLUImNJ+q2kF6s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c627000-efb7-4df8-aa61-08de055e7677
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 05:00:40.8981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZtMQZzn84pJhzfOz52nhDjFI+vujKdyDCqqM4etgQTqRlg0uSvr8nQJQtpn6zlx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Fix Resource leak CID:362787 issue reported by external coverity tool.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 2a22b23c8f..417b9b6fbb 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2024 NXP
+ * Copyright 2017-2019,2021-2025 NXP
  */
 
 /* System headers */
@@ -889,9 +889,9 @@ int dpaa_fm_init(void)
 	/* FM PCD Enable */
 	ret = fm_pcd_enable(pcd_handle);
 	if (ret) {
-		fm_close(fman_handle);
-		fm_pcd_close(pcd_handle);
 		DPAA_PMD_ERR("fm_pcd_enable: Failed");
+		fm_pcd_close(pcd_handle);
+		fm_close(fman_handle);
 		return -1;
 	}
 
-- 
2.25.1

