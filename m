Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D09C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 457D840B9C;
	Mon,  5 May 2025 09:13:48 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id D8B4840A7F
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:44 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 mx-outbound14-199.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9oKqfp4TN3KZjIy/ciHl/UnzxiR7/Qj40g/wPxuSM0dfqj7mqbMV2W3bU21ne6Yu01JIAHXzPEsWnAcQbJIt3eA9aAeT2oqwbegkcci1hM7vpv1tXk5OuUG0VQR7mFkJW5sjzUGyKjmZH+k777O6+K1ryBxyxW0jMa8i2q3Ya/EpmBfDvVPRbQ/SOiSYtdkX3m/i7aeY6AcTySh6dVleZip/MMbCxrGqTiHZRWbiCqkBVTafUiSN+O+F4BjDOju1+If5xbubvMz4kXBzbjWozl4ADWb1Sg/WC/eCAS3sObZSPu+kRAXtTnPH8/DWvDlk5QmpFckUGy7aiHbGf9vDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqYYkwC3U43tlwmtP9h4dx6p3fjaeQwBcrw800RUgAE=;
 b=DvS9/q2UJIbRaSvoAzH3yjud29zwRyDzmoUc9yEwr3YNuA4Mv//YesJs2A7PrYYfY8ve5RypHuEw0NM8M4bgD2/5mH3kKodw1InewDl20MsddLUVoCSw+2VX9yVU0L79ChZwIO4A8rPOkS5WSoL9MqzzOdSjBhjYWmpzwXHZDuphzRi57sIAVohnxlAzN/szWdYaeeZAyAi441wl9n0d9cCAqUM914bblo0YO302f/M9oAj2jS021ME6XaonFIexCmMjcfyvllkcy0ABPOfQmIPXm9fdYHrxF8Sm45n9hYbmefupVGf4J8QVnzTrtmCC3sgUQugdmXpQa3A1yAQZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqYYkwC3U43tlwmtP9h4dx6p3fjaeQwBcrw800RUgAE=;
 b=doSSIjI7vX30tdH+izKeDHfH9Kby7or5s6ToKgyNQwX3+ysLBrxXwRhRGZo7/H4eUljXL9qbUG9gaX/bQFKF3qIvgE1PObtKmF3SIVy8N1p+EiIG5fg0+VmQDeBP2bEG03Nm85T9W/VbvMkv4QEMTLbm2LrdMKRzQDhbNu14OnU=
