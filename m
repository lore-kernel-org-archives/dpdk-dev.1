Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542EE606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bG8fY2aj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70741402D6;
	Thu, 19 Nov 2026 17:34:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 17419400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 17:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795106074; x=1826642074;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XUMCcuoBZWgzo8DOvaaepkuFYqw7MD17ynaVIPlYzjU=;
 b=bG8fY2ajQQD7/lILqoqlO+m5htQryfeszMsoQGHpCiUzcpt/P6ikSmdL
 yix6RzylYNqflQPirdvHU5/ndX8ijN17Cdm+GNw/XQHBU0Rk7Kb+9u+F/
 4xi1iMSbrKbao1aHWNH6ueIUQkYxN/7GI3QlHLC0hK+JbKcRDt6Sx1olk
 5iGZQ7uV965GBsDzV6arBCmbCOgO370YjrzBEjLJZIiVmVrkPI83NUNLA
 ppbO/u5+sgc4NBiOIsoJ2mzFhjVA3i+sAy1njt1HJ7WJ4uoQPDg3xM8b7
 /Ug0ORNRY67XCw556DinFReT5lL9b6bqiXk9XDz2NI5iDzdwNBQ79lD42 A==;
X-CSE-ConnectionGUID: mONc0Q06S2+xom3Mp1uuXg==
X-CSE-MsgGUID: bOs9Gy9nQIykzEauW8p8aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3882991"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3882991"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:34:32 -0800
X-CSE-ConnectionGUID: kNfYKFDMQG2KTofdiIS3Wg==
X-CSE-MsgGUID: /H9Vmz+aSHycKnYl2Mw2OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10807961"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa009.fm.intel.com with ESMTP; 19 Nov 2026 08:34:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>
Subject: [PATCH v1 1/2] net/virtio: release Rx interrupt resources on reinit
Date: Thu, 19 Nov 2026 16:34:28 +0000
Message-ID: <5742c809e0515dbe0373788c1e9fff09b7cc1b46.1795106045.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Reinitializing a virtio device with Rx interrupts enabled can allocate
MSI-X eventfds twice. Before eventfd fix, this was leaking the original
descriptors, after the fix this has turned into failure when EAL rejects
the repeated enable.

Release the existing VFIO MSI-X interrupt resources before
reinitializing the device.

Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/virtio/virtio_ethdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index e6ad2de4baa..c595b8edcb2 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -1864,6 +1864,15 @@ virtio_init_device(struct rte_eth_dev *eth_dev, uint64_t req_features)
 	struct virtio_net_config local_config;
 	int ret;
 
+	/* Release Rx interrupt resources left by a previous initialization. */
+	if (eth_dev->intr_handle != NULL &&
+			rte_intr_type_get(eth_dev->intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX &&
+			rte_intr_nb_efd_get(eth_dev->intr_handle) > 0) {
+		virtio_intr_disable(eth_dev);
+		rte_intr_efd_disable(eth_dev->intr_handle);
+		rte_intr_vec_list_free(eth_dev->intr_handle);
+	}
+
 	/* Reset the device although not necessary at startup */
 	virtio_reset(hw);
 
-- 
2.52.0

