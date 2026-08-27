Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E3C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43CFF4027D;
	Thu, 27 Aug 2026 23:43:04 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id BE2104027D
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:43:03 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d049069377so4508775ad.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866983;
 x=1788471783; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Po0DN3G0H/j8p0pmtvYiNKnzm0591nFIe3ONJZzlo0=;
 b=f7u4ajle2VxveFb8fSM+pqvLdGcYO9kaP9cSLmHKkQPggFWsCnWsyYFNtGBbfHqNBq
 zMMfm0m+unqXNXkfs1fQ6OhXtzqz9/MxnXaoR3xOJd0n8xm54gOTuJxCHr0ktoX2cYLs
 RqTZHanrLPoDFvaQP71orq1bWZIQ9ghTqrA9SaabUqkOJWjnw6CjY7XGkIEQXAEy3Iug
 p0bnwW5ZeIyb9nu/2k0x5ZDsQ5AY3iIBtO9IPQDTNqSoHe6G4yQcQ18BbljTEiv8yhkJ
 PrZcmYHlJ9e2eQo+bZRPhVCLNmuKH8sajrwGM6MS+AkvwaE6K4GrezdwWkF2Bp7EAtcA
 nTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866983; x=1788471783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Po0DN3G0H/j8p0pmtvYiNKnzm0591nFIe3ONJZzlo0=;
 b=IWErMKefQGcisHn+u9oakejQuC4uu6tAGXA5roNu19AxjQZuaQkkVrus1HkkvC4lW6
 ZAhuqnzsvB10uwTzKAOw7TZYb/Pbq9DwHIc4ZUMCywXpKax9O4OjR/fMmdvXOKfOQPiP
 A15EN6lNqCS86KQzS2SYi8JJbbY829bc5G+ArI+Wk2MfsxzN5GODYfOF274uO/7MNPxc
 dug2pfxkft3eRjFYoB/maietPtimazGzyP+tfqCkic3DbdNvbBBPMm12VALnEOWB/YT6
 UUj1r8jgykUxnwgGTjZvArX9A2d1qgD3O4nEaZDCYQx6Ryzdxj7Gp6ZgLzBObdu2Y861
 I9jA==
X-Gm-Message-State: AFuF++kxAtfJK8GmbIn9jRAnF7+/CJ0D+83v0bV/ZgRvtxzir46Hjw7l
 DUeMuOlAYHvdM5NR4bjVR7XcinpymcBTcjKPy7UjNnKOE9EjTfA7DeaUghg/1d2WWGhdRA4NIh+
 aBqxo
X-Gm-Gg: AR+sD13UJVBOCLJau7eAhMruWItHP2oSkJ7zN5jLY3WJoWOgeRwktmRwHe7jygqs5NY
 MBABzNscL7c0V01j0PrxGlOiDzXQYrDBvaKu3wBXry/wkiIn4Mfh2sR5Goy6aBcTRa9fRkEoX6e
 idXAF4RIwdevFeTPCFpQ2Q17+n/hH9SUqMtIgSNvoJM1cPYPUN05CQXiSV0g4InnmN8ZdmpICkV
 HKr/RtcUQSN4R6roURSkR2bSCNb4RnWK8hF0YxdwPzkYeGlwEVPX2bKaI2HwW3srfLmlfOzg4+F
 XdC9C28VHjjNye69Jy9fY98USoqvk3qC4R2iXlKIn7aN/5IgtHigj1cGRhFgoNJPyDssOqrJ35x
 F35QJ8t9pv+0L+j1P1s5qToNJxCa3+KUwtqalaQ0gtPZT2C1QSoB9nl5+dqADxNk5Y+9Dog3ywx
 f417AXHVuGxosh1y6AunzLToGkXkh3FhYS6lQo7797YM8BduX2My74mRP1Z4S5WicTltFaXbA4N
 EBDl22bWJkho9PcLD1WTn9F9yw=
X-Received: by 2002:a17:902:d58a:b0:2d2:da8e:9017 with SMTP id
 d9443c01a7336-2d74dc797cemr38408295ad.8.1787866982940; 
 Thu, 27 Aug 2026 14:43:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:43:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v8 04/10] bpf/arm64: mask shift count per RFC 9669
Date: Thu, 27 Aug 2026 14:41:43 -0700
Message-ID: <20260827214236.1415047-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827214236.1415047-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260827214236.1415047-1-stephen@networkplumber.org>
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

The ARM JIT was not masking the shift count as required by RFC 9669
(0x3f for 64-bit, 0x1f for 32-bit), so large immediate shift counts
overflowed the UBFM/SBFM encoding and failed the JIT. Mask the
immediate in emit_lsl/emit_lsr/emit_asr.

Fixes: 9f4469d9e83a ("bpf/arm: add logical operations")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index ba7ae4d680..7582370062 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -545,12 +545,14 @@ emit_bitfield(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t rn,
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
 		  check_immr_imms(is64, immr, imms));
 }
+
 static void
 emit_lsl(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 {
 	const unsigned int width = is64 ? 64 : 32;
 	uint8_t imms, immr;
 
+	imm &= width - 1;
 	immr = (width - imm) & (width - 1);
 	imms = width - 1 - imm;
 
@@ -560,13 +562,19 @@ emit_lsl(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 static void
 emit_lsr(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 {
-	emit_bitfield(ctx, is64, rd, rd, imm, is64 ? 63 : 31, A64_UBFM);
+	const unsigned int width = is64 ? 64 : 32;
+
+	imm &= width - 1;
+	emit_bitfield(ctx, is64, rd, rd, imm, width - 1, A64_UBFM);
 }
 
 static void
 emit_asr(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
 {
-	emit_bitfield(ctx, is64, rd, rd, imm, is64 ? 63 : 31, A64_SBFM);
+	const unsigned int width = is64 ? 64 : 32;
+
+	imm &= width - 1;
+	emit_bitfield(ctx, is64, rd, rd, imm, width - 1, A64_SBFM);
 }
 
 #define A64_AND 0
-- 
2.53.0

