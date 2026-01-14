Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72008D31A29
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 09:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B84A4066A;
	Wed, 14 Jan 2026 10:32:49 +0100 (CET)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id 208F640667
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:46 +0100 (CET)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R12" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4drgrZ2gYCz3pxL;
 Wed, 14 Jan 2026 09:32:46 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R12" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4drgrZ1JK7z3YhK;
 Wed, 14 Jan 2026 09:32:46 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1768383166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/LnmQIRWRt2AnNWH1H6vIW10dk4U8COTSf0RWDl9jI=;
 b=qyayxGQlZ+JoJgDem0eS139E9BVCRJq06mvjFwBxIvZFmzUmPKojaMNv6wVW8UIU6PJF7n
 6i4nKxtxPJEoyWgyu/1om6qlJVz7OUUGNAFjfUIn+o90biN9QLNK95ZtdfG6XyoSAmYteH
 vfonIdnLDdJ0lNmjPr7x9zjSMSbP537EzhVXO+D428YL/GClr6TwHybpXb91K4xUbdyV3d
 wX27JgafWnFe9rJXH0lWg4KcAZVKn5ieoc5w1s6u17uYicKb/aKXCLnDTXSe+VmfyyGc+Y
 BA+jEXnp+wMDzWrmcJG8X0EXME5HxQQVQryVCfOni8FXE8aXBMpWbEhatpdovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1768383166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/LnmQIRWRt2AnNWH1H6vIW10dk4U8COTSf0RWDl9jI=;
 b=SFjqGyDLK9O5ennVhyON+sgCfTWXwfHylQfm+cZ8hiUnF9KbxpvpbnCK603wQ7wcsu5G61
 dK1eOQzEd1x6roGXYK0Mel7RNv5waOkVOIOUyWYQWz6jwz3AFe+N6L0Rxy2HF4MRQDNK29
 VT+cCkAhooziDnC64nP73gUQ+bCA4fC2s1Dt2QBztq/uhcIrM32LXe5E/4jR81SHx6ncOn
 3qIZ7LMX6tWNHPQhXyBIOxALdBB8wAHHKGVxk+xLct5WlxPNlIpwJiHbTW2aPjlKqjkkfU
 /uZ2QC/ijwteT06lDQ/bNEz//4drks9yLzkjzysJ0iXllZyEEEHqaYPzLClpDw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1768383166; a=rsa-sha256; cv=none;
 b=W064+FQi9imbcF/KVr2VSyh2K880SpoNAaf4F/pBwC7tfAWmuO9EiUK4qTfuJnFr6ud4C+
 iqY0A0StpgKJYU3QujMGwSguNwU9hkOkM+PvJydIRJPEmjJH+R15kLFffODEn9V1xRQnYA
 8063o15t3bLwnXQraQRWns/o3ihz8XA80iCHzXBDJbVamlCWULAMTcu0t7QQP/7epVt+iU
 JJhKyVS/nl3fxAlXJOLvu4jfqD4HmOT7LJOPMpRiGJ+JOagpL9r6PjpDaio/3QNijp9jAw
 Ns+958zoTPB2S9J8DLBsLvC5bBRNc3Yjwf7QC6CveMJA69xNHU52zBTfIhTnyA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
Received: from x1c.netflix.com (unknown [IPv6:2607:fb10:2023::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4drgrW5vVqzsfF;
 Wed, 14 Jan 2026 09:32:43 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v3 2/3] eal/freebsd: avoid claiming memseg holes
Date: Wed, 14 Jan 2026 18:31:28 +0900
Message-ID: <20260114093140.3256584-3-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114093140.3256584-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20260114093140.3256584-1-jfree@FreeBSD.org>
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

When need_hole is false, memseg searches will only be done for a single
element. If the search starts at beginning of the list, an element that
was previously reserved as a hole may be wrongly claimed.

To avoid this, begin the search following the last used entry. This way,
we ignore all pre-existing holes.

Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
---
 lib/eal/freebsd/eal_memory.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 8c315d97d5..5790f095c9 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -143,6 +143,7 @@ rte_eal_hugepage_init(void)
 
 			for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS;
 					msl_idx++) {
+				int start_idx, num_elems;
 				bool empty, need_hole;
 				msl = &mcfg->memsegs[msl_idx];
 				arr = &msl->memseg_arr;
@@ -157,10 +158,22 @@ rte_eal_hugepage_init(void)
 				 * adjacent to current one.
 				 */
 				need_hole = !empty && !is_adjacent;
+				if (need_hole) {
+					start_idx = 0;
+					/* we need 1, plus hole */
+					num_elems = 2;
+				} else {
+					/* begin our search after the last used
+					 * element in the list, skipping over
+					 * any previously placed holes
+					 */
+					start_idx = rte_fbarray_find_prev_n_used(
+							arr, arr->len - 1, 1) + 1;
+					num_elems = 1;
+				}
 
-				/* we need 1, plus hole if not adjacent */
 				ms_idx = rte_fbarray_find_next_n_free(arr,
-						0, 1 + (need_hole ? 1 : 0));
+						start_idx, num_elems);
 
 				/* memseg list is full? */
 				if (ms_idx < 0)
-- 
2.51.0

