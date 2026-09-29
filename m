Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E8CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55B5542E54;
	Tue, 29 Sep 2026 16:04:27 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 2C5F242DA6
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:21 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88098db8dcdso1756760b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690660;
 x=1791295460; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9P5Jck3wD7O9xfYx+oLDbJCo8lh/2AQ7A7cG3W0tlO8=;
 b=VEPC+iipgF7teXM02UB6J8vtFmArtxiHy4IjZu2HHaPIV5HPRm5LeFXQTRZBR8PNil
 ISCZRQAQ3iQE1xn3yxtIpAHpVvNacgOS3GM6v949aIbgoM+ZY+vv2PnL+xuMkn1ooUj+
 YhfhgVHjB4MIKMxEmeTo4BXiGcI3BzJpySvCzYCfSLC0+UOIJIoNzAbctR3LblBNyBzl
 KNmvvQZZ2HzKyMtMZjlk0HflKGimWP1jYFOqR+jjUQtN3FnQQO1b6EtlfAMmgUytHBRq
 Tr+QTCd3mYOBUnzQ4WeyontMR1sehIFdcMb7AJ8aS08QIs8GppvplQjw3EYRa2gBnUgc
 C8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690660; x=1791295460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9P5Jck3wD7O9xfYx+oLDbJCo8lh/2AQ7A7cG3W0tlO8=;
 b=QwETLeaO0LlLkZ9UeYnOU2rlPbYu6XGt0zM8pePtKm2PocCd/aqACmJxyCDLCOx3ee
 opRapopoLxF60OsQO5n0LfwTt8+4bEaamAcpz2/1vnumHisbFKqp2UzMueM4AZaR9qxc
 ZePKt5PgGnbTv7Y35T7UFoa4g7UkpRk+0PtZIxpjakB/jAwC9VEIW2nW5qBI51TPKRkM
 3kkWhUtOs8nSqA21/26tbp6XyHZwvCQQ6P28q7CWGMgPab71OAVlwnMutqzHjusb6oMC
 /1YG7Ht7An/dC3776jQNXBtUzBS6hVzfu0XkGsF/hQ1niVdLCbMk71pcBbvq8tpOPmTL
 4OEQ==
X-Gm-Message-State: AFuF++k6E/C6fGlgKh34ooCQ3C1dJdK8izJ66dzNLz+w18FmnZKKbslQ
 AzC+M2kKfMobnGF1dxbU2f1U0OjLaMjQWD3XTb/uWHZWpafZHDHgRm0GWRUuTI1VIWI4HjOvPpS
 aJ0OzYhw=
X-Gm-Gg: AYBFou0JKPd6cfFF1lpJkcKQtwvpwkz7pBU2sNl5LpLhA8/r59C9swaeZcBbsHOTe1C
 SBC6B9Q+LQgCzd3lKonQT+Ron06KMqL+qWP2meJtke7tZI4x9sW3SwLzq3DR65Sc1Dfs+uqqk7s
 FN4/6dX9rUa6Dc8Gri5gEQew9/qlj7q+1fYjrJpa+C216x+bpTRa7xuFQpmqGo5cjT6flYSafuY
 xMoOP51UmZpXonTnI+ntxzmuC0BCB024ZAs9BtCJbNCJipRDcQNZuQCPEGRw2mg9CZ0ualpt6Xk
 h1rhCWL0IPeSxPY682TspyuM6VFDJw1WrayM7O9QvtA3kWpqb1/z1/UFlZ+URoKwSsxVD2zi+h4
 HEu8FcpM6K9qugBdTz1g6ic1JHcK85zlQA0FFLFMw1OtRUIUKre3LHr5Wd9uOzPU5FJreCV8pC8
 XHO+pSGiGTSHgQf+xTx65K1EzBwqPJjiLXFc1m6CwFuIBqdlabipXKuI2Cr+OYs3CrI5bxYUJCy
 MOxFzdyX8rb1WDbffFRP4TqoUV8aVJ8lw5xkg==
X-Received: by 2002:a05:6a00:2e85:b0:881:fffd:26ab with SMTP id
 d2e1a72fcca58-881fffd2c44mr6848704b3a.24.1790690660002; 
 Tue, 29 Sep 2026 07:04:20 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v9 08/25] net/sfc: replace rte_atomic with stdatomic
Date: Tue, 29 Sep 2026 07:01:54 -0700
Message-ID: <20260929140409.234453-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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
index 809ad59148..510790a5f6 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -17,7 +17,7 @@
 #include <ethdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_spinlock.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 
 #include "efx.h"
 
@@ -258,7 +258,7 @@ struct sfc_adapter {
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