Received: from DU7P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::28)
 by VI1P190MB0703.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 07:13:17 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::82) by DU7P191CA0005.outlook.office365.com
 (2603:10a6:10:54e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 07:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:16
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 06/26] net/ntnic: avoid misleading variable names
Date: Mon,  5 May 2025 09:12:46 +0200
Message-ID: <20250505071309.586015-7-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|VI1P190MB0703:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03181708-bbf9-4067-5868-08dd8ba44e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/DKuwyFrft4lwxmnhp9zn330Lhd9MAuRmr5er3idkVCHvlhK8PLxOyxelUb?=
 =?us-ascii?Q?Skx8PJHry8tFleKhxETFTOtj9qX45n+Bs1+oMsCs40Nz12SLfO5R7wXF4trs?=
 =?us-ascii?Q?HLde3vjynZQbiYoCja4HbeMQcspkwde8XrvW5HPwvDkWhZ5JBfX9pXZjnbx3?=
 =?us-ascii?Q?2fLmKxH74loDnEx4936nXqVXJN8ftRn2I0J2+PvYJcOB8RKGwyKa8AK9k7bY?=
 =?us-ascii?Q?fHjpAZ/qQm6RpXMa0kbFdeoZXWwNYSgVrAlRpMtr25rEn1W+1P+2c3rgVS3h?=
 =?us-ascii?Q?WgPPv+bMxlFa5M5LTsACh0vC3b9TOaTgs4KfvYVJx7AWJdwv5UeeZXYwqQQK?=
 =?us-ascii?Q?1sJiSWQ2WqdMMja0bOqwJg/5FOaqR93QCUg2o3z1NWPXy+RSlSHqSpKVLKe3?=
 =?us-ascii?Q?zHvN5xxY3zzYNiTDmstwzelss7EXFw/ESnFyK4GW9+nXGcIPPbIHEB0C6wfc?=
 =?us-ascii?Q?SCP/xBVgYPWuDdtPEtptsq9Ao0jx/XvPfRT1xR83RGyh0Xu95m59QC/LTLTZ?=
 =?us-ascii?Q?aXBAik88sMgZiDfd4WXUGDkLKzgVfU8tC/brU97OpEAXg2Z9yrux0ibaWkHa?=
 =?us-ascii?Q?dw/Aw3bw3osPLLzPrACsDGVNaMt7BHbRog/sEcj/zsZVSf34tLca6quU6nmt?=
 =?us-ascii?Q?OJm4rCgb+QrMp1A2nSrCyeGQHarD2W2oMabBkzmmpo4+Qw6TYLfNDPrZctVQ?=
 =?us-ascii?Q?Ve/TersECwhMfxE/0fZyII8NZS3s56L14zJ/tD40Miqt7rzsmOW04LtauRsG?=
 =?us-ascii?Q?xe5zsgc911fYme2TDXepOpD3ca7iD9OF0Ago+Y/G5C9ha6lgGVpMmozTLNMV?=
 =?us-ascii?Q?BT0GxIeaKhyXaO9ItjYqX9grcEk1gYj0YbKFM5rpiziqkyalxC9gPUbL802H?=
 =?us-ascii?Q?52yho858BPi1qiMaABfDX8EURiw7nq66atENWA9cYUcQikaEP8l95gFXLqQf?=
 =?us-ascii?Q?0a9wQwbCqkMZtlkS+q1USjgD0Zot0yDKaVP6S34Qnl0c5gvT8XvFSquvUi/3?=
 =?us-ascii?Q?6hSzxg/LT2UUr9aPbnzIHUJicXpitQRHQf4V3Il9NUHT4kpmJ8CHwYjYI9xL?=
 =?us-ascii?Q?00Tx4lGpilZYMVlAle6Gv2emP+ogns9Nmt3LxzHzeBN5MPWa+F4+o4COkqAR?=
 =?us-ascii?Q?54SinCTq7yL8sA4rvSaY7fVgoyBoXPn+dsz2cedojatMHtjKHBYtNi+gbZbK?=
 =?us-ascii?Q?0RKGK/CZbgh3o2eLk0RathBdXqLD4Qq90i5ppsmwb64OjAQQb1hkIISGoB28?=
 =?us-ascii?Q?EAet5DBkRndds30LA9uQ1CUYtStiiSrE8hUx2uGWv5Gg6DKqLYphPraac1Pf?=
 =?us-ascii?Q?ArvS/75h7LzbixZoDJzZlxW8Z/gud26/FroIS4puYlZUltYtOrDLx6HiF5ca?=
 =?us-ascii?Q?3gYiiUP7JyFZl6TZaDs88Ou1hxW7TAdtS8zQQtYH6TjMyDIguy7hROAN6kqb?=
 =?us-ascii?Q?irDX+IwT9c7fsjJbVxi9Qo6sD85au1f2TATTP+UzaqIfOjTuSIkQF/RBWlBW?=
 =?us-ascii?Q?/U5zpFYpwDRa5cXHtMLIIu7MGRm1W5dAZued?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6szwddRx24PkorSHyHnKF4kAFusXMc+eD2vSbgJeLKXJO/H2qApqdAivBoQaAGUImMFiO+xO06Xk5hBSL7prNsoKv+A9alattIHH4l5FaDm5Ze3aD0EhsvD7Vd0vnOKDyPKqKvh1dmjcKTKstPuoLPCVc5FpQxbx8Jfj7oNuQNvAESJ4ysGDTJK3/phKy+jUSJkaPB64tm73pd3BKkD7SuMkkyiHAvdSEXNBPcXPYWRc+2cfpbZrcMVoDepBVHQsC8C1oNcBgg/u84p+t1qmh46aTcH8yaSbSZdZ06og7JoY+/PfWaLsy+ma/BXZGpYeBcGYfHxBSE4h4R/wx/PDZlzrVS1z7vf3E7MhEwrt0bmX1rXGwYDKHah75Yw3z4hvQ1/4RopWu4UoakJD/18n1XzlpGIFZkfh0zDI9nae6bfK8LSOtmTJ1yRuDbxEyl41Hyz3+2wXtynZDBQByOfalR9XfXdOTVzrEeMWCxKa34XGtqnkN/F77/+mqrnhEoNDe8NpWUUAmgUYqTJGcslzjEXpxEMHxLajgL4OJZYm2J10yR63BIvzX/kTX1KQqV6SxuI8VfgJydF9dDY+0vnFii2lHD16KJFeF+cSJb/atEP7gf6OSyxr6s1MWhPnFsJWa2O3Iqy2K+Cs5rCd+6JIfA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:16.4026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03181708-bbf9-4067-5868-08dd8ba44e94
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0703
X-BESS-ID: 1746429200-303783-7661-382-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.18.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaGpsZAVgZQ0DLVJCUxLckwxT
 jRONXY2NjS0swiKcU8MTHJwCIlMTVVqTYWAJHMHcNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan12-166.eu-central-1a.ess.aws.cudaops.com]
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

