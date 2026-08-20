Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F681C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AD1F406BC;
	Thu, 20 Aug 2026 07:24:08 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 7DB394067C
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:06 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so1690084a91.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203446;
 x=1787808246; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fZZ26sHsFrrQrWLcA4MWbNCbw8+eJnOIrl07RqDwiK0=;
 b=QzJ6eTh5yCPGIa3bm7MVQhRKDdKwiUOQglVJoJpSjJghwEWfWb7l7SfyGR4JtSh/o4
 pYHI73rBXBcS48Wo4oIVc4DGXTnP6c10wfej6zu3+2i2u/UDz94F0Iq54WQLA9uVMX8X
 JFXjB2UoLQC6tXm8tDV6+JcuVIu83IbIOefU8hcDyM1KS0uejchM0J+7g7NsjYYfKF4w
 IcPqaFZemn70ifPcUfoOeq+R08dEsNNh34pzmwrBy/NiEC4ie4U4VyoFEkT3jHVmUdSo
 8yGaFMGxU+2eaeZf3oZarIiUATSpbfm3JBh2B1ZMkk9+9xALjMwR11gsKvYLeXryH5Es
 LH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203446; x=1787808246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fZZ26sHsFrrQrWLcA4MWbNCbw8+eJnOIrl07RqDwiK0=;
 b=cB1nQt3PnkQiBfK3LgTUNDMZ1kot2doG34tEV5SoZ1I6PbYNQKvS5q5oBRF1PNaVaI
 SNsSqPB6E1T5jUv2KMiUkJpTdrovHWUjy/5Gt9Dt5B1nAGl1oM6nwJWGi+37OUM3rxIq
 d27qVDLJNz7VMMTk3HfZCIVbJ0D+qeTw1xbXXy46F+6siDCW5RtsSlQ0l6X6M9a6/2mF
 OJc9HQ3ag4dMULH+x8AeFVyrl7A7zKe1PDY9Bveqj3CybQJj6VmU+l9NmSsGDJeQRrpV
 qO67+nFedm90xEGkjuaDR4ZJexPUh7gdt0xDfcDVJSEJ8wi3v+l8N3S2WVTFX1kd5qxk
 Drtw==
X-Gm-Message-State: AFuF++lhNPcIcHd9lQCBu6QIy9a9EHcVHwp6blDNcppdArwvj+B4BFRn
 KPJFy8sR7r+ssEHRAPD7UvjOWoNzFu3/Z8lTJN1oT1Y8z0f+cOppxzDP4JicCUQRWzsJR8X+2FK
 JXJQn
X-Gm-Gg: AR+sD13Gn6ZMdfqvHze4PaxJV3U88XFAlVlcMq5nkOiimKcZAAMrxniBJlTb6rZ6qk0
 u5JkLlqcCeQMFXEVeRKSJpVPX0y/i181ZBUG/g0ODxcWdaUIerCi6KLhfaq5ET83r0ujygPFu1j
 A2WLik3zWtyPHTFbewJw2bPVHZCJMNhSv+tzBLK/bNhJepxc2GcdG5EwTLBRWGohFIeTA2CDBhW
 XpFS9rGrFki3zDbXeYjXzVVEV94Rz/OgEsDBHkBAB9CCnwrf064tmRELx9wxQ6J4w5qOBnDsWjZ
 4kjywR5hrJHdp/PCDwuW3CKNvtB9c314oHAmOwLLjg82QBlQkBragBm7SDOUqAgTg64FRqd2jfb
 +qekThmQCBJPJY6R15m30kk/yvgBSZ9K0vBaxmFsdxNpxhLEA3Mk5AAz2F6NoInpVT+X1FDvhU2
 h2z/wpHyYBO3HUY+DQGawzVJDEZ+fnmL2QtVxRgx2UeqNZ5apcllI0vcKreVitrtZ9ytXCuGSFr
 gp2CqYUS3iWMtDmNsoHWa55u1A=
X-Received: by 2002:a17:90b:1cc8:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39580a5052fmr19400011a91.4.1787203445616; 
 Wed, 19 Aug 2026 22:24:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 16/61] test-pipeline: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:06 -0700
Message-ID: <20260820052251.1453273-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Using regular memcpy is safer and as fast here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/test_pipeline_common.c | 8 ++++----
 app/test-pipeline/config.c               | 1 -
 app/test-pipeline/init.c                 | 1 -
 app/test-pipeline/main.c                 | 1 -
 app/test-pipeline/runtime.c              | 1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index eaf895869f..dd3021fa79 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -153,22 +153,22 @@ pipeline_tx_first(struct test_pipeline *t, struct evt_options *opt)
 			mbuf->pkt_len = pkt_sz;
 
 			/* Copy Ethernet header */
-			rte_memcpy(rte_pktmbuf_mtod_offset(mbuf, char *, 0),
+			memcpy(rte_pktmbuf_mtod_offset(mbuf, char *, 0),
 				   &eth_hdr, sizeof(struct rte_ether_hdr));
 
 			/* Copy Ipv4 header */
-			rte_memcpy(rte_pktmbuf_mtod_offset(
+			memcpy(rte_pktmbuf_mtod_offset(
 					   mbuf, char *,
 					   sizeof(struct rte_ether_hdr)),
 				   &ip_hdr, sizeof(struct rte_ipv4_hdr));
 
 			/* Copy UDP header */
-			rte_memcpy(
+			memcpy(
 				rte_pktmbuf_mtod_offset(
 					mbuf, char *,
 					sizeof(struct rte_ipv4_hdr) +
 						sizeof(struct rte_ether_hdr)),
-				&udp_hdr, sizeof(struct rte_udp_hdr));
+			       &udp_hdr, sizeof(struct rte_udp_hdr));
 			pkt_udp_hdr = rte_pktmbuf_mtod_offset(
 				mbuf, struct rte_udp_hdr *,
 				sizeof(struct rte_ipv4_hdr) +
diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..f4d5d435ad 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..8028192306 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index e5efafdf28..5782c55032 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -19,7 +19,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
index 752f783370..a6457488c0 100644
--- a/app/test-pipeline/runtime.c
+++ b/app/test-pipeline/runtime.c
@@ -17,7 +17,6 @@
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_eal.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
-- 
2.53.0

