Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831CC87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 14:27:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D51A5402D6;
	Fri,  8 Aug 2025 16:27:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2F45A4028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 16:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754663249; x=1786199249;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=50qzGGjQHpmNHu3tK9svo8mRLiQJvJYyhq0Ifzzz2T0=;
 b=XjtxbCTOv6RBNFROQ40wP45cNUNgAZ4TlCW4iuSIjT2xJuHH3zUjCw1C
 Lklcsj5kwhztzNuk5yIW3TAYqdyIehbuqJr42YiwGb85S7hkfuD34oKf+
 ZvjRDHLDncwOJWwIUuiZClF87OmBN+zL2tIZVwaSYBiGM71Uh5s6uYK1x
 Evhwn6EFhf8hZEkBqSMcyJESsqR4XbV+PdT7Hs54OCgiJU4BugeRSPdzh
 EOtVkxgh86hgzH0MI6imsEgE6jr8P4wawp6fbiWiI9BX27bP+ms7J8tPe
 jjZXLmycUKF4LSopUJYvG5z9InPiq21llJwgNtQdf6WinZ5kFLN8TD+fw g==;
X-CSE-ConnectionGUID: ncLlAlLVSYOSLMSi2nijRg==
X-CSE-MsgGUID: pYNPM/r+SlecweRDPz0PZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67601903"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67601903"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 07:27:27 -0700
X-CSE-ConnectionGUID: Y7IMeOk/ToeKVCQi/Z64HA==
X-CSE-MsgGUID: Rs8moQcRQomdS3nBeQdu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165715883"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2025 07:27:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] Improve mailmap file
Date: Fri,  8 Aug 2025 15:27:18 +0100
Message-ID: <20250808142721.408998-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The mailmap file in DPDK is not always correctly sorted, and standard
cmdline sorting tools don't always do the job correctly. To improve
things, add a new script to devtools for working with the mailmap file,
to make it easier to add new entries in the correct place, to check the
file for correctness, and lastly to sort the file in place (hopefully a
one-off operation).

Once that is done, commit the changes to the mailmap file to ensure it
is correctly sorted in the repository.

Bruce Richardson (2):
  devtools/mailmap_ctl: script to work with mailmap
  mailmap: sort mailmap

 .mailmap                | 354 ++++++++++++++++++++--------------------
 devtools/mailmap_ctl.py | 211 ++++++++++++++++++++++++
 2 files changed, 388 insertions(+), 177 deletions(-)
 create mode 100755 devtools/mailmap_ctl.py

--
2.48.1

