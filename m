Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F7C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C922940A81;
	Thu, 20 Feb 2025 23:04:32 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 9EFA540A70
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/5RucnMbXzCpX0phVcoYS3Yu16IjHC7moec7TN0VuqOahCQ9XcQidbcDxFkITvcI2EsjhIFk5VBUNbkYTKKLIL7cqRtaTCQmEqgaHjc37Y9fhiEaTgc/ye/fWuAOJpF1cQdFlzRQbbaJQcbtDXJ84VKWpj/IQtKtbClE4hFGySSrGvkO4vK7GygdDEetFb/YW2iyex9leFg91hgYpipJI/ZxpUO0T4LSM6CTeE11R6hoIqih9qoOoBap6J7xdhwaY9MU/sbAikcJBC2l4U0W//afoatG0npFpxJO557phbVO4CS1Uirg16HiVl5oHz54pwnNazXnJDhcOtcpc01Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuN3pnayBI7tLhMbNBpKMlQUsCPr6NgaJgyGnW/3eZg=;
 b=F/zG7+/XNS8jItjqLVCAxONwFwfKglyHHVPVlzhKXTjMG2CX+4BesYaJpVbPu8rDeso8TrUYJjlluS7Z3LF2EGVj61ULZd/QpzN0Jx1b6VSxjbSdpu21obz4IGWu64MSpc/0+rgp6zVZ8S+ZJ4bK3ptEltuqHLEVi2kklcNQmY/3977YgBHAxNkIOsO2Hl41GZPiBKhw+2hFuoHpm1W/Q9WaH4c2eZul9EilYX10MIF5X3wzd9mkHztjBCGkJ/oBSXNC5suMPMjETaNyplPV8kyTX9InA4uUfJGnr8oZ3AcS9pR0WJJrfjzDmftY3CTnClh6J8Ui4kaNPOz7JmKqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuN3pnayBI7tLhMbNBpKMlQUsCPr6NgaJgyGnW/3eZg=;
 b=gttkCguMuOB2lYIxOhnZ23bJRfxP2VwcZOoHIlolV+m2O+/zhaaPbuVvzb0UDIDU1yuOT2HqdJWLyQq/ZOgIfc29pmu/iYXLWk6/JkMhykxElc8i4O3QE2/PaKk56Oba7D/cU7REaNpjA0AgrQhUq0E95+gve4A86mDMyWZ6aFA=
Received: from CWLP265CA0498.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::12)
 by VI1P190MB0606.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:121::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 22:04:20 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::11) by CWLP265CA0498.outlook.office365.com
 (2603:10a6:400:18b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:19 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 11/32] net/ntnic: add port init to the state machine
