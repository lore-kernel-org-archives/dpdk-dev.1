Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A43C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0598D4064A;
	Tue, 18 Aug 2026 06:58:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B8A8140613
 for <dev@dpdk.org>; Tue, 18 Aug 2026 06:58:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787029115; x=1818565115;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K22L/wJbRbyfxd7YUZqcNZ8sxjfF/R/B6hZLwQ82F6s=;
 b=SAPBVV9Lnm6yvjCJ4ON3ZMX3aQyJy1ULMB8jxZSSOrmPql1ybMeRPids
 EPw4bSyJJqG2eIl4rfYHTihUl6/KQbYwGU84YS+ToG3InrHeQY7Qmwv6m
 BpU4eYq4MywMry/XAgdiar0h7XZQoKxENKrU5c9y8ZMzI3WGr0j0dSdrx
 ib0MMtBIToxtELQDznD0yaw45cfUpd4HJ8CgDuVkH0LUMq6StumeXolhy
 ZZltuXBYC+hl0743mcGvrxJAb9odDhlmp1Drh2YeYb4lPJIIwFE6x38VY
 Be7EQh0swZDRxjtfOyRQmC4XlVrv3xuu6lMp+vLK5lJPljvhK/1rmD9il A==;
X-CSE-ConnectionGUID: lH/IrUV9TT2p2vNzsSQC0g==
X-CSE-MsgGUID: 1FKNPU3kQj+Q3DJkWFrvHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87632995"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87632995"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 21:58:34 -0700
X-CSE-ConnectionGUID: DjkqKGUcTdqaI/O53uZalQ==
X-CSE-MsgGUID: DBrzm0InScieBlTeZqniow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268611244"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 17 Aug 2026 21:58:32 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v4 1/7] net/iavf: discard empty AdminQ descriptors on reset
Date: Tue, 18 Aug 2026 04:57:26 +0000
Message-Id: <31d66a7bd32d987e4a7af7c83b8991e1ee545c7a.1787028683.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
References: <cover.1787028683.git.anurag.mandal@intel.com>
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

During PF-initiated resets iavf_clean_arq_element() has been observed
to return success with a fully zeroed descriptor (opcode 0).
These fell through to the default arm of the dispatch switch and
produced a "Request 0 is not supported yet" log flood in the field.

Skip descriptors with opcode 0 so they are silently discarded and do not
flood log.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f346837bf1..23e4107743 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -614,6 +614,11 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 			break;
 		}
 		aq_opc = rte_le_to_cpu_16(info.desc.opcode);
+
+		/* opcode 0 means the descriptor is empty/zeroed, skip it */
+		if (aq_opc == 0)
+			continue;
+
 		/* For the message sent from pf to vf, opcode is stored in
 		 * cookie_high of struct iavf_aq_desc, while return error code
 		 * are stored in cookie_low, Which is done by PF driver.
-- 
2.34.1

