Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C6C282C6
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 02:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6440940281;
	Sat,  1 Mar 2025 03:26:26 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0A62D4025D
 for <dev@dpdk.org>; Sat,  1 Mar 2025 03:26:24 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0360E2038A24; Fri, 28 Feb 2025 18:26:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0360E2038A24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740795983;
 bh=xwQz3dX1VBEzT+3pkUe1HRRsrDf0NcZN5iuycicYg5k=;
 h=Date:From:To:Subject:From;
 b=dkH57UrcphaVP7T0813tGnekLnyyFDXI/qwgbj4fbmRUMLQR2VbyyryRJELz6Ttok
 7IhyeQR5J+guUtHxr2i1wJYoXkNiigXKXDoLUvrjrkmd8nRCfepz1ihqkITryeM/kg
 sHXQWR5AhNixGDDZe+iSR0XcG7dybnIkdVQ0QpqQ=
Date: Fri, 28 Feb 2025 18:26:22 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: honnappa.nagarahalli@arm.com;, dev@dpdk.org
Subject: Segfault in rcu
Message-ID: <20250301022622.GA6940@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
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

Hi,

Are there known issues with rcu lib?
I tried to remove the VLA from it by calling alloca() and gcc 14.2 on Linux immediately complains about "array subscript outside array bounds".

$ ninja -C build
ninja: Entering directory `build'
[1/144] Compiling C object lib/librte_rcu.a.p/rcu_rte_rcu_qsbr.c.o
In file included from ../lib/ring/rte_ring_elem.h:20,
                 from ../lib/rcu/rte_rcu_qsbr.c:17:
In function ‘__rte_ring_dequeue_elems_32’,
    inlined from ‘__rte_ring_do_dequeue_elems’ at ../lib/ring/rte_ring_elem_pvt.h:289:3,
    inlined from ‘__rte_ring_dequeue_elems’ at ../lib/ring/rte_ring_elem_pvt.h:298:2,
    inlined from ‘__rte_ring_do_dequeue_start’ at ../lib/ring/rte_ring_peek_elem_pvt.h:172:3,
    inlined from ‘rte_ring_dequeue_bulk_elem_start’ at ../lib/ring/rte_ring_peek.h:237:9,
    inlined from ‘rte_rcu_qsbr_dq_reclaim’ at ../lib/rcu/rte_rcu_qsbr.c:392:4:
../lib/ring/rte_ring_elem_pvt.h:176:36: warning: array subscript 2 is outside array bounds of ‘char[8]’ [-Warray-bounds=]
  176 |                         obj[i + 2] = ring[idx + 2];
      |                         ~~~~~~~~~~~^~~~~~~~~~~~~~~


If I stubbornly ignore the warning and run the test, rcu_qsbr_autotest segfaults (no surprise given the previous warning).
Wondering if somebody more familiar with that code would like to take a look.

These were the only changes I had made, on latest main (commit fab31a03ba98e7457284df95dd9eef2223a4ccaa)

$ cat 0001-rcu.patch 
From dc7776a7b918cd96ffce62dd3bfaca85fc449d1b Mon Sep 17 00:00:00 2001
From: Andre Muezerie <andremue@linux.microsoft.com>
Date: Fri, 28 Feb 2025 21:05:25 -0500
Subject: [PATCH] rcu

---
 lib/rcu/rte_rcu_qsbr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rcu/rte_rcu_qsbr.c b/lib/rcu/rte_rcu_qsbr.c
index dbf31501a6..65037d0217 100644
--- a/lib/rcu/rte_rcu_qsbr.c
+++ b/lib/rcu/rte_rcu_qsbr.c
@@ -323,7 +323,7 @@ int rte_rcu_qsbr_dq_enqueue(struct rte_rcu_qsbr_dq *dq, void *e)
 		return 1;
 	}
 
-	char data[dq->esize];
+	char *data = alloca(dq->esize);
 	dq_elem = (__rte_rcu_qsbr_dq_elem_t *)data;
 	/* Start the grace period */
 	dq_elem->token = rte_rcu_qsbr_start(dq->v);
@@ -386,7 +386,7 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 
 	cnt = 0;
 
-	char data[dq->esize];
+	char *data = alloca(dq->esize);
 	/* Check reader threads quiescent state and reclaim resources */
 	while (cnt < n &&
 		rte_ring_dequeue_bulk_elem_start(dq->r, &data,
-- 
2.34.1

Thanks,

Andre Muezerie
