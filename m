Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E878FCAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 015AF40684;
	Fri, 19 Sep 2025 11:20:19 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9B4ED4067B
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020080.outbound.protection.outlook.com [52.101.69.80])
 by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS7O39StkZaPbk1Arr5xzM1CycoHOhDElh+ng7Wk0NODgtyrvVvLDkTD716zWhfFqoTfSTcTbRI1dPziqg6RDhAlc/Himw5gWb8uTZVeQ6i/VFJ4MlzTSSuhWGWCvUeg4fHh40RhvB8uJ25qtZIesrXzGtGhWBuIAp70S39GJB5wnxrRrAqOwDUUV6RRU3lQjnsYJiQwFzlZ2yme8cr9PH9nzwZSHEoWwbmHV2Xm57UrrsrVdmwUTYoypxaqetn1Rc7G35otbjZO8C1Vr/fFBJXnmyEAfWXyutReBAnh+t13OWP7xW5iYv9b1RjPs1Bhtov8qhqiEC9byjuNooPFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF7iv9UsIbafGGj4Fi1eSy0lKGhKOV4B9B6zCvKy7WQ=;
 b=dwwelrVn4OIJx67UrGi6L6wuaBGO8Bw9L6m43qVMZ30zDslAAQ3xL8hG10gKH+prO/LDz3vpP30Z6wLQHn0IxeRWC/zbwqXSzb2J3mZ0itTfoGsLJegPKkyFK0+GKkP0l1IDfbW+s+7JQy4JlwFi8OJbAsbdpsvGE+EsusVth2FwHThQavpadKPBvxCBtLkR2hjlBqIVyiBdlh9tzdRvEkGQdAqjaEgWLHvSHfCrM1UoY0qyqdmA5dvYCdrY7ZNcr4fiCAS03p3Rx0DqTVINDwhYgzj+ltJRmJ1HlcNqvOd+ITTjG300UX5HAfEB0Zi8un07ccbtOl+lo3z2mD3q4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF7iv9UsIbafGGj4Fi1eSy0lKGhKOV4B9B6zCvKy7WQ=;
 b=m7tfN2mfzw++dn9kF9xah8NB2ss404VRMpVoBCxcJ411g7FmcrnccEDqVfLXXMbg3R/180kTKmuPeG+hI4ZNb1MLVXgSA14Kv0y18I2vCtkIEVePNw1PhnDfNpPTU2OiqpVrKFrkW/Jhsl6s5YKnwzoJbCXTNW1RSBecQJHkexw=
Received: from DU2PR04CA0354.eurprd04.prod.outlook.com (2603:10a6:10:2b4::7)
 by AS1P190MB1725.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 09:20:13 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::a5) by DU2PR04CA0354.outlook.office365.com
 (2603:10a6:10:2b4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 09:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:13 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 02/16] net/ntnic: remove unused functions
