Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2724C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B943B40DC9;
	Mon,  5 May 2025 09:13:49 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 880AC40B92
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:46 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174]) by
 mx-outbound45-79.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSY5yhyfyls4JOwvnS6U/dekGCA02qstmzFR5Hj2uOJp7nrKvW9188jtfIwXmzpcuSegMFPwYwF+gA7J240ZaEJYmnT/3xVe+KPgMcmNHLjqFdVYi2kXLlO1ojv42er6q3TRHFhW7cLGaS7OKduA2PyLY5F9zsOpT3cPWaIh9voYBj0sAoFHS89G5HCdDlhGjwCRu5rIeWTLo/6geWUWuJEsKYhV5P17uwLQ6rJ7TVBuSZskhCQO5pwpyHAqXllLwlzTeZG9rP+UTHGRbJda7YVUN0JKGkq8t/LtMixjd96n+epM3QNzTaoQ8/iSM+9H/ZRkl0NLINEowWsILKvBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0MUiSxuB4W0fI034a+KbuK01Y6Ig3Jf56H8CMXnKJk=;
 b=oUSjRx8VbvVoJNnTd5C6ArRd8q73gbOix/Go6idssz2q99dKrPNXXmZKBjgt8iE3d1uGtX0QeoWw9Qe80uBkZrm9mb17WijwlOuCVeIGquBDRN/RmGBEoTqi19O70WrP2FGB0V2qAnJdyzyDNzZEiWb8qirK8zaHZ0JzxgPWYtsA6NLRF9iaLrOkbN2PJhPbnaLPt9z7qjS5DqtYTz5mMMieaQbfRfjsDyJ2rZsqRbvgO5hEWTAVYZ/x7uzpJ+q66x0j6zxOnAZK9ceIVsNx0LT8VHp76HAe31UUtcjl2+2pXUtxgvdV7JKU9tii6fls+xhhWVUAd5lrCtN9LytVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0MUiSxuB4W0fI034a+KbuK01Y6Ig3Jf56H8CMXnKJk=;
 b=eXI/jPe8iC7U9+ldsjS3yRzNIviriR+NOgThuw5bEXjowgRYntXATMi/swnLJfKUCHyFTVsrdzzQgM53K4VCYIgUL6yiKKrZzYqDzpq/VKId8MKAQwmHSxJiS6MVVOzEVOiXBJLu9YqSEH7v24xVMsHW3Ky8mZ1q96/N13fePo4=
