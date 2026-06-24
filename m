Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F05CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DB34042F;
	Wed, 24 Jun 2026 19:58:27 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 637BA402EE
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:22 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30c713f37c2so115096eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323901;
 x=1782928701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuo8WfWDTaZ8UjGSGfkg4+5VDcRGKlAj0SZ4VJ0wdnU=;
 b=z/p+/F48/1jrYXyaLR6DYNlMfTh4BbFveRXtRc5Jsr8hVe3PG0mSnc4TVyFekx16bR
 HJTc15hOoHVqdKo/Qb/DNHl9fdhwGnEivMIRqDGG0fVnU2Rqsx1smomvDFHmCvRIcO+M
 r8CSCnFC1Uf0vYpdn/2+8+Ktm/DEftKwYpcHFKUMcn1ic5JNcHDfjwyuyyLPRFaIklwL
 fVzvZpbC5RPVt0fBDKM+iON8NtbKWkaQPdQ1T6E5V2uiytUcErHLGW0nZmbPfYFhHlCx
 ArGe44l+7mFdvYZgJfS1xi6FFGdi4Pke7/xj94YLmJyqrb1uKZc9RZJmkJwE52YwmpaK
 ryTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323901; x=1782928701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuo8WfWDTaZ8UjGSGfkg4+5VDcRGKlAj0SZ4VJ0wdnU=;
 b=eazIuCqRWJWuwWMYLacFmoQ5IUW2RKWS+uvgEJ6rWu+Sy/YfbFAY2Q3P29e6Tjeghf
 5ivrIPXOa9E6A/DO6IXr/4d3z5QWK7KSRSltN2C6c17x+qfKnIfrwtswJhRBu7hXKi9R
 MGuExoqHS1xQ11QQ1OYhDNaE1scVVsxiJTSbOU1jnUzsoooCtt5HXVPm3abmjKqo7lov
 s3QiGNZF6Z/pf0b7VhxHVHXyrpq7wwXSkSPZrOqTY/tp8kBDn0RCmtZ77uEsWFKWuyQT
 zVeBNMl5qEGaRFjX7oKNQZmQf+LfBU2Lxb/RfNt6rRW5HMJPc3u0d5DG1gse0HzdXqVR
 CxXA==
X-Gm-Message-State: AOJu0Yz/UEx9UNXR5s+yIE9MNUvI7aWy5f4XIu/sr2EoBhdirmQCg8FP
 joQOfpJGljumUpaxVVd/2/Fjvwq1KqnB5P/UOgnm8Zlt73V7BJspZc5+mp1fdld4X8NJ//g7FxG
 OxO6W
X-Gm-Gg: AfdE7cmHmyV6u0rr4WwdY+gRPXPY3yv12SAQovF+hfrb77y15l8+4RHdrwdK1iS20e3
 kQk365GikR1KyYW05cuU6eZ4wOWwtMggnyS8S50w/xeHIlqdEig7OyN8gXo++qajZ0dEW6RE/9b
 IiMD47AnmS24iYM+NIldjPFW9el45+3YfMzAGWAFRKWSEoKewbq5CUTOSwl5n/RsZDjrXSsYcwc
 NCqBDSzN8jD2VB944j2rBuWReVerejNtYnYiYvM0NKdPPOt9l1aY+9FCAeQ3+je5WcCXS4US+s8
 yqmD3ePBuIFFaubNPN6VHm6n3ZFuxbi/kz4JjSYXfw2iyCoORxY2rEx33BL0K7QjANSWJKZ89ud
 w0M+Be3SCqz1vMlNApVnEz6hPJSul8oKpPiIOiNqYo1alEyjmXUKwIybx7oeJWVkr7Wn65t/ue2
 D9kvWHdz6I3VhI2Wk8B4WNss8PZzeKUT4Q5PUU8kZMmvVkSk+2Kzs=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id
 5a478bee46e88-30c5553b105mr5569449eec.7.1782323901236; 
 Wed, 24 Jun 2026 10:58:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 2/9] test/bpf: add JSET test with small immediate
Date: Wed, 24 Jun 2026 10:55:01 -0700
Message-ID: <20260624175815.673064-3-stephen@networkplumber.org>
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

The existing jump test only used a 32-bit JSET mask,
so the broken imm8 encoding of TEST in the x86 JIT was never exercised.
Add a case with a byte-sized mask;
run_test() runs it through the interpreter and the JIT.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 6b07e72295..232e9e2a98 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3158,7 +3158,89 @@ static const struct ebpf_insn test_ld_mbuf3_prog[] = {
 };
 
 /* all bpf test cases */
+/*
+ * JSET with a byte-sized mask: exercises the imm8 path of the TEST
+ * encoding in the x86 JIT (a 32-bit mask takes a different path).
+ */
+static const struct ebpf_insn test_jset1_prog[] = {
+	{
+		.code = (BPF_ALU | EBPF_MOV | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 0,
+	},
+	{
+		.code = (BPF_LDX | BPF_MEM | BPF_B),
+		.dst_reg = EBPF_REG_2,
+		.src_reg = EBPF_REG_1,
+		.off = offsetof(struct dummy_offset, u8),
+	},
+	/* bit 0 is set in the input: branch is taken */
+	{
+		.code = (BPF_JMP | BPF_JSET | BPF_K),
+		.dst_reg = EBPF_REG_2,
+		.imm = 0x1,
+		.off = 1,
+	},
+	{
+		.code = (BPF_JMP | BPF_JA),
+		.off = 1,
+	},
+	{
+		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 0x1,
+	},
+	/* bit 1 is clear in the input: branch is not taken */
+	{
+		.code = (BPF_JMP | BPF_JSET | BPF_K),
+		.dst_reg = EBPF_REG_2,
+		.imm = 0x2,
+		.off = 1,
+	},
+	{
+		.code = (BPF_JMP | BPF_JA),
+		.off = 1,
+	},
+	{
+		.code = (EBPF_ALU64 | BPF_OR | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 0x2,
+	},
+	{
+		.code = (BPF_JMP | EBPF_EXIT),
+	},
+};
+
+static void
+test_jset1_prepare(void *arg)
+{
+	struct dummy_offset *df = arg;
+
+	memset(df, 0, sizeof(*df));
+	df->u8 = 0x1;	/* bit 0 set, bit 1 clear */
+}
+
+static int
+test_jset1_check(uint64_t rc, const void *arg)
+{
+	return cmp_res(__func__, 0x1, rc, arg, arg, 0);
+}
+
 static const struct bpf_test tests[] = {
+	{
+		.name = "test_jset1",
+		.arg_sz = sizeof(struct dummy_offset),
+		.prm = {
+			.ins = test_jset1_prog,
+			.nb_ins = RTE_DIM(test_jset1_prog),
+			.prog_arg = {
+				.type = RTE_BPF_ARG_PTR,
+				.size = sizeof(struct dummy_offset),
+			},
+		},
+		.prepare = test_jset1_prepare,
+		.check_result = test_jset1_check,
+	},
 	{
 		.name = "test_store1",
 		.arg_sz = sizeof(struct dummy_offset),
-- 
2.53.0