Date: Fri, 19 Sep 2025 11:14:47 +0200
Message-ID: <20250919091504.1548351-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|AS1P190MB1725:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2323989b-f0dd-4463-c448-08ddf75dbd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ziunyXVc5RGdsVt+ULfuxmzQJxdiL99gd0UFtrdW3CJzcJ+0+qXODJMi92MB?=
 =?us-ascii?Q?iEUH2TiD7JGynuiiRr5RBwxDe8xHMVs4fAh5fsQlQqpme8N1Td/NORuZOY3I?=
 =?us-ascii?Q?2HhFqNMKv+ysBCfAxXP5dc+Q0Q7vOBoFSfB0Jeqw+isSqP7I4e+mAuFThfQM?=
 =?us-ascii?Q?dxxBHnAdGHH0rCtQIpKNoUPWBfmf/jgDp9RRxUPERwVquVN72tQFVG34U5nU?=
 =?us-ascii?Q?jExzm2LwWeoee6/JxMH/qPL9Wfuql/7PPtzngZhh4fZjAC88dHEyhRkltWg5?=
 =?us-ascii?Q?iD7Yk6LSgEruEUXymrr3OxuiX9QoNvReXS90Zxx9pz94QO6F6Qo/JUQZu3TA?=
 =?us-ascii?Q?zhjnBaVLQr+vYKPAaXxUaFf5n/5uU4WHDfL6wXOoUVNP1Cte7NWVBUtXcUfW?=
 =?us-ascii?Q?gMjPsvT2X5QJ2dgzoWF1S8x9nX26QnKKD0Cjhj1tuxMHUSq1WRpxeXZRFX5Q?=
 =?us-ascii?Q?uyzjLWnkR58uDHdg/MXxtiX+w+GJ/bgoUhIJ40klwrO6uqyAwAheKEoE0WZi?=
 =?us-ascii?Q?0c0etkgmqOsBcsiDGzjf/+AsIG1DucJikrlxFeyBltz/B4PF+0c+trAf706P?=
 =?us-ascii?Q?d7grpC5uqyhqk5pCsZxG93eEaw8iE7gjB8ag0fsQc/HDyUYCopjIHhKesBYp?=
 =?us-ascii?Q?ECFv/ActUaV1wqWb+Ci48P/kxVKjHi+x5loKTBA6HUI6A182oKeRZeYS8zSn?=
 =?us-ascii?Q?TOxMOV7VX/iP3fS93VFUeZeyKAnyYbmFhWIFA4CXBQOL775HLMdHfO1sam2+?=
 =?us-ascii?Q?f3N2B/QT/n8+KRE8iA+EdvWsyvPKTWhPBz+Kfibnl6dtEqkHOqmvDjLtGXyC?=
 =?us-ascii?Q?uANyvONt0gn80YfbzOy1XiPDvygHaPjUDIqoWHJIQZwMJms7RThK5AByRgi5?=
 =?us-ascii?Q?5UPPXY4Im0UIKKMJUoA1Nl/tzfgXamn5/l9pAOJsWQgPJVZnu5rfG1jOTDJr?=
 =?us-ascii?Q?y/dc+HXxuwlfWdYWE7+5QS0Pogece4cg1RH5z1F1/+/qi6LgFM/rH6F5+o4F?=
 =?us-ascii?Q?Y/EBrY4fqbXQ/B8qKOIP9IUAJIIniKSvRtzpJMw0W5nYf0fnQVjQVB8fkKRM?=
 =?us-ascii?Q?lSuJNnD/TTkQtradbo66b+CIB8Wi8Zffah9Fevh5Uieq5owADGFIktMBfgRW?=
 =?us-ascii?Q?Uxa4rxjAd+Tw8NJzFGdOvpnb+90aeAeN7L0sSimwe5aDi62GxunJiLNvtxxB?=
 =?us-ascii?Q?i13WvDfrkxq3NmlyFlRSdH0Rhj+d7/Y+rCGLQDxnPYMzf5uEtest71kx9ya+?=
 =?us-ascii?Q?GdyWgVHAAjoVew6hb+7MKtcVXbzWBLM6Zi8bO42qHqgINf9V7St+q280pL7P?=
 =?us-ascii?Q?yLlDdGRtK2Qldk61OYkDfu3rlA5uZOX3tTRqlKYIsNLS4r5+U/idZa9kmPKD?=
 =?us-ascii?Q?KMoWHnBHc4MIMfhY+yllv0aUlQx+qEGnBqDy23QYo6hf0CvvJdviRYORISr0?=
 =?us-ascii?Q?BUCQRVwUnOswS5gzOS4xv2NoQpA+tuAa/0Pf7e5w7/ojfZGKcrXO9ztU+Ebc?=
 =?us-ascii?Q?gm9FyMkwX+exhBUW8WLahnqd4uckpOGhs5RK?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0PHwCY9A/kBj2nZOsvtlKr9/08/SXyFZiWjPyeZfnxNclpZelHfzZIa9R2uRITtPCmlQOA/p0a+FXgGf6ckginSTM8yHXPMdweDI5xjfB3K9HnJr+pQCc7kHcDA/jBzKa18vGwKg4Ta8zipNzwAKXSESi3SWGBmvTYJMrJ0r5n03LUitM+Bf+dO+FCVO6pjZgpSkHVPCK84uLVGxYwkvX96cYPqGiTABi9paZYpiA485QrAUVwWTghgaKcszCvV0Q3MuJpUF9l75G9SB7OVNlIvzElrWcnntp7fW2wDrnU5aVmHY+Vg0IUE8PWB3Ej6BNK8+3ZviOHoirKEpQOn1nc7mSdqyv/Iki/KYMDKG/zeXr4k8pzGKPbRoj6DbjuDhT/ZR7MY+BRckirF13Ml9emKxPL+uuCqpEU4IZhLPcCUUUqr1OXOEVPo4g12KH8ogA+8JSE7PNCD280iQELB7y8Bv3wqxiEc1cyeTk7w0TntRYjFZ9EjUvYmUwaUper/7g0F8UlqPj2APfjhaDba93/utkmHSy1fwN6/0c+3+h/jw+TFiLlXuPUo6lVNUFpx4Y3WPmvA4wWPe772GTBKAWgneD6KBo3IqW7P6YEyFhrsR61O+6GupQehnSEM5uPkDpd31uYbAKKBkeSTy2351eQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:13.4589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323989b-f0dd-4463-c448-08ddf75dbd47
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1725
X-BESS-ID: 1758273615-304134-7641-1086-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.80
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamBuZGQGYGUNQ80cQg0dggLQ
 0oZGGcZGCalJZiapxkZGxubm5smZSiVBsLAPda2vxCAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan12-195.eu-central-1a.ess.aws.cudaops.com]
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

