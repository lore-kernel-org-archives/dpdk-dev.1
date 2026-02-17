Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1EE6817C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68A7440616;
	Tue, 17 Feb 2026 13:48:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5C8400EF;
 Tue, 17 Feb 2026 13:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771332537; x=1802868537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5B1uAGuPLNfPfg9FsjTad0Q+ayoKBMeRJopMyExdRSc=;
 b=j0aYpFHc+YU/qiCh1C9xudVImSdUcmkoa7C46LtResJspfyQ9OYIGnRG
 oiWMDtdSd7Qt2yp89MGAfALOryDoSblCVBYpVxCtDe6ZSJi2FqCebKHYf
 DHFQ1t44G2IrnvqSUeIP+2GW+bkx2hZQz9cRNAe1hIPRK2ERfl3fshaaW
 lkPUg4IaA8hmnGy6SI7G6C5agB3dHaKtTjzAvUmR5iz+tMXGlEz4iz1Zf
 0DnqMAqn1uP9HcjREjW9Oe4URVNP/Lg9LrQfqttuHvMVFj0gZFkszawLQ
 HUvpFFQkv58wE5rhfm+vweR2XvbHOkrlbv8zM+iEjlVhEGO5zwsAtA5QB g==;
X-CSE-ConnectionGUID: ZR3Q/ZVIT16xzpgbZvunXA==
X-CSE-MsgGUID: WBp/f5VlTrmdugJrXKbLiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="76238761"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="76238761"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:48:56 -0800
X-CSE-ConnectionGUID: gpW23SpaRyOJfn+iG0qeUg==
X-CSE-MsgGUID: XTegdADVRIyoAXPfrUqHVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="212775069"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2026 04:48:53 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thierry.herbelot@6wind.com, rjarry@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH] usertools/pmdinfo: fix search for PMD info string
Date: Tue, 17 Feb 2026 12:48:44 +0000
Message-ID: <20260217124844.1458644-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
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

The PMD_INFO_STRING constant string is not guaranteed to appear in the
output binary immediately after an unprintable character. Because of
this, in some cases the information for a driver could be missed by the
PMD info script as it only checks for the prefix at the start of strings
that it finds. Change the script to use "s.find()" rather than
"s.startswith()" to fix this issue.

Fixes: 0ce3cf4afd04 ("usertools/pmdinfo: rewrite simpler script")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-pmdinfo.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/usertools/dpdk-pmdinfo.py b/usertools/dpdk-pmdinfo.py
index 9251c69db9..a4913f2209 100755
--- a/usertools/dpdk-pmdinfo.py
+++ b/usertools/dpdk-pmdinfo.py
@@ -221,8 +221,9 @@ def find_strings(buf: bytes, prefix: str) -> Iterator[str]:
             if b == 0:
                 # end of string
                 s = view[start:i].tobytes().decode("ascii")
-                if s.startswith(prefix):
-                    yield s[len(prefix) :]
+                idx = s.find(prefix)
+                if idx >= 0:
+                    yield s[idx + len(prefix) :]
             # There can be byte sequences where a non-printable byte
             # follows a printable one. Ignore that.
             start = None
-- 
2.51.0

