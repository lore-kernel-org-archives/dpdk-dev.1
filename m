Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC4CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 08:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F24940272;
	Mon, 12 Oct 2026 10:35:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0CFA240041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 10:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791794114; x=1823330114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e3YXkn2grP7fd3MxlKdJajzCVek7BzSvHAyoNggEUJ8=;
 b=Y1ToG0NgBOYjCgYQrSQgsosTvAoyj65S4LYFwTrBeELsfADIEwoby3V3
 zing/6tKBc9+9CF5zZ+8NQQlYnrEEkO4FNmv5/9bCnrGrO205RByeEOJM
 6aLGkyYCwBxOaKEWcDUQFTu5ppWoKH+toWa3Kbs8ijp3V059aoBBbNmKX
 c7MhimAehOPE7H7gDKbl06SXDk1f1sKCUWEa3oPHYg5VKsl7A3l6bnLHF
 ReG7pUAloaRj83zB+YY02UKnwNVdIL0Ddh8L2VIXDqN2kZwJgEBjS92Jz
 AdMSN3v/o3xUvDU1j2G65J2p8/GidtWfaWH5pqiFqYDf+kplBOBT3et3v g==;
X-CSE-ConnectionGUID: JBpJpXKsTEyEZTie7pdmsA==
X-CSE-MsgGUID: ydnRMt4HRImtvakEZmeHQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="396025"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="396025"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:35:13 -0700
X-CSE-ConnectionGUID: pJQMwGN4Siu8eMvMnp2iJQ==
X-CSE-MsgGUID: M63l/kF/R5+Slh/vgSAZHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1164614"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa009.fm.intel.com with ESMTP; 12 Oct 2026 01:35:12 -0700
From: Emma Finn <emma.finn@intel.com>
To: 
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH v2 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Date: Mon, 12 Oct 2026 08:35:03 +0000
Message-ID: <20261012083506.754857-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005123041.429121-1-emma.finn@intel.com>
References: <20261005123041.429121-1-emma.finn@intel.com>
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

Add SHA3 and SHAKE hash algorithm support to the ipsec_mb PMD.

Emma Finn (2):
  crypto/ipsec_mb: Add SHA3 support.
  crypto/ipsec_mb: Add SHAKE support.

 doc/guides/cryptodevs/aesni_mb.rst          |  10 +
 doc/guides/cryptodevs/features/aesni_mb.ini |  10 +
 doc/guides/rel_notes/release_26_11.rst      |   6 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  38 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 260 +++++++++++++++++++-
 5 files changed, 318 insertions(+), 6 deletions(-)

-- 
2.43.0
