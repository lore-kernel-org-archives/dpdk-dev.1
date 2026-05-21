Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE755CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:39:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 823E2402A2;
	Thu, 21 May 2026 17:39:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8695D400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779377976; x=1810913976;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m7pl5xiv5EtZsN/5jzlloXPGGX2636I7PYYL5eNjHAI=;
 b=iDzIozj1xnfTbgPxB6Rp0ggXuIthZ2Eh6bZQLFQQ66dGKI3LKQbY3ce+
 JHeORu0mBd8UC6XeHGVAVKAmYfbTsgX6ADdwhjl9AGdm2SYPTXaYUm+uU
 uYErhXDqC7RxJqHN/g+GRUdum006TmkYsGTZLNXcvAKHJr6Qu37KosIVd
 T6CxpGAapRq0mOCO6SRFC09Ym3wf0ukZzZ7dmDTqmEmUZH+j47xE8ccuU
 P9EPwmG4ANlzuCNgeO2nGOG158N23U6XddVxoVzvGv7E6sCSM8GRFDGM3
 fJXprNXgxPNeRVWuVNTN5QRed4klgm9xgxXjurgtCXHb2dGz9XfzhgDOM g==;
X-CSE-ConnectionGUID: B/Hz9R11Sneumx24rG8Nmg==
X-CSE-MsgGUID: /fHX97+6SPC5VNJnCnDpIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80353601"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="80353601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:39:34 -0700
X-CSE-ConnectionGUID: utjnjEDxQS+02eeSAv1kCg==
X-CSE-MsgGUID: NrSe4rc/TvGoRsEpDT++7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="278672021"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 May 2026 08:39:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] extend interactive telemetry script
Date: Thu, 21 May 2026 16:39:11 +0100
Message-ID: <20260521153913.82634-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

Bruce Richardson (2):
  usertools/telemetry: add a FOREACH command
  usertools/telemetry: support using aliases for long commands

 doc/guides/howto/telemetry.rst |  76 +++++++++++++
 usertools/dpdk-telemetry.py    | 201 ++++++++++++++++++++++++++++++++-
 2 files changed, 271 insertions(+), 6 deletions(-)

--
2.53.0

