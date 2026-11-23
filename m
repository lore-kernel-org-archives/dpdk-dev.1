Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C0606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lIZZMbsC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62E89402CC;
	Mon, 23 Nov 2026 11:24:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 6EE7440262;
 Mon, 23 Nov 2026 11:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795429490; x=1826965490;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=u6TYQynqZec+SdWvUck9FqGifeyW4g1FTVH17kfaUWw=;
 b=lIZZMbsCUy6BR9vAbj8ocMVllcQz9v/APTaOjQYQVTFRxilMwdY8r/Ql
 dLEQeFumqCd1m14igGQ0PHpIWE5H7edQXHAax1ZyhfnJpb3tbcpXgaDXD
 NTC8QCEgPBvgI1k//ovAbtywDz/Rh9fur3CZ0T1LKqIdZ0Iz+Idi0SHht
 SW2m7X6EUa3B4xWpa3KjUA96GO8vIiygqrsfTB9Vdac6lhmfj7Eg4x50P
 Dn62mnSx9bj0BEphONBCThSWhwWRMyRjcwuSOa756TpTFAmfz41ps1bi7
 xOzexrt6Hd74E9kCan356Za21tvm4i4/F7w3XqKtMqyHhOWO54vi0I0vP w==;
X-CSE-ConnectionGUID: ayCsDBrJQlmjaoApdmS2JQ==
X-CSE-MsgGUID: ZPp460jITMGogI6ZVKj3iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4212370"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4212370"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 02:24:47 -0800
X-CSE-ConnectionGUID: izZ0PlZnQ/W2J3jk9RxkuA==
X-CSE-MsgGUID: B7eZB+GuSNaEevfcic7chw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11148912"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 02:24:47 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/virtio: fix eventfd enable on device re-init
Date: Mon, 23 Nov 2026 10:24:33 +0000
Message-ID: <20261123102434.215799-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_dev_configure() can call virtio_init_device() more than once
with Rx interrupts enabled. Each call enables the eventfds again without
releasing the previous ones. This used to leak the old eventfds, but EAL
now rejects the repeated enable, causing dev_configure() to fail.

Fix this by disabling the eventfds before enabling them again, except
for virtio-user which does not recreate them.

Fixes: e7b9d1d2806c ("net/virtio: fix Rx interrupt setup")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/virtio/virtio_ethdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index f2302089ee..18d258a519 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -1455,6 +1455,10 @@ virtio_configure_intr(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
+	/* Release efds from a previous init. VDEV owns its own */
+	if (rte_intr_type_get(dev->intr_handle) != RTE_INTR_HANDLE_VDEV)
+		rte_intr_efd_disable(dev->intr_handle);
+
 	ret = rte_intr_efd_enable(dev->intr_handle, dev->data->nb_rx_queues);
 	if (ret < 0) {
 		PMD_INIT_LOG(ERR, "Fail to create eventfd");
-- 
2.43.0

