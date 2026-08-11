Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A370C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 12:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 082B340E1F;
	Tue, 11 Aug 2026 14:17:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 505864027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 14:17:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0610822827
 for <dev@dpdk.org>; Tue, 11 Aug 2026 14:17:34 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 11 Aug 2026 14:17:33 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] stack: improve source code readability
Date: Tue, 11 Aug 2026 12:17:27 +0000
Message-ID: <20260811121727.1706225-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Aug 2026 12:17:33.0745 (UTC)
 FILETIME=[637F1A10:01DD298B]
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

Fixed misleading local variable names in the standard stack,
for improved source code readability.
No functional change.

Fixes: 05d3b5283cc1 ("stack: introduce stack library")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
No need to backport.
---
 lib/stack/rte_stack_std.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/stack/rte_stack_std.h b/lib/stack/rte_stack_std.h
index ae28add5c4..d5b21defb0 100644
--- a/lib/stack/rte_stack_std.h
+++ b/lib/stack/rte_stack_std.h
@@ -25,20 +25,20 @@ __rte_stack_std_push(struct rte_stack *s, void * const *obj_table,
 {
 	struct rte_stack_std *stack = &s->stack_std;
 	unsigned int index;
-	void **cache_objs;
+	void **stack_objs;
 
 	rte_spinlock_lock(&stack->lock);
-	cache_objs = &stack->objs[stack->len];
+	stack_objs = &stack->objs[stack->len];
 
-	/* Is there sufficient space in the stack? */
-	if ((stack->len + n) > s->capacity) {
+	if (unlikely((stack->len + n) > s->capacity)) {
+		/* Insufficient space in the stack. */
 		rte_spinlock_unlock(&stack->lock);
 		return 0;
 	}
 
-	/* Add elements back into the cache */
+	/* Push objects to the stack */
 	for (index = 0; index < n; ++index, obj_table++)
-		cache_objs[index] = *obj_table;
+		stack_objs[index] = *obj_table;
 
 	stack->len += n;
 
@@ -63,20 +63,22 @@ __rte_stack_std_pop(struct rte_stack *s, void **obj_table, unsigned int n)
 {
 	struct rte_stack_std *stack = &s->stack_std;
 	unsigned int index, len;
-	void **cache_objs;
+	void **stack_objs;
 
 	rte_spinlock_lock(&stack->lock);
 
 	if (unlikely(n > stack->len)) {
+		/* Insufficient objects in the stack. */
 		rte_spinlock_unlock(&stack->lock);
 		return 0;
 	}
 
-	cache_objs = stack->objs;
+	stack_objs = stack->objs;
 
+	/* Pop objects from the stack */
 	for (index = 0, len = stack->len - 1; index < n;
 			++index, len--, obj_table++)
-		*obj_table = cache_objs[len];
+		*obj_table = stack_objs[len];
 
 	stack->len -= n;
 	rte_spinlock_unlock(&stack->lock);
-- 
2.43.0

