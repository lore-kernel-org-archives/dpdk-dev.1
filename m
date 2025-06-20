Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A485C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 11:28:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7248242EEC;
	Fri, 20 Jun 2025 13:27:41 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 7D90342EDD
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:27:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
 by mx-outbound19-118.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Jun 2025 11:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzuMABZnFH2NW+c9/IphYcYBclTedSqE3U4NRXMI0JvQLhA8tCwFty1lMVKYh1ujNFV4CIYrR2ANzazVGuIhwdiJK9vinEfIgSv+LaM+IK3f/Uw9QyrA4uRjUArb4iJqESf71DfkyBGxPYWh2OsiZhhMct9bMCgsznxZtVAQmXd8S3Rvm9ezItJbE75FWS3QXKqjyPL9j0skdz6qhW514jE5DD4B6OqAKeJ5vRZ2ItKCVSM2d7uNZQYVJa36jWf0IXgeuptFu+dGlXeYyN63eT0YpAIQYGqUdTg5a/uQ2QYlJ6M7Whc/ASEICdzeslu7rTIaF8gDCeAz2Wv4z2CIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trQLzQrdWTJG111tIcgIGCVjk0E0d/t9NzMqaaFKhGg=;
 b=JmBMiZCd/guP7ArV+HxmWwZ8gTKkDJkLij5RGBP0viPHtUsIQUWcmBDAxGZRqLWRo+apD4KbyaJkjDKPCv0yWa5Mc/rsFCiBM2pxt7I2tE86ZQ2LUTxNaTVqlXD/e46PDcp6kUHROb5Zl7uYwUETkJchHoDgivee+vneFwj//pJ3bbncJ2hk7BP+I9Z+ZLLKU4jsXIB6wYROZROLf8TOl8mZ+iwXFKTtBzJ7JVxNSkl2OtfyOm3U0FSFCUzfORUR5/j3GyJpZsDjpQx084u/7ObktOHaXdaL//u6m8XDihape/ENXgrnqCgyahdA5nH/aSLLUNOFhFrPxhRh1Auzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trQLzQrdWTJG111tIcgIGCVjk0E0d/t9NzMqaaFKhGg=;
 b=cttn8slGlJsa76f5oFH6C0+T8cPMSIV6BUH0nPi6dwCZeqY1lGjlZlUG0pILnbfknwlQQ/SleeFbys0yOiVflGGEILfOZR8nr5w6W5jTYZpSwZscHRR39xYvwNW5sop7TVSoIjWxJDCge8QroQWdjygT2dSmY/pYpuOVi7pn5QI=
Received: from DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) by DB4P190MB2251.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:5e3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 11:27:34 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::ba) by DUZPR01CA0014.outlook.office365.com
 (2603:10a6:10:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 11:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server id 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025
 11:27:34 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 4/4] net/ntnic: add warning when sending on a stopped queue
