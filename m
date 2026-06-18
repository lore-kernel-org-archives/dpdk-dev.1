Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB0CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:00:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30FF54067C;
	Thu, 18 Jun 2026 23:00:37 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 7953640609
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:34 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30bb7d20ad9so2092122eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816433;
 x=1782421233; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAGOm+DoEr/AJrW8h2pOz1d3tbtWAaOhOK3qUe4Lj98=;
 b=o9QnC13GwcqI11bYhJm4yujFHRH/d7siz+bxAvlPWP6FOJsRTt5khkWULH3hl6xDBB
 2vp2sy6JigBos92AaX2u7y6Oe/t5mz17tLCk7SllfOU4Dc472/jrmwjtM7fzxW7RDx92
 RSXVzxfOIp5EH8kuSFKkXWy0gjhG4DvFmCCNdw15xdXxP3FuCgXS8VvSbQowtdp4bIzw
 Nvm4LAyrzKpFMxGU4wVTYeQEh173sxqZxoc9ERjD67entSmGfWx5QJVsCuFg8/9rdgSq
 RUhbNdqQCtn1SRPyU0RDy9uxCHQy1KDipn2VF4cuqdeyXEeOsjcRmdgMJjmY1XAE/kmz
 xWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816433; x=1782421233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAGOm+DoEr/AJrW8h2pOz1d3tbtWAaOhOK3qUe4Lj98=;
 b=MgiddeT/J5ITDCHFQ8t1sMIFSOnfvc6snE4tjr+HumT24j/6o2iTfOZ2sE58Yjot7Z
 IfdEp+FLFCs25QIwZOFdmlJpvehVWjE4OxlaVUU0wX23JzQzSwEDBSqjwjA3Avb9c6DY
 7iuUPbo1PfhnlACcq+uBx+fK02BY3LuDalU8y+IS0z4WpPd+B8shcPvQOz3ix+EUT7Ax
 KkQHzfQk127B4D72c4MzgQI8Ceypm1zb19dmBqg/ftySMoYt8XZRxpJeBCkBIK7Yhmv+
 G9/zniyEcuieMx4DT04Guky+LRMRjuuWrQFyQSm/Mkw6XigS31m+SJESf3gh87F4K0/z
 0Oxw==
X-Gm-Message-State: AOJu0YyuHOYMDx/sD94L74sAFYeU8lz8++EB4eC9RR7C9P7FxLBI/w8b
 MN7WGhrC3qqnWuHb2K3LEezEeaKI2iSTZ1qR3H+j6dVXTaXsXdsU0CnJzXuTtbHSfOT0Q5W97M5
 p6EvQ
X-Gm-Gg: AfdE7clGOSpTU1UEsFR79ArdxJpupBF7kmvFOYp7qUUx+gqfwFy9tN5lkCyR/M/B9hZ
 /5u5IzUoSOY7EkRlBZM60F5FVSY41+fELJfmE6cXcWO0y6qpvcr6jL6b8E9Doryjp/E3aYN5tIs
 MipoN28A9eR+ffObMTu0mh1sKHnS9xfA7dooehMnliCiT3W+Ic6uQXF9uZV2mOIV9WLBTrVuxpE
 RgCXoEO4jviSfhIeEk3Y8i47reEZf5SQwv18m1KktFieW0OVm90XcyanG2Gyg1EGzhdsR2gwUbC
 hkMIwyHMHa9VaVSQkxyPEO4qB5Gs48Q4ZyyqgeD0XTZQwexdG0Qczzs3zV7y4pDw1u7yOLNmrRJ
 Ga1v2cXLN4Ns5VO2HCMSFVw5yp4MjLvgjMkCBIJqHg839CTHYjiRAsE8EnVDefB8lpgJ8AbggxG
 iYVri0hvZ/O3hthaVFj5ZRLgoVSq6+2nEb8mQYil6Hn/O7KxzGduw=
X-Received: by 2002:a05:7300:3c14:b0:30c:5fe:7f2e with SMTP id
 5a478bee46e88-30c070ee7a2mr777205eec.19.1781816433390; 
 Thu, 18 Jun 2026 14:00:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 2/6] test/bpf: add JSET test with small immediate
Date: Thu, 18 Jun 2026 13:47:06 -0700
Message-ID: <20260618210026.430288-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618210026.430288-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
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

