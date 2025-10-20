Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10226CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:39:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6392D40E64;
	Mon, 20 Oct 2025 18:36:58 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id A64D040BA0
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:43 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021073.outbound.protection.outlook.com
 [40.107.130.73]) by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPu6y4yNANdlyJWvWjguXQFJP+gi7/Zj7amNpjInC3/Iotl6juHmXmPXISy0z5lC5gla1NGGtdb1CZIyet5jplivP9bltvqdEZbtbbH4TRArAt62B+mvdwTU4K9nCvQtlYRnUUsi96cQH0mu8N6KgO6vB+9Zu8BvVrlsX8Fa5y14xHE63Of0NAQlVOZYJS8Di454S5JRyysYpSNGtLRYxgDRNn5c1sbMaUtlacP421W255+nd9mduAfnQU3QhxM2fM2gPT63jAf4mTAZQgjM4LADTQyXpyH5eiePCnFxypZMMzgi5uq6EkPGVz/Ixj75MFluaOQVtrEQ1ia8+Bj5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS8zvUWdqpFX8ssniW8zlkKdatz1gAS/qOgz92/SN4A=;
 b=Dzte9NzxZL3Vk82k8PV6SzqWZRqNtDhy2WdHkAS+YNIyk5yjZH/Z6F25dV64iIaY9qAsabqJUhnEQQves9n4OOp1Gq08+mEI8SylvMd1rkUpVDu75+f4J21GIZpWHcijioWKKow4LHroY5JtdYodmfeBkxisb3iR2BRDOXXnKBjZ4X+eYeuK9Hj5WnEH2ojwbV5vjNtkT2+PLaHAp47CSu6Gp8J4txlQW9Ty4PZl25pt+1oL32/amQO5YzgZdlnzsD55qIy6ScwjEQPQA4WOFwqdDbkvRoJW30zWBpj3HuUCvBju5+Il/uHyCHPgofSo0lgTU6xfdMTIzBtBp2M4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS8zvUWdqpFX8ssniW8zlkKdatz1gAS/qOgz92/SN4A=;
 b=Ubj1UINO6/Zt32XmDcEAWM6MI8p+7UD70MnHKjRaUggNBEDAzLS6aM8l4ANEEjUuJ3oeEJ7EKJLPkHRMJn4+Z0MvGE0UkpGr1ymuFRRwLIGOT8oY6ju3diY8rOou8oC4NeoIFd7d6i987BK2lLvoPZrLFqv+feDd8+pAfpqJJkE=