In the context of the NTNIC driver,
the variables named if_index stand for the index of the PHY.
However, the term if_index could also refer to the interface index
assigned by the OS.
To mitigate potential confusion these variables were renamed.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c              | 24 +++++-----
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 44 +++++++++----------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 6857191ef2..6ba6769e47 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -181,15 +181,15 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
 	nthw_stat_t *p_nthw_stat = p_nt4ga_stat->mp_nthw_stat;
-	const int if_index = internals->n_intf_no;
+	const int n_intf_no = internals->n_intf_no;
 	uint64_t rx_total = 0;
 	uint64_t rx_total_b = 0;
 	uint64_t tx_total = 0;
 	uint64_t tx_total_b = 0;
 	uint64_t tx_err_total = 0;
 
-	if (!p_nthw_stat || !p_nt4ga_stat || !stats || if_index < 0 ||
-		if_index > NUM_ADAPTER_PORTS_MAX) {
+	if (!p_nthw_stat || !p_nt4ga_stat || !stats || n_intf_no < 0 ||
+		n_intf_no > NUM_ADAPTER_PORTS_MAX) {
 		NT_LOG_DBGX(WRN, NTNIC, "error exit");
 		return -1;
 	}
@@ -315,8 +315,8 @@ static int eth_stats_reset(struct rte_eth_dev *eth_dev)
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 	struct drv_s *p_drv = internals->p_drv;
 	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
-	const int if_index = internals->n_intf_no;
-	dpdk_stats_reset(internals, p_nt_drv, if_index);
+	const int n_intf_no = internals->n_intf_no;
+	dpdk_stats_reset(internals, p_nt_drv, n_intf_no);
 	return 0;
 }
 
@@ -1529,7 +1529,7 @@ static int eth_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *sta
 	struct drv_s *p_drv = internals->p_drv;
 	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	int if_index = internals->n_intf_no;
+	int n_intf_no = internals->n_intf_no;
 	int nb_xstats;
 
 	const struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
@@ -1540,7 +1540,7 @@ static int eth_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *sta
 	}
 
 	rte_spinlock_lock(&p_nt_drv->stat_lck);
-	nb_xstats = ntnic_xstats_ops->nthw_xstats_get(p_nt4ga_stat, stats, n, if_index);
+	nb_xstats = ntnic_xstats_ops->nthw_xstats_get(p_nt4ga_stat, stats, n, n_intf_no);
 	rte_spinlock_unlock(&p_nt_drv->stat_lck);
 	return nb_xstats;
 }
@@ -1554,7 +1554,7 @@ static int eth_xstats_get_by_id(struct rte_eth_dev *eth_dev,
 	struct drv_s *p_drv = internals->p_drv;
 	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	int if_index = internals->n_intf_no;
+	int n_intf_no = internals->n_intf_no;
 	int nb_xstats;
 
 	const struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
@@ -1566,7 +1566,7 @@ static int eth_xstats_get_by_id(struct rte_eth_dev *eth_dev,
 
 	rte_spinlock_lock(&p_nt_drv->stat_lck);
 	nb_xstats =
-		ntnic_xstats_ops->nthw_xstats_get_by_id(p_nt4ga_stat, ids, values, n, if_index);
+		ntnic_xstats_ops->nthw_xstats_get_by_id(p_nt4ga_stat, ids, values, n, n_intf_no);
 	rte_spinlock_unlock(&p_nt_drv->stat_lck);
 	return nb_xstats;
 }
@@ -1577,7 +1577,7 @@ static int eth_xstats_reset(struct rte_eth_dev *eth_dev)
 	struct drv_s *p_drv = internals->p_drv;
 	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	int if_index = internals->n_intf_no;
+	int n_intf_no = internals->n_intf_no;
 
 	struct ntnic_xstats_ops *ntnic_xstats_ops = get_ntnic_xstats_ops();
 
@@ -1587,9 +1587,9 @@ static int eth_xstats_reset(struct rte_eth_dev *eth_dev)
 	}
 
 	rte_spinlock_lock(&p_nt_drv->stat_lck);
-	ntnic_xstats_ops->nthw_xstats_reset(p_nt4ga_stat, if_index);
+	ntnic_xstats_ops->nthw_xstats_reset(p_nt4ga_stat, n_intf_no);
 	rte_spinlock_unlock(&p_nt_drv->stat_lck);
