Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFBCA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0993D40E5A;
	Tue, 29 Sep 2026 02:20:52 +0200 (CEST)
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com
 [209.85.222.99]) by mails.dpdk.org (Postfix) with ESMTP id B1BAF40E54
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:20:50 +0200 (CEST)
Received: by mail-ua1-f99.google.com with SMTP id
 a1e0cc1a2514c-98076bb236eso1083763241.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641250; x=1791246050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9c3N+bNl0hhST++IX7sKKiBTLVGZMDZJPu6zY4JGBLE=;
 b=wp1jGls2L6UyF8+sfJ9NGg+m4nacC9q7HgqL7SkPcv9MYnWIGweLrLElm+huPr0dek
 9cONpJaeBry8CTjakf+xWvbBa1+8PwiRhNxxdJXg7xhgMGDPNFp5aoHCgltZtihBpp/0
 /NhP8wRGT73NrOTFOzBrjq9FP0CyLZIOd0BdzeHl4ZtxXjlXkVU6B7iSNh0jJEcQfWvT
 weu6QDkI78HT9QcqQiCwsoYWi6Q5+QRhwl5/3g7Jhjg5VYX7UfbrAuoXDZvsLtj6/dnv
 ezwvWc3Y1HJqeXHg9kFGsQ6ykct1Kixkx925GqBnTCD2FNwUZUQpsQHSqnU+XggAiSWM
 2aDw==
X-Gm-Message-State: AFq9FYKbSplfajE1OoWw872gCGpxSEhLs+ulra+axXVBbutuhM7f8QGM
 xMyn2KqaxpnU5h3s6Xb0yoaa4M5mLn9mngVm8gROyefVxNuXr5BhdOfTjUBHG/oTn6AEy07HjWf
 YHoN397fKEmX/ZiNcMj10gG5h+AjreoiltJ+rrLeBeJATOZxNZqIfwlPqHWiiezk8rJkc6kJswG
 KkgVDMTyO/NqZ7lxdesdm4uTrcsVF8GiTF1PVrBnd2/+wLFTWRRw5ef3ucAnYVE+p57oQ833Qwx
 n4DQbUtaV3y
X-Gm-Gg: AYBFou03uF21AM3KuQPvxZcoCqaj5vyUIXNZ4595jfGJ8IP1e7CLxw7pI8+a63N21UU
 BR/I9I5XmRQPSUj27b4w+PnkFEdlQQWe1zqqdzcj8kYrFd/JjOg8OVr8yOswrSNP4SQKT/X+mPD
 atRJc88ZDyEW2leIDtKBnW1zhmXHwlnkMSSetHmoPK35dNezVzuaVUv/2HN5RHOGJl4vTSCTRLJ
 t5JatSVfGmH5SDn2Z3mt0FsidBNjkWtNvNagK3WNAKaSS8JNuxnCl1mzlHxhm4/wVyMl2CvZeGY
 8nyfNKEotfi5cKuiDDYL06dohT6t/vJ0RFZbDpRJ1anIWkaIzI1oxwaGnZUyOdgvu/q3kt61SbE
 iz8SVIMYw0WMF8tZRPPzagAN2vwFGmNcdg6aHGHEVWFwWhEx/07L7FA3bf/Fx771x+VOiNBF9fj
 lSrAPN+Emc8EiQ1CyPk8c+dkppa+tgW6zHMsUCmZ5WLrLIQCBR6lsr
X-Received: by 2002:a05:6102:1817:b0:7b2:508e:3d3b with SMTP id
 ada2fe7eead31-7b2508f0077mr3065078137.16.1790641249717; 
 Mon, 28 Sep 2026 17:20:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5d1d23f9224sm229333e0c.0.2026.09.28.17.20.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:20:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a05d645acso778088885a.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641248; x=1791246048; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9c3N+bNl0hhST++IX7sKKiBTLVGZMDZJPu6zY4JGBLE=;
 b=bbfCVRtNQVOPzl9shiUBieTkh40FHaMn9dczPYJ8/MY8agAQoXI5xvzV5sRx3v7KBE
 S+ME/CeQql3vMnWXGwTUSOIWwJjH7gr5+cZTMszKQl8U80H7WX0EYTIkdYTFxkoG2aBV
 fhGeNDPv2Zc9USvhncSFnp9kOW8ZEpSP8ss4k=
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cef with SMTP id
 af79cd13be357-93c6450c33bmr1462913485a.57.1790641248598; 
 Mon, 28 Sep 2026 17:20:48 -0700 (PDT)
