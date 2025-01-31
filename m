Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9632C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8346542E6E;
	Fri, 31 Jan 2025 14:00:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8D88242DDF
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328396; x=1769864396;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fJun1x1+U/rnUBW1zxKpybMTISfu+CgQBzpZ+DoUnFw=;
 b=IdvtAibf6RNiJTlcBTPnqbZjyDpfgppn97wishohwoqzbSEi+NSpbNPA
 sxakZvlz3KvMjjsEOTDWi4JjTjf9AVKV4e22kecIRqLuzlsRZ0eJ61a0X
 t5ipsfKaGZDrFYI5pcLSLm7c3fvEKCN8p2k+dxiGOfN1WdCvFWEGMd+iz
 7QS3ZAaUhKosCYRrolXjIzoDVyUhwG3ljww1DQIrygTNajbN0263uJ8PA
 iNat1tQS3QnHP6XJxTTBpFgv2Q9g4Mzn1ct2gCmc46SXr9lMIHaldmw+x
 EwfqwJC0RZSYnPW3iZfoKUTR7rmtuOwPl3Fxvz7/aY/qA8sG5+ClOkeWR w==;
X-CSE-ConnectionGUID: aMMHpCkoSXmMtEUHzcnuzQ==
X-CSE-MsgGUID: Pb0APOMlQhuL+rzapC4hIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315654"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:55 -0800
X-CSE-ConnectionGUID: yPKEsq6kS4a9vawvF8v3ig==
X-CSE-MsgGUID: EOFa/fzlRVSN0ml/8OxxOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503415"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:54 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 29/42] net/e1000/base: improve NVM checksum handling
Date: Fri, 31 Jan 2025 12:58:42 +0000
Message-ID: <a11374f0b724a2cb0e7757a839a667161abf6271.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

When reading NVM checksum, we may encounter the following scenarios:

- Checksum may be invalid, and can be updated
- Checksum may be invalid but cannot be updated because NVM is read-only

For the latter case, we should just ignore invalid checksum and not attempt
to update it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 24 ++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index da36d4c098..77c403fa80 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4364,13 +4364,23 @@ STATIC s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 		return ret_val;
 
 	if (!(data & valid_csum_mask)) {
-		data |= valid_csum_mask;
-		ret_val = hw->nvm.ops.write(hw, word, 1, &data);
-		if (ret_val)
-			return ret_val;
-		ret_val = hw->nvm.ops.update(hw);
-		if (ret_val)
-			return ret_val;
+		DEBUGOUT("NVM checksum valid bit not set");
+
+		if (hw->mac.type < e1000_pch_tgp) {
+			data |= valid_csum_mask;
+			ret_val = hw->nvm.ops.write(hw, word, 1, &data);
+			if (ret_val)
+				return ret_val;
+			ret_val = hw->nvm.ops.update(hw);
+			if (ret_val)
+				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			/* Tiger Lake systems may have uninitialized NVM
+			 * checksum. Since the NVM cannot be updated by
+			 * software, do not validate the checksum.
+			 */
+			return E1000_SUCCESS;
+		}
 	}
 
 	return e1000_validate_nvm_checksum_generic(hw);
-- 
2.43.5

