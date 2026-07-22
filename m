Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD47C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 775FC4067C;
	Wed, 22 Jul 2026 20:34:02 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id DBF0040663
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:33:58 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso8574084a12.3
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745238;
 x=1785350038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Po0DN3G0H/j8p0pmtvYiNKnzm0591nFIe3ONJZzlo0=;
 b=I9gN8WcyyT5T+C/vUCZTdA106BERRmO30+E8WGCrVH1zFFfrvIDXYxnY9XaY5Yzm4o
 oNdv5cIXouHo0VZFetkyUwCa52xPRM+AypWhIaucGMP9bAVEvc/DpJOyKZSUy0Z/mdQF
 gcSAPwlq5D+/j2YDoqayRVD7TypxJiHoBtYmsNRgwAMstHnIYE9ZYlyPlDP8Gxz2sRXl
 0YCcjruEuLIdpAccj9yp2Rj6qFJ7/6F/NJQvBGTxSoPIacCbPQHMwd5gR7B5OkqrG30W
 rIwJm8TFgIJEY/N2PJssFDzP5BNr16QIfxo6/Tlk/v+fvFkpyG0P5WAdBfOXOBbxIvgK
 ETfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745238; x=1785350038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Po0DN3G0H/j8p0pmtvYiNKnzm0591nFIe3ONJZzlo0=;
 b=daPmY3XJmqil0elYs/LHOBqjuQaxkjZ3co7k4gNc/hPs6ZUzkPJEBjkqo3un73Y44R
 GO+wyh+KTy3HNqPF/jFOb6alN3G07ZPTzuXNJqcpB6fG7FtQKujn7mrphDu+09LFMSIr
 IPUzEG5eXLa1dTqX4bMI47W3P/Bl8WuXtxEeajBQQ5PYci7PHLOnbB6B1/jaV0eoRWip
 DK8bsVoaKXbk3AE2ZR1jKjRasaXoICYdS9lI/OBLYbww1OILu37GdqFwzU92RI0BMDJk
 QyIVoeJbFObr7KTAgzf8LBAcJN3Zfuyp9xmIHjdyE5HcCuU5sUeVWe0Z6iYqp35j1P8G
 XHNQ==
X-Gm-Message-State: AOJu0Yz6zWT/uLmWifD6/tikxR26UtL+jcDIeMP/aOH6ajK/HPGLVD4i
 xGV2wsYGGAT8hioBEsJslJBrjebq7sLbQZLu6YbjBmbB7FoSy2YjvLl/hiHkzBuFO6Op9QBibe5
 9laEq
X-Gm-Gg: AR+sD11H7e+SX4J1+ukDHuVb6Laqp3BbZuxRxIAnYGJAG4qqjlMjmhylUugwXYWZ+Mu
 LFHowFgjr+BEB25XB5IqOrgCLraD6867/HIVZ8ime1YfdupIRnvm+dtgKUfBQ1SeKDmUof313Sz
 99TE+d/dmM3if1M5fs9omRj4KfdNEznR0gH4d+pPa3fqInR5AsZa0i3+VefpjFUkGuHQ6MemW7c
 z4Gk6DbgM7KdbRxm1nTYBpmmdWJ+Obf4aU1Z79w5XaEOeKcXT9aLqEWcKyoJVTobB1x8uJbXXcW
 Clzya3glSIpiRL4fwMWXOLSn6AWqtNPk6abDgB/C/86dmOQX1wepWWWuMiF1Wb+ENpwlCEeR5HJ
 CGBT3gA/aNfiwJOVpeAkh/6dkpKpCRwOFoAtQ7Kx8Wv1KyS+La/X1JxPr9Xr2/vYVyM3wM+fgqG
 27dJWNNBD8H4xgXNABvSSx8cNZXUtzHSUrMSUoiJUz
X-Received: by 2002:a05:6a20:9397:b0:3c3:8bab:804 with SMTP id
 adf61e73a8af0-3c3ad8ecd77mr26546622637.49.1784745238007; 
 Wed, 22 Jul 2026 11:33:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:33:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v7 04/10] bpf/arm64: mask shift count per RFC 9669
Date: Wed, 22 Jul 2026 09:05:16 -0700
Message-ID: <20260722183351.633025-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722183351.633025-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
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

