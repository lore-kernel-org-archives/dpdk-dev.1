Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F0CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 295984066C;
	Sat, 23 May 2026 22:06:04 +0200 (CEST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mails.dpdk.org (Postfix) with ESMTP id DDF8D402A2
 for <dev@dpdk.org>; Sat, 23 May 2026 22:06:02 +0200 (CEST)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-464bba3a9easo5351070b6e.0
 for <dev@dpdk.org>; Sat, 23 May 2026 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566762;
 x=1780171562; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=uU+9TKiT8wC7m+ab4quc05tnGPh6FFUSINVt3UsCLT08ut1UQvGXtC8mUJ4fS1Su/G
 ufNxxAcUB3jrr8fGj2BWwoB8Kk/X1ouxIP4uRkRnOIlI/x5LHV3237N12EeHPPps5boD
 49EK4/6XJHXlhDhSxF+ZOt85ok8EUVkd238K3MKbAPvxYGyWmAJ3ihdjvuPaZAn/g4oC
 BDAgebjECSubOyL9us4AConRg0B1NcRQehdA3C3yPQmvQJ4swtp87q+xRUQ8rExwOjH/
 tmrg8erpzWuznJaDcllPWc7se4GWTIRUOFmUvsFoAcZcVpvpFn1Re49wk6a9nNmSX8Yo
 nCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566762; x=1780171562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=nXcdFIGw4+Jel/g8dTFNkm/D0jBVIp5AjslbWuoXrgtW4FOQvwua7tcxYPtgYqyzQ0
 N8hToN5HCqWkzyqE7UUwX6HpBdgo50uYy7llMm32ac18sYQ9Uo9TOl8BkiD96mXh72IA
 gL3VriDUqQ33x+Xn5VNhwJXm4lkLZrMQvF72enKHvryp/mXBcU8s56d0d60jc6i7E7mQ
 VRcsGXid+6lJYILyCPXo+idAEy0N0syd6Z7flCx6hA6wWsX6iG/4III8F8jQlKdq18YA
 PVPGpcraTz5oNhfYynWyfZPTmWTmVHE1b2haWU0Kwc45+goowV3mu4MU+coouOfNe7jR
 iAYQ==
X-Gm-Message-State: AOJu0YxnpmhsHdxbh40Xp7OlDrfracYzPPmxA4lJNeIbAuxFKx5Ge+z5
 HOSMALMx2MzM51MRyVa1NKDd38kMqKBm9/yv0iLIuQ5Uij0rdvf79ylv5O4dqQrZKsyC6AY9tKo
 c7vUj
X-Gm-Gg: Acq92OG8AI5qGiZ3sc+C0mqrAphRTOGxiVCrdRMxHxP4IrUmjTSAZGpb+1ORINQ4SmT
 mbPfDqtqp5GrbCwei6Tfln4RBl8O+mnH2dEjbkv7ih5Zs5qR6l5j0JFXZvTQbkqVuTPNCp+TugQ
 f7szUy8r8oe11lK3XUFuBqN0GOPi8mzlYA9e9kHUCuGn4E3Tpi1eEPjKr0fx+viEhwNrmD4/a2W
 IpdQhUVZcjcR7FOq+IUyNNRlgIClTrY4lCeVCD8YyXU88JHx3qxklN1YkRQFAACTn4IgXk7Nrq5
 xWy3qSQ/UcHQJQaKtpm5fQUziFz8lPRnBUvdbhywVQXMqoD1xqV+c5O5xQ4CkvcMed7f5U8Iyed
 asG+ZSTE9pBzDlzl/Gb+KipzQVTQZRPKJ80K6DpQpk3jtDdAEn5u1EBR5GGt8MPPcwCLBRZ4aHk
 4GYTrj/RjiQGW5IR7LBuaEu/IogodYGM8ndJ4pYy6vOfxiSoarZ94MVIeCnCdpSw==
X-Received: by 2002:a05:7301:6588:b0:2d3:2983:c87c with SMTP id
 5a478bee46e88-3044904e0a8mr4386955eec.1.1779566342460; 
 Sat, 23 May 2026 12:59:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 20/27] bus/fslmc: replace rte_atomic32 with stdatomic
Date: Sat, 23 May 2026 12:56:34 -0700
Message-ID: <20260523195839.454952-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

