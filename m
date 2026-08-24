Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76256C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:42:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C06CB40664;
	Mon, 24 Aug 2026 13:42:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 49D374027C
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787571755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ac2WZMiwCtW9EnExe7sXmSkrpWzARcToDs8TJ7eWo7Y=;
 b=g6g7aljpE/ArwoOlnAsGmAyPOPSi1D6xA7nJamwXHiLvtAB6P+ZdPIojFeU7gWrlJfZ9dp
 ugbX9+idoK3S4fnnXJ3Ors4UQRdNhHftvJLK3Q2SuQ6FsuW975PHY6VyMrH44fjzONwsV1
 mSffZoNTqjaTfk8sbwIIgIieh7ce5ys=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-FfiBF4mePkyfKUOJEoOr0g-1; Mon,
 24 Aug 2026 07:42:32 -0400
X-MC-Unique: FfiBF4mePkyfKUOJEoOr0g-1
X-Mimecast-MFC-AGG-ID: FfiBF4mePkyfKUOJEoOr0g_1787571751
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 013C61955E7F; Mon, 24 Aug 2026 11:42:31 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3BC726C; Mon, 24 Aug 2026 11:42:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 1/3] ethdev: check VMDq availability
Date: Mon, 24 Aug 2026 13:42:05 +0200
Message-ID: <20260824114207.312513-2-david.marchand@redhat.com>
In-Reply-To: <20260824114207.312513-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260824114207.312513-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Xs0y6LiWjfVijJ3-IVb-GxsRy2QoczV0aaKH4Y-feE_1787571751
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Refuse VMDq related Rx/Tx modes when the driver do not announce VMDq
pools availability.
This will used later as a gate to ignore/reject VMDq related matters.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
Changes since v4:
- rebased,

Changes since v2:
- added an entry in release notes,
- changed approach: relied on pre-existing dev_info->max_vmdq_pools
  rather than introduce a new device capability,

Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,

---
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 lib/ethdev/rte_ethdev.c                | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..4b68a5319e 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -93,6 +93,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **ethdev: updated VMDq related API.**
+
+  * At port configuration time, the number of VMDq pools advertised by a driver is now used to
+    validate VMDq related Rx and Tx modes (``RTE_ETH_MQ_RX_VMDQ_FLAG``, ``RTE_ETH_MQ_TX_VMDQ_DCB``,
+    ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
+
 
 ABI Changes
 -----------
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..9e305d98c1 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1581,6 +1581,22 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+	if (dev_info.max_vmdq_pools == 0) {
+		if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support VMDq rx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+		if (dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
+				dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support VMDq tx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+	}
+
 	/*
 	 * Setup new number of Rx/Tx queues and reconfigure device.
 	 */
-- 
2.54.0

