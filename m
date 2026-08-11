Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BEAC5AD7B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30EE0402AB;
	Tue, 11 Aug 2026 06:26:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9548740272;
 Tue, 11 Aug 2026 06:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786422414; x=1817958414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x38F1U5gDvwNE0hKlINDI8T8Jgbnje3NPaPAsDkATHI=;
 b=cVVz6H772Y1Wk+ARHH6PKBQk5RL6ITjlG6vYTgyChG+5O0oirlGc4pfF
 p96bQBKE7EGbDBnyKVJ87vmB7xNcB8HJEoKL7p1Fu0CKrsfCcHUC6hwxW
 oK/uBlTWt2o6irUI/NfLEo/KWTYk5JJtlz3ZoX2KV2/5Xl3yNZj6hWjzs
 jIYbuCdZCzFX5tjESsigNfxHTCgb+KnzIeIGbv4pT6dGgEIbhagi4p8KZ
 oesPJh7J6CRe/79C8eYPgVpYGFeHDoUubDiFzbWnqnMKSslXUYF56mci9
 IV6X1dxT9N0mbAvc9nCuFZ4I0Sgl03INRWuJJRJpZK5F3onQ3zc+OTaey Q==;
X-CSE-ConnectionGUID: D9n6r2riSYSTaxDq5VSy2Q==
X-CSE-MsgGUID: MxQ5pAg3SSifTJ0plW3hhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="74480216"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="74480216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 21:26:52 -0700
X-CSE-ConnectionGUID: U2824nBiTgS5EVvpjZHK1Q==
X-CSE-MsgGUID: Wu4iR4ZsQGixVudzGEwZlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="263276871"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by orviesa007.jf.intel.com with ESMTP; 10 Aug 2026 21:26:51 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH] net/idpf: propagate PCI NUMA node to vport ethdev
Date: Tue, 11 Aug 2026 09:56:35 +0530
Message-Id: <20260811042635.465194-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

The IDPF driver creates vport ethdevs via rte_eth_dev_create() with a
NULL bus_specific_init callback, bypassing the standard PCI probe path
that normally copies the PCI device's NUMA node into
eth_dev->data->numa_node via rte_eth_copy_pci_info().

As a result, rte_eth_dev_socket_id() always returns 0 regardless of
which NUMA node the device is attached to, causing NUMA-unaware memory
allocations for mempools and queue descriptors on multi-socket systems.

Set dev->data->numa_node explicitly from the parent PCI device in
idpf_dev_vport_init() to restore correct NUMA affinity.

Fixes: 5e0f60527e5b ("net/idpf: remove vport req and recv info from adapter")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index c13505416a..965de4ed9d 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1565,6 +1565,7 @@ idpf_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	int ret = 0;
 
 	dev->dev_ops = &idpf_eth_dev_ops;
+	dev->data->numa_node = dev->device->numa_node;
 	vport->adapter = &adapter->base;
 	vport->sw_idx = param->idx;
 	vport->devarg_id = param->devarg_id;
-- 
2.34.1

