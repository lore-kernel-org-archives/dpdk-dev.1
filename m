Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C6ECDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7568A40265;
	Fri, 26 Jun 2026 12:34:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 705604025F
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470046; x=1814006046;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HdyUVBMlav+tUv4j4abAanoLYdgb2gUco+K3uAkh9C0=;
 b=SxJk1aOlSLvi/teiwMjZQuO2lbXM71GC+0P8jAIzajF2S7PPTOcFP7xc
 LbwuM2DXK8ii+yGimxmNYRb1ujm4m+zw4qg3/D1xrREq38zZw7dDclexU
 tfGoWoOWiFIDgA9cS/vPRoMZZWCq16vqFGb6+drthY4ePHSlEAUI35mDh
 qCFhHE9gNlDrTf9wP7D5R3RA9wyBrfOR/DpRM/Qe9ZDB5GaSYxCeBAVl4
 giUk1TuCwplswaxLJV9cDzuBgLTDe5jdO07X+NweoG+hOjz6v1dwqfWTh
 zENwteg4s9Smq13RglO7GoyY7eaQqS8cMwlsP4WVVdE3epzW3kTlbIbDW w==;
X-CSE-ConnectionGUID: H5Yc7MyiRXuvE2UWDZ936w==
X-CSE-MsgGUID: yQwlxuczRVaXCb42K1KjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941964"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:04 -0700
X-CSE-ConnectionGUID: LKRF+nw9TmahxgOWacvcsQ==
X-CSE-MsgGUID: qA5PGTaeT1SCYWodxkh5nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383951"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 0/6] IPC fixes
Date: Fri, 26 Jun 2026 11:33:55 +0100
Message-ID: <cover.1782469943.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
References: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
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

Coverity has reported (issue ID 501503) a memory leak, but there
actually were a few more problems with IPC than that. This patchset
addresses said problems.

1. Using pointer as async request identity is unsafe

Because asynchronous requests can fail at arbitrary points while
having arbitrary number of requests or alarms already in flight,
using pointer as request identity can create use-after-free risks.
Patchset replaces this with using numeric request ID instead.

2. Alarm cancel can deadlock

Async request handler may attempt to cancel the alarm, but an alarm
might have already been in progress blocking on the same lock that
is held by async request, leading to a deadlock. Patchset removes
the alarm cancel call, and allows the alarm to fire. This is fine,
because due to fix #1 the worst that can happen from calling stale
alarm is a noop, as request ID would not be found.

3. Memory leaks

There are a couple of memory leaks in failure paths. Patchset fixes
those.

4. Zero-peer async request does not trigger alarm

When async requests are performed but no peers exist, we created
a dummy request and put it on the queue, but we never set the
dummy alarm that is supposed to handle that request. Patchset adds
the alarm set in dummy paths where none was present before.

v7:
- Moved request ID reservation till after allocation
- Added build check for request ID size matching pointer size
- Moved comment about minimum delay alarm from patch 4 to patch 6

Note: AI review had a bunch of false positive "errors", all of them
looked at and verified as such.

v6:

Moved pieces around, namely:

1) apply request ID refactor first as a standalone patch
2) fix the deadlock immediately after
3) fix memory leaks next
4) add missing callback as a final step

Contents of the patchset remain the same.

Anatoly Burakov (6):
  eal: fix wrong log message in async IPC request
  eal: use request ID instead of pointers
  eal: avoid deadlock in async IPC alarm callback
  eal: fix async IPC memory leaks on partial failure
  eal: fix memory leak in async IPC secondary path
  eal: fix async IPC callback not fired when no peers

 lib/eal/common/eal_common_proc.c | 137 +++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 34 deletions(-)

-- 
2.47.3

