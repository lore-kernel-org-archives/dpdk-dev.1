Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FFCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 016634111B;
	Tue, 30 Sep 2025 09:06:30 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id A7E1B402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:29 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-271067d66fbso54699435ad.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192649; x=1759797449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+VFzjwDWq3oyf6ypGL9F9LArEfUW2em8ItgyWpfPSw=;
 b=Ic/5aoahhPROaIVU1IywXj/2G/qL39HN+zNHSbjOT4txqpeHdv1D5dZubIjkBGEp+A
 uStUa5eCtab14MXTIZnOCa25qAJcD95lUPAALKC7wGXsX5Fk4i2IzlGbSLHDNNRiak7m
 rP90kkob1ziex+wvztOQBnrQ7qIRuKCYI6nBHTazvRvwr8FMsVr7j440O5DkEKkM/uua
 /uDXhRew9u1wSkXiNNEwHshGwnetC4LDGNAN/eaJqakQuvKhXB9n/rBZi/3C59dKL7yV
 yJGJPbYKOKHJ62/RQU54MqugfEGv/aGVLgpM2U4ZmT1XuH0LSKX03FlyUzyfpC9pue5O
 A7oA==
X-Gm-Message-State: AOJu0Yyhx0eGuYJcLqvOYgnYQ2zB+QTMispk483iCVaJCS3YoPy306pa
 dluabDRXRGMIwXKSs6tU47Sxz5NDGdteHpsHuxaunJGsscQcqQufYVjvmadLgXvY/hoTptHxEPo
 LfO//2dP91q9vX+Chp/s9+TYfKeqPX8cWNVEm/tSqu+MZe7yGvLEPKQJ+ozUcA9gWIeLUuUkjVW
 xj9bO/21GUQNUyofTd98PEA8H2MCQ4rvAqA/TkRB8xxDRpiqP0qt6SNAY0Ynn/ajx8hcjDww==
X-Gm-Gg: ASbGncs/wfZMfHxXaMFihig/BAc39VHh+XuUp/9m16moiLvzK/q9Af5q0Am2/adEV9X
 lwTyAfjkFRPQKdkZoc56bWiLUqLmHuiFsgm60e/T1avhqJNZeUj5gs7NMphK1W1FKp1cj5zaayB
 3d0tZ5i5mNvvB5ajywxE4Ja4bGBA85Ykw9++IZcrJ0WdcwPAycKF3f63eFr9ftqq6IIY0JYkryh
 P+GqVwRU5rcgRgqV19Wdoc/JjVsTmsiVQeS3qrvY2IsIStnX3gXCEgR0dRcclKMVI1ao15ExjQP
 fTMWg9knyGid+vn89x3SMgNhpFVaFmvbRZalJ3sz7RCXvLOhudDFFTuFdOIyoHTjA0BH6Mz0cVN
 f37IRVhSmUczB/MldDGMroVDJRsHkNNQmIiG4qeqSFEcR1l5A5uHEIwcnPvC1ZZd2e+Ba0hEGGv
 1fTMV2iKA=
X-Google-Smtp-Source: AGHT+IFKHFFMv2hEmROlkuugU8/8+FjnCujreVtsfG2DoUrAkvvgyjsNUHouxNvImR5MFQNlBjQCxv5bKHj+
X-Received: by 2002:a17:902:f542:b0:269:805c:9447 with SMTP id
 d9443c01a7336-27ed49df2a4mr208017705ad.4.1759192648809; 
 Mon, 29 Sep 2025 17:37:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed6827e1asm10200015ad.62.2025.09.29.17.37.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b471737e673so6561894a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192646; x=1759797446; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+VFzjwDWq3oyf6ypGL9F9LArEfUW2em8ItgyWpfPSw=;
 b=JoYYn1NLdnQR8hyAafQR8T2Hz/WfUTPXPyh1eF77K//wpzP8c3bsXDpXrnGtkodUsw
 8zDKzoFOw8QS3ZUM+cfMhxC/vZDbke8ffb8adKbM7gpXoxCrvfOqi+FSEpMAr5GUJIsx
 68RTcXEhQOiWPjSvd9eAaUeNJFEC5C9CzsobY=
X-Received: by 2002:a05:6a21:32a7:b0:2fc:660a:241b with SMTP id
 adf61e73a8af0-2fc660a28cbmr12433324637.30.1759192646429; 
 Mon, 29 Sep 2025 17:37:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a7:b0:2fc:660a:241b with SMTP id
 adf61e73a8af0-2fc660a28cbmr12433285637.30.1759192645668; 
 Mon, 29 Sep 2025 17:37:25 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:25 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Stephen Shi <stephen.shi@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH 37/54] net/bnxt: avoid potential segfault in VFR handling
Date: Mon, 29 Sep 2025 20:35:47 -0400
Message-Id: <20250930003604.87108-38-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