Received: from DU7P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::35)
 by PA2P190MB2104.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:40e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 07:13:24 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::da) by DU7P191CA0010.outlook.office365.com
 (2603:10a6:10:54e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:24
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 16/26] net/ntnic: remove redundant initialization
Date: Mon,  5 May 2025 09:12:56 +0200
Message-ID: <20250505071309.586015-17-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|PA2P190MB2104:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c3264c5c-aaf3-47a1-c9b7-08dd8ba45346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Y5zqV6tF3bRt3EulaXLWzthJf+bw7yDtujUVLJ2F35dnSt2t1hZOxhvZkYh?=
 =?us-ascii?Q?C+xRMP1ri9OcFVDQy6mqj5/mrQcRhqVuO7qW7zpiBASVGz+qNJ7br+REK7zU?=
 =?us-ascii?Q?kvk9nZ/cnOIeK4MLNzsaKT0U58XUl7S2+mPKi6TCpJ6v3v6fZtF7e5622u5t?=
 =?us-ascii?Q?caQeX/T8HHepLBi77pSov4JGS8BKm1+dQb5AeOCB3nCENbLAA1NmMF1//TPA?=
 =?us-ascii?Q?WDqo2AA/jnXRR48tMGZUF8oZeObYuieyvoMoJLnl4YFLfZWcwDRxQEwD5DYo?=
 =?us-ascii?Q?egsGrV2uY8FeFoyBHbxvYISPn8iYXgvoOQGXYWAdRU0SL0KhErkS2f7vwavQ?=
 =?us-ascii?Q?ZjF5S4Z6k+kO1jIneoQOT0x67sPLJkzo42n4TsxpD7eRBWAttzXdG02RtPsY?=
 =?us-ascii?Q?gNMovOFTO3uPgnMhX8tjgCyEvm4hrrp0UpMvEIPdD6JZRVzv6cjU8qgkPbVp?=
 =?us-ascii?Q?6kKHkUScVug7FxhtnWUbUPoZa68T1Kx/KrA8BR5nc4wRxVnwngBJ+nYbr/aW?=
 =?us-ascii?Q?vjD+btYzWB8wvEEOfJ0qItXyJdQAcXPUJxVtZFf5Hq6GxmDFi4cz2W8UO9t3?=
 =?us-ascii?Q?Nf0xr7knllb9TUGMKdOmxdbKf+xOAD7ZYsGfQIPO5oJWn/G9KrmI97nUbpy7?=
 =?us-ascii?Q?VBjKXCMV5gWx0VJ5R6++1ThJyBOus+zZGDuKrJ7wIxXt3lvVRIXatJtxFpAl?=
 =?us-ascii?Q?YwAAFvGbrgCO7pGQT4nDdUfwtqVlaDKWhw0ge5fLyEPJEzJBDkvJy1MIF3mG?=
 =?us-ascii?Q?HXf4jZDAyDyGuQOw3qcaEOG2UI2eSVGx6N6lOp43IwKxgxfiqIls03o/xgNV?=
 =?us-ascii?Q?bWz/94uq7O4ZK58NytnVX8lLkD5m71e6w5aexT1pHM5ShGjWNIuhW+GCnF5A?=
 =?us-ascii?Q?hoQ/WrNCnX8lOyC7/NKoPOCOEPiCaospAPpSPY9KdvNzkd9N6ZgS7lObkMkr?=
 =?us-ascii?Q?/+cElJGTIFexgYADAq9QsjDmbYcv7sNsTZtzREVTmqIagRIS1U73MirdmHL9?=
 =?us-ascii?Q?ivfGZ+PpZ0qswwf74Ft3dAUA8EKtsQxkZsS+n0lqR+L7tAFVDQsCkEUfM4Vp?=
 =?us-ascii?Q?Tah84bnjqXKNM40d4E0sZvHV2Js9w1oxAijHMtFkm0JeVRHaBl7g8UQkDWjs?=
 =?us-ascii?Q?OU7+4yCvjoYnnpOzvWnle422Zz0L6KATkNTOcAK2k8zvR67+Gr115y4qjg/O?=
 =?us-ascii?Q?kgYdcYjnfxKF9iwGpUMgNRn3SOF4OV15kdIVxIgzKQMkIq43qp81pr9/b88g?=
 =?us-ascii?Q?xRB1AESz288qOotLoqxD/MSIvUS/2tFyHxTadWrcteEw2C3ta4Fkvky1A9/0?=
 =?us-ascii?Q?uPqhrbK0+7TQwfEWyk7kOi9Vxygw1hacRlVquQAg5COhPnwX+pbsQ/zacX+2?=
 =?us-ascii?Q?lI/QK9SZIF/420Lb2SWY/VlytwjX762OCp4C2cSRUeMG7c+gfo8kZworKb4Q?=
 =?us-ascii?Q?KdiIs9E65TgWTCZISp2FUglYqLCLoOGoWj77EZQlPDIuQbNGcLRL4KDN2d33?=
 =?us-ascii?Q?XNw8gitqUt3ps6e8Y77fhX/wJnkDAWBxLX6D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z5wXSnM4ojG8ldqK0ESbQ7uTGGDsYPhlXmYEZJ20vGseTzqs6McREBpqE2ay7EIyc60807Gz4PrM/C3CWPIQX0oXVW91tJWi1GaV9R5q8qfl0OeedXaHSLFdQQR2ArtlcpwqWweTadDMow2br9gwXYrpANE17Mfc1MVHrdjSqVbdfMRil8p4+j+cPZZcWod34QiYEwLOnK+2wgRNGdlOwO5I/lULi6Fnt19/fdbaa2pyKGlyh3cDFOs/ViYkA/5zof4T9jcQIenMArABu4IaXMZ7E3ObnhPyaXRVKj/xmU3EW3QcNmhNrbUTdVxgAfURewpt1NxaFfLx5CpGiFAnOPIKCVP2YxGvEV2PWVTzze8gYvRkLUhRiuEVmY67Qo+KA4oqcJHTecoRjddyU85Dy9gehedhLdbjEHnxe/8P4INPUZpzU5p6eKSA3AOZMahlshFjMMBx8W8Oq4FslPIt3cXJkQYRxXfWBviAZRgfmj4+AJd1HF+ECFrB8OfJEyabxQ81iABk+FGdKz3F//ireTkF3tBB5WQUmJhTxP56eLeKemk3eHw27qHKIJrBrUOfmInIyVwDrSUZsNGURLZ7sdi0T5gMNjHeSKn07zB2f0gegfaBZhu111FERTlaCjqesYHVQjjL7EhpB7n1YVEsWQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:24.2630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3264c5c-aaf3-47a1-c9b7-08dd8ba45346
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2104
X-BESS-ID: 1746429206-311599-7768-357-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWlqZAVgZQ0DjJxMzEyNLExN
 QwMcnQ3Mwo1dDAxMDcyDjJyMLY0NBIqTYWAFw4IAVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan16-45.eu-central-1b.ess.aws.cudaops.com]
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

Some variables set twice in the code.
Fix host side FEC enablement

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nim/i2c_nim.c             | 2 +-
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c | 1 -
 drivers/net/ntnic/ntnic_vfio.c              | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 5e8eeb16a7..c6fa75e13a 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -877,7 +877,7 @@ bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool hos
 
 	write_data_lin(ctx, addr, sizeof(data), &data);
 	ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = media_side_fec;
-	ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = host_side_fec;
+	ctx->specific_u.qsfp.specific_u.qsfp28.host_side_fec_ena = host_side_fec;
 	return true;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 77400d2514..5b2af77f7d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -797,7 +797,6 @@ static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, u
 	/* Find quad lane */
 	quad_lane = nthw_phy_tile_read_xcvr(p, intf_no, lane, 0xFFFFC) & 0x3;
 
-	xcvr_instance = lane;
 	lane_offset = (uint32_t)(lane << 20);
 
 	cpi_cmd = (data << 16) | cpi_assert | cpi_set_get | (quad_lane << 8) | op_code;
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index a62234353b..8d955e8342 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -68,7 +68,6 @@ nt_vfio_setup(struct rte_pci_device *dev)
 
 	vfio->dev_fd = -1;
 	vfio->group_fd = -1;
-	vfio->container_fd = -1;
 	vfio->iova_addr = START_VF_IOVA;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-- 
2.47.1

