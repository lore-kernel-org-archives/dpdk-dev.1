Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A61BCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 01:01:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E01C840652;
	Wed, 20 Aug 2025 03:01:06 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5A6A740151
 for <dev@dpdk.org>; Wed, 20 Aug 2025 03:01:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 6E5B32115A56; Tue, 19 Aug 2025 18:01:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E5B32115A56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1755651663;
 bh=QtprBRT6uVx+MOmObmBRjKn7rpp8QI8UMlxhyMD3YEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=II2Hi+Tvz3VHvLlfmN+sjzb63VYdNxjYYnEbNsTLRp/qWpoV/8n3jrI/VwZ4vpEbd
 dW5UIg8vEfa3/ZLnG47l4lqLTdkUQQT6EWkS0hkvH25TIWWDH1qYLyviyb8OhIYB6U
 ZgELGKXwXw76ynoaNNjh6APCwG4VY5fDtaI6g6lc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v5 0/3] enable drivers to be compiled with MSVC
Date: Tue, 19 Aug 2025 18:00:55 -0700
Message-Id: <1755651658-13063-1-git-send-email-andremue@linux.microsoft.com>
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
compiled with MSVC and enables drivers to be built with it.

v5:
- Remove unnecessary parentheses from macros

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
  drivers/net: make code compatible with MSVC
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
2.50.1.vfs.0.1

