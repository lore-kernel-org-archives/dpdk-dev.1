Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A994CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4677F40E50;
	Tue, 21 Oct 2025 20:57:56 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id 115D04064A
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:55 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-430ab5ee3e7so20959985ab.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073074; x=1761677874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RkDUaO0RXoc8m6SCJz0vfSCgy4ImkS9VAKx+eiiqkKA=;
 b=Fhet5ubjmxEkZ8PXZEKvPewD/0oxJfpY5QAvQLm4nCKe+Q+X6lsghxnKjrVjvSu687
 IMvdGrBL39FiE0EEOJesjVOy1hZtJkrj83pAfzSOH4TrZK1kfv8NpclNUa2751ea8dLv
 3lHb2OzHiGheL7TkCVcb+dxRz1Ij+gO7Sl6CTnU2XwOODen9PAgDtwdvMBZptRaNWMlk
 CTjm2yYnUEQsPd8Ki0BdlmDdBwucIxQyHPdPKdQOUmt7zdT+nTl4xbqp8cCLn3EFwgZ9
 EDl4HF3mfv5SCBebmL3tKqXhfq2e9thHOuWxsEe+5KVlC12Q+1fw2k61tFIkcq/qW0Xy
 NBBg==
X-Gm-Message-State: AOJu0YxHStjy4Hraxt1SKDghP2ySOVt3gCs0cEp/yE7qcZNR0MlqbbNN
 zbNVaSkb0yDYKZgrhsCFtqKUpDy40at1M5DFYE8DjZhQPebrv23B2papwrh+GtdylYOPSYPiViw
 sribb+A1izDHtWp0F3GV/4izXi7w+x//QajH6TawG9y64M+7LTnMtCDYjL4jD/2nkIl9tZcW6wU
 QcpXSdB6xon59/YxhiL35QCWobIIORXFCOvDXExh9zLOkEBCUH0Gpy724sxX3xCzj+vUqPbg==
X-Gm-Gg: ASbGncv1XcEJcZpVRFYzeICsW+Ew4XZ4lHG0hmycMdOna/aQGlZYqF5W30S/GFVs5t7
 coxjvvapshHzOhfXnkBFL+pwFTOB81Go+XLedG+5432IHTPPFjFrfCMkgaQC4gh/jOrL/YDEL3y
 elV7mGnL+y7WnAGwjz/J4drAqXJxz4GGoPu9WLNaoL+M8zUNqTO1gOgcUAe17ZT+Ro047yjYIkq
 NbjygHSr/TW+1VbR7AyfLhJFIkPVq5exbQPxlmbvB118BA1NVucTYS7pKuESoGv3p+Gy5kfRvY/
 gq3qaoVC64u3iY6hfWJpomZJjT31pbtHT2NkuXioeAbmqrG/E6dbYY3aKagehkWOvr6dKD1tYTe
 7HGqTWCRaBYqeT/D1Z41J4uRA0wnBWhDrt3f/YUhGE3NIGp3874oAdxkuObXHAW39fN365qfOza
 ITmEK1hjn0d39I0iqLE+fpXjHsjFEFMpJ13wMQ
X-Google-Smtp-Source: AGHT+IGJBsY8vMSTR/GmAzHJAH5i70gCFUil+tclBMD9LwDxiuj0fVH4BJnHDe0clt5FImaQxweHlq0DtF+c
X-Received: by 2002:a05:6e02:2307:b0:42f:a60a:8538 with SMTP id
 e9e14a558f8ab-430c52b5afemr225281515ab.16.1761073074248; 
 Tue, 21 Oct 2025 11:57:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430d0701aafsm11855415ab.1.2025.10.21.11.57.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290b13c5877so120283105ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073072; x=1761677872; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkDUaO0RXoc8m6SCJz0vfSCgy4ImkS9VAKx+eiiqkKA=;
 b=cdFMKTlvRDJudH62KbACMMCtsM5uZfiQJHGxUXfQhYe5dP2XnCLJozNw1ooMwTTszL
 E766iMKYLjVFITy7vsl+xVzaEJnLOr5nNqs+Wo8AcsZ/SXOXz6MCXy45LgzQ9RPNW9qd
 v8Q0ymhGBV5czpuMQDJpqfKQrEtdTadyXU6TE=
X-Received: by 2002:a17:902:ce87:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-290c9cbc92amr266142675ad.19.1761073072448; 
 Tue, 21 Oct 2025 11:57:52 -0700 (PDT)
X-Received: by 2002:a17:902:ce87:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-290c9cbc92amr266142355ad.19.1761073071856; 
 Tue, 21 Oct 2025 11:57:51 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:51 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Stephen Shi <stephen.shi@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH v4 40/57] net/bnxt: avoid potential segfault in VFR handling
Date: Tue, 21 Oct 2025 14:56:44 -0400
Message-Id: <20251021185701.71881-9-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

1. Addresses crashes that were seen when using invalid
   representor arguments. The crash would occur when unwinding
   after a bnxt_pci_probe() failure.
2. If a representor port exists and an attempt is made to attach
   the same port a crash would occur. This change adds a check
   for an already existing port.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Tested-by: Stephen Shi <stephen.shi@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 54613076b0..4ed2bf2a1a 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6900,16 +6900,9 @@ static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
 		return -ENOTSUP;
 	}
 	num_rep = eth_da->nb_representor_ports;
-	if (num_rep > max_vf_reps) {
-		PMD_DRV_LOG_LINE(ERR, "nb_representor_ports = %d > %d MAX VF REPS",
-			    num_rep, max_vf_reps);
-		return -EINVAL;
-	}
-
-	if (num_rep >= RTE_MAX_ETHPORTS) {
-		PMD_DRV_LOG_LINE(ERR,
-			    "nb_representor_ports = %d > %d MAX ETHPORTS",
-			    num_rep, RTE_MAX_ETHPORTS);
+	if (num_rep > max_vf_reps || num_rep > RTE_MAX_ETHPORTS) {
+		PMD_DRV_LOG_LINE(ERR, "nb_representor_ports = %d > %d OR %d MAX VF REPS",
+			    num_rep, max_vf_reps, RTE_MAX_ETHPORTS);
 		return -EINVAL;
 	}
 
@@ -6942,6 +6935,13 @@ static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
 		snprintf(name, sizeof(name), "net_%s_representor_%d",
 			 pci_dev->device.name, eth_da->representor_ports[i]);
 
+		if (rte_eth_dev_allocated(name) != NULL) {
+			PMD_DRV_LOG_LINE(ERR,
+					 "Ethernet device with name %s already allocated",
+					 name);
+			return -EEXIST;
+		}
+
 		kvlist = rte_kvargs_parse(dev_args, bnxt_dev_args);
 		if (kvlist) {
 			/*
@@ -7078,7 +7078,13 @@ static int bnxt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
 	num_rep = eth_da.nb_representor_ports;
 	PMD_DRV_LOG_LINE(DEBUG, "nb_representor_ports = %d",
-		    num_rep);
+			 num_rep);
+	if (num_rep >= RTE_MAX_ETHPORTS) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "nb_representor_ports = %d > %d MAX ETHPORTS",
+				 num_rep, RTE_MAX_ETHPORTS);
+		return -EINVAL;
+	}
 
 	/* We could come here after first level of probe is already invoked
 	 * as part of an application bringup(OVS-DPDK vswitchd), so first check
-- 
2.39.5 (Apple Git-154)

