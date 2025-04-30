Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE5C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B3204066E;
	Wed, 30 Apr 2025 15:49:29 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 6738E402C4
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 mx-outbound43-210.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdYbgT48d5Wn/68w2wfR0lerN+o8hx3dot4igKxJhHuwPwU2tyBa0AUGqo4niXqPoBKoFuoh2IpgAbHwXaIHSAxpnTJwb8N/S6dRKsTQol9xnzXPeh8HMtKmSkmXBgnaLAKfMNPuxATp/fY+8V+qxAS6trdo6ALJldxPx+4cyxG5pIzYMV/awFUmVMSsIq/BCJhCTUdMCm6MlJq1u1MbH+R7oDUnqJVrtOHImbZc6KsXOYE6oqCb6Eo/ot0V2KfqWoAnkI3EHWB85zdPQ/Gc5B4/JaiHv3YJXuVpzy9efU/+xonwkgp4DG2koYenEvnLPtjYmwvmRTpCXrKKyzX1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M7irrNyPk8sM29G30JkGltyVYS3zUIVvxZ9n7vuzos=;
 b=t88sdO2vxVjbZuyvfxkORlBneTi/hJRw4DGQ/iTm3HlXp1z/PcxtRdyvSHddEfQRgoIrJ2Jq89kTcZHKLPiSfg/+ptyfdKcZcszWG1TfVk5Cs8y3tmYxaxq+PxglGRtaT4C9FQk4aJd/ZtqtkCxnnGBIEo9n8Sez5Js3jHhL+r7KDJ7k1pC87dGDIr+Zh23zO69kqLSPOM4IT7cX/Y7d2Q5arYsdxD3YWcUl/DhhZLBt4cDej4mOwZxKFDZ5nxLu81g9dEnxnn0k5BysKAK4j6f+ipAM9JmiwA0Dn9ktXbcQeT5Hk+Q1lpBOD3uWM+6Ay+dH6F3zY0dVvE3u6HsPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M7irrNyPk8sM29G30JkGltyVYS3zUIVvxZ9n7vuzos=;
 b=p1U8EQrJWOXLVICqL3xGhp3EpCBw2R2R4EV5yWwPsbznGtKeqC4O+Stc/FzM+oJErLNkniUrC//SmldvQBwX4MmXcg9LoLLKusPDwlOnCNV3mcfrCaV/yj0c25QL0VAH0g8HMtMq/L3Y6E42JbNjM8kHSPvelozngx6PSYLseQE=
Received: from AM9P193CA0018.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::23)
 by GV1P190MB2112.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:17b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:13 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::6b) by AM9P193CA0018.outlook.office365.com
 (2603:10a6:20b:21e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 13:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:12 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 11/25] net/ntnic: remove usless part of conditional
 expression
