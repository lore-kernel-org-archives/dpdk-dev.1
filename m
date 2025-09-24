Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EACAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F1140BA0;
	Wed, 24 Sep 2025 16:42:15 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9FDAC40A7D
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:05 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020082.outbound.protection.outlook.com [52.101.69.82])
 by mx-outbound42-195.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmGmz39Q9jaTzxBZhtTSaJ8xZ1rl/oe0ZGqMnIwPhzgRXgN59vFuLhCSmbB9I7YdOIifExUTHEz+CkFcGdp9kEq1+dMPBWY+nII+9c1HQOh+q+6SwjDKMiYesk/jX2yqbqMdAs09IUMVFCteSbkdflbwtr0hqbm8y2kydXFvT9AmHKFKDVZyIg1BW5ho49BoQr7wKmEG6o73j06zg+bYgRz+m42wewFUXSnCMmyJi7lReJch7kuMQv1U5ozKGGELNRPvb1Ni+W/Kx72hXIsuKS6RpFJO/ciLqHPXfmpjjGEShNWL8T3WAAOrn/BMZOnEODFIQ37u8ZIReum9qpkTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWmm8IJSpEknSBDuQLBuHiIF87VOIq8lAB6dpwAXBio=;
 b=GyT6A+sSkmou8zx/Uxp22K4m0rzFW+HvbcUx6Hw20J3rsCeWvotk2COcgyRu2O9Aed6Q2bbxbgro9tnaHgpK3/w9sqBI0Z+LygRb4TEVwZ3cnxTO2gnXswTzlzOYu2CCE7IrdzJ0AIUvmljTM/PAxlR7Pk0/K8LkGwSfjQZ+bRqDQG9udGDBDlyYVmcvmFNlveLmwuq9ZE6q+2xCJFj34N+GmwKAanIruSCWDee62CpJMr59ViQW3zXbeGWaaj28sQEisdQn0yjzjcVrC3chGRPlZ2i/4Kks8P5+j4nrWiYQvv9gsGSIkYH2eSauqibEntOzg22U22TGjiQ6iNVgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWmm8IJSpEknSBDuQLBuHiIF87VOIq8lAB6dpwAXBio=;
 b=VgE4lRiL3eB/UtkyHo5ujzhS/jPKDiXgh3VT/qJJOWUYLhdmegwJpVjxB0ziaGI3ep6hWA+e4lrQmfb7eBB7EVCNMdBV4//xP+ITR/5SzIyAeSGCnxIXpOSgtnafNlXfx/Q7IYRxIUNrClRG3bSlY8BXBihtO5nTHClViZlb2lo=