Date: Thu, 20 Feb 2025 23:03:35 +0100
Message-ID: <20250220220406.3925597-12-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VI1P190MB0606:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34f74514-8a3c-4235-9136-08dd51fa869b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YWU+wKhl6KgL5MbrNo7XQTJ7s650NNyi7CZuta56sQSbHJHLgg6Ey/3bMZj/?=
 =?us-ascii?Q?bO0tkpWEZrdFFB1SBCT18qhz+3oojPWqlbISdfhm2jagSu5zigbr2M7ZYFg2?=
 =?us-ascii?Q?nbjF3IBVSbRZOGHM85MgHXi8du+XqgMWVN3a2TLp9u0iVVnW1PP7OnOyjo0U?=
 =?us-ascii?Q?MSDoLytO609+B8wCBgbsU/QBos/4vIXD4YI6iFBNYQMoRPgN0yZCOTtHo3FS?=
 =?us-ascii?Q?cbo6N1nHPW4FPXbGAf3iZNff9W67VHpg4o1mwONrp0C8dEKk/nRG73ohKykZ?=
 =?us-ascii?Q?RLWlLwdprhqUG9yO0Forh1S1MQpKMv9nbvz72CokFesW3HLSol4oW8+gAYp/?=
 =?us-ascii?Q?9a8ClBSZreBwlD9NhgOJDEl9OJDqmlqkC2ZGuli6YWQH7mwcdFR1L3fhPcdy?=
 =?us-ascii?Q?qH2tu42/sCEGasjqBPZQc4v/18Qc75324QD+q4ays21AIzcGkXNnTaXp35A8?=
 =?us-ascii?Q?MDgN76ZjV8n9Y4Ac9vxmhTJ+4vDNohECPkW23liL3KtU7Y1WkCW4vwEd6A3d?=
 =?us-ascii?Q?XT6w3I+8YpV/MHeybd1EPPIqFgSu+vGL9CpbQDlQQ3VSVupSAochzf5lwP99?=
 =?us-ascii?Q?/1Z8GSMouMv9cP3XhkngQ+d/f2qJGalTjDcYLoONbECpdFFR7riJY5MXmHRO?=
 =?us-ascii?Q?hg4dKIvQ5NhV6gl0XUcGDXCxhFwbldrgAGApNg7u3MZcTS305S5xOPhmbE2d?=
 =?us-ascii?Q?ZgwipHDLzFLeIA8hm9QhDHL/T1NITgKbxwUEpM55lDvygybAMupK0bheVHWz?=
 =?us-ascii?Q?ryFZLTCqMFHxQ2n8uvEJRU/2+eZoE+Z9off8ymMZEm4Z94hqr/vNVQYi0aLy?=
 =?us-ascii?Q?PNXIloqyIXmwr8sPHWxDuVMHWgslCysEIxpBQCiULhl3bAAMD7o2mgNPwnml?=
 =?us-ascii?Q?7Eq3g4x6ZppL1pwh9+/tMT3bveDLBIlPzn72CIfzVjO1VpydMZ2XIZWGh+nn?=
 =?us-ascii?Q?R1XpDLmdP5H31XAURCNehMucSZo9lIhmSSk6uAo8GkmzDmXL0rCKARrliCxm?=
 =?us-ascii?Q?4x7jPU22CQQybjxloN7uTMwjNQJWCQTL/gUPvyhDw1hMSUk7qGG8pDyTPNdV?=
 =?us-ascii?Q?U88P2VHoU4tCj8Ew9s2zBpuRmGRk1/QvzbRCjnc0/6gbwblkSzdnrdAXE20Z?=
 =?us-ascii?Q?axIKTp1ikzTo/KxAJU9w3TuQoJ0+o258iUTRTh689XDj7tiAv6FMDQZokAjN?=
 =?us-ascii?Q?1qkL33SkY7CkF3mhToM4SfvAx3C9fOforVeYE7KNdCVz++vubVEuG9Bt6QkF?=
 =?us-ascii?Q?jsHDWsOgKLZfHyOrNyPo1qL+ILUiqC7stgVZ3nLH7IhHjlhSnhEu4jzW3un1?=
 =?us-ascii?Q?3MwikunXcI9qlKQHzWgVLZ/5E4xa30qApyO5gq4F1SSANqQW1gGVWbMAyCIw?=
 =?us-ascii?Q?apN0OiRVYRrcprpBO/5ciP0qFQ67XRI/xqO1gTew1ZhGLImq7eXhPhhMBNqb?=
 =?us-ascii?Q?o1gouhufcYPW6OV+5SauB05oLu2jeKYQK7lxBgvm0d0k9UyvprRIrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zNLu/u2BtJVmwGvvR58MWqht+J68jMJs5ppWw1M2Ln5XhJxU+482HyvBxgfeezaT9Yf9fXak2edY+moGnSPXtwlJljLYzDmRpYrM7/4QTM466FHrjQfBYGnaSfLY9/lyZQxaV4HV7WOW2Qlm3KPHLzugdukAQrhdOMOoVwX86LSU1leahPE6/MqYPBf4iFSSVUN+NGAjsWNLm/cvDP0O1cI+DXThY3tsxoV/kdWOAJxR/fuqHN17Q/ZCh2nvZ6MVWGiA9teZrT5fJGcr7RGrYZ4kYLHs59BcxtUuWix3CilixjMj6e9edUnNZnSh3nyrA4bIO/hNzHYJtDnLv8UQ/hiUpXFBC2iJdhlPwC6/w+4lVtAU24USisQ7o9BfijilGUp9au/m21igk+AHGzCXq9hMahA2PL/pH6qYsFQ0xm+PkR/pCYmgzxfK4MwkBfBg5kmaVkXIKh6LcB+XrpW+37A7n+TYaB8oooAL6vmwcl3rKD5RCsePo0eCZDzH41k6aOQh9jkEyO5IzBwu9X7RuYs7CAZWc+RNvKhYJ5WUV9iEY6t3op6euD3EvoJuWinjTs1GsrujME490JiAhw76TUvSxnG6JmzNyceNJkCkw4oDzGTOeI9cfOTYkwfOF9zjdwa3EYzh4I45UI7acK9f8PLbtjAODwJ1n2I8/YU76Dw=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:19.7244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f74514-8a3c-4235-9136-08dd51fa869b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0606
X-BESS-ID: 1740089063-312005-29067-14091-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWhuZAVgZQ0CDR1CQlJTnNIN
 HC0tQ82dTQLNks2djYLNHC1Ngy0cBYqTYWAIAasAFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-233.eu-central-1b.ess.aws.cudaops.com]
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

Handle NIM module insertion and initialization

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 00a30f24a5..33d39ce62f 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -872,6 +872,39 @@ static void *_common_ptp_nim_state_machine(void *data)
 				continue;
 			}
 
+			/*
+			 * NIM module is present
+			 */
+			if (link_state[i].lh_nim_absent && link_state[i].nim_present) {
+				sfp_nim_state_t new_state;
+				NT_LOG(INF, NTNIC, "%s: NIM module inserted",
+					drv->mp_port_id_str[i]);
+
+				if (_port_init(drv, fpga, i)) {
+					NT_LOG(ERR, NTNIC,
+						"%s: Failed to initialize NIM module",
+						drv->mp_port_id_str[i]);
+					continue;
+				}
+
+				if (nim_state_build(&nim_ctx[i], &new_state)) {
+					NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
+						drv->mp_port_id_str[i]);
+					continue;
+				}
+
+				assert(new_state.br);	/* Cannot be zero if NIM is present */
+				NT_LOG(DBG, NTNIC,
+					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
+					drv->mp_port_id_str[i], nim_ctx->nim_id,
+					nim_id_to_text(nim_ctx->nim_id), (unsigned int)new_state.br,
+					nim_ctx->vendor_name, nim_ctx->prod_no, nim_ctx->serial_no);
+				link_state[i].lh_nim_absent = false;
+				NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
+					drv->mp_port_id_str[i]);
+				continue;
+			}
+
 			if (reported_link[i] != link_state[i].link_up) {
 				NT_LOG(INF, NTNIC, "%s: link is %s", drv->mp_port_id_str[i],
 					(link_state[i].link_up ? "up" : "down"));
-- 
2.45.0