Received: from AS4P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::15)
 by VI0P190MB2105.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:24a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.10; Mon, 20 Oct
 2025 16:36:39 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::51) by AS4P191CA0025.outlook.office365.com
 (2603:10a6:20b:5d9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:39
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 18/24] net/ntnic: change prefix set to prefix nthw
Date: Mon, 20 Oct 2025 18:36:09 +0200
Message-ID: <20251020163620.282312-19-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI0P190MB2105:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3c9dd704-2ea1-4311-c857-08de0ff6d83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a72MEeONP9nGpfF+M01ZExTOiITCZaTTVQHfMqgA6IOgElb7RmcTkUyyXf1d?=
 =?us-ascii?Q?/tHPNWCM59+k3vnIqXzjTc/uh92DyUe4peBDfOtZD0HUZC09uf3SzLeWXarP?=
 =?us-ascii?Q?9zZnzPMWa55IMBp7aeob4hnsXGYbpoBEPuAD3EmOpHgygbjYqGXJlOhBKt6n?=
 =?us-ascii?Q?aAQyBYmsF3gGB05WpwsdTPAwC378ENMHYu9sKK7twGGARrJiRfkcTXMUi9cF?=
 =?us-ascii?Q?IPnpio9G1X2eI8PpaKhIvuCywdoRhArN6uDdpX5SspeBDvSoC21z0NyYQm81?=
 =?us-ascii?Q?B32xQQKziwLt3dzz+9BZXX2x01EDg69g7f0JGfhbCnnZMrxxVPwNcNq+7UKw?=
 =?us-ascii?Q?+pAn1r9d1NdSZ8+5STU1vrC2zbIHbsYpRfBj7lyt/lTr3kF0zyr5sjQmcwqs?=
 =?us-ascii?Q?zomvaAvPKtWlKVK7KktW6un7u35jz2qG0tmpwYYbIe8HGSuFhK9rBgn9c1SB?=
 =?us-ascii?Q?iI2gCSkJyfF0HZ+TvSwdLytUNaSHKxsrUwHilZDcwXdqqxVZk8ICSIZxGsZ5?=
 =?us-ascii?Q?QMLrKKTJxCVoK0FUHRhSGHny8s8Ac+hXADC9HUnqp5I2Bz/u9l9AG28xzITH?=
 =?us-ascii?Q?idC3zKZJ7B5dcKKpnO7iWVlrtC+2tBsacnALiwWOSMDC9XOqE7qSdLbVzAEg?=
 =?us-ascii?Q?H0gXwGs+ZRbCwaMkMoRgA/MsBiZ1jjdL0vfOzqOlWvURJ/sjcSfKj9mK+8/d?=
 =?us-ascii?Q?on1JKK8iRGpkQ2u0apzoWUxKRob0sBwL6Krt4lf+7tSHMO3nblttHYm4VMz2?=
 =?us-ascii?Q?0RU9TOso/fdwX7JjOvtJ4T82zhq07951FXjRwdxGXiWkwexzfd3ybVlwD+ba?=
 =?us-ascii?Q?u8vuD1V79H8K0jarUGpTPrSQwpRuLcdvkkTC1Yn+Hp6pqT0aEMlfUnlSb7eD?=
 =?us-ascii?Q?CYNov4V/PDDrOiRbAhUqAyEzwa+ehxm1sJQtyO1k3Rt9Kw8i/CVk45cfwgB8?=
 =?us-ascii?Q?MWB0TUQgbJka9A6J8LL5JwJVDYgUmF9IBGfqD9LhOsh/WgZNQRbyUge9zxiK?=
 =?us-ascii?Q?pGW9ULAXZLE1FtUcqwuIcuO5BkceSaiGJP5UH53FTd+GN2PpWFohe/iDZQmS?=
 =?us-ascii?Q?m4yzuRRroOXzIeSdrAC5tQMhLTpM9jIJHk3Ss9wShYrGoai+qtAdeb7HvBHY?=
 =?us-ascii?Q?5hfQna9djfVQw4aEZCApfHPu11nFKmHUeCWZToI3MogB6/FOKNUJ6FwJ+458?=
 =?us-ascii?Q?mek5a0NoGl903+FEm+Xy0jpLjDo6nLJQJspDX1eHnqK3Dwardcx6qdHCy0Df?=
 =?us-ascii?Q?NalME9pgNwM4kbR63c4X28uCH4RAzy1/x1VpKwvmD7wJwUM2BF6RWrT8D6hM?=
 =?us-ascii?Q?EufYL4pJr8ls9VKyad8DJpkqB31Rxql6V0o6eLW7JhIek4Ax48MnL2PO7pQg?=
 =?us-ascii?Q?ljGVsyCWEGJClQfBt/TKeXiFdx4K/A46jzi+txRfT10/e6rxWduJEYLx7sDL?=
 =?us-ascii?Q?wI4PxZKCAVWhySBy1vLZMlFrbJ+0JnRqsXgrHceOw7c5jNA3W7Oc7t85F4ED?=
 =?us-ascii?Q?sL6XlvREgK/ZCfE6HLKa9lzvuP3OihCKd9GwK1nea0rMcvcRSHZ5nVF7HhxU?=
 =?us-ascii?Q?y0VEqb60sGkrzAFEn1g=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g1vUEdF6oRTZ53+bj6KUyn+8fd92zKmKF55nLTWTnD7K9mGZ/UTRL16/Wm048JfnOnjErsamgYAXjqZ3P0we2OEPGUr1/TFuwdHhTL+y4qem/zEJ6rLid36KEgzP7AN7x5rtH/Xpnbgj7fQQpnsAyl5B3CQflKfbT80RudEg8c7gKp4NvWFsmnduXy2Xm6AxRIVIgL5JHZgCOIriOFyQqAqsBcD35lgkCGSxyBNeb7K2cAv23rWNVvonbv3i2Pri3/ixV4rsaY0xhZBuon95/Esn1m5lH55tWlv8p3SBLMOoMI4GiWPnIXFMyrq9zLYtUqxBDOltN6jTDVpKBCj7hii2H6HrOOmgRr6NKgU1KR0XMXMREF8IXgHeuwmtfM7YFrk86rUwYNCU0Irr0a8K5t7timD6r9J/nVXt122E32J8+rkb1OA2PtxiNPL599avxLkFST4JqOIfVQmZylWDtuATJFF3v8AjJZQSCf6dtKMt4Z8Pfq7KYFpl+GhUadYfrhg4qq57kFgTtU/TtOgC6OSJGDytehZAiGzWxTlbwAXH1bi1hfrHP7LJ2nCY/e5blhZ4z76QBskf8HkwyVQ/pR1cEN19Fvnf5/GOyEYkQ115CHr2XzCDrJ880wmp7GxDM08gT3de6c1+t8IrJx6O20s3vqejR0hyPd6XEM8WhIQ=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:39.6187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9dd704-2ea1-4311-c857-08de0ff6d83a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2105
