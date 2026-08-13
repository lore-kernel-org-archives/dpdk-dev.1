Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801CC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:46:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48508427B8;
	Thu, 13 Aug 2026 12:46:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 16DC5427A9
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786617998; x=1818153998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u8454T46Xw+8zDXAx3x6wl374hovtzhD4cO7WPy9l+o=;
 b=WMs0UFGoXelCQHNadVzNWY2gQB+r/ZeAEyXlD4d7zAqe6179LMVFvejV
 zyH2Uj5I26ztsyCaDqX2VDwwWI/lIwq/h6QdifDWyqOjn6T0kDNa17dK+
 O1fysbOdBDmIPJiXvIl0mZxSMxar6wHn4OqPbKgQLYdV4QqRA/gQC1uP6
 1Z8RoxJh1zg100u1l4D5F89Z5gKO2S+l+s76OcujJA4QFXFGJTtYjTirT
 LREVKXF1BXBCMlJ3Gg/1aQy7gNFaWUhnz4PUwV7bLJMWOYzcntnU4R473
 Civ2c8EcsS4k+6W2uocPeuJmBjIVLdslx9GGrfLmpn4DgZVkEHpIuDZ1M Q==;
X-CSE-ConnectionGUID: ktAhHOg2SSOWuJWyfmXtlg==
X-CSE-MsgGUID: niYTLsMHQcixzdiKlu+keQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89708980"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89708980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:37 -0700
X-CSE-ConnectionGUID: mtqB0k4FR5mEMJpzQg74Gw==
X-CSE-MsgGUID: DgOj9CIfR6aSFN/uglsuxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264491547"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 03:46:35 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 1/7] net/iavf: discard empty AdminQ descriptors on reset
Date: Thu, 13 Aug 2026 10:45:29 +0000
Message-Id: <1758e9329549e06f64942ebd102aee9e23c6f4a3.1786617159.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786617159.git.anurag.mandal@intel.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
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

