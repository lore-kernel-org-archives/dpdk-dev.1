Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E33C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC4340EE7;
	Sun, 20 Sep 2026 20:14:24 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7E20540E49
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:16 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccd5cef0so1543123a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928056;
 x=1790532856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=kncqy2yQ1PZcNeOUomxVL5gXNcfpknCJK8G7xEbm9Nly4GJqAvImZrkEMkyNe9LmLb
 SsgUrvMrxit4ZogBCpfXF29PBVPD/lLemxZRJL/iO3mch5PDPHCY+RRcIsGMdJ/IOdFj
 X01nGpWngmHwz/PCWPjzvzvrGX6WlZbUv8od+ZyxsnV5YL5EZ6pKvBKRtfsHea9/g9Xr
 EjaNUp25gNR0NDCpi2r7WuarWoMuAfuFDAL7ac80HUjJ973Hp+Pgvqqp2k0mznxC0dkI
 1RnJNS2WED2mMPhos8yt/gIneJTh/eaQkjkutyGDIxY3A24U2af41ggRHrWvVaFh+6KG
 N1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928056; x=1790532856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=xHb0QAxxdjJwKo+TugRYSMguzf7BblF+YuO2GtRjBFD0tl9zIL6RfW7lCED87htzMi
 usBSfeq1CqyOQBlI18OksWt7CFlcGXqUL9MXYv7wx7hsGmjycafZaWEJjb3Dex2ul4Ec
 eWf29YRnxoW6b+P9aRhBy71iJPCNMHuJOwxHVb9JwfLXTca+aVEIur4mjO+btdvAFCPQ
 yQL0gOIKHBehtDH5HAJAT7A2yGnlfJ5a8gKQhTyaV3eqO+JHjDdtDM8p3JueQ75xa5UA
 oFw8+ixf/F7YjN816CmnyoR7DgtfD5/zYUzV8jLlJMzr2D0fC8RmAQ2UEh/1fM1WREbN
 zllg==
X-Gm-Message-State: AFuF++m9pXkgrg4e4m8QWLdIa2VxbmRLa7jtQ2prpP+E56nQLWT41inY
 cfEg6xcRRYNI7xLXrgr7EiJHi7JeZh5OeMq3BhulI0LCx6rBy5OR2LSBwEiMWdE4nof7ALnSC9C
 Gwlq0
X-Gm-Gg: AYBFou3A3MEepbJa4e/LWUPLULWvUCTJtls1X41/C7s7WUHVwGJx9jB5wfLj8t918Ly
 LtHZMaPt7MEFpITYCLU8AW3a7hA4lXLzg8RoEyTp4vv370heXAe2YSIOSepkWkfOMSEIGEzBGP4
 k3u2dOAGHh4KyUdekaSkBZoIykuscfGBpi/rcg3fdMpFXD/qKH7Seyo+R/6VTYHnWGJuybcTBfC
 HteyV2i67pbzVu2iMGi7a+BSvXrDtsoCGWiX+P6XbDOE3zjsqsUzRiu2dFdCdh6nFTb4ptxMfHj
 ydgf4oNTxHCf2JiK85NMwcMoDz5qIA5FX9Eaa/915y+7TZnMU90+/z0IuZVIeEdKYyZaXlbRR0I
 6nlOkEBZOSf+tG1zYh8Y0a6tna3hPG+ekGTAdM3qZwuUQG7TZ3oCQPpc6dgsdpuNRT9F9w4c14d
 A4vAQbijoR1JBFqAIxG9h9GTvIgmLo0b9AxdOnjO/VQ7gPVnu0N8RbOP1uED2Er0eBHm7NuRXyQ
 4AtLaOUodWllAhmHphUS/qReIjsd+cKUd/6iw==
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:f478 with SMTP id
 98e67ed59e1d1-39e6c69f5b7mr8092275a91.55.1789928055644; 
 Sun, 20 Sep 2026 11:14:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 21/33] common/octeontx: remove redundant barrier in mbox
Date: Sun, 20 Sep 2026 11:10:13 -0700
Message-ID: <20260920181347.747210-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The SMP write barrier between writing the mailbox header and ringing
the mailbox register is redundant: rte_write64() begins with
rte_io_wmb(), which already orders the header write before the
trigger, and does so against the device rather than only within the
inner shareable domain.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/octeontx/octeontx_mbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/octeontx/octeontx_mbox.c b/drivers/common/octeontx/octeontx_mbox.c
index 9e0bbf453f..8b0da3a98e 100644
--- a/drivers/common/octeontx/octeontx_mbox.c
+++ b/drivers/common/octeontx/octeontx_mbox.c
@@ -113,8 +113,10 @@ mbox_send_request(struct mbox *m, struct octeontx_mbox_hdr *hdr,
 
 	/* Write the msg header */
 	rte_write64(new_hdr.u64, ram_mbox_hdr);
-	rte_smp_wmb();
-	/* Notify PF about the new msg - write to MBOX reg generates PF IRQ */
+	/* Notify PF about the new msg - write to MBOX reg generates PF IRQ.
+	 * rte_write64() issues rte_io_wmb() which orders the header write
+	 * before the trigger; no separate barrier is needed.
+	 */
 	rte_write64(0, m->reg);
 }
 
-- 
2.53.0

