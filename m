Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E28DCFC512
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 23:39:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 668FD40280;
	Sat, 22 Nov 2025 00:39:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC5840269
 for <dev@dpdk.org>; Sat, 22 Nov 2025 00:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763768396; x=1795304396;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=QfGzWkVmchGlZoskl8TTsZ5JEmZibgqBDsLEIzhoRXY=;
 b=GIFENL1L/sJP80RFQ2tuJA0lcMvxrHGNlQe/0BVZepEhrZorLAC0QwqO
 wzRqURw47ELdhdeqmFGMqTHm0VXt4l0B2bnsKasDAMweCypz8JZNgZHT9
 oHQ8TqXX4uaGBEo/pUUHbcdtL0sV9kCVTnI76fq1OUkdimdHCUdAev/Kb
 tR60ajKxXEJvIVjz1yEpQHqq1ophtdk0VDMW1B8zJdQin0KIZL/Zx4wj0
 C+P57cfNsdxFbVc9Mln/i8fbAkk8gENGzq28DtS196S5lacn9Jj6gzahz
 b3zsbA0sN1tx/AeEZRkQ4fNAWbMOptGdfafVBSgFYuu3jaN+7p3ML/AvZ Q==;
X-CSE-ConnectionGUID: U2V4QZm4T2SzdEeKYqJGtQ==
X-CSE-MsgGUID: r/5nIhI8QjWFdNLwyvBYGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="69734158"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; d="scan'208";a="69734158"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 15:39:55 -0800
X-CSE-ConnectionGUID: 3rgGNvkPQHe2FyHH7ZZXPg==
X-CSE-MsgGUID: VKdvVIKdS7a+RRNLQPK7PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; d="scan'208";a="192593052"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90])
 ([10.166.28.90])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 15:39:54 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 21 Nov 2025 15:39:37 -0800
Subject: [PATCH] net/iavf: check PTP capabilities during init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
X-B4-Tracking: v=1; b=H4sIADn4IGkC/x2NQQqAIBAAvxJ7bqGVIuor0UFzrS0y0Ygg+nvSc
 eYw80DiKJygLx6IfEmSw2egsoBp0X5mFJsZVKUaIkW4bmiD3VD05TDeeMrO6dR7ED+jkxu1sZO
 plauoayFnQuSs/8Uwvu8HMF6hr3IAAAA=
X-Change-ID: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197
To: dev@dpdk.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Kevin Traynor <ktraynor@redhat.com>, songx.jiale@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QfGzWkVmchGlZoskl8TTsZ5JEmZibgqBDsLEIzhoRXY=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkyFH15rMtsmLsz5WZzL2qMeeSPk0eP7Ylz9+YzBLHea5
 3EvTozuKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCIrgxgZvluvXrLwmkPxaqYl
 1w9NFFP6yXPH8HL5jGkzfP3Or+BSeMjwh/dWxIaf8gw3IxMDJGJmePtVKxn9rPg6/8qxu93xfeu
 quQE=
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

Commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
added a check against whether the PF has actually enabled Rx
timestamping in iavf_dev_info_get(). Unfortunately, this function may be
called prior to the PTP capabilities being exchanged, which results in
Rx timestamping not being supported.

Fix this by checking the PF PTP capabilities near the end of
iavf_dev_init(). This ensures the VF knows the capabilities at the point
where the iavf_dev_info_get() function can be called. Doing the check at
init is better than inside the info callback, as the info callback is
called many times.

The capability exchange in iavf_dev_start() is kept to ensure that
capabilities are updated after resets.

Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
My recent fix to prevent enabling Rx timestamping on PFs which do support
PTP capability but do not report Rx timestamping accidentally broke PFs
which *do* support Rx timestamping. This is because the driver did not
exchange capability before reporting its device info. Fix this by checking
PF capabilities during iavf_dev_init().
---
 drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 3ef766de4704..9b07b11a6b51 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2887,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
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
base-commit: ef98b88455bf4a7c8b7aa3106a761c9e9270d6a3
change-id: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

