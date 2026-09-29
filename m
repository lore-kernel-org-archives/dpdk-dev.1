Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD22CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F58442F7F;
	Tue, 29 Sep 2026 18:40:06 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 169C542EDB
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:54 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8692a856865so2165427b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699933;
 x=1791304733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GmLj1TBmKjo6H4+D/THjReCXdEKXZEv6GGqdUp47dfo=;
 b=zSVyTAJiS6MtLIduzcXaZ9+Y0JG+QAZUOTt2rgWI8kg6GZogcyttgJJanVIPJlYBbp
 kZq32rKTz0R7vW6t4es55zVFI/AW+WTGAAdnF4dfjTP9DdzrN4pgpUKR0r0WWgb4PcFE
 tRFeodPVGOErUEzkBLS42g3dLD3ZPzY5tBT2g6UrITeMX9gv/kRkH1JodNz3eiI/2A7r
 CC+CPzr15G41w3R9/8W+YFaxbzCoGOP9uS+7QpbzRptwwqILJv9bNwR/TJmgQJwNPgnn
 lUJgb9sGhxx+hhJJQa1BtTwQUrxCCOxS1I/IIoVKbuPTMKOR+YN+in7OTbhoZ1iyuOE2
 BVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699933; x=1791304733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GmLj1TBmKjo6H4+D/THjReCXdEKXZEv6GGqdUp47dfo=;
 b=kHMwmgpRohpAs4M3eRya6d0CeZ8nKRq3hKdcLsthS2hn9ffd2wWRdi1uRuqKGSWvo1
 06o4OabsyjC23C4SLghGlnfzvuZL/gM1tpYiI9Ch4T5i9/jAwdB/umsFTSjzK4rfnrKF
 ljIDgTQCjF8IM5pPZGxA7Cs3JW2nBmdEt3NCn56CgvG07AHNz/0Qn1Ai1o7j4zWgdTYC
 jO+OMKSEub2fhU5W/SzEOIFlX6WLfFxb7EvrAFOG+v7McSYDUupazfZ6luuHH/SXjmwi
 oYyJub8xygQJrDLQn1ly1aNy90IwnnDx0TSF7DXBO7rMwZJcSS9qX31WP/mpBlS7jset
 6PfA==
X-Gm-Message-State: AFuF++k5H0FUNIiN4iZWsOQ9TQcJpKWp5ef2w1JqBGhKYWFhdpanBVJr
 9nIRiDaP5I0Q0oUwWCi+dJEYYy1jUEpbeEGeOlU0O9GRVy87Bk4etghVnOLZ0Jjk3cO8mLDxwUP
 YviYZ3HQ=
X-Gm-Gg: AYBFou0Zf54c6FufXQS9/qrK27+PeO6kdZHNOMhSxNfvJDa3uloMAuyg0TU6vmoutoI
 JNc4jwTOUGTD5m7ryQ5pOVa1NZkswq3fmqcHSgfPXSWzqGYAXQQdhhCRZx3x+yPty4xVv+a8nVa
 Qqtk6S+ulQEapeqEGgNYHNN81xmF5ECWaF/1VRaK9s8+obSYDCa1sgMepMwD6436pxN1p5qZgW5
 2CI7ce92+y37u4CT9t4D7yuP3CibEMdRouDSIy4Mmtvd7dWoq36ZQtOSFHKf6fEBCYRGkIWzfE4
 22yxiDsw7BvGn0+cnNnv7kgRZmQeOrToTNiISo9Dsj2CuYYaAtVomDY4NaQhTr0V5nyTgh3b2JG
 grs8TIypuPDv73AJ2bRB3YTlh7lMXja+bg/MbrFU1tBhdtLDrT9MCaYgitWIvsnaLCMXwXb5zys
 /fa/NjHvMFTeA0zmxHVTLfiAzZRiOnoXmEFbQHdFnq7sDHazqtXFfwCGk6IgaTe3QkZ40B8afoY
 ASjGF/t378/2/J9/zuEU9v3ZtuYeaBus6rUug==
X-Received: by 2002:a05:6a00:4519:b0:871:41fa:d1c6 with SMTP id
 d2e1a72fcca58-87e98998abdmr13013602b3a.3.1790699933201; 
 Tue, 29 Sep 2026 09:38:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH v2 51/61] event/opdl: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:54 -0700
Message-ID: <20260929163800.1108305-52-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

