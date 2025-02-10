Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F54FC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75116402C2;
	Mon, 10 Feb 2025 22:32:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A34F8402A4
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739223130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhU+qpXa9ggestNwULJamSia+HmJ5JGG2hoDDqburII=;
 b=E5n8kxDfEF9TybzRA2gFWzPwHopr4D9NxiUNh9HAw2K0c8BCFSgW0KVo/rCvR/VIkzuVp0
 ZTHQayJATvYToPZ3GVuIMNrMloDyhKNeJ2ki2/mb++QeE4cLAF+0t4qMc/ad5w8UwK93LA
 xjY6KXpIvefA0sQNckPvVXlpeB4Y8CY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-PBuItbXDOySbC0PXKw0fQA-1; Mon,
 10 Feb 2025 16:32:06 -0500
X-MC-Unique: PBuItbXDOySbC0PXKw0fQA-1
X-Mimecast-MFC-AGG-ID: PBuItbXDOySbC0PXKw0fQA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7880A1801A1B; Mon, 10 Feb 2025 21:32:05 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04B901800115; Mon, 10 Feb 2025 21:32:02 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, frode.nordahl@canonical.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com
Subject: [PATCH v3 0/5] Defer lcore variables allocation
Date: Mon, 10 Feb 2025 22:31:53 +0100
Message-ID: <20250210213158.4165701-1-david.marchand@redhat.com>
In-Reply-To: <20241205175754.1673888-1-david.marchand@redhat.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tepTbsPWphU2Fj3z5pcEqKVbbKpK0jTsVou1XnNjXiM_1739223125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

As I had reported in 24.11-rc2, the lcore variables allocation have a
noticeable impact on applications consuming DPDK, even when such
applications does not use DPDK, or use features associated to
some lcore variables.

While the amount has been reduced in a rush before rc2,
there are still cases when the increased memory footprint is noticed
like in scaling tests.
See https://bugs.launchpad.net/ubuntu/+source/dpdk/+bug/2090931


lcore variable allocations in constructor is a bad idea, as the
application consuming DPDK has no control over such allocation:
linking some code does not mean that all of it will be used at runtime.

The general question on whether lcore variables in constructor should
be forbidden, is left to a later discussion.

For now, this series only focus on fixing subsystems using lcore
variables so that those allocations are deferred either in rte_eal_init()
or in the path that does require such lcore variables.


-- 
David Marchand

Changes since v2:
- added assert in rte_s?rand(),

Changes since v1:
- added a check on lcore handle,
- fixed lcore variable size in lib/power,
- renamed/introduced allocation helpers,


David Marchand (5):
  eal: check lcore variable handle
  random: defer seeding to EAL init
  power: defer lcore variable allocation
  power: reduce memory footprint of per-lcore state
  eal/x86: defer power intrinsics variable allocation

 lib/eal/common/eal_private.h       |  6 ++++++
 lib/eal/common/rte_random.c        | 12 +++++++++---
 lib/eal/freebsd/eal.c              |  2 ++
 lib/eal/include/rte_lcore_var.h    |  2 ++
 lib/eal/linux/eal.c                |  2 ++
 lib/eal/windows/eal.c              |  2 ++
 lib/eal/x86/rte_power_intrinsics.c | 15 +++++++++++++--
 lib/power/rte_power_pmd_mgmt.c     | 29 ++++++++++++++++++++---------
 8 files changed, 56 insertions(+), 14 deletions(-)

-- 
2.48.1

