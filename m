Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB918C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B8D340DD5;
	Fri, 31 Jul 2026 07:00:11 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id A139F40DF6
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:10 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so427658a12.2
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474010;
 x=1786078810; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=hAzxLMrlv+6u9d24tahtoCNntlwXrr0jMP2X04NUXYRqD+CJcKQVv0oj3c6hjziWeJ
 NFnUmqgd1h0X5SoyTPR/+4bs/nyCbKl2RWr1z12x//gM9JSDE0AH3K/hwN2SGjjrkZwl
 +0F1mC1KnI3gvuPnos+6H55XHtivaF3MvQOqZWuOfjUY7fjJlCFgVwtrELOLlDnltw7U
 +F1LQdWQ/I5K64ZOP5GIp8YehGUdS+mwXLHvsbq8koljxM6rp6h7lYE2TTaWQYafPg64
 pCxtBC66O+lmRhiqbZdhuTUAwxfCazfxRp15ZoYTWfgfjCZumgnDcIPUu/nYkYYcmtK0
 U1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474010; x=1786078810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=j04JR4wVblk7Il3db0WO0AyOe4S50BspJTQJpo04uNUTWPEbEX0tzlIM2JKzR+6DjX
 URNEOyK92HNrc6afr2orXaHixGSfqP5O4/NkUy39vL2bEKGSx6JBgBTfobZuQEgf9b/4
 f47bEuFXPM0v14Pu8rRHNnMcjqDySjNuPDXPFCmxRgTSPgytT544lfwUPPi5WMDqXyh7
 ihu9/A+cQ9xf3pUOLF2i9uKUBAUDM1KT6YLSly3vL6w0yVnGdaCUQgOFXoBY6pM7QfSg
 76nqWOOKq2I5W4ynuZE8JTq81rQFjggiIga6qJ163BIa093vxfN2AD0SLmbKaI8lrl3Q
 kv6Q==
X-Gm-Message-State: AOJu0YyvJ0vzeWK6OOM61LaXtzXaXdD7+SCpL/0y/w0BspYq5ZN6HCPh
 BJ4JIm1bbgmwvla4rID5TO4qNKeaGtFwLy/bqzhnN4011Psa7seGHQYQSLvG6g25kbbQqGgIaAG
 Onx1B
X-Gm-Gg: AR+sD12/HbQC/e7RnSEQAiMImgKseCiNfSJ2yB+40i0yG2OPNfTrQZQ3kvarjZrFlN1
 AeU1yWYzRH26rlOUwaB5WTcoeGQ2kdyPuZ1Ql8XsvUSFWU0y/ih97XL928lhkSi+Xgm9VkVUb9A
 jNJ71pbGmUQ+3sNXZMZ6I36bBjIEoXtCscTCJTebeh5J27yKsPrKkmP+LJy1uEEnXmJliQHyfAp
 lc6ixqwFjQ0uUL+MsdFefgK1KmmYq0sqUKgkdFzahdnIi1tIz0UgSov8ojFXlt6Cgm1N6c6Nzug
 ndzaVibUo6JYikO/sjU7FVKWr2B9Fbv14VxLgYi4q74VbqOBmc8hmiauxi04iZIHz00e+NAM8Jg
 t/mCpEwW6hi3+AnVyLcnAK4DNfycATV/QuOsPF4kQfPRjdXNFKhRYYGvrsxBLMPKUJr67ddtTRh
 GFn3eCxiOOMdYpfa4HtGTl62KyP6QBA//8pAbr/VKh9bt4+Ws6trYFcPohCV/oIJnkIF+N8KzIh
 87U/5MpC5FYsEbeo7XdKNAPTb4=
X-Received: by 2002:a05:6a20:72a8:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3c91b1fa5ccmr485937637.33.1785474009705; 
 Thu, 30 Jul 2026 22:00:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v6 17/24] bus/fslmc: replace rte_atomic32 with stdatomic
Date: Thu, 30 Jul 2026 21:57:55 -0700
Message-ID: <20260731045948.769926-18-stephen@networkplumber.org>
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

The atomic wrappers here are easily converted to stdatomic.
Drop any unused macros.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/qbman/include/compat.h | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/fslmc/qbman/include/compat.h b/drivers/bus/fslmc/qbman/include/compat.h
index 5a57bd8ed1..9c87f0b639 100644
--- a/drivers/bus/fslmc/qbman/include/compat.h
+++ b/drivers/bus/fslmc/qbman/include/compat.h
@@ -81,18 +81,13 @@ do { \
 
 #define dma_wmb()		rte_io_wmb()
 
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
 
 #endif /* HEADER_COMPAT_H */
-- 
2.53.0