X-Received: by 2002:a05:620a:45a4:b0:93c:6450:9cef with SMTP id
 af79cd13be357-93c6450c33bmr1462910185a.57.1790641248108; 
 Mon, 28 Sep 2026 17:20:48 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813d04f1sm279975785a.18.2026.09.28.17.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:20:47 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org, Dakota Sicher <dakota.sicher@broadcom.com>
Subject: [PATCH v3] net/bnxt: fix flow create segfault
Date: Mon, 28 Sep 2026 18:23:48 -0600
Message-ID: <20260929002348.1208423-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032701.763364-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032701.763364-1-Mohammad-Shuab.Siddique@broadcom.com>
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

When creating a flow that requires a destination queue but none is
specified in the flow create command, find_matching_vnic() returns
NULL and the code falls through to insert the new filter into
vnic->filter, dereferencing the NULL vnic and causing a segfault.

Reject a flow create with no destination up front, right after
bnxt_validate_and_parse_flow() and before bnxt_match_filter() is
called (skipped for HWRM_CFA_TUNNEL_REDIRECT_FILTER, which has no
destination VNIC by design). Checking this only after
bnxt_match_filter() is not enough: when the new filter's pattern
matches an already-installed flow with a different destination,
bnxt_match_filter() unlinks that flow's old filter, links the new
(about-to-be-rejected) one in its place, frees the old filter, and
repoints the existing flow's flow->filter at the new one, all before
returning -EXDEV. Rejecting the missing-destination case afterward
then frees that same new filter while it is still linked into
vnic->filter and still referenced by the pre-existing flow, leaving
that unrelated flow's HW filter deleted and flow->filter pointing at
freed memory. Checking before bnxt_match_filter() ever runs avoids
triggering that mutation in the first place.

Fixes: 59119d49529e ("net/bnxt: fix flow create when RSS is disabled")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Moved the NULL-vnic check from right before the done: label (after
  the tunnel-redirect/EM/NTUPLE filter setup, where v2 had it) to
  right after bnxt_validate_and_parse_flow(), before
  bnxt_match_filter() runs. Stephen Hemminger found that checking
  only after bnxt_match_filter() has already run is not enough: for
  a flow that turns out to be an update (matches an existing flow's
  pattern with a different destination), bnxt_match_filter() has
  already unlinked the old filter, linked the new one in its place,
  freed the old one, and repointed the existing flow's flow->filter
  at the new one before returning -EXDEV -- rejecting afterward then
  frees that same new filter while it is still linked into
  vnic->filter and referenced by the pre-existing flow, corrupting
  that unrelated flow. Kishore Padmanabha separately flagged the old
  check's location as dead code once this move landed, since the
  earlier check already guarantees a match by the time execution
  reaches that point.
v2:
* Changed the NULL check from "if (!vnic)" to "if (vnic == NULL)" to
  match this file's established convention for pointer NULL checks.
* Kept RTE_FLOW_ERROR_TYPE_HANDLE rather than RTE_FLOW_ERROR_TYPE_ACTION
  as one reviewer suggested: every other rte_flow_error_set() call in
  this function uses RTE_FLOW_ERROR_TYPE_HANDLE regardless of the
  underlying cause.
* Fixed the new branch to reset ret = -EINVAL before goto free_filter,
  instead of leaving a stale update_flow-path -EXDEV to reach
  free_flow and report a misleading success-like error.

 drivers/net/bnxt/bnxt_flow.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index 4bf38043b5..62dbb028f0 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -2047,6 +2047,16 @@ bnxt_flow_create(struct rte_eth_dev *dev,
 	if (ret != 0)
 		goto free_filter;
 
+	if (filter->filter_type != HWRM_CFA_TUNNEL_REDIRECT_FILTER &&
+	    find_matching_vnic(bp, filter) == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Missing destination action for flow.");
+		bnxt_hwrm_clear_l2_filter(bp, filter);
+		ret = -EINVAL;
+		goto free_filter;
+	}
+
 	ret = bnxt_match_filter(bp, filter);
 	if (ret == -EEXIST) {
 		PMD_DRV_LOG_LINE(DEBUG, "Flow already exists.");
-- 
2.47.3

