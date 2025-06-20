Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B7C7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 11:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B7D942EE4;
	Fri, 20 Jun 2025 13:27:40 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id E07E142ECF
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:27:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023098.outbound.protection.outlook.com [40.107.159.98])
 by mx-outbound45-75.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Jun 2025 11:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXEl0M91MS4ctDVqeo/KJNt/3IUUx05Fmw4B+/5sAKD2U429ir2nc//XE8GK9401X/9f1Fh3Oaow470bzHpARDJBNLBuWxLy6KSIKVNkoIAQjHoHUWD5EJ2EERYAPElah0hk/jAraYDSF+bX0+eI/WC6/6j2QEszVHSzjYVcBB6YmTEXsiuRk3bRKp12+xYhKTA2wc3Z9+aZbY3aZvbo10ZG+cC2VNs+03h0kpcNe47MZtvUaoJQLbmQzfVr5WFMRmtkphnunbLW61X61pt0unwd7Uw4sHyXFbMqTRb/5uxvU6lBzZWTSkizVTqMd7P7sDBMm+fy5nRtk2AbWe+9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB63lWx+e796qKjbX2BoDXZ64K1wdxcNqJijMfeKzEQ=;
 b=Gek+SZtrMwaYBEzZ/eBSoFVF8jvQTFwxUrXTQx3JK5BQnxKx0/3fuEEQLCH9zIiJZsS0jFcIEYKgDR2sdxETWxyCP8JUWh+YyXafnJbix+MQ720HPi3EzYMFyGNx1YwqZm4bANylO2R+aXWsRirQF7eY2mL+VnFewHojKPNPpwbYyxzap1Wewql2nvJ6OER2q6KWk4nR85dupoYUON7ltYemMcLo2VAG6Boy1KFUp19wuziNlriTRRDW7Iszt2qhqoNs/XeUgeT51jYq5bBKV0eyTYDR7JY7dKejvFPokrIElO78XEbnexuPBr5hYZ/k/Bld2CcpdNoC0R9Q5ExWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB63lWx+e796qKjbX2BoDXZ64K1wdxcNqJijMfeKzEQ=;
 b=pHFKJhfmivUqojR/hzxtMONm7BEm5dtn/vEVFYcdgF+lcYPvXLEfyqDKdBQAd12Z98Gs2Xz6IKEhNl5uQpqvaxNW3rlldYQvb4az8gw+aEvkRMQpjYqFO01H/ur/3MJyvZR9qjcJ248RK1m9CoU6UqKQ4flgEjXnViFAJNZPJ7I=
Received: from DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) by DB8P190MB0716.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:12f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.36; Fri, 20 Jun
 2025 11:27:33 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::f5) by DUZPR01CA0001.outlook.office365.com
 (2603:10a6:10:3c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 11:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server id 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025
 11:27:33 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 3/4] net/ntnic: unmap DMA during queue release
