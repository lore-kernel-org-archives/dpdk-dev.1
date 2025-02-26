Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EEBC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 21:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2880840608;
	Wed, 26 Feb 2025 22:21:14 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id AB5334029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 22:21:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id DE660204E5A5; Wed, 26 Feb 2025 13:21:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE660204E5A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740604871;
 bh=jfCyTSfLw71I3U1RJojj/DUf3JGkUJi2Dxt9kNj9uSQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m+6204rE3IqcrLC25vDtOOFAOFLV47ltgJDPdjkx4YgQNkTGxv75C3ye9o8tpYcQe
 zbQpsXCUuT7SmQkv6qAPIlk34b5sH6O5dw2dzG2s9Eidp3W2f2XKNcTM/4D0oIczBv
 TUH19+Z5ynkNjo++ZLPVXspcUE9vTAyvP/UY+7eE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/3] allow faster instruction sets to be used with MSVC
Date: Wed, 26 Feb 2025 13:21:03 -0800
Message-Id: <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
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

Andre Muezerie (3):
  eal: make compatible with instruction set updates for MSVC
  eal: only use numbers as align parameters for MSVC
  config: create top level variable cc_avx2_flags

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

