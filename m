Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C9DC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 23:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F2114027B;
	Sat, 22 Aug 2026 01:45:17 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EF94E4027B
 for <dev@dpdk.org>; Sat, 22 Aug 2026 01:45:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.67.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id E3733E0986;
 Sat, 22 Aug 2026 03:45:15 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am E3733E0986
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787355916;
 bh=8Guy2AISi4smSOb8FNxxWZ3yk0ocdLmlBrLIRIYBlfc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f9F/uZCppky3fjb1GuJpVHfYYJTBQ5Kr4nwT99k5Cexj89qfuDDhzrAQ5Z3ALaKKH
 AoSpc+FB6Y3ca5jALZNOayfJUIobrC05CnFy6gvgGbpO3HVKKDKKAHm+T1s4DdeBC2
 /epCOexn0IKXNWl6RP+qC/vxUrS2sbo9flVG6pVV5sYL0wJyz7KVG+XqyAsNXdWryj
 Li2kj8BZGN78JGy+lt1JnUDT3vBcA2kHSZjyY5+mpha4rYP95saeEhgBjWH6EEmuqd
 Uy8dq6v4KWh5qWgamnIoz8Rg4WT616LBPnjDa1Hivi6u7HFdRs6kVQun092PPsKKmz
 MWHmWw60NFh2w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 2/2] net/sfc: provide cached dev info to use in secondary
 process
Date: Sat, 22 Aug 2026 03:45:06 +0400
Message-ID: <20260821234506.12049-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821234506.12049-1-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
 <20260821234506.12049-1-ivan.malov@arknetworks.am>
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
 drivers/net/sfc/sfc_ethdev.c | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

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
index 13619b4b9a..2739985bab 100644
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
@@ -3749,6 +3776,7 @@ static int sfc_eth_dev_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	struct rte_pci_device *pci_dev)
 {
 	struct sfc_ethdev_init_data init_data;
+	struct sfc_adapter_shared *sas;
 	struct rte_eth_devargs eth_da;
 	struct rte_eth_dev *dev;
 	bool dev_created;
@@ -3787,6 +3815,27 @@ static int sfc_eth_dev_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	if (rc != 0)
 		return rc;
 
+	sas = sfc_adapter_shared_by_eth_dev(dev);
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		struct sfc_adapter *sa = sfc_adapter_by_eth_dev(dev);
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

