Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C0C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50CD440E5A;
	Wed, 16 Sep 2026 15:24:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1351440E12
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789565051; x=1821101051;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4mfz8YlaUFPXMGyYjqfq5Ib3KrNYQRizivsPZdeUEQs=;
 b=WT/el4I8TfMXLW9FwShX5+Jnd6OeIjAQVzeioH56v8lvqs9M4y/dABsZ
 8hDd3IbKe0lMlThAn7XXHWa0kKyycc48xR12Dnq8ZB5FyJdHJkVkFZQQz
 QpoEM+9du/d9XsD9A0XA/Gbx4qEmJqr7GgdnD7hrbHl5i9AZnuEpTVXp+
 wYxgXszZlda7lRCjVcjYylTPb3XAK7vomz9a5Kg9W1PYZdAX0ndinzhH9
 k1JdceqE+UAsqGxmcpZ61ouQzfMhhMgKLEIPT3s5y46AviiJhJWVY5/Gm
 KQ3XKemBQOkZOE5h4fofWp2cNn5KrZAKa65JknZEd9cvNVQW+BhfPlmAg g==;
X-CSE-ConnectionGUID: pJT0rPzWSn2pKOgFvyq2lQ==
X-CSE-MsgGUID: vd/cpVy/T3GrLKgiPm5Tgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77503102"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="77503102"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:24:10 -0700
X-CSE-ConnectionGUID: gvWD4SHGQJKIlHxAeaC1Vw==
X-CSE-MsgGUID: EgOfjPRXQHKfxaHSLmVvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277469709"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 16 Sep 2026 06:24:09 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] build: bump meson version to remove warnings
Date: Wed, 16 Sep 2026 14:24:03 +0100
Message-ID: <20260916132403.1040252-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251205121301.3443561-1-bruce.richardson@intel.com>
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
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

The build of DPDK now uses features from version 0.6 of meson, which is
greater than the current minimum of 0.57.2. Although these features are
non-critical, they do cause warnings to be emitted on build. Increase
minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
these warnings.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
v2: update some references to meson version in the docs
---
 doc/guides/linux_gsg/sys_reqs.rst         | 2 +-
 doc/guides/prog_guide/build-sdk-meson.rst | 2 +-
 meson.build                               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 0e6a2e2e78..2a55301893 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -38,7 +38,7 @@ Compilation of the DPDK
 
 *   Python 3.6 or later.
 
-*   Meson (version 0.57+) and ninja
+*   Meson (version 0.61+) and ninja
 
     * ``meson`` & ``ninja-build`` packages in most Linux distributions
     * If the packaged version is below the minimum version, the latest versions
diff --git a/doc/guides/prog_guide/build-sdk-meson.rst b/doc/guides/prog_guide/build-sdk-meson.rst
index 93a3271482..b236a933a5 100644
--- a/doc/guides/prog_guide/build-sdk-meson.rst
+++ b/doc/guides/prog_guide/build-sdk-meson.rst
@@ -35,7 +35,7 @@ The ``meson`` tool is used to configure a DPDK build. On most Linux
 distributions this can be installed using the local package management system,
 e.g. ``dnf install meson`` or ``apt-get install meson``. If meson is not
 available as a suitable package, it can also be installed using the Python
-3 ``pip`` tool, e.g. ``pip3 install meson``. Version 0.57 or later of meson is
+3 ``pip`` tool, e.g. ``pip3 install meson``. Version 0.61 or later of meson is
 required - if the version packaged is too old, the latest version is
 generally available from "pip".
 
diff --git a/meson.build b/meson.build
index b01010ffa0..6b8cfa8b2e 100644
--- a/meson.build
+++ b/meson.build
@@ -10,7 +10,7 @@ project('DPDK', 'c',
             'default_library=static',
             'warning_level=2',
         ],
-        meson_version: '>= 0.57.2'
+        meson_version: '>= 0.61'
         # meson_version_windows: '>= 1.5.2'
 )
 
-- 
2.53.0

