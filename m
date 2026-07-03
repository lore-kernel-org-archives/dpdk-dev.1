Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17699C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E619240DCB;
	Fri,  3 Jul 2026 15:19:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 042E74069F;
 Fri,  3 Jul 2026 15:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783084795; x=1814620795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ePjkIUw8COMw3FhtkL4UZCCJOAwJ0doRl8WtgqFPO8U=;
 b=OrnnVare4TAj5nzgN7AGHdZxkfpIBx6Q9b2Dbo5YprF+yIqHeC7PJcX2
 NViB54DJyR4/oXCxEsOjKTvUNHc6zW+9RUKZxwROKqpYMUeYeVDKTVFq/
 Fa90Cx+qYB9QDJj8QHZGmIAMYZD4wgQ+FxnFnketvULlRBigI8IMtk552
 0plCyjMFhMuo1TusqTAjKF+5s8x1YlUAhs28aeUTMoWAFHdRbmO6Lpp9h
 dVNKMwBecpDPQvuN/gDcOg1FU1DOfiSujxORzdSfZGAurn89o959Mlfc1
 0wFFDhXneaAwh7EFxt1EbKi2La5zgrY4w1aE7s/HSb2/ViSfTXjY4XA6j Q==;
X-CSE-ConnectionGUID: 66tY2JJVQcO+zDza+3hWdA==
X-CSE-MsgGUID: Bx5t58ZvSRu3KTWu2tZwCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94486681"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="94486681"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 06:19:54 -0700
X-CSE-ConnectionGUID: ruwWnXL3ThOgq7QdjUybXQ==
X-CSE-MsgGUID: j/9mAKquSvyCNgIxKKq2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257439868"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Jul 2026 06:19:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Haiyue Wang <haiyue.wang@intel.com>, Jeff Guo <jia.guo@intel.com>
Subject: [PATCH v2 5/6] net/iavf: fix leak of flex metadata extraction field
Date: Fri,  3 Jul 2026 14:19:19 +0100
Message-ID: <20260703131921.4102325-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703131921.4102325-1-bruce.richardson@intel.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
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

Function iavf_init_proto_xtr() allocates vf->proto_xtr as part of the
device init sequence, but no shutdown function frees this memory again.
Add an appropriate free call to fix this memory leak.

Fixes: 12b435bf8f2f ("net/iavf: support flex desc metadata extraction")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1cd8c88384..7f5b103326 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2757,6 +2757,8 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 	vf->qos_cap = NULL;
 	free(vf->qtc_map);
 	vf->qtc_map = NULL;
+	rte_free(vf->proto_xtr);
+	vf->proto_xtr = NULL;
 
 	rte_free(vf->rss_lut);
 	vf->rss_lut = NULL;
-- 
2.53.0

