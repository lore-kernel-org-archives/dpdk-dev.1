Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82268FC72CB
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 15:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5999D4042C;
	Sun, 22 Mar 2026 16:42:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 435AE402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 16:42:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774194142; x=1805730142;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8EuyXyH/JHhUtB9cMclxPZ72jB7G8JRWTiQw8yRKAko=;
 b=l5A3dJeRZgkG8d0hz9nZU4ta+EA/eFiBR0uIAQlP6anhPJ/FMPFk5zI3
 4tgwipdbj7hAElnOMSS36cqYES1vdmvju3pIhrV5tlzaRhqxW3J1U918U
 7lrPOP3fYFQ4/D54jGDeNU3D4/Qs2zMnD4rotMJBBClwZvVJuB+2rY2w3
 3IcM5J120tipl8bL3HN+65z8M2khB1kCAu2HPZbE9NEvnlUJ8PnHq4/5H
 PsX82Z4f2s/2QiYLO/pEJsnzLPMPVXJFwtRDjaH65p6zy4s7cZ7m0fH1X
 fwb1tkVY41pDXpua3521/u4h4wrtc0DXWyDb4/gzP5fwutPTBkIUmBPWi A==;
X-CSE-ConnectionGUID: WDycJpNzT+qrY0uL1jdR5w==
X-CSE-MsgGUID: KC73dq4JS3u8rKoSDcWQQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97832208"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="97832208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 08:42:20 -0700
X-CSE-ConnectionGUID: 1fUKFgMJQZaH5g75DE0KUA==
X-CSE-MsgGUID: lL1aBUSOStmDD8h7Os4AtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="221020817"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2026 08:42:18 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, nsaxena16@gmail.com, mb@smartsharesystems.com,
 adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: [RFC PATCH 0/4] VRF support in FIB library
Date: Sun, 22 Mar 2026 15:42:11 +0000
Message-ID: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
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

This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
allowing a single FIB instance to host multiple isolated routing domains.

Currently FIB instance represents one routing instance. For workloads that
need multiple VRFs, the only option is to create multiple FIB objects. In a
burst oriented datapath, packets in the same batch can belong to different VRFs, so
the application either does per-packet lookup in different FIB instances or
regroups packets by VRF before lookup. Both approaches are expensive.

To remove that cost, this series keeps all VRFs inside one FIB instance and
extends lookup input with per-packet VRF IDs.

The design follows the existing fast-path structure for both families. IPv4 and
IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
first-level table scales per configured VRF. This increases memory usage, but
keeps performance and lookup complexity on par with non-VRF implementation.

Vladimir Medvedkin (4):
  fib: add multi-VRF support
  fib: add VRF functional and unit tests
  fib6: add multi-VRF support
  fib6: add VRF functional and unit tests

 app/test-fib/main.c      | 257 ++++++++++++++++++++++--
 app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
 app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
 lib/fib/dir24_8.c        | 241 ++++++++++++++++------
 lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
 lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
 lib/fib/dir24_8_avx512.h |  80 +++++++-
 lib/fib/rte_fib.c        | 158 ++++++++++++---
 lib/fib/rte_fib.h        |  94 ++++++++-
 lib/fib/rte_fib6.c       | 166 +++++++++++++---
 lib/fib/rte_fib6.h       |  88 +++++++-
 lib/fib/trie.c           | 158 +++++++++++----
 lib/fib/trie.h           |  51 +++--
 lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
 lib/fib/trie_avx512.h    |  39 +++-
 15 files changed, 2453 insertions(+), 396 deletions(-)

-- 
2.43.0

