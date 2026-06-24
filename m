Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966C2CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEB4F40611;
	Wed, 24 Jun 2026 19:58:22 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 4FF06402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:21 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30c6874d295so91369eec.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323900;
 x=1782928700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVZXj4Da8zuZORYUV6JCjRQs299jvrO74WvVjL+F1U4=;
 b=Hxp8QJ8qE5rBQ2ymAWsxIZjIG00VfW6UVwTYhx0evCAFoxydikZzLpl/BD1mlhSO5a
 1mt3N4RGMAkO734mFrwBDMiQ6ZKzBGmPn5k88NxnJayCMEIpJpIYtdFZx4Phqlu+9fXN
 00wJ6C7MG+mllnAaOy4lgdjRbkjdYQrS5+Ih21ROeze3ofp8dbTqkeiKo0eIQSF8ExnD
 9v8IssBOwBWJSuOUJFoAOvULy0dnf1wOhz5Jwbz6h6HuhswUfg8AaxoubwRwsCEXcLhJ
 +s7ecDWKWDaS4Z6dnqLImRJCilk8GRIVBwq22qVBwhcTZsYFnjvuwk/JQLtx2pG82h5x
 xKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323900; x=1782928700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OVZXj4Da8zuZORYUV6JCjRQs299jvrO74WvVjL+F1U4=;
 b=gxLIbHMGDojlrpabQuV4okMFgXhveEXSPy3sfEPIOQm8SYMODUjP/XVc24AJOfdLNr
 +YnGRSAgleFh5MmnVqMc1E60DbMVTdfEoHFh21QJyqHdJyBz1OvOfsNSkx34oiR1XZcv
 jBRO1cGC6BnnaVSA2JEy1y763TIesRtcRy8PjZrjPXSSz/7G58cAnaZzqOqgskuVANa5
 orGOa6uo0BUhExtTIFfnQwZaG1eUGFbUM4Yg3Va4D2PQRtZK6pjXGwWy7l1xqvr7cDwC
 jHV9V4f94IFDuvecR/UX586n9lgwOaEHbcxALILeUl10VfVZOE5y1zKaWAPEySlnQ8/G
 uAnw==
X-Gm-Message-State: AOJu0YzLEmSkldbtfaK7tTbFryg2Ud6uW23KT15rzgYsKOkiuxbLJUuh
 WHCGsKrIROi3MydHRu8Cqp77Xer0SBpjzeNooR+L3HtQcS+nAzo0m/SrK/aqQG0+trJh8KTuywO
 gbOtt
X-Gm-Gg: AfdE7ck9l1pPbAt4GXci0UagAepjSEe4aArtlq97kQ4JTS3WxkQoM8pYkLEP5ojwf3t
 kDsLiBTU16Xikbpuq3o60wMtQHs5O3NVK2lVzlyDuRSsGPZNcOdzqC9FFv6/jO+i9bxCkYr8yC4
 DXQT4XBNNKnS7/ICbiUDV1vvvEgEW/Xyx5C3IlWMDRpfBNLRdIQH12TMsS8eywEKya87Vz+z67M
 Q0ZC45n8x62QdLqOL7zfzNedV73VXJIyaJm5uBNG7dyN3nN/275ra9g2r86T3ICpy/Cblf5mkWn
 nPxcK2pJOVAGvuRhGuN/ar0OJ7lo9H2Ft900DQTyoJM9YsY95Vv2IWK/ttT9WJxXcANZ3eHkbFw
 gc+pIeGdjjfdF582rZMPwj82cIrYChvzqSKPu9pA89+SoP/bfSCGsHwQF0sQKs+r5uFpmDQXcCw
 EIQvvhVU+Xqijz7v004VTneiX9kNofotO1wx7bFOAfrNiuwZ9EGyc=
X-Received: by 2002:a05:7300:d407:b0:304:e587:50b8 with SMTP id
 5a478bee46e88-30c55641f4dmr4921803eec.18.1782323900232; 
 Wed, 24 Jun 2026 10:58:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 1/9] bpf/x86: fix JIT encoding of fixed-width immediates
Date: Wed, 24 Jun 2026 10:55:00 -0700
Message-ID: <20260624175815.673064-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624175815.673064-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
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

