Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E6C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6A940150;
	Fri, 28 Aug 2026 07:36:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 18A554003C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895413; x=1819431413;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=65hAXoQJ85KmriqPWZ4hRoZcgT3S9AqUr8cA7t5dzHM=;
 b=OSVNC5FJBaFeYJC+eOiLiolsN81Agv5P3OaKiaLnX/RO3Hix/rAZ8+ym
 VcoCZhdZb8idqc7aIpwgujkYUAXtHvFKiceck9QIQDRiYpSlP1IELNqhg
 lksV5JmKfS8vcjsP2e27zinA8EpoO2FNABi86SeBJuLUS9+M/Dw56SYsJ
 cHzwH9Iv/SYgl8GbWyZe87aBwT7sEjQcLUSYAtrN92fzH/P91HhMZYMrx
 9zMJ/bIbbgwsvUN9wQPexhnyDpPoHaTHXMEXRYH/z4fJ4d3UcHe20FR3R
 BIOmXB2Ey08o+pcsWKq5MkYgRe96BhMrfx+RcKuPr1BgVluv3j/jPDMDy g==;
X-CSE-ConnectionGUID: 0z8w3WkjQQm0Uw8M42I0yQ==
X-CSE-MsgGUID: Up11YUZ0QAinTm28B2nDOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425711"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425711"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:36:51 -0700
X-CSE-ConnectionGUID: FgXBNTZmSQ2A/Q9+v2hOfw==
X-CSE-MsgGUID: aiL4XiyoS+GkhotbGf2NfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477063"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:36:50 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 0/7] regex/hs: introduce Hyperscan regex PMD
Date: Fri, 28 Aug 2026 11:05:49 +0530
Message-ID: <20260828053629.1224611-1-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
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

This RFC series adds a new regexdev PMD based on Hyperscan.

Goal: provide a software regex PMD for environments without regex HW,
while keeping compatibility with the standard ``rte_regexdev`` API.
The PMD is a virtual device, created with ``--vdev=regex_hs`` at EAL
init.

The series introduces:
- a new vdev driver under ``drivers/regex/hs``
- device and queue pair configuration, start/stop/close lifecycle,
  and device dump support
- rule database update, compile+activate, import/export of serialized
  Hyperscan databases
- enqueue/dequeue burst paths with per-queue-pair scratch usage and
  per-queue-pair extended statistics (enqueued/dequeued/matches)
- PMD-private rule flag mappings for common Hyperscan compile options
  (singlematch, prefilter, SOM-leftmost, combination, quiet)

Behavior notes relevant for review:
- per-op match counters are bounded by API field width
  (``nb_matches``/``nb_actual_matches`` are ``uint16_t``)
- payload size exposed through regexdev is ``max_payload_size = 65535``
  bytes, while Hyperscan block mode itself supports larger scan buffers
- queue pairs are intended for single-thread ownership (SPSC model)
  with dedicated scratch per queue pair

Documentation, feature matrix integration, meson integration, and
maintainers metadata are included.

Prudvi Deti (7):
  regex/hs: add driver skeleton and build integration
  regex/hs: add device configure and queue pair setup
  regex/hs: add rule database update and compilation
  regex/hs: add enqueue and dequeue burst paths
  regex/hs: add per-queue-pair extended statistics
  regex/hs: add start stop close and device dump
  regex/hs: add Hyperscan compile flag support

 .mailmap                               |    1 +
 MAINTAINERS                            |    6 +
 doc/guides/regexdevs/features/hs.ini   |    8 +
 doc/guides/regexdevs/hs.rst            |  158 +++
 doc/guides/regexdevs/index.rst         |    1 +
 doc/guides/rel_notes/release_26_11.rst |    7 +
 drivers/regex/hs/hs_regex.c            | 1342 ++++++++++++++++++++++++
 drivers/regex/hs/hs_regex.h            |   89 ++
 drivers/regex/hs/meson.build           |   19 +
 drivers/regex/meson.build              |    1 +
 10 files changed, 1632 insertions(+)
 create mode 100644 doc/guides/regexdevs/features/hs.ini
 create mode 100644 doc/guides/regexdevs/hs.rst
 create mode 100644 drivers/regex/hs/hs_regex.c
 create mode 100644 drivers/regex/hs/hs_regex.h
 create mode 100644 drivers/regex/hs/meson.build

-- 
2.43.0

