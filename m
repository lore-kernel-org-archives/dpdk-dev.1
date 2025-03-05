Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1100C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:06:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2AB540275;
	Wed,  5 Mar 2025 17:06:52 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E71B540275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:06:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 01619211049E; Wed,  5 Mar 2025 08:06:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 01619211049E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741190811;
 bh=Ql+n5e+rhcpS9XItzsxtvOedTN+LC3e53OU9KlZ9E0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YXE8WaCr07JysD6SdcxUTyzNpnndrxST9p+bI1HINlAPaOB8FXpWH9Fcpkq7eA7AG
 0Q84Co6sVA5czTVMZzCevz8b8k4XgsoSJDeq7RWFchJwy5gNR5lqnldARWf6IcqfFh
 txUKQDjfdNwmzao6RenCb4pCEXcl3bCI8PF+2UIs=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 0/2] remove use of non-standard array range initialization
Date: Wed,  5 Mar 2025 08:06:40 -0800
Message-Id: <1741190802-19486-1-git-send-email-andremue@linux.microsoft.com>
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

Array range initialization is non-standard and is not provided by
all compilers. MSVC does not implement it and ends up emitting
errors like the one below:

drivers/net/r8169/r8169_phy.c(380):
    error C2143: syntax error: missing ':' before '...'
case CFG_METHOD_48 ... CFG_METHOD_57:

The fix is to explicitly initialize each element in the range.

v2:
- Rebase on top of latest main.

Andre Muezerie (2):
  app/test: remove use of non-standard array range initialization
  drivers/net: remove use of non-standard array range initialization

 app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++-
 drivers/net/octeon_ep/otx_ep_mbox.c        |  24 +-
 drivers/net/r8169/base/rtl8125a_mcu.c      |   8 +-
 drivers/net/r8169/base/rtl8126a.c          |   5 +-
 drivers/net/r8169/r8169_ethdev.c           |  34 +-
 drivers/net/r8169/r8169_hw.c               | 447 ++++++++++++++++++---
 drivers/net/r8169/r8169_phy.c              | 163 +++++++-
 drivers/net/r8169/r8169_rxtx.c             |  25 +-
 8 files changed, 770 insertions(+), 92 deletions(-)

--
2.48.1.vfs.0.0

