Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7919C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB821427B2;
	Thu, 17 Sep 2026 22:11:25 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id A6C6140A71
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:24 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so247455ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675884;
 x=1790280684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rCAJxMnNcwMiqieaXt26ZnDPldzzB6KxmuNcIKPYBA0=;
 b=MoAd+AXHkfauay9RsmW39aXUSzPGwqtC5HSFsUxBq9ojon9fTdKuu9kyksmfebjN3i
 yCW/ag6ne86rGaCEaTs9mFf5M64C9u5PSDQ3evBy7CJkS8oN5h/yAaYJo8bbhm4Pcvjj
 8bR42saPcRuSb5gVUdJfo4oObHNUyUiUnaOTIjT8mR+ZbybeAhnWPPrlcoV9S227R+F2
 tK/wPLr7LR0BTAo81RNt6GZtMoYPAT1cIdkx1NFk/RfIapTfhTzMd99h50C3FRFoCgDK
 pFN8pd6eqtwQPoW9ums+73e4xqnC1FzMi2oirI6acy2d/j2nYkPZV83hlV/TNk+f46jK
 Annw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675884; x=1790280684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rCAJxMnNcwMiqieaXt26ZnDPldzzB6KxmuNcIKPYBA0=;
 b=FQG2XqTxIzVfEEdKHHVt7P9QQlCjnAhsZKoAE7DLfj0RmSdA5VTsd6SKMU9jhpcLau
 YcKwRXScP0ZAdxTE5Q1s5o2LG4MgySLPOl+VHEgNE8fEsu9dh63PKb9e1sW3xvmDsRGu
 Sdz5c8B1FD5CVpB7qxc0vrcuUiVOJgyQ1k2epK+Z2uhmlcYnhavoDp0yh2VfiKToqSs/
 pq51+wrXRrvdejp81BQJNBqnKKJ1LWaC6c8Zn6D7gIdWhl1KEuXUeNneyxW6x24I4Frc
 rIpTcpG476IYY/aHE6yDuKlrsQ93cBBKD1d8poopLIxX3k6zt7TLrSoOeJ/rHic11yL9
 rVNw==
X-Gm-Message-State: AFuF++kDbXO0xol2RhUuNuuFl7hm3CY9+F3b+YS7xFXirKGj+jnkwpBZ
 DsoNooFx1P0u35R6o0TAde65MXASsc/XUnRqoXWGI8Z72qO0Js+qZIq1L95wfjDVLD+v6VlgP5V
 vqe78
X-Gm-Gg: AYBFou1YYFjc5WpL9+E5kVNJ6xW8uUv9m6IQXAkH1Kz32sue/Lz2qiCMZ9AjoZwtF+u
 lcP2TAjV6b6ZKJIxYaVVMoS2wxjwb4LJv9x3Wu3CARV3Ukg/K2tqZb7WqQBGStIxUAcf9TWHZw1
 uD5Urv1P/l8+i3D6qdhTxcKxE0n40wZ0WhWBhh5oBaTAT2JausLc546eCL/RNcCYDhV+K7AWKYU
 Z4ZcA8PqZWLdNvRhuzalLvKt/9wV+TCKf0KS5VDK7m7Rb/PNy/CYSg6czbra1DADCP5ell8O8mW
 9A9SQPuupwweCfQPCBCbQyENHzAQR3CNN1nGeJW7VKqiaXr+NpqQsu2vWOMZYMr9zp9ZdO++qBt
 GUv30Bd6eHP6Ah/vxt1ZLZfuIQ+ABX5qchh4lpQlKy/VlEbRQiy2/0Ua4AMLzCAbTBME3DWIcwm
 CTQmrkQseDkpm7jLeX66W2tudjQAF2M/dcmpALj4w9cu3ibyWzgsxHuY5i58GpJniyMEZAv1ssw
 Alo55qxQpGj8AVdW7PPhjjBAHNeeLmvLi7z8IMOWCQtz+zg
X-Received: by 2002:a17:902:d4d0:b0:2dd:76b1:34f0 with SMTP id
 d9443c01a7336-2ddb1afbc33mr6110175ad.11.1789675883683; 
 Thu, 17 Sep 2026 13:11:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v8 01/25] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Date: Thu, 17 Sep 2026 13:10:05 -0700
Message-ID: <20260917201119.2168234-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

The BPF_ST_ATOMIC_REG macro generated code with deprecated
rte_atomicNN_add and rte_atomicNN_exchange.

Replace this with the equivalent rte_stdatomic definitions.
Use memory order seq_cst to preserve the previous behavior of
rte_atomicNN_add() / rte_atomicNN_exchange() and match the
behavior of the Linux kernel BPF interpreter for these opcodes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_exec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index d423ef28f5..99b37ffa4e 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -11,6 +11,7 @@
 #include <rte_debug.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+#include <rte_stdatomic.h>
 
 #include "bpf_impl.h"
 
@@ -66,16 +67,16 @@
 		(type)(reg)[(ins)->src_reg])
 
 #define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
+	RTE_ATOMIC(uint##tp##_t) *dst = (RTE_ATOMIC(uint##tp##_t) *) \
+		(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off); \
 	switch (ins->imm) { \
 	case BPF_ATOMIC_ADD: \
-		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
+		rte_atomic_fetch_add_explicit(dst, \
+			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
 		break; \
 	case BPF_ATOMIC_XCHG: \
-		(reg)[(ins)->src_reg] = rte_atomic##tp##_exchange((uint##tp##_t *) \
-			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
-			(reg)[(ins)->src_reg]); \
+		(reg)[(ins)->src_reg] = rte_atomic_exchange_explicit(dst, \
+			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
 		break; \
 	default: \
 		/* this should be caught by validator and never reach here */ \
-- 
2.53.0

