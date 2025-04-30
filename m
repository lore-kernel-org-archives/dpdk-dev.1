Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115EC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB0C8402D4;
	Wed, 30 Apr 2025 15:49:19 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 5700A4028E
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:14 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 mx-outbound42-181.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5I87e8ayOE5dx8aSKkK399CA719BJM1XikORFe7NpearOi6Dum1L1+8t57HIaxZk/MVO/hO8kd5WWejoW4/QAeelJcMx7/T4S7VqlKpU4HsaKF+Q/MPfXvH4Zpk1dIUA4fJTXdbI4S6g0RijgbsAwC2/1ri+/eTP3jvdxv4l7P0Qda5aDrBEYt+xs5yW9rPMH6FD+QrxVag1EajEUpRP96BkghqVhozv57X2LvrIm+ykG5PIoulchJFMZnmbJ/OgYBUFwmvoOLOgl9CwKT4CB7ux586qyeDEGWShhu7OS2XUVGXf4eM3gHJXJxBol/6VomT+KB9MkPr+xPfH5CZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zGKUw85DVRgQmsB0gSdaxZXuWTcZXZz4tg6kk4Ipa8=;
 b=GS5jZlj2ireIaiO93zTK0zaPuwWZiASSO4ZHB0nWvRg8xxEjke9JAn9frx7ieZlskGyMil4wib1EkoGcbrn0wd1H4VS+rNQJ+vPoa2Yzlv2SYXcn8Bz1FrY4lVZvhxomu2gMCSViMG/ZaMdcXWziNs2rdpSBML5QvLwnuQ4s/yynsVb9X8XaECvIIw5DN+mNfEx6f8xGCPn3bJSEUvfz0+/CTm7oeRXWUtLamOfX9dAT+mx8yiXt0cpyRXenUxHEg9QbegPWipzaYnaTtpBDQoLY/ne1Jij7NyB63jO+FXs+9qKKuBOdzxQioH4pEKqGlnhO7iiJCfXzEWmTqBzPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zGKUw85DVRgQmsB0gSdaxZXuWTcZXZz4tg6kk4Ipa8=;
 b=FPo994ZBdhPVe0bKIK+DT3TN8a5t3iq9WVbafB2+LpkzRNW22UNV+qmODsivm+/ZWXcOVJ0nWvvWXInpJmYyt4toAcB8gFcikdZs+5lqJ5R3ieeQGuogIkIAqyHrNsWG5vH/oHvLsnx/myMvzQzAAgTVDS6u16bGadrfpCeEJXo=
Received: from AM9P193CA0015.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::20)
 by AS8P190MB1144.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:08 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::62) by AM9P193CA0015.outlook.office365.com
 (2603:10a6:20b:21e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 13:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:08 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 03/25] net/ntnic: replace pragma pack with DPDK defined
 macros
