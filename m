Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3464CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93BD240DD7;
	Wed, 14 Oct 2026 00:35:16 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5950C40DCD
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:14 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so17558625ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930913;
 x=1792535713; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0UBbkdChMoxbRlB+/RdTQNq0QBOUvbs2vBNI+2pKPFo=;
 b=ZKbU5baV/tQibY8BELKBSaJ3zixkMMmFqgIBFUKgIYRxbAqKa6awXV7AcGeobsV5rB
 k2X8Egc7e6e/ktL5gmRxg/jFnCwqyHUFLtDr1qpPXmKNB3n2/Ch0wWCYT3srXPYzNgX1
 /f7bepmG/ePDRJfDur1J1v6rp/dXo43HM3C4W3e+gzCl+V1MGJWIaJJZUaFIlqG4Ny86
 G7oxaka/XkHXEbIrJj3DUJ7BBNEr18+7gERWQ45EcvHmlbRjGyLz1IavnPwyacyL3f4h
 0RsVELP/ro0h1Pfsl9Za+39g9i206o/gsYDm0h0nxqhY/lZ4mSNus5zYOLcPT0vc92E/
 r1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930913; x=1792535713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0UBbkdChMoxbRlB+/RdTQNq0QBOUvbs2vBNI+2pKPFo=;
 b=lgf3Ky78Bh35cF8Jdnbh5mikKhMlzWGBecQ1jd3yxmVJySbBDfC8AIA4bEo5fHzUEM
 0AgX+61rI2NtSXa9+pU20bdl+EuTzGTMZWA6PY2qTyO9yS+1xhevWhH/2VHXWqRI/lTI
 wnP9mOtDVFfQhBQyL7HUYbvxMxtC9X0eCJR/cvlyRW8HMAkv2LyfazCabNvunE9a+8K+
 Pbs4hbwO1+2+aewYG/GpjXXPEedO0wt+PDTElLjpJmVrKT+KpYdGhfyckvI4WxfVkvjL
 9Ag8XkPgwfmlPOzEhruXi0bFefxpyM2Bo16ZSZPQECams61ZphSIaMkz6A4ZDlRz/qcK
 5pVg==
X-Gm-Message-State: AFq9FYKhviG0bp3bUdzgAsnasIF3/nmZV7V1YP4urpa6A+6vtY3vgU75
 Uu7t/gO5y9iVTuZR5N9HPElEMIuiJwfJ4Y/LYqv87NQ6NOrW9GS5zb5nS/H/MeIpfrbUxlPU+3m
 DXRSDyfw=
X-Gm-Gg: AYBFou0oqu7nyEiwo+lZsdbtAONGwCBMnGNqcUT+tbbntIK0Id9hUigQ8CNaeaLdOBr
 ltzGm1QxZ5MuuDUqZsH7Dwm1xmJMqeeDpPUJLv3dUH6A+SmeQuAatWHC7MzIBfm0QYDodXLLcOU
 DmCGDmCxteM0l0d9AD+AnvgsISc+qgudnkDGOFzDdhlXu12xfHBAJP+eVzYM7dYZ9rT30fckg7c
 78MDX6yAcVFUypp34f2RV/znhWE9Wffo9mTKuN6FH1NABRWeLY41Fw2assQ/6RXe9jfSAWPfbys
 S68IVfriSXPFgJq0JrHXLxcGR/eAV6Ynn6FRGo9huao27Gk9e+IJNIi9HVv7nv26vxrhG2EHCfq
 XFafdZqdn9ceRNl2pbi3S93PkOhi0aD3AfsqqznSMGapzPECUQTJ53zayjw+g86Xcj/J4jyWi7r
 3ec8F87CQjDGTPFgL27bVlO/x2UtYX9DzSrW5DAneThDqUCROh8ZWy51tII8d5BDDD3KLvra9K3
 QImzkEKeNFM0u6kk04DXRPhNtKJNhnnh91NEg==
X-Received: by 2002:a17:903:4b4f:b0:2df:8ff9:5160 with SMTP id
 d9443c01a7336-2e842e0e7bdmr86675075ad.34.1791930913529; 
 Tue, 13 Oct 2026 15:35:13 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH v4 17/29] event/sw: fix unlinks in progress counter races
Date: Tue, 13 Oct 2026 15:22:30 -0700
Message-ID: <20261013222410.2257622-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

