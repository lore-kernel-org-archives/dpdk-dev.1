Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF98C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA65040430;
	Wed, 30 Apr 2025 15:49:22 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 58B2540280
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:16 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113]) by
 mx-outbound8-212.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrExuKQ4/Tff6G6bx6j983goS6xSbYsPqM21KGHIV44t1X1T//2cwc/UWKDvBS6WpAb3JgkvQRJRqtPMRuc4zd/+a/V2kmuAk/LKL+0/NSjvj14oIYxSbMx8H7rhm0ZnRZAneggUwAWCFOMl6UFzXAuI8xFZAqbThRtFY93PtlHWfv53KYFVrtYETj+sm/mf2BE//fGpKTP9kG97NXq4fkK5v2sT/77vx14jhQ47/L4rqlevoBG863tghZNRFU9IJfUqQUrBwN0rB7BCNmRHCGGECk7Ouasnl88BSZ7RrXxaA2hMn2sqF89M/BI+FXnl/i4KD7JXVNNYK+fBcUQGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqYYkwC3U43tlwmtP9h4dx6p3fjaeQwBcrw800RUgAE=;
 b=fpVnGMiScZJbbgt4fLqI3L0hfD4ZSdnPV3IXtCEy78ygFkMNkZvglun7qt4nqjtDq9TEkQW6Iz/vJVzTleCkdLWnv5xWi3vFWcAnflvozR2soKqaF3sYkdR7u+dvHjLR4J22q7JFVtdqPwvT3P1KqT8IjIMk2KZXHvuyX8iSCxJ8f3Spdofd/746bIAOKhj2Zr3jm7jN5qX0dWVG3gGilresdTUKvgssN0RGT536M6ys51EeI6aFHUVOaYXPfHBEPeGpKzQgtMwVcPzQOjCS0MtQghlad+FZnTglhoSOsHr7bQJ5BXf2QFhCDeivGeZ5FmvJOVmex0sI+1fX8GSHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqYYkwC3U43tlwmtP9h4dx6p3fjaeQwBcrw800RUgAE=;
 b=V0A+b2F2S/Zhbxs35gPktQVV+nIG5b52iq6w/yoGqKtkVcQwaNbbOVCQQOdtGRLb+/Gv486lCpH0ljc68OgxemmE7KMl/tthQBpbIfDQDUCAK2JT/OIJiO+H8ds6DiaxFigHvw64twJVHdWZES20Me/1A5FdwccJWCgc0lGLpXE=
Received: from AM9P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::22)
 by AM0P190MB0659.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:198::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 13:49:09 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::d5) by AM9P193CA0017.outlook.office365.com
 (2603:10a6:20b:21e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 13:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:09 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 06/25] net/ntnic: avoid misleading variable names
