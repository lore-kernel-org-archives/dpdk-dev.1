Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143DD1F9BD
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 11:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5AE94021F;
	Thu,  4 Dec 2025 12:29:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E140340144;
 Thu,  4 Dec 2025 12:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764847751; x=1796383751;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZfZZrY1nYBExLZfeaepeMH1h3+TKoerlHk/KBRvlZUA=;
 b=EFmMKjfSU+CemqOwzcEtqL3E37puy0G8srMZivLJbI2OcFoA/jjcWUsY
 3kLNuLBbCHsgE0FMMvGr9O+i+oTD8u+pxI3jq1Ml3BhkK0aRAOMI59VhW
 fKSBWBp/CuRK8VHitKEMLieOSkKCDViAKGq+xruabCYb3P/NV13E3lL2N
 9IWf24bJ8hbiGU6wlVruaHbCf+Njyv+NDc6k+phqfvLt3Sd1yhN6L6NEc
 rAFGwRJ3waw1ngLlnkNqTDFE0M5pCWvA/6cnq57cwlEWFcivBExXKMOQS
 cimn+Z9V8Uo0Zh/0G+rU0kMJSACXtwI2b/uME06eL3JReNcc9xc1P1+X9 w==;
X-CSE-ConnectionGUID: DA7D1K6CSFOVpeeutJfPGQ==
X-CSE-MsgGUID: V4rxdHlzSFCg3HAyu5POLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="78330215"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208";a="78330215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 03:29:08 -0800
X-CSE-ConnectionGUID: Hd+5hVrXQzaWPr/yr7lKbQ==
X-CSE-MsgGUID: cNBWcluSTqqdxhiuYFB0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208";a="195370576"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2025 03:29:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] Fix errors with updated MSVC in github actions
Date: Thu,  4 Dec 2025 11:29:01 +0000
Message-ID: <20251204112904.2869502-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The version of MSVC in our github CI has been updated so new warnings
are appearing about "zero extending 'unsigned long' to 'uint64_t' of
greater size." These two patches ensure that the build in github is
clean again.

Bruce Richardson (2):
  rcu: fix warning on Windows builds
  net/ice: disable warning in base code for Windows builds

 drivers/net/intel/ice/base/meson.build | 1 +
 lib/rcu/rte_rcu_qsbr.h                 | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--
2.51.0