X-BESS-ID: 1760978202-312065-25064-118011-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.130.73
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamBsbmQGYGUDQtMTXZJNE00T
 I11cg8OcUkLdHMPMnCxNIkySjV0ijFUKk2FgDWpK7iQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan20-186.eu-central-1b.ess.aws.cudaops.com]
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

Change setter functions prefix from set_ to nthw_set_ for DBS module

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 50 +++++++++----------
 drivers/net/ntnic/include/ntnic_dbs.h         | 22 ++++----
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         | 22 ++++----
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 7b2e2e53fc..3257233545 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -198,7 +198,7 @@ static void dbs_init_tx_queue(nthw_dbs_t *p_nthw_dbs, uint32_t queue, uint32_t s
 		nthw_get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
 	} while (busy != 0);
 
-	set_tx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
+	nthw_set_tx_init(p_nthw_dbs, start_idx, start_ptr, INIT_QUEUE, queue);
 
 	do {
 		nthw_get_tx_init(p_nthw_dbs, &init, &dummy, &busy);
@@ -221,14 +221,14 @@ static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 	if (p_nthw_dbs == NULL)
 		return -1;
 
-	res = dbs_init(NULL, p_fpga, 0);/* Check that DBS exists in FPGA */
+	res = nthw_dbs_init(NULL, p_fpga, 0);/* Check that DBS exists in FPGA */
 
 	if (res) {
 		free(p_nthw_dbs);
 		return res;
 	}
 
-	res = dbs_init(p_nthw_dbs, p_fpga, 0);	/* Create DBS module */
+	res = nthw_dbs_init(p_nthw_dbs, p_fpga, 0);	/* Create DBS module */
 
 	if (res) {
 		free(p_nthw_dbs);
@@ -242,7 +242,7 @@ static int nthw_virt_queue_init(struct fpga_info_s *p_fpga_info)
 		txvq[i].usage = NTHW_VIRTQ_UNUSED;
 	}
 
-	dbs_reset(p_nthw_dbs);
+	nthw_dbs_reset(p_nthw_dbs);
 
 	for (i = 0; i < NT_DBS_RX_QUEUES_MAX; ++i)
 		dbs_init_rx_queue(p_nthw_dbs, i, 0, 0);
@@ -382,8 +382,8 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 3. Configure the DBS.RX_DR_DATA memory; good idea to initialize all
 	 * DBS_RX_QUEUES entries.
 	 */
-	if (set_rx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr, host_id, qs, header,
-			0) != 0) {
+	if (nthw_set_rx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr,
+		host_id, qs, header, 0) != 0) {
 		return NULL;
 	}
 
@@ -398,9 +398,9 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	int_enable = 0;
 	vec = 0;
 	istk = 0;
-	NT_LOG_DBGX(DBG, NTNIC, "set_rx_uw_data int=0 irq_vector=%i", irq_vector);
+	NT_LOG_DBGX(DBG, NTNIC, "nthw_set_rx_uw_data int=0 irq_vector=%i", irq_vector);
 
