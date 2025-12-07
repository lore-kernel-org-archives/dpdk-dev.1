Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C469D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E059D40649;
	Sun,  7 Dec 2025 20:13:06 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 0C66740649
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:04 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so24241725e9.1
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134784;
 x=1765739584; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=0lXLUsSnTbu0FyddecLx+tGh019ScICiwYBTOoCmPX/4KWDDtfM2gPrmwfAAQnqnNU
 V8H7k6X8nIxUjg31MFplDgh/GkA+UQAGy6SQlB0EfUlWPypGsc6w5znzgrAJlYkU8Vuw
 TZLaNlYTwB6NeCy3is27HUKWBMtOBv6FPFDZm0gdEn5IVjJzu8kH7h7CwN6j5Q2pV1HE
 bRpkR+NC4d1nWfXx3eevFTTn92erg/O/p4tALBdsHf6FWtVVwfvEdFDtmrmfclMDI5Xy
 JhLEEZv02KT4EOX9KME8p3O2wD/7HXD1xRkdATBf6sgkcYX53acr0uvD00lAAcxTHaJr
 wJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134784; x=1765739584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=LbCeHYD4bW2qtEh2UI12waRp2pKPweqA2Z4NincGc5gXQs5o+nhON3W1PniJ+07tHi
 Omi1mZYrSsdWZrA9SwbdwWjXxsUMJZvsySgf2DvFqhwaKizV98xhQ7xusOQm4zQQpJ2L
 hgnR/IC81pJG9rizilbmdHLy6nvF82lM227QqY2GKwY09ze02M3V7Wn3J4jvjw2wgMoG
 xk1dvuMhEWLX+0v2t//XuZ4VJkAp6sbr6La2JaJhvctsfopO8PQkY2BF/IcArW4JX2hp
 KOg3rlsQRl5LQoGOFOovYxyrTVE/MneoTIK5BDhxhClE0XWrCXaxd8WaHTjOWE//bz76
 T7WQ==
X-Gm-Message-State: AOJu0YzqaoBH6TjrSDabdfn+lfO+nrsjxplRxsRs4e1rnde6VgsK1QF4
 DVfzCMwXucjgbA2IABGmAMsnOOBRuI2x4VIhtdGcYlTzEYL0miPgPoFN8/SRE9umJc0Tq05s/2R
 8AKh7
X-Gm-Gg: ASbGnctkjFm0ZUVcKHJEQoRmhigJVN2RC9PSbqPEWxPiCgwvBmC3o56QhM0/pNBS0PI
 mrVVSNLYL72wkNJsFpb8hhOl2eVqsL0GV8MxrzpwiyGEjn8BMr+LpMODiwqUN6Rmpd6pSIDQpsC
 BZyH668zGQ1QyWtWYiu8cKe3V/vGHGtr35tp+pshJn/OAOFSYwKTLATQ+OLil+flQfFvWVi63v8
 IZa6Kjg3ioSj/Fp6UrGD7+n9b0Rgj8njX11W+uqEM9muKtJ9E6mk4RF/adaKx4YONP8gytOboTV
 l+kCY87RjFt0iAfuTtMPdEl8frFI6C9c5hzrzf9K5Teq3NQcZll0SF+LwEXcwGtGAVvlWFx52DB
 qSidSXvs+7/bGX5W9Bj3MzYCO8LDvak30GyJI9PecZoCQdWueL+S5qAo4XfsRwDLTiZbAkp9Nn1
 sZf6SEONBZf5LeZdAil1KGyB0N7MB+Tc5ZImjUEOqHCG0Hy5fX0Q==
X-Google-Smtp-Source: AGHT+IEF1l2VBtO1FEiHEVROSDCELOvWsznCkHqpGuK1tRbmkFFg1/puB6aVsajloeKr4TfS3NJWaQ==
X-Received: by 2002:a05:600c:3588:b0:479:1348:c61e with SMTP id
 5b1f17b1804b1-47939e1f683mr64247385e9.20.1765134783617; 
 Sun, 07 Dec 2025 11:13:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v5 08/17] eal: warn if thread name is truncated
Date: Sun,  7 Dec 2025 11:11:59 -0800
Message-ID: <20251207191242.165619-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/freebsd/eal.c | 6 ++++--
 lib/eal/linux/eal.c   | 6 ++++--
 lib/eal/windows/eal.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..beda7e0c5c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..8b539f8601 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= (int)sizeof(thread_name))
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

