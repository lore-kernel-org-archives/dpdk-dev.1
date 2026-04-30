Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2408CFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7352C40BA3;
	Thu, 30 Apr 2026 13:15:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8585440B91
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547709; x=1809083709;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Z1ep9Bgj3BmLb9/jS8S30ByyZnXdW6K2uknWJ1+VdAM=;
 b=moI5ixumMkamXV/Y5FY281zZwYTB4BE5ht5GEo8GM1YCHguStIEnJ98h
 B5PKmj6pVlOze4uyE+Bv2yvZ1Z0eYOhKW5SuZX/6ohHU+Psi2JYlMfe7z
 A0ibbEhxAZ8SpDENR4laLzNsHih6bReQnb4HqH6ISOrDj2XRzufi20Fss
 aepJSeE8tTzCVYrW/L3DTZ0dtzI3Qa6xDNFAYbe/NFkn60kF79a2Y/qjs
 beWSjsG9tGVMdZH9HXgoFAjVLk7CZFgyWs7DZPnsFJ/qp7Y4wYd1AZIfF
 OS4VxSA7LwbxTyWgGJle14K8WpzZQaIW96HPTKJM2ihQ1gywmM/toxcN0 A==;
X-CSE-ConnectionGUID: 5/NJd2f/QdCuhm90PXj9LA==
X-CSE-MsgGUID: yVvd+nh/SkaxON3cKnRehw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482294"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482294"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:09 -0700
X-CSE-ConnectionGUID: JlmA3ulJRH6LOY0GZByjGQ==
X-CSE-MsgGUID: 4hslydjNRDCcjZLNDsgQjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444824"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 13/15] net/ixgbe: write drop queue at init
Date: Thu, 30 Apr 2026 12:14:42 +0100
Message-ID: <6d45bf1dcd4afb8da2e0dfaeeb00ca91347c1b6c.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
References: 
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

For FDIR, drop queue index never changes, so write it at init.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 80d70fe083..62edada379 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1468,6 +1468,9 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 	fdir_info->n_flows = 0;
 	fdir_info->mask_added = FALSE;
 
+	/* drop queue is always fixed */
+	IXGBE_DEV_FDIR_CONF(eth_dev)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
+
 	return 0;
 }
 
-- 
2.47.3

