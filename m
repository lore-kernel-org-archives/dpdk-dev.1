Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6249CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 21:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB5B40264;
	Fri, 29 May 2026 23:04:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4254B40262
 for <dev@dpdk.org>; Fri, 29 May 2026 23:04:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF253501;
 Fri, 29 May 2026 14:04:06 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53EBF3F632;
 Fri, 29 May 2026 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780088651; bh=vqpYIzUI/VFOiNQXquJL4/YkcKb+IJPCfaJU+UzAZ4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KUL2egOQi5ePKMjRv8l75UAhp7d1hVGyDjPtbzL0z1c2002JvOViDkYCKi5F/YlEp
 k5TptdlcZlRWYMr2yKdnI6bU2Z+1LagNiBwc0UMqyOU8TnM7vS+VjhIkGqq9Yexprv
 6cr608mTdI9fDiyhfL1IMM4pKOgkW326uwE5IawU=
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Cc: dev@dpdk.org, nd@arm.com, paul.elliott@arm.com, dhruv.tripathi@arm.com,
 shebu.vargheseKuriakose@arm.com,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 2/2] doc: update Arm IPsec-MB references for cryptodev PMDs
Date: Fri, 29 May 2026 21:04:03 +0000
Message-ID: <20260529210404.1986896-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
References: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
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

Document Arm/ARM64 IPsec-MB source and supported tag level for
aesni_mb, aesni_gcm, snow3g, and zuc cryptodev guides.

- Add Arm library reference to aesni_mb and aesni_gcm docs.
- Update snow3g and zuc IPsec-MB library tag to SECLIB-IPSEC-2026.05.30.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 doc/guides/cryptodevs/aesni_gcm.rst | 4 ++++
 doc/guides/cryptodevs/aesni_mb.rst  | 4 ++++
 doc/guides/cryptodevs/snow3g.rst    | 2 +-
 doc/guides/cryptodevs/zuc.rst       | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index 0b1f2262fb..5b31ee19eb 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -43,6 +43,10 @@ and compile it on their user system before building DPDK.
 The latest version of the library supported by this PMD is v1.5, which
 can be downloaded in `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
 
+For Arm system, ARM64 port of the multi-buffer library can be downloaded from
+https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/. The
+latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2026.05.30.
+
 .. code-block:: console
 
     make
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 7ce92305d1..8a7920ab46 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -108,6 +108,10 @@ and compile it on their user system before building DPDK.
 The latest version of the library supported by this PMD is v1.5, which
 can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
 
+For Arm system, ARM64 port of the multi-buffer library can be downloaded from
+https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/. The
+latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2026.05.30.
+
 .. code-block:: console
 
     make
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index 0fe914ffd3..0fc42c2302 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -54,7 +54,7 @@ can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zi
 
 For Arm system, ARM64 port of the multi-buffer library can be downloaded from
 `<https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/>`_. The
-latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2024.07.08.
+latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2026.05.30.
 
 After downloading the library, the user needs to unpack and compile it
 on their system before building DPDK:
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 7c6b83e7eb..02614a8b36 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -53,7 +53,7 @@ can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zi
 
 For Arm system, ARM64 port of the multi-buffer library can be downloaded from
 `<https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/>`_. The
-latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2024.07.08.
+latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2026.05.30.
 
 After downloading the library, the user needs to unpack and compile it
 on their system before building DPDK:
-- 
2.43.0

