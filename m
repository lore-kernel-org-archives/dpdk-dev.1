Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F334CC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4885940EF0;
	Fri, 21 Aug 2026 21:31:23 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 231F340ED4
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:22 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1241279a12.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340681;
 x=1787945481; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yNGkifjt2Ph7ZrJrqZ937s59gZJhKcp24YmtHqhPGcY=;
 b=BFkK60MC/mnwzdKZQm+4Zmuus/cnPan3xef83rwhlVfaHPzTmEWahpHTQuf9GOuAKJ
 wmYXWARIJzPvRbzHSCQ5IJ+2lFAHzMsXOlt9K1PhUvMQ/PzmFK+ePF6l9qj9YXxZcUbq
 eJ8QJMa8+K2UMgCCwV/HKKOdo/PKnhSWAeVAEBz2c324+H7seR0LiPDRel4Jhd/tM2kP
 ttSXd7PN4VFPJGr60EYtrnO1zTt87XoOSWuFfI/mJ3aD0kc46oAeM2XQR34dX/6LblkN
 RZ34bN4qkMXJfobMPKms3zuUxzrYf+hoHpikCHjBENBWTcCQqDt6wEygU/bseigKMIT6
 X4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340681; x=1787945481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yNGkifjt2Ph7ZrJrqZ937s59gZJhKcp24YmtHqhPGcY=;
 b=pSJQppG37vYcNy/YS0FsL8QzUf76FCrjJwbVdumq6LJNEuK1L6C1rESXkKJ3mtUG2a
 GGWuTAJStrWm6hHgZjBwsQWNMMWT1ntQMpYtqOw/4GCDcJ0DIG6kyjDfrPtMdk/cMAOI
 Tclb41xeF0VC5T/jz54hz2tNNNLluuE/gQ8AOAIoMsV7NVzxYkVuR8w9HR9PSK8JbxBw
 1M/QtzjnTFhpJYE5sPCOo//IJvDe6PNLo/N7Y6AeiUsUDkMt3lTvoIyd4OSQY/JH0b2j
 yzvNVF9HX/IAbGGub9+MzEVylKIV8ZoZWUBS5C50W0uOUwsSYtniBbg6RlbMfgI4lSpK
 lPzw==
X-Gm-Message-State: AFuF++mVchC4ISEayTXWxOr3/Dbii7XqLjtIaEbY8laDfFKMTVJQmtnE
 qqdkU+bpG5lgt++eWj8Lf/6fyw4hD/mylHVf3dzAvBJnjholiKPAZ6DHy2+0/22pBiUqTwMBjJU
 P2teWlIk=
X-Gm-Gg: AR+sD12A7G+OyRUzXeZZaDl2l9tSDUc5ULa9ja7CpNhb2W4K9mL/Vwzht9DTIafDBIk
 ECnOCnqU3T2rSXmuVZssV7s0tcse5HfWvmyDxTh+Ids4XuSMrfNpRU5JJOS4tbPoUZ0lLWIr7ON
 WiGUVnIaGEjg8BoUoY0ujOLKMVw2/jdFku10XyjH5YbzCztm1fd3TwUDXGI4A3fD8cxLKu7DvEy
 hT+koaViGH6E6e0Yjbpe0XGfWBhAb3CTgFSD/oaRPH+TbNgx+yu6kjHELpySxNSVfEOvMIQgvQY
 IQjNcz5y/MkBMmQEoYdT+wPgPTANXYtdFFhrKvFGgy1g8U5Q4t8kc5X4sx4QgOL3Fwx2CeTgVKx
 9zP6Bo+7wvurj3CgIGQfNuPgXJ2n111EDawoeNi3JpuAkOol4haEixX/dHiHXDbpi0WH9JSGi2W
 apTmWKVDRmT90i82upRtij0nKFufnwE18eV8zcIaT3NTJAJBbzOKeDXS4s++y3JjYMdovebaNo6
 fjIRUzej7bTHGaaQAqsV6TCrNI=
X-Received: by 2002:a05:6a21:1644:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3cd3011c9e3mr18052444637.15.1787340681321; 
 Fri, 21 Aug 2026 12:31:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v2 58/68] drivers/event: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:53 -0700
Message-ID: <20260821192646.146382-59-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

