Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55704C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B66042FFF;
	Thu, 17 Sep 2026 22:11:34 +0200 (CEST)
Received: from mail-pj2-f15.google.com (mail-pj2-f15.google.com
 [74.125.227.143])
 by mails.dpdk.org (Postfix) with ESMTP id AF53742EE5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:30 +0200 (CEST)
Received: by mail-pj2-f15.google.com with SMTP id
 d9443c01a7336-2d747f01363so221565ad.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675890;
 x=1790280690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=Dw3+4JiwRWuE6m5atU9O0lqkK7Y3hxuCEcfSymwCVXI7V5/OM6adZ2jXgXCphEClme
 nUs+nkIsMElx0MVRcC+JlXKw308Am9eK0wIfbJQwPCy+hEUuBFiM5gSSKNmA6PxeBajI
 dDQIpl3PiD10BKMlVO1WCPEfdO+btJbpFIwdArdCSJtjX4g2mTZUVM2wzWa3J/i3fWOG
 21+rQ7lVQ9yBIKgI6y9vzVUtmuKdjdZa67sGNoPn389JUvAlzPcGrHoF0Q+5/IrjIeSU
 b4YsEzrDZbuOJ1RMxSCH50QDzHxmW3asgqKuTWdh54ncpgQGIS5DPPzYbAxAXNzt6VRh
 Qa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675890; x=1790280690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=kQ//1DkuUEiw/wQtMI8ZDJl56eRBOA3RdR8ehadQjipdKyUlPckiQgTN2z97lPbpve
 fsT+ZxhTYb0dGv3tKOp44/zstILvQRCvUwE8+df9KfK53aMLXJv5o/jpJlynAB8XEmqm
 JIO5GaoUUm1UcHIg+UoaVbz5RAC+0WlxLVHY79SO17nlY21wvgv7K/VcJxlb2Y4Zu+zb
 8l6aiBiuP/EIOpv+sfF9yrBKM2t4VMvaQEkEzp/YYLErNh8mhDo/ljV7jN6weF1uBV9V
 JCsGns7RHaCsFqwcWW7gUUaOfjJnWKAAzXfH6xI/rDjH3NxFnzjdY/wAdc+OL01oh8yP
 Ruog==
X-Gm-Message-State: AFuF++n+o5vfXphIzolu/lr5m7ctkvAfsZknXIiJ3MICUT18ir3Mx4pA
 hOR5oJdjflFK0RBj0EM93arVKmoXVb3pQPSDL1ks+SdCRnqeV5beXU5ZvmCokXSJrznaS6nJbJz
 Klb6W
X-Gm-Gg: AYBFou3Mm09ccpEpGqMhdYe7tHdJm/bJILIj2do+TMokXSWDxqb4VcKMwTBGJlrpgjs
 btBjR7GQ+4yDpGp6GqJH7JCvDL9pLdbsX6SETAZb+FmjJNvHCtTEdDFU9RL4JR2iDTzzlYUrNsQ
 AqNZtBu9K69zI2f3aWwjDzlqIJb/0I0DdilHd1TJ0sWcQ/7DlrNsNHaRXhGj5HAEQa+hNp5UdnS
 TBF8s0HAW+oai1blNKtvowLOHqEtdNntINw3u44xtCUlSFlTP5Nbplb3JF/KXXKzwDNl+hSk2jf
 IK5+QP386N1UkqlpoJ/LWlISVAZPRLgKdtGJihlAielvFSrDUMoY6ZFXCb3w8+QHtFykMmvknc8
 8hl3EhIGgx6bhAxNvf57DvICT/r/XTfRv+x+foqG9cY989cgIDedJQBi8spB0FpAKEoba4KHYDC
 eh234CU0daRajuAlNpVVXRga7n6QdBwaRRjkahYpIsKjfNycFA/1cyJchlHvaxq9QGoUqVeGQYt
 vqf53C0InVwp/WvAGKjdx0gBFZeVa0va5onKg==
X-Received: by 2002:a17:903:2350:b0:2dd:ad74:ac83 with SMTP id
 d9443c01a7336-2ddb1bc1d80mr5911205ad.30.1789675889759; 
 Thu, 17 Sep 2026 13:11:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v8 08/25] net/sfc: replace rte_atomic with stdatomic
