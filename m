Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1CC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:03:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8AE24060B;
	Thu,  9 Jul 2026 18:03:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 46AF440268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 18:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783612982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxRsP48vxKgrdINfGiTmI539Dw0cs8mTudNQjiF/rz0=;
 b=XYmKVRGbpLpQWx/HhpmHYe+PfY9JOkoNqSV3dagtiFxQ57o4XRMCC+zciurDU0wUNzNk1E
 SsSTaBhwnGZSs6xlPkYRwL9ht2040KfWOX/lcPISHjtqpuU7xQwGZugpt6cNM9bssts3FB
 okRctbrdsJF1TiiRXMQV6Q+69JW4nY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-JmSUOIQ-O0mAvz0KwBEgoQ-1; Thu,
 09 Jul 2026 12:02:59 -0400
X-MC-Unique: JmSUOIQ-O0mAvz0KwBEgoQ-1
X-Mimecast-MFC-AGG-ID: JmSUOIQ-O0mAvz0KwBEgoQ_1783612978
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F19131801BD5; Thu,  9 Jul 2026 16:02:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9ED3C18005A7; Thu,  9 Jul 2026 16:02:55 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v4 01/10] ethdev: check VMDq availability
Date: Thu,  9 Jul 2026 18:02:37 +0200
Message-ID: <20260709160247.1798575-2-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IXRMkFfyhJZvP5GL9_jgEKXRkLa3XtagQrEUe-yjBcY_1783612978
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
index 6352ef27ab..5e9178d36b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -314,6 +314,12 @@ API Changes
   - ``rte_flow_dynf_metadata_get``
   - ``rte_flow_dynf_metadata_set``
 
+* **ethdev: updated VMDq related API.**
+
+  * At port configuration time, the number of VMDq pools advertised by a driver is now used to
+    validate VMDq related Rx and Tx modes (``RTE_ETH_MQ_RX_VMDQ_FLAG``, ``RTE_ETH_MQ_TX_VMDQ_DCB``,
+    ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
+
 * **mlx5: promoted driver event and steering management APIs from experimental to stable.**
 
   The following mlx5 functions are no longer marked experimental:
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

