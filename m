Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC4FC4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63BD440663;
	Wed, 22 Jul 2026 20:34:00 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 9C4DA4014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:33:56 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so6304828a12.3
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745236;
 x=1785350036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aWnqGvfYXu70jIEKM2VKj6WjCsJFxO956lCJg+fLFeA=;
 b=0Ap5oXzc4ClVcQiUPnHxcQnVlQ52XRsSSy217QBThjzIEr+hy7lKAf/T7XgAH1H0qD
 e2QIoUfAtDnD0qfXOItq26sinGzIOJT8u/wTfUGZIbnIOayODvjRfJXaGSeD9tCD1h2b
 kW70DfRzrYKBs/iZQOZUEVFUBaag8C+YW0Uysq35WFQ/XHCMQcLmXDWKvv8e7GRvj8V7
 5uP310d5NDW9arqe6fjj+jV2TulcYngqSc4SOb8NJWKUuUaW6NjwiUcxF+Q8Cp3rzu9y
 ZE2mB6rV7aUv676eoq7gICt40rG6eZXV5At1fAieOoPIk57bI7dS7bKOEpolSwql8Krj
 9HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745236; x=1785350036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aWnqGvfYXu70jIEKM2VKj6WjCsJFxO956lCJg+fLFeA=;
 b=EBTiMUUeMtzTs8Wz+2fllGMWeBbBL56zGsMlf32EdqMol4mFzO/FiGQii90HkzKeOy
 voZwb44C5rANwoRK3G2qUbwrPnjEcrgtOSHa9ZF1VZ+e7TjeCYlLdwM9yk78TSFKlCpg
 ZH+s6ma1nq6KqqKqKwAvSk4Iuvmevr1MQM+nvttsegJKFC8L4BehWIiLh3aOUbwUZ5hi
 i2HJ3Hri33suLyZUaSkyIy7kJZtBLFpL+n006q3Nx542dxGvig9JSozy7y6e7RLGOZSB
 dxYvba3WVFZp7JKueKnlgLY1BFXm+/1BMLswkDhFa/LsC5zExzyKp1YkoMEsLVswHg7X
 lpQw==
X-Gm-Message-State: AOJu0Yxnr5gwMhpDkB8OxGz7eRRkLaebSoh3yvWY8HJfHYDltHwpHTJo
 rqfg6hRoqXyJjoeB8gHkVVsYeXVyaWxm9KttIbY0ldR1x65xSCvh3Riug7UPWmuU0ykM7F8+hJT
 Aidhs
X-Gm-Gg: AR+sD13rgj/Ygnh5smy4w+MoXVFtF2xhOZiebqRRtV97dqWp7FJf9yF2gEgCan8aEah
 pGFZeCC+iRRVUrhhROw/G8GtG6rNxn3s/V+T2DPi7rv+zvQRh/N0cHURPsf3Vd9q4i9j48yYh6G
 YZPWaYDoFPWFjoxFBb0C3rrd1UawiKidUvndwvMsdsFZ3UXBCbixDaR4zIfT4J5u+wtBUWYC3Q5
 Cn/z2vM9ZujPwNdoG4Te9BAyK1aSE5LLLaazxdzLphlmqIM00QMZBexZ8AKFZZcM7uNKbojEVDB
 7F9ZWs1RDf4VWse3whPH4wNOkg9aD1F4y5KkNLdz4XQHOK2/2JlJe1IoAu8rT3UvO+tVCCu3g3W
 j8RSkmBtlzVOGKSOBzff6bQbkA/3/UBIiXySwEVS9Xi26NtASPpLlhDO66+S4XkFJEzK0LnotKy
 QWrfNrFN56SW04XK4cwqNzsKeM9qkkSJwvmKpLhqeg
X-Received: by 2002:a05:6a21:4c16:b0:3c4:347e:3b9e with SMTP id
 adf61e73a8af0-3c4347e3d78mr3849947637.49.1784745235799; 
 Wed, 22 Jul 2026 11:33:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:33:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v7 02/10] test/bpf: add JSET test with small immediate
Date: Wed, 22 Jul 2026 09:05:14 -0700
Message-ID: <20260722183351.633025-3-stephen@networkplumber.org>
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

The existing jump test only used a 32-bit JSET mask,
so the broken imm8 encoding of TEST in the x86 JIT was never exercised.
Add a case with a byte-sized mask;
run_test() runs it through the interpreter and the JIT.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..f4286bcefe 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3229,7 +3229,89 @@ test_int64min_umod_uint64max_check(uint64_t rc, const void *arg)
 }
 
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

