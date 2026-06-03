Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF803CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD5AA4067E;
	Wed,  3 Jun 2026 19:50:03 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 1298D4066F
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:50:03 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-36d98b9aa9aso3680234a91.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780509002; x=1781113802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mvaz+3kKC3VgK2pnIrGdhj6b4Wm7smYFljlS6USPtmE=;
 b=gbC08ILknJL+vKnJoda5tNJrcj+T6aLuv/yNvPfdW86wSmrgArZiXgBinhjNT85w7H
 cvAurKE6YrdtAuIV8Wz90ynw6uCZfxXR/tmrt9hkp0iopjxuVTurS/QFwplcbr2YeJT+
 DFhYPb7SC1xtfYYWAThyaztHPZYiQBOxbjwkFs5rHxbgw4FRdYc8X7YGBcl6z6YdyEZv
 dVCsg6LHQffaNBu4Q63Se74bhWXIwXjyMlv4fU9BnGyUjuHRB01oAxLag6gVhV7KM0H4
 fBQz0WHClfnYWKdwPIudJA79S2yw61/mt9r65DTE8+eli6yvC2Bz24AfJERekOb5nVBA
 RElA==
X-Gm-Message-State: AOJu0YyqspyupwzCeDEYUnvdwwtZo9WQf7ebGuRznf3p/9IVe4FJEJ7M
 MXtyOuQ/mObJCIvyCS9WibXL457Tjg5QuS6/O//JeYU1eLNV9ZmoMWtO1LH7FTPNQj0vJJqNA+U
 0bXQ5ribRvGBg8y1lrzJwZNdHBQC/HNMw9mjryslvAkL0KlyTKJ3QJHjAksxVPppTlBPqI82S61
 wfTuUXOb6k8AyiTZH4wulBzi/i4ImqIhGyIWZ05qXRQOy44t8x3sn40o5xTqcKd0doCOmS6Z5kZ
 jYZp8HTPUJS
X-Gm-Gg: Acq92OFrHdRoBY+/XuQX6VBHAi3vyvYTwp5rRyN8Sa2ANenxtJ6y070yAQijieU5urZ
 0Zjc5QhmyIrPfAGIusz2H7QXIvpQETYUw83Y8m6d2749B5nU5KBOGK7/xfNQLPNmEPIMRVNjj2b
 ogFjTQpweCCFyRMpJyc99lSpUi8goGAMdNK/kjgq+UBwRo+uP3BD7mtNmDm0ZVxuFdjt5R5hXFn
 HH6lBEpKBdJZWrJNyUbswUx1leA+NB3SXURt70hnWEp5cEPYuExgclr8W0xMlm++07imdZyTjns
 nNSLTOR+AKwwyjzI5KDZOCX9pJMou5OY4ppQorPeNPlfVHyN4myBf+arFpOqrVHOOz2Z7IrAzfI
 EbrsFfTZTwOeE5G8becBE+hpiLfsoy83aPfUtL/wBVgUxNE8hPNhpAEkMOVsEmsanv0pt1rvJtr
 1Bkv3igUgyL/67P64S/Fhpohm6V+Y+hlapyLceEyWWtYWzE1CSRz96XGr18mOl7H+WM13cZT742
 AFppXBkjRF0
X-Received: by 2002:a17:90b:5345:b0:36d:635a:ac1b with SMTP id
 98e67ed59e1d1-36e34292d44mr4846089a91.22.1780509002120; 
 Wed, 03 Jun 2026 10:50:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36f708347ebsm31462a91.6.2026.06.03.10.50.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:50:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccf62978bfso115067106d6.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780509001; x=1781113801; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mvaz+3kKC3VgK2pnIrGdhj6b4Wm7smYFljlS6USPtmE=;
 b=aSyUdlZmL3RnzSNxeTfuEkx8oioIACojvheBmuhHBzbq9z/4ccvxCAJE4bI+FgtjW3
 WE2kOl2h4Q8qWjPRX34zDdNBbqGxXN2Gv5LfcQhjWejvJaT1KHuRaaZ4EVkUmAxoIFym
 0RSZUPFmNIrL2eZHmB4ZEcvMwq5nfmQc+oTug=
X-Received: by 2002:ac8:6f13:0:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-517787a16eamr61781211cf.56.1780509000833; 
 Wed, 03 Jun 2026 10:50:00 -0700 (PDT)
X-Received: by 2002:ac8:6f13:0:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-517787a16eamr61779191cf.56.1780508998001; 
 Wed, 03 Jun 2026 10:49:58 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm29021021cf.2.2026.06.03.10.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:49:57 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Zoe Cheimets <zoe.cheimets@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 3/4] net/bnxt: remove implicit integer sign-extension
Date: Wed,  3 Jun 2026 11:51:36 -0600
Message-ID: <20260603175137.1990204-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Zoe Cheimets <zoe.cheimets@broadcom.com>

In bnxt_ring.c, the result on line 389 was auto-sign extended by
the compiler because the arithmetic result is an int, but the
dpi_offset is uint64_t. Fix by casting the result to uint64_t
before the multiplication forces extension. To ensure that a
negative integer is not being cast to uint64_t, add a check in
the if-statement.

Fixes: 7a1f9c782b50 ("net/bnxt: add multi-doorbell support")
Cc: stable@dpdk.org
Signed-off-by: Zoe Cheimets <zoe.cheimets@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index ccca779b97..579b73d2ce 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -385,9 +385,10 @@ void bnxt_set_db(struct bnxt *bp,
 		db->doorbell = (char *)bp->doorbell_base + db_offset;
 
 		if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB &&
-				dpi != BNXT_PRIVILEGED_DPI) {
-			dpi_offset = (dpi - bp->nq_dpi_start) *
-					bp->db_page_size;
+		    dpi != BNXT_PRIVILEGED_DPI &&
+		    dpi >= bp->nq_dpi_start) {
+			dpi_offset = (uint64_t)(dpi - bp->nq_dpi_start) *
+							bp->db_page_size;
 			db->doorbell = (char *)db->doorbell + dpi_offset;
 		}
 		db->db_key64 |= (uint64_t)fid << DBR_XID_SFT;
-- 
2.47.3

