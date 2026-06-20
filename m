Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F88CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC99740E20;
	Sat, 20 Jun 2026 04:32:04 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 83679406BC
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:02 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-80236b44a1dso5824377b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922722;
 x=1782527522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=IZh+SKPh33j22CbmFrgcclR1OTgjzsY3qofQqYpZzsxkflggj27h5pcte7v4uHnqkf
 Y5sYgHgw4+yLWEsI/xAt7+x2ssmkkC3oUQxQaT91pvPeFIhj3jpCwlogf2VD+SUMIH0n
 RUo9EZ/4nJtc2bJZpbgFCf02QnKsm+wdl1kT6tNOEI0m8FMUpi0qrcCo0EKFK/fs2WSm
 NNzrud3yZZG/sDfxd3OVveO5kh6cj2DDOpoHJm+65euwuGwN2dNk+4GvGcJ93NpDBV+1
 1TtfHlJLkleHcDs8i9JA01MZz++YWc4um2hhsmNp7wg2315N6zgFwy1CcUpaIM1zdjDg
 gAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922722; x=1782527522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=AbY+mGVvHzrHMpBtDO15z0UcRUstnxMntr2N6Wdrdb3Gf9qqQVUXYo5K1mmaJMoUvN
 QL8WQPnxjaYJI9W5RuakrwfBg+FLzMTokrfwZGACbDoM/Evp+hIAfxDG0rPrCk9akaAh
 0eTkEECE3015MUVDHyJT7FkRzQ8OOAyhSg4nF4R22N9SzaQLKDYsl6N/VLYbBOqHB2kk
 geyyTEcI+NFswQWRmaGzBafRHvBamrHdVn1SD1L1odUwNOIednhhg52EzVDaJMRgIS6R
 679Daf97frt3rB5ZcttR8zRaEh0CGpo5MQ2EYKZOA3Ft5v0iISRJMU79BTg+oxjDwr7f
 5TXQ==
X-Gm-Message-State: AOJu0YxGPDFXquh8x4PucqZXv24boGIT0mktl6ZfshRd9oN5RaSBXTbN
 9r2DR3Cmw4MrjS3q9bBGBji8enrG4MVl3tustj7lM6/HHZ8LlvtOgeFcBCwIHk3KtG5iX7nbw0r
 s1rtU
X-Gm-Gg: AfdE7clRoDlTqQvJuzzxx8z9ru39ADJv7aqGlwIp63hmeEU0j1Ln4Ojvd48olqW4/JR
 ii3O+vEiX0Jtf82LGjCFFh8fkO1wL8d4Qe6kjGW0P/deLmbhq6BW4ckUKztwddZLsb9IfUSue0n
 iZxzX4s1/yQleSKonjeoBFLBXH2e5+Q5l4NZRqq+3hglrQjyYLOcCcZbBMuekL63t/EB2tHIp25
 6M0TimxhsssCvmvtOt39etMYs90/QiR8LNTPB21VqGaLBskPj0tSLOt3yPsCwHZ/BOZwCBH/EpC
 cEcRPuPHlOxvnM96enYUP0o5kg/7r7KAHUt0rDRfdguKc8vQrGC1NB+eT0VFJ7LOOAWFu8WHcdL
 +maJjo+tw/TuyVvxHCuoMuNdGSCyLMtWUlOJu4NrmuJiY4bxFLEt3jm2es3MzFTY0NK242Vkodo
 LS1Y6QT/gUHJV7udHj1ZncVJCpE6ghFUaVOTLn3+Dam85XgRhDkHk=
X-Received: by 2002:a05:690c:630e:b0:7f8:7e11:d024 with SMTP id
 00721157ae682-801349890b4mr56925537b3.50.1781922721839; 
 Fri, 19 Jun 2026 19:32:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v5 17/24] bus/fslmc: replace rte_atomic32 with stdatomic
Date: Fri, 19 Jun 2026 19:28:42 -0700
Message-ID: <20260620023134.42877-18-stephen@networkplumber.org>
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