Received: from CWLP123CA0236.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::18)
 by AM0P190MB0579.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:42:02 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::6e) by CWLP123CA0236.outlook.office365.com
 (2603:10a6:400:19f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:02
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v1 08/24] net/ntnic: fix potential format overflow
Date: Wed, 24 Sep 2025 16:41:31 +0200
Message-ID: <20250924144152.53203-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM0P190MB0579:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9d50f51-3a3c-4387-23a3-08ddfb78862f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBMp/Whyb5CBir9KgjOKl8blu/jEEn447ay5zs8iKb9Zd/S1htzym/+bVpVt?=
 =?us-ascii?Q?jqehWgHgTC1AxHCZtlRb2RfMoxRsNjA+p/bNvD6autvGLTljsY5tqZDpapv8?=
 =?us-ascii?Q?0QFjZEYe1t7qGEc8yPgXzoDvlR3cX2ihUwUbMoW7nxYpTsZvHzCNkZo4kE+H?=
 =?us-ascii?Q?vsVyPY2s8ZOBwyV87Ht0OfyA4Ts5Day6u+kaEvrlA0iZISafCDy6kmPoGLmQ?=
 =?us-ascii?Q?tf5/BK0utOlCljbeV1XbuLuEUv3QmCV53ackHg4ttsiYGyzBa4pKI6UWLBTg?=
 =?us-ascii?Q?/lTPE+esy3gpdMAomFqdx05nuAc5m5kxghQ45ZKYbsaqx45eEdvDc3+HmJOK?=
 =?us-ascii?Q?Uj9EF8gSQtUzPWOc5WzEBmK0Frl/9W1DSrYbtu3icDcyXq5f/iAJwW40d8Nx?=
 =?us-ascii?Q?JHziU9kDPDzt73jgbfgf41/Rp567zJ0A2CnXWhVHq83Tg6ZM+10bm7+DHe4c?=
 =?us-ascii?Q?7cUp2a2v+EW+KQx8x0Ow5Jbab7/YUEhAhwI0NnRleG49/pAYFPFvX9i7SaKx?=
 =?us-ascii?Q?LzLsqAWENf4pC5U00RiK9alT5A9FQxrmDlPqxk3OUjY7ez+UB2gxyLx/3FKT?=
 =?us-ascii?Q?x63/Wh591n4/ATWBR/OO6PaqHPkE8CrmPi326tPYEDkZGXx1SEhVGPnbJBaT?=
 =?us-ascii?Q?h8oSIE0MaOwQEEiupYU+8LUVwXxG+fnlCPHJHYAuEW/PqrAcZutqako1jTE+?=
 =?us-ascii?Q?wzmmVFDzw/RQZH0TxUO7oIZd7dMZfsNXjxs+a3qcq7/tI+JvhtOAto5jiEvu?=
 =?us-ascii?Q?DDlcBDMk1+4xTz/I5CkidKi46WFRtmsG75YJPF8B4+8qftAD9+srsPI5jrs8?=
 =?us-ascii?Q?vgaKOlPX8e2ANWeBBrMLc5ol86Wu9TdalR5A9Q5vCofLgQq+gjI01u30eWjo?=
 =?us-ascii?Q?7qJOEzR3a5mFDwwiE60TaQjMVipa0bdE0/8b3vzbQUR/vNUg4o29x0jmYRcl?=
 =?us-ascii?Q?zEmj3MkGtFkmuKVfwbeoN7V9ojokYxwYdgeTczSeHIs5GUQQrylWbrgIeLA3?=
 =?us-ascii?Q?4k2LSDr0fYZiwi4Ls00Nf73sPaWeEBmsZJG7UXdEtnS4QSNS7YoscAOAw/25?=
 =?us-ascii?Q?tArkAjAxK7/8WXamU1i9Z5OnsLXjsSZzAZRc50Y4x/6DbtgC3MRlG+/ni4/t?=
 =?us-ascii?Q?RRJTb8Q+jIB41PKmDJfQlvDbY0yoqEMasgaBO74nCMtp68/QG+Kwsd1LxchR?=
 =?us-ascii?Q?QD6DPZzUz5Hh/ih7XnItn0C/MQ0uC6MJAPg9m/i2eDa0IZU5BPFcFk/mE2o2?=
 =?us-ascii?Q?mw7yh8r26BEh89v3qvUIGNQ8r/sNvG5VY2WS2rz4uRXHplCF9yWns4AYNIbH?=
 =?us-ascii?Q?kznhp2f7Wa8cyRyYWOoXZQ+mNdniHAar8N3dbumd75V0+aXfaTEQWTIbJ+pc?=
 =?us-ascii?Q?t45EUSAgqFQO0STBOuCPns4m8mRvtzTK7eK0JY8C6XnUeA0mbz62i6cDUTqT?=
 =?us-ascii?Q?nuXEvrQYpJ1m5WDPbVhb/H+EGkCMkRryE8NLs7y26xrAR79bXRVes3j9eCGj?=
 =?us-ascii?Q?RmMUP6kuCU9xBe7P1MsHGUuLLZofyl3zhIFw?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oA1OlCuI2xuH1TtSkWOkUpGoa8MhPQwrUGSeKw3YlnjKp+02qtJJaGEZo66E8jskQY41gQ+yQfm7pSmf80NG+R2SRZfWDChFyxdddOYZMTYwsHBTpFJDOtsrpNTVcZuUKo4/96e1COFuSakHaW37NWoFIGjhN35Hnpzn+ydsdfufI0/x6Nzr/bWTL+OVdk/KrOqmyTWpUI3ZLucjD07sFuwyygfJkkL+JTniuKtPvuehpnXhGIRke/ti0hPUQFAIDKzVwmScs/Vneb9apHq9ZgTaytu4fMGYNM+RSM+3cbEbdQeIAeWNDvwnB7+Jy4sz2sF2NQBTpwroa2bN+XvQkTPj/zpljfLZlR1Mb2GDT7lweivsLkvbk+9Awm5bgzSCwk4oq9UMhKMwLzg7F89FRUWK1zI9iUGH78UKlKHgH2tKlg+h+0AEzE7/B2H09W/ZLQtCovOsIx4fo7dk9uNq/MVtL0LomBrViJcAZbqAduCKfF8hKF6XSw1cdF1JjD3OqbS0wqJgSgLfh2r+sC8n2So9EnjHOwqaovQ/70+7bH2GTNRYeXPc0Pd2Ljuq4K6iePkHkeozYyZqnGbLsGYFAF0F4/+DLDQ3tqEzNdj8lI0X0Q9Nk4VvKJdkTRxHjc3KyKkVEu7uTbM3Gjm8Ex58lg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:02.1197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d50f51-3a3c-4387-23a3-08ddfb78862f
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0579
X-BESS-ID: 1758724923-310947-7718-8045-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.82
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGhsZAVgZQ0DjN0igpLcnAJD
 U5JdXYMjnZ0iwpzcw41dLQJCXRzMBYqTYWAPILKU5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan19-50.eu-central-1b.ess.aws.cudaops.com]
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

Use snprintf instead sprintf to avoid format overflow

Fixes: d3dc362770d9 ("net/ntnic: add adapter initialization")

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index a867e7b16d..58be82b2d2 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2613,7 +2613,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	NT_LOG_DBGX(DBG, NTNIC, "PCI device deinitialization");
 
 	int i;
-	char name[32];
+	char name[RTE_ETH_NAME_MAX_LEN];
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 	ntdrv_4ga_t *p_ntdrv = &internals->p_drv->ntdrv;
@@ -2640,7 +2640,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	}
 
 	for (i = 0; i < n_phy_ports; i++) {
-		sprintf(name, "ntnic%d", i);
+		snprintf(name, sizeof(name), "ntnic%d", i);
 		eth_dev = rte_eth_dev_allocated(name);
 		if (eth_dev == NULL)
 			continue; /* port already released */
-- 
2.45.0

