Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F337C369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93D1340E0A;
	Sat, 12 Apr 2025 01:49:45 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 23AE8402CE
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:42 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-af59c920d32so1926221a12.0
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415381;
 x=1745020181; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=cEUiT41A8Ur9jQEnCxi0TjjmGl0visPS+zUX6n5cjBcf/HbpQ4dO1a3+u/pIqEeMZS
 scX+q3tbrobVhXKW9gtLsApSS2qpwT3ClIRFxCJjK9SOkv1/QujfeFnwlTU4s4D5/QVr
 fAymSQhsSPj5IPh0/7tsn6Qqv7G+IRbDZr9dN04VRK9/ZRf/0WqBLIgMjtyI1Wjay4pM
 BnCDuWM5ezQKhW1BYN9V5rIQ9OFOyA4vv90blBUMRlZj8MSacmEG1vaXYcTZ8MkRt4ym
 ZPVWM664RzN7ueJup2+bcCRvbJHhZ18YSm5G4lQMqSaBe6FXCp+Kezqo23QnUloI561C
 bjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415381; x=1745020181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSh6kbv+hR1zb7kg6e6a3Btjfbls58Zvj3ges5YQbBI=;
 b=K3/A2qpvTNEeAw9dgn5nV6BWxCSXPEXwjd9J5XYVdLP8jv70HiXenmYAi9lgEtAnUa
 86U9HSc3uvRCoz+rY+UyD2lpnHsIomi4tpsiArPxVTma1CEBUI4KHuw53QEoUGT1tF97
 BW1TSpdHF+gkRH+KLaWImvumnwAWf20yXbB58AMzBGeioyKQLMittY/X7bbQhW+Xm9ic
 c+foT235RpnXE/maKn3ZlD+MK0QhqKZmpvh8dO96Fx0gEA18KPV+u+yK39FX3NapCCsv
 w5IzydtowmuB1MQ3M/TKHmDPGoGSiYdk5YFNDywSilaXXdZfjaf7V2+Vy5vC7b68KoSF
 NTnA==
X-Gm-Message-State: AOJu0Yxz4VhWXEMNMCqbDnzEL9/nEdyJZO+NA+SN/XjaNYadVtIyFU6D
 bczoVH/F92pRY370+R91zx4+MCuJf2+uDjSV25eOqfimpkW81d/BuBonwqYWJhL6E2aJcs5bPmE
 r
X-Gm-Gg: ASbGncvyCR4rfJIlZIRwsDWmBQMpMun0UzvPISSUNoRoMQn4oHccvfRingfyiFYMwAK
 +7zzZvFabVIHyrLjtQZmB0dlAZRp3LPokMdwyn8WlK8mUYjCf/Unxs20tXNt+nLqQipkv9CWgdA
 lU/t7jkAlFB9491vj94NU6ZfIbjWIvBFel8tGuHc9S+FIZKCnoV0HcdXXKBhXu2UW/eL92CoeEK
 efLRhLeI1DmzPdOSB84GV34JGk0CWbIkKEYIUnR1CCCrXwKRLcBDxfuA513wew1y3P5DIDdYmHn
 1drrzDdO7fhkB/Nn10+vxhUb1ZXlXwh/ti2Z3VBF2+x0Uw6F/JYtFoFGehdJ7IJPTdjeCu5KxHH
 LpMOhLVt2uYDZHo4f
X-Google-Smtp-Source: AGHT+IGyQ+oiokoZCg3p2vH3uel+uuSvAHetIm4hpu4f0BOIaVsyW7eAGeLDaB27CdkiqKI1bTSldQ==
X-Received: by 2002:a17:90a:f944:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-308237cf269mr7575386a91.33.1744415381274; 
 Fri, 11 Apr 2025 16:49:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC 03/13] test: add test for hotplug and secondary process
 operations
Date: Fri, 11 Apr 2025 16:44:40 -0700
Message-ID: <20250411234927.114568-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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
index f3694530a8..09611cc5c2 100644
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
+	char vdev_name[] = "net_null";
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
+	printf("# Checked hotlug_add OK\n");
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
+	printf("# Checked hotlug_remove OK\n");
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

