Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E1C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 17:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 911EE402EB;
	Fri, 16 May 2025 19:36:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D07B4402B1
 for <dev@dpdk.org>; Fri, 16 May 2025 19:36:48 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E5200201DB26; Fri, 16 May 2025 10:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5200201DB26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747417007;
 bh=vAk0Ju+4Zr15soZuGYeU+LSKD5DDAmCUC+ohOg9jBCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eQzPDw8h3eoPZQrPYePWsPUyU306nQoWFw3Qfa5F7FxCsKLVbmM6yscZCvgjc/Zc8
 kDEArG3Rwr6CG43XG+2cvMFHsOSEFWmztS/so/Z9CBHclVwL8zxo25xXZzh/anqwDh
 +UTM4SY00a+nDixfeQN5p3vr50PGzcEQlYLDJ66k=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com,
	dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v2 0/2] enable lpm to be compiled with MSVC
Date: Fri, 16 May 2025 10:36:40 -0700
Message-Id: <1747417002-28419-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733278801-19296-1-git-send-email-andremue@linux.microsoft.com>
References: <1733278801-19296-1-git-send-email-andremue@linux.microsoft.com>
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

This patchset resolves all issues related to lpm that until now prevented
it from being built using MSVC.

After resolving the issues it enables lpm to be compiled with MSVC.

v2:
- Updated meson.build to enable lpm for MSVC

Andre Muezerie (2):
  lib/lpm: use standard atomic_store_explicit
  lib/lpm: enable lpm to be compiled with MSVC

 lib/lpm/meson.build |   6 ---
 lib/lpm/rte_lpm.c   | 108 ++++++++++++++++++++++++++++----------------
 lib/lpm/rte_lpm.h   |  56 ++++++++++++++---------
 3 files changed, 104 insertions(+), 66 deletions(-)

--
2.49.0.vfs.0.3

