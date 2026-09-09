Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F21AC79FA1
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 02:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2DC7402AD;
	Wed,  9 Sep 2026 04:00:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BCEEA40E09;
 Wed,  9 Sep 2026 04:00:27 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6891Urk81569093; Tue, 8 Sep 2026 19:00:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 VhbiAb+qgqsJ1HQXZI/6NBczBpLfbPhvDCzbLaX8+w=; b=a7thzIVubmzjTOtPO
 oJyG6wP0XnI6+pF1hi3wFc5n2AgRqtsrXhkfKluduGT/4H8P+KdPtSMgMcIDof5/
 9jCuEpbj6/zuISP0BMg0m2hn9Koa+C7HGTVcV3t4PhyUeTEi+pK2feIj5BguyBRP
 MVMcUm7IX7kVDe0UQTm7S71vDEAsnV/agn4DbsYQVHGloyC2HlDbpN+BP4BXdZY1
 kNxohQKPeNsmTjtR92K/Br82DZbPpHYiZ6d7O9/KHKn4+1CRNtFCU/Hs8xOHEP3W
 lIOBvuyShBQz2BDuTh8muP9jRVk+fyIW1r81cydjKtTIoeeWtKO+wTDH9XkrvlKU
 DfRsw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gjwuu01wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 19:00:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Sep 2026 19:00:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 8 Sep 2026 19:00:24 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id DBAC93F7072;
 Tue,  8 Sep 2026 19:00:22 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 2/2] event/cnxk: fix out of bounds access in eventdev
Date: Wed, 9 Sep 2026 07:30:11 +0530
Message-ID: <20260909020012.23261-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909020012.23261-1-pbhagavatula@marvell.com>
References: <20260909020012.23261-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CyaGJxzRxWbF2Ju0UXr72o_guD8M5MBf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAyMCBTYWx0ZWRfX8Nm+iZrSHeMW
 k9A+nEkivTpgazLb4CoT8iYu6XR9r1rw8Shu32WbcJonMpYnvAGQsjAnrNheqeqZU3ZK+1R7eiI
 PGLn7oQWI7OW5EdfnSval0avu7OiCis=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAyMCBTYWx0ZWRfX2dlH3nC5hJnk
 AEdtIqNq7u/r1VJMvdGGSycMwf7x8H7YHBRkKYtg+rVxrpZf+ltRXnd4ENXdrUYzgOkIG7U6wdT
 UOaT/0+GP8sAfXe5g/+nURpHbmjKGv7RRn8WxXGjQFYtDPH7Prp3aSosKI8WeDREH6Mb0rdejNM
 6aXqgKl4Pd9Og05VXBRB6kKuo0lKk2nFSF5tXlc76+fFqH6wB25RmQBvXHpgugFPL2Zbfh+mWx5
 FlX9PQm3kIYxG6yIyLTzKQoa0ThbNldFMaXrYZoRbxw8bW53Lfn3YR2PCKRZSIyN0XOhkbp6vsT
 DWV5Yt8rYN05gDeGGc40klux61gV8nFS51ikQlIBA5ckiJY4tQuKui13mHwxSFITJLwvKImOx6S
 P5LQ5S/nSsmW+DRfBUA2it8IBGUVx/+W2o3NdiQoBGET1jS6A7QxNCZ6hLQmYam3IgnxUooqRP1
 eebEahUTRr/7vh3dfBw==
X-Authority-Analysis: v=2.4 cv=SfzHsPRu c=1 sm=1 tr=0 ts=6aa0bdbb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=qlUbPKDSq1id5OQ9BuIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: CyaGJxzRxWbF2Ju0UXr72o_guD8M5MBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

The devargs parsing helpers wrote to the parameter structure for as
long as tokens remained, so supplying more tokens than expected
overflowed the fixed-size structures. Bound each loop to the
structure size and reject input that contains extra tokens.

Likewise, cnxk_sso_xstats_get() and cnxk_sso_xstats_reset() indexed
the xstats array with caller-supplied IDs that were never validated,
so out-of-range IDs could access past the array. Skip any ID that
falls outside the valid range.

cnxk_tim_add_entry_tmo_hwwqe() used cnt as a count of LMT lines, not
timers, when computing the remainder, so nb_timers >= 8 wrote past
the LMT line. Convert cnt to a timer count first.

