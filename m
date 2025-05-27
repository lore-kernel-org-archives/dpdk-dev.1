Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D9C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 09:21:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B878402D6;
	Tue, 27 May 2025 11:21:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 63346402B9
 for <dev@dpdk.org>; Tue, 27 May 2025 11:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748337685; x=1779873685;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O3LH2bAqT7PzsdMV6otBGg9R1lYKBEXC0om4pPBjetI=;
 b=L4B9efHZD2JFWH8iSDQiuzRaZm1lUCptoWyiIL42jnRak238hqGEydRS
 wPfMCvhuA8D9OqByslbuDUTPq7vG4FDQvrRtGAhwcHaaZ2xqj+35MIlIn
 h8Cue2h2RW47V62EEnNzBMdZt39V6gtOXzQn0kgkpxCR0yHRYgW7SnjGY
 VcXYcXy46LR4m+aW9afIKY2rWnpqPLad+uNNvfYayCFycjisytn77YQOF
 e+yf+cEm0WgXnlqbmqrAB8EpHgPLKAVcVSW5MYJG6ncc2xGUV76fr4JjX
 62h3ZeVOpJK0fIulCOUOil8Cq+gwXT4vUSWJ7Z+NptxjM2YsdFwuJVvp4 A==;
X-CSE-ConnectionGUID: ajanVsD5Qwa00eCArUw8rQ==
X-CSE-MsgGUID: TC0MccduSyet939lMp+odA==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50197799"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50197799"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 02:21:23 -0700
X-CSE-ConnectionGUID: PW8yCgyqRB6uinRfN4B/mg==
X-CSE-MsgGUID: r3SPNIIwQ3+j6Zx/u0C7ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143703917"
Received: from silpixa00401217.ir.intel.com ([10.55.128.45])
 by orviesa008.jf.intel.com with ESMTP; 27 May 2025 02:21:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] argparse additions and rework
Date: Tue, 27 May 2025 10:21:10 +0100
Message-ID: <20250527092113.903910-1-bruce.richardson@intel.com>
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

This patchset is based off the work to adjust how we do argument parsing
inside EAL. To enable argparse to be effectively used for EAL, we have
new features and some changes in the first two patches, which are 
relatively small - though are ABI/API affecting.

These add support for saving off strings and boolean values, have argparse
stop parsing at a "--", and finally have argparse return the number of
arguments actually parsed on success.

The third patch is a bigger change. It was inspired by the fact that
when adding the boolean and string support we had to update some
"MAX" value defines used in the code. This is obviously not good from
an ABI/API perspective, once the library becomes part of the stable ABI.
In order to remove these MAX values, patch 3 looks to replace the
#define values with enums - which means some rework splitting the
various flags into separate categories, and similarly splitting the
single "flags" field with separate fields specifying if an argument
value is required, what type that value should have, and then a
final smaller field for any additional modifiers.

Bruce Richardson (3):
  argparse: add support for string and boolean args
  argparse: make argparse EAL-args compatible
  argparse: use enums to remove max-value defines in lists

 app/test/test_argparse.c               | 235 ++++++++++++++-----------
 doc/guides/rel_notes/release_25_07.rst |  49 ++++++
 examples/dma/dmafwd.c                  |  20 +--
 examples/flow_filtering/main.c         |   4 +-
 lib/argparse/rte_argparse.c            | 184 ++++++++++++-------
 lib/argparse/rte_argparse.h            |  91 +++++-----
 6 files changed, 352 insertions(+), 231 deletions(-)

-- 
2.48.1

