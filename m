Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9003FCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D988F40DD2;
	Wed, 24 Sep 2025 16:42:20 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7C97D406B4
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:09 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023109.outbound.protection.outlook.com
 [40.107.159.109]) by mx-outbound13-221.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBvPTQmNFGE0Z062zscPooeb8vmhgSgOHygZQMBJ3AKjLjGbE39XhjkhPsgDwDOn1I7ZuZZKKDf/Dbds59L9tI06NLkTwxORuAoYBWvL13cENzBrpFv0qvfS4UBkIjEsHbFHyB2siBK1ebsdlSZJtxsfHGdCG8c4WUBYupwZ6/zdBr2OX7+gKkzUnos7yqM5BmQVOLxGSBdlTyS84NSP6+3fgl1nzyrn1OyRitLzOwyHkwCp3JyZ+L7mknGDRBhfB8H5rToY1CdttUnFVNBJRNRkq+UMekuyRREgkzEYuZ1nEx2N+qvODJxVHdwJvmuKmkgAo2ZG+7mSqN46Wc/HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF7iv9UsIbafGGj4Fi1eSy0lKGhKOV4B9B6zCvKy7WQ=;
 b=Q5nBvXc1qmWer0YYmUi4X0zS9M0/SiTT1eJ5BdXqt82maK44HagGylFgWhys45ojbVzCE7wtGh26Ccf/e/5f0osxJ0WnhxYGJVw8nVAFVEK5T8FCJ8kzGWzgfARs04LRlAU0xU7lSevNtFJnnE7X6BI7loTVCQqzBiixoZ5tvRVQQu618mdJ2S6ir7BZqx0cqWai54hbJXexx0vNVl6hzpKVDhWRdCOxbQxpH/L9+eyjsFyT5I0f6xWfWY5ISyPawpFKKgayu7Ie8KcyJIplRTtksKvn36Vz1Rp3zsSH9iUWWLXTf4SFemNFyVIpM1GJbFKfTlwCdp/sV7f929/P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF7iv9UsIbafGGj4Fi1eSy0lKGhKOV4B9B6zCvKy7WQ=;
 b=SCmSEe9sc2H8oEVlJSEYTZaoQZULfMY/SALB9CUis7BDNIadFx3zsTj5a+kA143OllYUnJgVmM0vG8qhOSldaJ4O+122u4qyXBu+r9JdYJ7hbD3EkNzTp3iQ9AVn9Zt+aSu0kPr03OvKgmp3COOUj0jgIa4+nvPgwTPA4acsY5s=
