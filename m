Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B542C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70E1542D78;
	Tue, 29 Sep 2026 16:04:16 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id CDC80400EF
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:13 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so2659664b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690653;
 x=1791295453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rCAJxMnNcwMiqieaXt26ZnDPldzzB6KxmuNcIKPYBA0=;
 b=L1dvvgnF7jCpqbWe+k3ChlE9/V3YdOqYwM2Y6YhGnX73bdLX3yFFAW7fnYir30rEZK
 K4sgJAzjs7vBztlUwKA6wLfbkM8o+sNLHpQ/ywZ81ZZoJfOtnXrHfp7E/jXMPYvBo82/
 SfiHOxxFBAwGVLIP1aipfgFIVR3c1myb/tep8elk92pnSxMjZa4InyaNWaH57qgC5Gvq
 riEQURBPn2tP6VLYx3sWuK4ylaeLSdL37cZHsWtMjU6DeCNWvNcVwAGNHDdrB/iVLVua
 cB07AVzqojWpnCuSm+3ECEAnEqtIdaonmMeH/yBAIGfmB1D7SjYQ3drZmAf7+neZ8/HT
 HNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690653; x=1791295453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rCAJxMnNcwMiqieaXt26ZnDPldzzB6KxmuNcIKPYBA0=;
 b=HmvuJetyeFwFonb4PGmviztxt/Hn5JvMANkIR48/5L+7OKSfXszLyPtFZCKmM4lTz5
 H9EthjxjEnfbpT393hBPNEIyWvsJeRSPdt8W1lwDTpnFqu+llvORQwSTcx7tccsIGggz
 O9AbDvdjbM/p/q/uM5oApWDAV7QPC1G9y3MMUWHCxHCw22ZggyAY/g2ReByR7YDkJCJd
 7HTQcH2v1GS+qwTp7KH9DjQ4vmywIXbnx4WBvt5rO7ofgr0odi9bHgiD8m6mmXptQYqx
 VeMcXV3HyyomZJ65mdu5QK1TL1gN6AlnfMpVUIdGv8+VXnLfJyyjRxu7/STZApzN25Oy
 PvmQ==
X-Gm-Message-State: AFuF++kqHHl9SMreUsV28tGAa+K5WTnFJtbdGDsX3RnExvsH3WE43T6B
 bpgEb8n0tuq3+0GKWr9D2tynthF4/HC0vijH8EUbHPcvyCjsCaRFcB3H6h/bt77mPWxAsEN90fe
 3ur/ZDok=
X-Gm-Gg: AYBFou31qb9mQJ0rp1Tmxk4oE5pNwFvqz/8w/o2bsRzihVWImRKZPhPHS7BNhBMO07+
 X/dxtkY3AF2CoUxzumxhXXB81p+/aRSO98x2axyi/iLfYd47bDsYHuFRh8Ad2qUOD3VkovaCHH1
 MRtPSgA3khNVEN3P/U6BQBiLBBQ/EG5F16XdSKpts61qZWrYSZdvTeYnIKUK0nedzg1ntqe/Nav
 S6kP4kBpf6LTJUBL5vUNwO7oe4rYJvdSlVpwAXcjdxdPW5fuqlVikrIPkOE/VCu0ts0FrI855Wu
 RdItIdmdwx/YQ/oOE7AexsobAB6q3OcIUyXbRwZ9G7TI++/2CObGfC0RY4CKz/z32PedHXh2y6P
 pyjqDdhL51DWZwkWOemKpBxq+cAQdHp8FApC98I/fXFUzLFrVj4EEmVyupaj1liLhm5VUOXE0Pd
 SBkIVQDhsPcYAL0Ib8wpEkaH/XNGpXhn4s5LEqaHCZurHzMQM3Ga+/P2qGQht4h0RdzUBEQCwOA
 kpw0elkyLzOYclXokd+dIMLlveSBjekYeQXX0aCDQmr/VzU
X-Received: by 2002:a05:6a00:ad6:b0:874:706d:8572 with SMTP id
 d2e1a72fcca58-87e9b3b9f3cmr12662988b3a.35.1790690652906; 
 Tue, 29 Sep 2026 07:04:12 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v9 01/25] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Date: Tue, 29 Sep 2026 07:01:47 -0700
Message-ID: <20260929140409.234453-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

