Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF3EA4E3D
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 16:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80AA84025F;
	Mon,  2 Mar 2026 17:47:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F07C6400D7;
 Mon,  2 Mar 2026 17:47:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772470068; x=1804006068;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=muUyZFYtUwjTZkQc+CKTX1WcoHIvI2d+1bvD9E9UFK8=;
 b=fZkxOJfXviYhzqqLoLgt57zPZMBt/LCcT+QS/Fb6SnXojTl8lMK474uZ
 WNfHWdCc8BGq/a6EPnEDcUMnACaCodLL08ad7pLyKK5K10p1WyDN1jEFS
 piTwzW5uep3wP3C8cD6NFUFJmhi80JkRThw9He+TXHBaaOB730N3AZwJW
 7HNEtyRbdyqLR/lF2HzBchzJ2i1akSRKgItuR5e2rwb7g4j4ps6WIZKrL
 RCNWP3ZzqAJsH3dAJDiFuV980Dges36trx02rr24FPzkmGHbSlIHNjGF1
 OUHrMdvuHf0RE2WNzF/VFmXJbn2ql+hMwHadoRkBz3OjcwFu/4kPPSh6J A==;
X-CSE-ConnectionGUID: SoMpKqwOQQG+UA2nOIX45g==
X-CSE-MsgGUID: oy1vFimnQsiN77les10f8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="76087235"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; d="scan'208";a="76087235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 08:47:46 -0800
X-CSE-ConnectionGUID: Yc5Q+4J6R9i0SIU6RA8L6A==
X-CSE-MsgGUID: AEAuiUaBQjCnq21Gdlxg4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; d="scan'208";a="215682738"
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by fmviesa007.fm.intel.com with ESMTP; 02 Mar 2026 08:47:45 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com,
	stable@dpdk.org,
	Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v1] doc: update Multi-buffer library version to 2.0.1
Date: Mon,  2 Mar 2026 16:47:42 +0000
Message-ID: <20260302164742.2230427-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
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

Update the maximum supported Intel Multi-buffer library version
from 1.5 to 2.0.1 for DPDK 24.11+ in the cryptodev guides.

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 doc/guides/cryptodevs/aesni_gcm.rst         | 2 +-
 doc/guides/cryptodevs/aesni_mb.rst          | 2 +-
 doc/guides/cryptodevs/chacha20_poly1305.rst | 2 +-
 doc/guides/cryptodevs/snow3g.rst            | 2 +-
 doc/guides/cryptodevs/zuc.rst               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index 16bdaf3cb4..8d833c92aa 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -75,7 +75,7 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.11 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4  - 2.0.1
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index d58ce20ff4..b9ecb38524 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -139,7 +139,7 @@ and the Multi-Buffer library version supported by them:
    ==============  ============================
    20.11 - 21.08   0.53 - 1.3
    21.11 - 24.07   1.0  - 1.5
-   24.11+          1.4  - 1.5
+   24.11+          1.4  - 2.0.1
    ==============  ============================
 
 Initialization
diff --git a/doc/guides/cryptodevs/chacha20_poly1305.rst b/doc/guides/cryptodevs/chacha20_poly1305.rst
index b5a980b247..7802b6551f 100644
--- a/doc/guides/cryptodevs/chacha20_poly1305.rst
+++ b/doc/guides/cryptodevs/chacha20_poly1305.rst
@@ -67,7 +67,7 @@ and the external crypto libraries supported by them:
    DPDK version   Crypto library version
    =============  ================================
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4  - 2.0.1
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index bde30de1b5..f0334e964a 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -90,7 +90,7 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.02 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4  - 2.0.1
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 1bede0498b..5f498fdf41 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -89,7 +89,7 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.02 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4  - 2.0.1
    =============  ================================
 
 Initialization
-- 
2.43.0

