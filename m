Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095C6CD98C5
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 16:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09333402B6;
	Tue,  9 Jun 2026 18:14:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id B38D3400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 18:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781021650; x=1812557650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l0jJ7245ncD2BXnRVPpsdHqlsrXIX8G7uZrq4Wx7ya8=;
 b=bbJ9zM+V4Kfwdbj6OL9l8lmBtoQkiR3nQKg4U9OMWXChDhc0Y4rpDmnt
 z7cyMbwzu1ILZpFgER2CrmOLUT5sr1BiCjrcWSak1P1d2uDdz8ld+6Si8
 kSEuoQyHBu04q2/eBaDpiKKpNKNTaY+6ddLafFA6Dvox11KzuQT2WYqHd
 X+4qU1pvAlZEblMT9UkXJWf7MbApUxX4mq6CKR2xuHmMZqx32SMwqLQmI
 pzFSpStbHNitV7vyYDrUe/GVZMm1tti64DyASyw3Z5W5EWPArW1p8+kfo
 7pCzwFH2v3/HvSw3IqO4YvNEb+bOLoyU/prxdlKRJA2QDN9qbzWoMImAR g==;
X-CSE-ConnectionGUID: YWrb4/8BSJGJ8emH4Lv+Cg==
X-CSE-MsgGUID: qxx5Om5aRsG2orcoMSwvYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80809683"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="80809683"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 09:14:09 -0700
X-CSE-ConnectionGUID: ZxUkIcbrQ9GUREZAv2B98w==
X-CSE-MsgGUID: B2VNV3VZSJupnW3rHtLUKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="249830057"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 09 Jun 2026 09:14:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/3] extend interactive telemetry script
Date: Tue,  9 Jun 2026 17:13:57 +0100
Message-ID: <20260609161400.3661268-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521153913.82634-1-bruce.richardson@intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
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

To simplify interactive telemetry script for general use, i.e. not from
other scripts, we can add two new features to it:

1. Support for FOREACH to allow gathering a set of output values across
   a list of ports or devices, e.g. ethdevs or rawdevs.
2. Support having predefined aliases in a file in the user's home
   directory to simplify the use of more complicated FOREACH commands.

Putting these together, we can create new commands such as "eth_names".

  bruce@host:$ cat ~/.dpdk_telemetry_aliases
  eth_names=FOREACH index /ethdev/list /ethdev/info,$index .name

  bruce@host:$ echo eth_names | ./usertools/dpdk-telemetry.py | jq
  [
    {
      "index": 0,
      "name": "0000:16:00.0"
    },
    {
      "index": 1,
      "name": "0000:16:00.1"
    }
  ]

---
v3: updated based on review feedback from Chengwen:
    - added arg to override alias file
    - printed one-line summary of alias count loaded
    - improved doc for "help" command
    - added "help alias" to list aliases.
v2: added third patch with "help" command giving more details on
    how to use the various commands.

Bruce Richardson (3):
  usertools/telemetry: add a FOREACH command
  usertools/telemetry: support using aliases for long commands
  usertools/telemetry: add help support

 doc/guides/howto/telemetry.rst | 106 ++++++++++++-
 usertools/dpdk-telemetry.py    | 278 ++++++++++++++++++++++++++++++++-
 2 files changed, 373 insertions(+), 11 deletions(-)

--
2.53.0

