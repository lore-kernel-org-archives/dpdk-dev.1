Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9627C79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 20:20:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC73F427E6;
	Fri,  4 Sep 2026 22:20:44 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id A9F69427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 22:20:43 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso11307205ad.3
 for <dev@dpdk.org>; Fri, 04 Sep 2026 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788553242;
 x=1789158042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWgXtypDDRMlYa5MVp/9X3Giea4RX9mng98UZ6izUhE=;
 b=l0b7JjgjzyJ//gq3dBbWRDqRseDpWWdtYQRxGZsApIQWJ57w5M9Cl0qZjSTdCsASgq
 ZQ+PVzXBOHXDrKQmI7VBnHcachHuXzwmoktTgrDdNQv+acKruub3q3Mo6EauzJzdVSae
 7lemtn/lfDrgKjvmJbCRSKq6B2RHWwN4Kwpz7JOhxIKCU2OZEyn04a9n5U3itPWimGxf
 nf8Qp67zY114Uz2nu7jiib5ju1fbKW13f9d3Bnhm1CALwEllWBxXMncmH+0UNX6DY7NX
 2Oj2idQC3f+IrbSDFzdXka3m22AxdKeaV7+vQCTBMM0w6GM7OVOP5YSSAp+J6YhqFn8R
 YQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788553242; x=1789158042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWgXtypDDRMlYa5MVp/9X3Giea4RX9mng98UZ6izUhE=;
 b=q1HBVspysYtuAjW8rJBP7jy5sJnb0i1aJcePEMte06EhaKO/2NFKCEBoT2AFkCjUE6
 6scvm3NTlz0jxQFaqz+om+k5fAECjt6ygaOR14a2pBWzwy1usH/5VVmIEaNsXqVVtnx+
 dLd9FDibAXtwfdBcuyyz6fccHNNPJXHXXUt/Ct+/NVqfDU+rhpnWg2YfyvQiGc6p0O+D
 oCsJGWaedYAYMOM42bwooULCWFkHNoIRP5tEMt1Xmw+5sgGTh+fAFKdkUzySg4M8QCv0
 EM982WSKJlwZvYEk0aSC/2EqbLu1hBfhVOPmb/SdU4+J+76As2ovv5YVoToUM02mZeA1
 hEjQ==
X-Gm-Message-State: AFuF++lEz2a7QMVayKHYprKXnXe3eiglortdl4EdZ17uonmEbNjftKRP
 pypgDzpaFReQmn9i7SLPsx8Doyaf32eh20X+IEqARK+D4A6zXEnto+wZiTLOdeA9BnlZ1Ikblza
 hxeRW
X-Gm-Gg: AYBFou3AhPCMB+ZnQs+CxiBiOQ9a9zmnVhaf0TokJgEci9F4VmYrZivWWAlqoYY0Q2l
 pB+9xpzJPU94MrgYVQwe2PCAz7P0xBJ3Jh40gxbqPA6YMzivNaE7C2bQrBPWYCDt77a+lsGBMaY
 VXGTvPgGY5f0WfOgWZUzkL7DyjkIruyyBwtKW4o0Bv1khjsodbyHMuBDl7MQeU5bwN3b3ybO5Yv
 4BeJHSxIQyhOYWUI5pmQAMAx9FP5QuWLwEt3jYkwFW4lskIaA+VzkVvV8HxqabxNQfF9Z3xroXS
 HC9ZVN//MWEmuzSuGsS71L8RgNIPpasx4WDT0iZu7B07GY8QdKq+WrCErBur8ReFsYXNkz+ll8r
 DiXZ7VG8m+2BlrJS1zUs+kuTOx0sYBwMGetxTk9cXnp4KKFWalF2RBWIeuqWUkzeEh/LpyM33qP
 GME9zsoMk4j9+hgWrmvwvYM2rAqC4jEIeSh/TrswoT41HXv89gYM2PN2TtvAOuk7VT2i9q6fVVB
 yyQEG418LOlNDqLgbfylfZVlCM=
X-Received: by 2002:a17:903:4685:b0:2ca:660:b1d with SMTP id
 d9443c01a7336-2db126d8c1bmr123070175ad.11.1788553242364; 
 Fri, 04 Sep 2026 13:20:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db14841eaasm13919665ad.8.2026.09.04.13.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:20:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Narcisa Vasile <navasile@linux.microsoft.com>
Subject: [PATCH] eal: fix alarm cancel list walk
Date: Fri,  4 Sep 2026 13:20:31 -0700
Message-ID: <20260904202031.2688530-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

All three implementations of rte_eal_alarm_cancel() free entries while
walking the alarm list with LIST_FOREACH, which leaves the iterator
pointing into freed memory.

Linux and FreeBSD use two loops: one draining matches from the head of
the list, then a LIST_FOREACH over the rest that frees the current
entry and assigns the saved ap_prev to ap so iteration resumes from the
predecessor.  ap_prev is only refreshed to a live entry by an iteration
that does not remove, and the head loop leaves it NULL when it empties
the list.  A removal in the second loop then sets ap to NULL or to an
already freed entry, and the LIST_FOREACH increment dereferences it.
GCC -fanalyzer reports the freed case:

  lib/eal/linux/eal_alarm.c:224:44: warning: use after 'free' of 'ap'
	[CWE-416] [-Wanalyzer-use-after-free]

Windows has no such dance: it calls alarm_remove_unsafe() straight from
the loop body, so the increment reads freed memory on every removal but
the last.

Replace all of these with LIST_FOREACH_SAFE.  FreeBSD sys/queue.h and
the bundled Windows sys/queue.h already provide it; glibc does not, so
define it locally as is already done in several drivers.

