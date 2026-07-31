Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07E8C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 826A440E09;
	Fri, 31 Jul 2026 07:00:09 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 8DDB540DFB
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:08 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so492752a91.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474008;
 x=1786078808; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GEROxbuZQgjqdyXhxXT4csd5lpBVEU1BIcdyUP6h7Ps=;
 b=He6IeqOd8uzpEXpJRafOrYz8yFsmFt9GBbH4pew9JUy9A7Zn+ZRbxgyTpw/bbTt2Dj
 zptZapay3ux7LmhH+s5CnHZJhnS1lQZi0aRwR3XboFsgiOVDw7fgwTTA201umaz0FlAo
 XO9KL2LM049e69sVbGL/kDU0loUNlFXbn4o/qosVwKzuRmdNfzC9aoaG5OE0rog0aYiC
 5im3K26tPIvoycuTQXe3k2zmVsRSN8+//zLNk2gr372Y1BqeY/Uw7+/e2Tk0ze6bs30d
 rOqoJiiSza26TYDboNmhSgcdQap/PzwLSM4x967UCA+/EcoyW5Ebj3+sg9W9tnWe4zCI
 8MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474008; x=1786078808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GEROxbuZQgjqdyXhxXT4csd5lpBVEU1BIcdyUP6h7Ps=;
 b=ri6/BdhUV4Y+/OstjDDA5zv5iimtXLENMyds+deAEQ5rL5b/pPCmHaUFZNh58iGFRZ
 OATMrpHR/pH/3+Rhdw0vWwrOurslkZM0d0yd9GbHyFxGtKRlrqQ5s+ci19TrTPWTpXoc
 n2GdIdF28dESxI71Fz/OGMGebmvDSHTJpkDENsDu2LGYuhqVCYlYhmVOOsi503ngpqDQ
 xTnloX4FaaMoWfjyhdoFr5zKoWfQ2dvFnR8BpRpj87+U3sfoD2rwr6gKWZQ/23IpsYaW
 OlgNoopJiXzT7GtoedwLwCMohyqqAlDT1MRDYHaF7arOfVcbEXXSJgQ/PMGwWRTuJQOs
 GeBQ==
X-Gm-Message-State: AOJu0YxoCXRF1CnFpSwg47eZtAhR6mjQJEcyrMicai+/5wPo5UqnoC4O
 MgRy+s+ImmWrcMIp75PjRj8SITUJGyUt44zJNFMSZViy6WFHsw5xp/Ep1Oy68xYdYFrurnTwxN0
 1bcrj
X-Gm-Gg: AR+sD11xgJAprsFOHs2I8ZF3Go3iWIlnk+ld3PdjP+SSIB7ZfaNtD6fqYgzFBUe9N5f
 Py1LFbC5Nes3PtmqcYkw6FJPZt9R+jceH2uAREro2N/cGYq2ZI9ZcFnYq5ubqgYo6QhzyQRsJLe
 B+eotuhdn9gzf/tn19WrD7fJYDe144rTr4fi2nscjjIIZ7Z2ZtFnzjJLTOsfkPJIez7hy4HUHif
 w/fslCrhCpOSUL+et0Ub2IyYFlvKUUJMYK3Y0gUUf75frTwb2n1vvJL5kef4t/aXwDzSeqwTsCb
 Tm6oRI4CZzsPz2dCqkQ7BVunCeekgCqUEs+oixkgARK786Sgjgul7XrHsobRcOvWf3qzHdGkvtm
 lPXweOwrmtRaOUa7ki23PegQ8RKveOBjntlXOKgQ6kipg+zXadxCPvt0DBS8/hs5it6h5+ZE7qP
 +Iwx9hWTADLZfREyIatWWphMu+YLFs00H/K0pDue/qaWGI9Ua7jUodEoO1jQ//Wl6mc/e1kizxX
 jvZCN3udseBBtykhB+es3umvYA=
X-Received: by 2002:a17:90b:4c81:b0:38e:6ba9:5203 with SMTP id
 98e67ed59e1d1-38fb140d718mr569421a91.22.1785474007375; 
 Thu, 30 Jul 2026 22:00:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v6 15/24] common/dpaax: use stdatomic instead of rte_atomic
Date: Thu, 30 Jul 2026 21:57:53 -0700
Message-ID: <20260731045948.769926-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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
 drivers/common/dpaax/compat.h | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..3c229af9ef 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -365,19 +365,18 @@ static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
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
+#define atomic_inc(v)           ((void)rte_atomic_fetch_add_explicit((v), 1, \
+								     rte_memory_order_seq_cst))
+#define atomic_dec(v)           ((void)rte_atomic_fetch_sub_explicit((v), 1, \
+								     rte_memory_order_seq_cst))
+#define atomic_inc_and_test(v)  (rte_atomic_fetch_add_explicit((v), 1, \
+							       rte_memory_order_seq_cst) == 0)
+#define atomic_dec_and_test(v)  (rte_atomic_fetch_sub_explicit((v), 1, \
+							       rte_memory_order_seq_cst) == 0)
 
 /* Interface name len*/
 #define IF_NAME_MAX_LEN 16
-- 
2.53.0

