Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202D6C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 763A640A75;
	Mon,  4 Aug 2025 18:30:58 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id A961A40A75
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:30:56 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so8062855e9.0
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325056;
 x=1754929856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN8iaZlMVimROEUTtt1lhRt9g6RxVR7PpKINVBdW/WA=;
 b=enYSNKkWHwj1ujMarhbCC9uHZ0fJ+vSJr/HxyodGrhJaB5QIvTuSb2tYzmKNkH5DSA
 P3RRa04dQmzy1zvo9LI01wHxaBLwYV3ICoVFCimlCq5CyfNAujF+nmJVyBBUj/NosaHw
 J0gy8k0OaaxT3hRSR2oDHSTBgrBRijbejjbzAc8u04iEcnCz8C/aT7fE1VO3hKOUphzh
 PMQzFZj4EdqhHDpi+KhQnGMakB0O1WWoeOdDZ3oxc4vzCDNBD3zlbChungL2+4OAeO//
 Jti3JA2nyGrum2tEdkFmAkb0iarUlyfrExs4NOnuqbMatliFVe7GbgrljWnS3klHdblh
 2LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325056; x=1754929856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN8iaZlMVimROEUTtt1lhRt9g6RxVR7PpKINVBdW/WA=;
 b=bXwjiQKO8NgSFYGfVVTl2LLMhCcg7tpdakqs/eeAhgXWes97TuauUjWtzrjmP60i2A
 rFmg1DNbL5pRiDCW7ysr2kI8tDlc0bEA32HFGq69QLgOoogHWKN6Bj4zRPkRGYyUMiSf
 BotTBPeMkd8jMNiL3lzdmJoeKsf6YUD9m6BJRP9D/g9yE8i4dOaypINn5bvoqPCN/UlT
 SsBU16XlAUDHsiYmszpdvqt2EtZFQFvoltzLykwUc0WjoFTppARIkZguwY3mCFvjsKZa
 McKeS8cCAf1ZusgnHTPM6GDKDEBEPvKvsQlY1X9hziyPcjRdO7Bsld11MCvzuybFbmhn
 GA2w==
X-Gm-Message-State: AOJu0Yyn1ur0B2+RG+i4/deVoNbLB2V0QjqHFyqYicZDu2wIfvF12w4v
 WmZ/I4gAQGPFuaIua7uVBV/z6Hg4j2R2FB8ceD/MDlZUi6v/vcqzacRqWYUAMAlwHYHbf9vhz9b
 LCbZS
X-Gm-Gg: ASbGncvPpQ6L1PDlfzpi9jwvBEFiJ63IiCXRwg63P3mZH8Czj+owPBkk0k/MKzVeXoR
 dBHhK5fgw1sFF+otwR7rSzViKnhy6VORD6JFGYdW0EbPK/9mYd+xvS0dj6GXHwGdCiQPolRZqtI
 U9IU5tXZrUBh4W+6sOAj1h1RvJdBi/s2J0V58pb7l3P2c0ApiGqWf7BypRnwPMYsGK9rG+5jBoa
 kIIRgeL/wu3LrHMla6q+8uOVi9nF1oGoiZKDlB1W5tWjGh78kB6D6Pt6+fYxFKAj62NLxTlA7pY
 /w2XCWA8rTBaTIYS7QcHvEo5Ji2A1wGlGXE6KYaKhgfejMHGXY6e3NBo0cC+EIsy2TJUdYWd80T
 IMo1lXJWd+rgFxl+XwfCI8M72nnIs5iD6iXJN7H4445rkOktl6usZ5p9A8Qo5i4OreH1zEj2a
X-Google-Smtp-Source: AGHT+IGhmzHk9lvLWWpOnYLW01x5tegkoQiqdMLh9RdoXczCOE7ped4sJ5t0kBupz5vJv+B2dKzfqg==
X-Received: by 2002:a05:600c:4447:b0:459:df25:b839 with SMTP id
 5b1f17b1804b1-459df25bd53mr19015965e9.33.1754325056207; 
 Mon, 04 Aug 2025 09:30:56 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 05/13] test: add test for hotplug and secondary process
 operations
Date: Mon,  4 Aug 2025 09:27:36 -0700
Message-ID: <20250804163039.138959-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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

Use null device to exercise ethdev start/stop in secondary process.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mp_secondary.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..d6604b326d 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -42,6 +42,8 @@ test_mp_secondary(void)
 #include <rte_debug.h>
 #include <rte_log.h>
 #include <rte_mempool.h>
+#include <rte_ethdev.h>
+#include <rte_bus_vdev.h>
 
 #ifdef RTE_LIB_HASH
 #include <rte_hash.h>
@@ -204,6 +206,44 @@ run_object_creation_tests(void)
 	return 0;
 }
 
+static int
+run_ethdev_tests(void)
+{
+	static const char vdev_name[] = "net_null";
+	struct rte_eth_conf dev_conf = { 0 };
+	uint16_t port;
+	int ret;
+
+	printf("### Testing hotplug and ethdev start/stop\n");
+
+	/* use hotplug to make a null vdev */
+	ret = rte_eal_hotplug_add("vdev", vdev_name, "");
+	TEST_ASSERT(ret == 0, "Hotplug add of '%s' failed", vdev_name);
+
+	printf("# Checked hotplug_add OK\n");
+
+	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
+	TEST_ASSERT(ret == 0, "Lookup vdev '%s' failed", vdev_name);
+
+	ret = rte_eth_dev_configure(port, 1, 1, &dev_conf);
+	TEST_ASSERT(ret == 0, "Configure port %u failed", port);
+
+	ret = rte_eth_dev_start(port);
+	TEST_ASSERT(ret == 0, "Start port %u failed", port);
+
+	printf("# Checked rte_eth_dev_start\n");
+
+	ret = rte_eth_dev_stop(port);
+	TEST_ASSERT(ret == 0, "Stop port %u failed", port);
+
+	printf("# Checked rte_eth_dev_stop\n");
+
+	rte_eal_hotplug_remove("vdev", vdev_name);
+
+	printf("# Checked hotplug_remove OK\n");
+	return 0;
+}
+
 /* if called in a primary process, just spawns off a secondary process to
  * run validation tests - which brings us right back here again...
  * if called in a secondary process, this runs a series of API tests to check
@@ -212,15 +252,19 @@ run_object_creation_tests(void)
 int
 test_mp_secondary(void)
 {
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+	int ret;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
 		return run_secondary_instances();
-	}
 
 	printf("IN SECONDARY PROCESS\n");
+	ret = run_ethdev_tests();
+	if (ret != 0)
+		return ret;
 
 	return run_object_creation_tests();
 }
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(multiprocess_autotest, false, false, test_mp_secondary);
+REGISTER_FAST_TEST(multiprocess_autotest, true, true, test_mp_secondary);
-- 
2.47.2

