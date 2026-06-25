Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71572CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0B90402B0;
	Thu, 25 Jun 2026 16:01:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 770DA402B0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396113; x=1813932113;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=BSYVt3Ii69eUb0yYlESy4XJyVcUBTX9RzxZo7DtlOy0=;
 b=bzU0Ftl04LhfDT2cyBwhxVCjPi3DJ5g5DR8TE832Y4NgbNrbTvihNBz6
 vaK3yashNfIgz9Rrlkf4fe7jmpSS1Cfzix3BQ/HhM4H6zIegUZ61M0zZu
 cbSoA4ZnGXyempVSWsbq1T8qcNxxHDf3AiKoMZE2lbDbcAA/AkMoIjtjZ
 57wYmsCIWCK7zpURtJFDxX2zFIZHIWlF4Clb/kuloXyvVhfHini6SJBaG
 43oLV47CNygJUJZM73u3VX9jZ/G1SwUgLLVSQINtc+gnM+AWV0cwZHq1z
 jrvFVH4NdWIRDWHgJyBKzMBbQhEHujKrIiOcN7yh7E+eAbtL9g2YXvI85 Q==;
X-CSE-ConnectionGUID: FQG7ndMCScS+XLVGmKNKVA==
X-CSE-MsgGUID: FYN7bf8DQ5ilwdwFtxj9Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83225253"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83225253"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:01:52 -0700
X-CSE-ConnectionGUID: VXZ8aWpWSUWc8y8bl8sdiQ==
X-CSE-MsgGUID: cSDm9i5bQ5S9YJ5neCK6qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280908016"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 07:01:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 0/6] IPC fixes
Date: Thu, 25 Jun 2026 15:01:42 +0100
Message-ID: <cover.1782395581.git.anatoly.burakov@intel.com>
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

 lib/eal/common/eal_common_proc.c | 133 +++++++++++++++++++++++--------
 1 file changed, 99 insertions(+), 34 deletions(-)

-- 
2.47.3

