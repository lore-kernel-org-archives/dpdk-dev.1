Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E32FC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EFD8402AE;
	Fri, 27 Jun 2025 17:28:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 08886400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751038090; x=1782574090;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zNwxzdp8FCi7vff3ZVVoolv3aa6pSN96DKJqA9n88rg=;
 b=YcBOqlDCvkRXa/Zf4cJC40ZmMwLcIoacHXqprxrYpm3y1j6ld9o/8r32
 +Z+bPguC1HF1KNQkcxm5AcXRhNGLjyM4+8qN8t/Axca5R/h3NJu2eN5mI
 boZ02a0nkSzIt2sxzX9WQM0C3NSt4UdwV1M9P/Yj2IxgmUJ0b4V305a8p
 uAmWzAPiz9l3UfExcbcYc15457MOOyEuQUhLUo/rSekR2IQPaZ9Gy2nok
 FijlvCCQeGhJzf6pNf3RZBTtpJpNxcB0mnAiZUbzWjagJkPii/Olwd/M+
 jXU9C8dRFwKYe0w7ZoRpO41uNSl378K583CwW1JHGERq4ZqGuzirlshaD A==;
X-CSE-ConnectionGUID: SHartJ65TNKnTMJfgKEroA==
X-CSE-MsgGUID: 7TqLS9MPRtq42saPSf1VNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="70924425"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="70924425"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 08:28:09 -0700
X-CSE-ConnectionGUID: Y/eKNODVQY2IoT5hjvEcbw==
X-CSE-MsgGUID: 6qaKL+bDRUWJjppihRq8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="153318108"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa008.jf.intel.com with ESMTP; 27 Jun 2025 08:28:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] build: error out when missing elftools python module
Date: Fri, 27 Jun 2025 15:27:59 +0000
Message-ID: <20250627152759.145084-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

In the case where we use the meson python "find_installation()" function
to get our python binary, we can fail the configure/setup step if the
elftools module is missing. This avoids later errors on build when the
module is missed.

Old output (error logged and config continues):

  Program python3 (elftools) found: NO

New output:
  Program python3 found: YES (/usr/bin/python3)
  Program python3 (elftools) found: NO

  ../buildtools/meson.build:15:31: ERROR: python3 is missing modules: elftools

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 buildtools/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/buildtools/meson.build b/buildtools/meson.build
index 7b5e449cdb..12abbdff9c 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -9,8 +9,11 @@ python3_required_modules = []
 if host_machine.system() != 'windows'
     python3_required_modules = ['elftools']
 endif
-python3 = import('python').find_installation('python3', required: false, modules: python3_required_modules)
+python3 = import('python').find_installation('python3', required: false)
 if python3.found()
+    # If python3 is found, check that we have pyelftools installed.
+    python3 = import('python').find_installation('python3', required: true,
+            modules: python3_required_modules)
     py3 = [python3]
 else
     py3 = ['meson', 'runpython']
-- 
2.48.1