Remove unused functions from various files in the ntnic PMD.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_hif.c        | 90 -------------------
 drivers/net/ntnic/nthw/core/nthw_mac_pcs.c    | 11 ---
 drivers/net/ntnic/nthw/core/nthw_pcie3.c      | 87 ------------------
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |  5 --
 drivers/net/ntnic/nthw/core/nthw_rpf.c        | 14 ---
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |  6 --
 .../net/ntnic/nthw/model/nthw_fpga_model.c    | 86 ------------------
 drivers/net/ntnic/ntutil/nt_util.c            | 51 -----------
 8 files changed, 350 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index 2899c3706b..015dee1bcf 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -217,96 +217,6 @@ int nthw_hif_trigger_sample_time(nthw_hif_t *p)
 	return 0;
 }
 
-static int nthw_hif_get_stat(nthw_hif_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
-	uint32_t *p_ref_clk_cnt, uint32_t *p_tg_unit_size, uint32_t *p_tg_ref_freq,
-	uint64_t *p_tags_in_use, uint64_t *p_rd_err, uint64_t *p_wr_err)
-{
-	*p_rx_cnt = nthw_field_get_updated(p->mp_fld_stat_rx_counter);
-	*p_tx_cnt = nthw_field_get_updated(p->mp_fld_stat_tx_counter);
-
-	*p_ref_clk_cnt = nthw_field_get_updated(p->mp_fld_stat_ref_clk_ref_clk);
-
-	*p_tg_unit_size = NTHW_TG_CNT_SIZE;
-	*p_tg_ref_freq = p->mn_fpga_hif_ref_clk_freq;
-
-	*p_tags_in_use = (p->mp_fld_status_tags_in_use
-			? nthw_field_get_updated(p->mp_fld_status_tags_in_use)
-			: 0);
-
-	*p_rd_err =
-		(p->mp_fld_status_rd_err ? nthw_field_get_updated(p->mp_fld_status_rd_err) : 0);
-	*p_wr_err =
-		(p->mp_fld_status_wr_err ? nthw_field_get_updated(p->mp_fld_status_wr_err) : 0);
-
-	return 0;
-}
-
-static int nthw_hif_get_stat_rate(nthw_hif_t *p, uint64_t *p_pci_rx_rate, uint64_t *p_pci_tx_rate,
-	uint64_t *p_ref_clk_cnt, uint64_t *p_tags_in_use,
-	uint64_t *p_rd_err_cnt, uint64_t *p_wr_err_cnt)
-{
-	uint32_t rx_cnt, tx_cnt, ref_clk_cnt, tg_unit_size, tg_ref_freq;
-	uint64_t n_tags_in_use, n_rd_err, n_wr_err;
-
-	nthw_hif_get_stat(p, &rx_cnt, &tx_cnt, &ref_clk_cnt, &tg_unit_size, &tg_ref_freq,
-		&n_tags_in_use, &n_rd_err, &n_wr_err);
-
-	*p_tags_in_use = n_tags_in_use;
-
-	if (n_rd_err)
-		(*p_rd_err_cnt)++;
-
-	if (n_wr_err)
-		(*p_wr_err_cnt)++;
-
-	if (ref_clk_cnt) {
-		uint64_t rx_rate;
-		uint64_t tx_rate;
-
-		*p_ref_clk_cnt = ref_clk_cnt;
-
-		rx_rate = ((uint64_t)rx_cnt * tg_unit_size * tg_ref_freq) / (uint64_t)ref_clk_cnt;
-		*p_pci_rx_rate = rx_rate;
-
-		tx_rate = ((uint64_t)tx_cnt * tg_unit_size * tg_ref_freq) / (uint64_t)ref_clk_cnt;
-		*p_pci_tx_rate = tx_rate;
-
-	} else {
-		*p_pci_rx_rate = 0;
-		*p_pci_tx_rate = 0;
-		*p_ref_clk_cnt = 0;
-	}
-
-	return 0;
-}
-
-static int nthw_hif_stat_req_enable(nthw_hif_t *p)
-{
-	nthw_field_set_all(p->mp_fld_stat_ctrl_ena);
-	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
-	nthw_field_flush_register(p->mp_fld_stat_ctrl_req);
-	return 0;
-}
-
-static int nthw_hif_stat_req_disable(nthw_hif_t *p)
-{
-	nthw_field_clr_all(p->mp_fld_stat_ctrl_ena);
-	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
-	nthw_field_flush_register(p->mp_fld_stat_ctrl_req);
-	return 0;
-}
-
-static int nthw_hif_end_point_cntrs_sample(nthw_hif_t *p, struct nthw_hif_end_point_counters *epc)
-{
-	RTE_ASSERT(epc);
-
-	/* Get stat rate and maintain rx/tx min/max */
-	nthw_hif_get_stat_rate(p, &epc->cur_tx, &epc->cur_rx, &epc->n_ref_clk_cnt,
-		&epc->n_tags_in_use, &epc->n_rd_err, &epc->n_wr_err);
-
-	return 0;
-}
-
 int nthw_hif_read_test_reg(nthw_hif_t *p, uint8_t test_reg, uint32_t *p_value)
 {
 	uint32_t data;
diff --git a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
index a8d66268ff..4a7b7b9549 100644
--- a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
+++ b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
@@ -429,17 +429,6 @@ void nthw_mac_pcs_set_tx_sel_host(nthw_mac_pcs_t *p, bool enable)
 		nthw_field_clr_flush(p->mp_fld_phymac_misc_tx_sel_host);
 }
 
