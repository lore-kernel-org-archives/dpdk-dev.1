Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16061E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:48:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4A0940E26;
	Mon,  9 Feb 2026 17:46:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5EFEA406B4
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655567; x=1802191567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kIgNIHXUj2DQkMtUBu+qCEPdCAq8ChD+G7qGcdN3ps0=;
 b=OaXgyEmD98rBpNBQhPV53vagXVgSCqD9SOFHItufC9gqk/KVw9LIDtGq
 QQaueC3hn7OZeqlLZmdWoxK09TQkFyovwnwaqzJ/iAzrdYyuNoxeZWXgd
 twJ7LJwbUhNGniBScjnpvkS5gDnBLR02ARFYolrozOfHZzcXeQZLWA/Xq
 U7k4iuoqsxL4slg6sZ92MGfm1C+M7Ca88KYwK8dFtyTgJ0J73BwVE6hlo
 V3hzA1NhA6jDgdSX1NFkxlzzyQQrQ7vH9VuIQEevNfP4uYrXXKmv13/sL
 OVLp5GNxOkObpmnGpFFktj5dZqNZdw35INu8/tEmV6BJdKQ91HVEEafHR A==;
X-CSE-ConnectionGUID: lr/REUrDSFyHwSaqEVXy2w==
X-CSE-MsgGUID: ru5GELrwTSu2mwreJa3MwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663473"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663473"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:07 -0800
X-CSE-ConnectionGUID: oAE+HM5cRCmDO10QuKjclg==
X-CSE-MsgGUID: es49gZ2ITQOuAsIMTB7TSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789172"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 22/35] net/intel: mark mid-burst ring cleanup as unlikely
Date: Mon,  9 Feb 2026 16:45:20 +0000
Message-ID: <20260209164538.1428499-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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
 drivers/net/intel/common/tx_scalar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 3e54cd7607..cee8f11c7f 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -266,7 +266,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		if (tx_last >= txq->nb_tx_desc)
 			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
 
-		if (nb_used > txq->nb_tx_free) {
+		if (unlikely(nb_used > txq->nb_tx_free)) {
 			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
-- 
2.51.0

