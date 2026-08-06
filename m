Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF97C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC8AF40A6B;
	Thu,  6 Aug 2026 05:25:59 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 534984064C
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:57 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1576412a12.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986756;
 x=1786591556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=yltlu/LDnG4ZSOA5pDVa4c4z/EwbfEt4ioXkO44b/Wp9PJsVZA5ezY0zsYGmqY0LgE
 Y1aVs9dxl6YE++nvh463Y/kI5H9GRohQXQA72mwq4QiD6fI9hN8AY4tVRMAw3B7nhS6u
 W3LrAe78WtTel0XqnVy4pHKtkQr8XeBpGNPojVPy0YLrgPKbbg8nJHPzBD4HinR539xt
 aS0Ah59MLqAWiyVEQMGFc/0CZbpw3MzvbptY++Su13Vdm1n45x3aK/vRpKT22k3BtrCi
 7sO5a+ujqlqkpyEvN77HwvR68sBvkTmUobp283S6wy9BbWj2ui9MHWvslvgK7PDavWl4
 iFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986756; x=1786591556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=R7XKmXiUD2WxiyhftkcTO/HegYHiyt04gbCseWXHch/xn+Pt0+QAGa2lpKeV9jCaET
 rS8/SQAhcVsrB0s8o96IM/12bK9nHlZu4QyYHYZAXUDE/o1XjME4cgJogkgNO+RrITgl
 jjxCywZJprGjgyDiuZyahVeTIY0wlUg0yn39BYP7vnhfb0yJf6X7yjQP/1Ab7JUlEWHH
 wGY4yzvY42wPImXcujVi3jLsiHkEtqnDU/pgXUUhhScG5F14TXiShptCARdR4IdFNENQ
 IR47to88Gcl7dFuFwe9SmhELU+zxttl9YGoSe1LgzMgnDoK2sQXO+OinROtIoGf9jO3l
 maCA==
X-Gm-Message-State: AOJu0YzTHKMjok9a1GDTyk3kYLvTX49zfCHZyj72vKxmRmsB25R4mSaf
 S9JtBr88yVZDvROQ6AjXUYA9HcO/eWqB34P4W547RfSaEoJ1WgrfuLHFpl6bkWWg0eCAhdGoZnl
 4YR1Lkh8=
X-Gm-Gg: AR+sD1155NSdHcjaz69ZnkhtC4N5Mo8b1XQEWZQDWJvGnTaYiWTJUOf8pxeK/1hUsOR
 rTNR13tIAwvUaFDziMkTTZXWUOmD5Bbqgo0k6/vGLfkkhwDxV6LYb28+ZCSuInyTr9AkD87lasp
 i6ZlZSZPOEj9gq0O7tkE8myOcKSFifWSIhRS4QGUN5+7jOj3uDZkqtGWobgtfzppnAw53eTW7+Y
 vfc9Bynv27DlGyfsuOveXieoW4b7wj9qVM+fB+eQ4G790U1hL8sI+LCUQEPvOErWXEPY1WZ3JeO
 EPcIzNIateLuPRMeuiSiDp5Z+OxbVSgq+wnM/GQMF93VCmmB+rkZr0mGo4pULmcSdPIF/NdmQmh
 dIO5050OdpzCLlzxnKhm+ihB004RCl42ZAWfwFmOKTQiRIzVFRp4ksMiIZQPFPYwq9oxpRft7bk
 kyZYOzKkMtRuvy0PCFzyOAsKNh+jxt7Sp1BB66jgekrH69DrHF2WG8Kr32EW1V3AERfQas3bc9X
 4WERrZwCdfnFWbKVnaZtc0/p44=
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cb85df12fbmr12728733637.10.1785986756430; 
 Wed, 05 Aug 2026 20:25:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v7 08/24] net/sfc: replace rte_atomic with stdatomic
Date: Wed,  5 Aug 2026 20:23:00 -0700
Message-ID: <20260806032544.21337-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

