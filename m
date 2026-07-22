Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C0C4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE92A40609;
	Wed, 22 Jul 2026 20:33:57 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id AEA364014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:33:55 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so11242043a91.1
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745235;
 x=1785350035; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5h0mDzXrRZcbbwBxDTX5uc6w3dLxgQ+BFFRtFERvrIw=;
 b=pInRFgqbcAM74rLoMAKtSx3kL5KXHJ5yGuQslTg8I3wmyVcsOIAxNC64Hu0EWwl8V2
 ZCkG6B+k0kHcz37G89u9Y0AagC1jmXXQSqBhQc/aUS5+FCKraINEOgC8TGJ3ZUMPjpNE
 0ATnnmwIcLFRuJhunM4Mq58fP9dkNnA097eYca8tDv1DqQ5xdQ42c2UUX5zjstK4YpFY
 MgtJUC3jq0UsZ3ONaSwFmgh1kzNrrDE2t0i1yzZvVwnWEdhPWDnSTuSdFcQreG8gvAvF
 N2b2n9o6jAP/d2EB1BMJC/DaWqkm6WFCrbxXQFbvtxZ9ZbhCwzpsd30JsaTHd2YYlcFP
 D8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745235; x=1785350035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5h0mDzXrRZcbbwBxDTX5uc6w3dLxgQ+BFFRtFERvrIw=;
 b=L8EM/wWw8TTXwd47OqgDxcEAX27kHGxQKY5eRitAQneyQ1mjq1sL3C/luiwWbZpgBn
 XcAXSMMQmhL+SB7JeEaN8ZBjm7HpbcLBv88gJqqKY8rgawXabyNgF7PWGSUacKolyJzf
 V2XTuxIklElaIzk6rB6uYtGiuR7UWqWELhJ5YCcxwBAE375Vw/GV77vIz1A77DLS1Yoc
 fU2a6nJyV+2Pe/IdABIxsHUsafVwlPmWXisyw77z+7kn8PXu+eEJLgNrl8zswX9anXgI
 Q86/kel+HvQWjg/crjNWgMuzwIXtiHFpF9AFiL57oP4asmE/kDAW8fniozrWyDuN964S
 QODA==
X-Gm-Message-State: AOJu0Yw4jaj2sglsQ74yzloFC4Haq3Rvw6n54yf9k44ZIfJHoZHAgTG/
 wBoxMkUXKFd9+0Jys0dIKPkd6+k4WhFhySOpErie8JJxPpV5SPViFjP104V9sEhxICBm9mu8KoC
 e0GI1
X-Gm-Gg: AR+sD11k6q9slJtpULZV/wrr+WGBTbkKVEf6vpHbDqXHED16uHh9dw8w3ciJnz5q2cV
 wt+opLcZkQotfBGmkLw4E6VotbhewgQXpvizkQ7pHrHcPGyuU4K6K9fMB9aMcZBcng7jkppc33/
 g7uxsa9rBRvO+A2A5yiV7BG5lGh23xex4g6fV/LdrOj/5WoVVmKFGcRknATpaSM17X3RFv3S1HB
 e07S6fyG0cxeLmUL/1FgGXZ+Vkvt+MhyLM96rQ5GeR2sRpfF3JbwUT+lU4nkzbjmJjm01/+grms
 4bobo/wFhK/pNGTxbyW/SIWJbu0csI7bgzq/frx0c4EoCHn4sRDYXUBe/0KAPLG2csOhpX9pjNe
 uINr6y5j8nY++4aVlIaTWOM9bByMDPe4Lq7PQlyP1uGS0lTGwg1ajMeeUll41lZKmRUO5fLykU9
 eEETZyCGf2+zxONWRHw7wldpfRSiW+BCStir/e2qgw
X-Received: by 2002:a05:6a21:114c:b0:3c3:9ed1:2549 with SMTP id
 adf61e73a8af0-3c3ad95f80fmr25713983637.41.1784745234862; 
 Wed, 22 Jul 2026 11:33:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:33:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 01/10] bpf/x86: fix JIT encoding of fixed-width immediates
Date: Wed, 22 Jul 2026 09:05:13 -0700
Message-ID: <20260722183351.633025-2-stephen@networkplumber.org>
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

