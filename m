Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA5CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C61343007;
	Thu,  1 Oct 2026 00:44:43 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id 47FAC42FED
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:39 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4bd597d68so901128a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808278;
 x=1791413078; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GmLj1TBmKjo6H4+D/THjReCXdEKXZEv6GGqdUp47dfo=;
 b=vqfRKdALRn6o99f/2zMzfwEnsYgItkXC4xNubb1s2B3d/iiQuCpP/dJ6z1iAF3QK0k
 myFWCCFqLt0sD93Saazi5LGgT6ALA9fxw6GzS0tTm41iSoOs/8vOlDba9NrxNDkBC6+n
 AkVzfbN1NA00XM2LUrKNNyPJhmuV52yQfrUNM1XoqKevtJNlJNFEO8Sv4chWPxB5DqcI
 U3p3vdcuhWwWXDiP5gwotMG6pcuszGXezdT8OdzSxTytJczs3xfMBeUZdfEx5N96I2Ee
 6A9dWt19KPJm92lt8m2f2ZPolMdGDupO9ZD7q8j8DX7Bu8jyitFKc/+c9evNiZqcX94N
 kE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808278; x=1791413078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GmLj1TBmKjo6H4+D/THjReCXdEKXZEv6GGqdUp47dfo=;
 b=c1UV1xTRIvriqtJHFFoI0Vz9FHRg7jrQJts5EH9Fu1dXKu2Y3uWLYntylnY7CKel4A
 Ts0vKLDj9rGjNSbjwg81H9clR9oy0d7Cqy550BQYYSyxkv/DpJkU+xrP+Ge9W4k3Z1Il
 QsS0+edCyfw2WEx5KvW+G9vj/jBTO4DqyB6f6jejA/tjqnGa9B58oI1X03zoDxc8Ag++
 mdG4zp7c6wUXv2l9cwILKwPhbY1V6sE/VlkLR1D3lSiKWH8Ni5EZg0VzmtpOFyyJMmvC
 /FmixZ9vZSe7xy8F90Gn+sJaduUl0E92uQIyIY9HTctahtJICrr4seQgfI9AA7omn4bU
 doMw==
X-Gm-Message-State: AFq9FYKdD6uO2dx6KIWZqtLTU9/8aRiahYZwvxkK0Z5e3YXVL2ZLh0EJ
 bhX1OlsoBxL/GwSa7foqBZT6c6Q7hC4kU8zX0xeNES3wV89LgRP1o8vwws2hUbSgA/wzRbAR40I
 6sMBQeTg=
X-Gm-Gg: AYBFou3ibVvLHs3y22PuXQJSdcz0Ikqj6SvR/CGc7Q8Bo9MQlW3naJuXa98xz70mj+a
 M1sO7W7kOo/YHl9Nh/suIYtC9pk+7vXvCMZwr+VqxmViXPxRw+nMcmp+2ykSt9Fs4D/sGFqaFZY
 sIEM5ekPsjXoZxiaunNQ6knaLI4Tp4yYn6JfCsras2d6pb5+C3TwhbrTRIGhOfr9lEgrBG08JBl
 gwdVC7RiXLFhs2qmZ4M157g9zvmZaNsOftYGEwjCvhAzu4zH+NRHV4KwKeLG7F830i1ti8mNTW2
 IOMXCcHUsOUB8fKyux71VXNbJXt6NrJqnIihLqvJGEolVv7wlMsJFeWR4Az0AVJ3HUYVEZ7gaUA
 /IAUyFlBmN5aa56MvJrDujl7hSYTa1QDvAMQZzbPeakp7GsaQvUGqP+YYsUUdaU5RSeJeUaJb5k
 HdVMHwa7sVPsz1GweATeGl2JNQshTmxah0LsxAcpXoB4x5eW0VifkJzrAkQrGp+gIqd4rFCKbkn
 Ltk30j3PfGGfBTtf7x23kpimERV/bJlOXV9dA==
X-Received: by 2002:a17:90a:c885:b0:39d:fcbe:fdcf with SMTP id
 98e67ed59e1d1-3a4d0f0225bmr2188670a91.1.1790808278381; 
 Wed, 30 Sep 2026 15:44:38 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH v3 52/65] event/opdl: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:10 -0700
Message-ID: <20260930224340.58580-53-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

