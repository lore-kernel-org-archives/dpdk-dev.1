Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E2CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A24040BA5;
	Wed, 27 May 2026 01:26:15 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 2F16140A80
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:08 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-303dbfbec77so13254733eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837967;
 x=1780442767; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=gf8BdnHjQr5CMxN3KwzfJuUX6bxHnjAxoK+OhqrlqA9/c3m7qbsqekN07dkbMm1aVx
 raIV4/ywE+1LqH8sEcFS0Ja7eNI/BXijsujMxyRZ4a5CjYOTNXOgupR1h6HfMyFTdVm3
 ZdcX0+bfdx+xRhXrmO1TlnmCIs+eNWWlzyRC673KdV4qV9UeyKZa/gGlA+VXr4RuE8gL
 doFtrxYq7GmDZfV+yCOttPoKZa0X+2g3cXmOyds4Pl3+QDKXDBchi+12QBMQ2jHW0Xhx
 Rd3q9L1fBLE+1yio3XJssIKuN0G5k6yUODc2KROLin67gP1BOj/ONBZNzUfUfJt/vc7h
 /5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837967; x=1780442767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WW0+Y/b0yuU+7sTDh0ZxVsDIKC2rRrTjl7mblLmCB6A=;
 b=fwgRmf3EK3q7SI93wywu9gdAWcDs+obdp2u1y0xa6HbQB5zLPcIqRBYW03smH8THmV
 pcuPetpxEXjYSmQqhpm+qxbyQJbWxhXaMdNTbXy9vLnT9tgl/1FP6r2gVeBI5VigWW2a
 oO68VQY4ptkzJoWlgeykcR0b0fSIQIqrs79N4G+K4JeIzbvOwbmqp33ta4CE7HT+t/Pa
 Qqkwy6d0/pxMXKp51qFfIKK0a349qLLYVglJTOI3FBM0W2qtJ/aP83Y8TQaO9a5sfnZq
 uKX+HusiQzi/C0HEW2gfrTlWheV8f100aX2n1Zsov2SOSJ1+rSt9cHm5zvOofgn1z6QD
 A8nQ==
X-Gm-Message-State: AOJu0YwW/bxRJ8RJqUq/aYl/p/U1Cx45o1SjNdfw1pM1GMzDb1Ys4A7b
 RS6+5j5UY2Qfjk/j8wZ9/F/R4Koyx0tJ7qqdw2717YxEjMn2wx2Ucre3TR/EgaGdWx8BZPHb4lc
 nFS1D
X-Gm-Gg: Acq92OGxPomnyeET0orhqLUioYKTLCwshnuaItb16yfcJl4JHrdeL8eFK42PTML9i6p
 UwBqAkZhCdxS2zVj2Ju8zgksb8d/hOEHr7w1J+27LefTf451hcQghF6bb4dLA8hxpf8Nh6a1QZt
 KjN8kiwrkA2z3XOWDEeMzOqccI6BflUc4fquXmFpm4OYGSr22ajHfuR+BCcaf0Y33A0d6oD+js/
 WvPUVrHSfxOlCc0HnHLHmUUQIN8CF5jqalumLCR3sRP7ez/HHOpCvDESAV9Xes37Dc8JgZLwf4g
 +JIENL7xxHCSJeC7rwepdf3Nk/ij0H/fNQfy+dBSvg7ShF7hC4550BnAlgDteLASpczi4ye2QAf
 9GFsxvjvWlECoha16jxXDvxklJhpyRvAhefQIcLkcvNrc9yKRe5NawR8SaayLZjCoM2AjiRoTOF
 P16M9yWh+YjldZZvThA/62gCiltiUhU3II8Tks+Q46VLrb5jNGCKOuoEoM1LKuHA==
X-Received: by 2002:a05:7300:f191:b0:2ef:83d4:647f with SMTP id
 5a478bee46e88-30449094103mr9057972eec.25.1779837967164; 
 Tue, 26 May 2026 16:26:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 20/27] bus/fslmc: replace rte_atomic32 with stdatomic
Date: Tue, 26 May 2026 16:24:10 -0700
Message-ID: <20260526232542.620966-21-stephen@networkplumber.org>
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

