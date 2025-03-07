Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2EFC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 01:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CC5840A81;
	Fri,  7 Mar 2025 02:40:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DBEA640A75
 for <dev@dpdk.org>; Fri,  7 Mar 2025 02:40:19 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 000D4211049F; Thu,  6 Mar 2025 17:40:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 000D4211049F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741311619;
 bh=WrqYfN8gGGf/wbDPuBeZudE8jfHTlmilIcx6ojWRKSw=;
 h=From:To:Cc:Subject:Date:From;
 b=Eta7fpmxyB2xS1S0gHQCxEr9eRQ9t4KKUi/RUBC9Qa+GNaNXELEgdw8ouD4eNOqA2
 SsB/YnQdib88Z8ag0APj0HB1k6/DJfqjjjCmGEXpQUtYQBlUjL7iN9SvshZlPNBF2j
 Ta9/MjT+se35+1KiBHeNFyoQVFmUlecu2v9M68kE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] rcu: remove VLAs
Date: Thu,  6 Mar 2025 17:40:12 -0800
Message-Id: <1741311613-26629-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

There are two lines that were using VLAs, which are not supported by
MSVC.

1)
../lib/rcu/rte_rcu_qsbr.c:326:12: warning: variable length array used [-Wvla]
  326 |         char data[dq->esize];
      |                   ^~~~~~~~~
2)
../lib/rcu/rte_rcu_qsbr.c:389:12: warning: variable length array used [-Wvla]
  389 |         char data[dq->esize];
      |                   ^~~~~~~~~

The short-term fix is to use alloca, to allow progress with the msvc
compatibility work.
The long-term plan involves API changes and therefore can only be applied
with a new release. This long-term plan consists of introducing some
reasonable limitation on RCU DQ element size.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/rcu/meson.build    | 7 -------
 lib/rcu/rte_rcu_qsbr.c | 6 +++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/lib/rcu/meson.build b/lib/rcu/meson.build
index fb1f49ba63..71143f5210 100644
--- a/lib/rcu/meson.build
+++ b/lib/rcu/meson.build
@@ -11,10 +11,3 @@ sources = files('rte_rcu_qsbr.c')
 headers = files('rte_rcu_qsbr.h')
 
 deps += ['ring']
-
-# FIXME: this library was enabled for mingw target (a Windows target).
-# Relying on no_wvla_cflag would trigger a build error until the VLA in rte_rcu_qsbr.c is removed.
-# Disable the warning here for now.
-if cc.has_argument('-Wvla')
-    cflags += '-Wno-vla'
-endif
diff --git a/lib/rcu/rte_rcu_qsbr.c b/lib/rcu/rte_rcu_qsbr.c
index dbf31501a6..3f619e1607 100644
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
@@ -386,10 +386,10 @@ rte_rcu_qsbr_dq_reclaim(struct rte_rcu_qsbr_dq *dq, unsigned int n,
 
 	cnt = 0;
 
-	char data[dq->esize];
+	char *data = alloca(dq->esize);
 	/* Check reader threads quiescent state and reclaim resources */
 	while (cnt < n &&
-		rte_ring_dequeue_bulk_elem_start(dq->r, &data,
+		rte_ring_dequeue_bulk_elem_start(dq->r, data,
 					dq->esize, 1, available) != 0) {
 		dq_elem = (__rte_rcu_qsbr_dq_elem_t *)data;
 
-- 
2.48.1.vfs.0.0

