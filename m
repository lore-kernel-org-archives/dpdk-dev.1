Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F32CC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 127D540E11;
	Fri, 21 Aug 2026 21:29:55 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 2544D40685
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:53 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso1344206b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340592;
 x=1787945392; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zLAEd6Rg3iMRqPOIjbS0ze3Rhcny/PVxR3fx0hj6ZOM=;
 b=zkMPwoSaCVyDqKBMsXQxZy4meSDwVpnVJE7yVL2HU27WEuej57tBEOKsWzL553hpOr
 tl+e0GUzuHAyMcoDWIBiIaHCss4xWCPDcoI9dVL1tRoRpKRcXQnb7pX7yW3kL3umxzhc
 981Mh7/z9oJWxfruPNU6HEbLLVFtiF5CeX2e+DhCiZ53pbBYUZbOglkCLrur45waNLpp
 Exw7kA0Yp+8XeG+chA+AotSPn7bM2Y8KUgai5Zp1w4l49325mClHkj+CL0TvC3k+tfKw
 gY4Q6tHcqCbtlzSDYURSu1lqJ+UUx3KGY8r79bgWZsVDm3nDHTzf2+lTBNmwHVcMs3AP
 AMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340592; x=1787945392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zLAEd6Rg3iMRqPOIjbS0ze3Rhcny/PVxR3fx0hj6ZOM=;
 b=X94EvqU+8fb6Xx4qcjNHtURg1gCh+rlW19lREuCd4KlkAhyTHyo7ydQH02zP4mCDcR
 75mCHvyEufnEC1z9KEu420fGSOFNeZJutFA33GI6n7nvMS6EY5A4VSXIAnMmq/HVFJQc
 JYPG7AEuYM0kylAFo8TGCMQskAy1XvDeJi1IXrgCPOles39p6zVZHOzGNMiTbI5HyaL+
 gXB0iud1NuekbM89/B+ntN/jYPCaLqBrjz3xgLH1sQlAeh7/FosAZc5Y5XtLJKL0vRZh
 8AbN3Z58WaRVcSkrUQ/e1KWIW21QWLum8npxDqfZ044lQJExNbX3/k199cHJ061pZLdR
 V6JQ==
X-Gm-Message-State: AFuF++lPUkwyk7buUS2l6J926vUUOJDKcB5uF0LAXPZfpwJZeyxbg8uc
 VUN4NC+X0J8zaeJRXHSC4imU0He4mWsI2QuGgUx9/4mozaf+0ViJmWj4eyJmfPAQas4aztojkX4
 EVvZpwEQ=
X-Gm-Gg: AR+sD13rm6+W8tdaaaF6guuu+JFv2HVbi9iiCASyu4zFh4jgv2lo/hA8NY86L4sbLem
 mG4fSUqoyI6c2gXnbWo1XWaH+SyLgSmChTvzRClLqL4+g/aYH/FsZEWkiYFp0FuoriIJIfz4vBU
 bQxsLj2n+nF8U3GIsRET2YnJRjj/HefNBZ2sfYiYlDh8V/++E00Ohg+b4jMznUJAckICLJvwJck
 2jEnK2rgq+Y4XUp2bqmARnDgGmm0ySuPIuKsujxPsyOyvhwBPcIfdQdoAJ/hmjR2WIwu5Tg3BBy
 FP4LyIfBJBLnkZfKKTmkZIsjlp/RyEjW6wALjHns1ajGYM5fb1oOcdQrizcyLA6qsx7CxDk+yl0
 ifKiVUQY9QYSUyri14gFPm8wNFLr2LFhGJK5iCyOJZiDHW0HOkhb2oCdTJ/ktMgJFoQJ39+yBlv
 rcbd11iAtxMQNpoW3lz+5VIM/euo11+CtQePaTaO9WWANZgYgR39Z7Kc89yR3WCGU8SyVIT0JzA
 4i23ARh/hledsQdwa/jsciKbIONf3dpBQ2Bgg==
X-Received: by 2002:a05:6a00:1884:b0:852:2ef:c05c with SMTP id
 d2e1a72fcca58-8520beb3763mr1176153b3a.17.1787340592204; 
 Fri, 21 Aug 2026 12:29:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 32/68] net/dpaa2: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:27 -0700
