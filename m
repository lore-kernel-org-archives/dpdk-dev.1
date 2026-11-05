Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9F60726D5
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H2OVzBul
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C15640E09;
	Thu,  5 Nov 2026 17:32:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 045274026C
 for <dev@dpdk.org>; Thu,  5 Nov 2026 17:32:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793896323; x=1825432323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P4Siyw+HQwuJwFWZmrY51HTQnHBoHZsKq58Ijf412Ws=;
 b=H2OVzBulLItyUiQ47oI/9Um7Yoks+rB1qRnV1cfu3uV7zzdFETfTe8RA
 WLiyekHe1ZuLP/E8jFsArJ0pZsH6LZdgShzdUOwDaa9FEpv4QtWbO2NB5
 g9MaZkWiYQTpc3MqKuZaTR4S/NWoBKLMEKC4hUR9fRpoiG1/VpNCXK15e
 T2unebczcnyc85tXxDwXJA+ytMr9HTYAzViASkwsqEIwsO9uE86ryZ5I0
 LMHry9dcH11MF3t0CtXZYFbjhubZdQsSL2FO2AD3+TLmOGd2mCVqFqGt0
 7YWdN/69m2aQGnXxwVybxSms8BdL4ELFSwYA9RIIUNdCN19j+MOuknmHB Q==;
X-CSE-ConnectionGUID: SbF0MP9wTTa9VZBf6LDWYQ==
X-CSE-MsgGUID: rG4eME6RRkazUAA7AbKH7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2784134"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2784134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 08:31:59 -0800
X-CSE-ConnectionGUID: bM51PI3cTvq8iQ+t1qh4Dg==
X-CSE-MsgGUID: D2w9tusUTm6NJiJhiVw9yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6952907"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa004.jf.intel.com with ESMTP; 05 Nov 2026 08:31:59 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [dpdk-dev v10 0/2] app: add cryptodev validation applications
Date: Thu,  5 Nov 2026 16:31:49 +0000
Message-Id: <20261105163151.3744179-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013154400.3273585-1-kai.ji@intel.com>
References: <20261013154400.3273585-1-kai.ji@intel.com>
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

Acked-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>

Kai Ji (2):
  app: move FIPS validation under app/
  app: add Wycheproof validation app

 MAINTAINERS                                   |   11 +-
 {examples => app}/fips_validation/Makefile    |    0
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
 {examples => app}/fips_validation/meson.build |    2 +-
 app/meson.build                               |    2 +
 app/wycheproof_validation/Makefile            |   40 +
 app/wycheproof_validation/main.c              | 2097 +++++++++++++++++
 app/wycheproof_validation/meson.build         |   18 +
 doc/guides/rel_notes/release_22_11.rst        |    2 +-
 doc/guides/rel_notes/release_26_11.rst        |    6 +
 ...s_validation.rst => crypto_validation.rst} |   85 +-
 doc/guides/sample_app_ug/index.rst            |    2 +-
 examples/meson.build                          |    1 -
 28 files changed, 2246 insertions(+), 20 deletions(-)
 rename {examples => app}/fips_validation/Makefile (100%)
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
 rename {examples => app}/fips_validation/meson.build (92%)
 create mode 100644 app/wycheproof_validation/Makefile
 create mode 100644 app/wycheproof_validation/main.c
 create mode 100644 app/wycheproof_validation/meson.build
 rename doc/guides/sample_app_ug/{fips_validation.rst => crypto_validation.rst} (70%)

-- 
2.34.1
