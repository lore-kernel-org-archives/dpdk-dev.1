Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E791FC369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD4A40A73;
	Mon,  5 May 2025 09:14:04 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 6C89140DDB
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:02 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2048.outbound.protection.outlook.com [104.47.11.48]) by
 mx-outbound14-199.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC9CZ28WEFJMX8JkkvkyB3b9uYESgnMhMHn2YuSGuR+KNfN0zBgN1KBVUCrUJpJkK4gUat3qTFV8BF3LyNkFwGC7eLvrMGtPu7IC1nocdfcf3q+Ww1l+izTSF1SYjjMkduRpEIuJOnIIWWE5Y/7V7Gyc6wLyEgRjut17L9NfD27dSozeTYYzDP0z6RX2L2TGI78R0gOq4pONJ2ygz7iWHT1CNncBb4z31ike6/utliSD7xArWuT7+YbcSOURQ0DivVB2hJLUfsvR3HAtgQflFECCyLeeV5BG0ZLfxMoQ7/lWy+OMEXfnVz3AWNVxvUQIg4bxEzAFxiATLTu3E6824g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zGKUw85DVRgQmsB0gSdaxZXuWTcZXZz4tg6kk4Ipa8=;
 b=r45ChJJAya3aSk4mxd/e/0hDpH5X1oARHWkWqrD1/bJhHIisiLOw/lRCQgbEL+lDGzc5kGODtiyND2Qb+VhlylrZg6dQuJ2QgzGX0OmJVK2wLglDvHwUsBNv6/1ONLiByjOgotyGE1JuHpqJpaPRqEz0CvAm1GqHVBmIKLtCYHpMFhNBX98mGKdsjamRBR1/eS2GSTpq4Xhu0wer95CPYdoX7LG20c5QFq4fH37/UtlIP7rDghYlYi2sPbqLfTZqJEHUuhxdkcvxfgWLz35oPQ6EFEc2KbUIwNUKyZrEtB0htqGKJKVpLDRrne7pRgPvd6mmP4DnRcbCm7CZubsXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zGKUw85DVRgQmsB0gSdaxZXuWTcZXZz4tg6kk4Ipa8=;
 b=VaCC+djqixDh6H8UFL14HAXYGMYdxNZ0KbwahDhyuZuWNYpfxlcyI2cndeFcaheiFkacU1hdQGXJzcgR8d7gTFHQcP4fCmjj4PajEn6QeXMbm4++eyNrPi4rFS4RorFTZJF03YCU4wCgmSYMpCUIegffX04VCoiYmR4qJekMVoM=
Received: from DU7P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::6) by
 GV1P190MB2112.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:17b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Mon, 5 May 2025 07:13:14 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::19) by DU7P191CA0026.outlook.office365.com
 (2603:10a6:10:54e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:13
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 03/26] net/ntnic: replace pragma pack with DPDK defined
 macros
