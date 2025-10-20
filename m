Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B4CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 529EB40DCD;
	Mon, 20 Oct 2025 18:43:51 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 7FBFD40678
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:45 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021115.outbound.protection.outlook.com
 [40.107.130.115]) by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFo0Vxze4llF2oUKjM08MrJIwvC/mh0SJNuvQ59hqeSJ/ys/LEdttGL8eKpG1dzUYfRJiaR3tbo2bygh+BJkypL09JvHRY+ex7tmLMy1eMOPLiktd933jKO9RakyT6vd8+BEwB6jLqoxNUuTQk5z8sAjaLm0etJ5s52UnfpglFBthOQWZ5TCcmIWLeKLwShng8KrG1dgVoKqBapbbPRvSPJJBb57LJo5YelDZ3IzRU2XsmQ22dHlX5TjdEYbRe+QLrbVu+oI5G2X63PpJlP7UwX8xzgU5Y6sr5gqRiM2bY8EIcswCzBNGMC9XmDeM6sLmZVa+ZptXzU/Sj8vVs2tJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QheQmFWV5ZBLCrdmDd17jobeq9tgE8ENnqvqWlZxJk=;
 b=N8/y/N3x/aM5b/rxDQ3oKFRFpwWyY7XVlmXII84Fjh65dXtGvyWWVt4boPHfZ5memfNHMpnHPVs4CavNlq4nWatHqffMAuSc6NCqvTbIHzC9tj521mXTBUY6dwVK9z0APRUADsOf33jcDLgK99f6+9nMrLM7+616UYddasXH9/lDBV1ruWJj+ZJsFSFYXX5Ii3u7CtXe0baocNqjRphw4/P+DZWegPd6yeWeTLq/EYhfvTQIy+3qcQXKJNurWBusVKHiptlBu19Ecz9p+JQxLUeFemYbe520NReeXjeyDTyc6DFBq+wcAO/e91IaZdhgmbtIwRt8CBOl/ti1240vfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QheQmFWV5ZBLCrdmDd17jobeq9tgE8ENnqvqWlZxJk=;
 b=flha58JkPy/N0if8unxAueqh8bJ6nzY82hjJc4oZcoC7gqKi8p/OwRj5KTMfNfYGA9eKU86ZahXVqktKyFzX0zzJRbAEej4OD8RxZkFi14S+PqRy+YzU1ZlztQ2HqIhpkF4GKnWwGahgc/Jxc2sEK1RyyD1bnMLOksTzAGN3e6g=
