Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F05D2E01F
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 07:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 940B440156;
	Fri,  5 Dec 2025 08:48:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C56CF40144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 08:48:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764920907; x=1796456907;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=h4LO7Np10iyaSZC7ltlZE+ZQCDv2XB05f0ogFA7+UcQ=;
 b=GlPwrPARZMhWKruvgen4U1NyTRF4ceBiFOKTohGfG+rTHCUitIoVPpi9
 gy9QVebU5hLPEzNi7x2MTYhiR5WuLpjx4ay20ZcapBaxC7bjgRyVNm2Et
 4lW0a+AwprtpPuIMbY02i1l9q2bnWJ7TmD65yhMy6DVvXT+07kBeiDkMt
 x9RW6zpLf6Tt12AmnWuKTk3XtbPiA6+l8fyFtwTXfbM33aPU8gcU+GUYV
 CnrSL3vdtdBBlKpWgCfOnRGsbEjf2g7WzjzagDpXVmScmnaIVZt4hHNUz
 rLoHk3Us/taqkAKQ6iocgtJKVCybxARLU55d9wVVEzhgqrIEd8L51sZtI w==;
X-CSE-ConnectionGUID: S6XtfoYfTWG1+2L/H3HGuA==
X-CSE-MsgGUID: JMlgPGBwTnaHkiEMWqbAxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="77569580"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="77569580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 23:48:26 -0800
X-CSE-ConnectionGUID: T1pTJDugSX6y6BLJ4igMPA==
X-CSE-MsgGUID: a8VPcubwT++yEa0iC0rrxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="195663921"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 23:48:24 -0800
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 manjunathgouda.hosamani@intel.com, sadashiva.rao.pv@intel.com,
 hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1] doc/ice: Modify E830 recommended matching list
Date: Fri,  5 Dec 2025 07:06:01 +0000
Message-Id: <20251205070601.1155113-1-hailinx.xu@intel.com>
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

The firmware intel release version for E830 is 1.11, so modify the recommended version for E830.

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index cde31a5694..216c79b6f2 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -97,7 +97,7 @@ For E830,
    +===========+===============+=================+===========+==============+===========+
    |    25.07  |     2.2.8     |      1.3.43     |  1.3.55   |    1.3.23    |    1.0    |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
-   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.2    |
+   |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.11   |
    +-----------+---------------+-----------------+-----------+--------------+-----------+
 
 Dynamic Device Personalization (DDP) package loading
-- 
2.34.1

