Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C09CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9F0F40298;
	Tue, 16 Jun 2026 11:12:05 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 1D2D840289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:12:04 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so3571747a91.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781601123; x=1782205923; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qP9nWOPLnpUAisYWyJSAyEsTmC5xdQgwarURmqLlVYY=;
 b=fjIDf021gLvBmMRAjFmvuOwuGXUD/CepJW4HwZM8CNmWFyB5QgAdzDBwAGcVkT/CIw
 RVfPSgfrEdgMPE3xZsjPFxa002drV9J6b+B8KlSkUZFn++vPUmG2XAtNZ4bvYDlzpE1j
 RSNx+pJIO4CnYm/AL27hs2N1HIyKLiueZMsGcn5+U1VsJ/98wA4hSOatlzuEy+l+7HLn
 ID6GEi0CzkOhXT5H49JKKZpRuScNWGpb4cPg2Et/CCU9SghbEuU2E6VaK7KVL3rSHPMn
 tZPj6akBB4rTa8RpxeOTo3pP8vYhm8Wk2lLbJqlUKZQSKn8Vy9klBtEUT6C1PSWgtRON
 /fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601123; x=1782205923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qP9nWOPLnpUAisYWyJSAyEsTmC5xdQgwarURmqLlVYY=;
 b=Qyz91VDZdiQqOg29B6dY0dVQOtGiWI4IUuqk4Vvzakzltnfy/mlwYzqk/ZR36j5awg
 dHW2Cx6jmYxcf6xpTMgUX1Zm6ICNGVEdNadZeF8ry0r4bJ4VQ4YkXZXfGVkgPFpUVxsi
 EkWHEfQpNjCUQjdQ00tWJ9oT/5WgLnbSMF3W9Fb83oH1QQsXMpKzRxKwKbQvyeYO2Q41
 LXRG3Fkh84T7boYwlCkd+tnRwxXsxsp5RvpPGmpmhJwEOZxiMwIIzfH9wzXzqPi7grIA
 t+Veoa6o8GlIJEKUNfg5MzG//RuIPbyjBtdjc3g9xYoSFu/HMM8J3T8HNdGeOGfJ0S28
 lisw==
X-Gm-Message-State: AOJu0YzUgPgD6C16kMaIzgX6LRCBePPkZSSndXLfAJ7XrZk3yxizzb1g
 sN0T4QaeM+OikIxDWVMRPzEot7Pas/TM4bm6iqW2fEDM8RXPc831dJYO
X-Gm-Gg: Acq92OEBJp+0YLdrelAM2V9/z/bnoLOHdspr6ZqaJHnqfMCEbwKlIa/XgKcnPqmYBOz
 W0T9LSXph/9hqnqLJkjen6pJFrG+gdG3WJnUP1zEue5dN5qFa+EOEjv6AIufqtM1U8xNzYoSEF9
 C3lESqZE/JBQUExlKgosKKuqz52BUPYc+fRBBNzfpcGqlHp3F3kOB0CU0W2sRBlw7BbJKI4YRAt
 yzkmG5cmJkdDm5aCAhg0UFkVpHytEe0YD9D45ALiCN4ZCAXWZ8T9Je9tKlCJHD6Ww9bN67rrVCh
 gskInniVbhJX85knsHyPdI6B6tOyOaGz5cVq37Rs5J6fsyfr3AhVwGd8gsH+FJdTt4kIC8GgmN5
 wBtoRVbOQKk/iG4RZvLUKcG8+HQ0AmYO0tGmJrXwSucPLoFDQKso2yjCEhTDzjTqJ+GAJIbTDhP
 g/ntwXngI8anRtUa/lbYjjCE2YIjA=
X-Received: by 2002:a17:90b:5827:b0:369:de03:29c8 with SMTP id
 98e67ed59e1d1-37a03dc2867mr18734414a91.23.1781601122975; 
 Tue, 16 Jun 2026 02:12:02 -0700 (PDT)
Received: from gentoo ([49.204.144.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ca7a7sm2207433a91.7.2026.06.16.02.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:12:02 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: add 4x folding loop for aarch64 NEON implementation
Date: Tue, 16 Jun 2026 14:41:58 +0530
Message-ID: <20260616091158.731075-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_neon.c | 51 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/lib/net/net_crc_neon.c b/lib/net/net_crc_neon.c
index cee75ddd31..fc817e54f5 100644
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
@@ -136,9 +137,36 @@ crc32_eth_calc_pmull(
 	temp = vreinterpretq_u64_u32(vsetq_lane_u32(crc, vmovq_n_u32(0), 0));
 
 	/**
-	 * Folding all data into single 16 byte data block
-	 * Assumes: fold holds first 16 bytes of data
+	 * Folding all data into 4 parallel 16 byte data block
+	 * Later folds 4 parallel blocks into single fold block
 	 */
+	if (likely(data_len >= 64)) {
+		uint64x2_t fold1, fold2, fold3, fold4;
+		uint64x2_t temp1, temp2, temp3, temp4;
+		fold1 = vld1q_u64((const uint64_t *)(data +  0));
+		fold2 = vld1q_u64((const uint64_t *)(data + 16));
+		fold3 = vld1q_u64((const uint64_t *)(data + 32));
+		fold4 = vld1q_u64((const uint64_t *)(data + 48));
+		fold1 = veorq_u64(fold1, temp);
+		k = params->rk1_rk2;
+
+		for (n = 64; (n + 64) <= data_len; n += 64) {
+			temp1 = vld1q_u64((const uint64_t *)&data[n +  0]);
+			temp2 = vld1q_u64((const uint64_t *)&data[n + 16]);
+			temp3 = vld1q_u64((const uint64_t *)&data[n + 32]);
+			temp4 = vld1q_u64((const uint64_t *)&data[n + 48]);
+			fold1 = crcr32_folding_round(temp1, k, fold1);
+			fold2 = crcr32_folding_round(temp2, k, fold2);
+			fold3 = crcr32_folding_round(temp3, k, fold3);
+			fold4 = crcr32_folding_round(temp4, k, fold4);
+		}
+		k = params->rk3_rk4;
+		fold1 = crcr32_folding_round(fold2, k, fold1);
+		fold1 = crcr32_folding_round(fold3, k, fold1);
+		fold = crcr32_folding_round(fold4, k, fold1);
+		goto single_fold_loop;
+	}
+
 	if (unlikely(data_len < 32)) {
 		if (unlikely(data_len == 16)) {
 			/* 16 bytes */
@@ -176,9 +204,12 @@ crc32_eth_calc_pmull(
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
@@ -194,7 +225,7 @@ crc32_eth_calc_pmull(
 		mask = vshift_bytes_left(vdupq_n_u64(-1), 16 - rem);
 		b = vorrq_u64(b, vandq_u64(mask, last16));
 
-		/* k = rk1 & rk2 */
+		/* k = rk3 & rk4 */
 		temp = vreinterpretq_u64_p128(vmull_p64(
 				vgetq_lane_p64(vreinterpretq_p64_u64(a), 1),
 				vgetq_lane_p64(vreinterpretq_p64_u64(k), 0)));
@@ -221,22 +252,26 @@ void
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
2.53.0

