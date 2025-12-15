Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C6D5B16C
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A2104042E;
	Mon, 15 Dec 2025 15:07:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4FD8A402D0
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807671; x=1797343671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5+1jWAuTAsgmX66bMogP2c4F1ZFsZ+QBEgpfJuU3CHA=;
 b=nq4qUC2ooV5BIyAzTw0RIYBvZQQ3xmAxzovu7b3nw7EHJAHnzwAyNNvl
 xsDN7H/TBeGAJPHsnWkkRf6ryg2tgcEgl+e/RS6nczaYZ5wFZyUIedy/e
 DFuVLJBGg9ZyQJp+xIKXm3K0/FZZUY+yVAE+QzDcJDjtsajGaG9ldb7AA
 inHDkSFSTklID8ROVRWuMN4hXkQ5SOKDHjM+bwp3sldpd92rcSPLkUoJy
 mf2A/yWDCEp3EeHO0JLOJ0jGlXUCrzAJmbztbPtw3ote0kykZ0BK60J1E
 qRbkXm3wss5UVxy3iD4LM6yszPRAae8fqv4IqDlcyYq5a2wERM2xjpuGg g==;
X-CSE-ConnectionGUID: B/XBA2r6Rger1mZ2O/ZAsw==
X-CSE-MsgGUID: C5j1LNYWTo2sSVdDEPO0xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078689"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078689"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:50 -0800
X-CSE-ConnectionGUID: 5xcQ49RLSFW8YwZcxsGeRw==
X-CSE-MsgGUID: x9Qn9VTeRRWy3ZaPPdOXlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996402"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:49 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 4/8] net/idpf: ensure all Tx paths are selectable
Date: Mon, 15 Dec 2025 14:05:49 +0000
Message-ID: <20251215140553.2283531-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Tx paths are defined. The Tx path selection function
iterates sequentially from zero to num_paths where num_paths is the size
of the array as determined by the RTE_DIM macro. However, depending on
the platform, some of these entries may be empty, and valid entries at
the end of the array may never be considered in the selection function.
Fix this by editing the idpf_tx_func_type enum and only defining a value
for the Tx path if it is implemented in the idpf_tx_path_infos array.

Fixes: 04bb7e425614 ("net/idpf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 31915a03d4..9d3f35176d 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -78,9 +78,13 @@ enum idpf_rx_func_type {
 enum idpf_tx_func_type {
 	IDPF_TX_DEFAULT,
 	IDPF_TX_SINGLEQ,
+#ifdef RTE_ARCH_X86
 	IDPF_TX_SINGLEQ_AVX2,
+#ifdef CC_AVX512_SUPPORT
 	IDPF_TX_AVX512,
 	IDPF_TX_SINGLEQ_AVX512,
+#endif
+#endif
 	/* Need a max value defined as array values in are defined
 	 * in a C file in idpf driver, but cpfl driver needs to reuse
 	 * that array and know the size
-- 
2.43.0

