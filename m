Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E5EF48F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD46A40657;
	Fri, 13 Feb 2026 10:10:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F366440649
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973826; x=1802509826;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ec1Bgb/2EiJ/l7MlNRzTr3VJ3K6thDBWhqB34WGKN44=;
 b=IoUiwR7xRavDC9sP9mXT2FngYOGKL6Wl3DvsSRAMPBUpVA72P4MDUPMv
 rwP6ytv6TOUOc68dJNZ6VzYthRU7Ta2DvK/irZ9/DcbMnzg/td4D5TINY
 SgXIp6T/1T7cCFhZu4rPpMJwwC2OdLAKTQ5gEt+sI8Eh8dVf7RQfIUbnZ
 Cw7a6eZJfO515re1zHw4a7pGl9FQo+e/VsJ7UI7/kRsCjW3NdbD4awjeH
 g9oIQBTZHOsu5PvaHqyWqn/vBbiTMJUaWdqnnHzEHHXh/IKAYuhTfxFJw
 chtT2qt0B/MscMUusDxuFmeba7J2k9hrqY/AH/W0sBDGrG3jTcDCjFVlK g==;
X-CSE-ConnectionGUID: wLcETfjITMem1QbWIFpH8w==
X-CSE-MsgGUID: yNaBHZpUQXqw+eVk4EY38w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567859"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567859"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:26 -0800
X-CSE-ConnectionGUID: Gr63kaSfS5KSVlnhA5jRmA==
X-CSE-MsgGUID: JNpTlFbzTQGoZnyhcZPyMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966056"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v6 03/12] net/ixgbe: fix potential null dereference in IPsec
Date: Fri, 13 Feb 2026 09:10:05 +0000
Message-ID: <ba2d7d5320cd4a7709caefcd829b8356ba712053.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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

When parsing IPsec flows, we access the `conf` pointer unconditionally,
even though it might be NULL. Fix by adding the check.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 90072e757e..81b983ce69 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -221,6 +221,13 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	act = next_no_void_action(actions, NULL);
 	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
 		const void *conf = act->conf;
+
+		if (conf == NULL) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				act, "NULL security conf.");
+			return -rte_errno;
+		}
 		/* check if the next not void item is END */
 		act = next_no_void_action(actions, act);
 		if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-- 
2.47.3

