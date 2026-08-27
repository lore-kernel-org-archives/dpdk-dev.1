Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6530AC61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1222D40284;
	Thu, 27 Aug 2026 23:42:55 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 27BDD4003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:42:53 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-855d2bfae95so744749b3a.1
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866972;
 x=1788471772; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aWnqGvfYXu70jIEKM2VKj6WjCsJFxO956lCJg+fLFeA=;
 b=pj2Z8PskfcpdZGgWIcD0XeT25Hl1JsngQ+pY2FqbkDblo8EIhSHXQwbVNea/a32RmK
 G6r3beLFoeKu/jPVAIAau9BNdE154gfQiKdRKse3imyGPSqtT0jrxP7lbsaYoGCWt8wq
 zpVGu/l93OjMxtFAkuKo0hUBfGssXhcXIexmEpWnLuRK3eUkhUSsmbba8kNfbj5+8HiN
 8ZDAI+Xy27lHeynVlE862p/h6vZ1Iin76onbiQYAIdkJvOLZjJmxptHPrBLhsvQLEH2h
 j+g94H0NrzMOGREFtT8+weBaJ5xIvpWKyRsmbvngTQle6xDfzzYONpgr6F0wNmO+qtCZ
 nIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866972; x=1788471772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aWnqGvfYXu70jIEKM2VKj6WjCsJFxO956lCJg+fLFeA=;
 b=NS/dcYzCpnWfUzWBp1Mb80u8YZE7L7dNXCn+LvLytm86kNG4BmKzQuqWkcMkAM8JaI
 Eedn0mTXys0QRN9WMTvsB5KlIHQXzgl0z0lP1wULzg3vtcI+JqVx4qFc7mXi0tX4JsX7
 O9Cy6SrG0JkmNNQkcxbKJfAtleOEX2uPbhTUFL2AwjFFEGQDTxAmSQ1KMvUsAdwAh1BY
 ao2mbJ2GHLKbAF3SnunzRM4wOeFKxgkLlsTPj5dlT+hafKSd1UyAPCr4UvpW5ltbqSBG
 NhWrgMuKFcRK+EIGMdH7IfpJ60IqCOxwdv9laio9+Vo3L74Y178I84BMYEXJf5aVQ1bm
 shTA==
X-Gm-Message-State: AFuF++kUMGjRtfLhLwOsjzt3+Wk0D6+rIe44YaiUg0+0OkAGfpqksJos
 ltoqXW76Z/3EMljwiyrzvOo+GIovXTXB9NoWUNPpURe0T0myOOw0hcB8UwaE8/9UnQMY2Pfc+8z
 D8RQJ
X-Gm-Gg: AR+sD12RACW+WMly00VsLm5xxbiQ7cZ6zvifhcjzigLQ6H8QSnivaK9pKb1fDTP7Udv
 pp4upi/XHHjQgECtRzqpaAua3kk0QiQShoXuQEpZDGZ0YJ60iTsgm5TqPItXenoMR4uyIpqpGkY
 aP+U8OSC2lt32v1Vo21rVrPEwphGtMhxGWRG85w84yNchLPQUeXc7d4OpN0a1ELlsz8YAy2BdYO
 bVsOP5EK08aXYuDjPUdsHOChKz8Lk7e2j+j2MwEyG6WuClYgDcR8dP/Esb0TuhR2v3pXoZsYNTT
 Zoz8ZPfgXim40QI9aB3613WgnnFurkzepKSpKPYdRdHkPMuthU0Ipun4tyHAMtopdbyyYgI/k3z
 aY2z1uaFd6XItvgPqxSR2Ru3EFL84r9IBu7YevvIIORUHxD/X43zF5pfzdkW47nH/cJHJnDI6Yp
 zXCkmW71czhbuaG0u3oDyOc+Rr8PNTibU4TacDZtdXa8jArD+oOfDfZ0qYeWdKoF8gS0KwJ2tOU
 Ee1sLagSPPHfIHseTpi6sTukgWa
X-Received: by 2002:a05:6a21:3d88:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3d0f762b513mr10573521637.19.1787866972153; 
 Thu, 27 Aug 2026 14:42:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:42:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v8 02/10] test/bpf: add JSET test with small immediate
Date: Thu, 27 Aug 2026 14:41:41 -0700
Message-ID: <20260827214236.1415047-3-stephen@networkplumber.org>
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

