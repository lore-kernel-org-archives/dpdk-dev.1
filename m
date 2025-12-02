Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C03CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 10:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E6BC40268;
	Tue,  2 Dec 2025 11:45:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id A118A400D5;
 Tue,  2 Dec 2025 11:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764672357; x=1796208357;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pjUQ8KtYs2HzLbUWAmewqi9pwKwszwwr7RCQw5xH1pc=;
 b=EkFNrZEOx9IPaWlwr3H6SAUGfrLGqMwqjP6k5nibKAa8hVr9+iu4owGi
 J5L/YqOLp+A3HSC0VA+yMSYsqRl+sD+j3zlgVqv8bcP8eag5IYJqc0faO
 891KFtPRw9mg5959xuunS4UgFSyUWsUrRJ9tOpIj+ORaaLam1LTsUYUfl
 n0dI4X8v+a3RAcqOZdd0ckBd+7KzTxDoEQv7wPwI0oUU+xyfb7LK9GqIC
 9IhbyJO+IPgiEgD+IWEQVvFsdV5vGKjTZLbwWY/f/hAhxZ2+N3/5hzE3q
 8Ugqc4yZHYwq+ooxlp+z1xTBid0HGSn8JIymZmxyioTew2VpF8yokEsj2 g==;
X-CSE-ConnectionGUID: YyspZ2aER5uZii3NhJr49w==
X-CSE-MsgGUID: ZdPLfLJGTbG4gKsQ8QGlGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66347072"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="66347072"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 02:45:56 -0800
X-CSE-ConnectionGUID: nEmYPfZxTPyhyOFtA5yX9g==
X-CSE-MsgGUID: xwSkAnxDSaenEtvHI6PMeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="194435574"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa008.jf.intel.com with ESMTP; 02 Dec 2025 02:45:54 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH 1/2] pdcp: add digest physical address
Date: Tue,  2 Dec 2025 10:45:50 +0000
Message-ID: <20251202104550.849311-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
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

Set the physical address for digest buffer.

Fixes: a785af14ff79 ("pdcp: add pre and post process for UL")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 lib/pdcp/pdcp_process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/pdcp/pdcp_process.c b/lib/pdcp/pdcp_process.c
index 9b9b881124..f55ae3bec0 100644
--- a/lib/pdcp/pdcp_process.c
+++ b/lib/pdcp/pdcp_process.c
@@ -351,6 +351,8 @@ cop_prepare(const struct entity_priv *en_priv, struct rte_mbuf *mb, struct rte_c
 		op->auth.data.length = (pkt_len - RTE_PDCP_MAC_I_LEN) << auth_shift;
 		op->auth.digest.data = rte_pktmbuf_mtod_offset(mb, uint8_t *,
 							       (pkt_len - RTE_PDCP_MAC_I_LEN));
+		op->auth.digest.phys_addr = rte_pktmbuf_iova_offset(mb,
+							       (pkt_len - RTE_PDCP_MAC_I_LEN));
 	}
 
 	__rte_crypto_sym_op_attach_sym_session(op, en_priv->crypto_sess);
-- 
2.50.1

