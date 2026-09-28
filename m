Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CDBCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2348540E8A;
	Tue, 29 Sep 2026 07:41:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AE2E540275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 18:39:09 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SFvGM01792818; Mon, 28 Sep 2026 09:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 Li338Z6OA/gLanjS3vo1yvwhbjcFdcpaQkufSoa3mA=; b=RbIqj26Ir3EabcLBc
 sDUxNkqAvNsv1Gv9RfeUrCI5lCezavM+96ma93bDBlWBrUx97m3SVvVJ/rm4pGt8
 femgeLv2rkCQmYRgvuceRCn3hz8JDr3h3qrhYjp5VvhX7NaH46ZBRThdOiYFPdLK
 HWTlaXbsRYFY42vErLS4WDfn52F1sLasb9XE/1Xe0P1N2nqKDaUKbXU/MmKQd0LJ
 +/WIeNhTqFBwhq47ATx8UaUj6lo+AuQweTW1ojoEiH3gnorK73kAmX6+Jf8tKDLV
 SDyB+mua58TVM8WmukNogmRF7rtWcpX4kuKZUR2L0KJYO6M6j0ULsjNdrYu9Ijx1
 +U6Xg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gyub5r8ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 09:39:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Sep 2026 09:39:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 28 Sep 2026 09:39:08 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 97E8D3F70BE;
 Mon, 28 Sep 2026 09:39:06 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <gmuthukrishn@marvell.com>, <kai.ji@intel.com>
Subject: [PATCH v2 4/4] app/crypto-perf: add ML-DSA sign support
Date: Mon, 28 Sep 2026 22:08:58 +0530
Message-ID: <20260928163858.1281221-4-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928163858.1281221-1-psenapati@marvell.com>
References: <20260928163858.1281221-1-psenapati@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX2PqKJ7TmkrLv
 0aXtcZ1RefeowpSigvlwjN8e5iEaEqg5Mdcg0a81F15GumOgFM+hDDrh6SbxDG0eX6T0b+LiKF8
 uj/Rg6r9J1NhV4fWpN8dhY61QTFmRwUheSjkaLhoKWAW/5SdWgMxnx/ExGxvjc96xmFMYRbB4Y7
 PiLMVvyos55/RYt6VKf3CgTwhdO2vfKR+lVlZtd6c3BojLYEZNRnNuxTD0Ygq2nEdhLUWlj15XV
 9oAukQa+VPYc0bA+uiDnn8i/UhJZHMC3E2wndBBivDoscoST4/97kAocosxa10vxKcimyzzsE2m
 hOBO0F1491q7B0W/07EMEaaLGEAjt7aG6a4YugaunZSz7Cwjav1gQq1vNvvy6J0eGPnprFpgYiY
 0ytyC8con9pztL1cKfBMLy9N7JCRGOZETvkRrutnknW6aO7PkmfwA+I8XYDVZMKznPBOmud7ilA
 XC2JbCa4sMNfZwmUTTQ==
X-Proofpoint-ORIG-GUID: YEHhwhtKIFf9SYZZKDVdAAkh3577eY4R
X-Authority-Analysis: v=2.4 cv=e/ST2qp/ c=1 sm=1 tr=0 ts=6aba982c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=lX3d3-WNs_jbNntNpE4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YEHhwhtKIFf9SYZZKDVdAAkh3577eY4R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NiBTYWx0ZWRfX0cbFGgDF1EVk
 b7iZBeTTmd8EIUvBx7YX8qDMJuvVaZ5zLTAj2NiBt0GdYxehLO/vaUf88hzc/Rcs5S5ZHGSnrfx
 1Xux2mtzElsvpiQhesKbHn9AHclm0hw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Mailman-Approved-At: Tue, 29 Sep 2026 07:41:44 +0200
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

Extend ML-DSA sign iteration support to include
ML-DSA65 and ML-DSA87 for 1, 5 and 10 sign iterations.

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 app/test-crypto-perf/cperf_options_parsing.c |   3 +-
 app/test-crypto-perf/cperf_test_vectors.c    | 220 ++++++++++++++++---
 app/test-crypto-perf/main.c                  |  28 +--
 doc/guides/tools/cryptoperf.rst              |   5 +-
 4 files changed, 210 insertions(+), 46 deletions(-)

diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 332e8746b2..bc7ccdcc9e 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -1820,8 +1820,7 @@ cperf_options_dump(struct cperf_options *opts)
 		case CPERF_ASYM_MLDSA65:
 		case CPERF_ASYM_MLDSA87:
 			printf("# mldsa algorithm: %s\n", cperf_op_type_strs[opts->op_type]);
-			if (opts->op_type == CPERF_ASYM_MLDSA44 &&
-				opts->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN)
+			if (opts->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN)
 				printf("# mldsa sign iterations: %u\n", opts->mldsa_sign_iter);
 			break;
 		case CPERF_ASYM_MLKEM512:
diff --git a/app/test-crypto-perf/cperf_test_vectors.c b/app/test-crypto-perf/cperf_test_vectors.c
index c88a6a1f12..11f7afa189 100644
--- a/app/test-crypto-perf/cperf_test_vectors.c
+++ b/app/test-crypto-perf/cperf_test_vectors.c
@@ -5552,7 +5552,7 @@ uint8_t mldsa_44_extmu[] = {
 	0xF5, 0x2E, 0x4B, 0x7C, 0xD6, 0x2A, 0xF4, 0x2E,
 };
 
-static const uint8_t mldsa_44_message_5_iter[] = {
+static uint8_t mldsa_44_message_5_iter[] = {
 	0x5E, 0x42, 0x43, 0x44, 0x99, 0x76, 0x99, 0x99,
 	0xA3, 0x7F, 0x2B, 0xE1, 0x54, 0xC8, 0x0D, 0x6E,
 	0x31, 0xBB, 0x85, 0x92, 0xF0, 0x5A, 0xD7, 0x23,
@@ -5568,7 +5568,7 @@ static const uint8_t mldsa_44_message_5_iter[] = {
 	0x99, 0x99, 0x99, 0x9D, 0xAC, 0x48, 0x59, 0x77,
 };
 
-static const uint8_t mldsa_44_message_10_iter[] = {
+static uint8_t mldsa_44_message_10_iter[] = {
 	0x3F, 0x42, 0x43, 0x44, 0x99, 0x76, 0x99, 0x99,
 	0xA3, 0x7F, 0x2B, 0xE1, 0x54, 0xC8, 0x0D, 0x6E,
 	0x31, 0xBB, 0x85, 0x92, 0xF0, 0x5A, 0xD7, 0x23,
@@ -5584,7 +5584,7 @@ static const uint8_t mldsa_44_message_10_iter[] = {
 	0x99, 0x99, 0x99, 0x9D, 0xAC, 0x48, 0x59, 0x77,
 };
 
-static const uint8_t mldsa_44_sign_1_iter[] = {
+static uint8_t mldsa_44_sign_1_iter[] = {
 	0xFD, 0x1F, 0x49, 0x0A, 0xFF, 0x04, 0x28, 0x4A,
 	0xEF, 0xDE, 0x2F, 0xD2, 0x6E, 0x4B, 0x20, 0x12,
 	0xCC, 0xF1, 0x6C, 0x35, 0x02, 0xE0, 0xE6, 0xE6,
@@ -5890,7 +5890,7 @@ static const uint8_t mldsa_44_sign_1_iter[] = {
 	0x0F, 0x1E, 0x31, 0x43,
 };
 
-static const uint8_t mldsa_44_sign_5_iter[] = {
+static uint8_t mldsa_44_sign_5_iter[] = {
 	0x96, 0x98, 0xF9, 0xE6, 0x22, 0xEF, 0x58, 0xF4,
 	0x57, 0x82, 0xF7, 0x40, 0x95, 0x1A, 0xE7, 0x9C,
 	0x0E, 0x95, 0x77, 0xEA, 0x32, 0x86, 0xAE, 0x81,
@@ -6197,7 +6197,7 @@ static const uint8_t mldsa_44_sign_5_iter[] = {
 
 };
 
-static const uint8_t mldsa_44_sign_10_iter[] = {
+static uint8_t mldsa_44_sign_10_iter[] = {
 	0x21, 0x06, 0x63, 0xCE, 0xA8, 0xAA, 0x3A, 0x78,
 	0xD9, 0xF1, 0x8E, 0x75, 0xF8, 0xA0, 0xC9, 0x89,
 	0xD7, 0x85, 0xBF, 0xE4, 0x5C, 0xEB, 0x99, 0x45,
@@ -6504,7 +6504,7 @@ static const uint8_t mldsa_44_sign_10_iter[] = {
 
 };
 
-static const uint8_t mlkem_768_dk[] = {
+static uint8_t mlkem_768_dk[] = {
 	0x29, 0x18, 0xA0, 0x56, 0x30, 0x51, 0x93, 0xF1,
 	0x80, 0xB9, 0xCB, 0xAE, 0xD3, 0x97, 0x02, 0x73,
 	0xAB, 0x7D, 0x7C, 0xEB, 0x44, 0x03, 0x60, 0x06,
@@ -6807,7 +6807,7 @@ static const uint8_t mlkem_768_dk[] = {
 	0xBB, 0x2B, 0x37, 0x59, 0x85, 0x84, 0xE0, 0xF9,
 };
 
-static const uint8_t mlkem_768_ek[] = {
+static uint8_t mlkem_768_ek[] = {
 	0x7B, 0x15, 0x44, 0x17, 0xF9, 0x85, 0xAB, 0xF3,
 	0xCE, 0xDE, 0x04, 0x8A, 0xF1, 0xCA, 0x3A, 0x63,
 	0xB7, 0x79, 0xFA, 0x00, 0xAD, 0x20, 0x62, 0x31,
@@ -6958,14 +6958,14 @@ static const uint8_t mlkem_768_ek[] = {
 	0x1D, 0x85, 0xA8, 0x04, 0xD6, 0xCD, 0x32, 0x5F,
 };
 
-static const uint8_t mlkem_768_message[] = {
+static uint8_t mlkem_768_message[] = {
 	0x16, 0x20, 0x03, 0x2E, 0xBD, 0xB3, 0x08, 0xF2,
 	0xBE, 0xF4, 0x07, 0x03, 0x06, 0xAF, 0x29, 0xFD,
 	0x2D, 0x30, 0x73, 0xA0, 0xE5, 0x79, 0xCF, 0x90,
 	0x78, 0x7C, 0xCE, 0xC8, 0x9C, 0x4D, 0x9F, 0x16,
 };
 
-static const uint8_t mlkem_768_cipher[] = {
+static uint8_t mlkem_768_cipher[] = {
 	0x0E, 0x0C, 0x21, 0xA5, 0x33, 0x7A, 0xFC, 0x3C,
 	0x76, 0x9A, 0x80, 0x14, 0xD7, 0x82, 0x8E, 0x7A,
 	0xBC, 0xCF, 0xF0, 0xA9, 0x77, 0xD7, 0x92, 0x9E,
@@ -7104,14 +7104,14 @@ static const uint8_t mlkem_768_cipher[] = {
 	0xD3, 0xC9, 0xB5, 0x2A, 0x6C, 0xE8, 0x1F, 0xE1,
 };
 
-static const uint8_t mlkem_768_sk[] = {
+static uint8_t mlkem_768_sk[] = {
 	0x21, 0xA7, 0x5C, 0x6A, 0x1B, 0xC9, 0xA1, 0x0B,
 	0x3D, 0x99, 0x03, 0xBE, 0xE5, 0x5C, 0x26, 0x18,
 	0x0D, 0xF3, 0x1D, 0x21, 0x66, 0x1E, 0x39, 0x7B,
 	0x64, 0x6A, 0x57, 0x54, 0xAE, 0x70, 0xFB, 0x69,
 };
 
-static const uint8_t mlkem_1024_dk[] = {
+static uint8_t mlkem_1024_dk[] = {
 	0xBA, 0x60, 0x87, 0x43, 0x75, 0x8A, 0xB6, 0xCA,
 	0xCD, 0xFD, 0xAA, 0x89, 0xD3, 0x54, 0xA0, 0x21,
 	0x61, 0xCF, 0x3A, 0xCB, 0x62, 0x86, 0x5A, 0x11,
@@ -7510,7 +7510,7 @@ static const uint8_t mlkem_1024_dk[] = {
 	0x58, 0x0B, 0xBB, 0x61, 0x45, 0x9C, 0xA3, 0xE1,
 };
 
-static const uint8_t mlkem_1024_ek[] = {
+static uint8_t mlkem_1024_ek[] = {
 	0x8E, 0x4B, 0xB1, 0x60, 0xF4, 0x62, 0xE1, 0xE9,
 	0xBA, 0xF9, 0x5C, 0x65, 0x4F, 0x00, 0x60, 0xBB,
 	0x94, 0x8C, 0xEF, 0x14, 0x87, 0x7B, 0x52, 0x2F,
@@ -7709,14 +7709,14 @@ static const uint8_t mlkem_1024_ek[] = {
 	0x27, 0xF1, 0xC7, 0x3F, 0xD5, 0x54, 0x61, 0xF2,
 };
 
-static const uint8_t mlkem_1024_message[] = {
+static uint8_t mlkem_1024_message[] = {
 	0xA9, 0x91, 0x84, 0x52, 0x12, 0x42, 0xC8, 0xF4,
 	0x6C, 0x5D, 0x0F, 0x04, 0xCD, 0x9E, 0x82, 0x14,
 	0x15, 0x74, 0xDA, 0xD5, 0xF9, 0xF4, 0xF5, 0x9A,
 	0x6B, 0x17, 0x9B, 0xF8, 0x54, 0xF8, 0xFA, 0x9C,
 };
 
-static const uint8_t mlkem_1024_cipher[] = {
+static uint8_t mlkem_1024_cipher[] = {
 	0xCE, 0xE7, 0x81, 0x3D, 0x95, 0x80, 0x18, 0x33,
 	0x48, 0xC0, 0x05, 0xD1, 0x34, 0x69, 0x8E, 0x0B,
 	0xA9, 0x3E, 0xEC, 0x60, 0xE5, 0xBC, 0x55, 0x3B,
@@ -7915,21 +7915,21 @@ static const uint8_t mlkem_1024_cipher[] = {
 	0xB3, 0x89, 0x73, 0xBA, 0x02, 0x76, 0x64, 0x24,
 };
 
-static const uint8_t mlkem_1024_sk[] = {
+static uint8_t mlkem_1024_sk[] = {
 	0x14, 0x0F, 0x5E, 0x1F, 0x11, 0x85, 0x16, 0x26,
 	0xE4, 0x65, 0x6C, 0x09, 0x7C, 0xE1, 0x9A, 0x32,
 	0x28, 0x4E, 0x31, 0x64, 0x58, 0xA5, 0xE6, 0x90,
 	0xDD, 0x06, 0xD9, 0x38, 0x10, 0x34, 0xC6, 0xB4,
 };
 
-static const uint8_t mldsa_65_seed[] = {
+uint8_t mldsa_65_seed[] = {
 	0xAF, 0xB4, 0x7E, 0x7A, 0x2B, 0x5C, 0x6B, 0xF9,
 	0xE7, 0x3E, 0xFE, 0xD6, 0x4B, 0x27, 0x90, 0x48,
 	0xD3, 0xA2, 0x35, 0x42, 0x11, 0xD2, 0xCA, 0x31,
 	0xE1, 0xA7, 0xA6, 0xC2, 0xD8, 0x28, 0xCF, 0xCF,
 };
 
-static const uint8_t mldsa_65_privkey_noseed[] = {
+static uint8_t mldsa_65_privkey_noseed[] = {
 	0x1D, 0x6D, 0xB9, 0x95, 0x3A, 0xB9, 0x93, 0x6C,
 	0x2B, 0x7D, 0xB2, 0xF6, 0xEE, 0x16, 0x69, 0x8C,
 	0x49, 0xF3, 0x74, 0xB1, 0x42, 0xE8, 0x88, 0x07,
@@ -8436,7 +8436,7 @@ static const uint8_t mldsa_65_privkey_noseed[] = {
 	0xD3, 0x5D, 0x50, 0x2F, 0x70, 0x03, 0xE7, 0xDE,
 };
 
-static const uint8_t mldsa_65_pubkey_noseed[] = {
+static uint8_t mldsa_65_pubkey_noseed[] = {
 	0x1D, 0x6D, 0xB9, 0x95, 0x3A, 0xB9, 0x93, 0x6C,
 	0x2B, 0x7D, 0xB2, 0xF6, 0xEE, 0x16, 0x69, 0x8C,
 	0x49, 0xF3, 0x74, 0xB1, 0x42, 0xE8, 0x88, 0x07,
@@ -8683,14 +8683,14 @@ static const uint8_t mldsa_65_pubkey_noseed[] = {
 	0xAD, 0x5C, 0x6C, 0xEF, 0x33, 0x13, 0x4D, 0x61,
 };
 
-static const uint8_t mldsa_65_message[] = {
-	0x60, 0xD4, 0x8C, 0xF2, 0x61, 0x6D, 0xB0, 0xB6,
+static uint8_t mldsa_65_message[] = {
+	0x1C, 0x00, 0x00, 0x00, 0x61, 0x6D, 0xB0, 0xB6,
 	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
 	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
 	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
 };
 
-static const uint8_t mldsa_65_sign_dtrm[] = {
+static uint8_t mldsa_65_sign_dtrm[] = {
 	0xD1, 0x54, 0x6B, 0x32, 0x93, 0xC2, 0xFE, 0xA1,
 	0x5F, 0x8D, 0x6C, 0xF4, 0x2A, 0x86, 0xFA, 0x5D,
 	0xAB, 0xFA, 0x0C, 0x42, 0x49, 0x48, 0x7E, 0x77,
@@ -9107,14 +9107,14 @@ static const uint8_t mldsa_65_sign_dtrm[] = {
 	0x10, 0x14, 0x1C, 0x24, 0x2F,
 };
 
-static const uint8_t mldsa_87_seed[] = {
+uint8_t mldsa_87_seed[] = {
 	0x2F, 0xA5, 0xF2, 0x15, 0xFE, 0x26, 0x93, 0x2F,
 	0xF4, 0x7C, 0xF3, 0x03, 0x6F, 0xC4, 0x0F, 0x4A,
 	0x4B, 0x43, 0xA2, 0x70, 0xB3, 0x2A, 0xAD, 0xB0,
 	0x9D, 0x74, 0x8D, 0xFE, 0xD2, 0x07, 0x52, 0x8B,
 };
 
-static const uint8_t mldsa_87_privkey_noseed[] = {
+static uint8_t mldsa_87_privkey_noseed[] = {
 	0xD4, 0xFF, 0xA6, 0x98, 0xD8, 0x54, 0x53, 0xB6,
 	0xEE, 0xA1, 0xB2, 0x2C, 0xA3, 0xCB, 0xE1, 0x95,
 	0xA1, 0x92, 0x92, 0x54, 0x4B, 0xED, 0x50, 0x89,
@@ -9729,7 +9729,7 @@ static const uint8_t mldsa_87_privkey_noseed[] = {
 	0x1A, 0x6E, 0xD8, 0x73, 0xC3, 0xDC, 0xF7, 0xDB,
 };
 
-static const uint8_t mldsa_87_pubkey_noseed[] = {
+static uint8_t mldsa_87_pubkey_noseed[] = {
 	0xD4, 0xFF, 0xA6, 0x98, 0xD8, 0x54, 0x53, 0xB6,
 	0xEE, 0xA1, 0xB2, 0x2C, 0xA3, 0xCB, 0xE1, 0x95,
 	0xA1, 0x92, 0x92, 0x54, 0x4B, 0xED, 0x50, 0x89,
@@ -10056,14 +10056,14 @@ static const uint8_t mldsa_87_pubkey_noseed[] = {
 	0x62, 0x5A, 0x7D, 0x2F, 0xE2, 0xEC, 0xE8, 0xD5,
 };
 
-static const uint8_t mldsa_87_message[] = {
+static uint8_t mldsa_87_message[] = {
 	0x75, 0x35, 0x3E, 0x04, 0xF4, 0xB3, 0xD4, 0x7F,
 	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
 	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
 	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
 };
 
-static const uint8_t mldsa_87_sign_dtrm[] = {
+static uint8_t mldsa_87_sign_dtrm[] = {
 	0x55, 0x63, 0x52, 0x72, 0xAA, 0xFF, 0x4C, 0xEC,
 	0x2F, 0x28, 0x5C, 0x59, 0x13, 0xAD, 0xFC, 0xA0,
 	0xBC, 0xDC, 0x96, 0x49, 0xFA, 0xDB, 0x7B, 0x57,
@@ -10645,6 +10645,48 @@ static const uint8_t mldsa_87_sign_dtrm[] = {
 	0x28, 0x30, 0x3C,
 };
 
+static uint8_t mldsa_65_message_1_iter[] = {
+	0x13, 0xCD, 0x8C, 0x83, 0x61, 0x6D, 0xB0, 0xB6,
+	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
+	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
+	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
+};
+
+static uint8_t mldsa_65_message_5_iter[] = {
+	0xE3, 0xB3, 0xF1, 0x9F, 0x61, 0x6D, 0xB0, 0xB6,
+	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
+	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
+	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
+};
+
+static uint8_t mldsa_65_message_10_iter[] = {
+	0x83, 0x81, 0xBB, 0xD8, 0x61, 0x6D, 0xB0, 0xB6,
+	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
+	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
+	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
+};
+
+static uint8_t mldsa_87_message_1_iter[] = {
+	0x80, 0x1B, 0x53, 0xC5, 0xF4, 0xB3, 0xD4, 0x7F,
+	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
+	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
+	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
+};
+
+static uint8_t mldsa_87_message_5_iter[] = {
+	0x50, 0x02, 0xB8, 0xE1, 0xF4, 0xB3, 0xD4, 0x7F,
+	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
+	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
+	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
+};
+
+static uint8_t mldsa_87_message_10_iter[] = {
+	0xD2, 0xAD, 0x0A, 0xE5, 0xF4, 0xB3, 0xD4, 0x7F,
+	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
+	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
+	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
+};
+
 struct
 cperf_rsa_test_data rsa_qt_perf_data[4] = {
 	{
@@ -11222,6 +11264,48 @@ struct cperf_mldsa_test_data mldsa_sign_perf_data_1_iter[] = {
 		},
 		.sign_deterministic = true,
 	},
+	{
+		.name = "mldsa_65_sign_1_iteration (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_65,
+		.privkey = {
+			.data = mldsa_65_privkey_noseed,
+			.length = sizeof(mldsa_65_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_65_pubkey_noseed,
+			.length = sizeof(mldsa_65_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_65_message_1_iter,
+			.length = sizeof(mldsa_65_message_1_iter),
+		},
+		.sign = {
+			.data = mldsa_65_sign_dtrm,
+			.length = sizeof(mldsa_65_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
+	{
+		.name = "mldsa_87_sign_1_iteration (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_87,
+		.privkey = {
+			.data = mldsa_87_privkey_noseed,
+			.length = sizeof(mldsa_87_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_87_pubkey_noseed,
+			.length = sizeof(mldsa_87_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_87_message_1_iter,
+			.length = sizeof(mldsa_87_message_1_iter),
+		},
+		.sign = {
+			.data = mldsa_87_sign_dtrm,
+			.length = sizeof(mldsa_87_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
 };
 
 struct cperf_mldsa_test_data mldsa_sign_perf_data_5_iter[] = {
@@ -11246,6 +11330,48 @@ struct cperf_mldsa_test_data mldsa_sign_perf_data_5_iter[] = {
 		},
 		.sign_deterministic = true,
 	},
+	{
+		.name = "mldsa_65_sign_5_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_65,
+		.privkey = {
+			.data = mldsa_65_privkey_noseed,
+			.length = sizeof(mldsa_65_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_65_pubkey_noseed,
+			.length = sizeof(mldsa_65_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_65_message_5_iter,
+			.length = sizeof(mldsa_65_message_5_iter),
+		},
+		.sign = {
+			.data = mldsa_65_sign_dtrm,
+			.length = sizeof(mldsa_65_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
+	{
+		.name = "mldsa_87_sign_5_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_87,
+		.privkey = {
+			.data = mldsa_87_privkey_noseed,
+			.length = sizeof(mldsa_87_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_87_pubkey_noseed,
+			.length = sizeof(mldsa_87_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_87_message_5_iter,
+			.length = sizeof(mldsa_87_message_5_iter),
+		},
+		.sign = {
+			.data = mldsa_87_sign_dtrm,
+			.length = sizeof(mldsa_87_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
 };
 
 struct cperf_mldsa_test_data mldsa_sign_perf_data_10_iter[] = {
@@ -11270,6 +11396,48 @@ struct cperf_mldsa_test_data mldsa_sign_perf_data_10_iter[] = {
 		},
 		.sign_deterministic = true,
 	},
+	{
+		.name = "mldsa_65_sign_10_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_65,
+		.privkey = {
+			.data = mldsa_65_privkey_noseed,
+			.length = sizeof(mldsa_65_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_65_pubkey_noseed,
+			.length = sizeof(mldsa_65_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_65_message_10_iter,
+			.length = sizeof(mldsa_65_message_10_iter),
+		},
+		.sign = {
+			.data = mldsa_65_sign_dtrm,
+			.length = sizeof(mldsa_65_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
+	{
+		.name = "mldsa_87_sign_10_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_87,
+		.privkey = {
+			.data = mldsa_87_privkey_noseed,
+			.length = sizeof(mldsa_87_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_87_pubkey_noseed,
+			.length = sizeof(mldsa_87_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_87_message_10_iter,
+			.length = sizeof(mldsa_87_message_10_iter),
+		},
+		.sign = {
+			.data = mldsa_87_sign_dtrm,
+			.length = sizeof(mldsa_87_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
 };
 
 struct cperf_test_vector*
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index 85e145165f..dc781bb9cc 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -544,23 +544,19 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 				mldsa_idx = 2;
 
 			if (opts->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
-				if (opts->op_type == CPERF_ASYM_MLDSA44) {
-					switch (opts->mldsa_sign_iter) {
-					case 1:
-						opts->mldsa_data = &mldsa_sign_perf_data_1_iter[0];
-						break;
-					case 5:
-						opts->mldsa_data = &mldsa_sign_perf_data_5_iter[0];
-						break;
-					case 10:
-						opts->mldsa_data = &mldsa_sign_perf_data_10_iter[0];
-						break;
-					default:
-						opts->mldsa_data = &mldsa_sign_perf_data[0];
-						break;
-					}
-				} else {
+				switch (opts->mldsa_sign_iter) {
+				case 1:
+					opts->mldsa_data = &mldsa_sign_perf_data_1_iter[mldsa_idx];
+					break;
+				case 5:
+					opts->mldsa_data = &mldsa_sign_perf_data_5_iter[mldsa_idx];
+					break;
+				case 10:
+					opts->mldsa_data = &mldsa_sign_perf_data_10_iter[mldsa_idx];
+					break;
+				default:
 					opts->mldsa_data = &mldsa_sign_perf_data[mldsa_idx];
+					break;
 				}
 			} else if (opts->asym_op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
 				opts->mldsa_data = &mldsa_verify_perf_data[mldsa_idx];
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index efd56a25fb..2536476617 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -366,10 +366,11 @@ The following are the application command-line options:
 
 * ``--mldsa-sign-iter <1/5/10>``
 
-        Set ML-DSA sign iteration count for mldsa_44 sign operation.
+        Set ML-DSA sign iteration count for mldsa sign operation.
         Default is ``1``.
         Only applicable when:
-        ``--optype mldsa_44`` and ``--asym-op sign``.
+        ``--optype mldsa_44``, ``--optype mldsa_65``, ``--optype mldsa_87``
+        and ``--asym-op sign``.
 
 * ``--rsa-priv-keytype <exp/qt>``
 
-- 
2.43.0

