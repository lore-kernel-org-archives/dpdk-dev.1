Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF52ECDB479
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:25:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD0B4066D;
	Wed, 24 Jun 2026 01:25:35 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id C453F40659
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:29 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-139a71baa35so1019677c88.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257129;
 x=1782861929; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wp8VxHI5hrXX2fOyu12yhi6H64QNR5BYgk4bdnr9dNM=;
 b=Ni0cwg0YCRCo5hqIJKuA9zuTpSjwAzukyWqeMIj/Y9kZ5prJKbPPg64vQd3UQI2JyB
 Zz0rQKnvnkFFdjiHxlIWc4gIS7lUH4YOsQhGdfZEIQvxNxi3tTMvPJdG8fxD2HCQ9ERA
 OUurhmjGEKmuZpd0MCbPvULRDQnzvgxYElHExcTlmY6nIv0giCQ+hkNL1HqkRQEyY6PG
 p2E3dTSJSPLluNsODFMImycc23dY314Zqm/6jZdWqdpydFcoLvAh8vuYdakYQdiRWQZW
 PG/okYWSAkqS3FxSuH/NzkMwhqDMBRhOKFuVfSEKfrEgLBIMTfhjBCiaCPR7zxv5eDsW
 COsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257129; x=1782861929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wp8VxHI5hrXX2fOyu12yhi6H64QNR5BYgk4bdnr9dNM=;
 b=HRtghduA+orxbr8zkqqu+wXfFkoyVA18OcWocFHkcOmiZ2B3W6pxqtcjO7EHQTPJ1N
 J/Xsbizf461XI+JKt83RWvDJInQr9DVaXzi5bpleJaVW0OkRjvwimnxu/AlPNr0jyWpm
 GP9m/9OuqR+p7HsQf3CGRihZZ4P36tZgmXk6pT5Ejhmf6S6u1F8yepxksa9ywdAWvUKy
 wPz+JNuJLVBpAIkCqHUfX/g8JLM4f8wZwzA+fSw22lmx35S6F26q13De7c0vdDWbPWx9
 yYpZFzkjwM0K8UJoyy2oEI4IY+TeVQYoINBKi2ruGAxEWVJW2lWioOUrL3Pt29nOeqGK
 ZqUA==
X-Gm-Message-State: AOJu0Yz+JeGMZIqBVQab4m1KeBSCgNKX+JkLwouZGJdwS12B+BmOindg
 fMcBVJZyCx3pEAfPR28hqjP1Os/PfkVmmj2MtY4/Xb1FwzV/i8K2r4GSptAS/jzvgRBvPG2oYNn
 e9GwY
X-Gm-Gg: AfdE7cmHAKMSox1GmrHsAfGox5wihM57KP9wrlxB46mxtRpfoF31cizwgMhUcqYnJwB
 3tq0ffWvK3mMI3Iq6gZ6JkxJE8jE+fmnGKE1CxdGdas14VJmMhyZVjm5w6iZxzHuthRAoetIx9C
 HksJ31SeeJRjnnc87WF89Rxxi645Nd7EIX/RBpwRddnsVxVaundP8+LY0ClEdnKde6aGOk/qDpg
 1qf2YEyYh+bpYyg52YGU+OVkF+tcLgfsfM9mM9zrS1aWeL62EXxK2pmZ909FyTq7FXz7VIyoOIf
 X07SxBnuJjU3gUVfm5D1m155hDhzaKEXrQcY2v7VoZV5/k2vpgXE8ucFfFdpePEbWxmaBCcc1RR
 JaQCU2akDtMq7LTIkI44ugxw7abu/jkc2bRo0dDYJ1/TkdaDtRWZ1CAFaXepwW86mZ/dTQqaoDg
 SI00qUIADqVoTeHEO4owkwYs6eobcZQQqbM7/io5dKDdq/1CdIZLNge2kL9n7/Jw==
X-Received: by 2002:a05:7022:faa:b0:138:4023:8b6 with SMTP id
 a92af1059eb24-139d0c1d8afmr792536c88.10.1782257128777; 
 Tue, 23 Jun 2026 16:25:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 3/7] test/bpf: add test for large shift
Date: Tue, 23 Jun 2026 16:23:14 -0700
Message-ID: <20260623232522.257208-4-stephen@networkplumber.org>
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

The JIT compiler had issues with immediate values on shift instructions
so add a new test to cover that case.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 232e9e2a98..b54e36910b 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -2005,6 +2005,58 @@ test_div1_check(uint64_t rc, const void *arg)
 	return cmp_res(__func__, 0, rc, dve.out, dvt->out, sizeof(dve.out));
 }
 
+/*
+ * Shift by an immediate that doesn't fit in a signed byte: the C1 shift
+ * group takes a fixed 1-byte immediate, but imm_size() returns 4 for
+ * counts >= 128, so the x86 JIT emits 3 stray bytes and desyncs the
+ * instruction stream. The shift results are discarded (a count >= 64 is
+ * UB in the interpreter); the test returns a known constant, which the
+ * corrupted stream fails to produce.
+ */
+static const struct ebpf_insn test_shift_big_imm_prog[] = {
+	{
+		.code = (BPF_ALU | EBPF_MOV | BPF_K),
+		.dst_reg = EBPF_REG_2,
+		.imm = 0x1,
+	},
+	{
+		.code = (EBPF_ALU64 | BPF_LSH | BPF_K),
+		.dst_reg = EBPF_REG_2,
+		.imm = 137,
+	},
+	{
+		.code = (EBPF_ALU64 | BPF_RSH | BPF_K),
+		.dst_reg = EBPF_REG_2,
+		.imm = 200,
+	},
+	{
+		.code = (EBPF_ALU64 | EBPF_ARSH | BPF_K),
+		.dst_reg = EBPF_REG_2,
+		.imm = 255,
+	},
+	/* known result; a desynced stream won't reproduce it */
+	{
+		.code = (BPF_ALU | EBPF_MOV | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 0x55,
+	},
+	{
+		.code = (BPF_JMP | EBPF_EXIT),
+	},
+};
+
+static void
+test_shift_big_imm_prepare(void *arg)
+{
+	memset(arg, 0, sizeof(struct dummy_offset));
+}
+
+static int
+test_shift_big_imm_check(uint64_t rc, const void *arg)
+{
+	return cmp_res(__func__, 0x55, rc, arg, arg, 0);
+}
+
 /* call test-cases */
 static const struct ebpf_insn test_call1_prog[] = {
 
@@ -3409,6 +3461,20 @@ static const struct bpf_test tests[] = {
 		.prepare = test_mul1_prepare,
 		.check_result = test_div1_check,
 	},
+	{
+		.name = "test_shift_big_imm",
+		.arg_sz = sizeof(struct dummy_offset),
+		.prm = {
+			.ins = test_shift_big_imm_prog,
+			.nb_ins = RTE_DIM(test_shift_big_imm_prog),
+			.prog_arg = {
+				.type = RTE_BPF_ARG_PTR,
+				.size = sizeof(struct dummy_offset),
+			},
+		},
+		.prepare = test_shift_big_imm_prepare,
+		.check_result = test_shift_big_imm_check,
+	},
 	{
 		.name = "test_call1",
 		.arg_sz = sizeof(struct dummy_offset),
-- 
2.53.0

