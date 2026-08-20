Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC8FC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F29740E64;
	Thu, 20 Aug 2026 07:26:13 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 4D94B40DCA
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:09 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2236563a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203568;
 x=1787808368; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yNGkifjt2Ph7ZrJrqZ937s59gZJhKcp24YmtHqhPGcY=;
 b=lg5ZZioMhs5ILiDkE+47GV03ydk46SlAHK0sUtoyNh+/rN5CvWisdTJIXeYjjwvrPT
 VYPm8+SDwxUkq43aApC2RRaPaPpX8tKzN881adcz7ZSlgoUEJYfI4L9SFNz2JL9TIBKm
 K9wXt0cEu8e5gxos2rbIJTf7Sqvpmd8K6IqFeOBuHCrYRnwe2boXdMV1KJDWdGxWFlE4
 jl0Koy/iA4Bylwk0QYmQfAAkSEhlYJrXGZBij9UPz4t9CjH4hhIvkkbmtvsZimSwpEuT
 t4QOsRhDyBfpoGoQiRw257qo3KRe7iLERCoA0JCRitbyt1H5qYQuaFvQb64WIqtxgijr
 NPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203568; x=1787808368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yNGkifjt2Ph7ZrJrqZ937s59gZJhKcp24YmtHqhPGcY=;
 b=bOaVRBPUvpk22NdSndwBOzPldKNhR6XnPmm3JqNV1C5IZOyyFzJP+FuwO/UKHTrPY3
 Qdli/kUbgqIw5GEqJv3lzWlEQmHWLAgDaP4x8XR6lGW/oGdM0QHCjOQNh/0j+wUgkYLi
 8BQzxOdNt3nzrTiuVPnh7t2zGgWVpfIwpqrz0Bdg77+Zn1vGatxTxtqoEdvhGLwbeSke
 OZjJb395mk3xwJ35IdZc/EKPD2vvRBsuhSHDrJyvcsE63LbwJJVd5P8d3BraK+Alu6VA
 eJ8RpvA32WwDiecsoQS5WzSPP8/CvPw++JOkHki3GAntE/SGamkZ3ucFVRar5d0QXG5W
 TpNA==
X-Gm-Message-State: AFuF++nZ0TJcIbMdpQvaQVyC4e1jL7/2UA8lf/iGR9Bpz6hr039VPhOa
 U2//dilMNyopiOLBqm/aNFtyAg5U5J8GaBFMJh23WvfcsVe9jqsexzv7x2fSeR+KhOvz1O+A58O
 OEHgG
X-Gm-Gg: AR+sD1360rLHnFd+HaHpeaZBTMHnFac5wfQF5zEyyA7GVgyTxbA1zDbBazsKu8S78ej
 fgvDjIYD6/j2B0thKtTVvLPDkH2F1S7nfwv5BtzBW43WaTOgMpgoYecHmTucOuxnJjAknsmvOxY
 l+tBD1BBRohJyiItZJFlmCQ7o4LLzOeAj+7mEimCFjwi92BNxdbxD8aV6AR81VtU5LiA6vlhahl
 wSbptiRUXaNOEbc81G5yU+eFQwmFn+UbI25u71z/8xMY1+VhryzP6TiPryyWgLG4zgdAQ9LxFSq
 hBXIOt65L87qIWGZuR2B6JumPcY0BFRvRz1LPTSXhJru75d1cuz8aGP/MftFLp79ckL3jZjgJ3n
 IWm3e8kOwv+P6PF/DlAvggrtqAS90SuOf4+Tdw29l5UYhgnbJUEOL2IP8IPKGTh7GY8A9QqOH0x
 eDOjl6VMTY7deQJ+Idz1QyWLlN4jMX2TvPnZoUEIr/j7nrGvMWDCHCRq9kUhW5xSlsJyLf55Dii
 wqvHQLx9t5s2oc36xd3T1gE+T0=
X-Received: by 2002:a17:90b:3c4d:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-39580f04a50mr19021956a91.6.1787203568359; 
 Wed, 19 Aug 2026 22:26:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 51/61] drivers/event: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:41 -0700
Message-ID: <20260820052251.1453273-52-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/cnxk/cnxk_eventdev_selftest.c   | 1 -
 drivers/event/cnxk/cnxk_tim_evdev.c           | 4 ++--
 drivers/event/dlb2/dlb2.c                     | 4 ++--
 drivers/event/dpaa/dpaa_eventdev.c            | 1 -
 drivers/event/dpaa2/dpaa2_eventdev.c          | 3 +--
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c | 1 -
 drivers/event/octeontx/ssovf_evdev_selftest.c | 1 -
 drivers/event/octeontx/timvf_evdev.c          | 4 ++--
 8 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/event/cnxk/cnxk_eventdev_selftest.c b/drivers/event/cnxk/cnxk_eventdev_selftest.c