Date: Fri, 20 Jun 2025 13:27:07 +0200
Message-ID: <20250620112707.294596-5-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250620112707.294596-1-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|DB4P190MB2251:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed73a7b8-3488-42ea-96ba-08ddafed73cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VM+q5ysRVX6O09AGK7Mkejv5mLcjJE4NULlK04AU9vVCnACARJwCyfMXIklc?=
 =?us-ascii?Q?VsVC3aBNEpgZHhgnNMmrcbHyLUtgrYICAdiUz5fTLhvXtkh9yipbWaPMs5Ys?=
 =?us-ascii?Q?aLdiy3RrTpyKW2xUB6KeKyYg+lZbvyCMSK1IIhhyY/qT4yxTnV+dbVrbtk72?=
 =?us-ascii?Q?bB2K3J8u4P6l+qS3Wqetn/L9RHItE8a5DSe7J320wbq4nz3Q1SupdTAGExQ1?=
 =?us-ascii?Q?Xv1Grri5KPrQLd20m3LaQGSQ129WqxxXiDeIw6F3n2sX15pPrGz30ZJ+zPab?=
 =?us-ascii?Q?nlKUhzvISlXx0c63L9Hf/v1lUEnc90KRy2yKR/ZxQFt+9mqbKwZlhewaG5sw?=
 =?us-ascii?Q?H3vpogEZ7ffVmQCeZfpmXg1ZtS1LwnpPoSK09sl1OyTqvhpUJr88R3340JxA?=
 =?us-ascii?Q?RSub+nGeTKKEnBBsVgNk/ewOsX/jVAALCLi8R1VMAowUdtIJJyF0ZFvuBrYc?=
 =?us-ascii?Q?DZDOEsEqVG4tpel8PejL3Kjv1/+pvKUi6UITfTAVaME5ATXkhoXBbZx1J0Yg?=
 =?us-ascii?Q?HBkQDKRFJYE/beXlouG/exjk3Cd1TZMovvdTdGfZtReHCx8RSMRaIQMUbk1B?=
 =?us-ascii?Q?TWPn0KoP6T595ijokyjjZdeMF5S2Aq8RNukCNZq8GwfEpt0CogcrfRD5u6tj?=
 =?us-ascii?Q?sXw6AVb9gxWFowmYn6vUtW0lsUaGX5v0RObQeYZdqqxMhf/rHuVIm7cM9z8b?=
 =?us-ascii?Q?yPJ9qdeL1j+HZDbQF9bdsN3r8JfkWXZLjEBzXySWfZIlnVqM3Wp/FufSyD0i?=
 =?us-ascii?Q?kXqBbrU2fW/xyp8JHogAvDfsExmmF0zmCrEZ5+TNi7zx9QdD8oqgDzMdLNfx?=
 =?us-ascii?Q?Qi5bOA0MZdSrqQjQDuxjyf3FOHEpKNbHgRT4GlMMuEIyUCDxXyBnL7zc2o37?=
 =?us-ascii?Q?3P/FhbxIa9x6/Zn3TrpsRZFYlHBuRyC4jDEsmOqI1/YRms7cg9mYm1y74ZEY?=
 =?us-ascii?Q?JAWPop/hL/0/QfugNHQlxb6KolBSe938i7vEwhN15UxuWCRyfi0NxxqCPAuP?=
 =?us-ascii?Q?OdADq+Oh7I7XiiZgx31cNrenaf1adGZbkMrchP8cWQd6oQSpGjOCsdUeJCMt?=
 =?us-ascii?Q?H7RRlZ3qUrlmPTqDbCQwdSKG06+v9xlzVX6DoTMHll2s8j0aqwoM08eXmcdd?=
 =?us-ascii?Q?SEVKRVWUlrPJr+gGHw3sK1OILc/aVR6N7uw21dbG4TipZMoxttJyaqvLB7Fw?=
 =?us-ascii?Q?rEygeH2DbgnLCYAImqVKmNNwkEcT+eQc0wxRw25NGzxopZVOFMJZ6Mk8CwRz?=
 =?us-ascii?Q?y+1IsMLSTirs/8LJxSAhx1o/cbrT+7bPzempQX3QdUglW2ErCpl3zoI24onq?=
 =?us-ascii?Q?UFRNFHI878aVk7qTq5fKRophgpub0Sl8XrV/T6pa4A0bzrKI3Jz6+WkEYQno?=
 =?us-ascii?Q?XA1CPnWqom/YkaFeqWB/A4NKtAEw2JS4eq0K7Mb4YChWMwhUG5mZ/WF8cPND?=
 =?us-ascii?Q?WtpQXf8eXBvhEKon70+I/yaJSn/CEytpAL/J3iqjrxa5Iywa+TyyoQXVrl1F?=
 =?us-ascii?Q?DIeLl4yaSto9zkfYkod70oXkdDEwgseCIY8o?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xo8csikG0AunrxrTV5V7kNToNJ9qGW1qlw7GHqRio2DE36+MZX1DRliq0GM8hMuNhPX0lMkJnSo/JPZf93eJmL9gIfAAooIOfv9gpOOJAwD58sK8EkLHwZQuCDqQ/C/jm9QjB/4IDy+zcYxO74S4mRIbg7veljWhI2MRH9we9iCw7xGjUbaJop8o3MotX3zFqGhxDvg6Z1VDzSgV3b1zTZYxoJrIxLAv88jxEq346vSVNtUtTNlglnnaWQ1vkq8Nw/I+q2e4+zyVJmY9tqVLum7pfqXaUqfeRbMlJnzt2usDOYlQGcGpu3xfg7qqxFk3/glMr+RCcXVyyXEl3d+ZPNpwAlTTFPBA/QVZHVyehuNC7qVihVb0G/xyEbJdcg9vG9DitpRRnli7tzu9C5d0wZyz0S/yaWFNHGonL4if+mgVBKWR67HpVCV1N08PIQBB1yuXDcMKQEa9mONjMZrx+EuWYdojB5Bq0/YLkSbvN6xae3IL/m5/GMUrsdjVS4uOKhnx7AQCN6DqY13fpGj+VND7EVzmYBiUxtf4BXTnKj27C6BOMwvxEmv1cpV0aSqDa0YkBCJEKsPLniwEDNn9fyjrbRwfQ5u35coQm2DyoNi4oXfeuQdA2sEp1zdAO3ec7BdelLNdF4eQ86/UmepPIO+Fwfk9SBzjnc77w+hjqDk=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 11:27:34.0027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed73a7b8-3488-42ea-96ba-08ddafed73cd
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P190MB2251
X-BESS-ID: 1750418856-304982-7641-17090-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 52.101.66.72
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpaGpkBGBlDM0tzE0NzENC3R0s
 jc1NLYMjHZwMDIwDzV3NQozSzVwFCpNhYAuhgKLkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265470 [from 
 cloudscan22-82.eu-central-1b.ess.aws.cudaops.com]
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

When sending a burst of output packets on a stopped transmit queue,
the packets are written to a memory mapped address.
On queue start the packets are processed and transmitted by the NIC.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 79ef9e7e7c..4145128d11 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -694,6 +694,10 @@ static uint16_t eth_dev_tx_scg(void *queue, struct rte_mbuf **bufs, uint16_t nb_
 	int pkts_sent = 0;
 	uint16_t nb_segs_arr[MAX_TX_PACKETS];
 
+	if (!tx_q->enabled)
+		NT_LOG(WRN, NTNIC, "Trying to send a burst of output packets "
+					"on a stopped transmit queue of an Ethernet device");
+
 	if (nb_pkts > MAX_TX_PACKETS)
 		nb_pkts = MAX_TX_PACKETS;
 
-- 
2.47.1

