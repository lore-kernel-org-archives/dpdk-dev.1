Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64EAC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B6D402C3;
	Mon,  6 Jul 2026 11:25:44 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id B4A6E4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 11:25:43 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c85b73ffb52so1347693a12.3
 for <dev@dpdk.org>; Mon, 06 Jul 2026 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783329942; x=1783934742; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjzoX3NDeWEcFJ2K3vrM6fgx/nK6X9sta4jLOiiMCy4=;
 b=PwCWETJLGm0OhPqch+YhOgC0J8ui7b25vErSdcVAZsToLDiMkajSiIqXvt8mnk7lBT
 mOqmPzm/4ikk2m02l20f4LCj6LeaMfeJpp46juvfiTYD+42OH7o1uCIFyHjr/jvYjJBO
 MHk2mgvakMsSiwWvyj9qbQx9F5KEoIn/IxKP55OMC0ixo2vHtGk4yOu+NCzEuXJOpqYW
 eTJCm897DvMVToj4RJ3yzkc9VTqcjMds6yRHHDCZGcFuHfqHwC7WEw97Aio0tMFk4VFh
 /oEBmxcdXyFFPdmhcdJfIujO8MOGqb/Fdeot6is18Abw922ouGPpPImUYX9UStce1Zj3
 j3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783329942; x=1783934742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hjzoX3NDeWEcFJ2K3vrM6fgx/nK6X9sta4jLOiiMCy4=;
 b=oYN9tyLhoAQrDujaTPB1zoTsDGUVoQr8+i7rRnOJuFl1beXr+bNRUTevA2EGCUwV6T
 jSVncGdrZof6tGZFkq5/gZpbuUtGaeUa+jT9ixrAS9baYU/SNOhSJH6HSr/FtugYBwAZ
 BpbrREZ55bkQaPPqgJgddgYI0RRTXaJAwaEGV0eDLH8njuUa+EjMWAdvwzKifBsuQkUM
 NfyNEPlvwG1OPtSeUjHHQ4Mw28VPnO7V826gO3O/zsXeFRqdN6qvdbfAq1SIJtj5HLo8
 HnPkMcqkapeSqVUafa8Kd6kyJczTMMbYBUuoHV2ZIrN701kVvbL6jy0clBbscEyqoJWO
 V89A==
X-Gm-Message-State: AOJu0Yx0cZW4Ih07GxL1+iPfAra/qyt1Oj8x1Z9FjYfH+n32n8xSl7mo
 J1C9XyiXHtji6RE1YH8a5kPKeTPIs8CHk0NRywvavPJBE3xWavhd8N2g
X-Gm-Gg: AfdE7ckC820ix/4nW/xMiCbxtXOmG3NdDIumuNMSG9D6we5lrgZJ5ZdyWFDcVtprqDx
 eikdVsOb9BJe2sqg0KYer/j+3wsivz2ns0Gl5Jhe1jhEeP8s/oNykV+0BD0xcDJTlzWMRX1mWYL
 MbQmO0N3B8DxxEf8Vm+ledp3u1v3EugWBC2XIqW6GJeBgeB40jQhIiw8FqZOJXZpe+p5DKXFxMa
 53SLJCjAC8/MsYzhQrODy8+Z4PdJpx8oO5XAypAB3Y52Jeu9SneMh6v0EPBMkfQ61y01VClOTJ4
 F9Lv2WgmJ0eKpk+KNMxdMfARz5qHUBDenbnw6adN+6AqmtZ7/cMKkpieb5rz++nyJLClR4sRuTA
 g8A7ZJnToxZcrI9KiFvPgp15AbUnJdywIxaYoHjdXtXbGrkJw52YU9faaT39GzC2zXYO53Wx6JM
 K3DkZe+I+C2OTgbI7H
X-Received: by 2002:a05:6a21:69a:b0:3b2:924c:566e with SMTP id
 adf61e73a8af0-3c03e3ed5d5mr9154405637.36.1783329942472; 
 Mon, 06 Jul 2026 02:25:42 -0700 (PDT)
