Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC0CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4DF3410D0;
	Mon, 20 Oct 2025 18:44:08 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id B767640A7F
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:48 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023103.outbound.protection.outlook.com [52.101.72.103])
 by mx-outbound16-13.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muKLuf2EfHHLU1yIRpaCKP2CqFUd57ZWnIoxBQlklEtW1Ge06Lf+VRoemYbm+c1crPsYcsyx3rnMOGGH5dLNXSH7ra6c9cZUSb8vzr7OT6gfekSyo2kDhI8s2og3NTeNe4uaqsBKCG9egWEipAcHofdk3gs1BlX3pTCf5eADBLd0hta0skKxcAL+bn2zvljfAIrsbzp4zdKGUqSZ9RRkwGY1zvEhz/eb7Uyy8BAh3XC2Mtzr7a+R4jnV8o49xzaqyyv1hj4KTZxzARJb/gjssIDPGq6ZjFa29IQtE0CfXdPouYJZq/CfAL+J9UqhTP8aFgDPQoJK2+VqQytj2vf+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWwWprbEBRSOxORP4LRNj7gxqAU5zUKefrBbHXYrBTM=;
 b=pgOI/MOQBqQ2EfTqCzjNX0IZMWY59pDgrmzgrHQFokoVY23RzzsET+6J314kQ+D1FtXE3sXzm0MG85FA78M4yZoIE66jF6Cid3AqhdrhyRiLm0Y3M1R6KLkAukufZcuM3E+LgrUlNJRE8sbjAYqOz8tFbo+51Sx6K1i6kDSGD4wBEnPXLuzDbfGoMnYLR6fBBlYzYZsRRjHYpLKndH09cXM299YCOyqKNtrUAj/9T3BRKuykKNJSvKmcpRKIKzMtAQRWpHG91ldQL9ojBXcSWrIdt3K9mQvJvSkm/GvLOxBNBD1fKb4hrtIhxNaxByOs4sv++IeCUQ5mCK7F+k365Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWwWprbEBRSOxORP4LRNj7gxqAU5zUKefrBbHXYrBTM=;
 b=DXVvla2RDFB9Rtu0sUa1j/1CVv1N5xZ9dkH7i4W29LlktkFIyJ0Kd7Sx9PgV8C+pXTfwxGHYrdU3i/b/C5nIQnnS/QyLP/edcJA5Z6a7qHI86DGzUtTrmV0lusWVCpBuZtcrHYZ8sENcZgt8KjooR8jxjNQHDmefY090P/wdh+g=
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by PA2P190MB2127.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:403::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:43:46 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::bd) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:46
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 10/21] net/ntnic: add reset init stage 8 for NT400D11
Date: Mon, 20 Oct 2025 18:43:19 +0200
Message-ID: <20251020164336.283664-11-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PA2P190MB2127:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d66d005-f504-42c0-a27a-08de0ff7d6c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/rrHuqsZpMc5+kP5bXcxb5l/6Uqj7U/jwtOquCKew6SEDFGYvJUfETQJ+KfF?=
 =?us-ascii?Q?sLPsWUrbc7TqhAgq6mEqxOGtc2P4amF1k+E7T8BmPhMUWJ6ps6blf0sTGbvl?=
 =?us-ascii?Q?Mt9E56NU7Nqb/cQ63fJJ9+R2pibMU4z0KfJbmBJ3tR4YKEccXHP1oxWvQ+hh?=
 =?us-ascii?Q?Su/REVmiAxnDojTr2ADwqqbMSeXco9VkD4+JsKcGsYWx9K3FZSVXOA/SShgZ?=
 =?us-ascii?Q?YVP9fwMLIGzaQ6M+X2IPVCB96dcXS0ZCMQwcibOdnlEGl6JGNqWeQb/Fm5pa?=
 =?us-ascii?Q?Zh8E1TEDUUHoJ8SdRnL6mv47ykhhyiO8oo2VkbCyOFyyJSd5mQq2TLzNTK8K?=
 =?us-ascii?Q?OENPGAdWkLt95eUckJoB2X6Rafc+3M44t1oy26mA7z65cpmvpknCDNsnHwZa?=
 =?us-ascii?Q?NNxh4trTTA1HhxB4utF8wbfMOVWDoAo/xaZgiI5vMf+7eLBaYHkBfYSfdxD1?=
 =?us-ascii?Q?KYI2GYjDtz5DlTC/vjCjD0SrbctyF3YldmL+zd8AQos2z64+05Z8z0PhMoNp?=
 =?us-ascii?Q?m/GD1nfWERV0DhP/d7agfJ+oJqnRcoRWh0kXQt3BEmKMn2ZUMRVyMgnX34kq?=
 =?us-ascii?Q?bV1VjozrDl+PAHp9d8BH0qQfm9LBXuElT/eOYV4hWU7+LM+jWugZzYYBElVj?=
 =?us-ascii?Q?s8Y11+/0oR1JS4nutjW8mjsgnH0C13ygosVEqAhwMvzgHosK8OdQL4FRGOS4?=
 =?us-ascii?Q?gWKzeO426VpRiSQVuwjkStfe+ok6mP0FolIxO9nLjhMdOTKNeVqAxs0AotvY?=
 =?us-ascii?Q?Rb45w83Rv70e7AAR8JuH75wLnm0Mr3Nb2cZjdiIJkRT6/MDIwv0dSQ6RJkXY?=
 =?us-ascii?Q?o44MJKj2DNT4514buQmpm66eVInY2OG+Gk2va5xQLcjXdoy0wvGDsCMT//ST?=
 =?us-ascii?Q?wlEKCNWpqSGRSh98rkTWnOJd9zzk2oXZ2uHVvEhevi4vTeFFPK0ScZYvAdEV?=
 =?us-ascii?Q?b9cjyCElAS1FdpMrxzJGmyDZU5PE1UqVkP8wUSy/G+viav/VvuindazX/pzT?=
 =?us-ascii?Q?S560WyaapfVhbzvDQlBxrL0GT1q5QGsuBvAB1BMBGmoQEl2X4WdPY0dcomqT?=
 =?us-ascii?Q?U8wiNBkA1GquRk4GflrWkJjDOBhM4lgJ3nmC4vD360P9KxUHlLMHfM3ulgfr?=
 =?us-ascii?Q?+SvBwYtm59281LoYziz/4Aao8qs3TGU4vhE9d/Tt4A6Qf70+YAEBhF8soNm1?=
 =?us-ascii?Q?ZoufFECfFC3C8ebQ5PHR7FFrmY7qvgdQvL25GnK5Yx419tyjl1Vk9jIEDnDT?=
 =?us-ascii?Q?bYpMSzQLFC90NdKj4RNZrGHkQFolG8kXFrJN6/n460UxTAtSnGXpdQ3CJect?=
 =?us-ascii?Q?mmGcvP80Sym5w0kWaqiZHKcY3w09HcR6ohXjhdhHX6vjGHfbZVb8CVfsOOWz?=
 =?us-ascii?Q?s4CLpW5l9zpLsRPUeEkziwZZLC9NbhhC622WK5A5/rgIGEoInby8A77wDBBD?=
 =?us-ascii?Q?C1anUq1iVtdXDCi0nFZfH7PZTc42w7RAMwh4xkmqAdTXOriv1ZJay+CujR6J?=
 =?us-ascii?Q?FgBQRkvkV0CBAVs6lWOlu0vLeashlz1wV6Qkz2R9m45fqnfko/Ycq3vgNDOn?=
 =?us-ascii?Q?TVku1lk1nv3bld5QMhU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yUDt04YFMsY2/LIz4eo5VhX2ry8v/RU1LT43IDCU8kT1CWKJedH6YgLhk7BilUIewsA83ZGs6VUEhZfKTA0XLX19CeD7MdgpBmMYvS7QS0AoV71AaA5lC6CRgCJl4jkn9KAvAsk0ZGbS8Z6CzCCUzyU9tppXnzVbTqpQimN0ulDADlwd0yCn83aYyLGdTWIjb784PZvsoEmeynPwb7LEK206e8Ev3xAITde4KQz9T9wLTeWqEj8WlQD4m4tRCtSIp387vmTyYUFYmib3VJgECVvHVQgDYhVms/XtHOXUt2VJuSvNp8WLEM79J/y+C57HYaUY7ZlH5+OiNnd/+t3N7HkUBdX86OwUPSqfTD5BYQRu1Wic6DXGfK3nJW7vLJOOSO+wHGTIjL9300Pvc661MLHXJClyI0el+kjEbgSMtrcEYp44nKewUUUp3oZ1Ya1nSmHm2ZDTD5+te1faarTqRdTM2MUT+SJ5WjBtwPjDPLqpT3KGKQLDw6oAb7jEUxmZRhYfCQLcwC0gxs6ui5BLK8N/m1Uf1ov59AfeCwFy5sZzma3xVMpv8r2bt2A0s38qzyx+dMR360POsSOWqzt7M9JyTMOn8fKRKNAqmbyrHDyCpJ/DF3hJt2NPS3Sw87smG7Q6PnJzDTvnv5gc6zj+spcP6FrywF8w0L8SmbiALX4=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:46.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d66d005-f504-42c0-a27a-08de0ff7d6c1
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2127
X-BESS-ID: 1760978628-304109-7614-117820-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGRuZAVgZQMNUgLcXAwtDI3M
 DM0DI1yTQ1OSXZ3MjANDEJyDEzNlOqjQUA7qZbe0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan18-209.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

add De-assert SYS reset

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 29e32ffb22..f2b064f054 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -73,6 +73,12 @@ static void nthw_fpga_rst9569_set_default_rst_values(struct nthw_fpga_rst_nt400d
 	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
 }
 
+static void nthw_fpga_rst9569_sys_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_sys);
+	nthw_field_set_val_flush32(p->p_fld_rst_sys, val);
+}
+
 static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
 {
 	nthw_field_update_register(p->p_fld_rst_ddr4);
@@ -345,6 +351,10 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 		}
 	} while (!success);
 
+	/* (8) De-assert SYS reset: */
+	NT_LOG(DBG, NTHW, "%s: %s: De-asserting SYS reset", p_adapter_id_str, __func__);
+	nthw_fpga_rst9569_sys_rst(p_rst, 0);
+
 	return 0;
 }
 
-- 
2.45.0

