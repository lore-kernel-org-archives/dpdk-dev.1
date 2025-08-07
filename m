Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC69C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C64A34067B;
	Thu,  7 Aug 2025 19:34:59 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id AEF914066F
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:34:57 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so1004124f8f.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588097;
 x=1755192897; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6ZiznBmpT4+gnwSQarDW8ybOYEBWIwlssAkQUjVRBA=;
 b=CXlimaF5TroTHRGElt8l+opq6Kk/GmZk2FBD1eh2z13VxiXUpNVR8Z+i/BKjsUMHUo
 cQRPSo7lizsgmIgIpXRtBrpQ56jQC/29q3lhW7uBGL1eR17iqxg+0b/tEGSTxEZUcSJz
 TvxdISNNhDEHI5fRrNxW1HYQ6Dv0ZkZIvRCbk/94H0hZQkhBDJ+4Z29SUF97Ryz4yWU8
 t28fGi4ND4Q+Rzay26Nkj3Tar8Cw6lu+N6jTooyyU/i7vddJ27ERWL1PGlPJs08Ll53E
 si+AxCnQKITVBdC3RuvdreQkVItiC4veCUf9lpS/v3WLajHVDV50apXTBIEIYF3S5/Wj
 Z+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588097; x=1755192897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6ZiznBmpT4+gnwSQarDW8ybOYEBWIwlssAkQUjVRBA=;
 b=U28Mv26UY6um3TE0k/mvkLQ6a5uW5ZtoWDsxG75Tj9sufOiSbb6aEZ1BuYxiCCyAsd
 mgFz86l9khzYfHa4TCHHalsHl8gUs53KsXx0ce7emuqM4Zt0lpcnIm8Jp1+9yD5UsL68
 aeEJwNBDmqSYnsdHH0MUBtWw1gCzLSPhlxnPLaqY1sr9w87GBw6s4VCxs8FoFwGih0VW
 nzcC5k+HGwPxaBowDC8zdF4JF7hqmYQAT9v2/jL14OvTfMqTyQdj+kptctU13nCf3X97
 fZ2KqgtDdouod7/U21kZvMT5D0VTJ7Fcq6TjjF/yD80ESqls8c+GBp4VtMW0fpjzKSok
 rpIg==
X-Gm-Message-State: AOJu0YzDFXdRoGPynUuHrlNyJfh5SiaqJ9OYFQe8OcLEkZ4fU8pe/+mj
 ONGdf33MhcswM8yX6jM8ObzoVFN/zlNCKl7bCBhkEXjK9cM5TbRk3lKdLAX84Wn16nPtbMgEdrs
 w3UF8
X-Gm-Gg: ASbGncsIOceQtqoYtvZa2pDU26dCbqM2gVgtiiDQxyjwXGdNqjaYNr6xufRJglEQ7pz
 mVgNZOsuOpTqazxcU8sGMeC3Jo/CGsdTs0nQVW7rnbx/3l+dws8e+4hVs5RM7FD5Uuhcwqv/ye+
 KXSU3F1sUvnI7xdiheam/icJbjxuTyySiY0SZl+t6qp77SMe6VFqYiUOZTL2aXQ3VKGHFj9gzE6
 KuUYhp5HcIIDyNBy0obJerGo+HyHE/d1KUncwvzo4HBEd8DW/3Gr6tY4BTs5mMLqCBi+31mZ5X+
 WiBYuSNTq3foH8EAI9TA0JjGiAyKYr9xc4GW4Iuh0UrLE8JN9ZVsGYKWw9V+89+F3oePp45SDXW
 uV1/ERikz2fRSBKS/Lw8cEl+hVQ9lSep4Keb5BDQUuw+1++Uz82pFPl62AlAkRsLM9pG/qGG9
X-Google-Smtp-Source: AGHT+IEuwfdJavf8/rM5oeB0Jx/WMUhGyUo3MscnJ+lxtxLDlQWSTjhNaAVO/LSMKw5Ckp5K+8JY8g==
X-Received: by 2002:a5d:5885:0:b0:3b8:893f:a184 with SMTP id
 ffacd0b85a97d-3b900b8bcbamr40721f8f.52.1754588097218; 
 Thu, 07 Aug 2025 10:34:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:34:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v10 05/14] test: add test for hotplug and secondary process
 operations
Date: Thu,  7 Aug 2025 10:33:19 -0700
Message-ID: <20250807173437.11442-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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
 app/test/meson.build         |  2 +-
 app/test/test_mp_secondary.c | 50 +++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index ae947c4cbd..f3ea3e2b74 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -132,7 +132,7 @@ source_file_deps = {
     'test_memzone.c': [],
     'test_meter.c': ['meter'],
     'test_metrics.c': ['metrics'],
-    'test_mp_secondary.c': ['hash'],
+    'test_mp_secondary.c': ['ethdev','hash'],
     'test_net_ether.c': ['net'],
     'test_net_ip6.c': ['net'],
     'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev'],
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

