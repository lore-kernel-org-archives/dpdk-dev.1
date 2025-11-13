Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A197CCD98E4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 21:34:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0EF240DF8;
	Thu, 13 Nov 2025 22:34:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8560F40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 22:34:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763069659; x=1794605659;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=gy74MqBfSM7ZormIdCE8jlS8kRrlkzyF7lU0pZMrkRQ=;
 b=UwIjZu60bSABSo7Fp798Qn5psHUNKY541TovVQhMmNqiokW6n8cpWxF5
 1XuyOQEkBAqd8+cgliafrQIPg38v/uIlCiuwmf9QSV5KbB+7sWNUItOIR
 FtAVJ4qSwC4Z1udPq3kCz27bU8N4AsEHk+kLTLm33ondA1TQ3s5fkLKqe
 CBtOdbJid/eQYrNRDN3hA8UeVngHUM4tYUeDKzZmnaiZdPsurKNYlBtme
 YC+ckihN2jOLJEBfWQROjKQi23FYOInF5hSPwjcj9XSZATiTJhoXRkM7C
 QKNpz5JfqH+C92Za7TXCF1oCkavvTIeQPhjUpP7aNX+6weRAUDJ6J8dww w==;
X-CSE-ConnectionGUID: 8to0y9gIQwqbopZiruqLvQ==
X-CSE-MsgGUID: FksXwOJgRdWGivX/WtwvLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69027491"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="69027491"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 13:34:17 -0800
X-CSE-ConnectionGUID: rqXuYQh1SSWyLEq5j+ZUEg==
X-CSE-MsgGUID: K1rPIHkLRbWfbdCGAtzBkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; d="scan'208";a="194051460"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90])
 ([10.166.28.90])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 13:34:17 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 13 Nov 2025 13:33:44 -0800
Subject: [PATCH 1/2] net/iavf: check if PF actually indicates Rx timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-1-3d9a0168087b@intel.com>
References: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
In-Reply-To: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
To: dev@dpdk.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=gy74MqBfSM7ZormIdCE8jlS8kRrlkzyF7lU0pZMrkRQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkwxvxtM1Yxa/y/IRHrz/5W88WDHpttV0i1v5l3+9yN3y
 Ue1I3YpHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkrgHDX5HKK6/eJvUoffzV
 0F8wPa3IXWPVZpG8HfoF/PvOiusoczIybDtjn5b5PqRBbdb1ouefbZMLf7AvbfhsnH/scdK/K3f
 vMAIA
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

This is unlikely in practice, as most PFs which support the
VIRTCHNL_VF_CAP_PTP will support Rx timestamping. However, there are
some cases where this may not be true.

Check that the PF actually reports the Rx timestamping capability
instead of assuming it is enabled. Doing so prevents the DPDK
application from attempting to enable Rx timestamps when they won't
actually be enabled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe24814..3ef766de4704 100644
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

-- 
2.51.0.rc1.197.g6d975e95c9d7

