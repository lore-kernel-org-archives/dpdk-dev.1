Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF6E83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB8CC40663;
	Mon, 16 Feb 2026 19:14:18 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 6D76140652
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:16 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so2376506f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265656;
 x=1771870456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=wpQzkZ+mbMcuPh5vpxRDn4U/+L9Xrk3+bTFjRMUpgz7LqKbTbPSueL24gf/avnb7Mw
 gdx6GBbCkaM626zvvvXZdj0uPKkrxV/1kdhhAiVrKwbeUul5G3G3LN/ajjF8icUJOwzU
 w3+ZELflFoVLon6VxR18lmg4nA9W9PPs0lmr/HS2iSJY2RPUSBbdM6ZxfjbdRztzsNRh
 XArWJD6/SX/o3E2pWDj+J0uYCMR41REiVnb5Z5MWKWRZL2NEQSmKRuvOC5FJlIG9dkpQ
 5gkx2r48rZvNzsRVepN8renCgexkoJ4wxfaiGvDSIoIUa6pzlKI1yEalVeRUtUEMs6wH
 oSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265656; x=1771870456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=jLMOHsSVURAvMKO1sQf2Sh18/byRQVG7H7UyncwZrH9mtcddICJzOv7CjKYFZqPGJY
 LPPeIXqjkqZVOEzXt4zdHOfaWtTZRwM8a/FCD2P7McFMb1x67FkJA8X1ihDDdrPhEmt9
 3xfeGqM3GJ379J+HHdNOHQtPtRaxNGW67ltBJh01vwi9A6YSQZF1I+lw8OmMxE1g3dk+
 KkQCUOFC3ujXAelxd8QNGuFNzeypeSabg25LCoWYvxbD8mRS2ygF+L8DQd3pJF0sOhg3
 S8POJ08Itchg+P+dyA8lUf3gsR8DeaW/MPwUNogbCmCsZYDhdDMmGi7FaSvsCiVQCmnd
 GpqQ==
X-Gm-Message-State: AOJu0YyDVRm66rGmRb+hIKR/BuKJAzwiIlHJ6A2OvCsA/LAOQlK2XXkg
 9rAXmosPFWeL6JZdLJyJU8UEdN3++JCqc68vG3jOW63hp1GK6NQht2cyRxxcFAPo701dFrGJtJw
 zxQL/2os=
X-Gm-Gg: AZuq6aKoYq1AxIHqS3kVGPKSbC8i2knVG54YcBam2MwftXgsAZdKRrjOltbwtA2Lcp4
 lCbWZhdLaR5CA07IaxqBzM/m0MPkgG4vzYgBBxlOaXq8oJzYaKZZS7dFEL8Ddbc9e+t/mrPnS1j
 SvmyyFa8gZJCWK3ZlywmBFxNOgDfZv7Ky851dsiFqSSApoUCEXoCp/9OCLOR5npN6Uan9ogd44v
 KDsw/pJ7n3f+16OtlQjFiDltvHOPZo9skweGXt692IeQ4wLFtt/Xpz4eIOxWrM/vYGFzt7ZA5gT
 vxDKiqp87LJf4tp+VHESEV5AMjeWjSh4sAWrfv9NudyZ0m0BrM0ZjLvqkv3Gis6nHesMZNMRLTP
 h0/hxUxL/MT5joaw9cHT9W+0N0VzFXEukXuX+mG4ouYHF4tJZ+biXCqCqN22qALReHZO0XHcc5M
 +ua2zaTN1SggYA7hYBnekJUl+HAYUOhfrX7NxU5o1OsWufye/CEfJazEWCr5C6OQ==
X-Received: by 2002:a05:6000:230c:b0:437:67b5:9bab with SMTP id
 ffacd0b85a97d-43797929f6emr23264225f8f.56.1771265655873; 
 Mon, 16 Feb 2026 10:14:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 03/21] net/pcap: include used headers
Date: Mon, 16 Feb 2026 10:11:58 -0800
Message-ID: <20260216181407.428877-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

