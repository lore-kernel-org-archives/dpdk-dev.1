Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA7C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 10:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BF504066E;
	Tue,  1 Jul 2025 12:20:43 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 6EDCE400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 12:20:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020072.outbound.protection.outlook.com [52.101.69.72])
 by mx-outbound11-108.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 01 Jul 2025 10:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnMnXJl0r9eaymXT+lRq4IuwhIt8pwnh6dLgyGPX9yn1TbvFfMjJ2Ee9pycwm0nyXB44uqzz5LnXget+WTcaAnanDoZTJgR2KTRV+V4qWy7MXAaJudZLRJd/bgd9Obv7mPSfKU6rmJV9LXSTFxO1kWVn3/d/NuhdeCmJeOIPAhsabVQWO3Zk6W41fKlp/eFOKtom5OovkGWe5uUam8apbpb+b6kXh/30jsDoRG8wk25R2p25OaoPiuQXaaIPKydn0VIpP4tGnPxHaWNIoD+ougFFDVcL26XEtMWtnMicSDEBd//m3EIEHlCVk6aEv89tMcqavmxrUKZr5XHk+cVm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/1qdPYDdv0s0dOnFGkxlnJz1RGKXm2tQhtfJKqZtxc=;
 b=Xxy7WhPv/eh+B6GvrwEXW+1cDC2eMzseTTrnC5oFEvm77x1sJv6EfdOMkYWuqVtd7M5tzO1DG5QexvE7i2FVx/Oh49f/DPyaU+9Qxxk7RSK2j4qMF7u+lL1dpyaRluZClLAlnJvu5B1PTaQ8Pi0tJpGsmzieDAo4P5+vCP/YM/CtMj8cMod5VC8rUDEBSmQGaPPNNbnLQn8bfG5uP+0Vo2tdtSl/tgyR2F2Bm/L7C33goc8iFk0AfEyOZhCNmeYOkBvb5+gYlNUeeeMB5Eb9AUfp1D9aRYDbObD/pwviSPdf919WRmQ6SFG7fbT+J3HcQObBg7IAGpTm1CeFV9vjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/1qdPYDdv0s0dOnFGkxlnJz1RGKXm2tQhtfJKqZtxc=;
 b=qIka3r9pR+BCn8k1gJscrgM30JRX+VYm4txUgq8b7d0zDIMS+DzKGt6bNulw54DzdU3Gy3Zzk7n6M0uE4LEPnof6YvgtnLcgFnzSsneCODZIke3g3cwLMTrFrftfQpzs0kbBkUQOV781bbVFjy3xa7vdBvz7fBcm6WmvCJVMxl4=
