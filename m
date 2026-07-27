Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33146C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 17:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17DF9400EF;
	Mon, 27 Jul 2026 19:30:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D88DE400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 19:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785173422; x=1816709422;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=D5W6etVIX9kWYNVLAOefcllmhEmuOYVtmkXz9YHMhLk=;
 b=cHetcVycY97eGRk6A2BaLcVxAovBAjhPbv8k76WFj9DtLzzwVjiBxCD7
 c00rrPqhD8IDOssRI55bphIEoJCmaZeFV5pqOdEmluzfsUIChlI31GQBC
 5Ewv1s5lnXXAKtEPO0gXQ2QGXsmG6vj+YTMfZnKHy+7VYWKKBYCzJP12l
 yeuM3oTNjkB/vikXB2bj/xr83DP9Nc9VaYeccc5SewtaFfGl+PFFSgPWq
 QXIoaG+xSTKRtI6htdPpeHWjLf9LaVGiO8JHEEtjnSAT8nWCZc5Mz7LsX
 4UGY7pzoY1K7WvEp8ynqQzwjltIdsLUk/x6nGKHfLT4KfUFlcNBEcb4W2 g==;
X-CSE-ConnectionGUID: vXh1XuFSRJyfR5j7ZFgVig==
X-CSE-MsgGUID: a5mLdKnbT4+hgufb1R3Aow==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85510697"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="85510697"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 10:30:20 -0700
X-CSE-ConnectionGUID: 6Fd6VK6xT2+QBIWxCMivKg==
X-CSE-MsgGUID: ndZuy/jESMStcSLHtCaUWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="263248426"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa004.jf.intel.com with ESMTP; 27 Jul 2026 10:30:19 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, jingjing.wu@intel.com,
 praveen.shetty@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/idpf: add clock read support
Date: Mon, 27 Jul 2026 17:29:46 +0000
Message-Id: <20260727172946.824267-1-anurag.mandal@intel.com>
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

Implemented read_clock ethdev operation by adding
idpf_dev_read_clock() feature to get current time
in nanoseconds for scheduling packets based on
transmit time.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/idpf/idpf_ethdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index c13505416a..224a649f53 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1124,6 +1124,15 @@ idpf_timesync_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+idpf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+
+	return idpf_ptp_read_src_clk_reg(adapter, clock);
+}
+
 
 static const struct eth_dev_ops idpf_eth_dev_ops = {
 	.dev_configure			= idpf_dev_configure,
@@ -1159,6 +1168,7 @@ static const struct eth_dev_ops idpf_eth_dev_ops = {
 	.timesync_read_time           = idpf_timesync_read_time,
 	.timesync_write_time          = idpf_timesync_write_time,
 	.timesync_disable             = idpf_timesync_disable,
+	.read_clock                   = idpf_dev_read_clock,
 };
 
 static int
-- 
2.34.1

