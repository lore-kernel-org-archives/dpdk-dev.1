Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F9C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54A644067C;
	Thu, 27 Aug 2026 23:43:08 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 217A240150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:43:07 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc1c3d79b9bso376032a12.3
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866986;
 x=1788471786; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHkab7ovWVpVsJ8hdtI7YC045R7XRC9vCRGx6oPAtfM=;
 b=H582/vL3T68DyWNTuWPCS5HAflI89ihh8u8prESK4n01my4/2SAdQktjQWqzFkE1oa
 ag6AGcyVN19ecMRAD96dAcMI4nGwIxdeMIzpB31BWKXnQAb7UlDa84otak6Nyx6Z74z7
 CLAg4qJ+1VmOgvKaJntpvbkUDYdaycEBBJkToJlAGXProH9QKlPWwnjwBFzlRNlahilA
 3ZnBxfLgaCrCOYgB6/44RQYVMGy3rzWz6eorEG2BO7dh69jgvqZa4AGW67sCbPpUxwW0
 YTIrWQ3cLD05A9CY8GlN2Y/iALwguX/+PlvZvalc632f8GsBOBrVXxRz1LrDoRjNlJ6H
 ODyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866986; x=1788471786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHkab7ovWVpVsJ8hdtI7YC045R7XRC9vCRGx6oPAtfM=;
 b=F+UczBgbNtjDimJhyumAA1FOr5ziJHRIOz4F/u0Y0b04O4jF/r/awcDZDU7dguWFfM
 wzDTGexPl0a89SeMOeBobGyxcg/pv4siPOW6ZhkLOjiwZAuT1OfaiiKVake5E1WpgXMg
 f8S9Gtg9mXiDOO3rATdvrr7d8bpCW+waQ0l9zqrrq3ao7JGE5eDsEDWry3tPmg5eCU+T
 ZQCmEtKra0A+f2Zm8Z8ytvscoSSisFpca7mxM9iSvCbKETy8xn5aUwaxPQbyUZIMYe1r
 to76LhRe2q6vr2YJD+3iQQLqATlZqmTuIsvfgDLrGVsf/3A+0ni3NZ7WMVYnlDM0soQE
 hWpQ==
X-Gm-Message-State: AFuF++ka5uEAg8BCx0QuwBdTmtxsV4Ym6NR0XVA7B6f3iL9s9XUlDorW
 9AGoDBzhgXN29g0a+IYfimtqiX3BKPC8IBTTdubsa81uqwS7Fzj7BeSUJY4TXtc3wV3lXOx32Ww
 AAnSF
X-Gm-Gg: AR+sD11qHyrfm0UYnr9NvTXI7jqz7GH4SBbvrnFdEUtDbZLfu0Cuzicxg6M6Hd1Hiwd
 jeCy4bWzNx9iFlH1x3zozhrvbnnLzqeKSpb6MsutWLvXxYJS08Z04XswMU5na5ScvAlZ+AJDpXA
 xoAtqudKEB+VHhoC0pzmYCwdOtOvsYwOMc4RCx8O8KnVXhUiG2YjNRRSLBPMo0It+pabY5c/Ssw
 ZJMeYMgsHE+SUz1D7qO7k3fkJpUG+9QD4fuQOyB2imvT7VU8kMAG7Ddbe9Zk8A08nBwCUAXHxe0
 A5fTmZSj+LEu6qZ9bpPIrv6S/w5jZBgKxCxYs+cfC0eSmVOEHzQC61SM2+C8XKoLm6G92YrVUqs
 Os/wGqzIjPN9ycCbucRVwMaRUhNjO21ObDUjxI5mXdOOJDzIKpmKQ69/HE1wqYaB/sBwAJij7HC
 OiEfaj8luGFKR0YOOH7pmGAXA3ERo532UcdWdMtD6itZlNJV4FXoE5HXeCpM8DuOKcWyH7hWIO3
 n3dCt+NqLdL3ieOV/tCDoLBoOA=
X-Received: by 2002:a05:6a20:1582:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3d2681a9fcemr2960237637.14.1787866986234; 
 Thu, 27 Aug 2026 14:43:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:43:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v8 05/10] test/bpf: add test for large shift
Date: Thu, 27 Aug 2026 14:41:44 -0700
Message-ID: <20260827214236.1415047-6-stephen@networkplumber.org>
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

There were multiple bugs with immediate values in shift instructions.
The code was not masking as required by RFC.

Add new tests that cover these instructions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index f4286bcefe..413d47357f 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -2012,6 +2012,51 @@ test_div1_check(uint64_t rc, const void *arg)
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
 
@@ -3480,6 +3525,20 @@ static const struct bpf_test tests[] = {
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

