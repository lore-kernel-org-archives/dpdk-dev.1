Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02022D3E77D
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 21:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D79414028F;
	Wed, 10 Dec 2025 22:46:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id BC25A40285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 22:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765403171; x=1796939171;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=NqrTUQyBBbYSdFkAhvQ39XXc2FuZynwwYrUy8ZsqHVE=;
 b=KkljTxcG9RSf1rxvxLVci9eptEE+0ZZ8pQw3eBAXjCSZ1DxSx+pR9ERf
 o9Jd1VOYB/4BbY3h0FL7GWiVsSxKQmR7GDjANxbpHrpOQQUupO2yMgwqR
 qnSeCPj8elDA6c97dfQWwBWCNNgB+qYcrMV4Ta8GlGd1RsI3ILHSTX3+X
 Kp09Oe4crjU7kzox7RUNu6vWMyDbrNI0adt2G0k1K4eTKF4TIEHdeZ+TM
 SXzCUxgIp5WOVXLxeB8k+o6wUqAK+kM6b/QmUOFMwObbvrJDDFNLrsXu+
 WhI/hmcCAbDy9VkMmjbDkUDTdBxxOGIh35uW6ny/pCNIaK1+9qOdBYDOK A==;
X-CSE-ConnectionGUID: ENGmwYI1TBm/fE08SkqqUQ==
X-CSE-MsgGUID: LWwxAjjVSB+wmAWgPojLXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67431801"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67431801"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 13:46:10 -0800
X-CSE-ConnectionGUID: xoegv7Q7SFGjJgSti4pOrw==
X-CSE-MsgGUID: KgbrmN6EQm+XBobcJmUKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="197114353"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90])
 ([10.166.28.90])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 13:46:09 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 10 Dec 2025 13:45:52 -0800
Subject: [PATCH] net/iavf: negotiate PTP with PF before reporting Rx
 timestamping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-jk-dpdk-iavf-rx-timestamping-fix-v1-1-ff5913717295@intel.com>
X-B4-Tracking: v=1; b=H4sIABDqOWkC/5WNQQ6CMBAAv0J6dg1bVIIn/2E4lHYLK1JI2zQYw
 t+t/MDjzGFmE4E8UxD3YhOeEgeeXQY8FUIPyvUEbDILWcorokR4jWAWMwKrZMGvEHmiENW0sOv
 B8gqqM7q7SFtiU4ucWTxlfSyebeaBQ5z95zgm/Nk/4gkBQaJuVFXV6mblg12k91nPk2j3ff8CT
 CuEVdAAAAA=
X-Change-ID: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Cc: Paul Greenwalt <paul.greenwalt@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Kevin Traynor <ktraynor@redhat.com>, songx.jiale@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=3576;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=NqrTUQyBBbYSdFkAhvQ39XXc2FuZynwwYrUy8ZsqHVE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzLV7KFDnLdjG+/1h54Xvl6r9/joD87Y+UuzVsTe/TsQ
 fOyf/nfO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZiI6mpGhkfyi7V2SERKl+/J
 81Tz8PkRXnnntPar5bc8s9afzZWTPsfw3/vmZbUVy7QO+oQ98PGf9I4/I7btZ+pvFaMuwZ4prC/
 /MgEA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The iavf driver has support for hardware Rx timestamps since commit h
b5cd735132f6 ("net/iavf: enable Rx timestamp on flex descriptor").

To enable this, the VF must first negotiate PTP capabilities with the PF
by sending the VIRTCHNL_OP_1588_PTP_GET_CAPS command, with the requested
capabilities. The PF will respond with the actually supported subset of
capabilities.

The PF may not actually enable Rx timestamping, even if it reports the
overall PTP capability support. If this happens, the iavf driver logic
will incorrectly report that Rx timestamps can be enabled despite being
rejected by the PF.

This should be unlikely in practice, as most PFs which support the
VIRTCHNL_VF_CAP_PTP will support Rx timestamping. However, there are
some cases where this may not be true. In particular, there is an
unfortunate issue with some versions of the ice PF using a different
structure layout that prevents the PF from enabling Rx timestamping.

To prevent this, the DPDK driver should check the capabilities and
confirm that the PF did enable Rx timestamping, instead of assuming it
will be enabled by all PFs that support the VIRTCHNL_CAP_PTP feature.
This prevents the DPDK application from attempting to enable Rx
timestamps when the PF will not support it.

Currently, the DPDK driver only negotiates PTP capabilities when the
device is started. First, check the capabilities during iavf_dev_init()
so that the iavf_dev_info_get() function has the required knowledge.
Then, only set RTE_ETH_RX_OFFLOAD_TIMESTAMP when the PF has informed
that it enabled support.

Continue to re-check the PTP capabilities in iavf_dev_start(), as it is
important to renegotiate after device reset.

Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
This is a new version of the fix to prevent enabling Rx timestamps on PFs
which do not enable it when negotiating capabilities. It combines the
original fix along with the additional requirement of negotiating the PTP
capabilities during iavf_dev_init().
---

---
 drivers/net/intel/iavf/iavf_ethdev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe24814..9b07b11a6b51 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1177,7 +1177,8 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_CRC)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_KEEP_CRC;
 
-	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP &&
+	    vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2 &&
@@ -2886,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 		}
 	}
 
+	/* Get PTP caps early to verify device capabilities */
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) {
+		if (iavf_get_ptp_cap(adapter)) {
+			PMD_INIT_LOG(ERR, "Failed to get ptp capability");
+			goto security_init_err;
+		}
+	}
+
 	iavf_default_rss_disable(adapter);
 
 	iavf_dev_stats_reset(eth_dev);

---
base-commit: cd60dcd503b91956f966a1f6d595b35d256ac00f
change-id: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

