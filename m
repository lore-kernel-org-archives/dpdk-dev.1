Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB28BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEE30402C8;
	Tue,  3 Jun 2025 17:32:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 95BCB4028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748964768; x=1780500768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qo117bDw/C6r4Hc+P3jaeRcR4PAs4IokEluca9JWir4=;
 b=IFdXrhenAUHHP8MhmxUsuJK5e+HfNlsb+o4wZj7AbLzcEm/FS2EvuqIt
 Tp29E2wRMsNegosl+KQLEQIMuDtt67C832Rxao0aAYWERPPT1Kg3FHBhS
 pQx/7FrerhdfAtlu1E1YfbRCpglSawYOqKNXtRn+dkY6Ij/9RFknLf6Ad
 h6CcMSkIDssb1Hn95qpLQ9cRFm435twmyFddCmqCyHhDMWcBUmAhWQnS+
 no3KEYlPyWu/JaTBr88AZ7HAI5DmeRbsIDLG4YguwLbQ61YoUf88Z3NWU
 eFHOZKi6uf7TAk6ZeH2tVLimfrQF1LKTiLtRZXbLjReqvwpo9t++6ompt g==;
X-CSE-ConnectionGUID: tGNIZeFsTMWa5hda3rxo9g==
X-CSE-MsgGUID: Jolea5EKT7W/qp5uICZDtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51011737"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="51011737"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:32:47 -0700
X-CSE-ConnectionGUID: yi5tRhKYT/e5Ic5oJ9sjAw==
X-CSE-MsgGUID: 4IVteRX/TKaPDjUXLXuphg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150052564"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2025 08:32:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] argparse additions and rework
Date: Tue,  3 Jun 2025 16:32:30 +0100
Message-ID: <20250603153233.2427833-1-bruce.richardson@intel.com>
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

v2: minor changes to patch 2 (see log at end of that patch)

Bruce Richardson (3):
  argparse: add support for string and boolean args
  argparse: make argparse EAL-args compatible
  argparse: use enums to remove max-value defines in lists

 app/test/test_argparse.c               | 229 ++++++++++++++-----------
 doc/guides/rel_notes/release_25_07.rst |  50 ++++++
 examples/dma/dmafwd.c                  |  20 +--
 examples/flow_filtering/main.c         |   4 +-
 lib/argparse/rte_argparse.c            | 184 ++++++++++++--------
 lib/argparse/rte_argparse.h            |  94 +++++-----
 6 files changed, 355 insertions(+), 226 deletions(-)

--
2.48.1

