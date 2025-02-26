Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA74EC021B2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 01:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A981F40608;
	Wed, 26 Feb 2025 02:07:08 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 10A29402AC
 for <dev@dpdk.org>; Wed, 26 Feb 2025 02:07:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1F2B820460A8; Tue, 25 Feb 2025 17:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F2B820460A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740532024;
 bh=wJ47Y4+Emyjm2DTjv2NVseW9dXzDJQkUU5gKEOdzP3I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jnAObWIVgc9nYi2YvDKaAioasH2r0D880hHBJ/SKm1bzAa/r6L0vNFpFxKhv/izbn
 I9+aPjpCA7b2b5iheun0faio9g2MK5DALW5DEBlvx720t0czdc8actcyne6+OxkIOb
 ldXfwywey4RmRtq3JEGVWXigTclAp2EgPKIaef+g=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 0/5] allow faster instruction sets to be used with MSVC
Date: Tue, 25 Feb 2025 17:06:51 -0800
Message-Id: <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
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

Meson.build files were refactored to add MSVC support for the AVX2
instruction set with MSVC: Top level variable cc_avx2_flags was created
and set according to the compiler used. It is used in lower level
directories.

Andre Muezerie (5):
  eal: make compatible with instruction set updates for MSVC
  eal: only use numbers as align parameters for MSVC
  config: create top level variable cc_avx2_flags
  drivers/net: make compatible with instruction set updates for MSVC
  acl: make compatible with instruction set updates for MSVC

 config/x86/meson.build             |  6 ++++++
 drivers/net/bnxt/meson.build       |  2 +-
 drivers/net/enic/meson.build       |  2 +-
 drivers/net/intel/i40e/meson.build |  2 +-
 drivers/net/intel/iavf/meson.build |  2 +-
 drivers/net/intel/ice/meson.build  |  2 +-
 drivers/net/intel/idpf/meson.build |  2 +-
 drivers/net/nfp/meson.build        |  2 +-
 drivers/net/octeon_ep/meson.build  |  4 ++--
 lib/acl/meson.build                |  2 +-
 lib/eal/common/rte_random.c        |  2 ++
 lib/eal/x86/include/rte_vect.h     | 11 ++++++++++-
 12 files changed, 28 insertions(+), 11 deletions(-)

--
2.48.1.vfs.0.0

