Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED9CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 463E340B95;
	Sat, 23 May 2026 21:59:00 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 440CD40A6C
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:54 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304545f5206so2270499eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566333;
 x=1780171133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtO5XLVPbo2xyfbSMZqNWk8kbz8dmkFljgSKBl90kP8=;
 b=KcyZPCbfauJmFctRv5w4qwAA9nWnA2ADxaH3J9CjrmDdNKy7U1JyfaDWvHwDr0uMs9
 YdlRyyh3JM9oepjvO9vstmqPXz5Pt86vr1+TeG3f++3iXnWhDbmfjeNjW55IcE7w4tkZ
 zlfBtNysyXZ2mOTrJyrey8X5qHZASgkJpLO1uiwGBCmw0fITRHWl5LL3Yg3zY0vQiJNC
 gD+P8m8Em9P6Wsk42NKVxf5mdZifHTRDUfi7yHSk7PDKx/j/Gi/rSZ1bvXGuHp+ZUVxO
 M212RF/5EARJuaBIKjkp3rxO5S5T6CdW9suS+y7QPbz/W8PaNsTmd3v8PZaumkxOQyEU
 salg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566333; x=1780171133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtO5XLVPbo2xyfbSMZqNWk8kbz8dmkFljgSKBl90kP8=;
 b=LOLX6Zfqpc5Ds8OfpAVSLX2rfUEpNjqjG++9/aZHo0wryrEY2BXc/IuRosVQD+bS64
 4D1ByLIy4V9lE9NFWbEmyE8sGfimhsH3V0p2N0ynwXPjnetLye26iS4Vw+jPUoUFbY2w
 oeXJ4akBsT3wjTOCHTEJqJ+hB7i7jHqCkzmCN8z6gssEbc1n8xnu+rmQz2UnWD+wrdzj
 1JrrUkZj4Sz0WXBFYUnHAmj1kuOu8/6DAhJUFIvSro+kwkz5K9Gkks8l9+M9IJrkVS7p
 l1Y+3TtdhjYWgEPwSt7Qr1U7YSogirqwIgCAzeH7UlABEjhmIym8Qdd9A5Kum46lewfl
 UF4w==
X-Gm-Message-State: AOJu0Yxh+l9f0oNXXu4w0k6kqJVB9wJK5p9yBOlxo21liLQ9G/+N1gBu
 zLyArvV6PVxmpIjGAYWZSY3MLSHqbgmdyC5fdnU1K9sklb4OqBEhUzXP5koaZaJ03wx+gzwK/Jn
 sd84G
X-Gm-Gg: Acq92OHMlHGDY/IxgKiwfFNr4p4XLx/EHsVLxYlqhDnw8a4YhC9LWmY5tHkfRGoiSse
 G20oCzklNzXps2GXnJh3lRwwisCmH8QTL4u8gNZ7rykfIZGAdAkNk5AGPSR6wPXamIslgDZHE1z
 8q3udb2v/KTphTLBfUh7s8aHztWkNuLcSrU3Z1OpMG17SetsMot0nUEuQT7VHdR7bFHGDmNYvQs
 l7CfPFwVrp+0QtlBuhcXnFyQ7m6F+WcsRxXQRuHkLbFZxMPDBJmq198mUekDWsHTJe3botjazr6
 AqpItayKKihie6dXe06l91bJ6CrUrZacfW3qXa81K2GM2jogeiyZqiY/E/D3SpmIUlw7F3h23Dw
 naLZRNmnycZLBYKU1C4/PwYRm+2akDoGIcP6RrM1p3bL2/LtG6NQNHzBZq5kKH3L2P0wqk2XirA
 RHRCY2acWWiix/E+YerKGIdctuk+BL/gVJBOu9R3ju3VUWlBuURNFFqu/fLwVvtg==
X-Received: by 2002:a05:7300:1352:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-30448fd6144mr4105312eec.6.1779566333324; 
 Sat, 23 May 2026 12:58:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 11/27] net/sfc: replace rte_atomic with stdatomic
Date: Sat, 23 May 2026 12:56:25 -0700
Message-ID: <20260523195839.454952-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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
---
 drivers/net/sfc/sfc.c       | 9 +++++----
 drivers/net/sfc/sfc.h       | 4 ++--
 drivers/net/sfc/sfc_port.c  | 7 +------
 drivers/net/sfc/sfc_stats.h | 2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 69747e49ae..3470f7eed6 100644
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

