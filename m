Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0E6CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41E9B40616;
	Thu, 25 Jun 2026 19:32:37 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id C0FDA40299
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:35 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-13986d61b4eso256343c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408755;
 x=1783013555; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVZXj4Da8zuZORYUV6JCjRQs299jvrO74WvVjL+F1U4=;
 b=K/+qntwS84SBrRRCBGpz/0U9GMToFHJI3DvP2D3SmVZVpIiSHi90+NSQY1vidjtaYS
 xM2EalEu+YWdUpT2BjRN3qUHQ/nHZ75138yDRJ7y+BzqbuytuzSQp+txPw/afj2TWNRz
 twgE3jxintwMSX1K0uWEX40r/m37NMpDZFRREDAd/VLEpvKggMxsq221JsbLqs4c5nls
 s73ec4sxvuGzxxf8MUYwLcokWmk5SIqamEFyD2kaTFne5wFYOx9qMueLyxTYoNBS2KBG
 Ea7+VUw0LG4iHVUuipYlUPhl9qkMY22lB2VZaYNJiDEGEGu4T+BFc/7c8pSD6/YoVGN0
 jRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408755; x=1783013555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OVZXj4Da8zuZORYUV6JCjRQs299jvrO74WvVjL+F1U4=;
 b=c404Gz6VwLCO/h6HnDzm/Dp8W8gQlvQ2u8ViM/LjDlcuvJ9U3kh3joi7p1YyeRBqzX
 DC2dNcP+qU9prP540+bT0PLqmfng2mcDEj5XdSSUXUx5LpeEpZN7FGbG7rcIWMBldDTd
 QPp5uaPZ5Pps+SylFJe/ZPocPvvmuJTtZpQeH/8QpmrUeihC9PZauFUaw4z14OQ4R7Ig
 Q6IASZZ6FVjW3Ntd0sA9yK3+9mvkagTGrPFtloYtWNi/Cnw0/sQCex6XR5a/d40fVCDi
 0dKcJ+JWkiTFu0EwjQ+no5vB3SDhh0lr+lVbEyow0jYC0zFZoAVw74OISZQ8QiGZkLid
 Zo2w==
X-Gm-Message-State: AOJu0YxxOvJMnW6M3VpDbXgvaV2TSlj96BrNyeRaZboGc8bHW5vglgC6
 7o6Ilonq/iknDkym4r7VnrbyGMjZIa9WYZ/MBj8KOZJ0r+SRZic/kjTSfLk574Lz104rxCLTnCR
 482jZ
X-Gm-Gg: AfdE7cn4BAWMYVusTfc4dnBbI7oe1vbP1GcYzhZwIz0xSkX4iEVfQF1X/uOutHclmXJ
 yQZyqMU1irYAiZhIsQU7L6ppnUoY/AcQVDHyEU0KKQo0fWWeAMSSiVWGxfDZi/xySmvrvLnUk7+
 VCbm8RWzteebVdqTnodzKB9n1LdXTkXoNc0/FGCecjaPpxOjxhpbeHcUvhS/nnQRa5Nj7o62WQs
 wuv41KCs2pHujA6wImISHXsulumA+cew3Agpb2abanApJ3spQoFjydzWe2BhTxNeb2ne2daf0Dh
 q9Rs1zMbtaDfPO3qIhiWSkT8CCHXo8zGsJ5YlmxjPJD1nzfCJaYT0VEkfPsbqNBahmTyJjiFoBC
 lJRbFZJEQ39dizwDHhtJO2zFDEX1+gzlA+zfgnPVTD1/pEW4eJ330rUyC9c0ARQbkdXlXRGPg/4
 ZypO0ne6npez/JZqY2NQn3NVS6lFvwRncg6lfsjt9ZJsqqPHUgkyA=
X-Received: by 2002:a05:7022:61a1:b0:139:d923:f8f7 with SMTP id
 a92af1059eb24-139dbaae32bmr3037188c88.4.1782408754656; 
 Thu, 25 Jun 2026 10:32:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 1/9] bpf/x86: fix JIT encoding of fixed-width immediates
Date: Thu, 25 Jun 2026 10:30:11 -0700
Message-ID: <20260625173231.216074-2-stephen@networkplumber.org>
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

