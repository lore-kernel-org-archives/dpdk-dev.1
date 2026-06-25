Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07B1CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37EFC4042F;
	Thu, 25 Jun 2026 19:32:41 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 07165402E1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:36 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30c6836fea9so881192eec.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408756;
 x=1783013556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuo8WfWDTaZ8UjGSGfkg4+5VDcRGKlAj0SZ4VJ0wdnU=;
 b=ycdrV664WevGgF/MtuHal7ouYpUL4pvIhNO/dF9BE8s4RmjRFBqgD5nu/VnQEuaw5O
 /lRiQms+252pkcId2YvK3XCAuLYer0W09wOk4BrEo3DGFFgyPve2+mqyjxHgrpcBSgwb
 SbeodzwrtIRaBqBOND+Kn1284l/fDc0/X/+vU1SYq52Pb4n/elTRd7ccMm5uCzNt1SyY
 4iIipW8XY/T6fhr/9htt0MKoR1vC1hxOKK5Ct+ulzXZSdncZLiLFopfRk4/CnhjQHkz5
 fOlcIsHEIsl8ts4KL/YWl2meu8iBuA1XeD2iu+YPvL8kqPAT2G59wY8mCkohZz+uAIj4
 kWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408756; x=1783013556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuo8WfWDTaZ8UjGSGfkg4+5VDcRGKlAj0SZ4VJ0wdnU=;
 b=nuiJ9ugR8o2s0IwttppqMUoiEKlRoLALw/6raiU1mckz/HC9MItxdD1XEJwenieqaX
 S3i38DKNzwEdO9HmR4VpPRcbErmBK5swOClZLjVzOVIFc7O+pgnt/btSmdVCqFDZHkvd
 U+YxzcPlLe8Z4wlCB++QPmhviRp7/deq7Xcyf7OSUS898T+VbAAJq8nHUBt8l18JIKGK
 KNJS8cYaAerwtk0By9N991jn6z/CtkUUqY0dya93EN4TuVW9aN1uCq+KWj0mCAIRAEly
 jEdnyNZT9VFOIQq5LiEVdEDlq4y6wGy0yt4cuStU+dsRlC1adHaHvD0gawdC1bZ/DV2N
 0OtA==
X-Gm-Message-State: AOJu0Yy2sBWN20GiJf73fGbilJw1LiXFeoV0bW1gHTPsk2iw7ZCa6HIg
 +m5QfPtQNxjao1bLWANHq2Q+bmbhNsZ+tA2zFQoufFSwvQpwnLjShtewKTMHd/obQfANK8UFiaM
 u34Gb
X-Gm-Gg: AfdE7cn7O/g7m7wLflnVNqTZkuV6IdgNXokDd4b9+ziVyrHGE4grwph7VzL5Jy/aCFT
 4RWaY/WTrreahROhM7jHTVslzC+CoM1XyBpPGW5fpX9CHKxuFvl8kF7MTKWnlL7dZxujy68CGx7
 6SgDy0bD+Pcl4S0/QMaDXxwZL2fQ2fKGbEWrknaAXP7CIQqBSzZFantIVGDUrTdmJ+eKOA5GcVw
 4FZlz9h8+9M6OkNPn4hPA5GKFTILkvIVEUCwLSJz8mZP23H1zH8dA6Nld/S5z6sMDJ4WtvyoM2r
 fSzhWblFKwkh0kx1ojJr9X7dufh22u308PRcFJVGIgLeOkYI12UZ9hINpaEcHJSGSb6FlR1ojrm
 HZ8pd8z58B04wn6DS031B/Q2pFirReevdCqDc56lgW+PeAhIYtx9kPS/KGRY3dxhWILUvFB5LOf
 xAELOqhU+UA87Eo9ompqJBIJDTjK7la5E5P/MIxQZ4vKAEXKQGF/inVlF9MiiUJw==
X-Received: by 2002:a05:7022:6612:b0:123:3c24:b15 with SMTP id
 a92af1059eb24-139c3cdd5femr8918523c88.19.1782408755670; 
 Thu, 25 Jun 2026 10:32:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 2/9] test/bpf: add JSET test with small immediate
Date: Thu, 25 Jun 2026 10:30:12 -0700
Message-ID: <20260625173231.216074-3-stephen@networkplumber.org>
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