-static void nthw_mac_pcs_set_tx_sel_tfg(nthw_mac_pcs_t *p, bool enable)
-{
-	nthw_field_get_updated(p->mp_fld_phymac_misc_tx_sel_tfg);
-
-	if (enable)
-		nthw_field_set_flush(p->mp_fld_phymac_misc_tx_sel_tfg);
-
-	else
-		nthw_field_clr_flush(p->mp_fld_phymac_misc_tx_sel_tfg);
-}
-
 void nthw_mac_pcs_set_ts_eop(nthw_mac_pcs_t *p, bool enable)
 {
 	if (p->mp_fld_phymac_misc_ts_eop) {
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index 2953896759..763bf9e554 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -168,90 +168,3 @@ int nthw_pcie3_trigger_sample_time(nthw_pcie3_t *p)
 
 	return 0;
 }
-
-static int nthw_pcie3_stat_req_enable(nthw_pcie3_t *p)
-{
-	nthw_field_set_all(p->mp_fld_stat_ctrl_ena);
-	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
-	nthw_field_flush_register(p->mp_fld_stat_ctrl_req);
-	return 0;
-}
-
-static int nthw_pcie3_stat_req_disable(nthw_pcie3_t *p)
-{
-	nthw_field_clr_all(p->mp_fld_stat_ctrl_ena);
-	nthw_field_set_all(p->mp_fld_stat_ctrl_req);
-	nthw_field_flush_register(p->mp_fld_stat_ctrl_req);
-	return 0;
-}
-
-static int nthw_pcie3_get_stat(nthw_pcie3_t *p, uint32_t *p_rx_cnt, uint32_t *p_tx_cnt,
-	uint32_t *p_ref_clk_cnt, uint32_t *p_tg_unit_size, uint32_t *p_tg_ref_freq,
-	uint32_t *p_tag_use_cnt, uint32_t *p_rq_rdy_cnt, uint32_t *p_rq_vld_cnt)
-{
-	*p_rx_cnt = nthw_field_get_updated(p->mp_fld_stat_rx_counter);
-	*p_tx_cnt = nthw_field_get_updated(p->mp_fld_stat_tx_counter);
-
-	*p_ref_clk_cnt = nthw_field_get_updated(p->mp_fld_stat_ref_clk_ref_clk);
-
-	*p_tg_unit_size = NTHW_TG_CNT_SIZE;
-	*p_tg_ref_freq = NTHW_TG_REF_FREQ;
-
-	*p_tag_use_cnt = nthw_field_get_updated(p->mp_fld_status0_tags_in_use);
-
-	*p_rq_rdy_cnt = nthw_field_get_updated(p->mp_fld_stat_rq_rdy_counter);
-	*p_rq_vld_cnt = nthw_field_get_updated(p->mp_fld_stat_rq_vld_counter);
-
-	return 0;
-}
-
-static int nthw_pcie3_get_stat_rate(nthw_pcie3_t *p, uint64_t *p_pci_rx_rate,
-	uint64_t *p_pci_tx_rate,
-	uint64_t *p_ref_clk_cnt, uint64_t *p_tag_use_cnt,
-	uint64_t *p_pci_nt_bus_util, uint64_t *p_pci_xil_bus_util)
-{
-	uint32_t rx_cnt, tx_cnt, ref_clk_cnt;
-	uint32_t tg_unit_size, tg_ref_freq;
-	uint32_t tag_use_cnt, rq_rdy_cnt, rq_vld_cnt;
-
-	nthw_pcie3_get_stat(p, &rx_cnt, &tx_cnt, &ref_clk_cnt, &tg_unit_size, &tg_ref_freq,
-		&tag_use_cnt, &rq_rdy_cnt, &rq_vld_cnt);
-
-	if (ref_clk_cnt) {
-		uint64_t nt_bus_util, xil_bus_util;
-		uint64_t rx_rate, tx_rate;
-
-		rx_rate = ((uint64_t)rx_cnt * tg_unit_size * tg_ref_freq) / (uint64_t)ref_clk_cnt;
-		*p_pci_rx_rate = rx_rate;
-
-		tx_rate = ((uint64_t)tx_cnt * tg_unit_size * tg_ref_freq) / (uint64_t)ref_clk_cnt;
-		*p_pci_tx_rate = tx_rate;
-
-		*p_ref_clk_cnt = ref_clk_cnt;
-
-		*p_tag_use_cnt = tag_use_cnt;
-
-		nt_bus_util = ((uint64_t)rq_vld_cnt * 1000000ULL) / (uint64_t)ref_clk_cnt;
-		*p_pci_nt_bus_util = nt_bus_util;
-		xil_bus_util = ((uint64_t)rq_rdy_cnt * 1000000ULL) / (uint64_t)ref_clk_cnt;
-		*p_pci_xil_bus_util = xil_bus_util;
-
-	} else {
-		*p_ref_clk_cnt = 0;
-		*p_pci_nt_bus_util = 0;
-		*p_pci_xil_bus_util = 0;
-	}
-
-	return 0;
-}
-
-static int nthw_pcie3_end_point_counters_sample_post(nthw_pcie3_t *p,
-	struct nthw_hif_end_point_counters *epc)
-{
-	NT_LOG_DBGX(DBG, NTHW);
-	RTE_ASSERT(epc);
-	nthw_pcie3_get_stat_rate(p, &epc->cur_tx, &epc->cur_rx, &epc->n_ref_clk_cnt,
-		&epc->n_tags_in_use, &epc->cur_pci_nt_util,
-		&epc->cur_pci_xil_util);
-	return 0;
-}
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
index 9004ebef06..e98378e154 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
@@ -68,11 +68,6 @@ bool nthw_pcm_nt400dxx_get_ts_pll_locked_stat(nthw_pcm_nt400dxx_t *p)
 	return nthw_field_get_updated(p->mp_fld_stat_ts_pll_locked) != 0;
 }
 
