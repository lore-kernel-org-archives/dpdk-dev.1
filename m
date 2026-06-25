Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD08FCDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:33:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A05140677;
	Thu, 25 Jun 2026 19:32:49 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 384334025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:40 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-139aaba3522so63895c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408759;
 x=1783013559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLbIBmz3ivh4fx4sHBCn5JDZdNjyE2yg6oF93PVHG7Y=;
 b=Lr/7nIeF0JcjM/Z32X6RESsOQjGUuRh82RbVJv47abVGLLu9jyRQItzL0s0xnPnYST
 eZzKMZQzIWnDjooXoWC0nV1VIPCjX5m/E/NLcKuKPdBD5oiN8Qgv4kwbz/T0LKuvXm7Q
 5GtfNXj4kaMQWVRmqqz2ZOr2xESBfIZAdDNe6LfQe08Y52qU7yt2G/Cl++e6JCFGBiWQ
 V3uP9//6mWpKWmfNLJye7ad5YOS/WlcDdCXkxf9IGY+jfiXhzaipQia8uVUklpiPrZDG
 BQ+dz66hQ0wOE+3fdKopexX4WhXgZnBmuCQsLlijXTglVzk8MQKte9Y4yWXbmdJxAObz
 QUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408759; x=1783013559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xLbIBmz3ivh4fx4sHBCn5JDZdNjyE2yg6oF93PVHG7Y=;
 b=GzEKZWQtXv3oop6n1LtoRHPs2kEusvbCv5Z7s1zN6/e2DWvDcXdGS0n8he/3iRkw1P
 kYbq5dGauVWq2fiAujjAG8m0Y48RmJKOqDb/guOzqbtvhG1bKbe596C2WpiBJrPitwjo
 cc2oV904+tbjs3bFG09JBYLz0sKBKIVM9+5wdCfrS6v+7ObUJ+W0dsFyhOfphTdJLQvu
 z3LjFF6ja+8qnmsFa77Pfw1wrgIvpXUP/b1pDEIRWLypTLHMk9zItl175pKE6fXOqM+I
 stz01u8e/Ute4mQCU1C/LFp4QQ4Y7V2anML0iQpopcavdO048g32pOy1DtlIK2ZDNhZx
 r2VA==
X-Gm-Message-State: AOJu0YzDTpAweY7Pl/e3QBdnWE+okp83UvszQu23QtczV2ql6eYHAk8k
 r13/LwEi+fmZkTqPaq+eH4vtJhKKQuYNpmBPMg2Tl1a+xdohHzMVZnuwqLwH6/PI9HXx4EUYU1B
 +6NN9
X-Gm-Gg: AfdE7cnfAksLA/GXLaMZ4HPKChpiO7o19/o8VDHI3B+J14PYwhBpVoKgLcN8uETpYRa
 G0hjUHxtvK6QGgpblrW+HdIEXJzPGXfom+eV5gVUEPw3RZg+MsqJh4HlIJCtbms5dFSPJa2bqkz
 N0Ysk3VlV1aRl9yTRnqJoI1ipIhu9BAstL6ALVaylfB5QdVaGXDZmXiRU39tlRr/KuE98pAsVNv
 ZGsVs6oVQA8MKYm62kMcIrTCPaDJt7KQZlIVwekFxqQ9PZflHpPiPhygY0LzkW5jlvF/C4X+UrN
 38w80u9uESjue4+u9Y9jtHOQrO6Mqk6tR6gfNulWB94xHRP7kFQ79wX6Nws/cdT4AOqbsI0d5es
 Rp73Ei3resv88YpICMru3itf39ox0yTfp80a89+Dqkc+tYWkO6iB16aIyHB3UAQNDJJC80F7gXF
 /CDiwCd4oW6FxiiGLujTb03W1uz3mP2ytoY5yGt1vpnGV6PgY1610=
X-Received: by 2002:a05:7022:981:b0:138:40b4:6cf9 with SMTP id
 a92af1059eb24-139dba1b972mr3069910c88.19.1782408759001; 
 Thu, 25 Jun 2026 10:32:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 5/9] test/bpf: add test for large shift
Date: Thu, 25 Jun 2026 10:30:15 -0700
Message-ID: <20260625173231.216074-6-stephen@networkplumber.org>
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

There were multiple bugs with immediate values in shift instructions.
The code was not masking as required by RFC.

Add new tests that cover these instructions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 232e9e2a98..0e5894a532 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -2005,6 +2005,51 @@ test_div1_check(uint64_t rc, const void *arg)
 	return cmp_res(__func__, 0, rc, dve.out, dvt->out, sizeof(dve.out));
 }
 
+/*
+ * Shift counts are masked to the operand width (RFC 9669: 0x3f for 64-bit,
+ * 0x1f for 32-bit). Counts >= 128 also exercise the x86 imm_size() path that
+ * used to desync the stream, and the arm64 UBFM/SBFM immediate encoding.
+ */
+static const struct ebpf_insn test_shift_big_imm_prog[] = {
+	{
+		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 1
+	},
+	{
+		.code = (EBPF_ALU64 | BPF_LSH | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 191
+	},
+	{
+		.code = (EBPF_ALU64 | EBPF_ARSH | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 200
+	},
+	{
+		.code = (EBPF_ALU64 | BPF_RSH | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 130
+	},
+	{
+		.code = (BPF_JMP | EBPF_EXIT)
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
+	uint64_t expect = 0x3FE0000000000000ULL;
+
+	return cmp_res(__func__, expect, rc, arg, arg, 0);
+}
+
 /* call test-cases */
 static const struct ebpf_insn test_call1_prog[] = {
 
@@ -3409,6 +3454,20 @@ static const struct bpf_test tests[] = {
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

