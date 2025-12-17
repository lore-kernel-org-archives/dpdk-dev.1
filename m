Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EFD65C5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 15:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB6340430;
	Wed, 17 Dec 2025 16:03:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7F7364026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 16:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765983793; x=1797519793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zsJcmWjSX1eEBiFcfN6aZyO5LXPyijDGZd3ts9ZQM1I=;
 b=YHvPS7rDzm4xqRi1Sw2BRaxyaKaW36eI090K2omg6qYoyBtgv7G9bVID
 L7Nu7X7zuv0F6Vadx0sdt1yjlCz2bb3tk0qz2rdvQiUJvTNRQ+BEGPCdF
 db9W0+owtF0pprBmZ8DPyxdQVgm1Q0GGvjIGw4CG/oXmc3FQ2uYkfJiiW
 dvc1qzkv196lydoiN62F3+3lc0fUlMqPrUan9dwuRok+3ODXHalVyUvB5
 tSF3NnijmjOjl6tsJFCHH+w3YM9VR9B+5l7hlbasjJaRVWYi7oJpFZRpw
 EWIcdZ5/Hg0JjymhPFOdjxqeLEVAk89S7QlsrCfFAXx3v6ul9L8Ju9Dpq g==;
X-CSE-ConnectionGUID: LTcF4cDvTbKDdF3DReIfrQ==
X-CSE-MsgGUID: 4YLIzEvZS5i7T3CQudXy4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67811380"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="67811380"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:03:12 -0800
X-CSE-ConnectionGUID: pg4D2BH0QwGj2/tLHYFCUg==
X-CSE-MsgGUID: lkuRDf2RSJCLQYyAmp0ykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="198212940"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2025 07:03:11 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/1] net/i40e: unset vector flag when scalar path is chosen
Date: Wed, 17 Dec 2025 14:54:36 +0000
Message-ID: <20251217145436.3217068-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217145436.3217068-1-ciara.loftus@intel.com>
References: <20251217145436.3217068-1-ciara.loftus@intel.com>
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

The tx_vec_allowed flag should be set to false if a scalar Tx path is
chosen.

Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2db58c6b24..dd859bda4e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3631,6 +3631,9 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 			ad->tx_func_type == I40E_TX_ALTIVEC ||
 			ad->tx_func_type == I40E_TX_AVX2)
 		dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
+
+	if (i40e_tx_path_infos[ad->tx_func_type].features.simd_width < RTE_VECT_SIMD_128)
+		ad->tx_vec_allowed = false;
 }
 
 int
-- 
2.43.0