-static bool nthw_pcm_nt400dxx_get_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p)
-{
-	return nthw_field_get_updated(p->mp_fld_latch_ts_pll_locked) != 0;
-}
-
 void nthw_pcm_nt400dxx_set_ts_pll_locked_latch(nthw_pcm_nt400dxx_t *p, uint32_t val)
 {
 	nthw_field_update_register(p->mp_fld_latch_ts_pll_locked);
diff --git a/drivers/net/ntnic/nthw/core/nthw_rpf.c b/drivers/net/ntnic/nthw/core/nthw_rpf.c
index 6f06601de8..7184aedc04 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rpf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rpf.c
@@ -20,11 +20,6 @@ nthw_rpf_t *nthw_rpf_new(void)
 	return p;
 }
 
-static void nthw_rpf_delete(nthw_rpf_t *p)
-{
-	free(p);
-}
-
 int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance)
 {
 	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_RPF, n_instance);
@@ -67,15 +62,6 @@ int nthw_rpf_init(nthw_rpf_t *p, nthw_fpga_t *p_fpga, int n_instance)
 	return 0;
 }
 
-static void nthw_rpf_administrative_block(nthw_rpf_t *p)
-{
-	/* block all MAC ports */
-	nthw_register_update(p->mp_reg_control);
-	nthw_field_set_val_flush32(p->mp_fld_control_pen, 0);
-
-	p->m_administrative_block = true;
-}
-
 void nthw_rpf_block(nthw_rpf_t *p)
 {
 	nthw_register_update(p->mp_reg_control);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
index d55adc6687..1862d77350 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
@@ -402,12 +402,6 @@ static int hw_mod_tpe_ifr_counters_mod(struct flow_api_backend_s *be, enum hw_tp
 	return 0;
 }
 
-static int hw_mod_tpe_ifr_counters_set(struct flow_api_backend_s *be, enum hw_tpe_e field,
-	int index, uint32_t value)
-{
-	return hw_mod_tpe_ifr_counters_mod(be, field, index, &value, 0);
-}
-
 int hw_mod_tpe_ifr_counters_get(struct flow_api_backend_s *be, enum hw_tpe_e field, int index,
 	uint32_t *value)
 {
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 3655c86f51..0b8958c4c1 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -228,11 +228,6 @@ static void nthw_field_init(nthw_field_t *p, nthw_register_t *p_reg,
 	}
 }
 
-static void nthw_field_reset(const nthw_field_t *p)
-{
-	nthw_field_set_val32(p, (uint32_t)p->mn_reset_val);
-}
-
 /*
  * Register
  */
@@ -467,20 +462,6 @@ static void nthw_fpga_model_init(nthw_fpga_t *p, nthw_fpga_prod_init_s *p_init,
 	}
 }
 
