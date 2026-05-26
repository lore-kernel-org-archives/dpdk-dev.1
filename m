Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F106CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D2F540B9F;
	Wed, 27 May 2026 01:26:13 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id F367740615
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:05 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2f00a567cfaso6506776eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837965;
 x=1780442765; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EpAP3r7uuhgErGGHDwFgaIcsxdj0zwEzi5O7EhDhHs=;
 b=Z1PDCAQk1oR+1oaTk/637ztHMP8OBlCXvX6jSBQQtYGdiRjmjoj/lBf4YjM1LCIDBm
 yrQ4fUCnJCF19jQtRQOjFsfNBG1gL7Cfkzc+Zoi4S1kXaaFlkdc9IjB5cyxc1+k0kMkf
 ngv41+8W5g5dIja4CzyN0SDLJrlsGKBZgZ5a8eTbFR2pU32DKBZKXajbAj9/YnYhM7Gb
 KiXmW2NoZVpRJuxnAYQ7YPePuhJoJp3qs/onIFjHKPz0ApsUN6aqxXq4I03mRgITqZ9m
 f52m3J2mY4Cu7CKj/IpXFItIS8tcRUYIeZsge1dSWgy5/3ABJ5B4FNGbSg/ieuaqUeMe
 vC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837965; x=1780442765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EpAP3r7uuhgErGGHDwFgaIcsxdj0zwEzi5O7EhDhHs=;
 b=WY0jPyszqtK7AY/eY5DFt2cuRAhCUOxhcifAJxqb0t2XFi3616XKXwXt/R5u+LjR4/
 LneTHr25tud3h6bJz1M+kIwRq+YIfr/yX5K0mO8oy4maXtCvcbjNG6UTYs3xG0R3Alr9
 CSnAFgbeQvVEjpeiFYMEbgWwWlLPhWNFXg/N5B9n4HnGTHhm5pyqFxEm+/JLGbxZclwh
 AgfyLS6c8ZE8ZTfplY2p0ZtH1Km5dJHSmr2AXiV5z0SWaD9H+4ZerkpZQIrP7TDnIh7/
 OezeMBcTFF43RoxbdaMoBLxa6jyYa6nEc70gyPNSeeZ1iDwG7CI0LYEdeCJ0nv54KiUO
 ElPA==
X-Gm-Message-State: AOJu0YykLMCmlXmSScdYlDZR6WUw/z7qtG5Hzw8cNAtKBylZEY2IwzGK
 7DUj42iSjj6TSpBsZpYbs3nSxfKVvuyrmlsMklEKL5zWbI+6UGEIZnF7f3zHua+t1hndRcMSyly
 r1PWx
X-Gm-Gg: Acq92OGMBo1o1IeXVuYNU+idQb/vdYrBW7Ceh9s9hlyjPu+e25jxlIjhBqDZsERQxci
 iyeE5KcIMY0FAojhTSjHO8Xy7DxKgeRVvSjvGgHNMwkuYBi0EvyMUh2/vBXEuUPccINZ33GOmX1
 gHJgSZIHgZB2VB1U2gvduOI78MIn8Xy7uMzJZm4/llYQDAKx73NbvIkEnnswr9YuPgWhMdQcVoa
 x6tkMICD3sDQTf1Ugh2Lli57UkzvzwwIybzVV8f9+HubFKgaeuYHtR0f1XtctYYHMdEb8IXXSq9
 nNRIbId5nzsRUoGzoGGFZEz1hK5haZEejQ8lAuABBLZQWN7jmBk0iSyVIefsYwEv3s4ywJulGfT
 aPLX/hPQp8czNRz47gRSpMblzUBR0Y7NYudBqS6zHbhbBZyYAZEnCu6sXlEAFzYfWqKcbLrK1fv
 FKVroM5po6yJFhPs7soteEQPWbSTQcw7567gYVUc2MKz4fTlQUY3Uq0QUZKgnwdw==
X-Received: by 2002:a05:7300:a987:b0:304:9efb:c56d with SMTP id
 5a478bee46e88-3049efbca93mr2475035eec.18.1779837965029; 
 Tue, 26 May 2026 16:26:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 18/27] common/dpaax: use stdatomic instead of rte_atomic
Date: Tue, 26 May 2026 16:24:08 -0700
Message-ID: <20260526232542.620966-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

