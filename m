Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC43AC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 954F842DD5;
	Mon, 14 Sep 2026 07:52:28 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id A4DD142E1C
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:26 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso2788364a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365146;
 x=1789969946; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guZ8S4azmX4NrZUpbSMHrMvCp0ZPWqAiivaQCxy68pQ=;
 b=Vux0n5mlRIRIPhkUQs2dT64gU77Q1ROTzEGfqM37UHcjzwPY0r76i2eqpZ/1bwptTa
 xtIybdVwhZAtJnYem1PEjtDj9SzwuWBW4NZrS4QbdqqsmLqZqY5c/uc4V20v3IVz4yX5
 0htX8JpWDiNW4t0zlixZqzWZHGv6rfm//tuqYLhqwPwIKlKrHd4lGc7ZXsndCfQXrmE2
 fZkR920yp9drkQoSg6//XGVckNw0OXLZcQFEJeJ3UZScDHEBeUvb2AfiC2FLoaR47EBt
 Q0c7XPlkY/wcBDs5CIG2Km8C7OesoUdo0N6Dv+HZaPftc6nV0fiCppPUnvo+3W7zlxAm
 SgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365146; x=1789969946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=guZ8S4azmX4NrZUpbSMHrMvCp0ZPWqAiivaQCxy68pQ=;
 b=WC4U3EV3Imguh2ZhZQ03pCvliYKDrbITxygxfhuOLpN3xAEwLpYkkSwXxZ4fMjqkrY
 7VRz37S63oW9KamHmidGsv7/pednC0y/w2j0e4+sS/WONfz8jlKVRMr5+HwCH68V2KKx
 I70X6y1bCHOdUSFMIghqOavOO4r+qz1YcXxqLock1RNaqcc8I6YFhw2MORYItyOwo8Yu
 K/83VsIqouWemB3rHRpFbwpVM8OeWYy82vkGHS/uCHu/I4z3nLS6ytYVemal8g6DUjjq
 qkSy8UHe3h5vkKNwfcnI9ni3kc/rlroS/vVSoEcSi/gsNAtjHEQIBSl53RtqzO17pin8
 ApNA==
X-Gm-Message-State: AFuF++m2tIVqZESDkAI9YXE3oPfY9a5d/RO0PElQDAlr1xFENkqs2pf3
 TCJd3pQgoW7of321giEdDMPZSqkLekzMMx8gaRm/KyhL7MYDRHcwiFioO5kBT70b9bb9PSxSlvi
 mnbUTcjI=
X-Gm-Gg: AYBFou1qMbGCYc1jTyK2bGzXckY+ZiiePzmcfONvydezD5DxJAuqsMmus4j1aJ6XxdZ
 YAeSSLBPGrur5DqOfjRW3NVYFztbxJkeYxog1UxeI1zM1rykAZWScgXgB6XTPyhaSQ/y/RH8smZ
 5YyLQvbIKHPTtFooq+g4BtmnyrHXwXalnhQ0zvTibgThaSOyEEJdCrLXqCgZ1Ex8gkx6ipvCqzS
 jNynldR06Fy8aq5uwePFDXm67qTUeTZ2VZvZjWWUlrf9Yo151oW0JeErbvXReCwXkFrKbIOKgRn
 iTMNoKzAQUQiJd+ZPJPcoeRUOuC+VmN6fCwV4s6yqKm3nrxgEwvOkNooI87z40GaozeGySqc1p7
 ampGja2jHOpl6wLA3/ppA0EBbtvgJetbvMfZLFDGJqT/wPsSWZel6XS+INkhPOCXdt+gnW6nPlm
 6zPzGFircnMxq+7JiNsAiO/rqt2cjQzkhcvi8/nFRtYZAB24BppqZikJOtiuiDw9OczUdmH6PrA
 DuaiD7KTNQiaqJ9SWsgCbT1TP4HIG/YMejM37Q=
X-Received: by 2002:a17:90b:5410:b0:39d:ec1f:b3fd with SMTP id
 98e67ed59e1d1-39dec1fe307mr1638938a91.8.1789365145737; 
 Sun, 13 Sep 2026 22:52:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 54/62] event/octeontx: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:25 -0700
Message-ID: <20260914054912.755403-55-stephen@networkplumber.org>
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