-static void nthw_fpga_set_debug_mode(nthw_fpga_t *p, int debug_mode)
-{
-	int i;
-
-	p->m_debug_mode = debug_mode;
-
-	for (i = 0; i < p->mn_modules; i++) {
-		nthw_module_t *p_mod = p->mpa_modules[i];
-
-		if (p_mod)
-			nthw_module_set_debug_mode(p_mod, debug_mode);
-	}
-}
-
 static nthw_module_t *nthw_fpga_lookup_module(const nthw_fpga_t *p, nthw_id_t id, int instance)
 {
 	int i;
@@ -612,19 +593,6 @@ uint32_t nthw_register_get_address(const nthw_register_t *p)
 	return p->mn_addr;
 }
 
-static void nthw_register_reset(const nthw_register_t *p)
-{
-	int i;
-	nthw_field_t *p_field = NULL;
-
-	for (i = 0; i < p->mn_fields; i++) {
-		p_field = p->mpa_fields[i];
-
-		if (p_field)
-			nthw_field_reset(p_field);
-	}
-}
-
 static nthw_field_t *nthw_register_lookup_field(const nthw_register_t *p, nthw_id_t id)
 {
 	int i;
@@ -667,16 +635,6 @@ nthw_field_t *nthw_register_get_field(const nthw_register_t *p, nthw_id_t id)
 	return p_field;
 }
 
-static int nthw_register_get_bit_width(const nthw_register_t *p)
-{
-	return p->mn_bit_width;
-}
-
-static int nthw_register_get_debug_mode(const nthw_register_t *p)
-{
-	return p->mn_debug_mode;
-}
-
 /*
  * NOTE: do not set debug on fields - as register operation dumps typically are enough
  */
@@ -750,28 +708,6 @@ static int nthw_register_write_data(const nthw_register_t *p, uint32_t cnt)
 	return rc;
 }
 