Date: Wed, 30 Apr 2025 15:48:15 +0200
Message-ID: <20250430134840.402553-4-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS8P190MB1144:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35376783-d414-4b4f-07f5-08dd87edc790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GUgRKoQkJwNQw8IWk23elvRKrSRlH3ijXAbnumcG0WhSRM7qApueI02Maryw?=
 =?us-ascii?Q?9amvfsZjOV4LLDDLXwtYsa8bYP+0AhmNLY0awl5Dg3mUP7uRzTRAVEH4Yrbf?=
 =?us-ascii?Q?hjP0lP39sN5kZhkK4dH5xGY26qh7mbW/2DnHR4YOLh5R28UfJmP3aRqMS/Rf?=
 =?us-ascii?Q?K94Dgam+iJAoBX5klF4+NH/BtmXO0YTijqxUIt+4C9FkLHmwF0aTp278YI94?=
 =?us-ascii?Q?aPGrcTvw698/g5M/78gDJMYExOadulntLWt8ecK7bIIgtpUs87o4ngIlDT3O?=
 =?us-ascii?Q?pnRCYpKnWFS1jcYeqOgZj/vCzfQFZHmkDgnxE4x9uXwbT5vvjlRVRiAjkzrv?=
 =?us-ascii?Q?P4KNHAGA11nQp97dAwZF/wtFumChhYUDEUBEm4OP7uI365PVgMvzpc37SXPs?=
 =?us-ascii?Q?0WBbB0M/R4muXMbgvGIaos9FetDvHd/dV1WDrbCo2OilF4iCYLlcRDV5Qt3I?=
 =?us-ascii?Q?XsIbeUF/jC7qVACKI8OwaQx/WC+LVtaRKtxr6qxNcUNeSpXL1dGpmu4rfQa/?=
 =?us-ascii?Q?5Yu3Qy1QBCHSh5yP8jsya7OkN6vfc+nm43rMNGMQsIPf1wdiRKMZUWZ5AgSJ?=
 =?us-ascii?Q?fFYdTw5uTxMOwbTDZ6td0Cxb0dIEaxjEdrrR1h7Mdts5TfP4q5bR4+QTGfU7?=
 =?us-ascii?Q?TQyWahmVyBQuGlx4qonRp45PdMPjZTk0urlwOVjEfV4yJLjn/J+k0tDVVpHk?=
 =?us-ascii?Q?4wYAsm4GtX27IPZdYyrRj5maFj4wRt7BITFqSkBJDHXrM5aPgSMn6NMBAErX?=
 =?us-ascii?Q?B4qcivtZChsU39vpuzdt+PDA/5+emLgBJSkqNP6Sv2FoSuzu6os+ubX6R4Pr?=
 =?us-ascii?Q?CC+AAS8LPL2gpeqvBoaTFNu9BTA/n8xXBHwDbAhrApHSvuwJ3/BJl7+J8e87?=
 =?us-ascii?Q?0TCUahjdXyrfBBbELB5leytD+W2g3U0k1cK6CsDXBXZlESrzD1DE1NiTX0C9?=
 =?us-ascii?Q?liZk5dZtC4RWRx6uh0aK5NpUj5aNRPrqfOCBXH97r12tqtZBOuRMCp17hbHS?=
 =?us-ascii?Q?nMaC0ysF3f7vPxwY/1GNyn2S1QJCweqXOfswPecuDV3aAU56iqCwxiTz18f7?=
 =?us-ascii?Q?nwJL1hDEr5TgcJM/vwBNx/QO0e4Rf6ssZaM/IGuEjWnoeoDUsjwhKaoTjU1R?=
 =?us-ascii?Q?C6VGdILOg3StDwM7rIicJfnNTAgNmp5zMJo/OAZQH5qwTLtz8JfNpM/tv4bI?=
 =?us-ascii?Q?i1BK8rNRZic29WkL7RL/yI3EgBKHFL60w8b25k3mUBRCXPXtJsbOnpTJ7QPS?=
 =?us-ascii?Q?VCR6cpUBLf3C5pHrNObrki4RVVyQSmSR489OolOf6bp4xlrD3b2gSP0MuCrS?=
 =?us-ascii?Q?3lEegsRP90utyltI4hddEYWrZs/Bls0bDS2juAiOEqimvd9/36CRhPlNPqx8?=
 =?us-ascii?Q?f4PyurChCOdOq5zRgletyIPYfFussrP3EpnoGJwlQMRmcXHDx9ohrUS704Ad?=
 =?us-ascii?Q?IFet5SyK/J8esAwEjX1I8W1O8/ZFCPD9BeIK2CCkihuXTh1s8OUe1rSdpZni?=
 =?us-ascii?Q?rb+rrT6kiZGv2A2IkeIiCBda1ptbTD+hdDSO?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FRiRFOr6FJGvmn4ZEqSenYbr2id4kytQ6VgqDh0Lw3DN+8fPTVVb2CWEwk/3jhSf6NABTYpAa+6qw1LVNQSe3qkQuj8WT0tGoMrqVbjJL/b94a44W42Hsc7Ww70UIg1iJvfLTCjSeWVYq/mCDPOaOSigFwvFfhGO6duO/ldOfqaqk9xyZ/hR05JPwta03+pTeflhC+ut+HKUbgrumGze4jFPzyaxfTQ6CjtIJrGi3ymzsN1bs/5yGuQ7ILodE+LgjUQDDp8+6TvUlVbKLn4lFLhIVMOXaYb7yn0fF8s7N9lyvebtkv2m9S4wtCi1Z7xFuPkOg+kOkV/IqfsxEaZ1Dw6xkheHoQigjq62FDmpKS/n21XARjeekgufrggQP4sm//cACGJ5r1TC/31S9zsueuzgQwhYJdoL/kN7qDpuNfEgqWI4VU3pTB4li3d7pTRlSVMTAjY73wKAq+WFmBUmNBppPhSbdrEKg8l/VzP0faBHNRCnZAisV07KBcFaMiZEa3h6ZMepSjaqvq/Wag8EWKtFIlzSbotC4ngohp7b3bqUTMDJ7sN0QFX9bMx7/sTz58r9yKKJvtLzS6ivpvhiQsVNVzTs7J9467hzRDELR0GgyiuhpQPRyYoC1tT4pxjQKuNmOCOmP7ZFkYRL2537zw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:08.0327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35376783-d414-4b4f-07f5-08dd87edc790
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1144
X-BESS-ID: 1746020951-310933-7995-568-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaW5qZAVgZQ0MDI0MzQJNnEIM
 nc0sjI3NzANC3VGMhPtbA0tTA2NFWqjQUAL+eqBEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan16-155.eu-central-1b.ess.aws.cudaops.com]
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

