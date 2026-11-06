Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEEE606A33D
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jCmVZR5m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6E5F40671;
	Fri,  6 Nov 2026 17:14:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 2B83A402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 17:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793981686; x=1825517686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M/E/rXFdvtNnN1GC0mOFBjjcLLdFbNLgms4wx4vxtvA=;
 b=jCmVZR5m6nlAPPvr1VLE+H4lPE8QySLXcNjEAzztpWBWcqUEJdq/74b1
 NV++/blujyH8U838c1Q8MmtvjmhIIYixA0J3q7fyIxkJoukys5LbB/QVD
 NY7pSIQVbMELVwcZ2ZqfnG7qw7VDz9HZyc/f3sBVx9yDi25FPFYu8tWiW
 SVMrwsFBoUixo/W6Vy+LMSNsZ7HPyevLcfizqzN8ukLnDkQ73rzUYxKaV
 rlHw6zdoM7u9RMS9/fVv7q3x8ZZmdSfbgaDneKixYZ56WYFbt+lqej2pr
 uxkSZ/wKM01WOBpb7VdQ6WHZfxTxiPh9K0fDUUPidQoLHGuUQToVak5mY w==;
X-CSE-ConnectionGUID: jKkqjjgBQi6C3aVhHEv8Dg==
X-CSE-MsgGUID: 67w6D+smSyCYNaFZuvGgsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2674523"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2674523"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 08:14:44 -0800
X-CSE-ConnectionGUID: ciqpCg7nTkSZAH3klgNvLA==
X-CSE-MsgGUID: Jiwm50aHSM6mYxTxYIsEOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7663875"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa006.fm.intel.com with ESMTP; 06 Nov 2026 08:14:43 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [dpdk-dev v11 0/2] app: add cryptodev validation applications
Date: Fri,  6 Nov 2026 16:14:39 +0000
Message-Id: <20261106161441.3818963-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105163151.3744179-1-kai.ji@intel.com>
References: <20261105163151.3744179-1-kai.ji@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the FIPS validation example under app/ and add a new Wycheproof
validation application that checks a cryptodev PMD against the Google
Wycheproof JSON test vectors (AEAD, MAC, DSA, ECDH and ECDSA families).

v11:
- mark both applications as not supported on Windows in their meson
  files (they rely on POSIX directory handling); fixes the MinGW and
  MSVC CI build failures
- drop the standalone Makefiles: apps under app/ are built with meson
  only, and the examples-style Makefile needed the forbidden
  ALLOW_EXPERIMENTAL_API flag under app/
- remove forbidden allow_experimental_apis flag from app/ meson files
  (unused there: apps already build with ALLOW_EXPERIMENTAL_API)
- document the --mbuf-dataroom option in usage() and the guide
- print the correct program name in the usage message
- count unknown Wycheproof result strings as unsupported in the
  AES-GMAC processor, matching the other processors
- wipe the stack copy of the ECDH private key with
  rte_memzero_explicit() for consistency with rte_free_sensitive()

Acked-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Kai Ji (2):
  app: move FIPS validation under app/
  app: add Wycheproof validation app

 MAINTAINERS                                   |   11 +-
 .../fips_validation/fips_dev_self_test.c      |    0
 .../fips_validation/fips_dev_self_test.h      |    0
 .../fips_validation/fips_validation.c         |    0
 .../fips_validation/fips_validation.h         |    0
 .../fips_validation/fips_validation_aes.c     |    0
 .../fips_validation/fips_validation_ccm.c     |    0
 .../fips_validation/fips_validation_cmac.c    |    0
 .../fips_validation/fips_validation_ecdsa.c   |    0
 .../fips_validation/fips_validation_eddsa.c   |    0
 .../fips_validation/fips_validation_gcm.c     |    0
 .../fips_validation/fips_validation_hmac.c    |    0
 .../fips_validation/fips_validation_rsa.c     |    0
 .../fips_validation/fips_validation_sha.c     |    0
 .../fips_validation/fips_validation_tdes.c    |    0
 .../fips_validation/fips_validation_xts.c     |    0
 {examples => app}/fips_validation/main.c      |    0
 {examples => app}/fips_validation/meson.build |   12 +-
 app/meson.build                               |    2 +
 app/wycheproof_validation/main.c              | 2106 +++++++++++++++++
 app/wycheproof_validation/meson.build         |   20 +
 doc/guides/rel_notes/release_22_11.rst        |    2 +-
 doc/guides/rel_notes/release_26_11.rst        |    6 +
 ...s_validation.rst => crypto_validation.rst} |   84 +-
 doc/guides/sample_app_ug/index.rst            |    2 +-
 examples/fips_validation/Makefile             |   62 -
 examples/meson.build                          |    1 -
 27 files changed, 2222 insertions(+), 86 deletions(-)
 rename {examples => app}/fips_validation/fips_dev_self_test.c (100%)
 rename {examples => app}/fips_validation/fips_dev_self_test.h (100%)
 rename {examples => app}/fips_validation/fips_validation.c (100%)
 rename {examples => app}/fips_validation/fips_validation.h (100%)
 rename {examples => app}/fips_validation/fips_validation_aes.c (100%)
 rename {examples => app}/fips_validation/fips_validation_ccm.c (100%)
 rename {examples => app}/fips_validation/fips_validation_cmac.c (100%)
 rename {examples => app}/fips_validation/fips_validation_ecdsa.c (100%)
 rename {examples => app}/fips_validation/fips_validation_eddsa.c (100%)
 rename {examples => app}/fips_validation/fips_validation_gcm.c (100%)
 rename {examples => app}/fips_validation/fips_validation_hmac.c (100%)
 rename {examples => app}/fips_validation/fips_validation_rsa.c (100%)
 rename {examples => app}/fips_validation/fips_validation_sha.c (100%)
 rename {examples => app}/fips_validation/fips_validation_tdes.c (100%)
 rename {examples => app}/fips_validation/fips_validation_xts.c (100%)
 rename {examples => app}/fips_validation/main.c (100%)
 rename {examples => app}/fips_validation/meson.build (79%)
 create mode 100644 app/wycheproof_validation/main.c
 create mode 100644 app/wycheproof_validation/meson.build
 rename doc/guides/sample_app_ug/{fips_validation.rst => crypto_validation.rst} (70%)
 delete mode 100644 examples/fips_validation/Makefile

-- 
2.34.1

