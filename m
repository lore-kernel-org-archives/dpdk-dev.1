Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94735C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B5D3406BB;
	Fri,  8 Aug 2025 18:59:01 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 7A948406B6
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:58:59 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso1861763f8f.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672339;
 x=1755277139; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6ZiznBmpT4+gnwSQarDW8ybOYEBWIwlssAkQUjVRBA=;
 b=PqX2O0uxkxct8GjcIa4m6BahbeLrbTovryC14F8rN0xaMGTLmjxXxU88L8g9bm6/jP
 l2txjplXwhIDNZUZAtYDlrfspI/sq31ATmSVIC0PgPf1RmjvTNUYqvHeIjI+epMMNbv/
 X5XpX4Me4nyhMVb1dJxK5wYzMtSNOqxErhtJ6YaDz18eJI6GULN9g4NeFBRMjwTHf1G/
 IegZ04iseY7R82b56W0upBka+q7evryMthMWAzoLDfEGw5Sok5k+03UJgunsbCXVMB1T
 xyVtqqEfwBAxxYTkQrUtLr5KOWStQe4VObO/hKIeQN0camCgyX6Gw12+Ybv6oygawXSh
 /Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672339; x=1755277139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6ZiznBmpT4+gnwSQarDW8ybOYEBWIwlssAkQUjVRBA=;
 b=kEgqAp0YWXBmhhYquTEvQ1T52k9dXeEp79wMwLjpH4XLWynm7a9qXDgGkB3+4s771z
 DcFAE0JoC/ScG5qZuUcz3EhxQ/+71nGqh6YOO/3R4UTrmHbgpwAw7rpnIqmiq8lBQLea
 ujiNgPyYN8/zliAsZY6hxZT7JAXM8boApkTtq0VR+PA7ITJR+WvTBM33gx94cDLa7Yu2
 tdFcnJOAk2zjsltv0f/+o9Ola+8AKEqC76oUcN01pLln/xqgeOcJjSHTrgchfHrA7ELo
 dRM3yMKIHdtevIv1TZYCSH3fI/RZ7YW1tfJcSgB5DYcJUJxvrKnJqcBRFoPg6cNCJc4m
 HDWw==
X-Gm-Message-State: AOJu0YwPQ2uebGg43043UmY1t1hRntfgnrSMQmWD7Zn9Hu2+NETL+Q/r
 /wzFGBF7RFnRbXC/BarC9/NoEkZy5FGMIzM1QKNR4TycyxRT4ixKy69J3g7p7TKII3FTQXB6+3o
 KZ2MP
X-Gm-Gg: ASbGncusrr7CD/fQW1GeHCvgXlFJLxCcKq+bYl6qYKxY5kRPexCrQXrt4iadeP71g1m
 +1YqZzV0uzUsa6D31ZEICxDvayrb7wuO8qp2sHg9vOROzMqt6Cls1qEhw1P+/L8jA+00VZBDaKY
 TcGFGHK+HorAZ1aPlNetOCslf5JRTtBMad90TWAsPzEdhhAZIPV91RplfigbtW5gJQF3dAGJUwE
 kt+M7yZUHWP8zB1V2Zb2K6atLSKY9mjnJ/Y1DNiFUnHTgToOhzLg+UdwYd3FoyjBGOgWp8HyARF
 UpELEVqKTY0oPvY2N5AIThdX3OL4baxsblzD5j9VG+Hg554czvyMVktZyssUdgH2Lo1Utwgm3Bh
 52hAphLMrHEbjf2C5WIoaNvH2FqPIkN67h0n+iHDoPIQsXJ4sgRSzvYIelAaauwq9E/8BqA3m
X-Google-Smtp-Source: AGHT+IEUf6gUX288i8sOo7FoTOMZWA3hBj+tsLGHpJuD78hTVGQQHV2Qc7RbZL5gqAK3EnbPJ92gEQ==
X-Received: by 2002:a05:6000:2209:b0:3a4:cec5:b59c with SMTP id
 ffacd0b85a97d-3b8f97f4ba4mr7883591f8f.25.1754672338998; 
 Fri, 08 Aug 2025 09:58:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:58:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v11 05/14] test: add test for hotplug and secondary process
 operations
Date: Fri,  8 Aug 2025 09:55:43 -0700
Message-ID: <20250808165843.39075-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