Received: from gentoo ([49.204.145.109]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c870effsm66791011c88.12.2026.07.06.02.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 02:25:41 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: add 4x folding loop for aarch64 NEON implementation
Date: Mon,  6 Jul 2026 14:54:14 +0530
Message-ID: <20260706092537.1252921-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703073118.788f4324@phoenix.local>
References: <20260703073118.788f4324@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a 64-byte loop that maintains 4 fold registers and processes
64 bytes at a time. The 4x fold registers is then reduced to 16 byte
single fold, similar to x86 SSE implementation. This technique is
described in the paper by Intel:
"Fast CRC Computation for Generic Polynomials Using PCLMULQDQ Instruction"

This results in roughly 2x performance improvement due to better ILP
for large input sizes like 1024 observed on Cortex-X925.

Also removed the special handling of len 16 to 31 similar to x86 SSE
implementation.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
v2 changes removes special handling for len 16-31 similar to x86
SSE implementation.

 lib/net/net_crc_neon.c | 103 +++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/lib/net/net_crc_neon.c b/lib/net/net_crc_neon.c
index cee75ddd31..d924aed25d 100644
--- a/lib/net/net_crc_neon.c
+++ b/lib/net/net_crc_neon.c
@@ -16,6 +16,7 @@
 /** PMULL CRC computation context structure */
 struct crc_pmull_ctx {
 	uint64x2_t rk1_rk2;
+	uint64x2_t rk3_rk4;
 	uint64x2_t rk5_rk6;
 	uint64x2_t rk7_rk8;
 };
@@ -136,54 +137,69 @@ crc32_eth_calc_pmull(
 	temp = vreinterpretq_u64_u32(vsetq_lane_u32(crc, vmovq_n_u32(0), 0));

 	/**
-	 * Folding all data into single 16 byte data block
-	 * Assumes: fold holds first 16 bytes of data
+	 * Folding all data into 4 parallel 16 byte data block
+	 * Later folds 4 parallel blocks into single fold block
 	 */
-	if (unlikely(data_len < 32)) {
-		if (unlikely(data_len == 16)) {
-			/* 16 bytes */
-			fold = vld1q_u64((const uint64_t *)data);
-			fold = veorq_u64(fold, temp);
-			goto reduction_128_64;
-		}
+	if (likely(data_len >= 64)) {
+		uint64x2_t fold1, fold2, fold3, fold4;
+		uint64x2_t temp1, temp2, temp3, temp4;
+		fold1 = vld1q_u64((const uint64_t *)(data +  0));
+		fold2 = vld1q_u64((const uint64_t *)(data + 16));
+		fold3 = vld1q_u64((const uint64_t *)(data + 32));
+		fold4 = vld1q_u64((const uint64_t *)(data + 48));
+		fold1 = veorq_u64(fold1, temp);
+		k = params->rk1_rk2;

-		if (unlikely(data_len < 16)) {
-			/* 0 to 15 bytes */
-			alignas(16) uint8_t buffer[16];
-
-			memset(buffer, 0, sizeof(buffer));
-			memcpy(buffer, data, data_len);
-
-			fold = vld1q_u64((uint64_t *)buffer);
-			fold = veorq_u64(fold, temp);
-			if (unlikely(data_len < 4)) {
-				fold = vshift_bytes_left(fold, 8 - data_len);
-				goto barret_reduction;
-			}
-			fold = vshift_bytes_left(fold, 16 - data_len);
-			goto reduction_128_64;
+		for (n = 64; (n + 64) <= data_len; n += 64) {
+			temp1 = vld1q_u64((const uint64_t *)&data[n +  0]);
+			temp2 = vld1q_u64((const uint64_t *)&data[n + 16]);
+			temp3 = vld1q_u64((const uint64_t *)&data[n + 32]);
+			temp4 = vld1q_u64((const uint64_t *)&data[n + 48]);
+			fold1 = crcr32_folding_round(temp1, k, fold1);
+			fold2 = crcr32_folding_round(temp2, k, fold2);
+			fold3 = crcr32_folding_round(temp3, k, fold3);
+			fold4 = crcr32_folding_round(temp4, k, fold4);
 		}
-		/* 17 to 31 bytes */
-		fold = vld1q_u64((const uint64_t *)data);
+		k = params->rk3_rk4;
+		fold1 = crcr32_folding_round(fold2, k, fold1);
+		fold1 = crcr32_folding_round(fold3, k, fold1);
+		fold = crcr32_folding_round(fold4, k, fold1);
+		goto single_fold_loop;
+	}
+
+	if (unlikely(data_len < 16)) {
+		/* 0 to 15 bytes */
+		alignas(16) uint8_t buffer[16];
+
+		memset(buffer, 0, sizeof(buffer));
+		memcpy(buffer, data, data_len);
+
+		fold = vld1q_u64((uint64_t *)buffer);
 		fold = veorq_u64(fold, temp);
-		n = 16;
-		k = params->rk1_rk2;
-		goto partial_bytes;
+		if (unlikely(data_len < 4)) {
+			fold = vshift_bytes_left(fold, 8 - data_len);
+			goto barret_reduction;
+		}
+		fold = vshift_bytes_left(fold, 16 - data_len);
+		goto reduction_128_64;
 	}

-	/** At least 32 bytes in the buffer */
+	/** At least 16 bytes in the buffer */
 	/** Apply CRC initial value */
 	fold = vld1q_u64((const uint64_t *)data);
 	fold = veorq_u64(fold, temp);

-	/** Main folding loop - the last 16 bytes is processed separately */
-	k = params->rk1_rk2;
-	for (n = 16; (n + 16) <= data_len; n += 16) {
+	/** Single folding loop - the last 16 bytes is processed separately */
+	k = params->rk3_rk4;
+	n = 16;
+
+single_fold_loop:
+	for (; (n + 16) <= data_len; n += 16) {
 		temp = vld1q_u64((const uint64_t *)&data[n]);
 		fold = crcr32_folding_round(temp, k, fold);
 	}

-partial_bytes:
+	/** Partial bytes - process last <16 bytes */
 	if (likely(n < data_len)) {
 		uint64x2_t last16, a, b, mask;
 		uint32_t rem = data_len & 15;
@@ -194,15 +210,8 @@ crc32_eth_calc_pmull(
 		mask = vshift_bytes_left(vdupq_n_u64(-1), 16 - rem);
 		b = vorrq_u64(b, vandq_u64(mask, last16));

-		/* k = rk1 & rk2 */
-		temp = vreinterpretq_u64_p128(vmull_p64(
-				vgetq_lane_p64(vreinterpretq_p64_u64(a), 1),
-				vgetq_lane_p64(vreinterpretq_p64_u64(k), 0)));
-		fold = vreinterpretq_u64_p128(vmull_p64(
-				vgetq_lane_p64(vreinterpretq_p64_u64(a), 0),
-				vgetq_lane_p64(vreinterpretq_p64_u64(k), 1)));
-		fold = veorq_u64(fold, temp);
-		fold = veorq_u64(fold, b);
+		/* k = rk3 & rk4 */
+		fold = crcr32_folding_round(b, k, a);
 	}

 	/** Reduction 128 -> 32 Assumes: fold holds 128bit folded data */
@@ -221,22 +230,26 @@ void
 rte_net_crc_neon_init(void)
 {
 	/* Initialize CRC16 data */
-	uint64_t ccitt_k1_k2[2] = {0x189aeLLU, 0x8e10LLU};
+	uint64_t ccitt_k1_k2[2] = {0x14ff2LLU, 0x19a3cLLU};
+	uint64_t ccitt_k3_k4[2] = {0x189aeLLU, 0x8e10LLU};
 	uint64_t ccitt_k5_k6[2] = {0x189aeLLU, 0x114aaLLU};
 	uint64_t ccitt_k7_k8[2] = {0x11c581910LLU, 0x10811LLU};

 	/* Initialize CRC32 data */
-	uint64_t eth_k1_k2[2] = {0xccaa009eLLU, 0x1751997d0LLU};
+	uint64_t eth_k1_k2[2] = {0x1c6e41596LLU, 0x154442bd4LLU};
+	uint64_t eth_k3_k4[2] = {0xccaa009eLLU, 0x1751997d0LLU};
 	uint64_t eth_k5_k6[2] = {0xccaa009eLLU, 0x163cd6124LLU};
 	uint64_t eth_k7_k8[2] = {0x1f7011640LLU, 0x1db710641LLU};

 	/** Save the params in context structure */
 	crc16_ccitt_pmull.rk1_rk2 = vld1q_u64(ccitt_k1_k2);
+	crc16_ccitt_pmull.rk3_rk4 = vld1q_u64(ccitt_k3_k4);
 	crc16_ccitt_pmull.rk5_rk6 = vld1q_u64(ccitt_k5_k6);
 	crc16_ccitt_pmull.rk7_rk8 = vld1q_u64(ccitt_k7_k8);

 	/** Save the params in context structure */
 	crc32_eth_pmull.rk1_rk2 = vld1q_u64(eth_k1_k2);
+	crc32_eth_pmull.rk3_rk4 = vld1q_u64(eth_k3_k4);
 	crc32_eth_pmull.rk5_rk6 = vld1q_u64(eth_k5_k6);
 	crc32_eth_pmull.rk7_rk8 = vld1q_u64(eth_k7_k8);
 }
--
2.54.0

