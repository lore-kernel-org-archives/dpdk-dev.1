Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128FC53216
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 712ED40668;
	Fri, 20 Feb 2026 06:48:45 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 02A6F40612
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:42 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8947404b367so20098706d6.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566522;
 x=1772171322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=v0CetoTe9sfVTp9ECkrBKCy/eyl9lTRTfGB2ltQXE134cHIX7anSC3mBVUyfSdDF/g
 6It9t9qTYmhyTUePPRZ2C7N1LNHgAodCdA0zBu/RGMosZ8emDSCS3tE/lopEea66/ODo
 dgl0ImWMC8d7ctYbtvRhD21nSYxPCWHr8jyV87hfioIinXintZNVBJbL9edlbAHgzL4/
 igx6WhoKyO1WIUlY+eUWV8ltTAVjCHDJi2EF37bB1MX4grVAzs0KL0gHS5r7m7tv+hFt
 ZrpHUsaEIN4uhMnskQBnvrX8bh2N09aa0VmYFDzZCcFGsjrQRwOebJ9LWhO25GwBLfhq
 M3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566522; x=1772171322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=QcH1F8LbDKnVEQn5wdMEBMt0d5y80uBmZR5lmJwFnebKZySNKLkTAHEU2ohqx9rSdz
 1Q1K0JN9/e8vxcWQTGsIIev7hY6lInmVP/dgxF8tewp1dv4BCTCoD/m5E/NR8j6+zUUi
 NV3uQHFOD6phssjMpON8sxcbc0hjd0aZXdqT64V6JG4zBozTZNH4LkAfN4Os/xlH8ip4
 CfCD4MW/6KBMEBg7wtvUuYJ2P94fQwiYECvRecbh1qRo4FVdRR/VO0JLQNIJpt399VVb
 DEZwlmA9zsWpda+L12zGKfyy/PidSCtDt/JDuvAz3sCkwduQ7lt+rSpQ1FOCY81Mr6Qo
 YiCw==
X-Gm-Message-State: AOJu0Yy0w2Vq0yyp+QZAv3WFzpNmzt+eE3oh9++EI4b0sP5TGcSZMv4n
 FalTT6TKkY8B4HZjy8FQ4HNCZQB0sflV6B404LkW8bVvkc2GmxHtQ1+wpz994I8xBZvVMRzHCO3
 odTlI
X-Gm-Gg: AZuq6aJ38jMnSjKu+Z46mjgS5gQFuFxz+S+5oFi7K5U0gKlL9lg/ALV3cMIvhOrtNku
 TTyxQNE1ohW7H/QGxUjA7KS0W9BOQ+aZdFp55kIQ2XHvhwAvOkyCsrE4UyT5o6vplWM4yWMq5bv
 Bi+6mQYKwyHFOcce4FOuhVdEanISby32HyJOXd9MAcP4CastrD/zHsOESxgLn/f9/5ReUYERI2h
 bwZI364U73hopju6wVPOlGK0t476raFSICRVlL/z2gksmC/sEv/4sAEBO5YM6ZFGON5jtV7j/jl
 fzDI0KTmZ6ANHVymlFiPOlLM8+8ljL+qRBMjL6VmksDR0XmgAMtTL+8IsV5OSnBEcNwvKuA5dVd
 t9ifCsav2+jGR9edKmF5h8gEE4WB16GNwyiT3ipchgvFLyTNxecofaVwEMWNL4EMvXmeSZ07vIh
 PUJhX2T7ItkOnbGWV3jN9fIG7B/8rZ00Qrv9/uOuuwBve6+t/tkB7gnP63GpfL9w==
X-Received: by 2002:a05:6214:2269:b0:897:3452:23d4 with SMTP id
 6a1803df08f44-8996204f68dmr78811196d6.35.1771566522202; 
 Thu, 19 Feb 2026 21:48:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 04/23] net/pcap: include used headers
Date: Thu, 19 Feb 2026 21:45:39 -0800
Message-ID: <20260220054834.1632201-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