-static void nthw_register_get_val(const nthw_register_t *p, uint32_t *p_data, uint32_t len)
-{
-	uint32_t i;
-
-	if (len == (uint32_t)-1 || len > p->mn_len)
-		len = p->mn_len;
-
-	RTE_ASSERT(len <= p->mn_len);
-	RTE_ASSERT(p_data);
-
-	for (i = 0; i < len; i++)
-		p_data[i] = p->mp_shadow[i];
-}
-
-static uint32_t nthw_register_get_val32(const nthw_register_t *p)
-{
-	uint32_t val = 0;
-
-	nthw_register_get_val(p, &val, 1);
-	return val;
-}
-
 void nthw_register_update(const nthw_register_t *p)
 {
 	if (p && p->mn_type != NTHW_FPGA_REG_TYPE_WO) {
@@ -806,15 +742,6 @@ void nthw_register_update(const nthw_register_t *p)
 	}
 }
 
-static uint32_t nthw_register_get_val_updated32(const nthw_register_t *p)
-{
-	uint32_t val = 0;
-
-	nthw_register_update(p);
-	nthw_register_get_val(p, &val, 1);
-	return val;
-}
-
 void nthw_register_make_dirty(nthw_register_t *p)
 {
 	uint32_t i;
@@ -877,19 +804,6 @@ void nthw_register_flush(const nthw_register_t *p, uint32_t cnt)
 	}
 }
 
-static void nthw_register_clr(nthw_register_t *p)
-{
-	if (p->mp_shadow) {
-		memset(p->mp_shadow, 0, p->mn_len * sizeof(uint32_t));
-		nthw_register_make_dirty(p);
-	}
-}
-
-static int nthw_field_get_debug_mode(const nthw_field_t *p)
-{
-	return p->mn_debug_mode;
-}
-
 int nthw_field_get_bit_width(const nthw_field_t *p)
 {
 	return p->mn_bit_width;
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index c4a49d8358..18133570bb 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -85,24 +85,6 @@ struct nt_dma_s *nt_dma_alloc(uint64_t size, uint64_t align, int numa)
 	return vfio_addr;
 }
 
-static void nt_dma_free(struct nt_dma_s *vfio_addr)
-{
-	NT_LOG(DBG, GENERAL, "VFIO DMA free addr=%" PRIX64 ", iova=%" PRIX64 ", size=%" PRIX64,
-		vfio_addr->addr, vfio_addr->iova, vfio_addr->size);
-
-	int res = vfio_cb.vfio_dma_unmap(0, (void *)vfio_addr->addr, vfio_addr->iova,
-			vfio_addr->size);
-
-	if (res != 0) {
-		NT_LOG(WRN, GENERAL,
-			"VFIO DMA free FAILED addr=%" PRIX64 ", iova=%" PRIX64 ", size=%" PRIX64,
-			vfio_addr->addr, vfio_addr->iova, vfio_addr->size);
-	}
-
-	rte_free((void *)(vfio_addr->addr));
-	rte_free(vfio_addr);
-}
-
 /* NOTE: please note the difference between RTE_ETH_SPEED_NUM_xxx and RTE_ETH_LINK_SPEED_xxx */
 int nt_link_speed_to_eth_speed_num(enum nt_link_speed_e nt_link_speed)
 {
@@ -180,39 +162,6 @@ uint32_t nt_link_speed_capa_to_eth_speed_capa(int nt_link_speed_capa)
 	return eth_speed_capa;
 }
 
-/* Converts link speed provided in Mbps to NT specific definitions.*/
-static nt_link_speed_t nthw_convert_link_speed(int link_speed_mbps)
-{
-	switch (link_speed_mbps) {
-	case 10:
-		return NT_LINK_SPEED_10M;
-
-	case 100:
-		return NT_LINK_SPEED_100M;
-
-	case 1000:
-		return NT_LINK_SPEED_1G;
-
-	case 10000:
-		return NT_LINK_SPEED_10G;
-
-	case 40000:
-		return NT_LINK_SPEED_40G;
-
-	case 100000:
-		return NT_LINK_SPEED_100G;
-
-	case 50000:
-		return NT_LINK_SPEED_50G;
-
-	case 25000:
-		return NT_LINK_SPEED_25G;
-
-	default:
-		return NT_LINK_SPEED_UNKNOWN;
-	}
-}
-
 int nt_link_duplex_to_eth_duplex(enum nt_link_duplex_e nt_link_duplex)
 {
 	int eth_link_duplex = 0;
-- 
2.45.0