Date: Thu, 17 Sep 2026 13:10:12 -0700
Message-ID: <20260917201119.2168234-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

The rte_atomicNN functions are deprecated and need to be replaced.
Use stdatomic for the restart required flag.
Use existing ethdev helper to set link status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 drivers/net/sfc/sfc.c       | 9 +++++----
 drivers/net/sfc/sfc.h       | 4 ++--
 drivers/net/sfc/sfc_port.c  | 7 +------
 drivers/net/sfc/sfc_stats.h | 2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 39cd8d519a..f13c5e2460 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -670,8 +670,8 @@ sfc_restart_if_required(void *arg)
 	struct sfc_adapter *sa = arg;
 
 	/* If restart is scheduled, clear the flag and do it */
-	if (rte_atomic32_cmpset((volatile uint32_t *)&sa->restart_required,
-				1, 0)) {
+	if (rte_atomic_exchange_explicit(&sa->restart_required, false,
+					 rte_memory_order_seq_cst)) {
 		sfc_adapter_lock(sa);
 		if (sa->state == SFC_ETHDEV_STARTED)
 			(void)sfc_restart(sa);
@@ -685,7 +685,8 @@ sfc_schedule_restart(struct sfc_adapter *sa)
 	int rc;
 
 	/* Schedule restart alarm if it is not scheduled yet */
-	if (!rte_atomic32_test_and_set(&sa->restart_required))
+	if (rte_atomic_exchange_explicit(&sa->restart_required, true,
+					 rte_memory_order_seq_cst))
 		return;
 
 	rc = rte_eal_alarm_set(1, sfc_restart_if_required, sa);
@@ -1292,7 +1293,7 @@ sfc_probe(struct sfc_adapter *sa)
 	SFC_ASSERT(sfc_adapter_is_locked(sa));
 
 	sa->socket_id = rte_socket_id();
-	rte_atomic32_init(&sa->restart_required);
+	sa->restart_required = false;
 
 	sfc_log_init(sa, "get family");
 	rc = sfc_efx_family(pci_dev, &mem_ebrp, &sa->family);
diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index 629578549f..515e1e708d 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -17,7 +17,7 @@
 #include <ethdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_spinlock.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 
 #include "efx.h"
 
@@ -239,7 +239,7 @@ struct sfc_adapter {
 	efx_family_t			family;
 	efx_nic_t			*nic;
 	rte_spinlock_t			nic_lock;
-	rte_atomic32_t			restart_required;
+	RTE_ATOMIC(bool)		restart_required;
 
 	struct sfc_efx_mcdi		mcdi;
 	struct sfc_sriov		sriov;
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index 33b53f7ac8..d84648d454 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -121,7 +121,6 @@ sfc_port_reset_mac_stats(struct sfc_adapter *sa)
 static int
 sfc_port_init_dev_link(struct sfc_adapter *sa)
 {
-	struct rte_eth_link *dev_link = &sa->eth_dev->data->dev_link;
 	int rc;
 	efx_link_mode_t link_mode;
 	struct rte_eth_link current_link;
@@ -132,11 +131,7 @@ sfc_port_init_dev_link(struct sfc_adapter *sa)
 
 	sfc_port_link_mode_to_info(link_mode, sa->port.phy_adv_cap,
 				   &current_link);
-
-	EFX_STATIC_ASSERT(sizeof(*dev_link) == sizeof(rte_atomic64_t));
-	rte_atomic64_set((rte_atomic64_t *)dev_link,
-			 *(uint64_t *)&current_link);
-
+	rte_eth_linkstatus_set(sa->eth_dev, &current_link);
 	return 0;
 }
 
diff --git a/drivers/net/sfc/sfc_stats.h b/drivers/net/sfc/sfc_stats.h
index 597e14dab3..eaa2afd3fe 100644
--- a/drivers/net/sfc/sfc_stats.h
+++ b/drivers/net/sfc/sfc_stats.h
@@ -12,7 +12,7 @@
 
 #include <stdint.h>
 
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 
 #include "sfc_tweak.h"
 
-- 
2.53.0

