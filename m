Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D6CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 23:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 099CF40668;
	Wed, 24 Jun 2026 01:25:34 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id A7118402E7
 for <dev@dpdk.org>; Wed, 24 Jun 2026 01:25:28 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c03b09e02so821534eec.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782257128;
 x=1782861928; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuo8WfWDTaZ8UjGSGfkg4+5VDcRGKlAj0SZ4VJ0wdnU=;
 b=WRvXLsmmcGKUaL7gMzNEX9tMfqa0C3zDXYnGMuYI9boCQoWnwLdMwyhVEL+RSyS2fx
 4e38mzUutZaWgmERTmlL7trv/6AcEbPLS25qNnkZ5pkfj/SuQN29OVF6/zi2OVUtUXxI
 tK8VhfMhK1l8x8dDQMw8KyvrJ8WDplIpG5jTimBQvN67LsxWJENKaB5yytkT6NAGZzwk
 q9fAS/k90nD/jTtaXznXj8imkMy0Tv1zanAYvEAOi7XHf3iUcFwmcIqZtaNN8uboyFYL
 Woiex6HbH3UFot5z64Owfc3nZoTrlbcp2w764/hE81G7XZdj0EukuUkEUMrojWxTZ48G
 t7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782257128; x=1782861928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuo8WfWDTaZ8UjGSGfkg4+5VDcRGKlAj0SZ4VJ0wdnU=;
 b=RIAcwtGRgXB2iPY0crS+feLrYhLEetV7ZBhZ2pOFYwPWMqDBH2WS0g5/8VVo5vMXJi
 kcAWKRQqPk2yt9kB+pNPnOg+Y9n/n/UWOzcB6WD7wNu2iiYw09+74OZ57kpgZM3mNm1B
 AFay2d4I0TJCMNX2WVpTnexIo5vKXFpRrXwHMDiXd1+cAGKo82hmG0q4OFQTYzXg/Uv3
 rxnJl8rn0TJTJ0L8B1FUYnvf8jV87B9nKq2vm/12eIIXKE/jcSr4TAndO0VwfOw9Pjm2
 JCGS13flfZj+ECGHknO7sTTqNvITp+VAbtSXtCUvfh/oVq2QcqLQlwFEmpJArA6GRLRh
 xG5Q==
X-Gm-Message-State: AOJu0YwS+hAHDZVLVOgOFYyApMrO/X5cX/u/Q9Xt+wXptB7rCx+vKcBW
 Bs9hDVfrzaVTn6MZPkuE/HZOYKqBmQCYNQgJXhq5OcphhWyOUQPrd1jdUi/GK0/BKzASk4YH/j+
 5gfMx
X-Gm-Gg: AfdE7cm6DpST/wJgTMpswYedyUOWosoh3mdNwx7tIbmze6SQsx4l/bsn6PEGBuwxSUY
 AFxhvhMvXCDp+bD3oOVDAHYv37PzqOaAuB0X0NsW6hLFObiVSZ9ICmxkDLbJQU9kZe3zwttDH0/
 mQdQ0EMzfCTSFZYrF3Gj7xjuBo8GxB+sJBs88cH1qvE1yLw5EONP2rtHgarlVCxO+jSK0sLMaS5
 /rAr9Zm7Cy32r82SNh6t/M6mGEO7fa9h0DaOiwwuV5IfXidagcUxW9rm/JT7uEP6jbuGIa+exlU
 owNBTXNNyu/L76d+UMV/s81qACfo5hrlr344m76s7etxoBW5wx7BCCfQyd35RQTnx+W+zn3Gap2
 Bw8K3SV0LG3LN0G8s78hg1ztXPROij1QGffJOVR9cpD9QFzLYEZNfRNXSrGq46mmcA3WERNBZnZ
 qJzlBTm+lorTxEQk+6ZWCk5Zx2T/LbK4K01t6xe+u500dcumIGFE8=
X-Received: by 2002:a05:7301:4592:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-30c58ba8e12mr4407748eec.24.1782257127677; 
 Tue, 23 Jun 2026 16:25:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm21263443eec.10.2026.06.23.16.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 16:25:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 2/7] test/bpf: add JSET test with small immediate
Date: Tue, 23 Jun 2026 16:23:13 -0700
Message-ID: <20260623232522.257208-3-stephen@networkplumber.org>
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

