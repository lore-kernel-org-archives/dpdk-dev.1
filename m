Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910DAC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E788F406B6;
	Thu,  7 Aug 2025 14:40:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 91CA840689
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570405; x=1786106405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sVo96Us2wvER4Q9AxAp0WTDMzySMq1F4ZPcFZTQsR/0=;
 b=ehNA/P6Mig98z0X0CqJ+7B9Fgfv64Cgs+vvhbKe3KFN3CEV0oV/LIqIU
 YwfiNBPc9Uqsxx7QT5QWV8XfdmYpLLd3GCg6e+I07yDpc8m8UAss7gTdx
 a/B1GPWLdf+PXKRadH7QqI5a+WbxEbnim4MpEsyY1mKIwzYy04BcjBT8E
 Nfl6KYpFrNQsrd4qv/uR5s8viP55Z+x3ydQLYoSfIiGVLOiZ5DQoqEHve
 U4ZdErvEBpzxHFcwVwPluVRy3Rc0SXI4sbogOGZyKXa05gaLN9r6lb0ej
 13DSUfTlQ0b72o91RMVqeVsW+xuZT/Z3bmJomEDrC/CTqlVVTYwovVhzA A==;
X-CSE-ConnectionGUID: /IznVVBUStG4h9B7KnKvvQ==
X-CSE-MsgGUID: VU2MDokfRQKVwic7OQ0DYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981129"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:05 -0700
X-CSE-ConnectionGUID: KjJzSeOCSLaJNWIcUdMtfA==
X-CSE-MsgGUID: 4kJfwlpuRXCX2a07tOADLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886759"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:04 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 10/15] net/ice: remove unsupported Rx offload
Date: Thu,  7 Aug 2025 12:39:44 +0000
Message-Id: <20250807123949.4063416-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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

The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
driver so remove the one erronous use of it.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 9430a99ba5..5529e06a8d 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -71,7 +71,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 
 #define ICE_RX_VECTOR_OFFLOAD (				\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
-		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_RX_OFFLOAD_VLAN |			\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
-- 
2.34.1

