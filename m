Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3ACC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 947C240B92;
	Fri, 31 Jul 2026 07:00:02 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id F3D7640A8A
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:00 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso296451a12.2
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474000;
 x=1786078800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=J37huvkqEvA7MfFoaNashPaTgKQdLU6pnWZNqZvrxNtJnCWanzOn6nzpXpH2YGewiQ
 GBIsqskNk6J2jIBweikKGdyCkbHWw0ekobWZbvxxR/9wynTEkx6kHfxOCSeypKdc3/iB
 IbtQ7oxrjujFpvYixK4+Vlo58QgYCcKdLqtIq2se3rkmCv3/YIQDetfVZ2jBRnHz2CsB
 N+A7riXQU32qXmmVjFzG/T+IptiScB77R10EcFUsxTi9MdhC+hQdDnMN+xUj/TGJDogB
 vQwGkhoN2HFnmrfR81SJV0AB5MISDB8SGVlEVHp3G2ePwczVzCCCNcpwSLByDuwJ4NRn
 fLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474000; x=1786078800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=meZv84HBVCG3SEoVR+k/c2p4PZ/X79dPa2/gmIJZU/E=;
 b=EmqOj3M745Lawt+wVl+9eBKhx4fl6ZYdXutYC+dgRtDJEHRe1SRoSh4RpoWWs1qm7b
 4ZiNuWV5IYqbxCpkogRsoxZ/JYT/baWfy/qktLCAaGoa3olOWheB7NjxUprdb7WgPIM6
 UGo+WnY2+fJ3FC1Ic84oNnbdQgeO5RObJ1FGLpsCVrCLmnim4AjGcgPLpGo691b6Q6QW
 zWDF0xlbyWRe25uNRpLztFy/WWZoUvTb8t5Xz0R7XniAu7PbRmX7cTV9VmXSA3zjcLqK
 RFjWXV0IPV2zcMVupTgO4htxzIAO12GSGxn63re/O6v2TUqbceXqdPDSAYG62lOOvZXK
 8NqQ==
X-Gm-Message-State: AOJu0YwvMpLchHeI8kumMex48VIs/tUq8lCIWgeSKhbCsq9zH+h4teGx
 BMXaY8sMEc+NVN1Z33D8kBiQjVzmqTX1z2My6OQrcN3bxGKtBJQQFgTzTq/IqehJ0UofcPxzemB
 swu2c
X-Gm-Gg: AR+sD13daK33jZOWHlpOwzzxcN+sO1+s5SdJIh44TqV0AW8yYBbJXeqOV2zBHPjkGIu
 6930ngtZRSHeNwGo7Qs5xMENE9ivzLAUcIUC8rQzQXO5VYNgwA2IR4wpGLqgAITediShZVhhbqo
 TINCgtm87fR07NaZs2g9I6/T8Hw/tSz2plhn/u0yDfHWKW3olNhymvZRksl+pA1vC8xLusZqdBH
 7ciYayBBdBp+a6ohFWyXomDsUz66r6j+GbqjMEoPkljl8InHKq5/wNsr8xmpeRdkvPt+Ew1+Evp
 xYv8IZnyBG0FSscuqIMRBdzYiHeNCkEI7BY7Jch2cwg8Zj9hqs3PAI9TDstFD8COcrEFFG0zET5
 DFZ77wdaMsT7+S01ywZmZsLwhUC4YI745xYCwINuuBO+MHujMOmbihRQHY6v/hyJ6JBKvh1foB7
 b1jhXuCLYVuFtfhQqfWr5auNkDleNgtqqEGBQWng8I+8v67k51IKAFaXZGZRD7f3nceVea3tRS8
 7OVWBbA6qCQUCD2ZqIhYI9pFOuDWM5/Zi3PBg==
X-Received: by 2002:a05:6a21:1f84:b0:3c4:2cf9:2898 with SMTP id
 adf61e73a8af0-3c91b3401demr465509637.45.1785474000102; 
 Thu, 30 Jul 2026 22:00:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.21.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 21:59:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v6 08/24] net/sfc: replace rte_atomic with stdatomic
Date: Thu, 30 Jul 2026 21:57:46 -0700
Message-ID: <20260731045948.769926-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

