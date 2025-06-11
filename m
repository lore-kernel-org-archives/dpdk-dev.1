Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C035C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 12:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 147CE40677;
	Wed, 11 Jun 2025 14:36:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8CF374066F
 for <dev@dpdk.org>; Wed, 11 Jun 2025 14:36:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749645416; x=1781181416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yyNzFsP8fdMNixDtq31zAet4TocUa0Ncc2FP1hdnnCE=;
 b=V6VWZMxXSl99Bxl9rCfWHhBG9GXC5e3WsUOtHpzah8NVBHH0r0ZJ77aX
 2w2aIG/ZKCqiFay6tv8jOzsYcDLZe7684sBr/NLe9xIaYL9WRdD2IIS+E
 vtfwgk+Xx6tmm47BDEXJ8HoQmgtSfCjyGUESoX4OiE07/1KZmhk3maDnl
 IRQmfAlErYNmaTlHr29IYYrBrWQOhh3BaDg1w84irC4ffMc4kc01q6br/
 fgiKFCCRDrDd+cZKVFCKKU6uOLyqHzCUkIfUfYa7xLz/ipp/cznzwFv54
 BTnUipaFuK0loB9S0dyX50uXfLuH7Ok82G39mIzCF3tyvt1G8ahHmATCc A==;
X-CSE-ConnectionGUID: gTJk7RC/TFa1Iexk1b9bHA==
X-CSE-MsgGUID: IzwioR3iTdu1fwvuFtHySA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51934435"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51934435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 05:36:55 -0700
X-CSE-ConnectionGUID: 8oWJqrI6ToynHyI5qbFSTw==
X-CSE-MsgGUID: GcuI2aBITW+iPDHAHpjAHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="150984488"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.33])
 by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2025 05:36:54 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/3] argparse additions and rework
Date: Wed, 11 Jun 2025 13:36:28 +0100
Message-ID: <20250611123649.481811-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527092113.903910-1-bruce.richardson@intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
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

v4: rebase on main to avoid CI errors

v3: additional doc updates to patch 3

v2: minor changes to patch 2

Bruce Richardson (3):
  argparse: add support for string and boolean args
  argparse: make argparse EAL-args compatible
  argparse: use enums to remove max-value defines in lists

 app/test/test_argparse.c               | 229 ++++++++++++++-----------
 doc/guides/prog_guide/argparse_lib.rst |  36 ++--
 doc/guides/rel_notes/release_25_07.rst |  50 ++++++
 examples/dma/dmafwd.c                  |  20 +--
 examples/flow_filtering/main.c         |   4 +-
 lib/argparse/rte_argparse.c            | 184 ++++++++++++--------
 lib/argparse/rte_argparse.h            |  97 ++++++-----
 7 files changed, 379 insertions(+), 241 deletions(-)

--
2.48.1

