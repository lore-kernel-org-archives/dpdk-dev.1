Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E11CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:44:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE6B42F8B;
	Tue, 29 Sep 2026 18:40:08 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id A991042EEF
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:55 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8805988a200so2865503b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699935;
 x=1791304735; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guZ8S4azmX4NrZUpbSMHrMvCp0ZPWqAiivaQCxy68pQ=;
 b=RBsoIGC4+gfXynFnm96Fiw3ohgVuSufVRPB+PrbJgGhD5wuU5uwCGAd04wlyfwFSAh
 XKRsUvm9tbkpO5IijD7vrh92V1oMg+9f1sMr/vVvMgDX8qSX8ART4Hfx/n+OlvNAoiEU
 sAJEO8011mSJa2L22eA37PuGaU7nsinq54Ua196QI22/XU9wV5VHFaAtPZYs+jnwBAvW
 z+VqveC4tqjy09Oj72D89DssD2zAve5MraQo36MZJ/S/8uhFla2VMwrzmwcfD2p5u9NQ
 WBaNHhZMcTszFK2Fz3h7Ln5gSJk2yx0LuRKDNzzNaHQaEeUEIwXcneFiua/neJOShGpn
 fHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699935; x=1791304735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=guZ8S4azmX4NrZUpbSMHrMvCp0ZPWqAiivaQCxy68pQ=;
 b=l92t57IaB1G2+q4PaTjLngixREkHBX8xvfnwKUgNtTu2zi9H5zpef44mI6CrhokZxy
 wrJ1RnCHrgVCmKshjg73xHe2higq339jAJ0AMGutq1YGIQYX1pI9ZLZeJD3ig71FiOaV
 psbbOf91ag57F0R0BZFH15GveN34DvJPbyBDT0SFs5kOsiHeKcWyr632bAagp6I9DIT0
 ohmmiiHyuYQk5RbP3CbCOxqoxXEmZlKrpubo8STWTG1UzhT35XAPkuGi6IC7pWKYT1jx
 262ZuHyEw5UDaHZYUxOZlI7eahQALnp7VAxyEEzJ1qWU5GPxzGQsY2z+Wtf708UqaZFS
 9jSg==
X-Gm-Message-State: AFuF++nMpSRpQE6URrJcfLfMYKooVkqDSO8h4IhqFf+aBsHm4n4MEjr6
 hz0NzodVUr4iXsEj0WMErqTGZ0J9e6SQGPqIFMoc6Sg0gy8QMWLLhx7ZHS8T2WTdyFvTm32BYAE
 2G2aQ58c=
X-Gm-Gg: AYBFou1x+1vHGzqqJWmKtX3RA/bC95Q/bwLdfweCUzBBwTkRrL49PB+jmFnQUsv0SMs
 nGZPaolqjg6qgokXGrXF/KVU25js55Mevs9YynRiPRCLLRuuU5Qx6mjkeUYyldQB7ySfvaKzpcg
 s8YhVfOLOEZlghmGqeBlnOy+G+WhAXxkeTbmOfsJ1RYlQkt4Ua2dc6jF0uuH0Rma8eRuJaEYgai
 qVSRJlHZWsI0qPkqpYIPR9hRlFhILrDp9kCJzn93Dv17EAGVujsLjxjfYpthAMS/S5TulM17Kv4
 t1R7AqKsBsj6p4KkeyeHKa4pjLI/XeiN+5H913XJJbzM+Ls6Z191rimS2TC++M9G3/K22taHIy/
 akZlMdexTIJHIE6h2Wui1QMuoJe9Hz4rl5i8Wlqpvo44+RZHOJbvjEs1cvJ26JVNCh4smtOAT1C
 5wjGKSrmRZKMWH0N+TN77iZUrKx2IWsCqL6JD4DzvobAeoD2Scyi8JDdV5wv9Yzq4TQjEPAsfLn
 j6KSHFBmebMMRyvcCvHijUS0obyxgekeUrzQg==
X-Received: by 2002:a05:6a00:b48:b0:881:552b:15bf with SMTP id
 d2e1a72fcca58-881552b1841mr8860483b3a.19.1790699934867; 
 Tue, 29 Sep 2026 09:38:54 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 53/61] event/octeontx: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:56 -0700
Message-ID: <20260929163800.1108305-54-stephen@networkplumber.org>
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

ssovf_parsekv() open coded the errno, end pointer and range checks, and
the value it parsed was only ever used as a boolean.

Use rte_kvargs_handle_bool() and make the flag a bool to match. The
documented "=1" form still works, and the usual spellings such as "on"
and "true" are now accepted as well.

The boolean uses rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/octeontx/ssovf_evdev.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/event/octeontx/ssovf_evdev.c b/drivers/event/octeontx/ssovf_evdev.c
index 957fcab04e..4a56d91bf2 100644
--- a/drivers/event/octeontx/ssovf_evdev.c
+++ b/drivers/event/octeontx/ssovf_evdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <inttypes.h>
+#include <stdbool.h>
 #include <stdlib.h>
 
 #include <rte_common.h>
@@ -23,7 +24,7 @@
 #include "timvf_evdev.h"
 #include "otx_cryptodev_hw_access.h"
 
-static uint8_t timvf_enable_stats;
+static bool timvf_enable_stats;
 
 RTE_LOG_REGISTER_DEFAULT(otx_logtype_ssovf, NOTICE);
 
@@ -716,24 +717,6 @@ ssovf_close(struct rte_eventdev *dev)
 	return 0;
 }
 
-static int
-ssovf_parsekv(const char *key, const char *value, void *opaque)
-{
-	uint8_t *flag = opaque;
-	uint64_t v;
-	char *end;
-
-	errno = 0;
-	v = strtoul(value, &end, 0);
-	if ((errno != 0) || (value == end) || *end != '\0' || v > 1) {
-		ssovf_log_err("invalid %s value %s", key, value);
-		return -EINVAL;
-	}
-
-	*flag = !!v;
-	return 0;
-}
-
 static int
 ssovf_timvf_caps_get(const struct rte_eventdev *dev, uint64_t flags,
 		     uint32_t *caps, const struct event_timer_adapter_ops **ops)
@@ -879,8 +862,8 @@ ssovf_vdev_probe(struct rte_vdev_device *vdev)
 				"Ignoring unsupported params supplied '%s'",
 				name);
 		} else {
-			ret = rte_kvargs_process(kvlist, TIMVF_ENABLE_STATS_ARG,
-						 ssovf_parsekv,
+			ret = rte_kvargs_process_opt(kvlist, TIMVF_ENABLE_STATS_ARG,
+						     rte_kvargs_handle_bool,
 						 &timvf_enable_stats);
 			if (ret != 0) {
 				ssovf_log_err("%s: Error in timvf stats", name);
-- 
2.53.0

