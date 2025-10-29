Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11AACCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37FD64066A;
	Wed, 29 Oct 2025 17:20:54 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 6828640669
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:20:53 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-33e27cda4d7so1247813a91.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754852; x=1762359652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RkDUaO0RXoc8m6SCJz0vfSCgy4ImkS9VAKx+eiiqkKA=;
 b=dG2EgxFGvXfHCPRbPjWdHeBO6I1NfOhtl5kyPfTmxHXCfxQwH7wgH5NOK4d+BEld5r
 /NxbR06cCppjTeMKWowppa8jBHTU8sZDwU4GGTsTIJSNH37NOHtMrDjCdrIJM2CXnLH6
 8LlXUPQJvcxULncbFgOhybo3l2ZCzAP+J7wo7M4rf40RT7WtInRHJetsMzXd+v69y5uO
 C9ymZ7gHskAcbdxF5DP9Cc1IRZTkwdstZprdynSpBIuF+vhIfUVDql466Qy7YfN3IYY4
 FJRC3XP6ZwRXCxnXsuquhweyDG6zCCmr497eoQK0UlnhnQjGfeK5XJuZGBt4x6skDCSn
 htIQ==
X-Gm-Message-State: AOJu0YzQb/ZoHIibgpT6v1rjC5zPvhCDJOD/dFWQldhOKQhDW5CeJ17m
 lNMfuQsbrLrV+ou4ro7AN7dI5HI3XGorwNAmCTO+iTXBZOLfltYkyO0QBWvokw+Xw339fbjcyiD
 xoH+frL4USG1xjMC5Riw+wAACeWfZ2x+xGoMKHZVQEzGJb+WtSPZ00WVY3nSyc0e5o1QT98qUfM
 2mwOpkwzB5YUG1MQlSk9m+dLlvrgfMJNKN9Rdnny/Dhyj2S6vr/Y9Q8EIX1WMbGSuoinYCWg==
X-Gm-Gg: ASbGncvtzEClRuWT5aYuf7K0+/+uU2rc3Lpf0qzkDkG2nlH+Ql1iv7kVQs54VBES0qk
 pm5GFLKZX8w2r5R1xlQbRRrQpb/W6OesBLCt0PNxSAGS6g3T7qx6XEvhIIt5XkDnmXOluBYvcRu
 23dxC8bINo0FtbBGX+F0oNw5Pm2Tun9sjIzx816hUdh+v+wymQWlRVR9pQjecgbZChXImHeduGN
 Ezrs+mB8HzeShhs3r6MVWjbhhDeXKkUuEGHg/oBdlXIjXP+G68/2/9HPHDRDizIWExOPDtqSYFm
 tmCHiPx40AUoHEKFQScIom5GA5OIZnJvRBVBMFYIDY6mb0eSxgf1TpDis3erxlv6+Lm5bHY/RKA
 3S1P5VikB0G5PDs+C/w0sdMyoIoGOHrLMdfpgWdf6FqXCiLPtB/h0FotVawPrxk96otbwmTpooY
 HoicPQfkzmEwyMXzQ70mxXKB4zPDrLDZ067HBk
X-Google-Smtp-Source: AGHT+IFVcctPOJNjZLiaeAcOf0Bc9rnNo70z4XzvQGIyO9RVqCiOV0PzPxOhySKCJdegkhKzmveZNZ8CNlt+
X-Received: by 2002:a17:90b:4c86:b0:32b:7d35:a7e6 with SMTP id
 98e67ed59e1d1-3404ac82ba5mr193278a91.18.1761754852422; 
 Wed, 29 Oct 2025 09:20:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3402a382b92sm166138a91.1.2025.10.29.09.20.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:20:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a5b03118f4so293050185a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754851; x=1762359651; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkDUaO0RXoc8m6SCJz0vfSCgy4ImkS9VAKx+eiiqkKA=;
 b=VEdWzJl9PPipo9yBQk2z2Kc0hhPfDuS37RjD4CMeFvTL+7VseMJy+/mtbStUmGXs1p
 A+7/A8hpy9JhRKU9fgTkZR3L/1erVRyGPuG9Eq7MWazMUNUvDUThFA2cdpEIbWA1uV9H
 xblfVV3kEGzJvXVcc2fqc4sM0RYS1v6Dp/BHA=
X-Received: by 2002:a05:620a:3714:b0:89f:3fa9:d2d9 with SMTP id
 af79cd13be357-8aa2a559c25mr32770685a.7.1761754850588; 
 Wed, 29 Oct 2025 09:20:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3714:b0:89f:3fa9:d2d9 with SMTP id
 af79cd13be357-8aa2a559c25mr32764185a.7.1761754849992; 
 Wed, 29 Oct 2025 09:20:49 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.20.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:20:49 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Stephen Shi <stephen.shi@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH v5 40/57] net/bnxt: avoid potential segfault in VFR handling
Date: Wed, 29 Oct 2025 12:06:55 -0400
Message-Id: <20251029160712.58519-41-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

