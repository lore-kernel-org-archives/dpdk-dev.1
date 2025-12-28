Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897CE784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5367940689;
	Sun, 28 Dec 2025 21:19:51 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 3537E40656
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:46 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so50754035e9.0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953186;
 x=1767557986; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=WlQT8WYMBQcSRMvJMFCPVSu0JFSVflYfPgQcO1O4AMP5Nu2lfXaDpgGNXIu5KfZZam
 rtisEvTIQmd6+HmBAdtP2cNOlBxt05gstWBEUZfCkENxoZqN746kdgkA3B405cHp0627
 xSRc6pXYNq/NwVDMOAXqJbfKSgcveXkdRqBaoT4p9m1AVEUdS9+oM7aJ988ZAg7rgv7x
 Ps96TJFz2jm80seGKdCqvIu9Nz2vS5tJdYwgB0WjLjUfVeZZnitm0Px4gSocDdFX2xSI
 L/hxwY3TcB+FcludgoOcsROCP4B82WlCaiY89XGEoNBbiW9gmb1wR7GoJ81jeUYgbjRO
 KMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953186; x=1767557986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PnyqqAR4lxNz2L/jcPUa3d1OVH/z/Sw4mH+pS117ZWk=;
 b=HHBibq9q+x5zoq4L5ECIMN3dA7uPFrDqtw8+IkTn86FZGhpJknh9PGC09l6qVfg9KF
 eP+iWrGKVTwZ01bx4LGEVYdHF2JFg4bJIHCmm2ZbIhmcblvi+zp7PMUsZ5N5uecfO/Ux
 07581pkXOPTmF0iSKdveFswA0Mi4yYnN38rhnxZYWcJhxnh63S4GuVr3N4eBbmx5deuK
 Ul+Qmw8/TyYNu+FfxEClLrtk3v+JYfqBSVxrWiD8PdjXAwFphSG5dyLbCnWlenmR4y20
 5qkSlArHxfOjWEBSGK6N47L68Xq3boItaP7tEtR/WEiCFA5OfYyUNFcBhkkVFYX7EGh1
 dCrQ==
X-Gm-Message-State: AOJu0YycWfr87/YkdW07F60fbR7xLlTqCpM8i7jwn2c+ewdqvkp/OU5e
 +eODcta6YS+zgzEleyS4nwzjL6hD8z7Dqdslz7vqrbgGB8BbIB/f0mq1Rrq8uJeCCn0FvuYBqcF
 +doaruM0=
X-Gm-Gg: AY/fxX5muiDmpAQx+oyJdlpVPSjPQ48B5ENFddAtfqsSrb4YraVVXVXrWScI181oPFD
 ygsJelfNvqB8fehuIuBA4RbihkNgCXgJ5luf8zkkPN7cTMuto7VMQi6wB4Yn2rSeH+KOBfJHg2m
 Un6Ew0KQuzaC7Yq0Bi48mv0Ln1faM//KD/JWb48q4C1GwUguzmtYLTeDap4QHlWJpwLhBKk20qp
 IAQjBNv/hioyL0vH0dPrp5j3ifSIKYnQiMM/hSlzTRiIthUj9RTwrvNHB1Xwg8X/t0OlhsNAnS4
 iln7BDoBPfcYmx2wveY+i1cRFDJvifj4ulClws2w8ph9IrLkv3Fsnpn+A0EYRVaPN+An6kHEjPm
 5j6lbmy7tTga1gWRgFSgkMlBdKcpGMXm56VpkKd2w9ZSqr1OydZabBwZTs9B7mz95SV2Sj/sXSW
 xKahZmMW+aDOfNqKYyd4VlIze8nNyNSyfsxK1sb1cnRWGPMRW0+A==
X-Google-Smtp-Source: AGHT+IGvHXlq7jlLgbOKuqN/lWiPHs7Afi0JQXXdXuG+1tQ7A8qEtDgw1ego3wQyVGKpvUBOC62K9w==
X-Received: by 2002:a05:600c:c494:b0:47b:d914:98a7 with SMTP id
 5b1f17b1804b1-47d19582a05mr290489415e9.29.1766953185801; 
 Sun, 28 Dec 2025 12:19:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v8 08/18] eal: warn if thread name is truncated
Date: Sun, 28 Dec 2025 10:56:11 -0800
Message-ID: <20251228201236.547268-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

