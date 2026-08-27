Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B4C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:42:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCFB24042C;
	Thu, 27 Aug 2026 23:42:50 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5B14B40280
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:42:49 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso2659715ad.2
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866968;
 x=1788471768; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5h0mDzXrRZcbbwBxDTX5uc6w3dLxgQ+BFFRtFERvrIw=;
 b=H8kN5GDeGD69Qs5nT5/hYkeAWquLA5sP4wermgYhcQ8bWZYHoQCVG362TuRGG0AAt0
 r6YQcDi95us3DhHO/TUwa4hArADZzP625CCUatmJPacAH5m/33jGOdRlP6x5WbgTZ9t/
 p3jVKZp5dPWIbD4ck3K+yWTTYKbQD0QNdWY/y4VurOlxRghU45HKBlLMvaQ4QyGdTEVh
 cpB+nfT8XTPsZkBnqua83gy/tuMM1iohYKyZ+/z5Ux/kP3w+YtNItgZNTazYP1d5QULg
 vWCz5+d4uzZRMR6TvADx80xAIvUKmD6/ZU8V9FjL2av46obdhMAbvnGXdmhWCvXhK4ZN
 OUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866968; x=1788471768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5h0mDzXrRZcbbwBxDTX5uc6w3dLxgQ+BFFRtFERvrIw=;
 b=LNhlpnGEThz8k7Z+e10mnNjE1UZ4W75P9zLdNIaAnxRsFkDTwOuuPl57nGcTtGgAS3
 ZyIIUPlB4cTTDB/PYkrjROl+9wB1hbGKm6eZdyerH+UGoXT5yGccMopLnW3pkSJt3E6g
 uOZXgrde9Ge11JkhVu0/PYpetcC3rpvKz28mr2eK+f5BTmZaNqpNWTAH3MZ0fnkmLs68
 /+Ss47Z6MTaqRUUGS+FR0aqX6kl7OCX90bJsTA6LNSyzGAdv7AxYRYBB5xrKInDn5HB6
 ncsmHKy5RGh4LySlOrUZ/HjwdL3rtXIL2wCdyKOWfMeR6p7DV704Ij5K70ie6ymzRB+P
 nFEA==
X-Gm-Message-State: AFuF++nbDxebbZ1BFQLe/OL0c5EpvVUdHuKhc7GvPSKCSFp0IlPRBLE/
 na8ls27SlKIoLmzXypPPvKalfjl/Z4i9WIvjqP4WGLMvmoNw14Zjejf9t4QrGqE5VMZ2XshISor
 oiqiG
X-Gm-Gg: AR+sD103EKCQ72lX3xjQwEDXZ7jLIYkgpr9fedRROipb0pETNA3Xgk8PfVSsw+9VgkX
 0wDpY+cQhAeoQslWVaALdFS+7kdU6Q8m/V7DvHm4gOUDimW1C+IvzawhmF+YKwwQ4wH0DkWVpYZ
 P9m4qAV9WEYBtiuIDvPEPjy3IV2EkaqzSwzLsDDOm9eapBnGMhqad0rOcQ6ASNbYJp6pGspiVB3
 0RC62HrCbhFpUWKB8fC+314w7bT0dcub02apuDpiJ1ZFGqDlE0FnICUAHNnWybbw0c5kdYe0cZI
 qgeXljNBPBCL4k1BKTTAwu5Kqt12FNaQaDMWPAtUsrAoFbEl3/imxbXgaMMFgPJn8HmJqyjGGdv
 cjOiTA5MzjP6QmboxF8XinDM/cP06/hZgWwU1p3XfucnAa4wMQK13WFTW0Q0OAHYHH8lRqGtIby
 jO+cy0ogzftUg48IyEP7fWe+zkSLcjKDG5FgeofUxTxqvkhAE8ekwfd4f8RVdM4O2Tom0oPxPiF
 bUd148J40ohUsMLMWKPZkQz+MGtvFI5lJ4koQ==
X-Received: by 2002:a17:90b:39a7:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-396d0fd46d9mr3361219a91.9.1787866968319; 
 Thu, 27 Aug 2026 14:42:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:42:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 01/10] bpf/x86: fix JIT encoding of fixed-width immediates
Date: Thu, 27 Aug 2026 14:41:40 -0700
Message-ID: <20260827214236.1415047-2-stephen@networkplumber.org>
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

Several places in the x86 JIT size an immediate with imm_size(), which
returns 1 or 4 bytes depending on the value. That is wrong for opcodes
whose immediate width is fixed by the encoding, and it breaks in both
directions.

TEST (0xF7 /0, used for BPF_JSET) has no imm8 form; the immediate is
always 32 bits. For a small mask such as BPF_JSET | BPF_K #0x1,
imm_size() returns 1, so the JIT emits a 1-byte immediate. The CPU
still consumes 4, swallowing 3 bytes of the following Jcc. The
instruction stream desyncs and the program crashes.

ROR and the shifts (0xC1 group) have the opposite problem: their
immediate is always imm8. For a count >= 128, imm_size() returns 4 and
the JIT emits 3 stray bytes, again desyncing the stream.

Size each immediate by its encoding: 32 bits for TEST, 8 bits for ROR
and the shifts.

Bugzilla ID: 1959
Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_jit_x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 54eb279643..912d3f69bc 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -300,7 +300,7 @@ emit_ror_imm(struct bpf_jit_state *st, uint32_t dreg, uint32_t imm)
 	emit_rex(st, BPF_ALU, 0, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
 	emit_modregrm(st, MOD_DIRECT, mods, dreg);
-	emit_imm(st, imm, imm_size(imm));
+	emit_imm(st, imm, sizeof(uint8_t));
 }
 
 /*
@@ -441,7 +441,7 @@ emit_shift_imm(struct bpf_jit_state *st, uint32_t op, uint32_t dreg,
 	uint32_t imm)
 {
 	emit_shift(st, op, dreg);
-	emit_imm(st, imm, imm_size(imm));
+	emit_imm(st, imm, sizeof(uint8_t));
 }
 
 /*
@@ -921,7 +921,7 @@ emit_tst_imm(struct bpf_jit_state *st, uint32_t op, uint32_t dreg, uint32_t imm)
 	emit_rex(st, op, 0, dreg);
 	emit_bytes(st, &ops, sizeof(ops));
 	emit_modregrm(st, MOD_DIRECT, mods, dreg);
-	emit_imm(st, imm, imm_size(imm));
+	emit_imm(st, imm, sizeof(int32_t));
 }
 
 static void
-- 
2.53.0

