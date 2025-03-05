Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC24C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24AEA4042E;
	Wed,  5 Mar 2025 17:38:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4C10C4025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:38:18 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 91A51210EAE3; Wed,  5 Mar 2025 08:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91A51210EAE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741192697;
 bh=yamJjk9i2djH+DydFn20tArJPNr9ZlPq55SoOcP+e+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fxbm+t8vp2CPTAmv8MAdL75BpcC/7Zo+8OPwvF+T06HpMNFIrXjF/qUqUijE4wukY
 NyK4voWQKDweFW+VZhh1VP4hDU8h2EG/jAp0G4Qi7dliYdVpbH7mWrMfovx5YbAqZ8
 e+AB6QHbXXnXJtCmcX+cJXzwTXptQ1SB5jyE4djo=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v3 0/5] add portable version of __builtin_add_overflow
Date: Wed,  5 Mar 2025 08:38:05 -0800
Message-Id: <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. There's a need for a portable
version that can also be used with other compilers.

v3:
- Rebase on top of latest main.

Andre Muezerie (5):
  maintainers: add portable version of __builtin_add_overflow
  eal: add portable version of __builtin_add_overflow
  doc/api: add portable version of __builtin_add_overflow
  net/intel: use portable version of __builtin_add_overflow
  app/test: add tests for portable version of __builtin_add_overflow

 MAINTAINERS                          |   1 +
 app/test/meson.build                 |   1 +
 app/test/test_math.c                 | 170 +++++++++++++++++++++++++++
 doc/api/doxy-api-index.md            |   1 +
 drivers/net/intel/ice/base/ice_nvm.c |   9 +-
 lib/eal/include/meson.build          |   1 +
 lib/eal/include/rte_math.h           |  46 ++++++++
 7 files changed, 224 insertions(+), 5 deletions(-)
 create mode 100644 app/test/test_math.c
 create mode 100644 lib/eal/include/rte_math.h

--
2.48.1.vfs.0.0