Date: Wed, 30 Apr 2025 15:48:18 +0200
Message-ID: <20250430134840.402553-7-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM0P190MB0659:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55f2b598-43b5-46ce-1bab-08dd87edc88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kLlz0UpiR0RyeWT+g3lZwGfHM33Q1Fn99lHoyAJ1qzlzCf34iRb7G6rzblU4?=
 =?us-ascii?Q?etMd8kunVcnM96djAEE9Qc68c0PaguLCFei/8PdS+jbOk9J+aIqdNhoAZzGY?=
 =?us-ascii?Q?w+EK/of4NRCIFHKyKoB2nsyjG1yPh094TBS6e9GoJMczhcVx4nvrSo2wE6+w?=
 =?us-ascii?Q?oJKCv7v1gwLLFnh72Hj6eTzTh7c33B62UjS/YtcEl5d4Voqsm8eY658OEiVP?=
 =?us-ascii?Q?ldPBsxzMa6/RKCm1ArPtkHpFB5yrAo7BTsX56r+K6YZWg8ZJFE9QxUlLuioK?=
 =?us-ascii?Q?t0I4Zkan5ZEA/cuBgRJaYi38WZtfgsgOddd3djqSixbeJCiTIpbDj34Fulll?=
 =?us-ascii?Q?mEnphsVhPA6xf6jVg7B1UDf0I94YD7ozvnDBabrkJEAueT99C/zgFDfp+EiQ?=
 =?us-ascii?Q?b6PGTKgyd4J9IKh/N+dgDY4BcAVpGGPzjj9lK+pnF72VyhjQzY06xK8NMbwq?=
 =?us-ascii?Q?xOeSiHvEOvXZS9OdfMurgP6GTuA67VCjwVqbmA2K7eEOHPKKc7f+SkcEQY5h?=
 =?us-ascii?Q?9bVlsd0LabsSmqXjnaMQE6tcWM3WV3d005mWW6bSA1ZVGS6LctTGSjEIX9xk?=
 =?us-ascii?Q?SNkXeBa7W3NFbDkrzIR2rBnln0dWHxKbe+Dv+Ojp0ydT5j0u1z4NTUR5+ViY?=
 =?us-ascii?Q?vphAbcQ10dJ+sUX18fJWwvthuhXOTqU3lx9vsHqwcTTQ19X0M8gTIw7SLhAG?=
 =?us-ascii?Q?a2b6LEOoVOoFn+z/2HyXArKd2fPcaK+ddzJFM0zvYvi4fuog3bEy8QgslDT/?=
 =?us-ascii?Q?O3Ou9bMcYhzB7j2kQ+Spudu7m+MyYENgT+Vobmz4L6YinQAzTVZuRuze8WzD?=
 =?us-ascii?Q?zhCK+YQRjB1ST0BcX0qIkr5eZ0AX8/m4Fya4wKBYDR6LvClFCBB62bbD42Kh?=
 =?us-ascii?Q?ieeHZu6iY+oUZfFaSILJ1Wkdxy2jjkgBtS9Mos65z7Lr9sH13vQv84C4BTyl?=
 =?us-ascii?Q?l0mX9Lf97gZbi/DBntL9Sl3GTCgrcFDfb8SqgNpAkPdXm19VJUEvQwbtBCYV?=
 =?us-ascii?Q?f+qoIl4eGXdETVTPGnn5LqFKToWfx2AGtk678KTMBMExbpFntFShu64HNdim?=
 =?us-ascii?Q?bbEt7F8Mw1OhgL/r+WleOaTe77tDcK+1y/hRBmxX9Xk3dv4bIWYDQoRAV/ZD?=
 =?us-ascii?Q?W1xw95bXRF6CizSjYXNOW709wGY01xqUV6L08h7lkQRUFWwJqXqD1v0T9ZiJ?=
 =?us-ascii?Q?lvzqLsFmBEnt6ivYn1uatUCik451oQkZh7A+Th2pk1m+2zRARsH6tZeD7WDS?=
 =?us-ascii?Q?GRjIdkWckdrnKDqst8S81VSjsDEnSK+cppSplvT+uX+PFCvn7Y5L/CKoAafo?=
 =?us-ascii?Q?6hlmszgWEj5foIHj076MY9E/wipUqH2FWmcl8RqjQAH+7LTxvjmofdayzh3u?=
 =?us-ascii?Q?J4Tm9QaAqALx3NTAKU63qIPRzWlaPRqFmS5h/6TKona9MjVwtkBKaOzpeaSC?=
 =?us-ascii?Q?Q74OVya3BbuEeZu+A3z2E7x25GbeRsrTz5dW4E1cUckaXSBHRMs+iKXyWD5X?=
 =?us-ascii?Q?5wkD+0Fc7mbL2+g+1x3utXXI3IC1hXDX15iu?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8OCtpna9IOWHbp3ht5t5uwc7KCqSfa2DdY82IVWQ4lBRKEqYajDcim/DzSDxuJyjc5ylZUBc1Ld9Ju1n00EetgbiwFqSjWJ07sEmR40QjMGOzX1p+4JUcUxKJoHKDZm7EuS4yQPZ2DIJc0mZGSJfPIB1eGxVBtntDljsV189P33x/uequ/e7ImCo1g0iQ3VNgwPv72qpkk1lPZgPqkPBslEpZbCuJ5Bmy2xS2mlzfGtvFtA+FFG2PPuJ6iXoy9FJacWwRjjTrK/2QFMQhGePcVvea1IJlSJ12eFKfI4Fykay+gnT6C7+J3W5L5zBFYy0FrjyClOp7XBvDcTtnv43NFNNX1mk6M+egY0HM/qtAehBPsdJARBzNBArjKqxC2golRpumuxZhpY6Pu6cEfJbMI4fZGjExqIT1Ahq2kOZ2R3g8j/p5jzjxqTzJfmNcUJaM4T6CZWt/JUWEMBl8ix8rO4QSzHU15bRHYfwa3izA109RnI83fff43Pa0IG75lBGLkhAJAMfTyaptRgbtm9Tx3gaGa+QET/9SOrX8KuV8JHnGgQ6ne3QKfeif6QX0u/wVooES53XHk0PLrCansXevt7ZAW0FCpEeg2JXC8IRGW7sX7dayfM1/Reow5Lu89QPzyO271BUMjik0z79rwQDGg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:09.6834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f2b598-43b5-46ce-1bab-08dd87edc88c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0659
X-BESS-ID: 1746020952-302260-7744-9111-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.18.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaGpsZAVgZQ0DLVJCUxLckwxT
 jRONXY2NjS0swiKcU8MTHJwCIlMTVVqTYWAJHMHcNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan15-165.eu-central-1a.ess.aws.cudaops.com]
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

