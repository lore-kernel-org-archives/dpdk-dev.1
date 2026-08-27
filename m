Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F5DC61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F5BE40695;
	Thu, 27 Aug 2026 23:43:13 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id CE88D40150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:43:11 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d5335cf904so3092595ad.2
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866991;
 x=1788471791; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5jhZcu7R0c2Niw5UfBt3KpuoD+2pTKZJZWUFn2woelQ=;
 b=Fc5GSA/6jFTHvE6BPGpWIbXiWr1qd8h/xUdvHLXQU23Rdx30Nt9LrzKyzoNo7471aF
 yiNW4+J6abTsBrFKotIjEtw8XyUT5MLzotpNZgb1J4JxtqB6LJlpO1Hkx2WIWfJO/IMX
 riuFyFR1SBW3MfblcThcAfCiahArnXs7c5VIH1K0oDQc4miuTsWK2Ku3YmB/IX5KimKO
 h6g1D0TGRFhw3hY0KlnQXYYlDIu5Y6riOGm0VjN/mbp506jTvw8w4yWLg//ZLVuoV1G0
 GjxgAGt9Z+Lh8NqS9h1QcyG4A+eRsNEt16o+nIb3q/lMIU7ZOCFD0eCBUEloUAeqpe1i
 Z/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866991; x=1788471791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jhZcu7R0c2Niw5UfBt3KpuoD+2pTKZJZWUFn2woelQ=;
 b=JZbv/7VFdMIcuPoag2NReNOBxTQTn/dH4bInG0yWdll80FPoi32KjQvS8dCikl0s9v
 jpJpCrlo3ouV+B8N1rbxNzMdl/qfQAN8AWJsdDei0Ok5rq5+Dg0hxe8BAk8np7dWKNrU
 g4y1LFuOeXdoLmXEMCK01gQPZiNpL/gbZDq1lXPTZA+FFIrcDNjUQkFFz/8Szijs0FLg
 /qHiXPih/YcmAsRapDz7mKlgZQaecqRLn8g7ntkrMGrfb7Fn8wigQ3uYs7mTWjNeR32d
 +JfBEopD/goqwGT5BkFM2S10LriVZb2Mdr80cwvM6+FPzkKtT2EFt0IsWH397vPoKniy
 PaNA==
X-Gm-Message-State: AFuF++nOT5YDVAe0lpiE42YI3eu5+UVoaMWjkCa3ZesL1tlSrawAWIMq
 e9iy2gYQzugAVLqmdc6zQ+aTw2RxHqaqQsl+GC1XS77rMhp117V+AWA2yPVDHZNf+v6smKXuytN
 nlQO5
X-Gm-Gg: AR+sD11bikC0ndHrPmbxBEImrrl7Ul/RdM9+f4B8yOM4ANMxBbKivxqNorqZvS1Mbpu
 Lw0uPBswVdeLfbUsh6gZ5rufXdb7+Y3yGAnVcWY/CR0BAXwh0BZyp+1d6AQO7TNfyWipDY89N5h
 M2ms87k4KzCFGETF5wzs2YABYUVXKAVDPFBHL4ui+M5Tjeax4JjKP91jwPV1UUF6D1TkD1wzT6y
 S/OkwgEFd9qPGF3z2A1eSewapOoIgMco0yFAJC0tH4aH3a4fqPICPRKf5rCUyq1gUIGeFO6MvWo
 9FuUcLjKghzzhVbiGfPNSaIK2DqiSMZBPVV08I7hnU7fz4eIrlIsFwyiOmyDWbzD1/C+EHC88jF
 wM3td3g6gtpRtFRZn19JIpug4db9gp/LtEIa92i160IOdSE9nO4V3RGf/GD5PhlC3Olem/msH9F
 6TrROEWgWdjPLFecDvOcMqHTMgKlml7GzfJoV+ZrE1Yv6RUfCMkDPf3icFsT/kO+tiuiZVpQtBe
 7aTVwaKLvkZHa0HFAG2NL3up/OM
X-Received: by 2002:a17:902:f549:b0:2d5:e9d5:8ae with SMTP id
 d9443c01a7336-2d74dc5e8c2mr29435285ad.5.1787866990959; 
 Thu, 27 Aug 2026 14:43:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:43:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v8 06/10] bpf/arm64: fix offset type to allow a negative jump
Date: Thu, 27 Aug 2026 14:41:45 -0700
Message-ID: <20260827214236.1415047-7-stephen@networkplumber.org>
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

