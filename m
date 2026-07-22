Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BCC4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DDC840A73;
	Wed, 22 Jul 2026 20:34:04 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9820740695
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:34:01 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so9376904a12.2
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745241;
 x=1785350041; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5jhZcu7R0c2Niw5UfBt3KpuoD+2pTKZJZWUFn2woelQ=;
 b=t1mGC80pcBJzfbtJL5LZnLAJCyMp8VxV6ha4Nwamh9/aHS7wi/61/UD5awxDxIuyvw
 CfbGX4e4eu0qtmYA6AXX5vEYo6ZiwKA6Ay45TbhP9LFz4668becHU9xE9pnIajEbs6gj
 4lAbhBaJ78toIggWxFjPrKydRwajTMJyDoj8q11DCRdCxLTH7X+nGlEMvwMDrMHM6yM5
 hRaayXPTRv3Ds8WekdMch6fktvgmRHocWD2Ihkk2zIgI+GCd+6RjpQp+T1xfhhzBHG90
 z8FgKmwl37c/I/4PHJcTf4eLZW+ggbcls8YZVxqkEhlM7Ut3SkqmceJljH939y8mIEa6
 ZXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745241; x=1785350041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jhZcu7R0c2Niw5UfBt3KpuoD+2pTKZJZWUFn2woelQ=;
 b=e4hiBR4LCLZLafml0MPbqu3e9WWE6UokX87IjarBKYc5X/vy/ey5N1C1LgnE6ZfQFa
 IaN7w9NxCXmXbELyLNpZrABoEQLaNi21YIZ10a/jf/+kiZZV6oUr4ZR/wLh/yUfmEveJ
 XgY0s4wrGREmYtY8Bd9nEM94Q5bfz5ToLHWy6OUopNG396r5yf2f1Dcki6CgA+lrJbsw
 oWSFj4vxPgWUWHqS+r2XLMsdq+Rb9Ksm6Cy6OKjN2sjWdS6DM0orWc5hhfQwwhiZv+K+
 uv9k40lQ74Obp8y0JYb3iFrCPAisHBJFq58/f/4VYc7iFTa/I5bnyhl05vpWzAEO0qcJ
 3F8A==
X-Gm-Message-State: AOJu0YxkohOq8sSYaf8e9NgkvY+a4xjWOvpkuLMCe92S+WuZP16Po5Jk
 YstJrhWY3Q7ZF704P7wyKZvPzXEdtfugDIh4C7LWQkz1aTEltkKSH8gTkw0S7pSqhxmJ2k57Q7L
 /28xg
X-Gm-Gg: AR+sD13NpgCukoM8/NyTnJhfOB+KuGl3rn/sAalWlOlgwqNmBwuo5h0NBGri0iLYb6D
 O2ruqd7jS1TiJQEhoT4upGCoT063HN4FyBFdW5rmSwFW64yHA6fnZanToYwCmSfACo6p0YBsAjU
 MfOlyBNZXBlUbSSkhckOOMfclaiZxAd7wETCMwMFhvl1ZuP139fgV00lloVaTyWQA87EHgdsqIF
 Ed3QiOycv5iHt/07dOQxJZidE+1PSdrdhaVyDS6SovjEqAgcdDCIxaOKKfHhRlCCHVbi6Cstcih
 cf7hIoZcZ+31lwxw0u9GH1I7pVuTWNKly8OAWJiC6ZVTV7PgjDBsuV/O0spdyJuKCA4SIqyaD8x
 XD05kthkyIdlNc7EIRE+Yh/nP7hQy+lDGBidtJBryQBKtGmjKiAZa9kIfyekbV+VlKlb07QzKXO
 VOfPVlDJNEZSNVSSmdYkowyDN1/e71O3RhSeRM+yby
X-Received: by 2002:a05:6a21:391:b0:3c3:8129:a492 with SMTP id
 adf61e73a8af0-3c3ad8ecc9bmr27148504637.38.1784745240705; 
 Wed, 22 Jul 2026 11:34:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:34:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v7 06/10] bpf/arm64: fix offset type to allow a negative jump
Date: Wed, 22 Jul 2026 09:05:18 -0700
Message-ID: <20260722183351.633025-7-stephen@networkplumber.org>
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
epilogue. The target may be a previous epilogue so branch
might be backwards; therefore the offset needs to be negative.

The offset was stored in a uint16_t, so a negative value wrapped to a
large positive number; emit_b() then branched past the end of the
program and faulted at run time.

Fixes: 111e2a747a4f ("bpf/arm: add basic arithmetic operations")
Cc: stable@dpdk.org

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 7582370062..51906c7f0d 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -965,10 +965,12 @@ static void
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

