Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE24CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:33:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 851FC4066F;
	Thu, 25 Jun 2026 19:32:48 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id DF32A40651
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:38 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so264684c88.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408758;
 x=1783013558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqUW6b6oDzlk+wrWl9gvZAxNcRXAgplfikiX4S0Lszo=;
 b=j/IeipTRGDmj/OtJ+0RWsnsC0NDbnC4+8HZcjFu6aJ4po0X+001FYLsSl33KV44Esv
 XpZeZwFzqnK9JIJErPZvzQn+UBg1WxqgADHJyFLCdhB+yCXTKscfsV7mO491y73gSkPS
 Eq8rSs8xTprFNoCv4AiVQzmNJ0my45T8B+WyMe2QLhS9SEI+kR8zuIJfzKKfKwiJYUnJ
 NdA9vYTLmX7Uvm8sc3/U9yKLNXEsaT1lFAST1pKJHu4kpr8lALvOkqHMJSOgQRdvr1dP
 +rWPinLWxHqRHqv7xs68irOdBBvrYpeSMk7CxVg2NeiLJSyKAzA7rvk+QRq6cyCzxLB1
 6nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408758; x=1783013558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VqUW6b6oDzlk+wrWl9gvZAxNcRXAgplfikiX4S0Lszo=;
 b=dd5vXb3SLNYlc3Y7t6aEKrFQwOpBe22P/H2HdKD5LBbqB+KALxRnDdk7yZQxZamA3J
 HOw4IoSRjTLZ3b3WwXmsvS57D2iT3sClqTDC2E+wKXB28cIVh6CusPctaMZ48ejPJaxx
 UsBrO/MNmanIAFYAbr8eQ3QPFSX/nrEtG0lzeutjM9vq4oKCbx/trQ9u1asU82Hl/v+r
 63ByGJj6ECWppGbjNf3pA8/adUS0v2nx6gmRdPaqcSYHn57728zNChxtfYHMq6ja+J9A
 U9yb0fVKKoOkjpzFbgZGwbfQaTliPZxaH3dkKGOFuA4XafqwT/8c6D0Nk8Yp8I70AbBk
 dx4Q==
X-Gm-Message-State: AOJu0Yx2Zv8fRjRCxxKvf0cmOXJYayaUlh8qnOmyrdwhJ6l6IJZvD7kp
 r3hxs0FLv1nk/RagpCishGZeYLQ6r+71LWNb/6oIo/fxFXJSI4BLuvXCvwyBrjEw9R2ox3DDuhG
 UnYit
X-Gm-Gg: AfdE7ckYUBy+21n7kDwyT+IOkYCgVLslOa+e89IIfTZh4j5PIaW2WlKJPv8EVdXzkrf
 QKGWEUIJD8PrL2t/7Hco53SpELCZ48iT779wHqo2xaKixO2bRod9mgoan3GKPsJibEyXf3F5K5I
 7RiftdpxFhvgnB+8IxQ7HZfPA+yi+SnNZOedEdjCQGabIUnaxTTZXjXqU6QEoMBqlf4ovfSX/7I
 Aho5LqEgsq0WOmn1WbsRfd3H+3pDaGSnmfa+D3Y4YYInulO0FJ5ONNwwgK1xN9Ulbp/rs1G77xv
 1U4uJVHkuNv6OxyCOMLzkmgWi0mPrTX73tJNhcS/hAfYlIWP0RWS7tROx8K8QKls48qDPU5IJg6
 C78PODi3tF/Z/koC6AqVqft89wgf7cLARmviM5/Zg97igzhZ8TX1zLub5jT1UyV7sNOLIdLDxAE
 6pzKeMhLQT9O75AQOB8nSqD+Xs2+YWBykmSXxfalvx86gXFmu4fsw=
X-Received: by 2002:a05:7022:ebc5:b0:137:feeb:3fc9 with SMTP id
 a92af1059eb24-139dbb5b2d9mr3698309c88.18.1782408757881; 
 Thu, 25 Jun 2026 10:32:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v6 4/9] bpf/arm64: mask shift count per RFC 9669
Date: Thu, 25 Jun 2026 10:30:14 -0700
Message-ID: <20260625173231.216074-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625173231.216074-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
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

