Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EECCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:25:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30E1F402F0;
	Wed, 24 Jun 2026 01:25:36 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0AACE4065B
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:31 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-13809223fd4so471798c88.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257130;
 x=1782861930; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4TFPXuIcAq+K8UjaPMwJCwoN99kYXQSkJ/PrA8jo0Y=;
 b=zu9cD7artqjRfnbrQMtppQ0ZP95a4dfRUGH9MG4ahWMyiq2Bzw3B+7qX4gnmq+byD7
 z7aiLhwcuQVLnIOHh0IRO5gKLXNem5Fyni523cYPmwLRhcPvZyZtHRI6kR0Q31yvv0Cg
 Jm8qTBscd5eb5/+b+trJKoSuox9m0MS7oB8q5a38FzkuCpKPN7dazZD75cfi3cz6V7lD
 MWdQEj4SIUiZFaSTnTbuGAP2viv6DGyVma1vUnKa6em84H6NgKyRmyXSY1pL0dQFM9rj
 rPdSN0tG2vrlGFkwDy3gB06R0AoyXlWdLEoiiqLRWXGwc1E6r6Cf4yTQBsVyw87z7aja
 dEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257130; x=1782861930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O4TFPXuIcAq+K8UjaPMwJCwoN99kYXQSkJ/PrA8jo0Y=;
 b=ix5dqsRIf6d0XQUcL9a/G500kcgvULXrvGdLIUzFceMlyvIgk8eTDH1gcMl7EYCQo2
 mI//CmYOyQq3zMqup57ch0ajiarw+0jpthP3TpvdoxR7aSebfD7A7X3lQNIW3XusUDT/
 uWFbtj/M/iYsDSDC+PYKYjWGt9evFMp+v2Z98My5daiGhzbGxQMGAmf0rSrA5Bg+ggQG
 NnHjAwBJV2kUr1s6LMIlrMzOl5tOA6RDXEwQHt9edWThL+8O8rM3ZizZ0Z4X0hhgRvKl
 LRrgwQtnC9j1nsrVSyu8A0wgq8vaFBqib/xoosn5Ei94LSyDbjHxIPts+2n+ito6Jsga
 3WEA==
X-Gm-Message-State: AOJu0YxnXFB1A3GFgkT52M7MGWMqKTdfvW7/DicJlYofQdxzwPxUNSe8
 CEtcMSwMsJrvggpsEstiaF55kpRQjr++obO5G+6gOEt5AgVZTL5Hz0xC62MiuWlHQThDwwYTVNZ
 zDmoT
X-Gm-Gg: AfdE7ck4TtxeV7iYYBxyOr1Dq1sTwR/jyEMp9lrN9A5FYLJPQCRDPHcLxxENuHWLEhJ
 F75qO2Fln6ve5dLZ1t/V0KIahJdM/PhbncAQ/T5HhPHLHJpTiRKyItiimxzQG2JwzBzHVf1xXBy
 /zXUzlBWCZbmYg8XuvuA7XxYzjPzbYlgrbZWybPVCIf45/5F6JDzoH0H6RakmlCSUijJ1CTlN+h
 s6EudytQyvEaHr5q0RK+/BB4Bz7WRGP4qZge91JX6qs3mMzwJpzPDVzEhPrwl/fXSAX80RBPkxC
 RvfekRJcMDkbV+pOYvAjLY+ufIqYMi85dWVqlIQKtfhAuNie0SZukCL3gnEZ60RtMixSm4NGwJF
 UVJBY8TjWSjYk7KGDzLlJWKWM0gB107GRYG0hXUJ+PwlT1hB9OHUuLxLY6gBGqRqAaTZc7W1yjr
 B7HnbhqLQ6iwWtUYj/PlRMY7sWQCsx8t19jzrWZc0Y1A643RTHo7Q=
X-Received: by 2002:a05:7300:7313:b0:30c:544f:a861 with SMTP id
 5a478bee46e88-30c69345fe4mr1199225eec.20.1782257130084; 
 Tue, 23 Jun 2026 16:25:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 4/7] bpf/arm64: fix offset type to allow a negative jump
Date: Tue, 23 Jun 2026 16:23:15 -0700
Message-ID: <20260623232522.257208-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623232522.257208-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260623232522.257208-1-stephen@networkplumber.org>
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

From: Christophe Fontaine <cfontain@redhat.com>

The DPDK BPF JIT standalone test test_ld_mbuf1 fails on arm64.
It does:
	r6 = r1                    // mbuf
	r0 = *(u8 *)pkt[0]         // BPF_ABS
	if ((r0 & 0xf0) == 0x40)
		goto parse
	r0 = 0
	exit                       // epilogue E0
parse:
	r0 = *(u8 *)pkt[r0 + 3]    // BPF_IND
	...
	exit

emit_return_zero_if_src_zero() returns 0 by branching to a function
epilogue. The target maybe a previous epilogue so branch
might be backwards; therefore the offset needs to be negative.

The offset was stored in a uint16_t, so a negative value wrapped to a
large positive number; emit_b() then branched past the end of the
program and faulted at run time.

Fixes: 111e2a747a4f ("bpf/arm: add basic arithmetic operations")
Cc: stable@dpdk.org

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_arm64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index ba7ae4d680..776d7c8e97 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -957,10 +957,12 @@ static void
 emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t src)
 {
 	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
-	uint16_t jump_to_epilogue;
+	int32_t jump_to_epilogue;
 
 	emit_cbnz(ctx, is64, src, 3);
 	emit_mov_imm(ctx, is64, r0, 0);
+
+	/* maybe backwards branch to earlier epilogue */
 	jump_to_epilogue = (ctx->program_start + ctx->program_sz) - ctx->idx;
 	emit_b(ctx, jump_to_epilogue);
 }
-- 
2.53.0

