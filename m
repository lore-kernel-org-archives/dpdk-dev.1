Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A9CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45EA0406BA;
	Tue, 30 Sep 2025 09:05:11 +0200 (CEST)
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com
 [209.85.210.99]) by mails.dpdk.org (Postfix) with ESMTP id D2197402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:33 +0200 (CEST)
Received: by mail-ot1-f99.google.com with SMTP id
 46e09a7af769-7a9c15464f7so1380101a34.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192593; x=1759797393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=805lZjX2jdDGYGkrFvla+zLPmfx9Pfc7jTF7wfcVhwE=;
 b=pxdgOxosYv+O21KnUd/uq0PwAm3XALROi2BRRW0FSiKGGJAR6kWmhDx8s4KS/LtLjy
 JCy3y1EbCizRZY28WDsyxbnREPJDlQlV6egcpIG0SPRhAqJlS31LyGOu0PDUSlU8+sNX
 PxfKCOUd36uvzLbjxo4bbF9GDX845gdUMoJeaospCuaaYekoBYrYB6jmiRjR5D/IP74l
 Y6C6Ztxo9Nbuo7kBbdJwNXH+E+nPo4ZsyDZ/h7xWHkaqoG7SG7yCuv2JwC1j4iX2bs0I
 fni8SCBGya5/q9SjVT8SA7JaoMGNXu0dhasjr+r09GHkngvOewR00YDahTV7ftMjY16q
 XiQA==
X-Gm-Message-State: AOJu0YxjaZFrde6b8WQhu7xuEXA5rMeq1UWVm/lBgFe1RQ/6S9Ory6CE
 ypCLEov/yRgkBxohgolr7eXMGrd0xCoGTUavlwmflwOmmr8cGdMbPghpETd+IYOXEg5N/WKlIfA
 QBZDOBDJvIm/SWhIkJmzsrEzhJB4WL+GjqudjSAkcgkq7lD+rOcYrfZkMtOLYITLxomG1aAQvw+
 Y2X7SiIxdKBuVn5LkN+dMWHciU0Lu1FMXDMsPQFRnPbbNqUt2xsWO2/KI3J05QAA5zPFVmyQ==
X-Gm-Gg: ASbGncv2o5X9kbiUFO5LhHIs3RoqnpUrqtkJr5BnOy6t8om//mf+L2vL4gaeTNGKbRz
 pk+4ODoveHp5Ux3FeHSrzXT7ah8EYn385dUIG0SpXisEHlYhpzDgkum54GtU9jfYV7Yi96dBqT6
 Z/KM0Ll47jUjD348+2WjztySBDJuS7gB1uNhqo4xAxZDrBRveinEN2luv927laa8wUIxA2RH0kh
 4QQrRdSJ0L0wkdh5s01jEWWcowRGg+GR+UiOqSHAFnUsB9OTbyyyTUxmkAHU2unoevNtSF/AphW
 T3gG4HjOgJ2+HF0UVk2lMAffpfZc9qC912LzNuET1Niz0OqwjCGxHBjRgW8HepMWYQqBUxqltl5
 7CGBnsEhmZ1GYSuUpKCbGqS2cW88i0CYzYRn+nmZNVcq5ILVvOfUemvYJUPqzGfiy0jivLvsO7z
 qnTw==
X-Google-Smtp-Source: AGHT+IG+WeHFmmMkOdog2r/Ct5pZdn/Qq6J7lVDvl7ay+kTFEKERJgOWnVSCf35mt4sNGed42wjP7Y0KNa8Z
X-Received: by 2002:a05:6830:3484:b0:758:1e20:c41b with SMTP id
 46e09a7af769-7a04b05e2b7mr11438152a34.33.1759192593070; 
 Mon, 29 Sep 2025 17:36:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7b4c0e92ee4sm205693a34.8.2025.09.29.17.36.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78117fbda6eso3929268b3a.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192590; x=1759797390; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=805lZjX2jdDGYGkrFvla+zLPmfx9Pfc7jTF7wfcVhwE=;
 b=PCcAHrJlbl3Xrxd2bB3FAf5gyNdpVAoe3Yr8bc0d72zvXRJPB0SXUd3JcSND0f7Q3w
 y0lPQ2SuoWwE5DC57fo2y6KuB/UHfHUyQfCexDx2HBMEyWSX3Fw0IXHMspix3adiyX59
 DIvAPlGo4op7NkiGp46HCjWzHsIGfMpYVtsFE=
X-Received: by 2002:a05:6a21:3394:b0:250:429b:9e6d with SMTP id
 adf61e73a8af0-2e7d1ff03b0mr22475116637.44.1759192590380; 
 Mon, 29 Sep 2025 17:36:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:3394:b0:250:429b:9e6d with SMTP id
 adf61e73a8af0-2e7d1ff03b0mr22475087637.44.1759192589793; 
 Mon, 29 Sep 2025 17:36:29 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:29 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 02/54] net/bnxt: fix a NULL pointer dereference in bnxt_rep
 funcs
Date: Mon, 29 Sep 2025 20:35:12 -0400
Message-Id: <20250930003604.87108-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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