Received: from DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) by DU4P190MB2176.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:572::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:42 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::79) by DUZPR01CA0024.outlook.office365.com
 (2603:10a6:10:46b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:42
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 04/21] net/ntnic: add reset init stage 1 for NT400D11
Date: Mon, 20 Oct 2025 18:43:13 +0200
Message-ID: <20251020164336.283664-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DU4P190MB2176:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 941f3f6f-8361-4150-b9a9-08de0ff7d44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phm7y0asaN3Ym5DyIx8NhLv9LksOeP8uIO7JUBWe5O50z7BSVwNpzjs+KkFM?=
 =?us-ascii?Q?PFlASKTAICHDH6rnt038zSpKOKkj+oVGGfo0PnT8c/e7tTwyv08EX8q5f4a9?=
 =?us-ascii?Q?bzYZltXRvJlIlvnPyjrrgs0qQ7zgCJT0/KKUuOfrOD/xtIqJ8ybqNjDK2BPU?=
 =?us-ascii?Q?kS8q5JXglCgQU3yUxrU92eWF16xtz0zjZEAaV+045gD4Y0Ako9llG0cLCGnw?=
 =?us-ascii?Q?5oeqT6pOmEuDjZszeqmWQD+QTDz+JZbYyiqMqn+v7E9Lm0ls0HZT7myjZ7Ug?=
 =?us-ascii?Q?jvWASFspi1Bkd7zy5/7HIWafOiq16c4drj4xgiwB1Fp6/Z5eUDQP6hQx7LzZ?=
 =?us-ascii?Q?EBWNxPXfHqmK67Ws5wqIO/ok9dQx8iIT35bHHWWMEVhngsAyyeZsZhO2IW9Z?=
 =?us-ascii?Q?DK1C9D08VqC3/MdrHJ2ub0LxvSTU/djn5u8+PBNQi9r5s4U5d1+5DcFdEcc9?=
 =?us-ascii?Q?rWZ7sZm8/z71yZ9w21xp2rQ3trl1KL8U8OQ/Mn/9qzqysfdsZD9gutD3DCcf?=
 =?us-ascii?Q?a6vlbARTWvo9FkoPCbXh6eCtRflKfhn3Su5AwlXXMEgMH5rh0A2DU4OJxnt9?=
 =?us-ascii?Q?YgJl2eeiMbjjkm3vgI5JAj3N3vmTQY+i2PHDK5juoOjXd3TKB8z3gJ272FEW?=
 =?us-ascii?Q?luQRinYD1svyPJEm2qw0NBqxwXVvs7OJs2oIdhLml0g8Yb++rZ+CRAX7vhSs?=
 =?us-ascii?Q?GLG47a3ANgp+oLSjkqwtq77dRHfC1lUqdlORYMFtmiTuE3B7STaHZ/E5TYxO?=
 =?us-ascii?Q?K+SKz7pR5xH2JV2WIzy+/GnLE9WRi77K736+Kax6wS4me35Qk0OrIOJ6v64g?=
 =?us-ascii?Q?QEZ+vEvmnpAksEqbJmVNQjO/rNkd1uYp3E25HmLLks5yK6L3HZQpoqPdcW+t?=
 =?us-ascii?Q?lyMNRLMTkMEuMa0xIb0MHSx68FG15USGljNY+gSimSDZDs0BH2Heez0K1SKJ?=
 =?us-ascii?Q?R+t1q2bBvON5Fr6cMaXtECTmK018mtCpY1Ub2kpSwOUjz0279ULRslHfT72s?=
 =?us-ascii?Q?9A08Imybufqx5ljoOiVbGv0+pGy6CBTrb6kwhJCr3JWMElu6yVSCiyORK+ET?=
 =?us-ascii?Q?9K49YnDXbjIZG72+YqWwsg/V1e4OJmrZPrJ7Mnb6L0ddtXtso2HS7O0j1rTp?=
 =?us-ascii?Q?IK2LfExrd/Nk3McflIy2VAIA47h7PLYWdnF2q3ZXizmTU4KfL+pv8HxY7/mm?=
 =?us-ascii?Q?FNIugptoPyzTSmBAZIoWnIlzBi6O5dQDc5yM4xm7vV75V9czFAJijpAIOfEW?=
 =?us-ascii?Q?dTvvUm+3/icKp19x79fy1Y2Kc2KoMeHDLcBs+Il3rjuUtIPsFkkWxVMWehJu?=
 =?us-ascii?Q?vROh+ebIjpo5a9G7B1SIN3uX1nc0GfIz1oP+ZMj+atm3dOLgiwHessSCLoj2?=
 =?us-ascii?Q?enjB4maC+9Kwtghf2u750MyZEfpNJGeq+mHRNTw3j//THeVidB6PKimxK9u8?=
 =?us-ascii?Q?WnNq/4/9+qkedv9jrh1LDapDQMi60r23DIRIAxCS6Eq4gaDFP4GCloXkULnE?=
 =?us-ascii?Q?RJgxjXG0NvHBnCza5ej5sItQ168N4h9JId80mrNEIt5qvITG4o530Ryf1g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ILHICQTk24tqtlRZk2Dhqq17SXfFTZdsZggHvJEIzQKcdaalEjql7Vt6fRQeD3MO7VQm0UTIM3+fTp4Wz62xu3ZczDyaf+ArPHLqnL843dS3XW6/h4bP3k8q5KGuoEUIp5g9AnkMculyKW5Vibc/x/tqXwaLyULp8Sj29eZ0T1ClnI/RoTMkMLJIgLiE/IbM/eGrZWAaIdHUvtigwitKiKTQCAeIwJGuoMui8FdfqCmmtQejKBlDZjByQzGY+uKB7DFN7SIGY6ntSMdUJyfQpjzNHGRPXY5yY34CB/DgBAPkIb6vydTe0c+hIP+VW4HnI+d1TIY+WLIahSl7DtTzr+sP1GoyImKMOtN9Zv3Tjyrj3OD6lHfLiV3ZxmKZOEhq9qsQFR8dk8OAJH2aVhbYZ7kjLK05V92UokRSu9Slti57U7PxjNDWiDXlbAoB5UF34RnWtFcjWg9sKQIVSPFKTETGDo9rlu/Z7j89dXhN3qp54u8pgiTT5KYaXX6SndSwnnmPGkX/TBVxuQfji/Iskqkiyw/wkRGudHxasFW7MgbCoHvENcKVxTkCJQOn/lqd4+4EyxmJNX83kyyxZuoWtghSD4un2c46jFWwNLJV3Iv7R9MGnjy5Sb8jb9hFUauG+dHKSAtwy3xBViJ6Ot9PNUFFuOFaBQmBprHbYaUJ/BI=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:42.4763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941f3f6f-8361-4150-b9a9-08de0ff7d44a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2176
X-BESS-ID: 1760978624-312065-25066-118144-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.130.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFmZAVgZQ0CI5KS3R0sQoyS
 zZxNTCIDHJ0CzRzMTA3Dwx0cLcKNVcqTYWAOACkYRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-7.eu-central-1b.ess.aws.cudaops.com]
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

add De-assert DDR4 reset.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 6a6660cabe..4205e539b9 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -73,6 +73,12 @@ static void nthw_fpga_rst9569_set_default_rst_values(struct nthw_fpga_rst_nt400d
 	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
 }
 
+static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_ddr4);
+	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
+}
+
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -85,6 +91,15 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	NT_LOG_DBGX(DBG, NTHW, "%s: RST defaults", p_adapter_id_str);
 	nthw_fpga_rst9569_set_default_rst_values(p_rst);
 
+	/*
+	 * Wait a while before waiting for deasserting ddr4 reset
+	 */
+	nthw_os_wait_usec(2000);
+
+	/* (1) De-assert DDR4 reset: */
+	NT_LOG_DBGX(DBG, NTHW, "%s: De-asserting DDR4 reset", p_adapter_id_str);
+	nthw_fpga_rst9569_ddr4_rst(p_rst, 0);
+
 	return 0;
 }
 
-- 
2.45.0

