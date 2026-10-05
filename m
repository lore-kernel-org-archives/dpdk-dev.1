Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC0CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98ECF40659;
	Mon,  5 Oct 2026 17:16:44 +0200 (CEST)
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com
 [209.85.217.100])
 by mails.dpdk.org (Postfix) with ESMTP id 49A3F4028E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:16:42 +0200 (CEST)
Received: by mail-vs1-f100.google.com with SMTP id
 ada2fe7eead31-74ab6c88052so1036593137.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213401; x=1791818201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RE6wBBaV2jF4kaoSV51OBry86rhcrHbMQVHjmYBUjWM=;
 b=C9MEWHXrvAouisgAxgTQ7fZk9QxrNWZbwXQBntmSM8WGRJhUqYpWPHat52W7f4CvS/
 MD24cQd5N+2uiSMQzfREMPmS/rfRoO2u50jP4Drgp5GjePjd4Cll7C+UtC3Jn6maOASE
 3/OPhBmCMtqkABzO0jy0XuoU4BOor9y395sPy679MwdAb6lxInt4jpHfFlezdZjUC2I4
 5SLlId7pCChfS9xsCgKlBso6Gn0EEkRrcQmVpjF6Vh/Po/K9WhXmMOt6hKzFYKG4uZN7
 YFollyJEgi6yX21Yu8SDU51u8NulhYV/2R3os/Ok4Lk4twdtCRGfgQiK1LcyNh7nT0kz
 C/uw==
X-Gm-Message-State: AFq9FYKfKHh4rmC2BRpz+i76a20apHSDw2JlxDgaMAFH1BiR5u7L2vXe
 4b2cZ4VJA06j2llsDVDINJYXW5ruvH/MVn28lV7klpvVOkgXzSuh8Mds2yrRncDL0cLEZPC9i11
 KpApljBPZ9M/RWIaTGaIaQ8bviwZN2cg7i1tR3wKZq4DJS2sD2gJpwx8tMw2aBXVecLc3R/boqP
 EFjIuMD8+PQ1ElDbd2KCwIfw2qWJ2I3k20IJY417UoUCd1qGR+moR8Y65dQNvQsutPpjGoxg==
X-Gm-Gg: AYBFou0DxAb1GLR5DB3DlTKN/04y2h3InqlxJzNVVIug3pHXrby8dEQX/fuMDWsoc2O
 iHVzVhLJcJEvVltTJ57Am0g+19Ocuj1EsDmkDgvTadNZU3sbeOXEMLgIuTPOmN2k3kOotCfCQmo
 2ouhZ93rwc5q1/tzW1Bd2xa9R9XvpSXhpELlmyv1jYkVPqeoWNqHjvzuBmisElLenOe9bEfPgO0
 cMSQ+EOzwXLRNz5Umnzp0V0PfZSJ303cvxjwYePS6LwUeK3DnpUmDQ5HEammAB5PRK3Q8l5QMhN
 TfH2iwe0njmFOrtj99Uk2RtsZA40xw3yrjfBYSBg4hd1bfhNQbGRsgEOFKWtJfn9pk3uQkdMTN8
 o5x0tU2zAGWbEuBveGX/ZvHJzwT0KIwsFBxXpmznaU8uW/Dzou3S2cvx88GZM279B+xP14BbtTv
 tjv/Ap9p3/x0EtiiBkzuP4ox/Qx9ux3Q6UMOGOgw==
X-Received: by 2002:a05:6102:5127:b0:7c3:7674:337c with SMTP id
 ada2fe7eead31-7c376743649mr1128621137.8.1791213401289; 
 Mon, 05 Oct 2026 08:16:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-98c7b377475sm40113241.8.2026.10.05.08.16.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:16:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-676956fd276so2327550d50.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213400; x=1791818200; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RE6wBBaV2jF4kaoSV51OBry86rhcrHbMQVHjmYBUjWM=;
 b=cotvM7Sq7rBIbqe3GSnM7cmg2+YTJkFl4Bsl7t42+NPka3uOAvMDpFCciXiuunLD4Q
 xT1wjQvMMbgBO+gFW6JnWn9MKzBtMeyfi6Fi2stVLI0BrKhJ7hdIBsmKHK2u25GBDIew
 0/JcE/OLo6wSHSmXuiiudpdaXaTGKO/9tlD3Q=
X-Received: by 2002:a53:b08b:0:b0:677:b6f0:63c0 with SMTP id
 956f58d0204a3-677bd374b46mr2315269d50.39.1791213400361; 
 Mon, 05 Oct 2026 08:16:40 -0700 (PDT)
X-Received: by 2002:a53:b08b:0:b0:677:b6f0:63c0 with SMTP id
 956f58d0204a3-677bd374b46mr2315244d50.39.1791213399419; 
 Mon, 05 Oct 2026 08:16:39 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0bc98fbsm89306106d6.29.2026.10.05.08.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:16:38 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix flow db lock-free issue during shutdown
Date: Mon,  5 Oct 2026 10:16:34 -0500
Message-Id: <20261005151634.1705740-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Farah Smith <farah.smith@broadcom.com>

In ulp_tfc_deinit(), ulp_tfc_tbl_scope_deinit() was called after
pthread_mutex_destroy() had already destroyed the flow db lock
(flow_db_lock) instead of before it. Reorder so table scope
cleanup completes before the lock is destroyed.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index d5ce4c3c18..cc85f3b486 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -957,11 +957,11 @@ ulp_tfc_deinit(struct bnxt *bp,
 	/* Delete the Port database */
 	ulp_port_db_deinit(bp->ulp_ctx);
 
+	ulp_tfc_tbl_scope_deinit(bp);
+
 	/* free the flow db lock */
 	pthread_mutex_destroy(&bp->ulp_ctx->cfg_data->flow_db_lock);
 
-	ulp_tfc_tbl_scope_deinit(bp);
-
 	rc = tfc_session_fid_rem(&bp->tfcp, bp->fw_fid, &fid_cnt);
 	if (rc)
 		BNXT_DRV_DBG(ERR, "Failed to remove RFID:%d from SID:%d\n",
-- 
2.31.1

