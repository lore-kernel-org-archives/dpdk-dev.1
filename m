Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E78CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2B840A75;
	Tue, 21 Oct 2025 19:51:47 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id E549540A4B
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:51:46 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-269af38418aso72301035ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069106; x=1761673906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+Iwe3jUwnSBjjEGCAF0E0ql5UZ4ogg8jjbUlR0FFbQ=;
 b=aBSoq30pZoN5V9nRqvIpExpOcQMc4zwhztt8hyMSX4gHC5WX8jLgdjT26vk7hlbyG+
 DIAndWCLQ8ZRKsZP4qq57q8fCet5IKyl1CZ8Lm5KrmAZlh5r1zSsm/Fox2tFPyKKpPOi
 zilTifsUmIfRg4RGV8loGAKsHw74o2fwXSP1Dds5iLUge/ijl/wi9ZJazeOUKeJBBwUv
 +5RkT78SYuKvZoSMOQyvdIOsSqX7xRieBX96kj2+FJnXR7Xwy7DG/3RD4Om/LCPxf5gU
 3bPMgrXzvPXFeZQ7/RLLgrWyolC8NH5bn4k8drE1MWmnEWqCE8i0pvF8OhZ5DB0/1dLd
 6hCg==
X-Gm-Message-State: AOJu0Yy/OupjioD59d9NEf/6KYPg9BNFats+MWBbVG+xEzJEhWPVWVjX
 SkC5lnjUqyZY9VxnJ3p+UA69/48NjYJ8+zD9WH7P9OPzdE4Pay9sNYuZbBaai0xhHLTOeQy0oW4
 meiuFO/cA5x4Tmde5FLwfitaEg63Onsx5eOmwBbDiu/TLMvaW/Y2n2AvJzZvGy7AAkXGy6Xzz4u
 SG+Tmba4BvvVXlRCZB2+3APAA2Y4brR+uFz2PvvqpjkmIFB+hqfII/jbl+sWIVwCTYfm0gBg==
X-Gm-Gg: ASbGncv/ShR/4BLC+96pky+n4R2cwe1Be3WRHW/5pvI1dWZ3GCoW53ldSbn3jhBGaYW
 4Jp0iKK9DAfq3mgm3ayPuq2Y3+JflYtt/UhqkypVJ/SDNfEg3DxayitbMJoDqQ1YcCPAohRSwOF
 8dv11cDesjfRnSk4nL07BKrEGFszER4w/TfDRCD//G7fkpCszcb+NeMLvZselv+BIpVNp0Alg7H
 c7M/KTVc+pm4jbcICovWfjXv4Yr3xRum/r/mNz/2OQEl7EbE0RqUiMIolr3NFFlJ0jMAsdfu/AO
 QfNRM7Sc+dvtyqfQYPmyJLA4BElxfTDwndGoMDlOYI5LXNj2+CzkvaFrQxJmI0cSTTkQjeV6Nml
 iF78925802llkY2OJlEnbkg9HJNgIDEQaAGSap/QrT0awGfj9gsrsu/Q1Jv3IOqyokiF64uHF0T
 UIqXsgSbSMYvRF5iQpNjooEOC4bXjG9Xw=
X-Google-Smtp-Source: AGHT+IEB5v2F5JG5Cdof3cHZqhKi+7xPxyWlxQPfJN7hJUwLk7Zr8P/gOKxJNwwXVzDQJV67VtpSa0c+S9Kn
X-Received: by 2002:a17:903:19e6:b0:267:d0fa:5f75 with SMTP id
 d9443c01a7336-290c9c8a5b0mr254090695ad.1.1761069106023; 
 Tue, 21 Oct 2025 10:51:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29246fea2acsm13596225ad.14.2025.10.21.10.51.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:51:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290d860acbcso103148115ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069104; x=1761673904; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+Iwe3jUwnSBjjEGCAF0E0ql5UZ4ogg8jjbUlR0FFbQ=;
 b=Hb8OvcdDyc4H9Cht9XhybtoOJYgo6mzVYRYZ56CjW8qnpzPPHxFge5tkAMFUVZpIee
 Y2Oby/MxghMwXmfG4veVZFm9Cw+fb0njg+I3rwe7CfG6A6RrHzBfPyKGFO06AVDV2ejk
 7fszm0AZjWQZC/tuffFMyt6zWlT+wRUilZNq8=
X-Received: by 2002:a17:902:fc8e:b0:267:ed5e:c902 with SMTP id
 d9443c01a7336-290c9cbcc96mr235295425ad.20.1761069103783; 
 Tue, 21 Oct 2025 10:51:43 -0700 (PDT)
X-Received: by 2002:a17:902:fc8e:b0:267:ed5e:c902 with SMTP id
 d9443c01a7336-290c9cbcc96mr235295015ad.20.1761069103016; 
 Tue, 21 Oct 2025 10:51:43 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:51:42 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v4 05/57] net/bnxt: fix a NULL pointer dereference in bnxt_rep
 funcs
Date: Tue, 21 Oct 2025 13:49:57 -0400
Message-Id: <20251021175049.46092-6-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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
index 43e4085434..c57c98a911 100644
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

