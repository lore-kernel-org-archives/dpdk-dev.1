Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B4CD3427
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 17:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6757F40431;
	Sun, 10 May 2026 19:03:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9225640431
 for <dev@dpdk.org>; Sun, 10 May 2026 19:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZbPsueqv1XAf4dohIA95eFAKSrW9EU2T4MdGGAjbJo=;
 b=AyUpdEPhr2L4RJkl+AynTPWuvv1nSUxcNjujIF3TqCqrLxIzCkUCngvcjChYU/gwXcZpoh
 Afb4zIhloRk42W8JAG1PkEBZp2BNnHrDBgoSamdCP45UhldPNCKn4bKwqcxVg12U4JX38h
 RldfNf1hHKyxMl0oLCBh6HgXMSzyt7U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-dNBExQ6tOkyRiGhttKJhkQ-1; Sun,
 10 May 2026 13:03:19 -0400
X-MC-Unique: dNBExQ6tOkyRiGhttKJhkQ-1
X-Mimecast-MFC-AGG-ID: dNBExQ6tOkyRiGhttKJhkQ_1778432597
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978841800578; Sun, 10 May 2026 17:03:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41AE819560A6; Sun, 10 May 2026 17:03:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 1/5] ethdev: check VMDq availability
Date: Sun, 10 May 2026 19:03:01 +0200
Message-ID: <20260510170306.3406045-2-david.marchand@redhat.com>
In-Reply-To: <20260510170306.3406045-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PimoNu8aSERvncHHMVQEDrGUwe7dMqnlhJvPWlAQ-ks_1778432597
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
---
Changes since v2:
- added an entry in release notes,
- changed approach: relied on pre-existing dev_info->max_vmdq_pools
  rather than introduce a new device capability,

Changes since v1:
- dropped incorrect VMDq feature announce for bnxt representors, em,
  i40e representors, ipn3ke representors,

---
 doc/guides/rel_notes/release_26_07.rst |  6 ++++++
 lib/ethdev/rte_ethdev.c                | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..b59793f177 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -92,6 +92,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Updated VMDq related API in ethdev.**
+
+  * At port configuration time, the number of VMDq pools advertised by a driver is now used to
+    validate VMDq related Rx and Tx modes (``RTE_ETH_MQ_RX_VMDQ_FLAG``, ``RTE_ETH_MQ_TX_VMDQ_DCB``,
+    ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
+
 
 ABI Changes
 -----------
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..eae34954e2 100644
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
2.53.0

