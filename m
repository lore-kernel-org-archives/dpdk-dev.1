Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182E8CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 13:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A0E7402D9;
	Fri, 22 May 2026 15:37:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C3B774003C
 for <dev@dpdk.org>; Fri, 22 May 2026 15:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779457039; x=1810993039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T1L8LCV5Fk4Y6IrpangAJgChTKERKj0vffllJ+YEyoA=;
 b=ccU5S8lWjN9j/0jx1w7Vjevcay84uNvJ3as0DYD7aLMmPXoaEgRAkxnu
 kcD4Aw1tmwIUiOs8zmHzYGEK16xemxVjaciWZpcrYzWsGSkXJleBPQRbA
 CwzDpoHjS70l5bZeKilqmRiAUi9l7FE4xuEAMFnkw3Om72X7cq08UhsEl
 vlBTLeYb8gBdmmZUtoWjuYAvxB4jgwolKtUCtFNWhMPoP3dy5TZnedfyi
 D4yr0YfSvAH2cXqBTnpfq7FKBG0LBvRxHQz5ctT2FLwjbvoRou3CJB4G/
 2IOqcvYnIpFkEIo6u6JqkFslFUnJoR0fn5JJLq/VwPUE5lq/RZzVGRsLn Q==;
X-CSE-ConnectionGUID: fVMKGMdcRhCTsTARpoxPmA==
X-CSE-MsgGUID: 8UBh57sVQVCNqWkn7p1QbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80237483"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80237483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 06:37:17 -0700
X-CSE-ConnectionGUID: wiSKXDgoRiKbJDpJu8Qa5g==
X-CSE-MsgGUID: dNK9JmlAQ4i1fTOWEYh2Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="241145326"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 22 May 2026 06:37:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: fengchengwen@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] extend interactive telemetry script
Date: Fri, 22 May 2026 14:37:10 +0100
Message-ID: <20260522133714.133268-1-bruce.richardson@intel.com>
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
v2: added third patch with "help" command giving more details on
    how to use the various commands.

Bruce Richardson (3):
  usertools/telemetry: add a FOREACH command
  usertools/telemetry: support using aliases for long commands
  usertools/telemetry: add help support

 doc/guides/howto/telemetry.rst |  76 ++++++++++
 usertools/dpdk-telemetry.py    | 260 ++++++++++++++++++++++++++++++++-
 2 files changed, 330 insertions(+), 6 deletions(-)

--
2.53.0

