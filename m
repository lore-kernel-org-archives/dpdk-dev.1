Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5439CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F2340A6F;
	Thu, 21 May 2026 20:07:25 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 98AA440677
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:21 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-132c338a537so4384039c88.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386841;
 x=1779991641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtO5XLVPbo2xyfbSMZqNWk8kbz8dmkFljgSKBl90kP8=;
 b=Fv1eE2lA3iBJOiN7Yd2CpCK4dlvEYGuLSbcrN6WaHyXnW2NrHZXJtwM9u65M65dwzK
 1FtI2tffcqZfDPWOB81UqmiLOkSx/k2lmiqgQMQqN1cDvNTjp5o1iJptR/Z+24wcvR8k
 fdB53m84udnauWwkUFCvSuY4o0/8PXBuGwaLrg+lZB0ycLxAIyJFOoi9/qtWWMmIt/tc
 HS66lTQhPHzhJgruDiv314jgG3wQsJLcXtkcbn6wt6kwbb7lB4enlh1omTP2T+gC4Bp4
 3dkYygFsDuGKUBLFWeAfT7GaCOeH+3PRVXC5537yvDIIC7O1N7DRp6FKvLJGLlbv/Lnx
 LGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386841; x=1779991641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtO5XLVPbo2xyfbSMZqNWk8kbz8dmkFljgSKBl90kP8=;
 b=mM8T7ZfUaEJ350jDIYAJDynjueAkxBIcxRpuQApQz0ArllOQsjYKajM2CIolD6izui
 Bsm3SAA34uPrDaWKNND6aZqbqawn5gLfUFGjEbRkQwzqI6mxuDuUL0/S5vuzVvuyTWq/
 AXRmx0O+7ZrHQmHj1SH7x8Vb1s+QUBtOphJL2XbXwaohsgXw5xRHsVbN7WuXS0SdIkGf
 BIJhAf++Lm7vQFhfOA/YKXdA4ezDuvsoTncN9J6vrJbWM1RY8A3fOcqPLgm7pfWAHmfe
 uX/oICrJ3eTG4c3wriC9F83HC3Y3rne4ITZL2ayNceuccyQGcob1roW9kkA6jn5U9gI7
 164g==
X-Gm-Message-State: AOJu0YyrVI4S02xN4Zuv+ZSH+SwWCVe0dCFsM0UE7g5WAd2kT0Q2ZiFh
 IQ2mveWKlpthnHnH7PZxdhzZkpyzkDR7CxqEB91trrKe7abu94PBKccAFA8dQddPid7/uUrwNMp
 /fsFP
X-Gm-Gg: Acq92OHmQ/MmLyAbvFPPVrVGspt69njyXP/gWfaOgdHgXz2IKwyFbdHQxZXzPo4Hczi
 0V8wlHOZNc7UWkOTFb2T/DeZy73ICvxXGY+9U0TE/akltUEtmOKJM1JKvEliub1AAOx89OlePtP
 DGN8ig6D0c0J4jxveIzmC2ersYEPup0B5kP2fm3b2iuF2/SXR+W4sIZRPb0BavOLc4y0bDACLG3
 3lfu1lvHERgOCfWk0bbE4Bnhj4cHwLa5zjevgKE1Nhegz72j4UY1dSuvD7ULXAboDRI6oImlm0W
 yE/Da86yUAl1c63j41Bc5BhivOHx9NePWfjU4lB4IjWcBXJB4fqfKxMbPvJMe05A/5B772CIVAD
 eNNUMjQiqSGLBkm0/wn0uV3IKWE0v5Lj+VrrUE2aMFjl+XLvq3NjpfAD9AWh6pXZQSti6umivZf
 u3Y/yKyrHcU7BOYla34frC6IFfBgq3cbggk/dtNCbuK5juqWAHAfzRTLndGqsrbLiGpaDL9SJ1O
 s2q3OWFDF4=
X-Received: by 2002:a05:7300:2147:b0:2ca:bd22:6102 with SMTP id
 5a478bee46e88-30430f5a25cmr1976103eec.14.1779386840476; 
 Thu, 21 May 2026 11:07:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC v2 10/11] net/sfc: replace rte_atomic with stdatomic
Date: Thu, 21 May 2026 11:04:22 -0700
Message-ID: <20260521180706.678377-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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

