Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B01C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C022406B4;
	Wed, 22 Jul 2026 20:34:03 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3BB75402D9
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:34:00 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so8150817a12.2
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745239;
 x=1785350039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHkab7ovWVpVsJ8hdtI7YC045R7XRC9vCRGx6oPAtfM=;
 b=BxipURKQEpKMqfOVaYQP41/KUtxDqdn6A16IoY6gf/3Ctp/6wWglDpcSzGYIChRv74
 ARwYZk4VccKh3T55cMh0QbAtSjGuNbCRq3o3PZqyKIZ/9JbWErhHQd7eIBKPorEklKEi
 Q8wnEJllVBsXUdVvpV16Ep7rZMT7gkXDDUeqo4jpZnUddYG0SBFSXD2cX2N6wp4Y+kMJ
 Un+n+7LYILx40G8/5jOdXwKdaoFcOet30PdoigbV6Gwp42LcdxE2ce9MZmx8muS8ds21
 G0DjRlEbb+fz++Kt+G3ezsq08N1cu9LEmX94CgOtBIA01kFQaO9L1LuEm4dO59bfD9E+
 vzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745239; x=1785350039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHkab7ovWVpVsJ8hdtI7YC045R7XRC9vCRGx6oPAtfM=;
 b=a235/6WPoiKNy12WrQinVOzgypzFSiIjvERwTZewib5yc8KIM2us1cQMvxYx1PrxWS
 2mtTJ7EWNOQv45Yfhte/wTW1Hj3yD4dsxJ+08elzjjJ9H4ehQ0OP4GCkmthHJOn9FQaJ
 RhNcyKOv/39Tk+IG5+Xi6wSyKpDUIqgjKoTbDyU5FxKvWV8SA4dTuwgCYHcm4Z8Ho9mj
 wv6iJLL9Yckhqt2ogQvl7+nxUErXixw/pJiAn6fipkyC56pzXEyfbP3ZjiTuWd0SLSrI
 A7u5SfEI7Z9NTbsdGGCI2Mzc/mmlBf1YoRnTts1qLA7cX0BbSZeJ/bRAmNl925Fe9RTb
 9xSg==
X-Gm-Message-State: AOJu0YxYcYd87bNTB8yTzxaXZRSW6lRX1kHF1EhooaZWX/HwQNpnM9w4
 IQAhMdJdteFlCc0srxAsYOTkiSSetJctmLs5/lMAR9lDJeYqdsVJjy0MHNDdDs/pNALYyavCy/9
 NNoxp
X-Gm-Gg: AR+sD12Eo1i6PuVf2dswOA+ePg/1pDdoFdckp1JpVdTrXGmE7Gzm1MzZjFerao0JU3K
 POoNRaVCGCvcm55Uji9biZvY0RNrgq+VY+pu40d5XowsapzHUPZecs5E399RxQff4/6cPd7McMb
 zj+2gk7Tyko8qJWW2zxAxl/5HM4JvhSeF1otonusBtmRPA3vP25r88CEH68Fhz2iF64pFxlsvt3
 Oenm1IbJzDmiMzRmtbBOs9o7ZfdZG5sE+1gTZOcH7/uZ7Tt+wmEMLxstGTZz6LlGhTyaLYvr7RY
 C2yttm/s7bHqGmHnX8PMmygXl1zVB0cLo3JskLMyhr3UY/eIN8yBuszADMtW9ScQlEKzE8j+BLP
 47Hj82HMqDhullhjJLR/nfbMkixcGtxBxEREST6088LDKkVpKWeWTFl5r4bEKXrB38cFzFP8j2M
 SHn9mhODD8kw5EgL7H1tRdHkYLus+J/aIF6etxN8m2Y9ixdW32CkQ=
X-Received: by 2002:a05:6a21:e8a:b0:3c3:8ce8:1fd with SMTP id
 adf61e73a8af0-3c3ad9e221amr26034516637.73.1784745239450; 
 Wed, 22 Jul 2026 11:33:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:33:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v7 05/10] test/bpf: add test for large shift
Date: Wed, 22 Jul 2026 09:05:17 -0700
Message-ID: <20260722183351.633025-6-stephen@networkplumber.org>
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

