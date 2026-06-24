Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0FCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B517F4067A;
	Wed, 24 Jun 2026 19:58:32 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id A25C1402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:25 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30c52cc5285so2027667eec.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323905;
 x=1782928705; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kTq1vC4Daba1RPw475DzdlJ0pOg2HyJVl+399e8adY=;
 b=CNlfO6b/mJVPochLFKDuVQA+7eHTSdRggNns0fYYEclU/U0mOnAAGUQKOhzMDgB5su
 GIEaDW1rUSrRmFmwF5sRYtjax1Tmz5CWKvly6+COkbHA0VjAPa4CSy+XnIgupiBmA+g8
 eWkCJQByqcB2n99XFRG+E5s5u0YKDyZWlj0alAKFgTIhKZLS6q9GmYJ6C9DfvhhJFj3W
 Jmg5SQ9mdJinvdAnvJdb6utOHkLV+xepbmcry8LRthmF4vIySI7vC2uNsByyxsbwExzH
 YTK4O0U94abK/W2WNFqzAe8Wq/6Bo0VuDovwgvQlpXRuOoCh38QD8hfX+EMfCWJ+rivb
 HR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323905; x=1782928705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0kTq1vC4Daba1RPw475DzdlJ0pOg2HyJVl+399e8adY=;
 b=lcmgjIBh5hCPAZwbMB6lrEte94dhTKofjuXr4Zde4sWJo+ZWeK++G9n4RYfuxnlvDx
 k2fajVhw0W7QKSZ71tE60ZvVpLuy/Y60pH0+LxG0OerMorqOC8Zfd0Riw8l/ypByyklp
 GtlJbu1KK8ForQKvATe1eex6Q1obLnKQPayMShcX0f4m1nADuSoT+xqox4gHwni1u/qE
 kwW1CzTCVVLQJ2oneYc6cNBicqnCKj0f4afowTHzLRle54yTTCMQwbQEGtmPSzmO5cdm
 sUFChwuGsUhkEK6o5OyGS/pqEomEHM+xOsq+kWTFVhWZ3n52lf/1cAiqiJD/k4DcXH2v
 T18A==
X-Gm-Message-State: AOJu0Yw+RQwkeAbgpWpu1VkBUXMO8iu/Lig5Bw+rMDQB2RbUwlVTnho5
 FPVv1iuNYupRHe9rVyAiPd9nXDDnpKYxGyuBQYAeu1fnVigKZaQyYoWxYZzH7in9j5QYZm2Wbm7
 ryx6Z
X-Gm-Gg: AfdE7cmOztj+9qNjn1hHMb2XlcpGzyo7+AcpGwC4dgTBhpKh06n4MJaLWcJ/oHGO2V6
 ZaQuMf1kTT043W1nLSJppNawLN9fw02acxPbUbTsFXs9fJjCEfpY/cnDwp2IzscPb+5fvKUHqts
 3V+3wPmLUn/ixdaVtIIEJPfE3JUVd4r46ASZLbudFKa4FSWfArkn9gzZnZFzs12NmB3qFMJV0ct
 LXHTD2+Hzrsu4+Zqq1+Mg+G5ZjsfO1AUVx5xN+BGw7ZZjZVMoDOSAEss1i7nSTVwWpkX15xRsYu
 bvdwBnxyoI8hdqQRfgYgJdD49yMllndZsU7Ix97Iw2Me6+y1HwCCmhwTRVEtIk+wDM+sU9syw9m
 VzIelaa6niUTa1dcXV7GiocuYBXzFfRY01rQQKyA7v7gno8Knl5XFoJlkuPkrDK/kGhztKbcPER
 eO/Rq1Ohkl+97XnPzLi8ZJZ6srbr+nkR4YjR5NsMdGYgBd4g9Nix8=
X-Received: by 2002:a05:7300:1483:b0:2f5:5907:3a48 with SMTP id
 5a478bee46e88-30c691319a9mr4803627eec.1.1782323904607; 
 Wed, 24 Jun 2026 10:58:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 5/9] test/bpf: add test for large shift
Date: Wed, 24 Jun 2026 10:55:04 -0700
Message-ID: <20260624175815.673064-6-stephen@networkplumber.org>
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

There were multiple bugs with immediate values in shift instructions.
The code was not masking as required by RFC.

Add new tests that cover these instructions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

