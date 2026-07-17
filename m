Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA777C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E6E240A7F;
	Fri, 17 Jul 2026 11:16:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4E556402F0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784279765; x=1815815765;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=L+TIlGnHDfqw/VfExKckofRFJzXK9pDt2KFSOaRrLLk=;
 b=F+E5mPBQAbCp6HhROv0IO8serAaZGZ2EHSUTVTt5pG9KJTcBDKQwZuVZ
 a1lB+Iad0P/0IhGjDlVZrXd5muEM4CR59NOtTJbUaP36xRfMgVeALtqyX
 yIvzarRSuZfxVM/LrVzR7GnC5i2zJKAedYR+jYcXnr0N04RcmFJXTg7Fo
 hp/Olu/X98baOuaUU9Cd1ZvLf7PyVos8cARzi5QhHUY60RusUJrL4NcT2
 /dvMyNSk8aq4SK1T4dYSNoV4QyDdS2jcN+jyGTO97L0MQ9Y53AH1VEu5/
 CII2lYKCRHFGHJ2h/CCoxCR4nMDibwZy5n3PqU7DDsP/E61elJtaBBBg/ A==;
X-CSE-ConnectionGUID: cc/g9tGXRpyMz/7MdXwkmA==
X-CSE-MsgGUID: 2YbJbrZ2QHmHX+uKqNgsFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95550048"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="95550048"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:16:04 -0700
X-CSE-ConnectionGUID: oNicbGEUS/mNCjc5TAs1HA==
X-CSE-MsgGUID: HjkiGoWvSYOB6ZnoU44lKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260315193"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:16:02 -0700
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 1/3] updated i40e latest recommended matching list
Date: Fri, 17 Jul 2026 17:12:31 +0800
Message-Id: <20260717091233.12102-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
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
 doc/guides/nics/i40e.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index e67498aef4..b0e8cf1f55 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -102,6 +102,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 ============  =====================  ================  ===============
 DPDK version  Kernel driver version  X710* FW version  X722 FW version
 ============  =====================  ================  ===============
+   26.07             2.30.18               9.57             6.51
    26.03             2.28.16               9.56             6.51
    25.11             2.28.13               9.55             6.51
    24.11             2.26.8                9.52             6.50
-- 
2.34.1

