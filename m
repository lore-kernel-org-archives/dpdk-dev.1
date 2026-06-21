Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974DCD98F2
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 16:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72EA402E0;
	Sun, 21 Jun 2026 18:25:35 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 29FAC40290
 for <dev@dpdk.org>; Sun, 21 Jun 2026 18:25:31 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-139986373b8so3414936c88.0
 for <dev@dpdk.org>; Sun, 21 Jun 2026 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782059130;
 x=1782663930; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAGOm+DoEr/AJrW8h2pOz1d3tbtWAaOhOK3qUe4Lj98=;
 b=PqTJ/XBk2gTLe5T20L3VpivWcLLaZvxs3MdNlZ/klSYNpLGYfm64V4f6DvUUlnAiA8
 hNRZ1taVD5Ib8V0ILXsyUzJ81snSZPPwSKG0EnNmx93WUeBT5FDAszEmaAlm9bexO+Y+
 tNN9Rtq8F6IsLS4a/IQAozqX5fOos2Uz5Yyy3k2f9Puz/yvrrvoAykdES9Od2jRLp/AI
 FwTWRUUpJ5NP9BcSMACBpzhdPywOtQon/2TE3wrNawQexwipcNso9JoxkNr6eSrKEo0o
 BM1gMktGSRLThP89dbqZJ3UPCnMZu0w8DgR6yVQlncAdel85mDZoiTnvECk342pgNLFg
 P5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782059130; x=1782663930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAGOm+DoEr/AJrW8h2pOz1d3tbtWAaOhOK3qUe4Lj98=;
 b=JXkiLHRe8MHHOn5wBW2RMnDeTrLtk6htTL/6P6WjY2fPyZftCgbwcsTXEwK7ie3Lrs
 sGpS+y1nkcfzyoYVjy6XCpkcxsCsTEnmRXS7DSzTiXJe0/T7Jnt4R21+IwC8CF5tJnHA
 FKUMP7+UqVPz9FqqGOGhNnwSfFaE21hNExDyykPXne0ICiMBqkQg7m5tDYAs+6bQvMij
 Ap/pXAFn0SwChm8RakxDRUq6ywFpwHqC4k0ylcttHyBQ+az6/NzrdGePM4QrAddKPrsv
 t0Tjb3454+RBA/5UzK5wVgKiAjAqgm4Ve8z86QWCqN5PiES+z4AMVp9CzDMZc7P7exwJ
 16Hg==
X-Gm-Message-State: AOJu0YxzmbK0dnqecgUMF5yxVkoxCqi8joFHvPbGiGlMlVYKz2oLsyxB
 GZJ7e1bIEfEIz8KkzT7iC41oXeljXNxvVd91sFoDruGcsRJH0QYHklHvVxtMbM1v1kSsc/7ia4T
 BEASN04Q=
X-Gm-Gg: AfdE7cm5YfzjPpZaJ8w7ijgFELltKlVQDdSQGFU0bFriYF9MdtB4sLs6MA9MtqEsfer
 uJL7P/FBAJyZ0BLRvO82EsWSTpmpyoMp0DJvy56/ajF2XWZzOTmdwJKw9JN2aAR1lfTUzc1zjzf
 3UjE6BYuTeQ1iCkxJ98q3f3NFYDnFHt6qgPhGYi1roXh7h9zD791xcie1UEyKXqjgCrom325fpx
 zKfa013yFH58VB8OZhRckdN+MV7JsdPAunsPevZ69N6hkjjpKZBrpCmUq0wLAM+NXZGpLBH0dTN
 I2Pcovs5l+8KpxlTSvCz/GGZp+riz/Rys1xcdqII0/8DipDj489oG+phwiRQTXfIOZZSsol7WZK
 ngLa6lpX2sCNXqwOt+iumg/cJYtGdj5TJDkXF7ntYN3eQKAW49vK2LjNTLGTyWDBVjEQX5OOnlR
 kzDecgTLjH52k5WIO1TtTIZ2AjBKU13NcDBd+yATut26bBQ8liUi4=
X-Received: by 2002:a05:7022:689e:b0:136:d029:459 with SMTP id
 a92af1059eb24-139a210def9mr7447323c88.22.1782059130223; 
 Sun, 21 Jun 2026 09:25:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm5141593c88.13.2026.06.21.09.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:25:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v3 2/6] test/bpf: add JSET test with small immediate
Date: Sun, 21 Jun 2026 09:23:55 -0700
Message-ID: <20260621162524.82690-3-stephen@networkplumber.org>
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

The existing jump test only used a 32-bit JSET mask,
so the broken imm8 encoding of TEST in the x86 JIT was never exercised.
Add a case with a byte-sized mask;
run_test() runs it through the interpreter and the JIT.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index dd24722450..e70dea736f 100644
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

