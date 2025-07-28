Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2DAC83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10BB340A6C;
	Tue, 29 Jul 2025 00:10:06 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3F6AA40A75
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:04 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7e32c95775aso540200085a.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740603;
 x=1754345403; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JC6TuKnyG7XposPNjTqJ7jxWzCDVBfXB+D9C4ZHPRac=;
 b=QnWrh3OeAEdt5mbCEj7QmRB9BJI/CHlMvNF6i0r7AHw6ydMlXSU155pbnATY1pUe8M
 un/X7mQvx6F92ngYhbF34MYK4H9IVeCtqzzO1PFMfqFtXnpUAMMW1rU5ZmAPobdP5y58
 nZqEumgiBkdEm/3G0M5xP+Gn6OyNUCjTmS53LdHq5qLP5CwoZ2cGRv25R/pSNN6Ylpd5
 0cW5IPoyucE3v03vl2FsDfRBIHUJwywpU1gp2g0htaVL3xZy3xTJI2e+dezQKpWTx58P
 gFPm2j2chm4kAvWX+rJZYOuACl73FYhFKcJYAv+eWavl+eeYePytRO90ZQBC8dEDTM6o
 g8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740603; x=1754345403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JC6TuKnyG7XposPNjTqJ7jxWzCDVBfXB+D9C4ZHPRac=;
 b=h4YDrf0GAHSoeydRD1SJxuk324u8oN+wuDSQzUPpG5nTekv/1vDjZQ6BuilV6x/w/0
 6f0Pgs8+x86nFKU0a9B1uSX7i7jzuF8uTP79AkI+gzcg48Zz9YkTlSxm0mJ//KMaa9W/
 qEphH/gO3cDR7eaCtRisF1QwavSVPOGn4E8jtrdQWJk8X6B3JDboQ4+A/QHtFvrQ2LHn
 /SkAObOMrSX65MAg/6DzB6y52j8UmAq/AfTxXHVwQrxfhbijr2coy1KcIVKt7LZrngAl
 O+m6kTCN2qi+MyGiiTs74OyBY/7U3ZvdU/25m5e+xfc74k1W513/Vxd8pMJIzZNLyGRQ
 rJEA==
X-Gm-Message-State: AOJu0YzE35/ZekYn9U3iy+8LTXVqUGBTu1Q+rfVNorvgFJTfwjHNOoEg
 qKlkHz/4j9I7Jr6UPhJ9PQl9KLnIpmEQzUP20YkWRV4OlnAAWXnpYTxD6mTctpzHFwKCRmmp0Jn
 4hx0W
X-Gm-Gg: ASbGncuhglFbNtM4TTY9/KCleb/78692Ca9tyV62g/ZF//DlCU00juvRd+yLpmHKmhU
 Prh95ISEga+dtXnKH1PEBPFR2WXxBlwdY+CG3ln+9/tpXOFvajF2FM4JI0xh/8hYLclhBrLmPOC
 GUWumYZZRhbN4nKJrdvFuJvlukicV7FSVM0kzOkQlG8mt6mZP7lSU4y/ZmBFR33VK4y+mEC1TN/
 r1v+akb6oE4tnctsASLK21ZaZHuZPJqSDCRLe5YMbp6IfEDSMjXk818vuJ0rIHHDBXJSRjsqKqd
 Lwu8nGn7tLGNL1HkRpxxFK80TqOEpGPU34THX/vmjAqaetnmAddAB0Lec9VW4m85eh1ca2weIhY
 emks3n1sO8F+Oggy9XKrTV/edmxq8/SV9lNzxs+8Mrs3Nv4ZhaeCg1MysEno1/x9lv7LTqWQQ
X-Google-Smtp-Source: AGHT+IEa5dunu8HxoUkLRsU/BWjbIGKbXKJw6+nNMlZPSWDqjtRHEbDVp1ulFjMl1flgGRfxw51Ntw==
X-Received: by 2002:a05:620a:a106:b0:7e6:5e99:b231 with SMTP id
 af79cd13be357-7e65e99b296mr235253585a.26.1753740603415; 
 Mon, 28 Jul 2025 15:10:03 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 03/12] test: add test for hotplug and secondary process
 operations
Date: Mon, 28 Jul 2025 15:08:11 -0700
Message-ID: <20250728220955.332924-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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
 app/test/test_mp_secondary.c | 51 +++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..e8da81fe3f 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -15,6 +15,9 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <rte_ethdev.h>
+#include <rte_bus_vdev.h>
+
 #ifdef RTE_EXEC_ENV_WINDOWS
 int
 test_mp_secondary(void)
@@ -204,6 +207,44 @@ run_object_creation_tests(void)
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
@@ -212,15 +253,19 @@ run_object_creation_tests(void)
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

