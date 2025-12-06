Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F1D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78C3040612;
	Sat,  6 Dec 2025 19:44:31 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 3BE7D40656
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:30 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42e2e40582eso1849662f8f.1
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046670;
 x=1765651470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q88+kkSV/CHQib2wj7w0JeEYiilz9l/ewWww5mqHlHI=;
 b=iL1dNq2eG9Wa7HUVH87RNGrWksM22+6fpoJU/eR8jUQMGNbY3qhA7YJRqC7MLI9wcJ
 aj0xBGmo4e5h9bvaC4Jnts5AJCJNAOyrC5pD8zHcu13RNfojVbZMoUN8Gsxq7T7XjnxZ
 cCnmvD0kzvCWQArIcr9YAmwXNCbwzPn8ArHDYqSu44zpZd64mis6S5tJuXFL22df+X8a
 VPu+5LkIDk28owp0WC3mHSZeLSwFBbl3dJfftKiKG07pER91Ays5JQHEWPn/8GZrjuJ0
 5wLBaz9xNDSZjhMSV3orMVM8MRq9Nxwo/SrC9gV1oGT0ZCWNP4ZxxYESLKQkGF41vuhA
 HIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046670; x=1765651470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q88+kkSV/CHQib2wj7w0JeEYiilz9l/ewWww5mqHlHI=;
 b=GlRpfrHs6AcO6VUWbffQenhTAKCbFhc3byfue/sWxEzGN8oL4i9uIypDLmi+poU/dV
 tQd9C+BawdzHUVsAzchkeb5Z8GUneygpvxsVWfQw/jFZDsTHTLVLz/RCzXuMuO0dEzWI
 YTPq8+j8Gj0jGK+qdf0WGu3Lsen69DAy1DQZwdNZSmtmeaoAr/srYEuXJmw3sunXNwft
 Zx/5m16GaM4cjvfpwL2TFQc+3KmkwOVVvNFhEI3PE4yac0Kd/zX0Fg+NEeW5fNK2QGOv
 PrbVqBQOZsmEgE95+LunTd95ZEX6Wo6LkGz+OTsHi1uFUVBvGes3TgWpaNMZfvpaTRmF
 rc/w==
X-Gm-Message-State: AOJu0YwjVn1pjjie9fA6/lJCcZSwsi3QFGFJl1QjkYnryr54zQQ3FcTb
 CAgMddhXTsecvazVbmVviNf86QkCEvqVLbVBlR1GMyM1owfviaKi6kw5Akkds1DG+m7VRGIdcxM
 G4OHa
X-Gm-Gg: ASbGncuqZgITtmRJs80VFQqAVBcWSYKjW4SzjoJyNuzhKCN3OBJnLCLR9x5P1yB2R0O
 JyBnMZaXA6Eq3NpZicHp57eBIe6ggoofD/Wm9xNsrTbm8dG/CEvZvEiw7uOTsSVqzFeIvMJL0Te
 iODfUsedt5ef7ntDuNssKlsmdRCdVIKNHeSuOY3ZdtYgcLaYI2xj6VDWnsBHZI1CasWBD4/AP/Y
 xCHZVsKpBBS6nm+SmUS/uGZI/4gUW4nzNa/kRuPA74g1FXDDV4NJIU2DfrO33ewgEXoEipl/MTz
 APGfROYMBHYerpuOgZq9UZrrE42S4pGYwmvke1HzHguPS1bC4F1rkGtRILmdk7UFnOspxvgMTY9
 8iSVofnWtZ+cuU8tZ8LZU9qQkuF89nOGm7HvR4TiUuQLZeeSwv5sx2qTs2zJRyzgfhOaltLrUho
 988JVyA9jNgn9P/BHMXdbT122FXe5wmyibyUnrQglaL59rsETk7A==
X-Google-Smtp-Source: AGHT+IFMPQsb3UR6Kknx+22n4yCHv6URLlO57WbzxZdy8UlVuxluYskOtLev5OlJW6W2uTZ16D4ZZw==
X-Received: by 2002:a05:6000:402a:b0:425:73c9:7159 with SMTP id
 ffacd0b85a97d-42f89f3d6c0mr3004700f8f.33.1765046669759; 
 Sat, 06 Dec 2025 10:44:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v4 07/16] eal: warn if thread name is truncated
Date: Sat,  6 Dec 2025 10:43:08 -0800
Message-ID: <20251206184410.542725-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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
index 6215245ad5..9265aaaf5e 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= sizeof(thread_name))
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

