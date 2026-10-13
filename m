Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB1ACC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 205DB4042C;
	Tue, 13 Oct 2026 11:33:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 61659400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791884000; x=1823420000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZaK4k3o5qXXZPSGQNm9Qhr7YybIxOEaCzPbXC+fdqBo=;
 b=msuobQxv2K6ohVZuXireADHUjHn7Qmj1UD2GvwAtC5VvRzrNIKXjqt48
 w/gwUA6gC08Uf76jzV6nSBHWUAgQoCRTofoo1KB0YQyqcZ0Ch3YlBvqS5
 eurn+OlCvBA5OKzWZ1gtN3sT5Y9irwvPAEsSAm5O9sdnrG5wKRKGlYcTf
 pWcuQ5Vzw+p+g1GTqEFUCJ9xxPfnMU3HPc4fD5JsNrmaOn8J2gWMAOl8B
 kNiWCKGGiyiq5rUTAIzesbKXzcvyOSiq7GGLiyYrL5X33R8tUo+suv4xm
 EKBI4bO1PNanW4L2NBUOAd3FSDB/B+cHZcG37EAU0IoE1bYMFaQjYkbjo Q==;
X-CSE-ConnectionGUID: cAN2lyCcR5G3m/FB5BviUg==
X-CSE-MsgGUID: h9udGbgHTlGeNaw87z/fXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="494861"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="494861"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:33:19 -0700
X-CSE-ConnectionGUID: jh1hwk8NRDS9swkZ69t8PQ==
X-CSE-MsgGUID: Jvdk9HhASXSMBmIv7pE3Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1477727"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa006.fm.intel.com with ESMTP; 13 Oct 2026 02:33:19 -0700
From: Emma Finn <emma.finn@intel.com>
To: 
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Date: Tue, 13 Oct 2026 09:33:10 +0000
Message-ID: <20261013093312.817235-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012083506.754857-2-emma.finn@intel.com>
References: <20261012083506.754857-2-emma.finn@intel.com>
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

Add SHA3 and SHAKE authentication support to the AESNI_MB PMD using
IPsecMB 3.0.

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
