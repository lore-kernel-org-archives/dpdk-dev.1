Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8DD73EAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5612B40649;
	Fri, 30 Jan 2026 02:13:58 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id B125C402E7
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:54 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso13610965e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735634;
 x=1770340434; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=ifGbfSzzk3vktDhNCxDblLYvef81Abi4rIwujZP89lyE/4sXLRKTrXdiqT+Ctw+k+b
 kFSLZIx0Ui6w2v1kovLbh8DlHW+PmYiJE/2FbIRoO5lgRpeVF8r5gm74aFJotElVky0O
 zpSR1n95TTsPqksAfut47caECJyoNeeHepWbh//xfwbZIJ/OQQ9emwb+K2/XRpnAo6Q3
 TB2AMOsZLRcxi59XKiaCdz+NhLGRfqKaygkELHB8uf1C0GahFA51ljHuTKHz2c1gHaJJ
 gsgFH0D76gXZUAibhUo6czrDzNKm6rw9tYWb7pnaskq+EL4mDadHgIA5QAmMVlc+j6Rf
 GFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735634; x=1770340434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=FP9/gaCZMdrSGn3Kbl1yx74ct69e68x9ORTT1ysVEiQSvaMgdiGUcqp23QSHLY5YQ5
 /4I1hObIhti3b4UlGeVZk9dR1kpJEM9W8NCNOZh7a69aDRRBSVJ3NZOPqnxLMR03EZ36
 Ce0MDPzRX1hA2n78ilrVsWLMRGYmTM0GUYcF3t9cDgar61ls7HChEoSy/gDjhcojqhaq
 xoi4JRFcx89ao40Eg1nbqNVUGIyIak4NDbC2XMm8FQXvgsPaSZJHsOrzjo4YQUq+n6Mc
 WosN9DS8BJaaY92EZ2zd4HyiVhKvCD4XonrorB21XilLXKsl9Pr0rUGIuwTzHE4kezYl
 M1ag==
X-Gm-Message-State: AOJu0YzLwO+funGBfsmfL45aYbN2nZKUzPJocG1rRUSfILW8T0NDFnf5
 oQTq1g28nFPYH0fHRf9euP6pI7EowFkVmMG/B1jV7vwHH3Ef3El0kfo7KeYEc3eN0cfVnhIvSQL
 VM4MR
X-Gm-Gg: AZuq6aLmJK4lhqz+I6Pj2JYaOUF4IYCH+UzOSuJKEcEx0KsxeYE1AdqdZlfAPbNaLRa
 Rw7djxlguLQpCRe5RY6oiV4V25jhekmPgSZnK11NUKb82OzWN5xDN5IPAAafb+STop3k/+f2bHS
 R+G3XkN+IY9qNwjbBIHmfV7Ay1BgzrPrtn3GK/eYPTEmoZRTgR+2wZMrk32LG9qgfUQjtC2Wpt2
 09nWS4TxpGHMj5ptzvSWVtG1uPHjl50o+giOM/UFzhgKcYw1Ys/IkIGcWX2SXK3nMkhLybqA+Ts
 dZDlOXDurJEAuV8QPVsQlsw9ozOqUjGMzNWPh11Wwp6AY5hxOpXc9Z168Rnx4vlgY/UO2HhNUzk
 Tvgmo6pfhP40szcI6X2yTvqZar43tUm/beDWpvGi1AI9qKDScObMXYIl+m6GL+G38StAppKOkWb
 LvWZ+KxrepP3sRHoKpICCueU+FGoGrVPRSYK/HPQNW8zQMaFCGpQ==
X-Received: by 2002:a05:600c:348e:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-482db49ebcdmr13269855e9.17.1769735634358; 
 Thu, 29 Jan 2026 17:13:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 03/19] net/pcap: include used headers
Date: Thu, 29 Jan 2026 17:12:19 -0800
Message-ID: <20260130011344.204233-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

