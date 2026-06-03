Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F745CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 20:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39A934065D;
	Wed,  3 Jun 2026 22:35:58 +0200 (CEST)
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by mails.dpdk.org (Postfix) with ESMTP id ED9C440649
 for <dev@dpdk.org>; Wed,  3 Jun 2026 22:35:56 +0200 (CEST)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-7defee656dcso120747b3.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780518956; x=1781123756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L6cHM7qIjGHy1PqcMzQ0RrOPS0TSU0mrp4dUhx8H13M=;
 b=IABBCt2UyCvaI2oq5CwrU+mxS/P9c8r3cEaXWj/YtJ2FHsh4CecdoWMTX0+NHmqG5W
 L8RspRhwl2JJ/0ynyhXPrGfrbnm6E+M6lqIGvSQB69zFbBgxW52bEos2yDnmf5WN5jFX
 CrVdJCVREEg+/hY1uS32WmLsUYv+mgityy6x0kdvDsIYoxg+Zs3Go6XkzRm6Z3f2YqrY
 6PDmUm/oOmWjgdkZA4Ud3eJ/dZFHym77NBZpPegDd24seEzL5mTdnxQU1uctk0FSiS5M
 2W3lakWeC4svHsONJmmLgKushSUE+Qk4uBjOarbktCUzu8//hQ4FE/IjyAOJ8K9iy1zW
 26EQ==
X-Gm-Message-State: AOJu0YwlqqYRzz88r/C6YWWwPP06XLi9OOnbVy47T/OxM9CuHtdpqWdn
 VJVrJBOiMLQKU9jP0y3OFOQucjV9OsxXpOgQZYrCKhpHSin871J63kOZqdDAD0Cahdy5GJAEgc1
 yzIcRZEgmQIn8TNaY5Dpe6HdeJKPo+ixKpwuiqIZl4DuTP61gEoPq+q1t3L1y9PNhOMNAwD1oKQ
 0X4M47x9ukl81fkmWCKZCBP3AEdHMCcdPHOOKLT7IvBQ+rEpRDHTUOJRyRVWJ4hLpvQPDyXMwGL
 ZIazVa7rBgK
X-Gm-Gg: Acq92OGB7nylPkGg3lRNnQPKdSHv70XvISd7bjMX6JtY6BCNBrpT+theaF8zeXsEG1w
 vGLPVVH7JyHZDGqVpLBD93+Wy3K4Z4V8ExwbQ04/awyqrF22Zh3WuwvzC1M2zM1IaDvzORf+Nte
 wjazWlqaar+/aGUDPM4wzd6bVRCs50cdAb2rcUt+XFdUiCjak5wzZreOcmIxw3m7RLT7y9M7yVU
 qEqeMgfunq5kZdzTvsE9FnMiNQ7NB4hdUmHxCpSOzUW+2dQPNjaaYysMMmYhJDLImvUMF3sMYsp
 23VNxXPewMXXp0eNQxGrPVVYl0eKE+ZCPi5QRQTuJf+wqt+0yS+Z6/Jp/zValZyR4LH/liVzsYO
 YtBuzWyVczLYY+emfNDHX5nt3N3VJMIV2ikNY65fX3Suik6eukWfSshgXqUIhLvMc2NXP4eiped
 e/H7IRPOYPYrWjGV8JRHKm22WI4X/RjWU0OOs0UNX/QXeGrvLdIad/kWDqSyyCrEbaXPJqvv+J5
 uSZcbXAXA==
X-Received: by 2002:a05:690c:b02:b0:7db:b027:6166 with SMTP id
 00721157ae682-7ea488c0698mr49802987b3.22.1780518956102; 
 Wed, 03 Jun 2026 13:35:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea20eab917sm2842277b3.1.2026.06.03.13.35.55
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:35:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157929bf8fso4852185a.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780518955; x=1781123755; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6cHM7qIjGHy1PqcMzQ0RrOPS0TSU0mrp4dUhx8H13M=;
 b=FP7wRdwa0m254ypW8MMdYD1N+afMm3e03Zjn+grK+7OF7ovbOawRsZYibOY9UV3rLm
 vRc6I2oEvJ6/SuLkA+JM+eqYQ7UHGZgzxzhngQTjoO5qFUOd3US4fhel7/bZ48fcAhTr
 Z62+DYkWTw/DP+gSGD0LgetEJ9jp0vZL0hyFM=