Date: Wed, 30 Apr 2025 15:48:23 +0200
Message-ID: <20250430134840.402553-12-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|GV1P190MB2112:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5ea10e9a-2bbb-4ad6-8903-08dd87edca7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i5aOUI+zIWERkxylvIRBIzWV5vMu7UTn8ozaBxowQuMkOGFou/aeareB3ewP?=
 =?us-ascii?Q?Mp0eoUvCZ3802z31br/tQOsUIkAgBI06QBf8oVS/qdx6QX0sUzksKM0rV+c4?=
 =?us-ascii?Q?OJ5KrmepIcFv+UlYJkUSCanOz/jSM+nMFLeU0j/1AdGgypUJz0SxpMiOrJDw?=
 =?us-ascii?Q?8kajwRl6Jvqf+JiRrssLN3a1LXGsN6c+ceJ1yXL/uiJ76zPglpAX/Hge8SEj?=
 =?us-ascii?Q?niSNgzt5PrkpebzYM6B6d9JmHB91DHVXvsBEjN01sjwH6jsETu8xvDrv7pP/?=
 =?us-ascii?Q?XmE4JNEL2nb/yoYn0+p/spfARZUTMMnBsG9B9lFEuARqYFZFMfWV7FVgQn5Y?=
 =?us-ascii?Q?9h8cerxYr1DtQw/hcRH3jRgS4HPlh9f93SWa+4C9oX/K4cjLiIMx+0INdVkn?=
 =?us-ascii?Q?B0Z1+/1Iz/oX89wM6FgzNjfhyjmjRdgjdKKctFuZRaOI3DM0LUTVLdpP0zpQ?=
 =?us-ascii?Q?7NH5ggb2ZDbBWD30AJ11hp/x+olusM4mr7hvW6a66/gmWzbSo4xzmkpWcXjv?=
 =?us-ascii?Q?5+OsZSJqegAydA3l2vwiLoxM4H0aPFw/2Az/6zF84HtfE+c9MZWe6c9q0Ekv?=
 =?us-ascii?Q?yaheQg9VKDPokVT9ckLzRrAs4NO3+lDQSW3jBhb2+sU+3vuqBILDQu7KtniJ?=
 =?us-ascii?Q?Ep+IhOV2gZ1cGIETCOPPPq7enj4rsa+e4jMKjPt/M5wKX27JkbpUW9kChSio?=
 =?us-ascii?Q?7hDWijwHpXDajU138iFRAUYAPM1b/ZZ5eOI+tPYiMoM3oIsq3f2Kekh7GrAO?=
 =?us-ascii?Q?3TRdRZWjlBldri+UFBDfbmKqfKoUDrjNoaJ06nxqgw55VM7dGULrsaS0qSzy?=
 =?us-ascii?Q?kwTef70+R+YLYI/eNaLMsaU9dz1564McsaXq7HOtc6fiPdTp/HkhtiS72e6g?=
 =?us-ascii?Q?WNlrxALS2Fi23kd95+J9O75e5ocopQyw6jsRLh41tS7LajC3rbFMN3tODOim?=
 =?us-ascii?Q?y2MXU1M4ajHB1gGcYnoAJcP0bt4nZEwTr2HcZfLUV8xNGI97m/dDCcgWEU0W?=
 =?us-ascii?Q?vPW9sTIaCmiiTWpM5lIcMROERLJTVO58S8I0IMVMfYFrMIWLNnfopAoR3aTZ?=
 =?us-ascii?Q?CjB6f2gUvYGSwBrcC+NcvKN1bFttzWTGcl6PttfiAA+tvIX9HTwLJWNLmjQv?=
 =?us-ascii?Q?8ssNEXHeT7xjslTtka+Rk2a1MUounNJUQ1WnuBD3D/Boj7qJZO8Fv0b0HScM?=
 =?us-ascii?Q?hDJbpw5NXjqYZ56N9jLIrhe0qm973ZsRzOHD5pjnj1hsTzqFZZQ/yEmMkTNo?=
 =?us-ascii?Q?XKXSdoiBU6+Da8yIxzh6x5PRflXlb4hHEFMEIvV+mrn3NB/qtwl4Nw1ahKd5?=
 =?us-ascii?Q?571N5Xxoed19pR7fiHpf+RtJoz6C1RoxoAxnIfg4h/d9kSTqAntpceS0/UK2?=
 =?us-ascii?Q?thhgOXINl775lPzCJPVawLF0BoygeNoRltVPF6KOUkP/YlAxHeXOzYcsPUIb?=
 =?us-ascii?Q?x3lPCdze156oSu4J7ANIJSteGtMlxXkiMDiTArVsWUBp4e8lNg/FyN7ezBTR?=
 =?us-ascii?Q?wGY1kTU9gqQHA43ueJJ5R6Dhz156AyONLKOQ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qtkuFHOscPCaWSVRJrChtEGfOeDxmC6bmp7UVGtJgU3zuXjJKXDMLGNmZ7n7rpTMbvW4U9OS2cEk8WImDvGVFG2ICjJXjBxpJHzJXZfZu12Gfm4qQQKO3ANAnNWQnZ7XuhyVgffoWH/QqI8nlvy0giHCySm2qoJnhUeAlLPfFodsuCF0hVGt46SkjQ4h12McL99gLUbpBQ+Gvj0JKUjcrQxfqRazBCrtEDW/+gzuYNrNUl078yvu5qELlS+AlFD0TZhnn+ySejX1cZgGSfF1C9hoVmzv+CXtdmTn4cweIGshR2nfaSk46WHV1jagaaLoBT6bc+7EXPEyEi0rojiyYbofXhQlm4rF/IaZOKTi1ROXJ44q01+Yfe3LUPz2cr6NNaw8achoESU+xbPh8lNOJSA+lGduCvDqNwNU+9f/bmp5g8DRE122c+wlP+tY1ULHGiuoKzr5iej4h/Eov0E3yNMvGmacbrCgEF+UsQTxpc3vVIABwvj0NYoiTAZAmhA1wz4Xx+DZQLJpNxTH/7ObCq8LoW9zChcfSI7SktcgtayTR6lrEW8JvVLsWwdmqBg/z3WVzfY2twxa1oMX0WGDVZpjCAOkj6DJHERSvmVseSBPnjcMJ8ZqowIRfH+/fIw95vHakrdMpvD2zFCBdIgxkg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:12.9097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea10e9a-2bbb-4ad6-8903-08dd87edca7a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2112
X-BESS-ID: 1746020956-311218-7645-8869-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.177
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmluZAVgZQ0CQtxdzSIMkk0d
 Ak1dTY2DIp2czQLCXZNNEy0dzCMM1YqTYWALAjywhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan14-99.eu-central-1a.ess.aws.cudaops.com]
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

The conditional expressions that always has unchanging state was removed

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c | 2 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c                 | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index dde185c62f..43b3c5a41f 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -672,7 +672,7 @@ static int nt4ga_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nth
 	 */
 	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
 
-	if (res == 0 && !p_adapter_info->nt4ga_link.variables_initialized) {
+	if (!p_adapter_info->nt4ga_link.variables_initialized) {
 		nthw_mac_pcs_t *mac_pcs = p_adapter_info->nt4ga_link.u.var100g.mac_pcs100g;
 		nim_i2c_ctx_t *nim_ctx = p_adapter_info->nt4ga_link.u.var100g.nim_ctx;
 		nthw_gpio_phy_t *gpio_phy = p_adapter_info->nt4ga_link.u.var100g.gpio_phy;
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 485e912912..47f4b4e7b1 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -550,10 +550,8 @@ int nthw_fpga_shutdown(struct fpga_info_s *p_fpga_info)
 {
 	int res = -1;
 
-	if (p_fpga_info) {
-		if (p_fpga_info && p_fpga_info->mp_nthw_rac)
+		if (p_fpga_info->mp_nthw_rac)
 			res = nthw_rac_rab_reset(p_fpga_info->mp_nthw_rac);
-	}
 
 	return res;
 }
-- 
2.47.1

