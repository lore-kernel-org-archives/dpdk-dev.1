Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EECCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:12:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F264060A;
	Fri, 10 Oct 2025 00:12:01 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id 3D7604064C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:12:00 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-425911e5661so5643305ab.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047919; x=1760652719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=805lZjX2jdDGYGkrFvla+zLPmfx9Pfc7jTF7wfcVhwE=;
 b=XRECY/+xCEDHYJJkBMGIkKzAEKHITNipI7GMTD4wn8wSFuibt3wFSlfjJmTCbbWNiq
 C7eITlcGXkuOPaV0o1e8ZEyOL1ehERLl11T2XUDNersNNDOrgCW0tpIrrWkiiT2QqI4E
 6Ie1jYZYxsuKygvu2xLMZqunU9e2EOnvOifD4eNoQoX1GgUs7J78TeEeoCcwJNyxCgzc
 +5IYzQqhyHd8i/J1aHuljm32FCb80CvRAce5gzoRaUpSSvQGR8oZcxyKTEYuLolB/uYD
 MNHCm9Lg3QBGaJKSu4famzipu6C5o0umIYzwD23jSEsalk4Yv5uLd2ErvTR03H0qBQ6l
 dyyw==
X-Gm-Message-State: AOJu0YycCKwmWS075n86HKzX/YQ9Qpt/Z9IKleJrMuRCz17+n78dyMoQ
 pTXjrDtVfzqIkMXYkpZzZ2p8zOj4chLe/9OTGkWnjBU4ozYDheYLVVE+Y+wNTxWjgqGc78VZQEF
 5ACWsAd0JL4P8ttAm3HCnhy8pzW618Ka57yHN9WViMRO+TjAq98FrI9wQwf2rRKYnP4NNExipLr
 /y88H9whZEJgg3iBTUUgn7dG/KEMY0D8Hw4lD0wp3s2Ss1yxtUwQaG8U3q9xbGq490iJnvjA==
X-Gm-Gg: ASbGncv62cJqXGdNN19hDFeKVvzCq3NS3kZkxOw982e170HbZKTJwRtCXHyNsf7/WWs
 Ow3IofmdcoCR3/6OFC1JkwXMIFCxEQUazfJKJpwKZudymvQOYq+lLCWgb9IxXGk6EJ+htZeb+yM
 We/KjSq3v8w+fL5d5LbZtayJUQWa1iM9pPs4aO/T1S3PKFcLATKVyhR3JvszDsRrq5CdFS9lHkL
 575Z0ZWkGmAhrUu/Uk4D06Iy55+sAcPHRYXf3c4nyTzwrr5eH6CInTm0b3ZhHckTKjUHDZvWKZg
 T7R+G+GJhsBoZDEXQfnPO0O+hvi26axEmPZML+nj9xsbg0AVX+ZHo6jrW/mhwngZjvLS7yHcAUh
 navhe5c3EadKZheH8FVkNaZRt54X/ReQ8TI4aSGzJJPiK6dRJVgJ/MoDq9yNMQ5ZoXY6oSUOX73
 mzo4sG
X-Google-Smtp-Source: AGHT+IF0OPhxutL7j+HmTy/FRFsfRe8eTU4xERSpdPjsup5Hr4LetvJve+f4+i4qlonFYzH7FnRsEhDi1/5x
X-Received: by 2002:a05:6e02:380e:b0:426:c373:25f2 with SMTP id
 e9e14a558f8ab-42f8735458dmr80462145ab.1.1760047919338; 
 Thu, 09 Oct 2025 15:11:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f6d042b50sm48627173.9.2025.10.09.15.11.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:11:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e831e5a42so63054036d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047918; x=1760652718; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=805lZjX2jdDGYGkrFvla+zLPmfx9Pfc7jTF7wfcVhwE=;
 b=bJH+1b96bbYGKqU696XDu75kwmX/DKejOL7Tmm9Y9o/SHRYI0e61UZJKu895dJcAxk
 U4lb5C6CSR/h6uEIO/GGafTjJ/Mz141vd/M37oDcXPUd8gqqXSv4mobMYp7nAt8abori
 IGiNowqwZ25PytiK3Yh7x34qs0GLIySvxklss=
X-Received: by 2002:a05:6214:20ad:b0:856:d1d4:d116 with SMTP id
 6a1803df08f44-87b2d732187mr122820836d6.40.1760047918136; 
 Thu, 09 Oct 2025 15:11:58 -0700 (PDT)
X-Received: by 2002:a05:6214:20ad:b0:856:d1d4:d116 with SMTP id
 6a1803df08f44-87b2d732187mr122820436d6.40.1760047917586; 
 Thu, 09 Oct 2025 15:11:57 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.11.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:11:57 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v2 02/54] net/bnxt: fix a NULL pointer dereference in bnxt_rep
 funcs
Date: Thu,  9 Oct 2025 18:10:37 -0400
Message-Id: <20251009221129.28256-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Jay Ding <jay.ding@broadcom.com>

There are some changes made in the 23.11 upstream function
rte_eth_dev_release_port(). The library now sets "eth_dev->data = NULL"
at the end of the routine. This causes a NULL pointer dereference in the
bnxt_rep_link_update_op() and bnxt_vfr_free() routines when it tries to
access the parent dev.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/bnxt_reps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index 6f5c3f80eb..20a0ba65a5 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -299,10 +299,10 @@ int bnxt_rep_link_update_op(struct rte_eth_dev *eth_dev, int wait_to_compl)
 	struct rte_eth_link *link;
 	int rc;
 
-	parent_bp = rep->parent_dev->data->dev_private;
-	if (!parent_bp)
+	if (!bnxt_rep_check_parent(rep))
 		return 0;
 
+	parent_bp = rep->parent_dev->data->dev_private;
 	rc = bnxt_link_update_op(parent_bp->eth_dev, wait_to_compl);
 
 	/* Link state. Inherited from PF or trusted VF */
@@ -542,7 +542,7 @@ static int bnxt_vfr_free(struct bnxt_representor *vfr)
 
 	if (!bnxt_rep_check_parent(vfr)) {
 		PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d VFR already freed",
-			    vfr->dpdk_port_id);
+				 vfr->dpdk_port_id);
 		return 0;
 	}
 	parent_bp = vfr->parent_dev->data->dev_private;
-- 
2.39.5 (Apple Git-154)

