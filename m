Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0EC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 08:01:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 109EE406A2;
	Thu, 10 Sep 2026 10:01:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4F31F4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 10:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789027317; x=1820563317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cDv7KQ26Y0DrZFnclCV8QqIyQdphSuihOfBalgmxpiQ=;
 b=YmVOvTjn77j210ZJZksd+Fwc99jNU4kiuVrUAqqBiXrMmDzGjiVHZFbm
 ipLeevLgGLS4mMdZMwswiToS7IWnQCRNupw6sHgDKUGZPEBSNqw2NpZD7
 chE2w9Gh9XQkN/xKEH9RgRYq5pdTiutfCxpqokVpDq1CoHWL5DIzN668c
 mvozk3PLXCSdfvl9uHgpFk0UJUETeZA5qvLDpZtRtZv3yImn3DFaZMyR8
 Ft6vmC2JFVY9e4kf1fdBRcr/+ZjRvVTlyjB7DvRz0TkecAVXieVKtDi3u
 Do/5AL6HXFCtLGZzFCfcf/76DDjT/sAzVx6PphPnLBNnDn/VI0XDjq0O3 g==;
X-CSE-ConnectionGUID: DSfJV2SAQRmX+ies11McWQ==
X-CSE-MsgGUID: 0tyFM38kRpevKbUxeD/vzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100989478"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="100989478"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 01:01:56 -0700
X-CSE-ConnectionGUID: IoN4XY57TgGyj/TBbBswkw==
X-CSE-MsgGUID: BMqE35PfSzi/84bOSm5bIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="267271983"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2026 01:01:53 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Deep Singh <aman.deep.singh@intel.com>,
 Nirint Shah <nirint.shah@intel.com>, Prudvi Deti <prudvi.deti@intel.com>
Subject: [RFC v2 0/7] regex/hs: introduce Hyperscan regex PMD
Date: Thu, 10 Sep 2026 13:30:39 +0530
Message-ID: <20260910080136.1790851-1-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828053629.1224611-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
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
 drivers/regex/hs/hs_regex.c            | 1446 ++++++++++++++++++++++++
 drivers/regex/hs/hs_regex.h            |  101 ++
 drivers/regex/hs/meson.build           |   19 +
 drivers/regex/meson.build              |    1 +
 10 files changed, 1837 insertions(+)
 create mode 100644 doc/guides/regexdevs/features/hs.ini
 create mode 100644 doc/guides/regexdevs/hs.rst
 create mode 100644 drivers/regex/hs/hs_regex.c
 create mode 100644 drivers/regex/hs/hs_regex.h
 create mode 100644 drivers/regex/hs/meson.build

-- 
2.43.0

