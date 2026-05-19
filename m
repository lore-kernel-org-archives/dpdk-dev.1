Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DDCD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 10:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47CE14066E;
	Tue, 19 May 2026 12:36:56 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B48FB4065F;
 Tue, 19 May 2026 12:36:54 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 11FC51D000E6;
 Tue, 19 May 2026 06:36:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 06:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779187013; x=
 1779273413; bh=YxUwHYa7Z2hJOxxoA5EPwzfOHB8ZgANgBV6hz6qBVUY=; b=h
 ZE1C3xkm06ThpT2xWYxe7R+2leWp/1lfIHQ7BV6UoJBw38oabtjo7C8ekSIAROZW
 lzh/hqvllumWZUPubMAM0aDWetfKlx8FicJOZowOXGRNMjav9GySOZuKs6ZXsUTt
 6HxzttcutP4wNmU0ufFfnztSx2xhX3T+1y7RHlH4vNHSGCCr3KT9IYa7MJCPvwst
 Tynxj1uzYHOtUgoX+k6xxurO3h/snJxwqGHZqg6XtX9OMu8+90llp8tprGeFP+r4
 ge98QGyk3ecPujo9PhjhzgtRUxO/XU19Cl066TuGAmcx0yO3mvTD4s4eWlCPdfMp
 aUxiE6KlJSz3+leS6bvIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779187013; x=1779273413; bh=Y
 xUwHYa7Z2hJOxxoA5EPwzfOHB8ZgANgBV6hz6qBVUY=; b=aJeNf4BV9LBz6s0Sr
 tIs4DNpSLXIcWSNHM3y1e/hZpnGCDeOf27POu9IHrAEznaOdI3TB3jrJkD3OWFdz
 lcaWezn99uGdmw5dOIs5P+Gw0hn0fpJxLhKxzZe4rIXqMQ1CDXg433xbPBCp3umy
 xFT3hDitJJ7AjhctX+WA4/7WVE6dtxqWB6B60ZyJqkto2uNt+5LGJ071Wnf7+Baf
 mJPWt1LnLmYEoaEPGEgVzmLseb1lIK2jzLh9Whvb0CFtBHiX5rBVTLGtFuCVZgPM
 6+p9calwwNKW59Sg0yNsveHVHTRYBMMe1YgTKFlLCdHZ7wFQUg6GbPpL/RqW9g0z
 ID0Qg==
X-ME-Sender: <xms:RT0Map902cfv5ohHVqfQvT3qzZ4BkbtWwOg9sNZoAaksGIytbGEUMg>
 <xme:RT0ManzhPi2f7mSq6xjgxddNpmzF4ceMMgna_fhGYZsXeXBiW146KZoyafbfJlcXd
 lWTTgYAPZdFI7iup5YWWhmse7YWD2EPnzWqMn-cH6ZbezchliIqYA>
X-ME-Received: <xmr:RT0Mam7FhZy7etzdzvE7fZqlqPpxDifkl02rlKcjyWrgmrNlcG1m3rycTIDVroitzo2iLUk0cOtSIMj1kltVnfpymmb7oxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhgpdhrtghpthhtoheptghunhhmihhnghdrlhhirghnghesihhnthgv
 lhdrtghomhdprhgtphhtthhopeholhhivhhivghrrdhmrghtiiesieifihhnugdrtghomh
X-ME-Proxy: <xmx:RT0Mau_eJsi4_v36hl95aLVj6O7QoP2mqoQb81txp-W9pMP51oXvmg>
 <xmx:RT0MarpjuH58nzMhSqgYkCPfbIWGPD_CKhRKuNagYjMioJdY8TRsMA>
 <xmx:RT0MavqvfE6SUsDKadKjXAI7RdG_O_YhRPnlMJ7rVuPZ63HNT05TnQ>
 <xmx:RT0Mau0X6J-UEfWJGDnUK_cmPB5KZyvqbICD8rluCAxjfV1QzwHRJA>
 <xmx:RT0Mai9ZYMKsmugr3XIDprV3ibVdn7zNmYhDQGXedy3lFosKWzYRvAvk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 06:36:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, stable@dpdk.org,
 Cunming Liang <cunming.liang@intel.com>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [PATCH v3 3/3] spinlock: fix API comments
Date: Tue, 19 May 2026 12:34:16 +0200
Message-ID: <20260519103640.3986710-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103640.3986710-1-thomas@monjalon.net>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
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

This is not a read-write lock.

The user field stores the thread ID, not the core ID
since a change in DPDK 2.0.0.

The implementation is architecture-specific in some cases only.

Fixes: ca2e2dab079a ("spinlock: support non-EAL thread")
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/include/generic/rte_spinlock.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index e7cd18a8e2..dd3d2d046c 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -7,12 +7,16 @@
 
 /**
  * @file
+ * DPDK spinlocks
  *
- * RTE Spinlocks
+ * This is an API for spinlocks.
+ * This kind of lock simply waits in a loop
+ * repeatedly checking until the lock becomes available.
  *
- * This file defines an API for read-write locks, which are implemented
- * in an architecture-specific way. This kind of lock simply waits in
- * a loop repeatedly checking until the lock becomes available.
+ * Some functions may have an architecture-specific implementation
+ * if RTE_FORCE_INTRINSICS is disabled.
+ * The hardware transactional memory (lock elision) functions have _tm suffix
+ * and are implemented in architecture-specific files.
  *
  * All locks must be initialised before use, and only initialised once.
  */
@@ -198,7 +202,7 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
  */
 typedef struct {
 	rte_spinlock_t sl; /**< the actual spinlock */
-	RTE_ATOMIC(int) owner; /**< core id using lock, -1 for unused */
+	RTE_ATOMIC(int) owner; /**< thread id owning lock, -1 for unused */
 	int count; /**< count of time this lock has been called */
 } rte_spinlock_recursive_t;
 
-- 
2.54.0

