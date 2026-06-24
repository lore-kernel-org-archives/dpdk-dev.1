Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE3CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82DD140669;
	Wed, 24 Jun 2026 19:58:30 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id A7B714065B
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:23 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30c55adcf66so1498114eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323903;
 x=1782928703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6FbDl25tsvIGYfr+isu8bghV85J/cXrG7G1kyzjZGg=;
 b=Z2Ov+qaDS1ldSFBUqiKAGwvc88y9UIxyz//tbhr5zxOJ5aQRMiJWD5aKPBa2e293xj
 /zavFPwUc4MxvUq+6UA/SkuJSZO5DA7XhYXj4GnlkQHy77Qm9hcD+bkju7E3MhSz6H7B
 Z1J3MhD1faWWWfnLYR3QldITHWZSLSeRF+Qo3o2vplPY5aFKRhjLgoLOC4C2M2VYd2yT
 Msox87zvRVoB+AT4ESIL66aQb96VPUNCRhyZXV73hk0RDZvUgcZZ4TeBR35AKPDZ//LP
 XykM29RF5gsBiS2TKo7X+kY1HyHuxhCM9/6kuvOKRQ1PnJSjQuvkv3Hm7jOOXVB6GUQc
 Jftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323903; x=1782928703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H6FbDl25tsvIGYfr+isu8bghV85J/cXrG7G1kyzjZGg=;
 b=BmFQ9+P/aipBdIFHMWRW4XsndZFCK6ScgQPT3xMCPdGACNyvpZiSzhxe+v94rG95EP
 B/cy3OeDCIoraVU6GppTjn5tj6cfgHv4JzjW4byx0RfrOIw3tpLjrT14yiJoF3JX+Vcx
 bLn8xLP2IBa2ArSupw5+VvfLzT7SlPyh58wozZM9zq+kuUDa0TjjLs6la0anw3PvnYOx
 clsEF6MsAxfPC2Exe8Si+UBzVyYDf89vSQmW5doz7ShDAtRLKFpHRnEmyM4423QYJZ+z
 Cwx8TdhFxiwX+fXgndvnibO3uUw0OjmwK7ZTT3/CeB5I58+s5qusBOzYRN7JjT1NlFFy
 u65Q==
X-Gm-Message-State: AOJu0Ywv//n1dVHH0KPD+k6ujQDuWvv9DZTp0WWMqP/qOJLQYXVzn1mh
 dwXTJJPFMPNEhalv2k6t9nLLNbXqRYDIxsubRIKqKp2+bdF8mg6Xvo5V7tQGVaAgdiSiWaLdYp3
 KNuwE
X-Gm-Gg: AfdE7cmbU42hNS338/RBaj+6nupyNEwpJAZCTuwhSC4QWMrwdgGRqzGCWQS7SlxQm+n
 2hwwH1O/Sj0UqTiLRG58Zsz3Ntz241OLoFNWtqJbGpQcVuny2S1VtFSFDnZjgT4KzQAmSPuhbin
 IbEbe6UtfjnuZF7aanyv1ZUyx/1JQwQR18hJJDU04jFpE2lOuo7OAuxeWutC8viDwA7Kbn3CFPw
 NvckdBC9jP1t6+D7sHCfKJnm7dal1ZybxZxlw3jfW2mM95xosxS7jYS/93kTPepwEyncjHpsJju
 WKRChwT6DkGPUqZZ50eNFgp6vMe9r4g8xock76lUgEYpSiVZ5KQ6djyQk3QemCF0NHkuf7ea/l0
 Se2tGVqa7MkSbls4IJ9ZslCBK64/pkzyRB9KUmSgpqbU1FreQ4rFI0KnoGFa+nllLPm+qUvC4pU
 zUJAL46t4lKGecuE158EgAg6KWRPslC4tqMfRSzMOBNTJW7K83anw=
X-Received: by 2002:a05:7300:1825:b0:30c:5254:787a with SMTP id
 5a478bee46e88-30c68e03de1mr4367404eec.0.1782323902380; 
 Wed, 24 Jun 2026 10:58:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 3/9] bpf: mask shift count in interpreter per RFC 9669
