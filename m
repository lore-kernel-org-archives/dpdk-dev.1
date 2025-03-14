Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB068C35FF1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5CA8400D6;
	Fri, 14 Mar 2025 18:44:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C7EB9400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741974285; x=1773510285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K/5+jyYZiXA+R/7suP3vih1Jappp8zjYunchX0gzx40=;
 b=cj2MQgpSqhzIeP9Rl57TF9WVfi8BFm+yXokbb+YKQFm13nJJiTy3rMAR
 AKq3RbeoR+78A0bPYq6e9JuwH4EqJrLt9GZQUmMNxLCgRwYkhFaGHNv+E
 okibjNRy6pba763Fefsy8mjPBEsD7KCxaNtu1/qWD1sCmBdwFiSMSQZfk
 DYvGkQPrToh8yOx37eQsj+PLbJYwnFDnifHTNrF5JzHqPQXF6c7oOPclW
 v0mCqFTVYf1CWKo06rXRFjgW1d9oruEONRwkhBvYLLvDeSr2HY1MkO/hB
 Iyk8TAqd8QDHqXxj7rxj+0hzJMjBVlyfx37tJ1mQj3tovnE9Gnrh09Y5c Q==;
X-CSE-ConnectionGUID: XRCwBOevSO2dgpt2leIx6Q==
X-CSE-MsgGUID: DTNwtNTES82ECxlTP7VAEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="46925680"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="46925680"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:44:44 -0700
X-CSE-ConnectionGUID: j2xnNUNpScGjFH6zm6i3aA==
X-CSE-MsgGUID: 8VrUB0LTSkK1tUsTXB5Nvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="125528682"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa003.fm.intel.com with ESMTP; 14 Mar 2025 10:44:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/4] remove driver-specific logic for AVX builds
Date: Fri, 14 Mar 2025 17:44:34 +0000
Message-ID: <20250314174439.112658-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314172339.12777-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
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

A number of drivers had special optimized AVX2 and AVX512 code paths
for performance reasons, and these tended to have copy-pasted logic
to build those files. Centralise that logic in the main
drivers/meson.build file to avoid duplication.

v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag

Bruce Richardson (4):
  build: add generalized AVX handling for drivers
  net/intel: use common AVX build code
  drivers/net: build use common AVX handling
  drivers/net: remove AVX2 build-time define

 drivers/meson.build                   | 30 +++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_ethdev.c        |  2 --
 drivers/net/bnxt/meson.build          | 10 +--------
 drivers/net/enic/meson.build          | 10 +--------
 drivers/net/intel/i40e/meson.build    | 26 ++---------------------
 drivers/net/intel/iavf/meson.build    | 25 ++--------------------
 drivers/net/intel/ice/meson.build     | 25 ++--------------------
 drivers/net/intel/idpf/meson.build    | 25 ++--------------------
 drivers/net/nfp/meson.build           | 10 +--------
 drivers/net/octeon_ep/meson.build     | 13 +-----------
 drivers/net/octeon_ep/otx_ep_ethdev.c |  4 ----
 drivers/net/virtio/meson.build        |  9 +-------
 12 files changed, 43 insertions(+), 146 deletions(-)

--
2.43.0