Date: Fri, 20 Jun 2025 13:27:06 +0200
Message-ID: <20250620112707.294596-4-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250620112707.294596-1-okl-plv@napatech.com>
References: <20250620112707.294596-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|DB8P190MB0716:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 99fc280c-2fc2-49b3-f8e9-08ddafed7394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?180X9/zIGOBO8BLIfv5dbAD3/Mebxa8u8KWIyHedn2YGfN0cBnxDlMEcZB7K?=
 =?us-ascii?Q?LY4/cabDql/hkCRvOkx0UdAuR05ezYv+T0vOT+Sj2FVzhzMZSITfmZuIoOqe?=
 =?us-ascii?Q?JrHx3gsXYKwZc16zw5xUkrF9dwoT4LIER9IaZwZLXO9WcJ1Lp4x19uxZUJ+J?=
 =?us-ascii?Q?ZHRplZr2Zh5vjUnIS72Va1YhK0d1tnDYYG0dE14slF/k23yFICAt/v2nz9Ya?=
 =?us-ascii?Q?e2USF2z1odwwVPYYBFJ4iXF0/sboLPlbGbOzS8xXkcSp1Yhyhm7ieRN1CZaB?=
 =?us-ascii?Q?31IObrw16A4YnT5W3ZZkzCI14ZmzY6BL4KiYo2448ae4yHlBa5UzWsloljpu?=
 =?us-ascii?Q?mFA7ZqEz+I3oRGXVNc6AMW0ZBUADtINvW7625cX72YaHRnVtw4/s6uuuE/v6?=
 =?us-ascii?Q?YWmB2lG3zxUKDFNUUvQOcQ96GGDIZIyEbHLP9fmp4PdEBqoTYJlsd0WeaPMs?=
 =?us-ascii?Q?i5xVaot6lV0sIpkvpaMMGIQaVWXsmw3v0YiuqBbg3Ni81G+8lLv2FBxUK7pD?=
 =?us-ascii?Q?o7IfVLDF9pvIWWg0zzqVfqb+NmylwTjwUoMStq3iRuF0IcRrFdv5A6JL2mcl?=
 =?us-ascii?Q?BnTxs+nV+/yC3adLdA3wZoLzC6vTroDbNfMcYD2/UjzYddI5rJNsMVYymTVo?=
 =?us-ascii?Q?cekDDEaPclzREmW85jkeuK1AxxroLQYowrXU60/FXOQ/OnixlQBgaWVlPzNg?=
 =?us-ascii?Q?KUIv+AoAo+DLV4oDO11xr16ZD4zpQfSgt1ziUw5TJh8QYfx1VIGNtT77T+SN?=
 =?us-ascii?Q?mknf5KedVQvf40+/V7O95hOiZp4Wus37grVYmgcLGsO4XRMYtdZ5VmI37e90?=
 =?us-ascii?Q?a3ekKdMWS0A6xOgBOnakaf3ANcZDs7Iga1ii+rAog479DsI8H5XH0zgiSlkl?=
 =?us-ascii?Q?/aBzPyHrfnyHm6k+Z1XpYaWG3QYIC/l386a37Je9QZP16+B3iMhNXN/6F+q+?=
 =?us-ascii?Q?uLC8d7Pc0pEUy/edQWJOzKwUXll5zVTkJfY8rkKUOiJkb9xPli7hQ3hc9mr9?=
 =?us-ascii?Q?trjKIgfoe/Sux0Jku6px2gXl0KsUEkm7/xdRn5ixYKVRWKWlhJ3WlQdqBCex?=
 =?us-ascii?Q?429J1Ah6O6RrvAIAv8GBixx6hGU4TTfSRSayUIeYXOJJItBnQmebA7Xm3zMw?=
 =?us-ascii?Q?6QYXpMw0j0h4CmZ7mimYq4VxQNoKp+h5CFuFq1wu3FKgfziJcL8xwFo/qf9B?=
 =?us-ascii?Q?zrgC5UnXy/Yt8+dETWxJv9kEbLsVaLp4T3e75taGKk1NyTubh+O8gXb2go7M?=
 =?us-ascii?Q?FDUx74+RqEISlKDkPUPCr45TEdO4gJEJPuo3V9w3sM5XVURQJzpvZmYlqKd7?=
 =?us-ascii?Q?A0sLE5r8W3VUF9oBjxWQbxxK82AVaRFhlNapRbb5zuS5ErGMQzxR6WlF+tVc?=
 =?us-ascii?Q?nyrP11MzQvBAPt7tcMexKFWBUu9vUEZXFjWKcga/lsng8NYVSSWgYX9nqR21?=
 =?us-ascii?Q?kGC3lh23qYCpdg2axPGhUc7+oF2uYgTAF1PZ9a5gw2wHOuu98qlaT6XwL23D?=
 =?us-ascii?Q?69o/yXZrCmAVlz9FFIq50VxNcVkCNhpL92HE?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aQpGK6992092kKAjsoQx5sTNFLNdE8LyhkT8wcB1dtVPgiR3+S7M7QPlM5XSBwNsREwSQjQPmSHgoHi1os7EBes0QhMbKToOXlM4PrGnVUtesOjlzJ5wsRR/cRgrUA5nsa+Gki58n/yLsGolrSkOL9gS129JKWXRc/eJtuqXWDfundTA8klP08jFRKSu0InYkrnNeMrLB2c8tZAJzyuzBWJChtOjYlZZzdL0FvI/Y57r4q4fBlL6mb5rQNomv5F/9SCewNXLuVcJCVgD/J7Wz7vdBU+uNBuyHHP8b/ln1GdTfpturqwnyouF62YHN7EKBicDVv2sp3+8kIr3QLNLITQ8k57C5nBQGtMFcrQjFbb9S0DBlXZh4y0TSpx2vp9iiT28jUvFezT5fZBtA8DT/dOo4a3xrYRBWV6qusjFX20i6KmScQhFgbxuGI5RBuM3qY6EnRxrfIbsH6e/BRct63Ir8UtBhuj5miQtNRVFQUGvDWPR+G+OjvS3qPnbzAutxLiHVARi/N06Mz/TYn5DJESidM5W8P3UIHwJG5YISKZDKGaHXxUSKF4HOW4kdRkw8DhIazFCVQ9QMEhsXfbECgkRfhU0Ve33O9gV1zO0KktWMluGyGPxxh2BbBfWG8s8jC/8/f4c3R2laNr3KE56X/qrqwZ5Bmalo1xKRrXJLOs=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 11:27:33.6306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fc280c-2fc2-49b3-f8e9-08ddafed7394
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0716
X-BESS-ID: 1750418855-311595-7696-15915-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 40.107.159.98
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYmlpZAVgZQ0DglJdHC2MjIND
 Up1dLIIsXc3DLRzNDY2NTQwjTF1DRJqTYWAA3MiFhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265470 [from 
 cloudscan18-133.eu-central-1b.ess.aws.cudaops.com]
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

Perform unmapping in a default container, which is used by queues.
Handle multiple mappings when IOMMU is unoptimized.

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
2.47.1

