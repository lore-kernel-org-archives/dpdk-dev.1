Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A49DCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02B3E42FD1;
	Thu,  1 Oct 2026 00:44:45 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1B85F42FED
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:41 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso2715348a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808280;
 x=1791413080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guZ8S4azmX4NrZUpbSMHrMvCp0ZPWqAiivaQCxy68pQ=;
 b=xirfUV++UOaBoRd2RMr76XxFqpgqDJA2rkzm6G9bLwj3EHV/0WJWGrNIsDOeWytfxT
 g1ph92gdnv05zYZBajnP/DBGr2eLrQMz41fQziuqim8pGMagU/ZUwrriPllepZ3p4iru
 Bmpf/BZFm+KtxYBkvU7QfaT1nw/gqmBDRdrQhNuSRGhmeGt9pIZ4fsvL37AQPQSQMmnC
 yzQbIWeiVSZhQeB7gq/UESo1DkkKb3yAPbuNdV1m56z1WY9a/O8IiB3PWpqzzuDw9JE9
 bcDXzuMHJyph0hDpmMssdPYB9gif1JB9aGqMmbbNOENftbdoH1ZjIODQh8eRZzPw1S6m
 rodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808280; x=1791413080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=guZ8S4azmX4NrZUpbSMHrMvCp0ZPWqAiivaQCxy68pQ=;
 b=OVcx7TxzcVBbjPYZn9tP8AW69ssxaO3JfkruFvA4iFjF76t88WoLyRmQ/AMaDfRR7D
 Mt/HZgsLkZZ4re0rAUFvEDzjqRKzQ+wht4yxmaLn9yfYfosoUIOmKhG/XgoQpIS42Bqn
 Ohpj9sZ2Qx4362nyCkNaPkf2hL2m/7nGe7NUz/WBWipi4ewI7YOAU9GsCqwbCW4P5EQh
 lam3bjyEKEkhRwN1JUlzee9adBW2vmTjVsqw10VBhXQ0HHd8/7zGZofRd06yeJbaCEcO
 /iM6wLXy99npWpIk5H+TQ/docbVNX8GsTLet3m2UlWSQmUlafyAlW3WJaIcDdpjMRNmV
 YsRg==
X-Gm-Message-State: AFq9FYLa9FGz4T/3Do9ENdEKEKxz0GZNlVWpEITn+m+3ydi/a5uVEjLx
 NChy/XRJBHfW3U4LTRW/mMNZdDjeK1yQ5TTIdPlvgFl5n+HabeBPDhGtvc6Dt0mnvRSxuKwnE9O
 RjyLTeg4=
X-Gm-Gg: AYBFou3lIbFgJfVRt0RvrLWNOFKDZZrRFKUfL5zxXHWaF/ry3+cfmyy3y7X9lBNA1WC
 QG+o1wCkyK9U6C3ACcwP5Fayr8z6Sygec7Z6qqYpGhMYUZGHfhAapsUEw1lrpSTALF3lVYUvws4
 8YKh1iEPnBR82e2NvZIZ4i7GXsXqcHkwrkqlghhGth1UJ0rx1wjmCsdydAx3zvY8EqRFRUbwyTq
 OFFXOr1wUFzkun72BGVnNrR+hnIJItX2Gq6VT3G74X4qWlK0acW1ccjZtD1+q5sLy7K8U93bxul
 S9NSFHsI6WYUnPgebw8DMCnTseE77cp0/GlYr5EUFL3R0nbR+a+hIuRjo6bm/rh7Q+p//sl1Ark
 uCYZGBLDHM4Ad+l+YocJR2iMJNskpyIZX4RwrDV4SbvpsU/ImFi1zZvKW1l2JxBwdbB7lmOkhRU
 /Kwf/fjlmZnBt/Amm66idBHnFJ9001LuT53jGejr/6jmjAzM5wP9xKjpF8E//0mcMbGkkUn89Jn
 1iDzEOjUGlgFHJ2qtUQH9NsTfeYlSGKWH7lB4KVTSyQN7bs
X-Received: by 2002:a17:90b:3c89:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3a4d197a32dmr2237254a91.12.1790808280214; 
 Wed, 30 Sep 2026 15:44:40 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 54/65] event/octeontx: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:12 -0700
Message-ID: <20260930224340.58580-55-stephen@networkplumber.org>
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

