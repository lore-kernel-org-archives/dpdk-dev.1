Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B8C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 23:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A321F4064A;
	Thu,  2 Jul 2026 01:09:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2850440279;
 Thu,  2 Jul 2026 01:09:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782947345; x=1814483345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YQa5UVG/I6ldVDA7fUnD3FQ10Z3rIVUoC+/kreTObog=;
 b=eLBR8SudDSrzCRpzoB2o8cqiDPuPtxMoBI/KlyeXGiw725kJ541q1Zau
 rYxfG4eqHKqaM1Wpih86MDJHA2peAfbQzuCcODTbMYLNdw9f6sdqCB8ws
 FkiOmLQfPGXcXdKk2Rnak2AX3cbwFU2YGsM3X6dLIC2FVKyN4do07sGbu
 DNe1rnFveNOjbRxq1U7w82yYLv84gxakCCOKtBEdDmBa95nZVD7sl1ZX6
 jnrFWU0vbhkFLyqJOL8vjNVEDAH3aNMC3JCO2Cu1o9zBbu99+CQGh+UDd
 ct5EQRsg/fhKpe71QkZKqBgkiIsiiq2v7o9LNtG+9UQz6Sycn5gw0v58F A==;
X-CSE-ConnectionGUID: 5rquPfkMR1i8pkhPGCZboQ==
X-CSE-MsgGUID: 5/Q45ARTRNiVxxIfu1S9HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82807558"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="82807558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 16:09:03 -0700
X-CSE-ConnectionGUID: vFmEmFz3QxaAeMt8B5OWNw==
X-CSE-MsgGUID: 9mocDnj3RzqpS4btQhlM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="250972243"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa006.jf.intel.com with ESMTP; 01 Jul 2026 16:09:01 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix QinQ handling when only inner VLAN capability
 is supported
Date: Wed,  1 Jul 2026 23:08:58 +0000
Message-Id: <20260701230858.436510-1-anurag.mandal@intel.com>
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

While adding support for QinQ stripping and insertion
operations, it was assumed that Single VLAN
operations are always reported through outer VLAN
capabilities by the hardware.
However, it seems that Single VLAN operations can
also be reported through only inner VLAN capabilities
as well by the hardware.

This patches fixes the same for QinQ operations.

Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 0643a835d5..0c5b0f8ff1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -904,13 +904,14 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	stripping_caps = &vf->vlan_v2_caps.offloads.stripping_support;
 
 	/* When VLAN extend is disabled, Single VLAN mode which is Outer VLAN
-	 * When VLAN extend is enabled, QinQ mode, this API works only on
-	 * Inner VLAN strip which is always 0x8100.
+	 * When VLAN extend is enabled i.e. DVM mode or when hardware reports
+	 * Single VLAN capability through inner stripping_caps, this API
+	 * works only on Inner VLAN strip which is always 0x8100.
 	 */
 	if (!qinq && (stripping_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 	    (stripping_caps->outer & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_strip.outer_ethertype_setting;
-	else if (qinq && (stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+	else if ((stripping_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 		 (stripping_caps->inner & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_strip.inner_ethertype_setting;
 	else
@@ -1003,7 +1004,7 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 	if (!qinq && (insertion_caps->outer & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 	    (insertion_caps->outer & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_insert.outer_ethertype_setting;
-	else if (qinq && (insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
+	else if ((insertion_caps->inner & VIRTCHNL_VLAN_ETHERTYPE_8100) &&
 		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
 		ethertype = &vlan_insert.inner_ethertype_setting;
 	else
-- 
2.34.1

