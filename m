Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A08C5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 820ED406A2;
	Thu, 20 Aug 2026 15:03:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 37D9840679
 for <dev@dpdk.org>; Thu, 20 Aug 2026 15:03:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.79.191])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 23AF9E0CD2;
 Thu, 20 Aug 2026 17:03:24 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 23AF9E0CD2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1787231004;
 bh=5U58fWtb2fomwGJbemaoMWXJ592KP+6vkiTsoLhS7Lg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=z8eGf/uW4jY1SR5Rrw+V8AH8nT06qX0izL45hIhZ9AoxwYgTfMIugKoWdrRWyPqXU
 GxzJDr+8O5298PfgMuP8U+fx7FrtT/monSWYmSu9BwUxO504KS1cFU4l2LThD1Rhcl
 91qXzzufS6vjm4AXPqv/J1ECjzgS5NaYI4gbO0PZ+EhLEjZsC3pKY4I/x51Ap1Vgxs
 qtK4zsJCQhTDdVXOy1/+NhFPcqsl7M76D5pcDD/Nc9J5dDzmjVnG9MstjNnytlRyLq
 EB1g6Lh6EBwEGnYID7v4BCoqBxIXz3+qjMJWlfObmiVV6EOrVQEEGP8/2gL2DgLJPY
 k4sVrc6KBMpfA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 2/2] net/sfc: provide cached dev info to use in secondary
 process
Date: Thu, 20 Aug 2026 17:03:14 +0400
Message-ID: <20260820130314.12251-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260820130314.12251-1-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
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
 drivers/net/sfc/sfc.h        |  7 +++++++
 drivers/net/sfc/sfc_ethdev.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index 629578549f..9fcc8c9044 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -156,6 +156,13 @@ struct sfc_adapter_shared {
 	unsigned int			nb_repr_txq;
 
 	struct sfc_nic_dma_info		nic_dma_info;
+
+	/*
+	 * Snapshot of the 'sfc_dev_infos_get' output created by the primary
+	 * process attach path for the secondary process to use in its own
+	 * implementation of the 'dev_infos_get' method.
+	 */
+	struct rte_eth_dev_info		dev_info_cache;
 };
 
 /* Adapter process private data */
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 13619b4b9a..aa0e92b004 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -3163,7 +3163,22 @@ sfc_eth_dev_clear_ops(struct rte_eth_dev *dev)
 	sa->priv.dp_rx = NULL;
 }
 
+static int
+sfc_dev_infos_get_secondary(struct rte_eth_dev *dev,
+			    struct rte_eth_dev_info *dev_info)
+{
+	*dev_info = sfc_adapter_shared_by_eth_dev(dev)->dev_info_cache;
+
+	/*
+	 * The cache holds a stale primary-process device pointer;
+	 * restore the process-local one passed in by the caller.
+	 */
+	dev_info->device = dev->device;
+	return 0;
+}
+
 static const struct eth_dev_ops sfc_eth_dev_secondary_ops = {
+	.dev_infos_get			= sfc_dev_infos_get_secondary,
 	.dev_supported_ptypes_get	= sfc_dev_supported_ptypes_get,
 	.reta_query			= sfc_dev_rss_reta_query,
 	.rss_hash_conf_get		= sfc_dev_rss_hash_conf_get,
@@ -3443,6 +3458,20 @@ sfc_eth_dev_init(struct rte_eth_dev *dev, void *init_params)
 
 	sa->link_ev_need_poll = encp->enc_link_ev_need_poll;
 
+	/*
+	 * Pre-populate the dev info cache for the secondary process.
+	 * All prerequisites (probe, attach) are met at this point.
+	 * The 'sfc_dev_infos_get' helper always returns 0.
+	 *
+	 * Care to initialise the switch info and reset the device
+	 * pointer as it is going to be stale in the context of
+	 * the secondary process and it will have to fix it.
+	 */
+	sas->dev_info_cache.switch_info.domain_id =
+		RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID;
+	(void)sfc_dev_infos_get(dev, &sas->dev_info_cache);
+	sas->dev_info_cache.device = NULL;
+
 	sfc_adapter_unlock(sa);
 
 	sfc_log_init(sa, "done");
-- 
2.47.3

