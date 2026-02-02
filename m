Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B874E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111F64065E;
	Tue,  3 Feb 2026 00:13:00 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 2B1C440657
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:12:58 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43601e96f72so1286028f8f.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073978;
 x=1770678778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=GjjxtBbcujMj1OVcZWIXTkoqs0PL2J1vtREkZkCKD/TzyWzGbkn+AdF6xKzX21qsU/
 tO+8TDOD/tZTNSPQAz0Uo3cFqdOE5WmSApN0oqlQEFSaS2VVWdpYt5fJP1bpayQvC3Rb
 vn8thJknPt/DnssUmctDU0SNJiExPsvRJWdW57hne7lesPIQBMWdsQ9Psc4gELC4kO1h
 U2T/VqgQoAz66FkKYjcngsXCxnzenPwpbdMql9db38h0Y8cDJrQ9EVTNv3+E7FpMWqRl
 oJ1UOx8d6c4ian5+tfkvm+NNyQ6s813rVhONSThZv7RTzcNQAKDOewH4YQKiHMlV7s+q
 SXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073978; x=1770678778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=wZvoo/ZmXI0QIbJGmdvyAWSOTSKpXws7ch3bBDnG8pvTXYn1C3fAigQqVRnDvxlM4s
 gdzEzzA1B5kSRLYe58HP801QRXO34zhe0yoXDEZk38+sh/fwEhVXBNrVcxel5oTAJJrM
 +Yc0sNqsl64s0lAqBRlis385l45T4J0VmK8OjECtTQ/ULEKZwCnhoRMEwXgawQIJHTmC
 RWcQ/KAeJhN4YrncvJfcKJYzRK4n1lv9/03tiy9t2FL3JCfG3xKl1DDNwrmJkIAm8S7d
 MEQ7CC7G2St+RttwX8TN/3cBnJLSP/vIKZeMOcQqe8zjd4izWjkbF6L5hfx2vXj2veTR
 8vKw==
X-Gm-Message-State: AOJu0YwJiIw0HpZgwtsu0UfxlxiuBkMd2xPk0k3vMWik3rNJ+DO323Pa
 2FOQUl+oy3Ht2qI9Xb4/wAdAbb447Prq0YFN3Aab7GJQzmFmAPBxT1aNX1EKmWGVSxVxdKMaiqJ
 17EE0
X-Gm-Gg: AZuq6aJPJEdPtMv0JorZlqjiXeQO1Xa2f6eC9g7hYbJZXrjxxa2wRJdLcOzo0eYsOSc
 T9q/VDkab5UJhoc3jSP0x5bnI92N5KjpAaVPh2mmEKInnYsyOW91/eCS1wFOZGZ7U+uSY7Viv4p
 Kw6jpXnKmLsYRsnJVdfBEXe3CNpFqRnuot3zd0bli+Jq9Rp2Stj3+WK75gJ9QReDhuM4w2OCPt8
 kqCXC9ue+DhCRfgQJUaUPfCGBuXciRVU1w+mg+svUJ6ViMVyYEXq1EE0hsMojUQI/hMShilq2O0
 8AZ9DTPW4IlZkNfORfpq/zCamYTm7Yk+Qdvhrowf1hbRNRfe9v0UF2t+KSKahUrbzAACtutlPRP
 nXaNWIw3oAc2FBzLVpIDR46TXH2djw6GoIYGieaW93d03XUudh8ESxFrBrYWpF+s4rAuTGYQYAe
 42FfXPjGLWEqGqV2ZX8vKLd67LSLMpcLSGAngo2O/Qvkd4bkH+lA==
X-Received: by 2002:a05:6000:1865:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-435f3aae00fmr20329643f8f.52.1770073977678; 
 Mon, 02 Feb 2026 15:12:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:12:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 03/19] net/pcap: include used headers
Date: Mon,  2 Feb 2026 15:09:06 -0800
Message-ID: <20260202231245.216433-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