Fixes: 38c2e3240ba8 ("event/cnxk: add option to control SSO HWGRP QoS")
Fixes: 20345cbda6d3 ("event/cnxk: support WQE stashing")
Fixes: b5a52c9d97e2 ("event/cnxk: add event port and queue xstats")
Fixes: 8a3d58c189fd ("event/cnxk: add option to control timer adapters")
Fixes: 822d4ef519f6 ("event/cnxk: add CN20K timer adapter")
Cc: stable@dpdk.org

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/event/cnxk/cnxk_eventdev.c       |  8 +--
 drivers/event/cnxk/cnxk_eventdev_stats.c | 64 +++++++++++++++++-------
 drivers/event/cnxk/cnxk_tim_evdev.c      |  4 +-
 drivers/event/cnxk/cnxk_tim_worker.h     |  1 +
 4 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/event/cnxk/cnxk_eventdev.c b/drivers/event/cnxk/cnxk_eventdev.c
index 41079af2a95c..e3a3134264fe 100644
--- a/drivers/event/cnxk/cnxk_eventdev.c
+++ b/drivers/event/cnxk/cnxk_eventdev.c
@@ -488,13 +488,13 @@ parse_queue_param(char *value, void *opaque)
 	if (!strlen(value))
 		return;
 
-	while (tok != NULL) {
+	while (tok != NULL && val < (&queue_qos.iaq_prcnt + 1)) {
 		*val = atoi(tok);
 		tok = strtok(NULL, "-");
 		val++;
 	}
 
-	if (val != (&queue_qos.iaq_prcnt + 1)) {
+	if (tok != NULL || val != (&queue_qos.iaq_prcnt + 1)) {
 		plt_err("Invalid QoS parameter expected [Qx-TAQ-IAQ]");
 		return;
 	}
@@ -525,13 +525,13 @@ parse_stash_param(char *value, void *opaque)
 		return;
 
 	val = (uint16_t *)&queue_stash;
-	while (tok != NULL) {
+	while (tok != NULL && val < (&queue_stash.stash_length + 1)) {
 		*val = atoi(tok);
 		tok = strtok(NULL, "|");
 		val++;
 	}
 
-	if (val != (&queue_stash.stash_length + 1)) {
+	if (tok != NULL || val != (&queue_stash.stash_length + 1)) {
 		plt_err("Invalid QoS parameter expected [Qx|stash_offset|stash_length]");
 		return;
 	}
diff --git a/drivers/event/cnxk/cnxk_eventdev_stats.c b/drivers/event/cnxk/cnxk_eventdev_stats.c
index 6dea91aedf31..d88e6130b9dd 100644
--- a/drivers/event/cnxk/cnxk_eventdev_stats.c
+++ b/drivers/event/cnxk/cnxk_eventdev_stats.c
@@ -157,6 +157,8 @@ cnxk_sso_xstats_get(const struct rte_eventdev *event_dev,
 	};
 
 	for (i = 0; i < n && i < xstats_mode_count; i++) {
+		if (ids[i] < start_offset || (ids[i] - start_offset) >= xstats_mode_count)
+			goto invalid_value;
 		xstat = &xstats[ids[i] - start_offset];
 		value = *(uint64_t *)((char *)rsp + xstat->offset);
 		value = (value >> xstat->shift) & xstat->mask;
@@ -181,6 +183,7 @@ cnxk_sso_xstats_reset(struct rte_eventdev *event_dev,
 	struct cnxk_sso_xstats_name *xstat;
 	struct roc_sso_hws_stats hws_stats;
 	uint32_t xstats_mode_count = 0;
+	int16_t first_id, last_id, id;
 	uint32_t start_offset = 0;
 	unsigned int i;
 	uint64_t value;
@@ -191,44 +194,67 @@ cnxk_sso_xstats_reset(struct rte_eventdev *event_dev,
 	case RTE_EVENT_DEV_XSTATS_DEVICE:
 		return 0;
 	case RTE_EVENT_DEV_XSTATS_PORT:
-		if (queue_port_id >= (signed int)dev->nb_event_ports)
+		if (queue_port_id >= (int16_t)dev->nb_event_ports)
 			goto invalid_value;
 
 		xstats_mode_count = CNXK_SSO_NUM_HWS_XSTATS;
 		xstats = sso_hws_xstats;
-		rc = roc_sso_hws_stats_get(&dev->sso, queue_port_id,
-					   &hws_stats);
-		if (rc < 0)
-			goto invalid_value;
-		rsp = &hws_stats;
+		/* Negative id requests a reset of all ports. */
+		first_id = (queue_port_id < 0) ? 0 : queue_port_id;
+		last_id = (queue_port_id < 0) ? (int16_t)dev->nb_event_ports - 1 : queue_port_id;
 		break;
 	case RTE_EVENT_DEV_XSTATS_QUEUE:
-		if (queue_port_id >= (signed int)dev->nb_event_queues)
+		if (queue_port_id >= (int16_t)dev->nb_event_queues)
 			goto invalid_value;
 
 		xstats_mode_count = CNXK_SSO_NUM_GRP_XSTATS;
 		start_offset = CNXK_SSO_NUM_HWS_XSTATS;
 		xstats = sso_hwgrp_xstats;
-
-		rc = roc_sso_hwgrp_stats_get(&dev->sso, queue_port_id,
-					     &hwgrp_stats);
-		if (rc < 0)
-			goto invalid_value;
-		rsp = &hwgrp_stats;
+		/* Negative id requests a reset of all queues. */
+		first_id = (queue_port_id < 0) ? 0 : queue_port_id;
+		last_id = (queue_port_id < 0) ? (int16_t)dev->nb_event_queues - 1 : queue_port_id;
 		break;
 	default:
 		plt_err("Invalid mode received");
 		goto invalid_value;
 	};
 
-	for (i = 0; i < n && i < xstats_mode_count; i++) {
-		xstat = &xstats[ids[i] - start_offset];
-		value = *(uint64_t *)((char *)rsp + xstat->offset);
-		value = (value >> xstat->shift) & xstat->mask;
+	for (id = first_id; id <= last_id; id++) {
+		if (mode == RTE_EVENT_DEV_XSTATS_PORT) {
+			rc = roc_sso_hws_stats_get(&dev->sso, id, &hws_stats);
+			if (rc < 0)
+				goto invalid_value;
+			rsp = &hws_stats;
+		} else {
+			rc = roc_sso_hwgrp_stats_get(&dev->sso, id, &hwgrp_stats);
+			if (rc < 0)
+				goto invalid_value;
+			rsp = &hwgrp_stats;
+		}
 
-		xstat->reset_snap[queue_port_id] = value;
+		if (ids == NULL) {
+			for (i = 0; i < xstats_mode_count; i++) {
+				xstat = &xstats[i];
+				value = *(uint64_t *)((char *)rsp + xstat->offset);
+				value = (value >> xstat->shift) & xstat->mask;
+
+				xstat->reset_snap[id] = value;
+			}
+			continue;
+		}
+
+		for (i = 0; i < n; i++) {
+			if (ids[i] < start_offset || (ids[i] - start_offset) >= xstats_mode_count)
+				goto invalid_value;
+			xstat = &xstats[ids[i] - start_offset];
+			value = *(uint64_t *)((char *)rsp + xstat->offset);
+			value = (value >> xstat->shift) & xstat->mask;
+
+			xstat->reset_snap[id] = value;
+		}
 	}
-	return i;
+
+	return 0;
 invalid_value:
 	return -EINVAL;
 }
diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 75414408776d..44acd4ef5170 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -471,13 +471,13 @@ cnxk_tim_parse_ring_param(char *value, void *opaque)
 	if (!strlen(value))
 		return;
 
-	while (tok != NULL) {
+	while (tok != NULL && val < (&ring_ctl.enable_stats + 1)) {
 		*val = atoi(tok);
 		tok = strtok(NULL, "-");
 		val++;
 	}
 
-	if (val != (&ring_ctl.enable_stats + 1)) {
+	if (tok != NULL || val != (&ring_ctl.enable_stats + 1)) {
 		plt_err("Invalid ring param expected [ring-chunk_sz-disable_npa-enable_stats]");
 		return;
 	}
diff --git a/drivers/event/cnxk/cnxk_tim_worker.h b/drivers/event/cnxk/cnxk_tim_worker.h
index 6a9099a23f3a..9e33ff58d683 100644
--- a/drivers/event/cnxk/cnxk_tim_worker.h
+++ b/drivers/event/cnxk/cnxk_tim_worker.h
@@ -726,6 +726,7 @@ cnxk_tim_add_entry_tmo_hwwqe(struct cnxk_tim_ring *const tim_ring,
 		}
 	}
 
+	cnt *= CNXK_TIM_ENT_PER_LMT;
 	/* SIZEM1 is 0 */
 	pa = (tim_ring->tbase & ~0xFF) + TIM_LF_SCHED_TIMER0;
 	pa |= (uint64_t)((nb_timers - cnt) << 4);
-- 
2.50.1 (Apple Git-155)

