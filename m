Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30522CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A32A402D7;
	Thu, 14 Aug 2025 23:32:57 +0200 (CEST)
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
 by mails.dpdk.org (Postfix) with ESMTP id AF53F400EF
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:32:55 +0200 (CEST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4c2z4736FSz3TBt;
 Thu, 14 Aug 2025 21:32:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4c2z471RTMz49w8;
 Thu, 14 Aug 2025 21:32:55 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1755207175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmX9RCyNKtGMwBz8nXaad5mBrG1/fHi2Esthf7HMnkE=;
 b=AqEKX8lBDmb0+brbOpbfWMhSvNYgiPkWPhLsxB6B0uveZdz8s0lflS0EKFJfdjGqwPT5Xd
 xoiuPVRcaBranWTfeLhUadaf+MDW9WZYtXW421YVxKtWHUK4tNa8hSZtbNQCyktPADHzaa
 vT0dOeu/df4i+IY3toFEbskoYfAix39KqTHHFB46GHghLm7HJ2AjVdWkjNOx/PXqXhffrV
 yZhvvE9CkJY7WaJQEfC0P+opQIHCMYS7+F4fT6LfmYsyBIrQSOkJe1ULWZX4D949TczaOn
 fmFeIrzc8QDEM/slY0Y8AC/Tr9XUBJB18NPl+uqYb1Dqd1U0ATQg4Sn99S92Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1755207175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmX9RCyNKtGMwBz8nXaad5mBrG1/fHi2Esthf7HMnkE=;
 b=mTA4RFGiaY89OfkJ6MTLaziDF2uogfrWYH/Q5g38eApVowrixL77WC5Btw9FRxIxRjfd11
 7ZCWB7ykCMxFLbdPtIVp9wxnB7x/tMZPpn3BON2GsqXyukgTm2/i3uonY3OOXSQx8fZWvE
 +nK431sZAzHPFb89dl4nXEV/8jmXwuu9rvxNfIIfzSdx0EUCx2LBCWDf4K4lwGeRCVrLec
 Jl+D0h7tReTLstgxbJq9jor4ycbeBqE/XxnBkkTtqx7OLUKJB4x2o4ZmWjC42hf+fWRI2T
 xsqyVddzvuBEiLYgTRLsSxAEHcF0OfoXZEEqKK5rqPXtvJslhV6/je2QCxLypA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1755207175; a=rsa-sha256; cv=none;
 b=Ic9he3V8HajItCrRSMhcW7tp96B2TkGUuYaTMQszLPwgfYVfRE0KFCk9EvaDGN6CX0sD2v
 lwZSufdXu0BnoFQTsZehEZ+vkwgPrjaiMaQOoZTIaJQm1DRClbYB0Am+Usat49kjYYcO/e
 h3IQvwq5jAL4vaFq3O4ZdNo7if+54AXNud4dYStWQUzxWyRlsvJrdkZIAZWaZn4fFgxvet
 bX/3ZZiGZx0WPWQZrss1egGRu8YUUToLLtXtFuXbGnF98SM7ct/iXt9dESQE8DsHkg3WpE
 qjPq9fM/BMLtRzqKzDAyKtprDVduzJZ7w6jmK1X+90gTbrEUtTYXhUEE+dRQ0Q==
Received: from s1.pct.niksun.com (70-59-118-59.mpls.qwest.net [70.59.118.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate) (Authenticated sender: jfree)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4c2z4661LXzQnp;
 Thu, 14 Aug 2025 21:32:54 +0000 (UTC)
 (envelope-from jfree@FreeBSD.org)
From: Jake Freeland <jfree@FreeBSD.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Jake Freeland <jfree@FreeBSD.org>,
	dev@dpdk.org
Subject: [PATCH v2 2/3] eal/freebsd: Avoid claiming memseg holes
Date: Thu, 14 Aug 2025 16:32:44 -0500
Message-ID: <20250814213246.4141803-3-jfree@FreeBSD.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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
 lib/eal/freebsd/eal_memory.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index be3bde2cb9..b159e9ef4e 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -143,6 +143,7 @@ rte_eal_hugepage_init(void)
 
 			for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS;
 					msl_idx++) {
+				int start_idx, num_elems;
 				bool empty, need_hole;
 				msl = &mcfg->memsegs[msl_idx];
 				arr = &msl->memseg_arr;
@@ -157,10 +158,24 @@ rte_eal_hugepage_init(void)
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
+					if (start_idx < 0)
+						start_idx = 0;
+					num_elems = 1;
+				}
 
-				/* we need 1, plus hole if not adjacent */
 				ms_idx = rte_fbarray_find_next_n_free(arr,
-						0, 1 + (need_hole ? 1 : 0));
+						start_idx, num_elems);
 
 				/* memseg list is full? */
 				if (ms_idx < 0)
-- 
2.47.2

