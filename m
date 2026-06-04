Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8372CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 22:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8BD440665;
	Fri,  5 Jun 2026 00:54:39 +0200 (CEST)
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com
 [209.85.160.99]) by mails.dpdk.org (Postfix) with ESMTP id 68A2D40651
 for <dev@dpdk.org>; Fri,  5 Jun 2026 00:54:38 +0200 (CEST)
Received: by mail-oa1-f99.google.com with SMTP id
 586e51a60fabf-43d3454f643so568406fac.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780613677; x=1781218477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3D3NJ8zQZ1gKqWPb7TuG6PIlbI/VjmbHpeQcL+swms=;
 b=lYaElKZqMoq/unC9UpVkOhItH4Z8JtDLHrHm4uQgk8rkTslwIwf/fEKuw74fdSgbSH
 okZjuMQ+vhcG8+oQVil40ECTpL6ZqQueYLd1r2BXLIsHtkBlGgoGz45b1tniLmz02SNV
 rO3JVGflXBIh4T3VX2Uv3Y3CXx5+wW0d8R/hGEFixpAmkgGlkxnjvy1A/Aji2NpXhKV+
 SnglfIrFRGL41131m+gaX3xZjnraglhdlT9a2Dbh6Xy8OaknuuIDox0ZnVIEe7k217ul
 hkIBUE5I3ckbOOaIjKTsfsBXHfkZQNGh24aFW8Zq0Q9HD4MZLOdnFsgJy8gDxjY3l5Hz
 b0fw==
X-Gm-Message-State: AOJu0YzgIZUJ1n1Op+9s3Vag0HS0m2dqzH9BLHVoolule4YggcbwnqpA
 X55AFeE6uuYQOV/hqfEnSn29oDI0PE+igo37YcigLpBmajw7nrQoMvs32QYu2nOwFZYfKsNn9I4
 jsVleYg7zcrIQxe7F21KGRH/2r4wJpgJneGFo4t85irGBaRFR32WWoa1RuX1WXdTrwIGBoWMNo4
 jPo5iRc0fFzsqT4wmSczcrqp93J7khJ0r+Lxae6rl7cZWfhdqNOWRTlqyL8yTYRBH0pXpiybYgZ
 qFuHHlZ7tfO
X-Gm-Gg: Acq92OGdb+eCO/W9KEDHBKWHbuyVqz+C8FrBsteqHcyltcyFKP/7+N2Kv/F3vKXMygy
 dzF38lD92rU7BrYWATn3Uo8kAxYDN7z1ACokAkSos9Wo+jUD7Kc+v/c2TQaq7YcIX3sb9INyUkY
 alqZCt1d+EqIM/CG8lg/DDUQgoB6n4ll+Ji7P0KXBxyEGMkBJ5ylMyYK+aGIy2HtFcTgRV5GC5+
 YHdnixhrKTxwNIxaJo7BjMfqmjlQ153CIVzplHZhdozNp3lqLv2KrTbGRJ8RtX1cL6l72Fe8iOY
 V7E2c+j4WMERD3pW1WbSglqXkPnwxNJuQHcO3R+Le5Kg/WKisl0lyr2AyJvAulZYtK0q4BRl/ZG
 mscTfJRDi+QG/OsKjoL+hnwykgPi4bUOFwvmkn+sZd5RYfyWY2q86oMlFr9OUo75CGWs7SKMqWB
 RhGgZ8QPLG+wzzYBZ+DiACy/Jx6bzegh+277Py6E4DYa9KRhW6o5d4Zsgkvu3jwRYB5+q7gxOQ9
 8SMlmuKPRfe
X-Received: by 2002:a05:6870:4206:b0:42c:711:a235 with SMTP id
 586e51a60fabf-4413da4f407mr582397fac.35.1780613677305; 
 Thu, 04 Jun 2026 15:54:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-440d7e114a1sm729089fac.5.2026.06.04.15.54.36
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 15:54:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ceba6ec0ccso10630606d6.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780613676; x=1781218476; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3D3NJ8zQZ1gKqWPb7TuG6PIlbI/VjmbHpeQcL+swms=;
 b=dZ9YzllGXX7tnc+OseXLu5MglJkD26SnLOygDN7LAWojBk2UdEpc6SW+0CCr9GGkD2
 Wfra+x6JUccLzaxHTBa1VI7w9IkGvrzyyovKxdSsvyVMD3PTpg87CudygoUwC9p/p1Pb
 0UWTrQ4vf+LZIJpnNsQUxMnYLLoZ1LH84Fg/s=
X-Received: by 2002:a0c:fca7:0:b0:8ca:105a:c23b with SMTP id
 6a1803df08f44-8cee6120ab5mr15727616d6.23.1780613676086; 
 Thu, 04 Jun 2026 15:54:36 -0700 (PDT)
X-Received: by 2002:a0c:fca7:0:b0:8ca:105a:c23b with SMTP id
 6a1803df08f44-8cee6120ab5mr15727316d6.23.1780613675402; 
 Thu, 04 Jun 2026 15:54:35 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053032sm67043146d6.24.2026.06.04.15.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 15:54:35 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 2/4] net/bnxt: fix QP resource count in backing store config
Date: Thu,  4 Jun 2026 16:56:20 -0600
Message-ID: <20260604225622.2285191-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

The driver is not passing the QP1 count while
configuring backing store for QP type.
This can result in a smaller set of entries allocated by the
driver with the firmware.

The number of entries is provided by the firmware as a
part of backing store qcaps v2 HWRM command.

Fixes: 5b5d398434f9 ("net/bnxt: add support for backing store v2")
Cc: stable@dpdk.org
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..7d70d0f3ec 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -5404,11 +5404,11 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
 			if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_CQ)
 				entries = ctxm->cq_l2_entries;
 			else if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_QP)
-				entries = ctxm->qp_l2_entries;
+				entries = ctxm->qp_l2_entries + ctxm->qp_qp1_entries;
 			else if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_MRAV)
 				entries = ctxm->mrav_av_entries;
 			else if (ctxm->type == HWRM_FUNC_BACKING_STORE_CFG_V2_INPUT_TYPE_TIM)
-				entries = ctx2->qp_l2_entries;
+				entries = ctx2->qp_l2_entries + ctx2->qp_qp1_entries;
 			entries = clamp_t(uint32_t, entries, ctxm->min_entries,
 					  ctxm->max_entries);
 			ctx_pg[i].entries = entries;
-- 
2.47.3

