Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A292CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4241B40F16;
	Tue, 29 Sep 2026 02:21:36 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 4A94740EE2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:31 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2dd4b3c752fso20216695ad.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641290; x=1791246090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iACSyRrrvdNxL3m2MagtUhr3OYw/rDWFrqaWWuc8ZIc=;
 b=XdxxLVMwivCUTz307XzxmSq+PnzuigC11VzdZjYWcR+WSrvNmgDHCCekWtwaQGKcgP
 psPj9gVJwPiM7XOl1RVO1hJGvfTXjpEPZRSL6cXl1tQUA5cGPfAhtSR3y2c8iwGwF3ja
 nufIi9YBmeyuYHBh0+aqmEUoXP0KLEJ0rseHHRGAWRuUrSdN+8RskkZUmXzhQs03sXH4
 WXz6mDqvGXFkbj2zqXSBg6rAcTG5bulBgRqIs52qcUamtI1kAQj5OvZ6WbWcZwtSLdDK
 ZnhN/gaKbuTBLY/XrCiQvra8ku+PjfwxdL2DBCOzopvJJt+IOJIEZDOAsJLyEzd4S1l9
 iLwQ==
X-Gm-Message-State: AFq9FYLT8CUwj1R2ANvRERyx6H2PjAg9XPf1b3iQVtonBmZN5GA3S4PC
 wPwIBfoqIRPsHzQOMuZnv/0TKL8NYnan0QK396McGbk3AyGiwHBi4VJ8ncdQ0YDIc4HUew2rtDU
 P4Fi9S6uDJq+PZjdRvJ/x7nR3fDUoxaUOas/xHYPRxgHzX2d745v8H1d51V1Hpm79hMbuxA+z6P
 nQ6bxLpyr5k+FN90fC4GUCe3BPm/cgVeRsT/iZH3if3hTJ0DjpAl50GZWVb6nXDSsKnEnEmxY9K
 GGhyrvhPwq1
X-Gm-Gg: AYBFou2ffl0RbaWIleyblPZRWCYJsjthsV1GhQCJRZkK1+z1CQw/l0EJesq32dbJsr7
 ylfW2bSI/LwHvXgvn2gTQTOiMIrjSq4Xt9IM0pCj6VTaxru6WEoDX/4sVVEuduF/2QjeZREB+Ea
 +TElmwpwOO5/dJC0tVpaQ4yo1h+XL3dIVqYhqFJb1M7WJ/8WaFAnX7SKSSwB1LQzC8odiloMoRQ
 WuB+gEF+Ja+03auzhPOnkSOlYbbppDTYYcwrCWuEckuY34UuY+Q+WgLhRZNQNuJ1JrmrkaKrT+0
 pgRj8e9NDkSSxdBZc5oO7csxBazZHpa2RNFcvuQdyP3gE0w+Uo8MfIVG+DcoGUO/6DI9DdlqK5p
 H0j4N31Go1zA/KwDqRMmAgkeXUjlTNwLKdF9Ap3A6k6j67Wg1IsV1HXJRg2A3MkQHpVMg49pKj8
 v7GJAdMF36hwgRvHjGSY69soHHRLZUQNE5g6FIDiz4X2bviKcS3Mx9
X-Received: by 2002:a17:90b:4c03:b0:39e:6a82:afd6 with SMTP id
 98e67ed59e1d1-3a098feb5abmr12200305a91.40.1790641290086; 
 Mon, 28 Sep 2026 17:21:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a4983551f6sm645049a91.5.2026.09.28.17.21.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939f248907fso357068485a.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641288; x=1791246088; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iACSyRrrvdNxL3m2MagtUhr3OYw/rDWFrqaWWuc8ZIc=;
 b=Pu9Hspy9IiuCzH4/f+JnGskIP02xbxQGqgmyZ8WMBmBFUfdr1roqu+zUYm5XpHUUli
 QjSKQXC/1EPyittJlez4fU+78PUhAXdZplIGJfthFiZPBVK59D5vJlKPTlN/br9Groje
 z3pNTps3lPykRUGbz8At95BDBJrEOs7x+8uQs=
X-Received: by 2002:a05:620a:3190:b0:93b:d7a2:dd2e with SMTP id
 af79cd13be357-93c43d34647mr2315520185a.62.1790641288484; 
 Mon, 28 Sep 2026 17:21:28 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:93b:d7a2:dd2e with SMTP id
 af79cd13be357-93c43d34647mr2315516185a.62.1790641287921; 
 Mon, 28 Sep 2026 17:21:27 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813a5ae6sm273808385a.13.2026.09.28.17.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:27 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v3 3/5] net/bnxt: fix VNIC filter list walk stopping early
Date: Mon, 28 Sep 2026 18:24:22 -0600
Message-ID: <20260929002424.1208457-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

bnxt_clear_hwrm_vnic_filters() used STAILQ_FOREACH() to walk
vnic->filter, clearing and freeing each filter as it went. This is
not a use-after-free: bnxt_free_filter() never actually releases the
underlying memory, it memsets the filter object (clearing its next
link too) and returns it to bp->free_filter_list for reuse, so the
object stays live and mapped.

The real bug is that memset() zeroing the filter's next field means
STAILQ_FOREACH()'s own advance step sees a NULL next pointer after
the first filter is freed, so the loop silently stops after removing
just one filter. Every other filter still linked in vnic->filter is
leaked: its hardware entry is never cleared and the filter object
itself never makes it back onto bp->free_filter_list.

Walk the list with STAILQ_FOREACH_SAFE(), which captures each
filter's next pointer before the body runs, so the walk does not
depend on a freed-and-reused object's link field. Each filter is
still unlinked from vnic->filter with STAILQ_REMOVE_HEAD() before
being freed.

Fixes: 20ef524432dd ("net/bnxt: set L2 filters")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Retitled from "fix use-after-free in VNIC filter cleanup" and
  rewrote the description -- Stephen Hemminger pointed out
  bnxt_free_filter() frees nothing (it recycles the object onto
  bp->free_filter_list), so this was never a use-after-free; the real
  bug is the early-termination leak described above.
* Tried STAILQ_FOREACH_SAFE(), Stephen Hemminger's suggestion, but it
  is not portable to this build: glibc's sys/queue.h (used on Linux)
  has no STAILQ _SAFE variant, and DPDK's own RTE_TAILQ_FOREACH_SAFE()
  portability wrapper has no STAILQ counterpart either. Kept the
  STAILQ_FIRST()/STAILQ_REMOVE_HEAD() loop from v2, which is
  functionally equivalent for this always-drain-the-head pattern.

 drivers/net/bnxt/bnxt_hwrm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 45c11b58da..5b07142770 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -3591,9 +3591,10 @@ bnxt_clear_hwrm_vnic_filters(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	struct bnxt_filter_info *filter;
 	int rc = 0;
 
-	STAILQ_FOREACH(filter, &vnic->filter, next) {
+	while (!STAILQ_EMPTY(&vnic->filter)) {
+		filter = STAILQ_FIRST(&vnic->filter);
 		rc = bnxt_clear_one_vnic_filter(bp, filter);
-		STAILQ_REMOVE(&vnic->filter, filter, bnxt_filter_info, next);
+		STAILQ_REMOVE_HEAD(&vnic->filter, next);
 		bnxt_free_filter(bp, filter);
 	}
 	return rc;
-- 
2.47.3

