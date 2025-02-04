Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E907C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D19A3427C7;
	Tue,  4 Feb 2025 16:12:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 02924410FB
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681914; x=1770217914;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CbDC26FKhu6oAcKiQkD+++3zcQ9SvbQPmB4GHl7J6oY=;
 b=O1Mk0dlAP2oEXCO0AmGpx4cLXInAxe/R7jE6GTtGF91T2q3IlqCTxZfc
 /6cNIrtCpnJouS0syCSqRc9dZydHIRxmg8w52qN3GdOWQ0x8mj44wl5Y7
 8kVApqhZpM+srlbCj99CDp4yfjkaJb43iSbomXZWfahojZ7nM5ok9XlR1
 jTmlt+XwZ72eqysOIZxRI6XOZpWCsiriBxt7x/7Qe9nU3y7Hg6lUFu5O+
 DuFEEsk6cwqfKuRM7ZOeNxg4QIjeRC6K8ZkpINuZuZl7DXDmp156oSQmv
 /cvwnQxFCheCTcxUdwypxBRO2+h2JJ6sjb+byGGESv4UXpiJbv19AA23j g==;
X-CSE-ConnectionGUID: GgVgXHJoQVeBeIVsszm8/Q==
X-CSE-MsgGUID: hf/EthJtShGpKMXm12+ZVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097126"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097126"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:53 -0800
X-CSE-ConnectionGUID: etW567nsTFCdCO7ZArmSrQ==
X-CSE-MsgGUID: 8oJagsCaRA26sL4S3Pvekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792652"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 20/54] net/e1000/base: reset loop variable
Date: Tue,  4 Feb 2025 15:10:26 +0000
Message-ID: <aacc71d84a15eb18c3068df6b2145bd6777202c8.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

When writing to Shadow RAM, we set rev_val on success, but since the value
is already set to success initially, it is possible for none of the writes
to be successful, yet ret_val will still be set to success. Fix it by
resetting the ret_val to failure before every loop iteration.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index b8b57b6628..999fa03a3d 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -572,6 +572,7 @@ static s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
 	}
 
 	for (i = 0; i < words; i++) {
+		ret_val = -E1000_ERR_NVM;
 		eewr = ((offset + i) << E1000_NVM_RW_ADDR_SHIFT) |
 			(data[i] << E1000_NVM_RW_REG_DATA) |
 			E1000_NVM_RW_REG_START;
-- 
2.43.5

