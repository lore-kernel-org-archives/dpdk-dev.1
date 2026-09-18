Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FF4C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DB4F42FFB;
	Fri, 18 Sep 2026 05:24:34 +0200 (CEST)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id 3E4E042FE9
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:31 +0200 (CEST)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-86a46577018so272922b3a.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701870; x=1790306670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XVyCJRGHMd48gNZ1JAF6/eKiGLLHFJo05fI3+RhCztM=;
 b=XTZx02f27YH2D+KjHlac5P7hKbQXiU23mkcxaB8EzLQbRXgNUuDNc03Oar0eSTWWTG
 x6c0oTqZq3Lw6IDvG7TjjbP47zoPsBiiQ/VDcaFMDI5MtZ/20RndgzwUTj6mVwpc5tTK
 phiyUcB48vSdAP02BqFrSDUx3PtLRkYod/ZC1LV1JzS1SlbOOzNUtXDvpvQyORxTlNp0
 DBucJ9RL//6Duu9y40CIBAELR2Fk01BV37psjho8EAxdWc2dubIcS099L0//vz1MFr+K
 lyayXiSsb+LENP0axuEyjg64JeQ4WV5K45FtrKkz4Q2J7MFRRq+V76aT6m2YMurN/NSH
 /j2w==
X-Gm-Message-State: AFuF++m0Ey02ABj9VilfxTUNcSn7ea7ydh3SHEvANiYIcsdzLk9c/H18
 R3ql/baB3NWMh1mM3RjcQGIPZ0KaJjFhldJrroX+Omm9CCRmtJIvq8zdaLXj6Glr4G+/Q/4meUN
 FsssOv50SdXZW/BM6dmkN4fV91Gf/qE8NzYjBkXB80bWuYBzgiMIu6q0PeBPaRS8sLvorHK+cDO
 dsp3gpdkAxdF+8/ZxJUlNB+FML0m7yz7HpLyvRx8PHT8ilGHLnurAzWMQ5m86Iw4YD1ybowIgfs
 xzWr7+aSFSC
X-Gm-Gg: AYBFou06q8R4WpFTqb/FLe7FWfYUn0dhMwUDOndfO2ij9PMmnoRikuGF7wkRoH6n5/i
 Cq1XpTBvwXox2fILdN1ERM8tEoVo2Ul1waXBFxifgeeG51R14ZaoRTStVH3V2CyWHjtGrl0nZ8n
 ZvOcPhT+8eB53unstDqNnxsaSstI0z3Ubp5twNglKz3BoHbQToIiOEUP4KdtkoFTizzmxXF9VL2
 EJLe3Ll5JN6Es5apGqjtPsOwnrdmQO8KvB2UchnqFR6ai0mcXCSBJbltooMoFzbEHSSo4pYvLJI
 n+JvTnPzcrhHhufdIwwaOYmXYsnVeEQXNCQ12HdTA0ueFWq4DO00j6EWtHuzXNRW2X7bA0CTbfQ
 jNxbn1SwKfDsL4Zv8UZQlD99cS1MDx9CPPa9P3o7Uu+WhKHdi3nzR5KeiEcehUyRCuqSlcdESRw
 2jV+7iuQYQOscvwWXVrT0dVwzjCEcFHwaKlaaEDBh08H6DWNzRHw==
X-Received: by 2002:a05:6a20:d04e:b0:3dd:85aa:4531 with SMTP id
 adf61e73a8af0-3dd8c5d8f31mr2477525637.35.1789701870296; 
 Thu, 17 Sep 2026 20:24:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc5c50b0ba0sm175448a12.8.2026.09.17.20.24.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc18ced1a5aso514984a12.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701868; x=1790306668; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVyCJRGHMd48gNZ1JAF6/eKiGLLHFJo05fI3+RhCztM=;
 b=g7EI3KlqJvbY39yBjAW9IQXtaHl1fA8fzdJsPP9pjs8edYhIpRcEXpCLjOe9IbPKfS
 P4X/N7tVKzgKYyhodQ9HbgZ144iiV41isDvQEoW4J08UvkWwDFTtyGIRNipDs6PNSzoX
 mxtoWPzgp5rQkMv9X5zPqq7iSvgAQ6O2dyluo=
X-Received: by 2002:a05:6a20:c68e:b0:3d3:afeb:880 with SMTP id
 adf61e73a8af0-3dd8c58df13mr2680787637.28.1789701868654; 
 Thu, 17 Sep 2026 20:24:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:c68e:b0:3d3:afeb:880 with SMTP id
 adf61e73a8af0-3dd8c58df13mr2680735637.28.1789701868172; 
 Thu, 17 Sep 2026 20:24:28 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b023bsm597708eec.23.2026.09.17.20.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 4/5] net/bnxt: fix memory leak in VF VNIC query error path
Date: Thu, 17 Sep 2026 21:27:25 -0600
Message-ID: <20260918032726.763384-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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
index 99539d3705..dee35758e1 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6280,8 +6280,10 @@ int bnxt_hwrm_func_vf_vnic_query_and_config(struct bnxt *bp, uint16_t vf,
 
 	num_vnic_ids = bnxt_hwrm_func_vf_vnic_query(bp, vf, vnic_ids);
 
-	if (num_vnic_ids < 0)
+	if (num_vnic_ids < 0) {
+		rte_free(vnic_ids);
 		return num_vnic_ids;
+	}
 
 	/* Retrieve VNIC, update bd_stall then update */
 
-- 
2.47.3

