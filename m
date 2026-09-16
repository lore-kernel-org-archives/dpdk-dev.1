Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E87C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 680E742EA0;
	Wed, 16 Sep 2026 14:27:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9586A427BA
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:27:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561666; x=1821097666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5/T1RG2wO9IFgE5yB/ol8NKq7auadO+ES0asYoISaQU=;
 b=e07YEDeUzXAieAYMWhjakq7R2tQ1/O4NJNzNYoV9Rva3JX+q7hZmDkUP
 r+SAbMgvmgdzBtXAkGvy0oeLdqQHLifmFfdLxUkqW8UX7he5BWMIohn9o
 BQ2mW7/8rNzoR4rdVWGPUR6VjtXUoVKaoxleRwQhjsqoKYaBR6VwrwIQ+
 bA7cRFRdYSibXL1cPUsR8AToAHYmAjz4dKO7tLLxyHc9eshNGc08LylXZ
 Kj215BnOxgKPf2M3EpVAcBaixc8tFZi6gWtiAM+UWWq79i9unk8CpvT6C
 8BxoN/477w5NoflgVkpMk1BFSIRuBvMjF01kt+IddKV/1BgCaVkECa+zs A==;
X-CSE-ConnectionGUID: O8oCDxAoQ+6cbqMbRuR2pQ==
X-CSE-MsgGUID: F/qjGLYHSYG6MJeMAHFVvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107305478"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107305478"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:27:45 -0700
X-CSE-ConnectionGUID: 3hpCKfzMRB+z5BKI/5HByg==
X-CSE-MsgGUID: RnbtfTnHSeaRR5rxgCIcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270693914"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2026 05:27:42 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>, Nirint Shah <nirint.shah@intel.com>
Subject: [RFC v3 0/7] regex/hs: introduce Hyperscan regex PMD
Date: Wed, 16 Sep 2026 17:56:57 +0530
Message-ID: <20260916122738.2176589-1-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910080136.1790851-1-prudvi.deti@intel.com>
References: <20260910080136.1790851-1-prudvi.deti@intel.com>
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

---
v3: Addressed AI review of the driver skeleton patch:
* Fixed a resource ordering issue in hs_regex_dev_create(): the device
  private data is now allocated before rte_regexdev_register(), so a
  registration failure cannot leave a registered device with no cleanup
  path, and a private-data allocation failure no longer needs to
  unregister the device.

v2: Addressed AI reviews with the following changes:
* Fixed a queue-pair resource leak on reconfigure (stale scratch and
  operation ring were not freed before reallocation).
* Rejected unsupported device and queue-pair configuration flags
  instead of silently ignoring them.
* Fixed a rule-id hash name collision between multiple device
  instances by including the device id in the hash name.
* Validated rule operations and fixed rule-id hash/array consistency
  on add and remove failures.
* Cleared the compiled-database state on a failed rule database
  import so a partially failed import cannot be reported as started.
* Implemented stop-on-match request handling and saturated the
  per-op actual-match count instead of wrapping past 65535.
* Fixed device info to report the backing vdev device instead of NULL.
* Moved the pending-operation warning so it fires on both explicit
  and implicit stop.
* Documented the 20-bit match-result rule-id limit and the
  unsupported high-priority match request mode.
* Capped dev_dump() rule listing with a summary line for large rule
  counts instead of printing every rule unconditionally.
* Documented that rule_db_export()'s output buffer has no alignment
  requirement.
* Documented building Hyperscan 5.4.2 from source as a prerequisite.

 .mailmap                               |    1 +
 MAINTAINERS                            |    6 +
 doc/guides/regexdevs/features/hs.ini   |    8 +
 doc/guides/regexdevs/hs.rst            |  235 ++++
 doc/guides/regexdevs/index.rst         |    1 +
 doc/guides/rel_notes/release_26_11.rst |   19 +
 drivers/regex/hs/hs_regex.c            | 1447 ++++++++++++++++++++++++
 drivers/regex/hs/hs_regex.h            |  101 ++
 drivers/regex/hs/meson.build           |   19 +
 drivers/regex/meson.build              |    1 +
 10 files changed, 1838 insertions(+)
 create mode 100644 doc/guides/regexdevs/features/hs.ini
 create mode 100644 doc/guides/regexdevs/hs.rst
 create mode 100644 drivers/regex/hs/hs_regex.c
 create mode 100644 drivers/regex/hs/hs_regex.h
 create mode 100644 drivers/regex/hs/meson.build

-- 
2.43.0

