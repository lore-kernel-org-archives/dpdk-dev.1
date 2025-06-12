Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1252C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD0442789;
	Thu, 12 Jun 2025 16:17:27 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 13FC541104
 for <dev@dpdk.org>; Thu, 12 Jun 2025 16:17:26 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 39721201C778; Thu, 12 Jun 2025 07:17:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39721201C778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749737845;
 bh=dfNdi7JPxntn2RPa+pKYWYwBsJR5C3RVzt2m6uCSqJY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D/MjoU3f4rNdelTFszoNc/rKxijY96Zr0xMVNr5BApdjP46dYqdQe8A+bMiqkAnjR
 Bl9TepDogGvlE5qXGYcXAiw5dnvBLGlOUEGydwCg+SdMJG0P+sEjQTdP2CPD7FTlrz
 XLZYX27x9qlYDQ6QLlBETC/EXSSWvTrb6dUwkkyM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/3] enable drivers to be compiled with MSVC
Date: Thu, 12 Jun 2025 07:17:19 -0700
Message-Id: <1749737842-30538-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
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

This patchset solves the last issues preventing drivers from being
compiled with MSVC (array range initialization) and enables the
drivers to be built with it.

Array range initialization is non-standard and is not provided by
all compilers. MSVC does not implement it and ends up emitting
errors like the one below:

drivers/net/r8169/r8169_phy.c(380):
    error C2143: syntax error: missing ':' before '...'
case CFG_METHOD_48 ... CFG_METHOD_57:

The fix is to explicitly initialize each element in the range.

v3:
- Add a patch to enable drivers to be compiled with MSVC.

v2:
- Rebase on top of latest main.

Andre Muezerie (3):
  app/test: remove use of non-standard array range initialization
  drivers/net: remove use of non-standard array range initialization
  drivers: enable drivers to be compiled with MSVC

 app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++-
 drivers/meson.build                        |   4 -
 drivers/net/octeon_ep/otx_ep_mbox.c        |  24 +-
 drivers/net/r8169/base/rtl8125a_mcu.c      |   8 +-
 drivers/net/r8169/base/rtl8126a.c          |   5 +-
 drivers/net/r8169/r8169_ethdev.c           |  34 +-
 drivers/net/r8169/r8169_hw.c               | 447 ++++++++++++++++++---
 drivers/net/r8169/r8169_phy.c              | 163 +++++++-
 drivers/net/r8169/r8169_rxtx.c             |  25 +-
 9 files changed, 770 insertions(+), 96 deletions(-)

--
2.49.0.vfs.0.3

