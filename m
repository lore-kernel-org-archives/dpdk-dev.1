Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC863CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D472340FB5;
	Wed, 15 Oct 2025 11:05:05 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 3FF86410D0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:04 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3306b83ebdaso5593525a91.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519103; x=1761123903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+VFzjwDWq3oyf6ypGL9F9LArEfUW2em8ItgyWpfPSw=;
 b=Z7a84pCCCpFhbHpyNLQXOoCOxqWAXkyndzJTC3pfFbyUfWs2bjPbeo1W45+naeFY59
 ElSKjajgyVUglPjp/8xTWn7afJuYC3qFVta4Ft1XFNjKBEX+OfUtKwnzic+qB/pNFwWm
 ouxVEP+DAORcL29y03KHdvoDyB4A+s9Jn6hVVvGQWQeJiy5YHoUWtye+reVKH7yD+isU
 2F2KkvgEozQzLg56jtPVd4LfwhQkj35OOaMeopH5Wvqu/hdA9bkiodhUPAwUt0e/dj1W
 dXMzpjqi9Lxp7Y48yu0+hwoY3cv1xnSohjJcocLfrnlDqPnr8o9hYgD/NbqQk6l8Bk6M
 zXIw==
X-Gm-Message-State: AOJu0YzedVkVgMTdat1tikxbYHmss0F/hPnjr2Hbvup0TqFyUUrkR10m
 70YerA9vcgsRLyED/uunHjIh6pPcczhexeR0Jj2DoFO834zbRi8KrNEGvv2PmR7JPHW1guYwn2y
 HHNgebLbBAyA1GMAwLbPNXKCo6fbMaHKR9a7udRT4sC38gUbuNMfCLNZxNQQ1+4Cd00Q+fRpyeg
 Q47kUguhzA2DS5g8Dcf+2j1AhRkjc3JR5WzHOsWwF0pXrLkMGJ2CIphTAJh8Ix34BimibhiQ==
X-Gm-Gg: ASbGncsNuMH5BnNRUdo0z4PvBOEkgj4/TCRTWvBoFnIxw/srhDVSOtLAabpySuVnxz1
 pgDZYX4fNSQglIhwI0qwkijY2z22XeTVtJxaJxw9puSKtZ2LKCctzj9YJdHmJsN3y9Y3kiCWTLu
 YRbvjFwagfj/5fBQlAER/xAkMJ54QLIw8+DDnHBI/iRMzdB0Bc2Vh5UVi5gIcU/shjq79QMuX+o
 aDnXhJ4OeV7GUpzBK7ZlR0dZuISXLBnrrtqPSLujsV4IaTjlBbXNoBHuSrs5/YLuoQP3iodhWkD
 Nq+F8i8JVQI+zoUHbhCBvudjv4PR+GFGyf4DQXR5ICnjMAmyXJ/P3ZTL8VGY5GiL19V6XHeHuwq
 6IPRrI68vWEqhMM0Q/n/MPUid/Xkca+IU5bk3g3+YC/RHYSQAWEKYg70vjJ1YpsJCE4nlXVvmXC
 ACV7XziEl0H7afSrDmQTvzJzBQyU4Emb7Ykg==
X-Google-Smtp-Source: AGHT+IEi9MpPrYbZj49ExAIiXl9iW7qWU0CfuuPMzmTsGEEaYP46XHvYyMfEEhm4vUep0kgNtcMBjdtOQTZb
X-Received: by 2002:a17:90b:3b43:b0:330:7a32:3290 with SMTP id
 98e67ed59e1d1-33b513b4de7mr38303179a91.37.1760519103154; 
 Wed, 15 Oct 2025 02:05:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b626ea0b6sm1555424a91.7.2025.10.15.02.05.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-780fb254938so8425018b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519101; x=1761123901; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+VFzjwDWq3oyf6ypGL9F9LArEfUW2em8ItgyWpfPSw=;
 b=g7UYKLfoYb/++BoeOMSU9/QIM32e1zAUotD9u9flx2j0NNI1tJ2voq4EhqD00vK+gI
 IyKgSZuQ6Wac/+JsLJukjjISDzLcgDR3XSKF2U9DkzatJ4ovTfoXPkNr+6lNQ1Bj55rM
 5/JJu4q0c/7xMtE0znwNG88JGI8KbK/peR/84=
X-Received: by 2002:a05:6a21:e083:b0:2d9:b2ee:7855 with SMTP id
 adf61e73a8af0-32da83e7348mr39626578637.51.1760519100805; 
 Wed, 15 Oct 2025 02:05:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:2d9:b2ee:7855 with SMTP id
 adf61e73a8af0-32da83e7348mr39626510637.51.1760519099992; 
 Wed, 15 Oct 2025 02:04:59 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:59 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Stephen Shi <stephen.shi@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH v3 37/54] net/bnxt: avoid potential segfault in VFR handling
Date: Wed, 15 Oct 2025 05:00:07 -0400
Message-Id: <20251015090024.32250-38-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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
index a395c2ab47..efecbba2c3 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6905,16 +6905,9 @@ static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
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
 
@@ -6947,6 +6940,13 @@ static int bnxt_rep_port_probe(struct rte_pci_device *pci_dev,
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
@@ -7083,7 +7083,13 @@ static int bnxt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
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

