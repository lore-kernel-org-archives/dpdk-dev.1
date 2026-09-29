Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E420BCA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 519EA410CF;
	Tue, 29 Sep 2026 02:21:37 +0200 (CEST)
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97]) by mails.dpdk.org (Postfix) with ESMTP id EB68040EDC
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:32 +0200 (CEST)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-6c7ea9947e6so822015eaf.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641292; x=1791246092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=atv4uRL59TxOR+dmG5RRo7j6jDjhKnxnc59IS8CobP4=;
 b=UQcg3b2GdpQ1GY3lsh2PYFQRTcnkRSu1iLuOXJ+Jmy4qA9AF/XwtU6SDO/rG6Lqumi
 oyIDpjt+TWIv6VG/HMbIJ3/BolZQGUyPouXmbGAn6l0BBYj4wXTo7G6NSnLp+sTVYIMQ
 7GQcWOiBahBJrNLwgHxiURUhclLFyAZXf9DL5TPavXGdYkakxbQBqi4A6hLokucKh5Vv
 sZsShdZFpqatxWalO1FYPCKLXlWKP9ZY3up9Q9Vnet8i0QRjMLtJrog4OUqzboLkLj+a
 35ckU/NGoQ/M6R5d03K11p96lvpM+o8il2zuiHumGlKp9mvde5rEdNTkKjGwzlDJGcAQ
 emKg==
X-Gm-Message-State: AFuF++l8WJ3P/5D+po4UkalY+60nBA03fWau6YLUtayd6tNzPnLt8CqN
 X1FnQfAVA04ettWrvd857KkNoQQ0lU8HZeX7vcUIGmL7JiQrzUvCXC/fw3vlwwNz0PquxxLt7jB
 jmxeg8a7kHV/sw3pO2hoJN9pNLOaCHWEU6qXT78+dTEoym0vsojOQogqfUXBFYs+V46V3w+DDIz
 ZIjjfcWbtFChgMejR9G4F+RzwGHRS1UoW9OqWG8tKw17Y+rLiqYy1VWWGrAxzVq58cY0ATkGFFL
 KJaKxt6G6K3
X-Gm-Gg: AYBFou31hHiCRJ/o6I0Rpz77mFc0X5swLFZGRiDFK6tUp9PwyVbJuKHwvXfjllMQrRi
 lRLVbLTKs1LL7INQiec89pc8o8A6q/XbA2oJPzpURmWsx9XpSVAHvw2eaexidlnpGAtcQa3pfIg
 DO1tjZ3O4W6ZvI8ALx72xGDN8Qi6xpgaFNz+7zaDzEqBmGbJrelU7TTJSn4lulcYrBHF3OjvK/D
 qzi+3npuQtMQEVIQr7wNWdtdMKIvtu2iMKGtMEiTflNgdutBYfEfZA7DTq7sKcf8jXW63GOe2hD
 iYPwqbRv8gwmFdA2b7g7Ktw22gHeohVp4FrtDUo4AiR2MZm1X1XSYoVC7m/hgMdCx5ExOIRDp2M
 aXnlc0ICUETKkRSIPfhhOqJSG2JTEHqKL9ZiA6I1If6MghOtL+VTEB4MOcO+j+shFXfJOV6rlMi
 oFDanDDladKQqkV1yohHfytgRVBEkA+Fd1ARpZ+gspsA/EOi4FVoeg
X-Received: by 2002:a05:6820:1998:b0:6cd:3ffc:ad00 with SMTP id
 006d021491bc7-6d441c7dfc8mr14926701eaf.80.1790641292004; 
 Mon, 28 Sep 2026 17:21:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-81d5316ec4esm889999a34.0.2026.09.28.17.21.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so428800685a.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641291; x=1791246091; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=atv4uRL59TxOR+dmG5RRo7j6jDjhKnxnc59IS8CobP4=;
 b=a1Zwu4nelBDHZPMEqdzY9uyVDAF8vnCLSl1qyxX1i97Kx/GfS6h3i3cdIrYGuuQt6Z
 9LaFTJlocUYgVywIoBsW3VdpgGzbLxaRTOEEs3YRlZzwq/giV2b6mQsbvD6wgi0B5Hd+
 V09iuz4EdsrRGMfFPGJn49Eo9nI+pz1nLkDr0=
X-Received: by 2002:a05:620a:1792:b0:93b:d7a0:d9e4 with SMTP id
 af79cd13be357-93c43d442bemr2325426085a.62.1790641290621; 
 Mon, 28 Sep 2026 17:21:30 -0700 (PDT)
X-Received: by 2002:a05:620a:1792:b0:93b:d7a0:d9e4 with SMTP id
 af79cd13be357-93c43d442bemr2325422785a.62.1790641290014; 
 Mon, 28 Sep 2026 17:21:30 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813a5ae6sm273808385a.13.2026.09.28.17.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:28 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 4/5] net/bnxt: fix memory leak in VF VNIC query error path
Date: Mon, 28 Sep 2026 18:24:23 -0600
Message-ID: <20260929002424.1208457-5-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

bnxt_hwrm_func_vf_vnic_query_and_config() allocates vnic_ids before
calling bnxt_hwrm_func_vf_vnic_query(), but returns without freeing it
when that call fails.

Free vnic_ids on the error path too.

Fixes: 49947a13ba9e ("net/bnxt: support Tx loopback, set VF MAC and queues drop")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 5b07142770..f6623693fd 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6278,8 +6278,10 @@ int bnxt_hwrm_func_vf_vnic_query_and_config(struct bnxt *bp, uint16_t vf,
 
 	num_vnic_ids = bnxt_hwrm_func_vf_vnic_query(bp, vf, vnic_ids);
 
-	if (num_vnic_ids < 0)
+	if (num_vnic_ids < 0) {
+		rte_free(vnic_ids);
 		return num_vnic_ids;
+	}
 
 	/* Retrieve VNIC, update bd_stall then update */
 
-- 
2.47.3