The counter is written by both the application thread (increment on
unlink) and the scheduler (clear on ack) as a plain uint8_t. An
increment is lost if it lands between the scheduler's test and clear,
making rte_event_port_unlinks_in_progress() report completion before
the scheduler has seen the unlink. On a weakly ordered CPU nothing
orders the scheduler's cq map reads against the counter test, nor the
application's reads against the counter reaching zero.

Make the counter atomic: release fetch-add on unlink, acquire load to
read, and an acquire-release exchange to clear. The exchange cannot
lose an increment that lands after the test, so the scheduler can
keep its relaxed load of the counter first and take the locked
read-modify-write only when there is an unlink to acknowledge.

Fixes: bd5ac24fea88 ("event/sw: implement unlinks in progress function")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/sw/sw_evdev.c           |  8 +++++---
 drivers/event/sw/sw_evdev.h           | 11 +++++------
 drivers/event/sw/sw_evdev_scheduler.c | 17 ++++++++++++++---
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index a2f760a98d..87a8996f9d 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -119,8 +119,9 @@ sw_port_unlink(struct rte_eventdev *dev, void *port, uint8_t queues[],
 		}
 	}
 
-	p->unlinks_in_progress += unlinked;
-	rte_smp_mb();
+	/* Pairs with the acquire exchange in the scheduler */
+	rte_atomic_fetch_add_explicit(&p->unlinks_in_progress, unlinked,
+				      rte_memory_order_release);
 
 	return unlinked;
 }
@@ -130,7 +131,8 @@ sw_port_unlinks_in_progress(struct rte_eventdev *dev, void *port)
 {
 	RTE_SET_USED(dev);
 	struct sw_port *p = port;
-	return p->unlinks_in_progress;
+	return rte_atomic_load_explicit(&p->unlinks_in_progress,
+					rte_memory_order_acquire);
 }
 
 static int
diff --git a/drivers/event/sw/sw_evdev.h b/drivers/event/sw/sw_evdev.h
index 5e49b08030..2c11d02911 100644
--- a/drivers/event/sw/sw_evdev.h
+++ b/drivers/event/sw/sw_evdev.h
@@ -154,13 +154,12 @@ struct sw_port {
 	/* A numeric ID for the port */
 	uint8_t id;
 
-	/* An atomic counter for when the port has been unlinked, and the
-	 * scheduler has not yet acked this unlink - hence there may still be
-	 * events in the buffers going to the port. When the unlinks in
-	 * progress is read by the scheduler, no more events will be pushed to
-	 * the port - hence the scheduler core can just assign zero.
+	/* Count of unlinks the scheduler has not yet acked, so there may
+	 * still be events in the buffers going to the port. Incremented by
+	 * the unlinking thread, cleared by the scheduler with an exchange so
+	 * an increment racing with the ack is not lost.
 	 */
-	uint8_t unlinks_in_progress;
+	RTE_ATOMIC(uint8_t) unlinks_in_progress;
 
 	int16_t is_directed; /** Takes from a single directed QID */
 	/**
diff --git a/drivers/event/sw/sw_evdev_scheduler.c b/drivers/event/sw/sw_evdev_scheduler.c
index a5fdcf301b..207dee5854 100644
--- a/drivers/event/sw/sw_evdev_scheduler.c
+++ b/drivers/event/sw/sw_evdev_scheduler.c
@@ -523,9 +523,20 @@ sw_event_schedule(struct rte_eventdev *dev)
 		do {
 			in_pkts = 0;
 			for (i = 0; i < sw->port_count; i++) {
-				/* ack the unlinks in progress as done */
-				if (sw->ports[i].unlinks_in_progress)
-					sw->ports[i].unlinks_in_progress = 0;
+				struct sw_port *p = &sw->ports[i];
+
+				/* Ack the unlinks in progress as done.
+				 * The exchange cannot lose an increment that
+				 * lands after the test, and its acquire orders
+				 * the cq map reads below after the unlinker's
+				 * map update. Nothing to synchronize with when
+				 * the counter reads zero, so test first and
+				 * keep the locked op off the common path.
+				 */
+				if (rte_atomic_load_explicit(&p->unlinks_in_progress,
+						rte_memory_order_relaxed) != 0)
+					rte_atomic_exchange_explicit(&p->unlinks_in_progress,
+						0, rte_memory_order_acq_rel);
 
 				if (sw->ports[i].is_directed)
 					in_pkts += sw_schedule_pull_port_dir(sw, i);
-- 
2.53.0