index 8f3d0982e9..adef6b3f2d 100644
--- a/drivers/event/cnxk/cnxk_eventdev_selftest.c
+++ b/drivers/event/cnxk/cnxk_eventdev_selftest.c
@@ -13,7 +13,6 @@
 #include <rte_lcore.h>
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_memcpy.h>
 #include <rte_per_lcore.h>
 #include <rte_random.h>
 #include <rte_test.h>
diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 8cdb8a72dd..a523b93d24 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -141,8 +141,8 @@ cnxk_tim_ring_info_get(const struct rte_event_timer_adapter *adptr,
 	adptr_info->min_resolution_ns = tim_ring->ena_periodic ?
 						tim_ring->max_tout :
 						tim_ring->tck_nsec;
-	rte_memcpy(&adptr_info->conf, &adptr->data->conf,
-		   sizeof(struct rte_event_timer_adapter_conf));
+	memcpy(&adptr_info->conf, &adptr->data->conf,
+	       sizeof(struct rte_event_timer_adapter_conf));
 }
 
 static int
diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 084875f1c8..7e781ed920 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -1832,7 +1832,7 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 	qm_port->issued_releases = 0;
 
 	/* Save config message too. */
-	rte_memcpy(&qm_port->cfg.ldb, &cfg, sizeof(qm_port->cfg.ldb));
+	memcpy(&qm_port->cfg.ldb, &cfg, sizeof(qm_port->cfg.ldb));
 
 	/* update state */
 	qm_port->state = PORT_STARTED; /* enabled at create time */
@@ -2026,7 +2026,7 @@ dlb2_hw_create_dir_port(struct dlb2_eventdev *dlb2,
 	qm_port->issued_releases = 0;
 
 	/* Save config message too. */
-	rte_memcpy(&qm_port->cfg.dir, &cfg, sizeof(qm_port->cfg.dir));
+	memcpy(&qm_port->cfg.dir, &cfg, sizeof(qm_port->cfg.dir));
 
 	/* update state */
 	qm_port->state = PORT_STARTED; /* enabled at create time */
diff --git a/drivers/event/dpaa/dpaa_eventdev.c b/drivers/event/dpaa/dpaa_eventdev.c
index e5d93afca2..bea89cb12d 100644
--- a/drivers/event/dpaa/dpaa_eventdev.c
+++ b/drivers/event/dpaa/dpaa_eventdev.c
@@ -19,7 +19,6 @@
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_memory.h>
 #include <rte_memzone.h>
 #include <rte_pci.h>
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 95d9154b11..f6fecd9740 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -20,7 +20,6 @@
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_memory.h>
 #include <rte_pci.h>
 #include <bus_vdev_driver.h>
@@ -159,7 +158,7 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 					"Unable to allocate event object");
 				goto send_partial;
 			}
-			rte_memcpy(ev_temp, event, sizeof(struct rte_event));
+			memcpy(ev_temp, event, sizeof(struct rte_event));
 			DPAA2_SET_FD_ADDR((&fd_arr[loop]), (size_t)ev_temp);
 			DPAA2_SET_FD_LEN((&fd_arr[loop]),
 					 sizeof(struct rte_event));
diff --git a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
index 9d4938efe6..8a9a14f628 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev_selftest.c
@@ -12,7 +12,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_lcore.h>
 #include <rte_per_lcore.h>
diff --git a/drivers/event/octeontx/ssovf_evdev_selftest.c b/drivers/event/octeontx/ssovf_evdev_selftest.c
index b54ae126d2..c0a0c789de 100644
--- a/drivers/event/octeontx/ssovf_evdev_selftest.c
+++ b/drivers/event/octeontx/ssovf_evdev_selftest.c
@@ -14,7 +14,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_launch.h>
 #include <rte_lcore.h>
 #include <rte_per_lcore.h>
diff --git a/drivers/event/octeontx/timvf_evdev.c b/drivers/event/octeontx/timvf_evdev.c
index b404b1db61..712e2bb973 100644
--- a/drivers/event/octeontx/timvf_evdev.c
+++ b/drivers/event/octeontx/timvf_evdev.c
@@ -42,8 +42,8 @@ timvf_ring_info_get(const struct rte_event_timer_adapter *adptr,
 	struct timvf_ring *timr = adptr->data->adapter_priv;
 	adptr_info->max_tmo_ns = timr->max_tout;
 	adptr_info->min_resolution_ns = timr->tck_nsec;
-	rte_memcpy(&adptr_info->conf, &adptr->data->conf,
-			sizeof(struct rte_event_timer_adapter_conf));
+	memcpy(&adptr_info->conf, &adptr->data->conf,
+	       sizeof(struct rte_event_timer_adapter_conf));
 }
 
 static int
-- 
2.53.0

