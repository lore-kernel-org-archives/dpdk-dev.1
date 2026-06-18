Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384ECD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49F1D40678;
	Thu, 18 Jun 2026 23:00:40 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id CD5AD4066D
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:36 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30b6dad2382so2729000eec.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816436;
 x=1782421236; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+2ghHD60zgbMYRSZ6C9jtUI7a9ClanIEDG1dt/Udk4=;
 b=JHhWkhDWPOQMyx36kCKhSwoOxgWB3pDh2AwTtaqyxnCweFR0WYagcISePb7VGLvs8P
 Vji6rr36buGLxAB+pvLMFBxEBps+x30UyO55YqvN30DS0HcxHcs+RlMzMOWzEdwpzTOV
 ftVea+05M17SrwrEmUxwqTPyXHMSxyrg+HgInhC3w7o8gFAfen2XupHoWbrY1nh6R1Ol
 hbapULnA1F7/jYTD0zA+dK85b1pz7akEqHH91lvmBLDH5FgQepPDOCgvi95d043bgEco
 X0X9xhNWy+YLbVr9EfuLASm34yMFawEApLdmWxPu3/FhYGo1qgAAc/P1lRGT4+C6a7HL
 d7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816436; x=1782421236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t+2ghHD60zgbMYRSZ6C9jtUI7a9ClanIEDG1dt/Udk4=;
 b=aQxM6aiUsL+o6PmdpU+TnMj9gKKwZOv8/k5Ih1VK8OyADASkKA8OJ6tQVRPDNSkmdI
 wsf85f2f3C79C+7gmg2kw/Zl1U6eKDi1u4+RVJWZVPPbMh4gRHlFEBcET+rxXRLFRC94
 7rGGl9drSbr9HmiIA8OVj27Au0yD+gExvK0+OLNyhjr/DwECFU4Wb1T0QdAZ0CBaSPXf
 KQvFKLxHCLj8S6sxMj2BfTCFXTEB5wLLE//1xbf4LJ0VdF4VIyRZVMmNDfNI0+L9ZLrV
 3g128A/HAXggaKeGhuISXAYR3yVjSRUw3nIbkJUPUraWhZzs1iPYiSu+n/y3h/fMY+a8
 8EfA==
X-Gm-Message-State: AOJu0YzL+c5qiQB/sSa2rSt5OyuwucDx3OJJ9OKa33WU7/b0gLq8nUvz
 g6DCraAozZ/7BeuTKeYvhsf1xG+ka0P5SE/y/RyLieLccTObJT1FH4Uugxb5mXAfbH9giXAqhe+
 RG2f1
X-Gm-Gg: AfdE7ckiC4mXRVtU3KpHdGIU1Kpciorjf59nMthRQgveRN8gF/XwHj1Ry/R7ICSGEoU
 +J7SuONkbQ+bJMj25eI7aB8pVu1I9ndSxC8m3Anjh53/9C1RIJ4Gx+22N7tXuQUyWm/PQQR6yuR
 hiDDvbuI1o0KIlZNo/kTp3437Fjy0q1o4kJyQDl+0XKC9TAbr5Uw7jL9Iy8Fnv1AKymGj78DsUY
 spvB8p3ioimk3mEXc5MEVThAX4wMCT/1+qKwLGNClqeybXp2LkEqVI6cFCdvVTBE4GDpk2o6u4Q
 X0uogNnXUbxk+oHgLkW8yBp4hy1jTH2/ZWd2iW7Bk6mPmmbf6tMvRCs1fgbPt5lwZXFhj4g0Cxv
 1gNdgJtUhjEq4BC8rC4XC1BqlMAKfE9v2jhK66XxZmtkmT9QuLi1cPTR1Iqi8O0fcgcW9Wg05Hy
 b2pm/H6hO4ks7gWyGntHo8hCL6480I0+PciaXtNSKKdyIsyA1H21M=
X-Received: by 2002:a05:7301:10cc:b0:304:7a67:6104 with SMTP id
 5a478bee46e88-30c07086a40mr708281eec.7.1781816435509; 
 Thu, 18 Jun 2026 14:00:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 3/6] bpf/arm64: fix offset type to allow a negative jump
Date: Thu, 18 Jun 2026 13:47:07 -0700
Message-ID: <20260618210026.430288-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618210026.430288-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
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
index a04ef33a9c..67e42015de 100644
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