Received: from DU2P251CA0013.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::17)
 by GVXP190MB1967.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 10:20:33 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::e9) by DU2P251CA0013.outlook.office365.com
 (2603:10a6:10:230::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Tue,
 1 Jul 2025 10:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server id 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 10:20:32
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Oleksandr Kolomeiets <okl-plv@napatech.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 3/3] net/ntnic: unmap DMA during queue release
Date: Tue,  1 Jul 2025 12:20:27 +0200
Message-ID: <20250701102027.3525524-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250701102027.3525524-1-sil-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
 <20250701102027.3525524-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|GVXP190MB1967:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: acc8d03b-93ea-42e3-b48e-08ddb888e9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWWKKTqemHAD7NY1z3ixFw7lcA45DkZX15BXHnWzDOo0JiwX5jqKovHR+i7N?=
 =?us-ascii?Q?hIS4lzqc+Pu8WOniwoKU9NIgeOfNzY1d+rI5wDDpQoy0B8ZMqlwnKf+YB0iN?=
 =?us-ascii?Q?DAq8vFvAsosD32MX7S+udb//+iyMORIK5Pism0gOLOxj/l3+zN+NcGDYbWiG?=
 =?us-ascii?Q?xlCoiGTR7TwYKHnLUyD75c6FqHqNDxJcl7Z9i+atmQbxvZSg2i0kgLgLRThS?=
 =?us-ascii?Q?BfjBmCjjfGyo/iqdE8MwG5v8etYPNPOeYH+A7hrwTMLXF/61NLpcx3KTguau?=
 =?us-ascii?Q?WMg0dYTVvBDUO04Vn9QaHps+KOZv1WiokImtEcYPaRpLDKN+MTBBPQguZxKg?=
 =?us-ascii?Q?OOVq/46qLMH2ix74YnyZi45CsxExrLmyEgbolfha6fESaO0/oyaG8CkOvBwR?=
 =?us-ascii?Q?HYe+b5w+lkKrnVjdv7HIVCzvxyRQWeOPr5/HVVbuuSUv3/Q3KquiHwmkBTSe?=
 =?us-ascii?Q?O+ZtDMxpJhwTetbLbEr6ter5zVbRltXC2rawE7hanXu1KjYhjh1BNMsgklLU?=
 =?us-ascii?Q?x6zOhkhZZ79UXaw4FwrVBnP4X97gtp1pUvsmAfXz3Ba5lR11XHdmptLK/Ya/?=
 =?us-ascii?Q?Zm6HUR6rBFcC7wnoJAQPPkPk03GsU7TaK+0xW2Ec542juQt6WJ/tasMYhooL?=
 =?us-ascii?Q?GN/bm+cguSabXSmr/Gk608VKlDrKHYM9HyvBbhrrBvuT87/nLpkNYNr5KqQq?=
 =?us-ascii?Q?rpzq3kN2+yDigNHYIhCTZ0pHD0kFFrxIGAQkBQomJuvdeCU39/W5Y7myRDnn?=
 =?us-ascii?Q?o76mlb7udIjyftuzXgU3wtYe9loHgIxNRuJGtmdatPdmYXFAve5OqnoRmwPB?=
 =?us-ascii?Q?f6BvDRSvwfqrv2M0yl4ar6/zXUppiSSH4gBOYSQnJYii54H0lm+gXaphQlwe?=
 =?us-ascii?Q?GqcqY2TtTXgITHHoSWQt2oEVl6UOh7TUpXSaJ8EVlGIU1mYRw5BLlbqcCP5j?=
 =?us-ascii?Q?CKee/4zSpVSKdbrc7BKwlgGCFkss6a6og+zdmEoBARsqhHJvdwk8O7A+ayPj?=
 =?us-ascii?Q?P6FHKBsohLbL17GSOjw9GOY1+gqvLcglqKQwW6csKfLht9LykoEAcWIWUy+4?=
 =?us-ascii?Q?fSKKwSGheQ6/+oNmwaRO//wtn+sR/huOHo7/S+JV8s1T0YO/70orQWOsDrjH?=
 =?us-ascii?Q?HVUo/57i0sCWhmLzWmFrgQ3V4HPNlZSueQwVLVQJRtj07YKOuPwvkEeEYfBl?=
 =?us-ascii?Q?VERuiC6cbs/muYJPh5k5J2jLpnNf2k0XoJp3GKv6oJZZcBuuIkwp8gLdVJSI?=
 =?us-ascii?Q?aDtCZKpFX4mCVbmXnGoG8CGRMFAvySz0RaStQgIPq5j9A+camaZ/nUiQebs0?=
 =?us-ascii?Q?p/jRZSBDkAQZm6N61wGpdgTq+Ymz0VuVAnKVnJLe3mj41oGANeO6WLaHknD8?=
 =?us-ascii?Q?CMKmU2Ng/PTwjDuNGPsqNJxcYg9IXfhKdbTbUcw1njyleuFRpJav3Hp/rfqK?=
 =?us-ascii?Q?IwO/uYK3oCSOscw6I4KyLqHOFPDeKKktyxx+c0l+T7L6OyxM8CCMReSZG0ZE?=
 =?us-ascii?Q?OtcXNxTYSaSSQDz8DB7vu89FtizBD2yGGNyw?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2MSb0Bd9VGh02oz/vnEkb6cS4Qc4qpa96O8+JfMzaYQogxZjh30pUMV4emjE5xWE5RxpXIWM6M5rLNd3vfJP2o7sAO3LN88t8wqJ2JSJk7YbPWnHzahjd1lZUrcLy3h9khagPEEuw2dUc2k58LlD9/7aXKaUWDaVxSryIGatwZMRSExyA4iANZHTE7FPXz8Crl/BZXFbLlj7QMdAEAQbZHHJNwPLtT6fJS4E8/gWD+wkbLi1D64ILQp+4jgXiVTzD35MiGv+UIztyjgzC9fyphVX5UGt/XeZiL3QMMz6Z+ie8CvlYTEDafs9yYPZ7oaZcCj/UgoHJ/r0pPcusAtU3DppfOf7VaT/RZ9lIZiriwpIFv41Fn5dyalCtDNDYm8NBvIUeL7MvJ5DXxLn3I9MMkR2dxi2Qqzp0YKnV3bnQdAfGITBpc2YQptd+p4CLzF71Wl32kIolnPiqMJHwkSEMCalmtsYPhYtPWUQJ/dkL6EvFMPNupFRugjodPHTGRViQ7KOrlGfVUBu/+EAVUYXX4H0U7J81frI959kG17zX8eKmtmOxiOG39gplwnQlGeW5LVWDLdagPMMVPBbt4zktjkdZJm8oWUpCbvlb2+CGNbV+jxLqtOlFTlSHgS2iR3tqH3K6Yo360P9gOv6Vxszrw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:20:32.9785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc8d03b-93ea-42e3-b48e-08ddb888e9aa
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB1967
X-BESS-ID: 1751365238-302924-7633-5897-1
X-BESS-VER: 2019.1_20250616.1856
X-BESS-Apparent-Source-IP: 52.101.69.72
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsZmBkZAVgZQ0DTN1DLZ1NTA3M
 jMLM3IJMnIJDkxySDZ0tAoJcnMMMVCqTYWAIuaOU5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265646 [from 
 cloudscan16-150.eu-central-1b.ess.aws.cudaops.com]
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

