Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB69FC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B12E40697;
	Thu, 20 Aug 2026 07:24:39 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 22B2440DD2
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:38 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so1851505a12.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203477;
 x=1787808277; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+1L8n+fqHv93gTSX8lX4ri4MeBRLDxF888Ds3mn9fI=;
 b=D4ugUG50PfJmanZ9Sd6t0bQ1XHFbZsOUqcrkEm2/kWTwWhpcIBJUaJ+y/lvxmWpf11
 h3c3ngog/3lfJlYEjxCViDY6lWlX4/PFwHSVsgfKqU6FJVcF+tGC/qehRa/2ilA0jEji
 /5wktSOJkW0NZR/Pws7CMhxhhdD8iTx7sf0OiU1OVEH9Q3awNXUCFzUaHm+igAxlqACj
 2nHRbOaZ3i3xUGlPascGsZGOw1bInaADes1KgG4Pu0QMteS7wR7g+ISq2yWyICNoU+j7
 fUvis2rihKkL//Aw3jvtVL/Fy3LCWGdK6d40hOH4bi+suvgxRyizIR7eJa0lN5VsJ6WA
 +tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203477; x=1787808277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+1L8n+fqHv93gTSX8lX4ri4MeBRLDxF888Ds3mn9fI=;
 b=nc+VahFTPOeC1zmeVJH8V4zj1FCRhmjcdKDWizkh5k8oO23/4uB00i2FtN/TIaX6G2
 aUn8PcD9qHuejwC29wJnd38gYooxJpn1q81qidE0arr0a5Ao8YWaKtxbTYOOu9h2fvtJ
 +Gi6nUdrrQt/+ZwC29wz7noNPjq6xci7+fvkyFr9Jy0bR0o2JNRsnLTvMfSBiYUYy+/k
 tQ0agDu11suR7yBF+6I/GsWDhMK1P5DTv9pUUzBbOt2+VaIfdVTwP/3oueordhMOwibs
 70r0nPvCjC0cBZugCP0ZL7A4cgw2Fka7916P6j/TS8yinqEgfR4EKjuosll6uGzz71Ax
 15WA==
X-Gm-Message-State: AOJu0YxrhbEHRYylBukshq2bbr/U9ZDS0cSttgmR+HPzYksJGghiUi9t
 Bs5qngh46NtclCdSnYyC80uqPIVs4WhYDivhsn9P/h5JdVJpmu6mSKNxWEhAeuTuodAqNY3Sv4s
 FaRe3
X-Gm-Gg: AR+sD11AJ8HFPbj1g3Q0j+/z4VsgjwLpIF118I7jHxOxFLzqKkT/Hrh3h++0fmfqtvP
 lvkf3ZzrP36XGxjbPNNIIa0e2YduAHI4lMRbQEk60KU8ipausAbKLqgbzv4UCduuTFFgekzQR15
 lYWSBt+z1SJsUhawJ5srZrCKN/G5+YwOv6WqtMc4Wi8mMHgaVGOyzfWKOmAMp4metFZGRDsQSCH
 dsNSUZeFSnCaYfqXKNYk/frnTwngrMaswjWi8hdJnl/VNyAHVsyR+NNNCdh0qz4EmfpC8iX5Iad
 Cv41R9UcRzBDt+Zz7uluwCzupymnidMvM/hb4w8eZMa6f0O+a3+RfExLK3mhGINtPYSYUtW9dZG
 EYEYS8FPCM50UBbvR/0AdL8iS98kVxDxmSvx6W2AyLPqjFzss4BhA2YiCkPa70NQOUJuxBUqxM2
 cYmZVTtjVou7ilBD0FARt5T4GpGKzezHLmT/ePZIUHoRvaQ9nPSTq1KL5Eeo27JjdVesJ99pYsr
 LnEaSWmYWUHFAKGbtuEU2YraJY=
X-Received: by 2002:a05:6a20:9148:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3cd00e823d7mr14760183637.9.1787203477185; 
 Wed, 19 Aug 2026 22:24:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 25/61] net/dpaa2: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:15 -0700
Message-ID: <20260820052251.1453273-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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
index 9bb1bbca38..a934390043 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -150,12 +150,12 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
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
@@ -178,11 +178,11 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
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
@@ -205,12 +205,12 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
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
@@ -233,11 +233,11 @@ rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 
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

