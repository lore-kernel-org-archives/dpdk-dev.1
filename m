Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E280FC982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48B0E4325A;
	Fri, 18 Sep 2026 05:24:32 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 6C62B42FC9
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:30 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3990fe066ebso112623a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701869; x=1790306669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uF+BcsQsd5BPXnZ5by6cN1lP7pM14JDeynW+GnrK35U=;
 b=yzsQFEF9+I4MTEdX4JV5epuAhstBS9BDgqarLqffyt7xkFA1g7DoA0+AzBH++E2J+J
 EuIJwKavYLCizXpw3KXz87O5BXWL7SjvXNeaPp+luYvDltNPJ26KahzqTtdfs9gXCW/A
 Aui7cCep24CUVoxz3S9Eq+YquSoj3g62o4gJ5cLj3ddiJVbqyL5Cow+qMNy40R2AKyiN
 +UCyToHSj9Ml0ysNOFtOFnrKS+RuRAi7lATEEy6YssC5kcyeFajGJv1b90q5FtyTLynb
 bzw/gt6QOvjXGlvf/gutcDL7PZ8t8y6AoVGkPq2feXK8+mOgvaqO8gJz2euT0KmU4NMO
 Am9A==
X-Gm-Message-State: AFuF++mSeREZRwxtn+MQnVJP15tc+DqrRb52otoia4DkAuAGlVRIvUYD
 a86A0KiXeiTLBMsXpplRU63CeBWBJQp3AHPA5Ksy+8i8jQEyB/KG1RikoHO2RG9lWXwuEPVvNof
 akcEdgEzEnx+Mpt8leNUZYbwTq7f+AHZIOR7NopBLPKty0KTzoe/f6whZ8xwU79l4maoPL86h4P
 LVe7AN8vmPp3KyEjSYk7Psn4AtAab6nPp13Qe9t9j+yR5Sp1UaNyAh2/SdJi31F/A0iEawVlFIc
 8q0IUNDflc4
X-Gm-Gg: AYBFou1hZK01m05bI++bmAKPbi7TZqVPRyzRJpMYnWQdkxNmd5XIhlxJ4U5d8d3w9oO
 eWZw6tfsKw41RI/VSW47DT9NB8Bi82eXsqEKwckRTERAKgAGm2O/8dni9OTS/XYd5+WjZ2DJanB
 Y0yPcC6jEwpGbttdk0E4DvQKHEGQ3L5gmU+r8TJQW7pBRbgxBYRsop+kolgLyWMA48A/tj6Rnwy
 wbx/B4O/ElTOJVxjUgqCzQHNryQQmGb8Qv75gYCQGkJs00sUz08FIGkOL41boF4zEECZM+kX+A4
 bR76PXhkep14yYHskAUsbfRdpJKdAz1saAqG1yzpiG0VuiZoDAxAL8SeESwQC+5uW/NkIXCYLmg
 pjt7ChiQ9asirR8m0gmfVBm198BMebR2zp08KdBjVIUpsRKR1LgiOB97AW3UsHR23LF6xOUhkdJ
 IVF6EDlUdBY2/Vh/9BxdaGUttZzMrw6jJVNxrdLQaaTYfiepUUiw==
X-Received: by 2002:a17:90b:2243:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39e54d56e0fmr2441989a91.23.1789701869443; 
 Thu, 17 Sep 2026 20:24:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e5a3e902csm280406a91.3.2026.09.17.20.24.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc4fc935a11so222744a12.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701867; x=1790306667; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uF+BcsQsd5BPXnZ5by6cN1lP7pM14JDeynW+GnrK35U=;
 b=Db6z3ToTOCmZQ10lQbC8sX+Uan09esMZClNTzKJ5GtEMKk1PhjMvnH/vByC/KQHb9S
 epAyrzoPc2eMj4DjenEeyCfanI4B6d1ME717BySEU+VSQh4trCG/LMqyPsd9FVxSvN8w
 HxbSp/B0i/U8dsqGUOpMk3lXGne5azcYa3QrY=
X-Received: by 2002:a17:90a:e7c9:b0:39d:f615:725e with SMTP id
 98e67ed59e1d1-39e54bc3a8emr2529490a91.13.1789701867460; 
 Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:39d:f615:725e with SMTP id
 98e67ed59e1d1-39e54bc3a8emr2529428a91.13.1789701866878; 
 Thu, 17 Sep 2026 20:24:26 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b023bsm597708eec.23.2026.09.17.20.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:25 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH 3/5] net/bnxt: fix use-after-free in VNIC filter cleanup
Date: Thu, 17 Sep 2026 21:27:24 -0600
Message-ID: <20260918032726.763384-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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

STAILQ_FOREACH()'s own advance step dereferences the current node's
next field after the loop body runs. The loop body here frees that
same node (bnxt_free_filter()) before the macro dereferences it on
the next iteration, so the filter list walk in
bnxt_clear_hwrm_vnic_filters() reads freed memory to find the
following entry.

Walk the list with STAILQ_FIRST()/STAILQ_REMOVE_HEAD() instead,
removing each filter from the list before freeing it so nothing is
dereferenced after being freed.

Fixes: 20ef524432dd ("net/bnxt: set L2 filters")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 765aa7c452..99539d3705 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -3593,9 +3593,10 @@ bnxt_clear_hwrm_vnic_filters(struct bnxt *bp, struct bnxt_vnic_info *vnic)
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