From: Oleksandr Kolomeiets <okl-plv@napatech.com>

Perform unmapping in a default container, which is used by queues.
Handle multiple mappings when IOMMU is unoptimized.

Fixes: c1c139535591 ("net/ntnic: add VFIO module")

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/ntos_drv.h |  1 +
 drivers/net/ntnic/ntnic_ethdev.c     | 26 ++++++++++++++++++++++++--
 drivers/net/ntnic/ntnic_vfio.c       |  3 ---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/include/ntos_drv.h b/drivers/net/ntnic/include/ntos_drv.h
index cef3c5c277..047c077057 100644
--- a/drivers/net/ntnic/include/ntos_drv.h
+++ b/drivers/net/ntnic/include/ntos_drv.h
@@ -51,6 +51,7 @@ struct nthw_memory_descriptor {
 struct hwq_s {
 	int vf_num;
 	struct nthw_memory_descriptor virt_queues_ctrl;
+	struct nthw_memory_descriptor pkt_buffers_ctrl;
 	struct nthw_memory_descriptor *pkt_buffers;
 };
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d875e7c236..79ef9e7e7c 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -879,6 +879,10 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 		if (res != 0)
 			return -1;
 
+		hwq->pkt_buffers_ctrl.virt_addr = virt_addr;
+		hwq->pkt_buffers_ctrl.phys_addr = (void *)iova_addr;
+		hwq->pkt_buffers_ctrl.len = size;
+
 		for (i = 0; i < num_descr; i++) {
 			hwq->pkt_buffers[i].virt_addr =
 				(void *)((char *)virt_addr + ((uint64_t)(i) * buf_size));
@@ -900,9 +904,13 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 	hwq->vf_num = vf_num;
 	hwq->virt_queues_ctrl.virt_addr = virt;
 	hwq->virt_queues_ctrl.phys_addr = (void *)(iova_addr);
-	hwq->virt_queues_ctrl.len = 0x100000;
+	hwq->virt_queues_ctrl.len = ONE_G_SIZE;
 	iova_addr += 0x100000;
 
+	hwq->pkt_buffers_ctrl.virt_addr = NULL;
+	hwq->pkt_buffers_ctrl.phys_addr = NULL;
+	hwq->pkt_buffers_ctrl.len = 0;
+
 	NT_LOG(DBG, NTNIC,
 		"VFIO MMAP: virt_addr=%p phys_addr=%p size=%" PRIX32 " hpa=%" PRIX64 "",
 		hwq->virt_queues_ctrl.virt_addr, hwq->virt_queues_ctrl.phys_addr,
@@ -948,13 +956,27 @@ static int deallocate_hw_virtio_queues(struct hwq_s *hwq)
 	void *virt = hwq->virt_queues_ctrl.virt_addr;
 
 	int res = nt_vfio_dma_unmap(vf_num, hwq->virt_queues_ctrl.virt_addr,
-			(uint64_t)hwq->virt_queues_ctrl.phys_addr, ONE_G_SIZE);
+			(uint64_t)hwq->virt_queues_ctrl.phys_addr, hwq->virt_queues_ctrl.len);
 
 	if (res != 0) {
 		NT_LOG(ERR, NTNIC, "VFIO UNMMAP FAILED! res %i, vf_num %i", res, vf_num);
 		return -1;
 	}
 
+	if (hwq->pkt_buffers_ctrl.virt_addr != NULL &&
+			hwq->pkt_buffers_ctrl.phys_addr != NULL &&
+			hwq->pkt_buffers_ctrl.len > 0) {
+		int res = nt_vfio_dma_unmap(vf_num,
+				hwq->pkt_buffers_ctrl.virt_addr,
+				(uint64_t)hwq->pkt_buffers_ctrl.phys_addr,
+				hwq->pkt_buffers_ctrl.len);
+
+		if (res != 0) {
+			NT_LOG(ERR, NTNIC, "VFIO UNMMAP FAILED! res %i, vf_num %i", res, vf_num);
+			return -1;
+		}
+	}
+
 	release_hw_virtio_queues(hwq);
 	rte_free(hwq->pkt_buffers);
 	rte_free(virt);
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 8d955e8342..1031b3cf67 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -211,9 +211,6 @@ nt_vfio_dma_unmap(int vf_num, void *virt_addr, uint64_t iova_addr, uint64_t size
 		return -1;
 	}
 
-	if (vfio->container_fd == -1)
-		return 0;
-
 	int res = rte_vfio_container_dma_unmap(vfio->container_fd, gp_virt_base, iova_addr, size);
 
 	if (res != 0) {
-- 
2.45.0

