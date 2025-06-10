Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE81C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 16:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 993BD42F06;
	Tue, 10 Jun 2025 18:31:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A9BE042EAD
 for <dev@dpdk.org>; Tue, 10 Jun 2025 18:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749573082; x=1781109082;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wkE3eT7n6nYEk5ZESolxU4a0s9Yz09Xp+tGLIUB33fw=;
 b=li6Z1RfTMLQmrcMgngns4WEjFtuj0kzG0oLs7M5CjyuyYfMweuVMDVeJ
 XMBKp6ZRo407+W7VG5NHbhs1dLrqpi2WKZj5g/ZH4SL7tNGFkhCZleKDK
 pfaeExAAy9rLfmAtHyUXcK2sYu9s5usaxrw6yB8dl+i/jCp/gyHhR4v5K
 IRgqBX6kWH6flL/sR1VI2TWcpod2tdr0Ijkcshp4qDfStr3nfPKXXD+dA
 VgQLohVlI8u7OCj5dGQaq4EvsUOo0ceO5uZfNrTnDwZmemqzUDhUZkBR6
 hJTmEMkB93jaJSLI1egRw0jI3a9e1t0P4PTo2DRcE2TCYl/Kj/Yg/4qwN Q==;
X-CSE-ConnectionGUID: RGaSuQXXSdmzbXs5+8Hdgw==
X-CSE-MsgGUID: 7LX60vPuSCWzfPbMgamRRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63101381"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="63101381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 09:31:20 -0700
X-CSE-ConnectionGUID: zAzEtvWgSym08qhjrNQ6tQ==
X-CSE-MsgGUID: aTyPFmekTEGq8YjcROZvFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="146868441"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.33])
 by orviesa009.jf.intel.com with ESMTP; 10 Jun 2025 09:31:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/3] argparse additions and rework
Date: Tue, 10 Jun 2025 17:29:35 +0100
Message-ID: <20250610163109.111651-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527092113.903910-1-bruce.richardson@intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
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

This patchset is based off the work to adjust how we do argument parsing
inside EAL. To enable argparse to be effectively used for EAL, we have
new features and some changes in the first two patches, which are
relatively small - though are ABI/API affecting.

These add support for saving off strings and boolean values, have argparse
stop parsing at a "--", and finally have argparse return the number of
arguments actually parsed on success.

The third patch is a bigger change. It was inspired by the fact that
when adding the boolean and string support we had to update some
"MAX" value defines used in the code. This is obviously not good from
an ABI/API perspective, once the library becomes part of the stable ABI.
In order to remove these MAX values, patch 3 looks to replace the
#define values with enums - which means some rework splitting the
various flags into separate categories, and similarly splitting the
single "flags" field with separate fields specifying if an argument
value is required, what type that value should have, and then a
final smaller field for any additional modifiers.

v3: additional doc updates to patch 3

v2: minor changes to patch 2 (see log at end of that patch)


Bruce Richardson (3):
  argparse: add support for string and boolean args
  argparse: make argparse EAL-args compatible
  argparse: use enums to remove max-value defines in lists

 app/test/test_argparse.c               | 229 ++++++++++++++-----------
 doc/guides/prog_guide/argparse_lib.rst |  36 ++--
 doc/guides/rel_notes/release_25_07.rst |  50 ++++++
 examples/dma/dmafwd.c                  |  20 +--
 examples/flow_filtering/main.c         |   4 +-
 lib/argparse/rte_argparse.c            | 184 ++++++++++++--------
 lib/argparse/rte_argparse.h            |  97 ++++++-----
 7 files changed, 379 insertions(+), 241 deletions(-)

--
2.48.1

