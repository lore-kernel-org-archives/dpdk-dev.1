Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE745CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E71E40651;
	Thu, 25 Jun 2026 19:32:47 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id B7A0440651
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:37 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-139a5f4ca15so150349c88.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408757;
 x=1783013557; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAThRL6TTvmjP8V+IxMMZv1yOjoqt4suLh6BDU3qx3U=;
 b=toPANQNGubJfUZFCPyOAYkoBBhthMZluT3vyketrB7fNqrlM0aGzkhpKkYkT0dC4PQ
 YvL7YUkeqDzj6u2dViPBcryN/pX72wetTgIftXtCnzgWXODaXkQuLsE9XTIUHvJ6ZaSt
 R4FNtEHm47jLufX9FOciSfz0aT+z81bQIXz0wBJsSkQ+yMcp6Mn0I9CG9/Aa02dtep1s
 OPjX+wzpJigW9BKPFQYKKiWdF9+HGo++hTWoADvrIn0gWjjBRGar4jG6+gwVGcHZEivK
 lRQwGDOhVaPFTkLZ3J+encl/6zxrNJO9L5G3mvKp4UD7iffa6ENYjUZsaS8Ma85vcldO
 3rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408757; x=1783013557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mAThRL6TTvmjP8V+IxMMZv1yOjoqt4suLh6BDU3qx3U=;
 b=h84ltyHZvn7iTfwPPwjNcKylUzslle6DzkMTB0UzoXLZKKlwUtXtF3sMTzg4Wl4VGn
 CN/jf9hs1hVldfsHolhFX3hNrp2+k2dNCOsCHTV5o57Wiq9icBpLZ83aqhyDJnfPoNLn
 hFjLEwVpLg4n/6MKM4qcWA792Ez6Zltl8se9ZhGnUh/PHSTm6B8h3kChks54YdQr81iq
 VGv/jFwqd9Lv3eh5lVC8a1Xe/DQQ2faxJtjVALYW77EWbBJtSYiLfRZl729uc/dxqGmn
 /uQKFWpV+nnIByYq+k37qmPbSaHaX7hGw6Q5IXnzWj1BgEp/JBPgvOxCKITUGo0wR32T
 pmWQ==
X-Gm-Message-State: AOJu0Yz5PZqafBc2DSCZbBjMiESh0tSAui2EamdUcS55XYMJtWKdHfDt
 X7yxOYzHISk4KbX8jKtq9DZhH8xfslurpV9EdbPw9wDJ0MQGeFWAxPnH2n3BPdOY8qy+Ft+Hfrg
 mP337
X-Gm-Gg: AfdE7ckVEXxXnhdduCJhjCH4szgBLBdrv2Fpdaj9rDk66ygeX9hVPFB9ik8JXNdCrqU
 OIUTDhTd34xPCeq8C9f3/i5VvU2PG1womISpItg28APWQ9as2f7V+MWuu4rwLA3NIafVJP6LYt/
 vlb0rcOgdfSmU/sKntqm1PLoRMbPe2TFpZostWyCyXNaXuTh1HY/M00BMqTbFQeRIXg+jRbmI/v
 jkALPMebf8hFHTLEfnTlL8MPwZhxcQCXrAu4rv05h1z5h4ig+mH78I/MupojahUToYr++d/dKbZ
 al1x+Jc4PNOF6+hGEyXA3N/aLFEWgWitoq/LxXDNmwWjXYMzLdSuUDoB0yp/8PnwLQgyei5R3pl
 E0vABJtWeO3+9NYY43o6X7b59ypQMG0WMlWU6u45UEaVz1o4o7e7gLuCDOF7O9oOrd2OZPQB6Px
 ccu6VRFJ43cHoqSSg7iRzkhAelV/B23JEXE895GTCW7UbaTtF8iBs=
X-Received: by 2002:a05:7022:788:b0:136:c443:80e5 with SMTP id
 a92af1059eb24-139db9f6888mr3215479c88.6.1782408756778; 
 Thu, 25 Jun 2026 10:32:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 3/9] bpf: mask shift count in interpreter per RFC 9669
Date: Thu, 25 Jun 2026 10:30:13 -0700
Message-ID: <20260625173231.216074-4-stephen@networkplumber.org>
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

The interpreter shifted by the raw immediate or register value, which
is undefined behavior in C when the count is >= the operand width and
trips UBSan. RFC 9669 masks shift counts (0x3f for 64-bit, 0x1f for
32-bit); mask the count in the LSH/RSH/ARSH cases.

Fixes: 94972f35a02e ("bpf: add BPF loading and execution framework")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
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

