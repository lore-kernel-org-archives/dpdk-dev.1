Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7AC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBEAA402D6;
	Tue,  4 Feb 2025 19:54:38 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B7C4340261
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B3D2B20BCAD8; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3D2B20BCAD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695274;
 bh=zLJT2T7whUiiPv6BQN9Gr3MLTN+hoQBH+6EIUvpjHvs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R8UWsoOS6jHBdSQF3k1oWi2y/SNmQZtR+jS3sWpvqP7LG/F5xjbXEUjpUeSqn5iYZ
 qy++JlZtl2Fsf8udJG1Qhum5JdLj9s/PvdpPrGaGpsNEVZMNLc395tAidAwBjc+vsH
 RmpFN4STIdRt3TKqzrFJ2oVB9SRfZ2KbA57MMU9M=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 0/7] eliminate dependency on non-portable __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:24 -0800
Message-Id: <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
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

Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
Therefore the errors below are seen with MSVC:

../lib/mldev/mldev_utils_scalar.c(465): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar.c(478): error C2051:
    case expression not constant

../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
    case expression not constant

Turns out that the places where __SIZEOF_LONG__ is currently
being used can equally well use sizeof(long) instead.

v4:
 * rebased on latest main as previous patch was not applying cleanly
   anymore.

v3:
 * added prefix RTE_ to BITS_PER_LONG* and moved them to rte_common.h
 * defined PLT_BITS_PER_LONG* in drivers/common/cnxk/roc_platform.h to
   avoid warnings from checkpatches.sh like:

   Warning in drivers/common/cnxk/roc_bits.h:
   Warning in drivers/common/cnxk/roc_ie_ot.h:
   Warning in drivers/common/cnxk/roc_ie_ot_tls.h:
   Use plt_ symbols instead of rte_ API in cnxk base driver

   It can be seen that the same was done in the past for similar
   macros like PLT_CACHE_LINE_SIZE

v2:
 * fixed typo in commit message

Andre Muezerie (7):
  eal: eliminate dependency on non-portable __SIZEOF_LONG__
  drivers/bus: eliminate dependency on non-portable __SIZEOF_LONG__
  drivers/common: eliminate dependency on non-portable __SIZEOF_LONG__
  drivers/dma: eliminate dependency on non-portable __SIZEOF_LONG__
  drivers/net: eliminate dependency on non-portable __SIZEOF_LONG__
  drivers/raw: eliminate dependency on non-portable __SIZEOF_LONG__
  mldev: eliminate dependency on non-portable __SIZEOF_LONG__

 drivers/bus/fslmc/mc/fsl_mc_cmd.h      |  3 +--
 drivers/common/cnxk/cnxk_security_ar.h |  4 ++--
 drivers/common/cnxk/roc_bits.h         | 13 ++++---------
 drivers/common/cnxk/roc_ie_ot.h        |  4 ++--
 drivers/common/cnxk/roc_ie_ot_tls.h    |  5 +++--
 drivers/common/cnxk/roc_platform.h     |  2 ++
 drivers/common/nfp/nfp_platform.h      |  8 +++-----
 drivers/dma/dpaa/dpaa_qdma.h           |  3 +--
 drivers/dma/hisilicon/hisi_dmadev.h    |  3 +--
 drivers/net/ena/base/ena_plat_dpdk.h   |  6 ++----
 drivers/net/hns3/hns3_ethdev.h         |  3 +--
 drivers/raw/ifpga/base/opae_osdep.h    | 12 ++++--------
 lib/eal/include/rte_common.h           |  5 +++++
 lib/mldev/mldev_utils_scalar.h         |  6 +-----
 14 files changed, 32 insertions(+), 45 deletions(-)

--
2.47.2.vfs.0.1

