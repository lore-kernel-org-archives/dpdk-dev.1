Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA8CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D76B40DCD;
	Sat, 20 Jun 2026 04:32:03 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id E5C8840DFB
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:59 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7fe723ca5e5so29187327b3.2
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922719;
 x=1782527519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EpAP3r7uuhgErGGHDwFgaIcsxdj0zwEzi5O7EhDhHs=;
 b=XjNLipmU8GUzDvDNhp0r9VAma1tTSzKnsUXtDe1vaVrlPpRSe5bmXKzkDGhdncdJWq
 2GRzaWcunRNT42BZLbB0mC8GimbFJHuGQuV8b38m5ystJlob2IMlTDwO/3jAocoj45oM
 euNMfJovbVahszWOPDRLSY5CGNo9ih4Jy/talt84lKVzrjMHRAg4t5hGdGmM/n5/uMO2
 zgSIkMcZSzCG8TXMNbE6n1CSHRGHtTL4h+7JrpAXx7mE4jp66oJzLq/Z1Hn71P8boB+R
 eAP45DGExvSa/ii28ycrkOIsutZwNpGUV8ahf09N+ADnBoMniUUYTVqpOWYgt2M7+u+P
 mXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922719; x=1782527519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EpAP3r7uuhgErGGHDwFgaIcsxdj0zwEzi5O7EhDhHs=;
 b=FyEz8xAXpxwPpIQA2B/j33A1v8NzSP7piAtU2zlSKEflm0jEyywmBRvg+gsVvrNNRI
 7m6s0u/yj3W2to763F2Ux9P1q5mPM4AENv/LG8DTTMII8KCvWrObxMZVcRvKWZka7uU9
 PiOlUSkbaugHxFYIlxhGeMRj0o5NtTMIQMR7RyRiW21UNIs1hUpqwOuiY1Oe7xmTeUSn
 0V2KRM1mqQTKRHzLGeeD+Ghk24aME3Uq/lbJ3AnwL0foQBIiTKXaZ4kvybNBzxSKcxZI
 uqDxNAiL+MTTsawNDUJ+VzQh3aeTHyF13kLIp6uCnscP7I7s4M4L8fOnK0RMjUboUa1u
 8iXw==
X-Gm-Message-State: AOJu0YxbU5bGki422agLHb3yBahLycLAELQdb2pvQIVxCgVa1yOLwNk3
 z3EJNaAfDX7FjYhH/zM85mru5ZHEZYvU/E3o/X0048IT2eBeGf4gRbeUDUGwl8tQCUC7Rcx7Npb
 9YR6X
X-Gm-Gg: AfdE7cnH529gXGpchi0dOii55izLB1vsPFDPnz/B4yYYv8lV2u8a4AQbOQWBpY4nwpk
 F4+R1SFl9GQQacaBauUuhmtxHHbIq4dfwieeeOELixPijKEXNJIED3z1C4Ze+ReVrQXmnfBhTT5
 dXPD85R3Yb8BhF0yTsiGQXL581UOhLugbI2YbiDi1H0PsvrR+aFQa+sbI/4u9BC+qMlC4T1IYZu
 hohFH4b1cThRk5EcTaa11pStl0p128zDuPJY8OlfXG0aRoInobkv4p0aNxK2RRn57JR4oQm1xud
 cxWfafgN8aGOXX9QkygnlJZaBMBpcWiEenOlGANT4HMdNzc/EOu1g7ApPhb82AXGpS5F+SSP65B
 9DIpyJQsiHyweU3vvn1IFwGyzj15dZuFNty2eIlPyU23Ebj0hxF2PSiRVKgwBEfMiVMTJUe/1GE
 H8yk4fnSBZdMt54bwMZaI2N5R38Z9weKdfqhev9GR5Uy0onVH2zww=
X-Received: by 2002:a05:690c:9a87:b0:7fd:8249:f154 with SMTP id
 00721157ae682-8013340c0admr58467127b3.44.1781922719179; 
 Fri, 19 Jun 2026 19:31:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v5 15/24] common/dpaax: use stdatomic instead of rte_atomic
Date: Fri, 19 Jun 2026 19:28:40 -0700
Message-ID: <20260620023134.42877-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

The driver debug code uses local atomic wrappers;
convert them to DPDK rte_atomic wrappers for C11 stdatomic.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/dpaax/compat.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..793616e095 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -365,19 +365,14 @@ static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
 #define spin_lock_irqsave(x, f) spin_lock_irq(x)
 #define spin_unlock_irqrestore(x, f) spin_unlock_irq(x)
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
-
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
+typedef RTE_ATOMIC(uint32_t) atomic_t;
+
+#define atomic_read(v)          rte_atomic_load_explicit((v), rte_memory_order_relaxed)
+#define atomic_set(v, i)        rte_atomic_store_explicit((v), (i), rte_memory_order_relaxed)
+#define atomic_inc(v)           ((void)rte_atomic_fetch_add_explicit((v), 1, rte_memory_order_seq_cst))
+#define atomic_dec(v)           ((void)rte_atomic_fetch_sub_explicit((v), 1, rte_memory_order_seq_cst))
+#define atomic_inc_and_test(v)  (rte_atomic_fetch_add_explicit((v), 1, rte_memory_order_seq_cst) == -1)
+#define atomic_dec_and_test(v)  (rte_atomic_fetch_sub_explicit((v), 1, rte_memory_order_seq_cst) == 1)
 
 /* Interface name len*/
 #define IF_NAME_MAX_LEN 16
-- 
2.53.0

