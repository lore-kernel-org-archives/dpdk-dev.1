Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6DCC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:51:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9908D4027C;
	Wed, 23 Sep 2026 15:51:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id 3EFB940262
 for <dev@dpdk.org>; Wed, 23 Sep 2026 15:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790171517; x=1821707517;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=g9/HSWE6abotFpXNfjJurwHlzStvMyc0xFxoTcc0e2s=;
 b=Vr0LIwVYCcCYbo3VI5Isr0oedVB+8vNNB/30pxJsgGhe1jfA20l/jnCo
 ymT1qs+2G60jcgNZtllvKq19Kg6ZrvR1coNid6iUdIMmYbHbgIuB5Sc1f
 kjdIhRgYE7YDbJI3snlz6okdm2G5S2HYIgN0xuoQpffmawLc1EsqbW8Rh
 WaxuARgJlFb86eDlHF6YVEDNRRuJCRbwaS1cYp0m+rjvTmXwfDgo6z6Qh
 7nyI8IP5rmvKkJ+RlE1AtM/RuhZxE/ANIGoUj5dzi4g952l33gulaTABx
 vI/4k40OeihIDYpv14YOdNevO2Z2JhTqRGjBSX8xXMzcQFmIE51lJpehz w==;
X-CSE-ConnectionGUID: PLn1qIt0Qdyl7kwgeLu61w==
X-CSE-MsgGUID: P2cuRD27Rr2gXZfGY76JqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1375382"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1375382"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:51:55 -0700
X-CSE-ConnectionGUID: lFVMPjK1TN+0u/8fki1NmA==
X-CSE-MsgGUID: KiTQCV+lSPONzmll6uTCGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="270130082"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 23 Sep 2026 06:51:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] net/i40e: use common AXV vector code
Date: Wed, 23 Sep 2026 14:51:44 +0100
Message-ID: <20260923135146.3527913-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

With the AVX2 and AVX-512 code paths from iavf and ice consolidated
into common folder, we can reuse that code from i40e and reduce our
code footprint a bit.

Bruce Richardson (2):
  net/i40e: use common AVX2 Tx function
  net/i40e: use common AVX-512 Tx function

 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   | 121 +-----------------
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 113 +---------------
 2 files changed, 6 insertions(+), 228 deletions(-)

--
2.53.0

