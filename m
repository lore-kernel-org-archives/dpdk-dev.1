Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B17EDF17D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7701140653;
	Fri, 13 Feb 2026 18:03:46 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 01A5C4064E
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:43 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-482f2599980so13059785e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002223;
 x=1771607023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=LZkcP86gAJYn03Ozoi25r83oFutX4i9gYakjlS/9L1ATPY9JGDIK12UmCzbO8R0CYc
 zr6cOQqrMAXx1uFrXa3dS46ZtH9Euz3W12m1zegucDCXzcStuajvBx8znc+iUYWl96Ai
 3/rHjjeF+ohn2LNB/2wCVvGteNHb08J6N8gePUhkfwLkl421PgRcjUAE1L59CahE+v64
 zci7p/VdNI9XKS6BVe1HM80VNB0X6+m9j0Zgfa0MQvW4sY14+8h6CwOy8RzW7dh78GdO
 UsgsbLFAY3CRJGliingQJiQfLixsPVrZj8q/kEs9R5dLJHGsPiv4KOdpQx+kWdFd2X8B
 FeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002223; x=1771607023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=M9qmKjDpWZ/jlSYJXjsM7e8Ibe8x3frFNwUyCXrP+JocsrjFXLnXgv3KY3VDr/N7M/
 DiiW5HFh/auEuaJY/SN2zwNKlKShgu7peu/a9czPIkNHYsq8CzaoXVOFyZj8NxLuQjw4
 kZ6ZpZnsRWlPH+JyDX2FT5aI9GjRMeufM/f+rrKbT8d3tm9cE3R8bSzVSrWAp2MoM6D2
 LPCzOUmJcVvzkOximFV0gs/IfaYZvnVOW54fFlYlRajwiyaEuC+keUw7zTuaX90LpFJN
 Q34/k7X0kd+KpVBKSrfW7muDOyHx3ndQqsh5ZJ9nKjoAOsqimbq/b8kw9HljCcQchFVt
 vPeg==
X-Gm-Message-State: AOJu0YydFDJGLROL+1hRXsgBFrgSCMpSuRPjveYEiYLsNhVG+bMjdT6K
 WhPbJkqFydrzE+7xyBmeie1E1ZSoQL3DB/PyjhENANkrg81QNY9u3qWM5P1gOO76zllv/4CQP0S
 +cg2L
X-Gm-Gg: AZuq6aI03xZ8PpG0LsnSBR5y9x9ckr77ZJ8LhEXwQiLJ45tUVZauIoQjddOMbOyfbgZ
 oxRxGO0igbempdByUT7E5bWDkWaRI44ow9pkEJdcRUZjq2ZOlAPjT3QnzH2IxlVFxvHB1slsflC
 K3vJNgsfhydu+VC5yPOOvU7hu3O2gFc2e5OM+Ce12ctpTMITILHDhj30g8BjcxDTJQpIqs7IxgR
 IbTi2N+j+ismPCNVRLA1cp+KgndeG7K/FfqvRQtVUH8clcAsaPdLNnq9AqT75Oo+tboYNnT/n0K
 khEyGy7SjUJfWuURAVSp218ZrgyMvUkQIjnL2qSvOV9qShkiVPTFbdbgv5RRA6L/Y5B0AbYHDgV
 GSqCpdcv0inkFrM5DEmLYfC/EmmCCpXptbcvhxy2g/X7PSnw7Cg2uwx/A2AgZ4RUc2QQ302TWJP
 Q2SBH4tmmLQ755kh1CMxWtDhYJddmSwG0ZuzqQW+wCbQ/jtRAcTvWg7omBV4FLuQ==
X-Received: by 2002:a05:600c:1381:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-48373a1bbc4mr41130665e9.9.1771002223496; 
 Fri, 13 Feb 2026 09:03:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 03/18] net/pcap: include used headers
Date: Fri, 13 Feb 2026 09:01:26 -0800
Message-ID: <20260213170333.40089-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c | 9 ++++++++-
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..4513d46d61 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,23 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-
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

