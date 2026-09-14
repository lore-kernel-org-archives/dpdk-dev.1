Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46652C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5978842D7A;
	Mon, 14 Sep 2026 07:52:21 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id BA51042D7A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:19 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ceb47d53so147082a12.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365139;
 x=1789969939; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GmLj1TBmKjo6H4+D/THjReCXdEKXZEv6GGqdUp47dfo=;
 b=d3WizhwxoSebg8LTEH3qMj3Nc2oLiX7NGZ4lj+L0UoLJ2MdUDlmUoL7Z4HP9zkp2E3
 VfYM3nT0Zrx50+pCYvGidabS4CaeqOZUkZBsULcuiMCeISgWFTyCvbkMwKlpZcQBv710
 +QX5ERsQRwcVjw8E57lM5UHxRdCkrmhImOa77T5WnrqeuXQGoB7zO+T06qqfHG3rGEPx
 RGKzjzk5gLaf7qzpQZtgvdOrmUEUusJY1f4WzfT3VChmMMd9MHMdUpSLhKEyNfWdTkEB
 0W9/XbWSCyeCQVHX6qSr8R2fMfAxCplg6tIRbTqFhzqyUx/0ihbcb0Opta1LTElMTfeC
 LXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365139; x=1789969939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GmLj1TBmKjo6H4+D/THjReCXdEKXZEv6GGqdUp47dfo=;
 b=EFFay0Hv9CLFprOOcKY7btD6qqJR+YAz3qzdi1dtImcJIpInAe/zIOSRlqJlXC8XtV
 wylIV6j2Oaxq7r0tCyQ9dY961+lrvkJYq7cyE0MlSAwpjTJHIXoefEI+oYunSALrWWK2
 uctA8kG4obby4FBOxcH1YheuPJzzu8CyRsoD/5RNd0ghrXz48MBX95euN+93iBo3khCL
 FZmJlRLU2eiqaXYM9W5wRXFLFV54sDUhS6rERmjxxxub9MFQfuhktMc4ps9dHw597qU9
 Fp7i7J5jS7TZeHnAnc6GvJoO08g1xwx3SSf+kIhWI2ojJdL4r1zWLtcGtT5vtbcC4t4C
 Cc8Q==
X-Gm-Message-State: AFuF++ko3aqd06f7Qmjo4siU/+gH8x2fV6oMiGB0gVII7u25CTbre7jP
 laQljpuGLRsql8X7q3zH5D89RsZ1Bzze4Qs8LDxRt5qRmZgzuCT3OTWOxRCzjWbTUSyR/sacIIA
 LrdHZyMQ=
X-Gm-Gg: AYBFou1sPl/MBNgwYfViHC4LA03SnLAL9KFbLL6jOt2ab96sSBDQuiDEhW7tJ1DVSW1
 akaBoXcOQXUJwzNCqDL4cWSRw485Z5uoaUM7btvRcUfqR+5oX7asiG2JVOwtvh5hjkFnsx3shzN
 ebJtSUmne5Neyw+1uDvDMC6p3tuKDMej8E37oL3dskZI8Ymeacy51SASoBuHRF8uqlLYuVBeu5a
 5ajsc0b2tA5QJRopwOCpJw+MRxKiMj/NYs+maWwE/xlO1aagI2VITAn4fAAHcPjKWZWAQyKKkub
 FXDGMMtrK35Nn+PP37lja58uvRDAV9xgqpEP8U7Axzw3ilruz860u5PlF4UmxgY907WBnKkxhdj
 23OLJLNB6LuiwXbqln/p6BomiRKNLaLY/ybWHwni9G8jqKzWbx8rT59/NG41XIUhM4y/h1XpRJu
 xzBpn2ZRy4MZgzyuwJewcNyC8aagBU4UrZhSG2WnnLNswWqNaqB4WBxrwa0/DgmZJh8TAgPk42p
 4ss/nmcWkLQj/xb7/fQET1EV7UY7ngbVPV+SQ==
X-Received: by 2002:a17:90b:4b0e:b0:398:baa7:4c2f with SMTP id
 98e67ed59e1d1-39dec3b40c7mr1151410a91.5.1789365138814; 
 Sun, 13 Sep 2026 22:52:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH 52/62] event/opdl: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:23 -0700
Message-ID: <20260914054912.755403-53-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

All three handlers use atoi(), which cannot report an error, so a
malformed value is silently taken as zero. Zero is within the accepted
range for each of these arguments, so a typo was accepted and quietly
applied rather than rejected.

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/opdl/opdl_evdev.c | 49 ++++++---------------------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..4650d3eca8 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <inttypes.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -580,38 +581,6 @@ opdl_close(struct rte_eventdev *dev)
 	return 0;
 }
 
-static int
-assign_numa_node(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *socket_id = opaque;
-	*socket_id = atoi(value);
-	if (*socket_id >= RTE_MAX_NUMA_NODES)
-		return -1;
-	return 0;
-}
-
-static int
-set_do_validation(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *do_val = opaque;
-	*do_val = atoi(value);
-	if (*do_val != 0)
-		*do_val = 1;
-
-	return 0;
-}
-static int
-set_do_test(const char *key __rte_unused, const char *value, void *opaque)
-{
-	int *do_test = opaque;
-
-	*do_test = atoi(value);
-
-	if (*do_test != 0)
-		*do_test = 1;
-	return 0;
-}
-
 static int
 opdl_probe(struct rte_vdev_device *vdev)
 {
@@ -650,8 +619,8 @@ opdl_probe(struct rte_vdev_device *vdev)
 	struct rte_eventdev *dev;
 	struct opdl_evdev *opdl;
 	int socket_id = rte_socket_id();
-	int do_validation = 0;
-	int do_test = 0;
+	bool do_validation = false;
+	bool do_test = false;
 	int str_len;
 	int test_result = 0;
 
@@ -666,7 +635,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 					name);
 		} else {
 			int ret = rte_kvargs_process(kvlist, NUMA_NODE_ARG,
-					assign_numa_node, &socket_id);
+					rte_kvargs_handle_socket_id, &socket_id);
 			if (ret != 0) {
 				PMD_DRV_LOG(ERR,
 						"%s: Error parsing numa node parameter",
@@ -676,8 +645,8 @@ opdl_probe(struct rte_vdev_device *vdev)
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist, DO_VALIDATION_ARG,
-					set_do_validation, &do_validation);
+			ret = rte_kvargs_process_opt(kvlist, DO_VALIDATION_ARG,
+					rte_kvargs_handle_bool, &do_validation);
 			if (ret != 0) {
 				PMD_DRV_LOG(ERR,
 					"%s: Error parsing do validation parameter",
@@ -686,8 +655,8 @@ opdl_probe(struct rte_vdev_device *vdev)
 				return ret;
 			}
 
-			ret = rte_kvargs_process(kvlist, DO_TEST_ARG,
-					set_do_test, &do_test);
+			ret = rte_kvargs_process_opt(kvlist, DO_TEST_ARG,
+					rte_kvargs_handle_bool, &do_test);
 			if (ret != 0) {
 				PMD_DRV_LOG(ERR,
 					"%s: Error parsing do test parameter",
@@ -734,7 +703,7 @@ opdl_probe(struct rte_vdev_device *vdev)
 	str_len = strlen(name);
 	memcpy(opdl->service_name, name, str_len);
 
-	if (do_test == 1)
+	if (do_test)
 		test_result =  opdl_selftest();
 
 done:
-- 
2.53.0