The macros __rte_packed_begin and __rte_packed_end are used instead
of #pragma pack(1) when structure or union memory should be minimized.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/hw_mod_flm_v25.h | 14 ++++++--------
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c  | 15 +++++++--------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ntnic/include/hw_mod_flm_v25.h b/drivers/net/ntnic/include/hw_mod_flm_v25.h
index 12135a652c..132a585802 100644
--- a/drivers/net/ntnic/include/hw_mod_flm_v25.h
+++ b/drivers/net/ntnic/include/hw_mod_flm_v25.h
@@ -226,8 +226,7 @@ struct flm_v25_scrub_s {
 	uint8_t inf;
 };
 
-#pragma pack(1)
-struct flm_v25_lrn_data_s {
+struct __rte_packed_begin flm_v25_lrn_data_s {
 	uint32_t sw9;	/* 31:0 (32) */
 	uint32_t sw8;	/* 63:32 (32) */
 	uint32_t qw4[4];/* 191:64 (128) */
@@ -267,9 +266,9 @@ struct flm_v25_lrn_data_s {
 	uint64_t nofi : 1;	/* 716:716 (1) */
 	uint64_t pad : 50;	/* 766:717 (50) */
 	uint64_t eor : 1;	/* 767:767 (1) */
-};
+} __rte_packed_end;
 
-struct flm_v25_inf_data_s {
+struct __rte_packed_begin flm_v25_inf_data_s {
 	uint64_t bytes;
 	uint64_t packets;
 	uint64_t ts;
@@ -277,9 +276,9 @@ struct flm_v25_inf_data_s {
 	uint64_t cause : 3;
 	uint64_t pad : 60;
 	uint64_t eor : 1;
-};
+} __rte_packed_end;
 
-struct flm_v25_sta_data_s {
+struct __rte_packed_begin flm_v25_sta_data_s {
 	uint32_t id;
 	uint64_t lds : 1;
 	uint64_t lfs : 1;
@@ -292,8 +291,7 @@ struct flm_v25_sta_data_s {
 	uint64_t pis : 1;
 	uint64_t pad : 54;
 	uint64_t eor : 1;
-};
-#pragma pack()
+} __rte_packed_end;
 
 struct hw_mod_flm_v25_s {
 	struct flm_v25_control_s *control;
diff --git a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
index 0b611462a0..6ef739279a 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
@@ -171,26 +171,23 @@ int nthw_spi_v3_transfer(nthw_spi_v3_t *p, uint16_t opcode, struct tx_rx_buf *tx
 	const uint16_t max_payload_rx_size = rx_buf->size;
 	int result = 0;
 
-#pragma pack(push, 1)
-	union {
+	union __rte_packed_begin {
 		uint32_t raw;
 
 		struct {
 			uint16_t opcode;
 			uint16_t size;
 		};
-	} spi_tx_hdr;
+	} __rte_packed_end spi_tx_hdr;
 
-	union {
+	union __rte_packed_begin {
 		uint32_t raw;
 
 		struct {
 			uint16_t error_code;
 			uint16_t size;
 		};
-	} spi_rx_hdr;
-
-#pragma pack(pop)
+	} __rte_packed_end spi_rx_hdr;
 
 #ifdef SPI_V3_DEBUG_PRINT
 	NT_LOG_DBG(DBG, NTHW, "Started");
@@ -294,7 +291,9 @@ int nthw_spi_v3_transfer(nthw_spi_v3_t *p, uint16_t opcode, struct tx_rx_buf *tx
 				if (result != 0)
 					return result;
 
-				result = nthw_spis_read_rx_fifo(p->mp_spis_mod, &spi_rx_hdr.raw);
+				typeof(spi_rx_hdr.raw) raw;
+				result = nthw_spis_read_rx_fifo(p->mp_spis_mod, &raw);
+				spi_rx_hdr.raw = raw;
 
 				if (result != 0) {
 					NT_LOG(WRN, NTHW, "nthw_spis_read_rx_fifo failed");
-- 
2.47.1

