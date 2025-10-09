Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB10CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A401640E20;
	Fri, 10 Oct 2025 00:17:00 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id B8CDB40DD6
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:57 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-78defc1a2afso22317926d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048217; x=1760653017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuLGH3yY0QftvblPy2/QYDcK1QBuOY3rdtImcr+3JJY=;
 b=D0C3i+DavcprXzwNjgUJBrorUnaT1CGJrcgArBoSsNxyEgY9Lm0OxnDhtrwY2C1z7N
 9ZeW8g9cumNP4qJ+s9CfCIPw+9Se/kgiGducV12fJfm0131zP97NaFB2sxSBPivtgOHp
 jqOK4itVHaV4nDjSwwDeaZDiIOtQ5TaeyPweL2+dhf9n5PV6TimEUajYMEJIqVcyYwtk
 XTdqt3Xu37qbk95Lj+IX2A63GhXA81b0RAjQyF2n/wjDPraRixRzGOaVwIABIiWiPHe+
 QBFwJqWYUOZx2NtgGC8kZfekc86pfpZXpk69ggVMAyaKS55zmcS0EKOE8ojBj/QmLJJc
 bwtA==
X-Gm-Message-State: AOJu0Yx0HERdfQJD0JBUTZ5lltwBKSZD6yx1Lh7F5gmcS0vMpD/iA0mY
 5eJTQmPlacFiwVH9xM4SqLmCGcry7eO35TlpJPzfAGgWvJQXNaKLlTnoDCKGuJbPIcuUzd+se0x
 XarKffL0pxyx6iCM3u9hsMn4UM4jHkFsFjjLoKhqX6ft0A2BRiW7ZyEuJBIP6JFLInxhMujRC22
 zEt/J51xblWXTF9iIjAN+XoEGT7tjpDn6iiKdcFbC8jJPyv/M83/lXfOs6/KMXitq+9rvOLA==
X-Gm-Gg: ASbGncuc2ADF1sPfGOtPpl2FQn5RoEAfs8HGS/y91rcmnlcWGpR5cjqDa1Uvc8zcwQF
 MJVT5AA1rVhmX4EQfVGp0lB8uLWy8ublVy3p2xlghViCACrT91HA5H9hxBDw9wEn7Gc7bD0AbE1
 S+2dUVo9vh+CL6ZZ8oKZshnfuTSup+IJ4pRMKsyZtBWcXcXvw+F8397SGBuk4k7SKc1uKkksNUD
 1/OwjCunK0Vz10WEbxgJ8ko9+zZ5PgHh7fFgvuLbJGtUiHH1JPJqBQF6/G4coyu3p7uiEArU276
 RljkZaR90zyZngP66fMPf8m99Ws6npSnivRD6jVotLpUJRqbOP3CibZoHA6nwRqFQX5PxTLLsn6
 QuP7NAgjD5UKo4bzYNH6zIE51LrF9B2K/T2qBaz6GNpeCvk/KAOlQkRigqVuCWfjHoxX7/jrnSR
 QqzyQG
X-Google-Smtp-Source: AGHT+IFlhDwEhurlTaOhnA8Llq3qMWDRXtLf7HekasM6v8wYmQZf/eiqBWgZobcSxC93/tXsI/kDf2PW2a26
X-Received: by 2002:a05:6214:d04:b0:824:c08e:1840 with SMTP id
 6a1803df08f44-87b2101d77fmr113114456d6.21.1760048217056; 
 Thu, 09 Oct 2025 15:16:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87bc356a8f0sm318466d6.37.2025.10.09.15.16.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78e50889f83so58303166d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048216; x=1760653016; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuLGH3yY0QftvblPy2/QYDcK1QBuOY3rdtImcr+3JJY=;
 b=bF3du1hSmHvxD5s/ahH2KSpKNoxIezTXMEMascAm5EoWsN7KiTm8MqA1/WyV9kAkJL
 OhcB2sekKq5Jb4kvcMIv/8nhLyAi8BKTwMl0ziz+6DtgbGxCAao6cpZFrurAQunHbZqd
 Ay4RNoRrJEZf7+oUYmDxaXIW+MV9muOXxBSMw=
X-Received: by 2002:a05:6214:5002:b0:81f:3abf:dc1a with SMTP id
 6a1803df08f44-87b2ef373c3mr133481526d6.49.1760048215872; 
 Thu, 09 Oct 2025 15:16:55 -0700 (PDT)
X-Received: by 2002:a05:6214:5002:b0:81f:3abf:dc1a with SMTP id
 6a1803df08f44-87b2ef373c3mr133481036d6.49.1760048215286; 
 Thu, 09 Oct 2025 15:16:55 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:54 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v2 53/54] net/bnxt: add support for truflow promiscuous mode
Date: Thu,  9 Oct 2025 18:11:28 -0400
Message-Id: <20251009221129.28256-54-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The truflow application support promiscuous mode to enable
or disable receiving the packets with unknown destination mac addresses.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 854c8b7371..f37136c8f4 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2161,9 +2161,15 @@ static int bnxt_promiscuous_enable_op(struct rte_eth_dev *eth_dev)
 	old_flags = vnic->flags;
 	vnic->flags |= BNXT_VNIC_INFO_PROMISC;
 	rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, vnic, 0, NULL);
-	if (rc != 0)
+	if (rc != 0) {
 		vnic->flags = old_flags;
-
+		return rc;
+	}
+	rc = bnxt_ulp_promisc_mode_set(bp, 1);
+	if (rc != 0) {
+		vnic->flags = old_flags;
+		rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, vnic, 0, NULL);
+	}
 	return rc;
 }
 
@@ -2185,6 +2191,11 @@ static int bnxt_promiscuous_disable_op(struct rte_eth_dev *eth_dev)
 	if (bp->vnic_info == NULL)
 		return 0;
 
+	if (bnxt_ulp_promisc_mode_set(bp, 0)) {
+		PMD_DRV_LOG_LINE(ERR, "Unable to disable promiscuous mode");
+		return -EINVAL;
+	}
+
 	vnic = bnxt_get_default_vnic(bp);
 
 	old_flags = vnic->flags;
-- 
2.39.5 (Apple Git-154)

