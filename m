Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4FCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C68EA40E0A;
	Fri, 10 Oct 2025 00:16:23 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 624BF40E2C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:22 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-33292adb180so1405830a91.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048181; x=1760652981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+VFzjwDWq3oyf6ypGL9F9LArEfUW2em8ItgyWpfPSw=;
 b=npDT0kZoY1Lks2LN7MFSi2AhhpPJ7GqVRv9DIBKduEg9wLigXOro/IaDiSRJtDUrVR
 7WemhU+RlIM9qqhbRbbMtdwy4wFgTN+wOmW5KPa4gDh+oqUxmjMIY1pJ0RwLA4HeaHzg
 7l/LQJRV7G6J+yycYGVEO6xVt1owjSjOwoKwBSEl4zNdqo7U5cYof+utHVb7hieXH5Hw
 jQ9jMFJYBeJNIC880UwQXt7h7cUUL34QcuxtE9K/BBwP/df6jZa77XkJ4uJbX9QhORST
 ZqE5o5k715aS6cVYxY3/zoebvWt6Hm2DrUbJIsp5BWQHATlJghf2fRvjHzRPiY1Vfd5I
 AQAg==
X-Gm-Message-State: AOJu0Yyc01UFeXE8F+MBqiTUH6xKEOgyAkf2Hv7mGbhcqllB2lT0+GV2
 Dn3+niPRsfcPsAhkfodKieoYew4XTgPeTvEy+U8rs5yPi8sJ7agVAxqMfvD166UKglapvDw1V7U
 7wllN3C6wNs2nJgHRknayl+3MK9NC9oP9HQBxXzOZjavRguJGEwxxsKrYovCEpPx7k0sEYK0ZRV
 xfoL6ZyIlN3qVRiVMcGpzQnEDHWm3tsaIODU52jWTL0/GGp7M2T+AmqvZ0/PCSJbPQ/ZlAHQ==
X-Gm-Gg: ASbGnctVh7cgmspMimxuJMfHgWDRHWYXhvHjWHGWWaceBLMv+ogz64XmdVDKMRzxC24
 LCtV4ZC6C3aUPvQyDKYVG//4NDOS8R0E81UJNg/OxRnuP9oZtctcAYYoNc5rJuuE8DZizN7iVj+
 XutM7TYx/a/wt/bUFDY4LAkmJsUsyJuJmItaZdtM6PsR9GBRf4AJqglzTStqds/gKhEaYkVMWJN
 c957t1x67uqTKz28Qxrqc2FmbUsIB9ChxeaHtv6N6vr9JpmH4LXZMn4/wkSMyybYJnSd5yUNRMo
 iO80aAD8xhijkMTLpjSOIV0HJS7AEqLm0pXs2k+rCouR6hrbwRLVFErgBgZHNUdqann1Rp0kdTZ
 FQsyx0glExf/iTMCnJVGeRz1e4SAV0oMbT2BJW3lBPH885//ncKo0XmA0OPv/8J3Jrci7BnYeef
 DAg8QM
X-Google-Smtp-Source: AGHT+IH5C41ibx64HKcSoRWwrXHcJmXsGNvloLq0ZffhNOPaAJeauLQXKWk9yvZnTpTiPgpjMxOwvTigF3Db
X-Received: by 2002:a17:90b:1c8f:b0:32e:32e4:9789 with SMTP id
 98e67ed59e1d1-33b51105ddbmr11893216a91.3.1760048181435; 
 Thu, 09 Oct 2025 15:16:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b61a85229sm84970a91.4.2025.10.09.15.16.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-818c83e607bso28032226d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048180; x=1760652980; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+VFzjwDWq3oyf6ypGL9F9LArEfUW2em8ItgyWpfPSw=;
 b=aOIvHwl4QN7ODuKZxe1X/TvamtkiA61Jvu8zGMdHz7qQj5jSyQfHPHVulsZMD2xQkZ
 qwkPU0ISfMmoonkW881Wz/hQ3+/W1175qaGqci1FT65pSqo0/6xNXZQ7u82vRe/19a4x
 tKUTvBw7Tml1q7fS61+CTqN23hlz6VeqFbmGE=
X-Received: by 2002:a05:6214:f08:b0:879:dc43:6321 with SMTP id
 6a1803df08f44-87b2101ed2emr127096686d6.20.1760048179806; 
 Thu, 09 Oct 2025 15:16:19 -0700 (PDT)
X-Received: by 2002:a05:6214:f08:b0:879:dc43:6321 with SMTP id
 6a1803df08f44-87b2101ed2emr127096036d6.20.1760048179181; 
 Thu, 09 Oct 2025 15:16:19 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:18 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Stephen Shi <stephen.shi@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH v2 37/54] net/bnxt: avoid potential segfault in VFR handling
Date: Thu,  9 Oct 2025 18:11:12 -0400
Message-Id: <20251009221129.28256-38-manish.kurup@broadcom.com>
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

