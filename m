Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B5C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8011402E3;
	Mon, 17 Aug 2026 08:49:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0B5F240608
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949388; x=1818485388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u8454T46Xw+8zDXAx3x6wl374hovtzhD4cO7WPy9l+o=;
 b=myg5wYycYlWSVNu1pIIxVgZ9bNNIm+1rroqpb5qD/4f3UnuDzirEwYOK
 6DAMxt4wKnr+VIu0cwtEgvy1WkjxggzH5El2apf9QiTUyMk4DBohhFKDo
 O7PG1F5BX0BQnYvxFEl1rmKUZhVpMwUhMF1dRgMtko3nxh/UVHDAE+kKN
 m5CAzUsT3CQunqBzomRFTmvyTO95fOiiwhoBteo9OR9oqf5835/ViH/a4
 amHcauF8XZQnVi6O7HB/VqQdJAIp4z5uOE1EFjePj6qLUr8HleqosQKoG
 YU29A5xEqHE2WyDjWBjP9LQwkTvKA+3fftflm9rXX9HGPh3sEm0TPAhV3 Q==;
X-CSE-ConnectionGUID: 7emYZSfmTKeNBtXoZrDVcQ==
X-CSE-MsgGUID: fL9bDPTJT+qUEqGnXIp0ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095595"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="91095595"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:49:48 -0700
X-CSE-ConnectionGUID: IW+ZHU1KRF2YLGUC0jiPfA==
X-CSE-MsgGUID: cHs2Z+gxRfmV4ozt6vqIRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="262195939"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2026 23:49:46 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3 1/7] net/iavf: discard empty AdminQ descriptors on reset
Date: Mon, 17 Aug 2026 06:48:40 +0000
Message-Id: <8c83baa243e010dcf171c12baf1b91f57fa7b148.1786948817.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786948817.git.anurag.mandal@intel.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
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

