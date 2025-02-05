Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B097C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2958B406FF;
	Wed,  5 Feb 2025 11:46:25 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id A71194066E
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:14 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLmQ2f14eJmNXkP0irR/DpIyBsRV02SalAuAGdcBJ7lg6056h3xmFA6SuNSLycyRwSlHnHDIrRdp6RsLC9cdHLhSXO54KX9c87vmGDXjTrQflvohssJzDd4qLb8jP381l+4ZJdw/LLT5sPrSSgGXwQzkOeHiPXJKGzXk7EQAfArVCULTgqcy2ldOlgXRiPzragkS/U5siZ2IWBHgRmiEKOGcA0FHqzTJuMlypzTmdDK/MfntKsqhu+n/KS0aKu5t9kEfDG0lNL6QxtW6DohhQ/kAzDeLDw07EwdRcEeOrLc7YqiJF4notvpATStCWgAPfBqCGtTmZlcl2h80id2vLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJxaCw/5VKVmAxtz8bGsEWKB5cwzmeiYjrivuSwRDPM=;
 b=FZY0X2GUscGzFjQE40bAbFE6y/2o9BHOCdZDD87TtVVN0vUim04ofpM0XODfKPZliMJFu2Gg7KXPEUtZ+m3YDDr5zLflVH4zBDgzhV5djmZZra7FQ92Dwm6iPIhCR5K/SPucAAQhCkqhCAsScE6AQvGtw6356T/Mzj9QeLpAjXV41fTI/ZVBcW0NdhwJTdvl+GtkHFt361SrqtLxRFJKLB1BXbnRzplsVzCLnP87Cq3PGHbFC8+/RWoXFZvtavxSLDfhjRIM0UJVRsgviHCYdE/fy89eVEUT4DZCzYnfhKgN6oAjFidPqY2LRHsdmIJJb66SKChzFVe9E3NNw9PiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJxaCw/5VKVmAxtz8bGsEWKB5cwzmeiYjrivuSwRDPM=;
 b=OTCbJJzWZCKUfTsy4eZEiiYSx9IaGLbuldTdMOeZ/WOtBmkNzU7pR2IMWsCNcB7zMwGd0rJ8U2sL4Z/VUdzlfzWrCo916BVO9Z0QVHCS1tNtSJJ4YUuH4ggjaXzr36Pp085ZwIDkWygW+T1PfenyMFoFNL6nKlmBRVNbtx9fG/M=
