Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF9CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FD9540A67;
	Wed, 27 May 2026 01:26:03 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id AB7F24068E
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:58 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f7020a928eso16415263eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837958;
 x=1780442758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtO5XLVPbo2xyfbSMZqNWk8kbz8dmkFljgSKBl90kP8=;
 b=bRPWHdIKsudpsgixG56hZ7LXcPcfqskH+SsBUSRbCHf8sIdJKrDuF5CV9bljbz/5qZ
 tNxlC3Okl2hGGGbP3PsezLQXvDFEoEgKd3POV+JMu464cjodV4MD7oHqzx87Qj4Hk/E0
 CniwXmj14ChujK43sN9mKKe2dXKsn4jBzux/zZJvIT+zquFWY+xK/tPkSrx3UXjqa0ST
 nvC7y7SzQHpJe59xmKK92zyua5Sd5P8a35th+kUBjpBp7IXcKz1jBeJyniyLzQJianF7
 lEFG4ZdycqlWX1oDvmsAB6F6udq1Zidxu64WB9YvYANk241mNKoAgD1WqN+JJmpmwhDa
 gQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837958; x=1780442758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtO5XLVPbo2xyfbSMZqNWk8kbz8dmkFljgSKBl90kP8=;
 b=lFdOlHRKjgSKiurAS9N64VPWGqFT7GlQq7rwd+OeipOE+Z3Uk9+lbHU5GMmkyENVP1
 qnlbdMNSDldZ6nm2L89UFgEalK1OanrTyTwXnLkOHgJD5tw3KwNqDZ3iG9RqoFYUeIpu
 hz/kjCyVe2yGyKiO6Nin6vTeQ7zmWtmLht70doboNU6+PDWpPJNCIelYDwqmy8F+4Pu6
 N6I5Mm1VmbrOFzoR4lvW7YzzErw6jaLSd7PiWf3X5IonxUsCjcezcCWhsYGwM/kTvVPr
 I0iKTdkjt5KEnZrWanp1SjXtmphp/BxfY5bP0vY7BbMzZRp7SZIZ7hyVFknpKIwjirUy
 zWnA==
X-Gm-Message-State: AOJu0YxwHXhWO+8xR/p6W5QlA5vdz7U9Ds1Cmvrawri3s03F+keKdwDW
 gjn2GGWAI+mjwVeSP7LaRItLIcIQQS1cjpTEXTrocNOIQThE5k/H2sVjsBqjAHAbUhL/L8E0fWj
 2YmQd
X-Gm-Gg: Acq92OGnu/AhEM1d/w+lndWJaSHthNm7el82ClU+hvPiTbnQtj5iJcdlmo8xs3b3iFb
 JQ5ZGDQSrpnGWpQW5hXlPlTn6CmfPa6GN6Iu0Z74rvj8ztLQkU3Ngcgejom5UMZe6FDqyi+iInE
 OVPdfsYUD8/5kDzTwAJysHhpcfMNYwIukD1zb8b9S/trmowvfraypnDOUE1j/9qAahTRP8WCEf/
 E/M1OhOAKn4Gbjf3mawoW5Sv6fYd4Ib5ojGiGqgUZ14DlFHYKBDhlxqqnUs93ui+QnwXWlp7yfk
 0Fn3ZasJtGF05mjqVzbJ88rvrjTkZpGdSbCL2Le076LtPKB2PZ6Pf8+eVcJCsKY9AE9JrgiJtcM
 BY91pA4erN7MiR4/0wwCV1Ozvag8sdtAUKOTTxa/QFEatp8ZHaeNPDS4YBUAa7nF926gYgCfCQ/
 xTExZPmVKEH+tjwolJyhYjKieRStrmmhRg2pdFeONR0xgXJEmHJm0wyGdX8GL+qg==
X-Received: by 2002:a05:7300:7c13:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-3044904e126mr9222045eec.4.1779837957666; 
 Tue, 26 May 2026 16:25:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 11/27] net/sfc: replace rte_atomic with stdatomic
Date: Tue, 26 May 2026 16:24:01 -0700
Message-ID: <20260526232542.620966-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

