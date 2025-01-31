Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97573C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D336F42E50;
	Fri, 31 Jan 2025 13:59:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0FF2D42E1D
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328386; x=1769864386;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5aPAJYq9eyRYHWj69mHmAn2wnFIB4PKXgRKfwlXjYDs=;
 b=ndf9v5zr+wH4808kvntyQG2jeiw82HMyfent/rkQBioHTeQ1l460q9dR
 sjWwLjDTwe6YuQQwVCx4o5tINLlSfvRl04TCdcuvihXIAvZ5wS3ImG3Xw
 ahYM249sjmMHdw7ehUJutQMgSOMfE2ReOGHeQgvYoMCtRgEK1D8wRcTRk
 oey+RuG5uhXq7iQaZxXy5+Vm1nulvmyYI+wKlVlBbMXK0TflEYxgrAj99
 NAh3QGTenKzbwIoBWAz8FRJy3ehgzl1Tvz4RolQqyOR2jlkChqoqTVn/g
 cBV1rTAoGymSVaPytMWCX6thDwPJnDEu/kD4yj7JhnA4f8szwdTh30nzG w==;
X-CSE-ConnectionGUID: /vF0IchgS/SS393UhOmROA==
X-CSE-MsgGUID: dYSd0Ad7Rpa2lvkLAzWO1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315640"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315640"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:46 -0800
X-CSE-ConnectionGUID: BpU8u5q0T2CdSwghjzZEHA==
X-CSE-MsgGUID: dwNI7uWiT+25VIVmQhhxLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503401"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 20/42] net/e1000/base: add profile information field
Date: Fri, 31 Jan 2025 12:58:33 +0000
Message-ID: <5c4e6d0293487c392a28e03fc75d62538fa76312.1738328107.git.anatoly.burakov@intel.com>
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

Some tools require device profile information to be present, so add it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 3743b8849d..8c1f931038 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1047,6 +1047,7 @@ struct e1000_dev_spec_i225 {
 struct e1000_hw {
 	void *back;
 
+	u8 pf_id;               /* device profile info */
 	u8 *hw_addr;
 	u8 *flash_address;
 	unsigned long io_base;
-- 
2.43.5

