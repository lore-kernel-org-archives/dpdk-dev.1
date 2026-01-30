Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3939E6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E648C40DD6;
	Fri, 30 Jan 2026 12:42:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A5CAA40A6F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773367; x=1801309367;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9bLDaE1hHjN6XlcCplowGvIdj2YOIAd2WjeCCH9hqUA=;
 b=nLoZnPejxPNzi0SKGTuJvKNNCO264ZX2jDFVXtmy5HgdLoiXtWwiomjn
 ysj4yFCPJZ/WwSOf/gynDojBF+9akyAFCFkZmyWyG/dRvQqDaC/2bU4HR
 +yPYWylBjgtETgmK08v5xGaa3q1ObjNABXdlIc3Sce9oRdsUJVfLuzM7/
 mlWKNbhwMvnV3vhW6peMeBrajO6pnnfHPWvHSIWHVfflvoG06kLuji8LN
 koBAPqrBp23UpXRIKiqKwRJaquXm4aQ9JgaLkqSQWxuCqmS3C1BAZCR3D
 E26CElVaNbcRmT8Ljzi0Kx3zZp8L5b1gwMztGmZTg4ehluz/Ua079cIa5 A==;
X-CSE-ConnectionGUID: qYT6bHQUTX2STFeVGQXrDQ==
X-CSE-MsgGUID: /7NlNuTiS5a+3FFD0K8z7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392320"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392320"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:46 -0800
X-CSE-ConnectionGUID: qiOSjE/ASayRApYr7acLEw==
X-CSE-MsgGUID: 3ZBJO9HsQiyYBpk1ee9B5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190540"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:45 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 23/36] net/intel: mark mid-burst ring cleanup as unlikely
Date: Fri, 30 Jan 2026 11:41:50 +0000
Message-ID: <20260130114207.1126032-24-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

It should rarely be the case that we need to cleanup the descriptor ring
mid-burst, so mark as unlikely to help performance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 90dc6ae423..488130c813 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -271,7 +271,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		if (tx_last >= txq->nb_tx_desc)
 			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
 
-		if (nb_used > txq->nb_tx_free) {
+		if (unlikely(nb_used > txq->nb_tx_free)) {
 			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
-- 
2.51.0