X-Received: by 2002:a05:620a:4621:b0:912:671b:d09b with SMTP id
 af79cd13be357-9158a6df52dmr850351485a.24.1780518954011; 
 Wed, 03 Jun 2026 13:35:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:912:671b:d09b with SMTP id
 af79cd13be357-9158a6df52dmr850346485a.24.1780518953367; 
 Wed, 03 Jun 2026 13:35:53 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a22dbbesm340925085a.13.2026.06.03.13.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:35:52 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/4] net/bnxt: move ulp stats timer thread to dedicated cpu
Date: Wed,  3 Jun 2026 14:37:35 -0600
Message-ID: <20260603203738.2084478-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

The ulp stats timer thread is currently running in a lcore cpu
that is assigned for the dpdk worker thread and this causes the
performance to drop since ulp stats thread hogs the cpu to
collect the stats. The fix is to move the stats timer thread to
a dedicated cpu so it does not affect the performance of dpdk
worker threads.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 73 ++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 23e1b59ca4..fd33e0d36a 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -347,6 +347,59 @@ bool ulp_sc_mgr_thread_isstarted(struct bnxt_ulp_context *ctxt)
 	return false;
 }
 
+/* Find a free CPU not used by DPDK lcores for the stats cache thread */
+static int ulp_sc_find_free_cpu(void)
+{
+	unsigned int lcore_id;
+	cpu_set_t dpdk_cpus, proc_cpus;
+	int cpu;
+	int rc;
+
+	CPU_ZERO(&dpdk_cpus);
+	CPU_ZERO(&proc_cpus);
+
+	/* Get process's CPU affinity mask */
+	rc = sched_getaffinity(0, sizeof(cpu_set_t), &proc_cpus);
+	if (rc)
+		return -1;
+
+	/* Collect all CPUs used by DPDK lcores */
+	RTE_LCORE_FOREACH(lcore_id) {
+		rte_cpuset_t cpuset = rte_lcore_cpuset(lcore_id);
+
+		for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+			if (CPU_ISSET(cpu, &cpuset))
+				CPU_SET(cpu, &dpdk_cpus);
+		}
+	}
+
+	/* Find first CPU in process affinity that's not used by DPDK */
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (CPU_ISSET(cpu, &proc_cpus) && !CPU_ISSET(cpu, &dpdk_cpus))
+			return cpu;
+	}
+
+	return -1;
+}
+
+/* Get the first CPU number from the first DPDK lcore */
+static int ulp_sc_get_first_dpdk_cpu(void)
+{
+	unsigned int lcore_id;
+	int cpu;
+
+	RTE_LCORE_FOREACH(lcore_id) {
+		rte_cpuset_t cpuset = rte_lcore_cpuset(lcore_id);
+
+		for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+			if (CPU_ISSET(cpu, &cpuset))
+				return cpu;
+		}
+	}
+
+	return -1;
+}
+
 /*
  * Setup the Flow counter timer thread that will fetch/accumulate raw counter
  * data from the chip's internal flow counters
@@ -360,7 +413,7 @@ ulp_sc_mgr_thread_start(struct bnxt_ulp_context *ctxt)
 	struct bnxt_ulp_sc_info *ulp_sc_info;
 	rte_thread_attr_t attr;
 	rte_cpuset_t mask;
-	size_t i;
+	int target_cpu;
 	int rc;
 
 	ulp_sc_info = bnxt_ulp_cntxt_ptr2_sc_info_get(ctxt);
@@ -368,16 +421,18 @@ ulp_sc_mgr_thread_start(struct bnxt_ulp_context *ctxt)
 	if (ulp_sc_info && !(ulp_sc_info->flags & ULP_FLAG_SC_THREAD)) {
 		rte_thread_attr_init(&attr);
 
-		rte_thread_get_affinity(&mask);
-
-		for (i = 1; i < CPU_SETSIZE; i++) {
-			if (CPU_ISSET(i, &mask)) {
-				CPU_ZERO(&mask);
-				CPU_SET(i + 2, &mask);
-				break;
-			}
+		/* Try to find a free CPU not used by DPDK lcores */
+		target_cpu = ulp_sc_find_free_cpu();
+		/* If no free CPU found, use first CPU from first DPDK lcore */
+		if (target_cpu == -1) {
+			target_cpu = ulp_sc_get_first_dpdk_cpu();
+			if (target_cpu == -1)
+				return -ENOENT;
 		}
 
+		CPU_ZERO(&mask);
+		CPU_SET(target_cpu, &mask);
+
 		rc = rte_thread_attr_set_affinity(&attr, &mask);
 		if (rc)
 			return rc;
-- 
2.47.3

