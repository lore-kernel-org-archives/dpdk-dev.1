Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A958CC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92156402E2;
	Mon, 21 Jul 2025 17:24:54 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 08B4840297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:24:53 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3E6DA211764C; Mon, 21 Jul 2025 08:24:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E6DA211764C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1753111492;
 bh=jlHIr0/HpxMdS9/cEdckYLw6DMWyCKhdUFLiaPVnSgk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E/S9sizJfu+VY/y22m9FYdEI5gS6Abi2zmx/7Kamd7RdmvrCTi9ZUVA44Jo2+kknt
 KbJdGinXQpCo1Nvw3VuDJVZT3CuiRtBszkz2Pl6npAtw5VuUQgToaaoaf+knwU1jy3
 MqYoDPE9qWkVzm9PFiCe7DbiOvWIzFwKDwCMf1UY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v4 0/3] enable drivers to be compiled with MSVC
Date: Mon, 21 Jul 2025 08:24:41 -0700
Message-Id: <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
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

v4:
- Add explicit casts to avoid warnings in mlx5 driver
(https://bugs.dpdk.org/show_bug.cgi?id=1758).
- Add cast to drivers\net\mlx5\mlx5_rx.c to avoid warnings
about signed/unsigned comparison.

v3:
- Add a patch to enable drivers to be compiled with MSVC.

v2:
- Rebase on top of latest main.

Andre Muezerie (3):
  app/test: remove use of non-standard array range initialization
  drivers/net: remove use of non-standard array range initialization
  drivers: enable drivers to be compiled with MSVC

 app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++++++++++++++++-
 drivers/common/mlx5/mlx5_malloc.h          |   4 +-
 drivers/meson.build                        |   4 -
 drivers/net/mlx5/mlx5_flow_dv.c            |   5 +-
 drivers/net/mlx5/mlx5_rx.c                 |   4 +-
 drivers/net/mlx5/mlx5_utils.c              |   4 +-
 drivers/net/octeon_ep/otx_ep_mbox.c        |  24 +++-
 7 files changed, 183 insertions(+), 18 deletions(-)

--
2.50.1.vfs.0.0

