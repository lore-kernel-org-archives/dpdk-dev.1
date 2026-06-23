Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB73CDB479
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F90640663;
	Wed, 24 Jun 2026 01:25:33 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id A0D6A40293
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:27 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso580514eec.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257127;
 x=1782861927; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVZXj4Da8zuZORYUV6JCjRQs299jvrO74WvVjL+F1U4=;
 b=aLg1R2xCg++3t46VOr3AJ6w3XkDWOTnpetzOx18pLNki/J39wtvzQujtaTSzt5ivyV
 /FEvLjyD7jb6Ilcrb331t4MPXYODfWKVQTzRDBY7yZXZds55oopRzrsIGx9/XmuWXz+B
 2EhbJY7rGuMCVAVGEtRQRw325tYv5zYmNnWUDPIwsB40mP0MjRp1lWbXvoM1s9ZzU+Db
 3t3/4ZMpd+lyHRtpLuiU/nTZKz+WuqktpKl/fomFfIKrIIpZsO5vsbQcs4m6YbljAqzp
 aFcAsXyFkUbUpTJPJPJZN1EC3YQnpnZm5tHfDQjRa98G/x1G1M28yODfps5hEiBbRq8c
 +yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257127; x=1782861927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OVZXj4Da8zuZORYUV6JCjRQs299jvrO74WvVjL+F1U4=;
 b=dhNZqUY7mJwaJuu6xENhLnc7K7zxFHhNiFjgz16+hlrc9M+G8hs8esoUzcsLg4uh1r
 0il9pJXlP9AmftRwtpR/pRdk4mMxIh5iA/fDgE6Ut9IiHb5qf+m7Xb+qgagCv/NWtFnX
 kGzQZiWzK/jsaCQcD/l7OgX22ETyzyEhxRl86lhi5J/479MZXvn8M63HekrAQIhBmsz0
 NHz0Wcd/v8ftk/JnNAGduhHznc43kq7WWbOAq33BN0q28E24ZHsB9maQO/TXQJEfNbOI
 OMAgv0kEwkaMJUqOh7k9edO1KnEkEoYHjGJuZCyGLhDMZ3o3b4EyDmcNJ+fqZ06N2HYs
 gwsg==
X-Gm-Message-State: AOJu0YxQcLtZgZ4PjQStlM8DV/3anfAoO6VS9P4Z21/Oofa3h9dpEVZP
 nyNd1c/fNihBTc/flv5ekJUGnLtH+hljcK1HpoUNGpikOWfxVwCAOYCngihYdYeUk/sArfdXYZG
 bqvUw
X-Gm-Gg: AfdE7cl4QzwllYgHc8R4/TnWlMvq5gxRJr/03HWonMQj5w0D8XoZEQVvV6OOuYKCdFX
 yVOSKrcXXUuMXn6KnO2mEvRCxdSYQEyhr8wBPBKC1+VLelDCkjjaKEr+QIeYE3n+Imtd8BVPcEd
 hsX6XofKTuSVU/AK0tciLfxtZPwr2sJv4QMEGA/BNPa3IKB8NlRxZBniEm9GmYkqLv8ujbsZNVv
 A8G2wmC0UDbHNveWbTxiAXcp0+/pDrQVkRpzmIAllsUIWO3AGZUlhUX+w1MSLLKBlgCKVaCoyad
 DWO8ZKb4fsCMvxLCHbjRYzPr4Mwldj+4DdjdeZXaBwErY+h38bnMGsD3/Jwt8aeTKknN96eNuQS
 byW+iC3YY7hrhtQiCa6QEZbQED/CjQNr5BJdtGWblOI23P0g8HmTlXjwPhWb7JHq6XXOeN26yqt
 I7z+deiZ7B3JgUrapoUrRgHFWtUSI7bpxU7GwF45KItg8/LDgLvqje0jZtTUxpsQ==
X-Received: by 2002:a05:7300:3256:b0:304:2cc9:2ba8 with SMTP id
 5a478bee46e88-30c68e47e84mr1365146eec.30.1782257126472; 
 Tue, 23 Jun 2026 16:25:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 1/7] bpf/x86: fix JIT encoding of fixed-width immediates
Date: Tue, 23 Jun 2026 16:23:12 -0700
Message-ID: <20260623232522.257208-2-stephen@networkplumber.org>
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

