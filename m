Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB6DCD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8CD4402F1;
	Sun, 21 Jun 2026 18:25:36 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 7B78B402CA
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:25:32 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1384eb94d20so8673364c88.1
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782059131;
 x=1782663931; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+2ghHD60zgbMYRSZ6C9jtUI7a9ClanIEDG1dt/Udk4=;
 b=Y112ZXwvPZqQD3zqYda9Xr73BFeHiV18ttLiMaIwDfMl4abc9rpN/xKmgzDyRTAMUO
 taMI37beYBPIAPzzdAkNkiW3ug8zTddAZRE0HuG/r4ZChTA9+AfGg7DBpPRoRmwrqXPI
 cMuhuApOKeDgAzGyONCLdmKeXHjL5XoZ0PygLARd9lR4QhbHZvT/JUn6Bo6bpm6BOtf1
 00MYWbJ5vSzBu4WlBIRYUlmpViEGZVFA364iB7AYcBMArCkNnChbeyaT8j9Qd703g6+F
 Ts4NN2YkkaB71DRsLKV2Wo7rxGiMcyRXaSQZG1y4pJh3LLjG3rj0bnyYb37IccE5Z+9l
 2rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782059131; x=1782663931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t+2ghHD60zgbMYRSZ6C9jtUI7a9ClanIEDG1dt/Udk4=;
 b=KF3ujfMZYcuW4HSMj3LBOuGPlwCXh8lesCMRT2fr0bsPMz3TNv6zrfo8rZTF+MvC0+
 zsKU5lqm51QUua27KMaJU8pHyvP3vZKZr/owBoQmf+wbQfqkq0tUgLx0OU9gf3KW/nma
 XyQUoEphgS9XzAoJZ/vh4NTWy5UyXEETI1/H02cD0GKKQ18x08zmCfP1oQ0SW+ru5/MH
 qG4xV9BGOrppXO+7qEc0BxUZ8fguuyrXdvzDpmzSWNtXa/Vl5yAurDEC+wbMtHwUWyOh
 5Iru1bRS34N+sme1ySGbI4Ku2WBNqUuShGOmtnmSzt4YXiN+l8UrSYT/yUR7ai4wSrXh
 JmmQ==
X-Gm-Message-State: AOJu0YxBuYmTx0jL1VLmmGca2oHJRpop8bOGt/c/DNiCq9i/p77+okXJ
 +rwCx3TUMzYEMZfLtsqptPrfznyhwGGLwisDUoDvw+XrKpXayThxAeRpEyQt04rWUxLHRK+k9WR
 +jWsU6ow=
X-Gm-Gg: AfdE7cnQhRbNg4f0uXLtpjImUb9g7BSiPw5Ym3bzCzktWm/o5KvqxxR0R2VcrhG2CCr
 w2AX34aES0NYyMnjTHuDbhCyNtfyDYp1esorSw9XvFUEYpOu6i6lFQQD1rYHLDQxx4krMBj92dA
 90YpzE/l8n4mRwmyrl/yv2hqK3Q+F9UXVW2KACxVuFnqQK0hDzNqmXcFU72pF5gwhLwMSEGeaw9
 f9jdy7vxevLfkOmi+VpqYciqjuM31Xvq3jIJQK1uw7O9inCPKYNpxiIeCPjJZQbUT8epd1xoKhf
 ZbOgIe5f+TS0MrMdue/p7gKjb4Ve6jKHQ7aUc9Qr3ohHtgHJT1qSenfFOYSC3A2tIjkeDmF9WF1
 WaSvBG3iM+RPFZT99rvet009IyUa5aLWWtrY8y/+YlY4it/8FyfGyX9s6fzroRbJZLS8DM/xOij
 MNHTM3BMkXCTeIvhHk+GHCxJJiQQl2bCAP8N2I2p3SFBjAJrsPdnUlv/XqA3zo/A==
X-Received: by 2002:a05:7022:98f:b0:139:89ad:8deb with SMTP id
 a92af1059eb24-139a205efc7mr6446432c88.9.1782059131519; 
 Sun, 21 Jun 2026 09:25:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm5141593c88.13.2026.06.21.09.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:25:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 3/6] bpf/arm64: fix offset type to allow a negative jump
Date: Sun, 21 Jun 2026 09:23:56 -0700
Message-ID: <20260621162524.82690-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621162524.82690-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
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

