Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F560C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 09:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62C7542E62;
	Tue, 10 Jun 2025 11:34:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5D2B242E5D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 11:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749548056; x=1781084056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LpfFXX4JGKYLnK8mzSnTHZjYY6UGuPKBUjkXkTxHG+U=;
 b=nlBXE2sSheTc1Du4cVOIxl5E2y7o4LMAeh/HIGFl5AiBPDlomKPcbTqO
 vnzUQmcA91VcN0tJQYXEvKguwqJNvR70uyioNLSIp9tAowZzCsPXreACY
 S3nkbtacjCOuUkKj0tvmgMA/QFrCvdaIHpGwpxmza28MnTwtq3QexAQLZ
 AZIWnepFmf4hExUNXNacHmXOjEzMUlBYIXc4+64FBeqYQhVDmdHXMMwLP
 w4JfkIcDstCxNhHAZ0Wxgtq5fotqO0uBY8L1zBGY4rNfiMZs7ZAkFgGnf
 PXivs/n66hJ8N1FSrvMucqs02QBTTtxANXz75TFazl5OMY6gmXs47CBp8 g==;
X-CSE-ConnectionGUID: JucsYT8HShCVa5JIL6fknw==
X-CSE-MsgGUID: SnkowFzpS8Cf2Q+ClMtClA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69213351"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="69213351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 02:34:10 -0700
X-CSE-ConnectionGUID: HUeTgUPiQDirNCZa8LEvKw==
X-CSE-MsgGUID: h8Q1UoUtTUKrtFkfjPqeIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; d="scan'208";a="147357180"
Received: from silpixa00401217.ir.intel.com ([10.55.128.45])
 by orviesa007.jf.intel.com with ESMTP; 10 Jun 2025 02:34:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] doc/linux_gsg: update recommended compiler versions
Date: Tue, 10 Jun 2025 10:33:43 +0100
Message-ID: <20250610093351.1321520-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408171835.2833766-1-bruce.richardson@intel.com>
References: <20250408171835.2833766-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rather than specifying a minimum compiler version, update the docs to
recommend a particular compiler version. In other words, earlier
versions may work, but are not officially supported, or may give reduced
functionality.

Since we don't require that many version-specific features, recommend
the compiler verions included in our oldest officially-supported distro.
Those versions (GCC 8 & Clang 7) provide all needed functionality.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/linux_gsg/sys_reqs.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 4c9d0c55c0..0acd26f260 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -28,7 +28,8 @@ Compilation of the DPDK
     For details on Linux distributions and the versions tested, please consult the DPDK Release Notes.
 
 *   General development tools including a C compiler supporting the C11 standard,
-    including standard atomics, for example: GCC (version 5.0+) or Clang (version 3.6+),
+    including standard atomics, for example:
+    GCC (version 8.0+ recommended) or Clang (version 7+ recommended),
     and ``pkg-config`` or ``pkgconf`` to be used when building end-user binaries against DPDK.
 
     * For RHEL/Fedora systems these can be installed using ``dnf groupinstall "Development Tools"``
-- 
2.48.1

