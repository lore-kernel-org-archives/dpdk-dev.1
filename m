Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35773C5DF94
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Aug 2026 00:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EC804069F;
	Sat, 22 Aug 2026 02:06:53 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id C62D940151
 for <dev@dpdk.org>; Sat, 22 Aug 2026 02:06:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.67.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 2AC41E0988;
 Sat, 22 Aug 2026 04:06:49 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 2AC41E0988
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787357209;
 bh=0B52QyC8T2GdVt2L9N6S2xEV6akqMtx0Zn1qFkW83FE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0nRcDSoj3cPejRvNtwghblzcSVE5jZfcZomsjXAea6nOfx9DF2scyBk7TjnET2xrW
 K4xp/cLcxDU3sB22YRYSsm7i7fMTXrYxFUNM1lWVfe/fwC+9aq4I3791qiPl1zblTc
 ikZtPWX15q9dsNPSsLUOgZVukPQZBVfyLbHj+BKocHVpAi6pe43LJGMpH0N7EixQsq
 KtxX1VHgo8VNX/zfZ6i4dl4zHOguGOszdaAbBR+fZOJ9eSwWGX5D9j99dWTApBnZWR
 QtW/GizIQS5+Qj91lP9DzPtW968NS3vv8sQDDWAv8bTi0AO9lVtn8qAJ53AJa+Xjxw
 jgw3rzmd3DSLg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 2/2] net/sfc: provide cached dev info to use in secondary
 process
Date: Sat, 22 Aug 2026 04:06:46 +0400
Message-ID: <20260822000646.12718-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260822000646.12718-1-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
 <20260822000646.12718-1-ivan.malov@arknetworks.am>
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

Secondary process support in the 'test-pmd' application now requires that
the driver expose the 'dev_infos_get' method within that context. Use the
cached dev info from the primary process in order to meet the requirement.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/net/sfc/sfc.h        | 19 ++++++++++++++
 drivers/net/sfc/sfc_ethdev.c | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index 629578549f..809ad59148 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -156,6 +156,25 @@ struct sfc_adapter_shared {
 	unsigned int			nb_repr_txq;
 
 	struct sfc_nic_dma_info		nic_dma_info;
+
+	/*
+	 * Snapshot of the 'rte_eth_dev_info_get' output created by the primary
+	 * process attach path for the secondary process to use in its own
+	 * implementation of the 'dev_infos_get' method.
+	 *
+	 * Some driver-computed fields derived from mutable post-attach state
+	 * are knowingly stale, which is acceptable for the secondary process.
+	 *
+	 * This also contains a handful of stale fields which are normally
+	 * set by the ethdev layer upon invocation of the 'dev_infos_get',
+	 * so they will be overridden anyway in the secondary process.
+	 */
+	struct rte_eth_dev_info		dev_info_cache;
+	/*
+	 * Set to 'true' by the probe function from the primary process. The
+	 * secondary 'dev_infos_get' returns '-EAGAIN' when this is 'false'.
+	 */
+	RTE_ATOMIC(bool)		dev_info_cache_is_valid;
 };
 
 /* Adapter process private data */
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 13619b4b9a..a02697a7cd 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -16,7 +16,9 @@
 #include <bus_pci_driver.h>
 #include <rte_errno.h>
 #include <rte_string_fns.h>
+#include <rte_stdatomic.h>
 #include <rte_bitops.h>
+#include <rte_ethdev.h>
 #include <rte_ether.h>
 
 #include "efx.h"
@@ -3163,7 +3165,32 @@ sfc_eth_dev_clear_ops(struct rte_eth_dev *dev)
 	sa->priv.dp_rx = NULL;
 }
 
+static int
+sfc_dev_infos_get_secondary(struct rte_eth_dev *dev,
+			    struct rte_eth_dev_info *dev_info)
+{
+	const struct sfc_adapter_shared *sas =
+		sfc_adapter_shared_by_eth_dev(dev);
+	bool valid = rte_atomic_load_explicit(&sas->dev_info_cache_is_valid,
+					      rte_memory_order_acquire);
+
+	if (!valid)
+		return -EAGAIN;
+
+	*dev_info = sas->dev_info_cache;
+
+	/*
+	 * The cache holds stale primary-process pointers; restore
+	 * the process-local values from the caller-supplied 'dev'.
+	 */
+	if (dev_info->switch_info.name != NULL)
+		dev_info->switch_info.name = dev->device->driver->name;
+	dev_info->device = dev->device;
+	return 0;
+}
+
 static const struct eth_dev_ops sfc_eth_dev_secondary_ops = {
+	.dev_infos_get			= sfc_dev_infos_get_secondary,
 	.dev_supported_ptypes_get	= sfc_dev_supported_ptypes_get,
 	.reta_query			= sfc_dev_rss_reta_query,
 	.rss_hash_conf_get		= sfc_dev_rss_hash_conf_get,
@@ -3787,6 +3814,27 @@ static int sfc_eth_dev_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	if (rc != 0)
 		return rc;
 
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
+		struct sfc_adapter_shared *sas =
+			sfc_adapter_shared_by_eth_dev(dev);
+
+		/*
+		 * Pre-fill the dev info cache for the secondary
+		 * process. The port has been registered at this
+		 * point, allowing use of the public API.
+		 */
+		rc = rte_eth_dev_info_get(dev->data->port_id,
+					  &sas->dev_info_cache);
+		if (rc == 0) {
+			sas->dev_info_cache.device = NULL;
+			rte_atomic_store_explicit(&sas->dev_info_cache_is_valid,
+				true, rte_memory_order_release);
+		} else {
+			sfc_warn(sa, "failed to cache dev info for the secondary process");
+		}
+	}
+
 	rc = sfc_eth_dev_create_representors(dev, &eth_da);
 	if (rc != 0) {
 		if (dev_created)
-- 
2.47.3