Received: from CWLP265CA0360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::36)
 by DB8P190MB0617.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:125::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 10:46:11 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::80) by CWLP265CA0360.outlook.office365.com
 (2603:10a6:401:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 10:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:10
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 17/34] net/ntnic: fix var overflow
Date: Wed,  5 Feb 2025 11:45:26 +0100
Message-ID: <20250205104548.1533554-18-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB8P190MB0617:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5e50d9ee-dd3d-49ac-fa65-08dd45d24db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S3XCRuzMAN4qU63apgPaaHV4BCpsO0atpekqS9ZugdQ4BA4hqXeopzlwRZYy?=
 =?us-ascii?Q?Cp/v69XDsCGthwNALf6OZfdvUWJZRMSTLFCY5pS5fIHrK5D/jCFhFX5sPibH?=
 =?us-ascii?Q?BOxNg1YBibvOxC8zujz0mwhaqFZxeBDjPBqx0TwuafuKl39YEy2lLKTTpEMX?=
 =?us-ascii?Q?jDX5tu5eKEkp5Y84I7/rYCUlbhfLdNifsUE7Zb/lAy5xpCUCX8WD8X98jx74?=
 =?us-ascii?Q?p6in5uzF3X0md0Q+zPQFctcZPUkLRfFR0nIVdv/lGKJwv2uSSBJBrClKdGRY?=
 =?us-ascii?Q?Xeje2qjQ3Ul3COw1tUy+bHfXehEcVuBe5jh1lxDMsMtoZK0UG8kDP6JKS+My?=
 =?us-ascii?Q?d5WtYqyMaRiayowqPGIPVwDUSpabLDTenVWrvHDDIMTweHvjW0/uTf5CQ8O2?=
 =?us-ascii?Q?KwVOvo/dGjHpam9My/48Hhqnl+Zy6iMKBO5zgrrwlvqSmGj+pXXyn6s8Z480?=
 =?us-ascii?Q?Yj/26uC6M0liA3mXN/RT8mSCjciO7FRzMh06mLxY1H8/vK9XGj++8Bz/mdJa?=
 =?us-ascii?Q?oGSNDCRTr+z4jbSTzwCXrywsqRVFdWK0FIn7aciPiMioaTX0JImGAWsilx9v?=
 =?us-ascii?Q?LyeMdHMDbvDA/9nmHfdXvvhp22qJ0GQvL9E6xco7VIJJ7KQilwBlmu5SljGs?=
 =?us-ascii?Q?D0Kfjfy/kcbsvzZTVXmPMnhepwOQNgo111r/oxlzA4PGxPugVUmCLeRT6fgo?=
 =?us-ascii?Q?FiQ6oVNlw3vAtUjnrAbjt6W8kxWDCs+Q6UekcQiR+IiOvi9TOHFY0vCMEbw/?=
 =?us-ascii?Q?GUegbgFVqiIOLOrUikKF25T2/2p5E/GmtPWLCIp+eTPnAqxqUK2+sHtK+64D?=
 =?us-ascii?Q?rrflNRwqbAubZGtLUiF03Q08YzsSFuNJAG5luTacfeSId07/rl1b7Ds2mH33?=
 =?us-ascii?Q?+8se5zrqUWhYFvxZDOTCx6Evvtuxb+JtqcdCo1sKpBv4xVtZ1xV4SkQ3Td9i?=
 =?us-ascii?Q?jQevsc2YIjOlot6ALkk7TBiGKEMnrcrAKzvqlQXeRQ/Yo6RsRgLqX3TIpa9R?=
 =?us-ascii?Q?akZa0tLYIcAiVU9XXJBxKgdkytWcfOo+XiaS98NhCUNpCefj4Cz90SpHDtgU?=
 =?us-ascii?Q?wf01YCPTg4kGTEbJlkVwey7ei9mJLiXpwQtE2ZoFfzjXdl/iHT+JFhwm0qoo?=
 =?us-ascii?Q?AKbz7/nI+FfkjufE+wJpv/0yujco0NgWV5bJR1kTLggQBJnBVZKDMuBe9MZD?=
 =?us-ascii?Q?JIocBp6vakkuCDD4pl7S23QqmB4onHYoqU9Qgta8CTroj9YtA5OuYPtPzhxq?=
 =?us-ascii?Q?TggJieunHKq0xnbL0vWATTzdkFOTHvllk8MIkYiOi5vsYfCYfLh8xE4rz5j5?=
 =?us-ascii?Q?k8mk0V2tmTws2cZKXqBPXSKO3N5IMEe1FA7FtHTTdhuqivmZ5ulxqL1mVGD9?=
 =?us-ascii?Q?KenpIbdQxeWIU2GfoRcXfRPMYMF5cuG/bSSehVey2PZ5HXoppjQPeP7FyklY?=
 =?us-ascii?Q?DEhhKw77fyVqpqz6unNcg0m8slj1aDwCCX20PSJ0P5yWWJerVCnbzIeDjNIL?=
 =?us-ascii?Q?Tcr1E2nUvgIDu2M=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bTtg+U0lolgGEtDErnU3FTdhgXV2lM7hLv2jGSR9J94itYk0Z21C+odzlmHs+T/cgB7edphCP29c32H9CR1gQoXbWv4p0wOoYaIRaQDSWcKEg5UUvy2XfRT522xALUcCfj7PjBqXwjvkxKeW0LH7C2PnGwZaWXGCjhEb5prB3Ck0VraG7kPxCn1WGwU8gh+X90wgS8DolmJNNl5/fKkCoH5pRoi/qrHiRXdHhzG5Rfd1lmZHyC8JMCe8F6gdLYhHyVm907P/e1NeXU1+j4PZVkz7vHyf+S2bpsoVtICpPwjiabm9CtOqp+UWGUPgpxRUyffyB0CHBVdPCgVHF21FyX+JiJ5fl0Fu2vYnij+NPvADIz1NUiBqkfQVevLLNTizlVKgTPH6YdyleMhr3LPPlvxFcxSCiCVKlhJf0rcf86p6GEVDgI/NLtGtFm3j/61HM7wnyzWUUu/I2etZV/MRBIgCYWBP4JtRhtjtln3d/YDvpabsq/eMAC1GP83E1H7Fw1cQ3HikHmDQe9pP/85Tz/oT6En6tI4/KuAPjE+BAbOWWPZsxoaZA7L6/40E9osgW9GMQHxMKSFyXMTx+mroJRsLH3EuTy6aqihmwPMHJekDYs8WqV2wPfmzgZtJKPMFrxQBc6osu5+MqitlDEQ/Lg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:10.4489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e50d9ee-dd3d-49ac-fa65-08dd45d24db8
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0617
X-BESS-ID: 1738752373-302364-7587-660-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGFgZAVgZQ0MTMNNXYLDXF1D
 zZKNXc1DDV0CQlzTLR1Cw1Mc3CxNxMqTYWABa2FPdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan11-114.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Casting either buf_size and num_descr to uint64_t before performing the
multiplication was done.

Coverity issue: 446740
Fixes: 6b0047fadf41 ("net/ntnic: add queue setup operations")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 28b086c009..6fcbb8fa9b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -790,7 +790,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 	NT_LOG(DBG, NTNIC, "***** Configure IOMMU for HW queues on VF %i *****", vf_num);
 
 	/* Just allocate 1MB to hold all combined descr rings */
-	uint64_t tot_alloc_size = 0x100000 + buf_size * num_descr;
+	uint64_t tot_alloc_size = 0x100000 + (uint64_t)buf_size * (uint64_t)num_descr;
 
 	void *virt =
 		rte_malloc_socket("VirtQDescr", tot_alloc_size, nt_util_align_size(tot_alloc_size),
-- 
2.45.0