Fixes: af75078fece3 ("first public release")
Fixes: f4cbdbc7fbd2 ("eal/windows: implement alarm API")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/freebsd/eal_alarm.c | 41 +++++++------------------------------
 lib/eal/linux/eal_alarm.c   | 40 ++++++++++++------------------------
 lib/eal/windows/eal_alarm.c |  4 ++--
 3 files changed, 22 insertions(+), 63 deletions(-)

diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index c03e281e67..1585a651e9 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -264,7 +264,7 @@ RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
-	struct alarm_entry *ap, *ap_prev;
+	struct alarm_entry *ap, *ap_next;
 	int count = 0;
 	int err = 0;
 	int executing;
@@ -277,15 +277,12 @@ rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 	do {
 		executing = 0;
 		rte_spinlock_lock(&alarm_list_lk);
-		/* remove any matches at the start of the list */
-		while (1) {
-			ap = LIST_FIRST(&alarm_list);
-			if (ap == NULL)
-				break;
-			if (cb_fn != ap->cb_fn)
-				break;
-			if (cb_arg != ap->cb_arg && cb_arg != (void *) -1)
-				break;
+
+		LIST_FOREACH_SAFE(ap, &alarm_list, next, ap_next) {
+			if (cb_fn != ap->cb_fn ||
+					(cb_arg != (void *)-1 && cb_arg != ap->cb_arg))
+				continue;
+
 			if (ap->executing == 0) {
 				LIST_REMOVE(ap, next);
 				free(ap);
@@ -301,31 +298,7 @@ rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 					executing++;
 				else
 					err = EINPROGRESS;
-
-				break;
-			}
-		}
-		ap_prev = ap;
-
-		/* now go through list, removing entries not at start */
-		LIST_FOREACH(ap, &alarm_list, next) {
-			/* this won't be true first time through */
-			if (cb_fn == ap->cb_fn &&
-					(cb_arg == (void *)-1 ||
-					 cb_arg == ap->cb_arg)) {
-				if (ap->executing == 0) {
-					LIST_REMOVE(ap, next);
-					free(ap);
-					count++;
-					ap = ap_prev;
-				} else if (pthread_equal(ap->executing_id,
-							 pthread_self()) == 0) {
-					executing++;
-				} else {
-					err = EINPROGRESS;
-				}
 			}
-			ap_prev = ap;
 		}
 
 		rte_spinlock_unlock(&alarm_list_lk);
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index a1433eb867..eb41064851 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -25,6 +25,13 @@
 #define	TFD_NONBLOCK	O_NONBLOCK
 #endif
 
+#ifndef LIST_FOREACH_SAFE
+#define LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #define NS_PER_US 1000
 #define US_PER_MS 1000
 #define MS_PER_S 1000
@@ -206,7 +213,7 @@ RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
-	struct alarm_entry *ap, *ap_prev;
+	struct alarm_entry *ap, *ap_next;
 	int count = 0;
 	int err = 0;
 	int executing;
@@ -219,10 +226,11 @@ rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 	do {
 		executing = 0;
 		rte_spinlock_lock(&alarm_list_lk);
-		/* remove any matches at the start of the list */
-		while ((ap = LIST_FIRST(&alarm_list)) != NULL &&
-				cb_fn == ap->cb_fn &&
-				(cb_arg == (void *)-1 || cb_arg == ap->cb_arg)) {
+
+		LIST_FOREACH_SAFE(ap, &alarm_list, next, ap_next) {
+			if (cb_fn != ap->cb_fn ||
+					(cb_arg != (void *)-1 && cb_arg != ap->cb_arg))
+				continue;
 
 			if (ap->executing == 0) {
 				LIST_REMOVE(ap, next);
@@ -236,29 +244,7 @@ rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 					executing++;
 				else
 					err = EINPROGRESS;
-
-				break;
-			}
-		}
-		ap_prev = ap;
-
-		/* now go through list, removing entries not at start */
-		LIST_FOREACH(ap, &alarm_list, next) {
-			/* this won't be true first time through */
-			if (cb_fn == ap->cb_fn &&
-					(cb_arg == (void *)-1 || cb_arg == ap->cb_arg)) {
-
-				if (ap->executing == 0) {
-					LIST_REMOVE(ap, next);
-					free(ap);
-					count++;
-					ap = ap_prev;
-				} else if (pthread_equal(ap->executing_id, pthread_self()) == 0)
-					executing++;
-				else
-					err = EINPROGRESS;
 			}
-			ap_prev = ap;
 		}
 
 		rte_spinlock_unlock(&alarm_list_lk);
diff --git a/lib/eal/windows/eal_alarm.c b/lib/eal/windows/eal_alarm.c
index 0b11d331dc..ed6e7f2245 100644
--- a/lib/eal/windows/eal_alarm.c
+++ b/lib/eal/windows/eal_alarm.c
@@ -190,7 +190,7 @@ RTE_EXPORT_SYMBOL(rte_eal_alarm_cancel)
 int
 rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 {
-	struct alarm_entry *ap;
+	struct alarm_entry *ap, *ap_next;
 	unsigned int state;
 	int removed;
 	bool executing;
@@ -207,7 +207,7 @@ rte_eal_alarm_cancel(rte_eal_alarm_callback cb_fn, void *cb_arg)
 
 		rte_spinlock_lock(&alarm_lock);
 
-		LIST_FOREACH(ap, &alarm_list, next) {
+		LIST_FOREACH_SAFE(ap, &alarm_list, next, ap_next) {
 			if (!alarm_matches(ap, cb_fn, cb_arg))
 				continue;
 
-- 
2.53.0