Message-ID: <20260821192646.146382-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c |  1 -
 drivers/net/dpaa2/dpaa2_ethdev.c       |  1 -
 drivers/net/dpaa2/dpaa2_mux.c          | 36 +++++++++++++-------------
 drivers/net/dpaa2/dpaa2_recycle.c      |  1 -
 drivers/net/dpaa2/dpaa2_rxtx.c         |  1 -
 drivers/net/dpaa2/dpaa2_sparser.c      |  1 -
 drivers/net/dpaa2/dpaa2_tm.c           |  2 +-
 7 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 26ad105c73..33b20c35f7 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -12,7 +12,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f211357919..d6786b5cb0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -12,7 +12,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 7b7bf4161c..19b9388d41 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -151,12 +151,12 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
 			spec = pattern[loop].spec;
 			mask = pattern[loop].mask;
-			rte_memcpy(&key_va[key_size],
-				&spec->hdr.next_proto_id, sizeof(uint8_t));
+			memcpy(&key_va[key_size], &spec->hdr.next_proto_id,
+			       sizeof(uint8_t));
 			if (mask) {
-				rte_memcpy(&mask_va[key_size],
-					&mask->hdr.next_proto_id,
-					sizeof(uint8_t));
+				memcpy(&mask_va[key_size],
+				       &mask->hdr.next_proto_id,
+				       sizeof(uint8_t));
 			} else {
 				mask_va[key_size] = 0xff;
 			}
@@ -179,11 +179,11 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
 			spec = pattern[loop].spec;
 			mask = pattern[loop].mask;
-			rte_memcpy(&key_va[key_size],
-				&spec->tci, sizeof(uint16_t));
+			memcpy(&key_va[key_size], &spec->tci,
+			       sizeof(uint16_t));
 			if (mask) {
-				rte_memcpy(&mask_va[key_size],
-					&mask->tci, sizeof(uint16_t));
+				memcpy(&mask_va[key_size], &mask->tci,
+				       sizeof(uint16_t));
 			} else {
 				memset(&mask_va[key_size], 0xff,
 					sizeof(rte_be16_t));
@@ -206,12 +206,12 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
 			spec = pattern[loop].spec;
 			mask = pattern[loop].mask;
-			rte_memcpy(&key_va[key_size],
-				&spec->hdr.dst_port, sizeof(rte_be16_t));
+			memcpy(&key_va[key_size], &spec->hdr.dst_port,
+			       sizeof(rte_be16_t));
 			if (mask) {
-				rte_memcpy(&mask_va[key_size],
-					&mask->hdr.dst_port,
-					sizeof(rte_be16_t));
+				memcpy(&mask_va[key_size],
+				       &mask->hdr.dst_port,
+				       sizeof(rte_be16_t));
 			} else {
 				memset(&mask_va[key_size], 0xff,
 					sizeof(rte_be16_t));
@@ -234,11 +234,11 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
 			spec = pattern[loop].spec;
 			mask = pattern[loop].mask;
-			rte_memcpy(&key_va[key_size],
-				&spec->type, sizeof(rte_be16_t));
+			memcpy(&key_va[key_size], &spec->type,
+			       sizeof(rte_be16_t));
 			if (mask) {
-				rte_memcpy(&mask_va[key_size],
-					&mask->type, sizeof(rte_be16_t));
+				memcpy(&mask_va[key_size], &mask->type,
+				       sizeof(rte_be16_t));
 			} else {
 				memset(&mask_va[key_size], 0xff,
 					sizeof(rte_be16_t));
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index f78d12362e..8dd10738ab 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -8,7 +8,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index c31d6556ad..baaaacc2e0 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -12,7 +12,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <dev_driver.h>
 #include <rte_hexdump.h>
diff --git a/drivers/net/dpaa2/dpaa2_sparser.c b/drivers/net/dpaa2/dpaa2_sparser.c
index 6c3e6eb573..60dadb4776 100644
--- a/drivers/net/dpaa2/dpaa2_sparser.c
+++ b/drivers/net/dpaa2/dpaa2_sparser.c
@@ -5,7 +5,6 @@
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <dev_driver.h>
 
diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index 36e815c356..497cd2dc84 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -324,7 +324,7 @@ dpaa2_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 					 NULL, NULL);
 
 	profile->id = shaper_profile_id;
-	rte_memcpy(&profile->params, params, sizeof(profile->params));
+	memcpy(&profile->params, params, sizeof(profile->params));
 
 	LIST_INSERT_HEAD(&priv->shaper_profiles, profile, next);
 
-- 
2.53.0