Date: Wed, 24 Jun 2026 10:55:02 -0700
Message-ID: <20260624175815.673064-4-stephen@networkplumber.org>
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

The interpreter shifted by the raw immediate or register value, which
is undefined behavior in C when the count is >= the operand width and
trips UBSan. RFC 9669 masks shift counts (0x3f for 64-bit, 0x1f for
32-bit); mask the count in the LSH/RSH/ARSH cases.

Fixes: 94972f35a02e ("bpf: add BPF loading and execution framework")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_exec.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index d423ef28f5..bb03c9cc2c 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <stdint.h>
+#include <limits.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
@@ -43,6 +44,16 @@
 	((reg)[(ins)->dst_reg] = \
 		(type)(reg)[(ins)->dst_reg] op (type)(ins)->imm)
 
+#define BPF_OP_SHIFT_IMM(reg, ins, op, type)	\
+	((reg)[(ins)->dst_reg] =		\
+		(type)(reg)[(ins)->dst_reg] op	\
+		((ins)->imm & (sizeof(type) * CHAR_BIT - 1)))
+
+#define BPF_OP_SHIFT_REG(reg, ins, op, type)	\
+	((reg)[(ins)->dst_reg] =		\
+		(type)(reg)[(ins)->dst_reg] op	\
+		((reg)[(ins)->src_reg] & (sizeof(type) * CHAR_BIT - 1)))
+
 #define BPF_DIV_ZERO_CHECK(bpf, reg, ins, type) do { \
 	if ((type)(reg)[(ins)->src_reg] == 0) { \
 		RTE_BPF_LOG_LINE(ERR, \
@@ -183,10 +194,10 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_IMM(reg, ins, |, uint32_t);
 			break;
 		case (BPF_ALU | BPF_LSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, <<, uint32_t);
+			BPF_OP_SHIFT_IMM(reg, ins, <<, uint32_t);
 			break;
 		case (BPF_ALU | BPF_RSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, >>, uint32_t);
+			BPF_OP_SHIFT_IMM(reg, ins, >>, uint32_t);
 			break;
 		case (BPF_ALU | BPF_XOR | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, ^, uint32_t);
@@ -217,10 +228,10 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_REG(reg, ins, |, uint32_t);
 			break;
 		case (BPF_ALU | BPF_LSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, <<, uint32_t);
+			BPF_OP_SHIFT_REG(reg, ins, <<, uint32_t);
 			break;
 		case (BPF_ALU | BPF_RSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, >>, uint32_t);
+			BPF_OP_SHIFT_REG(reg, ins, >>, uint32_t);
 			break;
 		case (BPF_ALU | BPF_XOR | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, ^, uint32_t);
@@ -262,13 +273,13 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_IMM(reg, ins, |, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_LSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, <<, uint64_t);
+			BPF_OP_SHIFT_IMM(reg, ins, <<, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_RSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, >>, uint64_t);
+			BPF_OP_SHIFT_IMM(reg, ins, >>, uint64_t);
 			break;
 		case (EBPF_ALU64 | EBPF_ARSH | BPF_K):
-			BPF_OP_ALU_IMM(reg, ins, >>, int64_t);
+			BPF_OP_SHIFT_IMM(reg, ins, >>, int64_t);
 			break;
 		case (EBPF_ALU64 | BPF_XOR | BPF_K):
 			BPF_OP_ALU_IMM(reg, ins, ^, uint64_t);
@@ -299,13 +310,13 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			BPF_OP_ALU_REG(reg, ins, |, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_LSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, <<, uint64_t);
+			BPF_OP_SHIFT_REG(reg, ins, <<, uint64_t);
 			break;
 		case (EBPF_ALU64 | BPF_RSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, >>, uint64_t);
+			BPF_OP_SHIFT_REG(reg, ins, >>, uint64_t);
 			break;
 		case (EBPF_ALU64 | EBPF_ARSH | BPF_X):
-			BPF_OP_ALU_REG(reg, ins, >>, int64_t);
+			BPF_OP_SHIFT_REG(reg, ins, >>, int64_t);
 			break;
 		case (EBPF_ALU64 | BPF_XOR | BPF_X):
 			BPF_OP_ALU_REG(reg, ins, ^, uint64_t);
-- 
2.53.0