Date: Mon,  5 May 2025 09:12:43 +0200
Message-ID: <20250505071309.586015-4-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|GV1P190MB2112:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a436e92e-bdf0-497f-b91d-08dd8ba44ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I02VwvEH0Re/xD9vvDHNhtwG+TToHQN+L2uXMtcPFEgjhLnwKY2KUtdQdyW5?=
 =?us-ascii?Q?e/I4Y5j90BCcp/DH+sXN0FQQVm1XqWxgkfpG6smTNhcQP1eNIU8UxLbXOpn2?=
 =?us-ascii?Q?j0sRGZ4EHoaub47YHd6uidSpgMoi7HrVDf1Sh5D/YFihOJq512PzjOIrrvxC?=
 =?us-ascii?Q?d50z6SaRzI9l73POKCdhJ/S7mb2O6S5TjbxZEjyZqfDgNgku6YQHvsAdPJA3?=
 =?us-ascii?Q?axxkbZW1uXcksr4Ytnl+cqfMosYS0ETqnCisyhzHhd7DZnvzGZqgvqrX4INb?=
 =?us-ascii?Q?x6bU+6W/RT1d5Dgs34bSDwJKdIpIkw1T9DGLOsOUzIfTyg65WUtQDlnAB/E9?=
 =?us-ascii?Q?rsqS5G8RR7neMPnQiGrt+5ay+SsPCSzU65IKZ5qHZkRq5rNN6G/pZn1mw4kn?=
 =?us-ascii?Q?d4VA26sCsB0EdpDtFlfiYOut+zOAk7YjFn+wtOSRS+6+AOypYlToUuZ5zWuv?=
 =?us-ascii?Q?4CUtLGY3HcsgX5wzatt7noJxfzeuSjbuM8Vij9wVMfBfXOTubqkBwwRV18e8?=
 =?us-ascii?Q?8Tav1XfAGyErKlqNKa01UBTYNtzbjcj5pTZys3laSr7F3WxdhqHToJtwqBTU?=
 =?us-ascii?Q?A1sqRikSTctc2GlcRRXTxcXpZlxea/0p55zMCWakncMUoMSyQ+Xuy/efiuLR?=
 =?us-ascii?Q?rgCk8rWhpeomyxGUnU2Tq7cRHLcBGTEXrAnUw37wsXuE/zLJuhgbcu8Jjr1D?=
 =?us-ascii?Q?vwLFKS8wBlyPv/zOlfgQtBdZQfxVv9coAbkOXVqj5cHuO/prrW6tIPE7MJf1?=
 =?us-ascii?Q?0ldlwbgRAjx8M5NvcJYfNFDZpwREJiz2U4usotdz+fzA0PiWG8l+sjqB1XmB?=
 =?us-ascii?Q?KutGjWVjJJ8+2AMa9ikB8G/feTm1MxJdo4sonTJ0Asg5fkNJxoP1xRskSoqF?=
 =?us-ascii?Q?M91XJM+QjXbKHCK5u1otNKwR2PGpGN/U1JgcjClVY2+/3iQlqJQ8kGG2Dxfx?=
 =?us-ascii?Q?b255hMZcE+XgKmauB70Z4qliAAtv2r8QGBS4T2uD53bYOtA1gPYfv1hTS+ke?=
 =?us-ascii?Q?G9yhTFFX9QQ2Vmh8I+EWuzBgEoV7SXurorIjPRWRuA4A2rcrjhTyECFUjAV8?=
 =?us-ascii?Q?8I5LztTPGeuxJbAH27LK/HZyTpNY9m+2EWLnEb/XRHNU+KjI9axvvwQQV3Vn?=
 =?us-ascii?Q?YoCjhFLArSBDTKckR9rrRztDnNhv5rWL2hAUtx+fR4w2b7ldEuMpchRjXkgn?=
 =?us-ascii?Q?AvlzRHCRWmlSr5DNN9VnmxWF+UXUGKOOFQPm1A1a1Vwn1P4kG5kbh8X23OXI?=
 =?us-ascii?Q?ttcW7vpguWT26g38AOw2kolGeRsvef4nn2B7jY3GwdKlR67CquPymOul/Ran?=
 =?us-ascii?Q?mhhbWsmBOmoGRmX7Ss6AXWJqKL8xf92tOcfgfB0J0K80iD92a0KsWrITgKGX?=
 =?us-ascii?Q?3lMt8hqsiTBCF0OU/BYTv0ZCRYo7MAWLxOX6/gvqkuLfxlLCl5uForXbgSbO?=
 =?us-ascii?Q?FXHFgoxa/nz+jUeEhUN03CoF3DLjJSArIsq9r2hx8xgT+qi5nPSASmbFUqRJ?=
 =?us-ascii?Q?1vqKGOsDq/WseHBT1A07iYOG0xLzkn2oKgrv?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OSYy78G4OOB4WIQc32B6MYxbQ2sERQWZgRZa1F0jSrV7Y4pFysEJ59NmLPhNWeZ5zEjYV4uvVReNyr1bnoDvK94n60ehBE0huwBHzWK8J8qTl3UvKlbM5xu2Bic7vhB5qFFLQYAdPYQ2SfiZ3YdOEGejNpEmVFKp8iKqJVu4L+muTBK+4RzRBUw/Dmr1DaK4/ZqZJFqLxBlmpEPNqK0FcicRVN9mv2m2WvXn9fM5ZMJ1uGVQHSbCKrjsFFuxJXt24unl0h2eBDCKtqWVSy7vqCGEx21DbCImnZn7BIa6PQOcmnBTwP/011Bz7k0GaPQlAbPgepN4/z+EHebEVi84gIzJ5xIcdt2ZTV/YQ23LidOgFFcuoITs+tk1e/QioeocMInNdFXTh+Fq2KgTiPlq+uuLI4pVbNlPZmHHVaTJpS2nyUWvtBX3CQ0XUPzVt/qs8fUpNiITIYPP4ZUscoDUDRquq8EyInjWaCkUR6QesWLwW0Iy2TiFKbbtZeVZnp8WxQytaEcEW1OFwse9TL0vpI7+b2ndEAZXTq4k+XFKmgNmVs+HbXrOvsVyj0Mavo8OqyjTnCoz2r/jOhk+R5PVTQbADE/ToZP14h2imr5AOthR4aJkr44Z/6xXhmHPsIEddXSghZ7uynWTZasHcPuN3w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:13.6057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a436e92e-bdf0-497f-b91d-08dd8ba44ce9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2112
X-BESS-ID: 1746429197-303783-7645-377-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaW5qZAVgZQ0MDI0MzQJNnEIM
 nc0sjI3NzANC3VGMhPtbA0tTA2NFWqjQUAL+eqBEEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan18-156.eu-central-1b.ess.aws.cudaops.com]
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

