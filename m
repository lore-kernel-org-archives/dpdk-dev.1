Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFEBD1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DDB3402F1;
	Mon, 26 Jan 2026 19:08:21 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 2ED02402E1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:17 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2781713f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450897;
 x=1770055697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=LlcN866WKXbpK4LdAjzl48a19g9S1+u5lWsG1ikC42Da2e8aIc4e2bn8Xb+fE6Lob4
 7I3u+DOM/1hmq/bMAMT6gX2WJKRen1FuHtT3kuS50UPsYuHTmex1C5PeAwq7B+vf2X8M
 teTTabxs8m3DIB7lfogmzSeWOiYK6i+m8goql6b6l2G3rqfWHHWtooZilXASV5ff9Qhk
 kREIdSOjfd91FvWQpDG6nT3c2WHe8/AU1+zM2dGnI8rXS/VjoETWrF5vryLNFukYQwZW
 74qv9q5zZf70woz/CGT95OiTaEelXesg6Lx709gOAZRUh9yh7hhuxGuWq/sBbmMIQAmN
 npUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450897; x=1770055697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=qpB6TZxKWS0H00iHW67zSrQUZIs3rB2uciVQ4tRo9zgGgwR4+9hlG8HY7rF5T12JSN
 1ND+u3xSt/LQ7SUppAQe/kU8b+oPvcPA8SCq4SqvgKqiUNGEb2I6LQMcrkZSCl1zpjBZ
 ohFWPqThUbsx/LNMidRp4ML+I9NlpuZ0s2caMLo6KxDYN9q0CWVGF9h87aozqlI9z1wi
 /0aelg3kJeS7DCE4usZeOX2Z4lfVEiYLeyT+tF5TMcm8GD6LB9bCAG9iTy0KQS+UuRsS
 KC2oS3JZk4bz8ZeWRj2U1ss7woMusV0BYi5Ahmxwkce3zsrspzOiy4Y7yNJoBe/U5DSH
 dtYA==
X-Gm-Message-State: AOJu0YwYQOgo0OJFDsu5DpKnd3vE15xu2WFJYW1N90gAVWf40yWP/Wb5
 ShQqtCyWmh08YTNGnOSx2wVp6Cg3Dzu5En1Bb01lSSb7xa2VjIGmX8GMlGNneK+Y5g/E2dXu7Vy
 C8Mo+
X-Gm-Gg: AZuq6aJNOGTE7RZCIp7w8+8TH/VmmtodmzGknknC8v86HgMzNjcaO1v99gBvDDyF/7/
 3V8iBSROdQCZeivE848WoWR6ffzSRpjq/u9mdfqRIAUO0T9rTmnvivZw37oYKHe/Y/2AQvwQiZk
 Jt952lrlbmpC8dsMqYMaOiwr2ad629y/1OBH6GCczmUl5CYX80Gc50yCbrFtgGNIkuGWwgXq6t9
 n93knHihv4/bHEEAhV28zI9QIbl8/JcFo8HIkoKRnTCqwWgCseu9mt9rFGcYDK726/4mBWvw8VM
 P0nZ1TQnd6LtBRWVlH6RpUtjN1zg44wLknxh2RTqJEiKH24f4p9t+FPDMkjbRxy8X7/dTN1xhJN
 tKOTUuXmbkYcBDUO82/Jfw8RgD85bzPl6GXvx6IM1f7gKHC74oIRiHFEQxDwcQVHdKbYRRhG6T8
 v65oNRiX9UN7BVXbrYOgyKydXQxEfENQJe6pEXgVFmb7c+b940ow==
X-Received: by 2002:a5d:64e7:0:b0:435:9756:d4c4 with SMTP id
 ffacd0b85a97d-435ca147250mr8074417f8f.17.1769450896687; 
 Mon, 26 Jan 2026 10:08:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 03/13] net/pcap: include used headers
Date: Mon, 26 Jan 2026 10:06:40 -0800
Message-ID: <20260126180807.100891-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

Include the used headers instead of relying on getting
the headers indirectly through other headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 8 ++++++++
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..d09ba5abe9 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,24 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
 
 #include <pcap.h>
 
 #include <rte_cycles.h>
+#include <rte_ring.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 2aa13f3629..a0e2b5ace9 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -6,6 +6,7 @@
 #define _RTE_PCAP_OSDEP_
 
 #include <rte_ether.h>
+#include <rte_log.h>
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
-- 
2.51.0

