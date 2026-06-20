Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9977CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A04240DCE;
	Sat, 20 Jun 2026 04:31:52 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id 253ED406BB
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:50 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7e1916922b9so30517817b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922709;
 x=1782527509; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=fOz2HNv0mQk0oqu5NrpAl9qDAw0UN5QCeGkWpBd5sqBj1NfQmxi7w84bOEWL+pGMAL
 Vd+3E/ysu9d378NEi1PZvSJILRc/GtVoP62tjNCIeFjhN45kF9WCsPsbNGVPZDq/xJkr
 S32tsnoSTDihRK6r5X9PUD0GH6y2mve+bWMIhlxY2Zdecuz2stBmwTSLZeIpcPR5LBK+
 E+nwrYrEMOesJTGGZJ25CaP92ETcV0WGcYsvAFhry1fwGOhn1KcH2yUvTWTLY500UY9E
 kNS5T4xRLc4QW8Tx2GlN+zMEKWmud853TWRrJaSDLN45WVW7ijJefs45pLq2PWNZ98xn
 KJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922709; x=1782527509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=jQrjb80uDhETx0tmkTyyHg2xWzby/zc56aEcR0uuPMaV2/+JdN0bGVeVL/I1YY0rgO
 7xg6NyHuGl5BWOyDKvdZFdaxwAZey+IoIWYdsCQZYWe7/2C/Tn0Ri1ZstlLVMjIz79HC
 sxwQIFyS/7cXhO73THcecyBDv4DX3N2J1BnYMh8RWc2wJzMlWtdAtSsdtgpkfXyBnYQ6
 OG/Gma3QRVTufuUJtmvhW/Gf8iejeCcMaZw944i2/gSTz/kW9eJ0SwqNMVWZXMN6fnZW
 PrD7xJOGD2fbmIYJH/xKSI4qQTpy1a8Wkem7csjUUZdKgs19tFXPBqFgkjn5FSp7Pht0
 Z90A==
X-Gm-Message-State: AOJu0YwNzRGtHdJvsChWSwcbvd9/bfCXaxkP/IbdK3A4p14LyORSj839
 I05ywogBiQAe4ucEEOqv6NYFT+B5rTy5lqtwi1Sn0VhD7QiwWklll4XYYHXfjYhO9w95W8ZByhi
 Vu29a
X-Gm-Gg: AfdE7cnVwOi9W794hOLfAxNZjBZUQSW7MEf4kJVjjX+U2/3YidNFJ0IWCgPail3OfEW
 UWsUq201BHttGfNOXpQ4soUYDK15/GlAWE0DyRDgBl7twdq6ELIGo3Ns/oVc1Acejm9NL37krhy
 xp9KXL6hkx7zDkbrnC/k/H/mOv1hXhWYD6Kcu+1PteE77CMqy9ssEsQSbNx4muUzR9bkqY3WhaK
 iWqr3H9fCBuNUJnO7zgTB0cwZmr2BZMVeOL3QQ658RH9/uEGMz5DuxKpXjf0nLiIF9HJ8MH1C4Q
 0uMBDVApgoLfw7r9QkrloVp7dlN/yUTCgxxxqwD0syRtBWLT7NLZQYk5hbJqF4UnqU/jD8EQzea
 nlIkDp4CV9c72KCZ+aDW2ufNUmgnrAPIiPLu9PY2+a6T7EHVSVe1v5M7jfWVc78QNEYpXbv0XXB
 ApW6C4RhdLkxD+alLj21RLLTNoHxfQW4Pnam+T9AM7z4HFAzmbqehtTAt+PaWk/Q==
X-Received: by 2002:a05:690c:c4ce:b0:7d1:9c6a:d60c with SMTP id
 00721157ae682-8013350505fmr67481317b3.18.1781922709285; 
 Fri, 19 Jun 2026 19:31:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v5 08/24] net/sfc: replace rte_atomic with stdatomic
Date: Fri, 19 Jun 2026 19:28:33 -0700
Message-ID: <20260620023134.42877-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

