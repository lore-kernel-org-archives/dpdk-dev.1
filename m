Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA4C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:16:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 732EC40DD0;
	Fri, 17 Jul 2026 11:16:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5A56C40DCF
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784279768; x=1815815768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7aYsMV5UZgRxiz8xJw6Tovzl9nvOR7tpDG1pavOxHN0=;
 b=CughsP5nxJJMBhMyf8EpqWxKIkWGp5ebrmxvtY/qF9F6ElKePggg5Ive
 WeAGTtdohkBchI2NtvILZTrG/TMSVQ6HUMXBHYocb/mMAXr1yg2jOHJpK
 3M1sDtf4s1fzWj0xrrEMjgHEbgPrFop+PSy3UE4IXlmw3J1KpK1cHRMmG
 rID1mk22PNf8QMJ3r9x/p8rNIFku7T1BAlIumqNKE7GaMmVRuz2sF3F8Z
 /6FFCLbhegJNsVW6nplRsCiUGK0oZYjXztPsqfxsXb7vtIkotb+9OxG9Q
 uqUViVBCdioptvp5xm8L6vvw62DmEsERUtRqkPshFc4+eopKrxd/wb0w1 w==;
X-CSE-ConnectionGUID: 23EjJbi3SCSS8wqHLjkmFQ==
X-CSE-MsgGUID: leRSJHSqRIWGfVvTkOZVUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95550050"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="95550050"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:16:08 -0700
X-CSE-ConnectionGUID: mtCPb9fXQLi5AObX5pNfbg==
X-CSE-MsgGUID: Q9p2ErNDQHS7EI9Xh1I/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260315214"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:16:06 -0700
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 3/3] updated ixgbe latest recommended matching list
Date: Fri, 17 Jul 2026 17:12:33 +0800
Message-Id: <20260717091233.12102-3-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717091233.12102-1-hailinx.xu@intel.com>
References: <20260717091233.12102-1-hailinx.xu@intel.com>
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

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/ixgbe.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 90fdf0a39f..67d6c05372 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -68,6 +68,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 ============  =====================  ===============  ===============
 DPDK version  Kernel driver version  E610 FW version  X550 FW version
 ============  =====================  ===============  ===============
+   26.07              6.4.4               1.60             3.70
    26.03              6.3.4               1.41             3.70
    25.11              6.2.5               1.30
 ============  =====================  ===============  ===============
-- 
2.34.1