Received: from CWLP123CA0226.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::11)
 by GV1P190MB1994.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:59::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:42:04 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::4a) by CWLP123CA0226.outlook.office365.com
 (2603:10a6:400:19f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:03
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 10/24] net/ntnic: remove unused functions
Date: Wed, 24 Sep 2025 16:41:33 +0200
Message-ID: <20250924144152.53203-11-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|GV1P190MB1994:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b76aa10-93de-466f-7ca3-08ddfb788722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nnr8cHCW/65b6X8ppWLCv+QbZwNgVRXs7+H30/cyM4sjaYGJSH/Q3cOZuSQh?=
 =?us-ascii?Q?qWid9e9k8+ztMS9d+UPWYNlHvhm9izeIIgma2nHkH9c/Lyz+pSSm1Bbaj40f?=
 =?us-ascii?Q?bwBqEXjZJ1NUxX+Ubqu8dz+HbHTUeipKHlKQqsxyTBdw/ZH8AqpqRgfoaO8N?=
 =?us-ascii?Q?2zWENopnX8MyRKoK+RH9ZfzcmdnQmFCavOVcAeH1Dug1n2qvPWfgN7ZJ6NFU?=
 =?us-ascii?Q?/Rctl/l3O03oyJOO650VBlhUdYRICCfuNkqXRV65tCrOG8HLJ+KlEMq3oDUM?=
 =?us-ascii?Q?w7dgsJIZtOjjpIz9E222PS9tHZjL9aITW2SsadgApSkZ0WRp9LfU8Ydj+xon?=
 =?us-ascii?Q?TlUf+pHQpYi3iNUROpLMZNcV5II1m6eBn4zDV0Q4aP3eCh5GxnFdBAiqxBmj?=
 =?us-ascii?Q?KOporkOmK2CJmYZN4OCcjgV9DEPhv4/irRLT5Nqx4L3TOJUSHZ0pd6n2l32t?=
 =?us-ascii?Q?Sbc61vwZ2MA/ujfntq44Z//bcuQHK2t8ihRAYYtzA2HNa6OSdgLKliahumw8?=
 =?us-ascii?Q?OCEDtFAT1MVjF61AnszBvZSQqQJ4/BbSiVctkuldSpQalM9j6Ju06eMeEMwe?=
 =?us-ascii?Q?5nUtePpnh1GsnSoF+hvJsTl993TFQufCX87k6QJasmJzTVtrReve890kSPaT?=
 =?us-ascii?Q?ez8n2+20P+lT0YxTzOY0MiZXAJEFLhafuIP8VR07A3Rf0jKSw5u325novNxQ?=
 =?us-ascii?Q?y3SFoOVgROQ98p5FLHRnpI3tibVq0dxV4RLUJJk0mcgCqWlzSceqrW+z2pF1?=
 =?us-ascii?Q?uLrznri2V0Tg6yZDZyIOUx4cKDNnT5100iL+6yidkUgI2owRXIGxTDLneiGx?=
 =?us-ascii?Q?xUVWvPjnX/qLqPGG+jG3NcYLjsy7l1WGZ18NfaQ5seMw2Qco4ETqf9T6CW+h?=
 =?us-ascii?Q?myOuEcIX/s+xdJuu4xSSLhN5VWekOWPOsOapU/AQo3uk5waQFJFioUZPdbkz?=
 =?us-ascii?Q?HQsAj+V+q5mfWOu8wxybU+QBXp/NHOBtROs7CdGNcFG/iqepAqvI8cYxWL6G?=
 =?us-ascii?Q?odHCt4FFb9A13goYc34Pv4kjs39rYf7jtcFeSzdUWOjHMNp7Kk/B/FCH6xzW?=
 =?us-ascii?Q?g6mSB5zYt22N2ckWrUnlKhD7aGNnGjyLNJf6c7ApozaLAJbT++JaSQwsmplx?=
 =?us-ascii?Q?cbMCYKocWHTS4gEjOxYcZ9v2FBoArxeyrlzZtZOLMTm+BX6dFMYbN1su63aZ?=
 =?us-ascii?Q?W53AnOUL1lscSA0767aTU6KqhipbtSvaRFsNxngMQxBVsg14GeSbv2EEncPL?=
 =?us-ascii?Q?VAhmJ3vAwtfHIJNGnQdoD4WIBmqbGqO9iDhICQrr1EZx1g77gjkliKNlV35S?=
 =?us-ascii?Q?4uBAcbK0/ZkhDlc7meIjXu3FQMyAK3nNA9ZcJuUUbvxluLQGYHV/2aCYdnoc?=
 =?us-ascii?Q?OXMbuD68ZzunZFKAJ+cKHk1kH7g1l+UDafNUOYyr/PabVQXX1YcF0pksw07U?=
 =?us-ascii?Q?VynybN18WHgG9OvEZPvKh9tHsEI81YDXfID244ox1rfflxDbjQuaf2pow16Y?=
 =?us-ascii?Q?z23aJWOT6Gmpwv1Sin/okRuooKi4tnIJ+N0u?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wIX5qe36Zy1LQZOm91WwbSOKXlPJQLSiUjRvgK+6f99mCO3LokrYszD/G/m1cdSPSEfnyBR9AFRjtPL4RKnBLYjFVLk/INbmRe4a1JF4A+uCH3zP/XF3kh1C7YdXoAbjxRBl7fjZtSjVKnIm9BnsyjElsYWrTk8MfwJSnkImvR0JEySJ1WAgoAgGl/L3gnEF43xT8uu9BgIjpzmuBNKC8U3Dp/5J0z0daDDM6jAF4p9Wvs8FEds4D1lvOsIznhF4DVfka0HhKCniMwB79jrS2dUNVYAwzIkm8Qpq047eF7zX4CtAXIjVEym3P16fEF3qH8FQGox6VZfdFet4iUJYIlEAj+tjTIF/7gbMnVs3inZeYgOb3YGmJ4kpuXsH5sfuthJxGZUEDI3U6EU9R8dBVUarQE2aohn3r/6KZkNbgg7WwDdEFIGDmsiY1wvnbj1s4evr6Eg1BYgzFXt4NUoG+tBAT4HNTuTDxnWhFZxg4RW4zLfnnGJ/zL2cWSLdS+hBWVgRQJQ13hOxxLDasfMB0Sr8FGqw1RKdTji0n3iLTp1oMSqrSu9abHsy0zGFYp0eDv1TQif+sGMPPn0qwhRwBiTGDhVwQhm9Cx2BDGRpo+gwH4OovMzre0pMygtEfHkA/MIqT0mDeCCaNgJV6h5C9Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:03.7295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b76aa10-93de-466f-7ca3-08ddfb788722
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1994
X-BESS-ID: 1758724927-303549-7635-8082-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.109
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamBuZGQGYGUNQ80cQg0dggLQ
 0oZGGcZGCalJZiapxkZGxubm5smZSiVBsLAPda2vxCAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan14-245.eu-central-1a.ess.aws.cudaops.com]
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

