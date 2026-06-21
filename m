Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D0ACD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:25:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5E1440290;
	Sun, 21 Jun 2026 18:25:34 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 4B9804027F
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:25:30 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-13986d61b4fso4123592c88.0
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782059129;
 x=1782663929; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83A61IRl5fLx96XNfp9UDw3Z9Zq4F+NHNkcmc4G8aa4=;
 b=HGJGCT/7IKP3w6M0l707eM05ikr/EBFWwiRF9uHkHvOzPM2cVz9iIEw3pGb2oMifDg
 KS94tCFX7xbS/VlrEMcFcOgxEU9SFHrmWHxrMK8xqyL36Qz+qQh9jakMkI0PfGXLanuj
 U1gbmPfNvKIrabPRN4tSp8Dpo5ZKEKr+V70mVxYjJ/IO1pzo56k4hhdvVWGfyd6FsAL3
 4OA+kzaOArWtcpe9ZX5HLlRaqTGgLs+HtNOk4wvobkIbwtmiNgZ+M5Q/zlyc/++kP4iW
 agTCyooZuSA5MQ/VYmv+yU47vi/eSQ83Ff9rHrH9CPdYewbcXQwz/fhjQ9derH0murPO
 zq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782059129; x=1782663929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=83A61IRl5fLx96XNfp9UDw3Z9Zq4F+NHNkcmc4G8aa4=;
 b=ITswgd52W4cQ9cw38WCGO+FwrHW4yre9cDTnhcnvCH7fbhPzw+PKTPvS3n+pvUh/0g
 0kIwE8M4v/mGqM8oDPS4D2Eorr63sokLlIcvodiL1y6qBbE3OdeFos9VUSwycJz+nPop
 e/dtgBHsysKkTqBK4zzMVQyx5oMjKk7envpQJ4tckSO7diIKtSEA+d8VQSE4JAtCc5kJ
 TuvQ5waFCPO5XdMmszErhIeCCsPE7mLEfTuDUgicbcOT4boQb0ZlL4GTncq/tSpoMA3t
 g0aedBodByudSveIx1LuhP8XRWmLeiw78b8xAtG+Aq3NjAYT/yN7xcAoFqlcsEFy6IQs
 p5jg==
X-Gm-Message-State: AOJu0YwIeTFcpu8PwZOHeahd/pRezF0h4I0zjV/ZtYk7sd4pdFr0gcXy
 LFNTebNHafrXrFa3CuH7RYjUkZ+p6JDJfx57wK+bevJ/tYcazYFgJ5I6ErHUbIDh1J+45ddbg7J
 6xXzDa4E=
X-Gm-Gg: AfdE7ckqPY8rcUMFiQM2Qh4UfutHVNqmXVfB+H33ar49JCGgax5oZ/tit3eP4ld3pZo
 2/LwOka5dpw2itGpWAb18gwLLCSgSHFj8OpNwBVJolnKa2+q+D5kf6KaB8806SPMrx9H5kJs/3I
 GD+QnNk9iTMNgWOOgSklJwJp4joqlkD5/2q7PPvZjTRUWvqoTJOrQ1ZoIZIPcPIvpWupprtONl8
 sT8DnEO5kGl/09VnXNUUHysuj2JzFi5lH4+LkQP/qQJ+8/awRz5dw7v/+huRFKhTQ30LneFm5l9
 UpjJRdSZZtJrOBHiIp3ORkCuHfnlAzpcS+yiZ9osNPP0x+UjtMHxY30ZpRTlH1O93QMbFkLtjGe
 9s7IbyKkBpDtb/rmgZOreOweGN1M5wLnfjOa82coG4DsHNXAPCVMYuWf89qUEOtp64TdNRQOF7H
 bmHFsCZYLdTkuwvKr5s5S4OoBTPGwy1pC0sM19FbveTx6/b0qddvk=
X-Received: by 2002:a05:7022:6884:b0:138:3d7:e8b1 with SMTP id
 a92af1059eb24-139a2053689mr7419900c88.10.1782059129187; 
 Sun, 21 Jun 2026 09:25:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm5141593c88.13.2026.06.21.09.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:25:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 1/6] bpf/x86: fix JIT encoding of BPF_JSET with immediate
Date: Sun, 21 Jun 2026 09:23:54 -0700
Message-ID: <20260621162524.82690-2-stephen@networkplumber.org>
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

Several place in x86 JIT code, it assumes that for small immediate
values the instruction size is one byte; but it is not.

The immddiate form of the instruction takes a 32 bit value.
The broken version of emit_tst_imm() emits TEST (0xF7 /0)
but sized the immediate with imm_size(), which can return 1 byte.

A small mask like BPF_JSET | BPF_K #0x1 then produced a
4-byte instruction the CPU decodes as 7,
swallowing the following Jcc and crashing.

Always emit a 32-bit immediate for TEST, ROR and SHIFT.

Bugzilla ID: 1959
Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 88b1b5aeab..b14a574703 100644
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