-	return dpdk_stats_reset(internals, p_nt_drv, if_index);
+	return dpdk_stats_reset(internals, p_nt_drv, n_intf_no);
 }
 
 static int eth_xstats_get_names(struct rte_eth_dev *eth_dev,
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 1beba22b9d..29bfb2a121 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1155,10 +1155,10 @@ static int poll_statistics(struct pmd_internals *internals)
 	struct drv_s *p_drv = internals->p_drv;
 	struct ntdrv_4ga_s *p_nt_drv = &p_drv->ntdrv;
 	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	const int if_index = internals->n_intf_no;
+	const int n_intf_no = internals->n_intf_no;
 	uint64_t last_stat_rtc = 0;
 
-	if (!p_nt4ga_stat || if_index < 0 || if_index >= NUM_ADAPTER_PORTS_MAX)
+	if (!p_nt4ga_stat || n_intf_no < 0 || n_intf_no >= NUM_ADAPTER_PORTS_MAX)
 		return -1;
 
 	RTE_ASSERT(rte_tsc_freq > 0);
@@ -1184,36 +1184,36 @@ static int poll_statistics(struct pmd_internals *internals)
 	 * Add the RX statistics increments since last time we polled.
 	 * (No difference if physical or virtual port)
 	 */
-	internals->rxq_scg[0].rx_pkts += p_nt4ga_stat->a_port_rx_packets_total[if_index] -
-		p_nt4ga_stat->a_port_rx_packets_base[if_index];
-	internals->rxq_scg[0].rx_bytes += p_nt4ga_stat->a_port_rx_octets_total[if_index] -
-		p_nt4ga_stat->a_port_rx_octets_base[if_index];
+	internals->rxq_scg[0].rx_pkts += p_nt4ga_stat->a_port_rx_packets_total[n_intf_no] -
+		p_nt4ga_stat->a_port_rx_packets_base[n_intf_no];
+	internals->rxq_scg[0].rx_bytes += p_nt4ga_stat->a_port_rx_octets_total[n_intf_no] -
+		p_nt4ga_stat->a_port_rx_octets_base[n_intf_no];
 	internals->rxq_scg[0].err_pkts += 0;
-	internals->rx_missed += p_nt4ga_stat->a_port_rx_drops_total[if_index] -
-		p_nt4ga_stat->a_port_rx_drops_base[if_index];
+	internals->rx_missed += p_nt4ga_stat->a_port_rx_drops_total[n_intf_no] -
+		p_nt4ga_stat->a_port_rx_drops_base[n_intf_no];
 
 	/* Update the increment bases */
-	p_nt4ga_stat->a_port_rx_packets_base[if_index] =
-		p_nt4ga_stat->a_port_rx_packets_total[if_index];
-	p_nt4ga_stat->a_port_rx_octets_base[if_index] =
-		p_nt4ga_stat->a_port_rx_octets_total[if_index];
-	p_nt4ga_stat->a_port_rx_drops_base[if_index] =
-		p_nt4ga_stat->a_port_rx_drops_total[if_index];
+	p_nt4ga_stat->a_port_rx_packets_base[n_intf_no] =
+		p_nt4ga_stat->a_port_rx_packets_total[n_intf_no];
+	p_nt4ga_stat->a_port_rx_octets_base[n_intf_no] =
+		p_nt4ga_stat->a_port_rx_octets_total[n_intf_no];
+	p_nt4ga_stat->a_port_rx_drops_base[n_intf_no] =
+		p_nt4ga_stat->a_port_rx_drops_total[n_intf_no];
 
 	/* Tx (here we must distinguish between physical and virtual ports) */
 	if (internals->type == PORT_TYPE_PHYSICAL) {
 		/* Add the statistics increments since last time we polled */
-		internals->txq_scg[0].tx_pkts += p_nt4ga_stat->a_port_tx_packets_total[if_index] -
-			p_nt4ga_stat->a_port_tx_packets_base[if_index];
-		internals->txq_scg[0].tx_bytes += p_nt4ga_stat->a_port_tx_octets_total[if_index] -
-			p_nt4ga_stat->a_port_tx_octets_base[if_index];
+		internals->txq_scg[0].tx_pkts += p_nt4ga_stat->a_port_tx_packets_total[n_intf_no] -
+			p_nt4ga_stat->a_port_tx_packets_base[n_intf_no];
+		internals->txq_scg[0].tx_bytes += p_nt4ga_stat->a_port_tx_octets_total[n_intf_no] -
+			p_nt4ga_stat->a_port_tx_octets_base[n_intf_no];
 		internals->txq_scg[0].err_pkts += 0;
 
 		/* Update the increment bases */
-		p_nt4ga_stat->a_port_tx_packets_base[if_index] =
-			p_nt4ga_stat->a_port_tx_packets_total[if_index];
-		p_nt4ga_stat->a_port_tx_octets_base[if_index] =
-			p_nt4ga_stat->a_port_tx_octets_total[if_index];
+		p_nt4ga_stat->a_port_tx_packets_base[n_intf_no] =
+			p_nt4ga_stat->a_port_tx_packets_total[n_intf_no];
+		p_nt4ga_stat->a_port_tx_octets_base[n_intf_no] =
+			p_nt4ga_stat->a_port_tx_octets_total[n_intf_no];
 	}
 
 	/* Globally only once a second */
-- 
2.47.1

