Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09446D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A01F406BC;
	Tue, 13 Jan 2026 21:23:52 +0100 (CET)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50]) by mails.dpdk.org (Postfix) with ESMTP id 49EC9406B8
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:50 +0100 (CET)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b83122f9d78so1263092166b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335830;
 x=1768940630; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=oOPVlvzta0wDjBpm+nXEWQK/VeAKISxjPldZgiGNTVHtWXCo7Sc/Bbv/TaygfR2hUM
 HEfi9bNstbkLNKs8W9DLGaJPzGzr47DHdH5EoJqkI82vIz6t567V8ynCpeyQ2T8oTBbG
 Ksa+3/uqlsdDbJ0p6vVcKHBxdb8REmISF+BJN2qQlqYba3Vid5qi4FXWWxcceiJKaw/j
 OShYoMk+ssmAtDRewxNVtk62oBP72W0JiBGxPEqepG+VpZvg93ha6LwT4b1A9vypLEBO
 q0pmmUUUmedZK6PLBxV929FHsj13D2lu9j6q2veutA82RoUePkxr1yePLvlck5Nn4Q1+
 9WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335830; x=1768940630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kqCFItk0itE0KpgFMM192XBzrhr28QRY35s8pDKsiw=;
 b=EbOYsGZ5lqkKVbuzKHRkJStHXY8oSDiLBmbExBXOEk/Q6oKKHXoCyurns+G51YBM38
 ng8vgJ8eapju9wzaxYMRtLAWs0WQYVW6wqyj+NL4UWjUyaJciW+pkL/xkA1DUe20l3Kl
 ZrnYNiuVRKg3V6JnOaujEwV9mWUvekVDU7rhXe9UbEMAB30X6GBE3azbTTtbjLtIH57x
 WyPbL6eFB+GVZSBxn5GctWlV6kHV2U3QJ03y5QHXL6KfAnDMcM+czNUJ6PU37syLGoW1
 W7+9w9z2IhtVuUAxQmw7YBLZXKqzJIKxnFrK9Il8y/FtNEBSMi5/u2mrk+SvCGS0lZ4c
 mm3w==
X-Gm-Message-State: AOJu0YxfnYs4ExxlUsyUrmXWSEMKzT1olmiY+CeuGgMVLlFgXWUeV+Pb
 iqLTbO2QmmqaJrj1eC8UgoPOzZZWPzw3k8K6TSglSIS8hai2lrbvviLMxFyQ1ONUhp1HcgmH3Mf
 R2+wp
X-Gm-Gg: AY/fxX7zN8srdOIrxIrQOWPYLGjDo+J2XhF0lcy9DfTVnLnm/Iv1hQBnUBNjzgNeCrA
 aQxJRt1qM++liJZBASMQ5kDsCaQU40a9+xkJOuxoTvSERiuBGbBLuraoTW5EI4tHkLpoXSpD3CS
 UQnGl3yQVcFkJRG6ydX07PAeFEK6MDETQNCKhWWSeLjFnjM6iLdipmBjz9Y7vO8qfwvma0QOpIv
 SJNxYqo7QJDKelmqDqSUo0q6wMtay2/sDcZsMyb/BGTHYM8w5a30zWk6ld6yhUQpT7fcAfLhGhh
 wG0kbS908V/Y6U6DPgVAKmHyEyHGeCxfVu2cy20z7kMfgcpXZg1GbGV6D3NiGOdnLDFW46G+rqj
 g+w/NylQWunjKEgeyTtEXBDh/cu/jubozf+G2Rw2YdHo3WgfMBK7/Y2ElCIr5bwJbm3maB+aypM
 JHz0IxfAnIWuljSLSSvHlM9akMOwxxuccK51lx/BXJp9Bq+zF3Ew==
X-Received: by 2002:a17:907:3f13:b0:b83:974d:ddc8 with SMTP id
 a640c23a62f3a-b8761028920mr29104466b.25.1768335829609; 
 Tue, 13 Jan 2026 12:23:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v10 08/18] eal: warn if thread name is truncated
Date: Tue, 13 Jan 2026 12:21:47 -0800
Message-ID: <20260113202329.35190-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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
index 6215245ad5..60f5e676a8 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -690,8 +690,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-				"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
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
index 21fe7cb1d9..f06375a624 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -378,8 +378,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