-	if (set_rx_uw_data(p_nthw_dbs, index,
+	if (nthw_set_rx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
 			host_id, qs, 0, int_enable, vec, istk) != 0) {
 		return NULL;
@@ -414,7 +414,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 *    at a later time (after we have enabled vfio interrupts in the kernel).
 	 */
 	if (irq_vector < 0) {
-		if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
+		if (nthw_set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				RX_AM_DISABLE, host_id, 0,
 				0) != 0) {
 			return NULL;
@@ -432,7 +432,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 *  good idea to initialize all DBS_RX_QUEUES entries.
 	 */
 	uint32_t enable = rx_deferred_start ? RX_AM_DISABLE : RX_AM_ENABLE;
-	if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, enable,
+	if (nthw_set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, enable,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
 		return NULL;
 	}
@@ -520,7 +520,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	/* Clear UW */
 	rxvq->used_struct_phys_addr = NULL;
 
-	if (set_rx_uw_data(p_nthw_dbs, rxvq->index, (uint64_t)rxvq->used_struct_phys_addr,
+	if (nthw_set_rx_uw_data(p_nthw_dbs, rxvq->index, (uint64_t)rxvq->used_struct_phys_addr,
 			rxvq->host_id, 0, PACKED(rxvq->vq_type), 0, 0, 0) != 0) {
 		return -1;
 	}
@@ -528,7 +528,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	/* Disable AM */
 	rxvq->am_enable = RX_AM_DISABLE;
 
-	if (set_rx_am_data(p_nthw_dbs,
+	if (nthw_set_rx_am_data(p_nthw_dbs,
 			rxvq->index,
 			(uint64_t)rxvq->avail_struct_phys_addr,
 			rxvq->am_enable,
@@ -546,7 +546,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	rxvq->avail_struct_phys_addr = NULL;
 	rxvq->host_id = 0;
 
-	if (set_rx_am_data(p_nthw_dbs,
+	if (nthw_set_rx_am_data(p_nthw_dbs,
 			rxvq->index,
 			(uint64_t)rxvq->avail_struct_phys_addr,
 			rxvq->am_enable,
@@ -558,7 +558,7 @@ static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 	/* Clear DR */
 	rxvq->desc_struct_phys_addr = NULL;
 
-	if (set_rx_dr_data(p_nthw_dbs,
+	if (nthw_set_rx_dr_data(p_nthw_dbs,
 			rxvq->index,
 			(uint64_t)rxvq->desc_struct_phys_addr,
 			rxvq->host_id,
@@ -602,7 +602,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	/* Clear UW */
 	txvq->used_struct_phys_addr = NULL;
 
-	if (set_tx_uw_data(p_nthw_dbs, txvq->index, (uint64_t)txvq->used_struct_phys_addr,
+	if (nthw_set_tx_uw_data(p_nthw_dbs, txvq->index, (uint64_t)txvq->used_struct_phys_addr,
 			txvq->host_id, 0, PACKED(txvq->vq_type), 0, 0, 0,
 			txvq->in_order) != 0) {
 		return -1;
@@ -611,7 +611,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	/* Disable AM */
 	txvq->am_enable = TX_AM_DISABLE;
 
-	if (set_tx_am_data(p_nthw_dbs,
+	if (nthw_set_tx_am_data(p_nthw_dbs,
 			txvq->index,
 			(uint64_t)txvq->avail_struct_phys_addr,
 			txvq->am_enable,
@@ -629,7 +629,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	txvq->avail_struct_phys_addr = NULL;
 	txvq->host_id = 0;
 
-	if (set_tx_am_data(p_nthw_dbs,
+	if (nthw_set_tx_am_data(p_nthw_dbs,
 			txvq->index,
 			(uint64_t)txvq->avail_struct_phys_addr,
 			txvq->am_enable,
@@ -644,7 +644,7 @@ static int dbs_internal_release_tx_virt_queue(struct nthw_virt_queue *txvq)
 	txvq->port = 0;
 	txvq->header = 0;
 
-	if (set_tx_dr_data(p_nthw_dbs,
+	if (nthw_set_tx_dr_data(p_nthw_dbs,
 			txvq->index,
 			(uint64_t)txvq->desc_struct_phys_addr,
 			txvq->host_id,
@@ -713,8 +713,8 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 3. Configure the DBS.TX_DR_DATA memory; good idea to initialize all
 	 *    DBS_TX_QUEUES entries.
 	 */
-	if (set_tx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr, host_id, qs, port,
-			header, 0) != 0) {
+	if (nthw_set_tx_dr_data(p_nthw_dbs, index, (uint64_t)desc_struct_phys_addr,
+			host_id, qs, port, header, 0) != 0) {
 		return NULL;
 	}
 
@@ -730,7 +730,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	vec = 0;
 	istk = 0;
 
-	if (set_tx_uw_data(p_nthw_dbs, index,
+	if (nthw_set_tx_uw_data(p_nthw_dbs, index,
 			(uint64_t)used_struct_phys_addr,
 			host_id, qs, 0, int_enable, vec, istk, in_order) != 0) {
 		return NULL;
@@ -740,7 +740,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 * 2. Configure the DBS.TX_AM_DATA memory and enable the queues you plan to use;
 	 *    good idea to initialize all DBS_TX_QUEUES entries.
 	 */
-	if (set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, TX_AM_DISABLE,
+	if (nthw_set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr, TX_AM_DISABLE,
 			host_id, 0, irq_vector >= 0 ? 1 : 0) != 0) {
 		return NULL;
 	}
@@ -764,7 +764,7 @@ static struct nthw_virt_queue *nthw_setup_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	 */
 	if (irq_vector < 0) {
 		uint32_t enable = tx_deferred_start ? TX_AM_DISABLE : TX_AM_ENABLE;
-		if (set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
+		if (nthw_set_tx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				enable, host_id, 0, 0) != 0) {
 			return NULL;
 		}
@@ -1127,12 +1127,12 @@ nthw_setup_mngd_tx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 
 static int nthw_switch_rx_virt_queue(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable)
 {
-	return set_rx_am_data_enable(p_nthw_dbs, index, enable);
+	return nthw_set_rx_am_data_enable(p_nthw_dbs, index, enable);
 }
 
 static int nthw_switch_tx_virt_queue(nthw_dbs_t *p_nthw_dbs, uint32_t index, uint32_t enable)
 {
-	return set_tx_am_data_enable(p_nthw_dbs, index, enable);
+	return nthw_set_tx_am_data_enable(p_nthw_dbs, index, enable);
 }
 
 static uint16_t nthw_get_rx_packets(struct nthw_virt_queue *rxvq,
diff --git a/drivers/net/ntnic/include/ntnic_dbs.h b/drivers/net/ntnic/include/ntnic_dbs.h
index c35a7cb99b..3de7206ccb 100644
--- a/drivers/net/ntnic/include/ntnic_dbs.h
+++ b/drivers/net/ntnic/include/ntnic_dbs.h
@@ -233,8 +233,8 @@ struct nthw_dbs_s {
 typedef struct nthw_dbs_s nthw_dbs_t;
 
 nthw_dbs_t *nthw_dbs_new(void);
-int dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance);
-void dbs_reset(nthw_dbs_t *p);
+int nthw_dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance);
+void nthw_dbs_reset(nthw_dbs_t *p);
 
 int nthw_set_rx_control(nthw_dbs_t *p,
 	uint32_t last_queue,
@@ -253,30 +253,30 @@ int nthw_set_tx_control(nthw_dbs_t *p,
 int nthw_set_rx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue);
 int nthw_get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
-int set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
+int nthw_set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue);
 int nthw_get_tx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *busy);
 int nthw_set_rx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
 int nthw_get_rx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
 int nthw_set_tx_idle(nthw_dbs_t *p, uint32_t idle, uint32_t queue);
 int nthw_get_tx_idle(nthw_dbs_t *p, uint32_t *idle, uint32_t *queue, uint32_t *busy);
-int set_rx_am_data(nthw_dbs_t *p,
+int nthw_set_rx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
 	uint32_t host_id,
 	uint32_t packed,
 	uint32_t int_enable);
-int set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
-int set_tx_am_data(nthw_dbs_t *p,
+int nthw_set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
+int nthw_set_tx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
 	uint32_t host_id,
 	uint32_t packed,
 	uint32_t int_enable);
-int set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
-int set_rx_uw_data(nthw_dbs_t *p,
+int nthw_set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable);
+int nthw_set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -285,7 +285,7 @@ int set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t int_enable,
 	uint32_t vec,
 	uint32_t istk);
-int set_tx_uw_data(nthw_dbs_t *p,
+int nthw_set_tx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -295,14 +295,14 @@ int set_tx_uw_data(nthw_dbs_t *p,
 	uint32_t vec,
 	uint32_t istk,
 	uint32_t in_order);
-int set_rx_dr_data(nthw_dbs_t *p,
+int nthw_set_rx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
 	uint32_t queue_size,
 	uint32_t header,
 	uint32_t packed);
-int set_tx_dr_data(nthw_dbs_t *p,
+int nthw_set_tx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
diff --git a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
index da64dbab48..25989d170b 100644
--- a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
+++ b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
@@ -76,7 +76,7 @@ nthw_dbs_t *nthw_dbs_new(void)
 	return p;
 }
 
-int dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance)
+int nthw_dbs_init(nthw_dbs_t *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_DBS, n_instance);
 
@@ -369,7 +369,7 @@ static int dbs_reset_tx_control(nthw_dbs_t *p)
 	return 0;
 }
 
-void dbs_reset(nthw_dbs_t *p)
+void nthw_dbs_reset(nthw_dbs_t *p)
 {
 	int i;
 	dbs_reset_rx_control(p);
@@ -462,7 +462,7 @@ int nthw_get_rx_init(nthw_dbs_t *p, uint32_t *init, uint32_t *queue, uint32_t *b
 	return 0;
 }
 
-int set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
+int nthw_set_tx_init(nthw_dbs_t *p, uint32_t start_idx, uint32_t start_ptr, uint32_t init,
 	uint32_t queue)
 {
 	if (p->mp_reg_tx_init_val) {
@@ -601,7 +601,7 @@ static void flush_rx_am_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_rx_avail_monitor_data, 1);
 }
 
-int set_rx_am_data(nthw_dbs_t *p,
+int nthw_set_rx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
@@ -618,7 +618,7 @@ int set_rx_am_data(nthw_dbs_t *p,
 	return 0;
 }
 
-int set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
+int nthw_set_rx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
 {
 	if (!p->mp_reg_rx_avail_monitor_data)
 		return -ENOTSUP;
@@ -673,7 +673,7 @@ static void flush_tx_am_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_tx_avail_monitor_data, 1);
 }
 
-int set_tx_am_data(nthw_dbs_t *p,
+int nthw_set_tx_am_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t enable,
@@ -690,7 +690,7 @@ int set_tx_am_data(nthw_dbs_t *p,
 	return 0;
 }
 
-int set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
+int nthw_set_tx_am_data_enable(nthw_dbs_t *p, uint32_t index, uint32_t enable)
 {
 	if (!p->mp_reg_tx_avail_monitor_data)
 		return -ENOTSUP;
@@ -796,7 +796,7 @@ static void flush_rx_uw_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_rx_used_writer_data, 1);
 }
 
-int set_rx_uw_data(nthw_dbs_t *p,
+int nthw_set_rx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -923,7 +923,7 @@ static void flush_tx_uw_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_tx_used_writer_data, 1);
 }
 
-int set_tx_uw_data(nthw_dbs_t *p,
+int nthw_set_tx_uw_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -1019,7 +1019,7 @@ static void flush_rx_dr_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_rx_descriptor_reader_data, 1);
 }
 
-int set_rx_dr_data(nthw_dbs_t *p,
+int nthw_set_rx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
@@ -1121,7 +1121,7 @@ static void flush_tx_dr_data(nthw_dbs_t *p, uint32_t index)
 	nthw_register_flush(p->mp_reg_tx_descriptor_reader_data, 1);
 }
 
-int set_tx_dr_data(nthw_dbs_t *p,
+int nthw_set_tx_dr_data(nthw_dbs_t *p,
 	uint32_t index,
 	uint64_t guest_physical_address,
 	uint32_t host_id,
-- 
2.45.0

