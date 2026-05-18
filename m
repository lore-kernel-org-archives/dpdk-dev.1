Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD0CD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 15:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0594B4060A;
	Mon, 18 May 2026 17:08:31 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 33F09402D9;
 Mon, 18 May 2026 17:08:30 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A424CEC0229;
 Mon, 18 May 2026 11:08:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 11:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779116909; x=
 1779203309; bh=tAOLN4IcYjQ6pJ5gpSX0aoCYT9FzTj64lrxzXcLgohI=; b=b
 cOQfpbIj78FP3UrqFET8HaDy4gujCebAkxx/+Xkf78v5DAF0Pypu58jASPJ543qu
 oGBOVjM7fiUHKNTBz+TIJyEEKJKVd7I/1KV3PIedV8YYsITW+ggxXdi36eAcQNZZ
 fgdj++TRGdil98LwhnYMH/o+0lFms5KuEKHn1WEqfSNbW14t1a15RbU8XTkPsVVv
 KOp26mW4juyuwJF4jrCN1xBaaX7mQJnZR/3zmpg8+5I2NmaK/YYkFimUvq0LL7w4
 nbKpaomrpaBhf+SX4/D89t9Y6GT5d2eJqA3iBIzVfG0aCxaOc55SH7Cd6pDPCILg
 rIh+gfL9Ia2E4m5sWuy1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779116909; x=1779203309; bh=t
 AOLN4IcYjQ6pJ5gpSX0aoCYT9FzTj64lrxzXcLgohI=; b=kELIaPBDGVXZDgAJu
 ZAYBEfE0ZnEPTqjzqnJ0g7WG+ObH/yIrznWtDVbE3AVqNWP6PPiy9veFfvV0SuRn
 6GxEwNn1S8bX/qMs8QLIkguytQis1S9tTWVkIDTIjtFCgu0A2WZ9B1WbxQcPtM+P
 u6peBHXWDflHOqa2XdP9nEd049LebvAgsMYUkQljD1XrCZ1Ac3OPoRbahSrB1jAi
 i9C4HB2nNqT9y+TseOFpZBPuiWqGPidCi6FTCNncO8ROCsYk0etq++P8Kh8XWbVn
 zaf1V+cs2uWBlYCrQOyN4eSenuq5gGBJOyIqymazTAkPO4uF7EMkE76Ws6Kz1VaM
 QmOKQ==
X-ME-Sender: <xms:bSsLah07MR5lomNknA4e4VShaNTCtAdR1LeSJvjF_xBptAktvDdpqQ>
 <xme:bSsLahCTyr6RG9Cb_a8qvaqZtFcVVHQtSFOlIC4vMYU7YbN6mT4NnwhA9IaMWQOhn
 _XL_UWdZKPfRSg0zVAfsrftzemYrALY1ofECeXNtIJWlaPFf22Q>
X-ME-Received: <xmr:bSsLatdFWgWDTcKVCATh7a5VB6aH4KmT9F_a4SZEi0tD5UcpXtdDWOmNHf74uVC_CAfPp7fl29FDndRdgPVUSwqFt5ycFxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeludelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:bSsLau4n1C2J2KIvktMZhN8MVYjLrGXVdfWgtLqafK0LGJ_xMgvDZw>
 <xmx:bSsLagUvYJvIL0G8KqHG-LHnP6ajIkZrHAZvGRUIPVyRR5qwE5QCwg>
 <xmx:bSsLat7yuyRIhJaGJha5_nHDOxBBNsTA6rCrt4LPZUweb9eLFdxcOA>
 <xmx:bSsLarqrV091jTL3pVk2eAr19zxq6NN8vTSj03xYW6EYHr1I63bHgg>
 <xmx:bSsLaikmPt338ampLFd-f8oAbaoqWeLARl5HsSUo1OB0LXqqyZRxRBhq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 11:08:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, stable@dpdk.org
Subject: [PATCH v2 1/2] spinlock: remove volatile qualifier
Date: Mon, 18 May 2026 17:07:35 +0200
Message-ID: <20260518150819.3332628-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504083714.2904729-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
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

When compiling with C++20 standard requirement (default in GCC 16),
the increment and decrement of volatile variables are rejected:

rte_spinlock.h:241:14: error:
	'++' expression of 'volatile'-qualified type is deprecated
rte_spinlock.h:252:21: error:
	'--' expression of 'volatile'-qualified type is deprecated
rte_spinlock.h:278:14: error:
	'++' expression of 'volatile'-qualified type is deprecated

The count field of rte_spinlock_recursive_t
does not need the volatile qualifier
because it is only accessed by the thread holding the lock,
which already provides the necessary memory ordering.

The user field can be accessed outside of the lock,
so it must handled as a C11 atomic variable.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
v1: drop volatile keyword
v2: make user an atomic variable
---
 lib/eal/include/generic/rte_spinlock.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index c907d4e45c..5d810b682a 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
  */
 typedef struct {
 	rte_spinlock_t sl; /**< the actual spinlock */
-	volatile int user; /**< core id using lock, -1 for unused */
-	volatile int count; /**< count of time this lock has been called */
+	RTE_ATOMIC(int) user; /**< core id using lock, -1 for unused */
+	int count; /**< count of time this lock has been called */
 } rte_spinlock_recursive_t;
 
 /**
@@ -215,7 +215,7 @@ typedef struct {
 static inline void rte_spinlock_recursive_init(rte_spinlock_recursive_t *slr)
 {
 	rte_spinlock_init(&slr->sl);
-	slr->user = -1;
+	rte_atomic_store_explicit(&slr->user, -1, rte_memory_order_relaxed);
 	slr->count = 0;
 }
 
@@ -230,9 +230,9 @@ static inline void rte_spinlock_recursive_lock(rte_spinlock_recursive_t *slr)
 {
 	int id = rte_gettid();
 
-	if (slr->user != id) {
+	if (rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) != id) {
 		rte_spinlock_lock(&slr->sl);
-		slr->user = id;
+		rte_atomic_store_explicit(&slr->user, id, rte_memory_order_relaxed);
 	}
 	slr->count++;
 }
@@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
 	__rte_no_thread_safety_analysis
 {
 	if (--(slr->count) == 0) {
-		slr->user = -1;
+		rte_atomic_store_explicit(&slr->user, -1, rte_memory_order_relaxed);
 		rte_spinlock_unlock(&slr->sl);
 	}
-
 }
 
 /**
@@ -266,10 +265,10 @@ static inline int rte_spinlock_recursive_trylock(rte_spinlock_recursive_t *slr)
 {
 	int id = rte_gettid();
 
-	if (slr->user != id) {
+	if (rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) != id) {
 		if (rte_spinlock_trylock(&slr->sl) == 0)
 			return 0;
-		slr->user = id;
+		rte_atomic_store_explicit(&slr->user, id, rte_memory_order_relaxed);
 	}
 	slr->count++;
 	return 1;
-- 
2.54.0

