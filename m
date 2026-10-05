Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0714ACA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:51:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 140E240E5E;
	Tue,  6 Oct 2026 01:51:11 +0200 (CEST)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by mails.dpdk.org (Postfix) with ESMTP id 9A16C402DD
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:51:09 +0200 (CEST)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-930c0f9c1b1so3226685a.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244269; x=1791849069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xLHU6z1nDHcmrU7RPMOhzAjXnwBla2gbd5DG81WVqHE=;
 b=FMqdj4EJ0Xoh82vz8S1S9t5WpuaL6GNbPKCipHRnKIn5/+qEZjn+vy5ebMbEbUQqXN
 W8+lzNpF+z9sHlvrHouyomYsblZY+UnIRB1+08kD1wqy9UQU+INedOsMWByEziormuCz
 dw1KzIgI66o5hoqnw2rGiSaT1xM/yAOBk86XJCorVQJ4hNUNzVlEQNjHGOiDOB6Ak7Ax
 XNbEyVOV4n9YLFV+IEOLgRMAEKSHTvkyZJrDrGlLqWthsbBr3PfbRWuBEze5UTvpETM6
 /foVEMI12c+GtZ4FKN+Lie35FjOiCtcSDUVbsDdSFH1aWxQt0cL4+8TnwbAeoycuwdrb
 b0OQ==
X-Gm-Message-State: AFuF++lAdBJnrahT4wWISXnCPGOei3odOGEw16e9Vsmz3QXZ7JcZshF7
 bLKgzkQfn8pNsSrZz7JYvO2JhGV6K1CmyamRkEq2jdvlHh9Y4h3ibzhd7Tjy091b/W9wkyCCN1a
 rHPjrtb6Kh7ADMgPf4Hf3G7b/NAH3W53ldF2mzbdBwWE3AXlDjlD9ec/L1BvdmCEZkqF8QFg6BF
 QrGdZ+N9bWm71rU4q1lx8EMPwz0DCz0ffRnJJVqsGMymRHx+3+cppwysWMx34XsyN8dmyIgg==
X-Gm-Gg: AYBFou1+5RDTtvqAxXxFQhYnidxukxu+sp1RIGPy4bsvw4/jnbncDHjYf/Bc4S4T9d3
 N3basZlYqMe1XfshLi6qDxk18F7JWGSa31L9LvHK3PJgEBdzGeQRNYRSAqr655KBSlAqeW902il
 OoMjGjvwT8e4YsEBykQNpprSJurDJihH6UYIENpLpeLSBAzAv16fv1BzBgRM7j8p2sLRMgk6R6Y
 m0BI5heAimyuj3AMPJhAUXP8rbojP0mcNO9N96CFou7neqNUIAAdt/NgGwqcqmp8hs5ynQ4T7oa
 YQYEIm3KJqL7OmqBIC1XVnvi6PvGsv50IEepy7kdiVAnWtIke6tqC9qdNVjXEX3EJ/ne7mevkX6
 bKeKDrTq1G1l6Q/VSua3hg0QlsXaK2EeZUt/dlUNizySbHGLh0dzBtYIwKbbtsX8GpnX4qXmn8X
 JTXxlRwjGkfJ/mgbRGTjk0KHB/WSaHt0aXMbcZfw==
X-Received: by 2002:a05:620a:44c1:b0:93e:3824:4123 with SMTP id
 af79cd13be357-93e38244209mr2022452685a.65.1791244268701; 
 Mon, 05 Oct 2026 16:51:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93cca32f5e4sm448347185a.10.2026.10.05.16.51.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:51:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so384325985a.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244268; x=1791849068; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xLHU6z1nDHcmrU7RPMOhzAjXnwBla2gbd5DG81WVqHE=;
 b=TdgZ6e/g7mcsFBTx4pY4hDz3yLGRkBsR9Hu2npX/jtYW6cgdFsnF+8KMeG2pcQ2BiZ
 xuSx8RZQBJoLyLTV4skAKBTHtox43t6PPWvrgJrIZPbumWO3lQ0QbEWyqjewSP6Amv4f
 GE1lVxa+GGcFImb7DYly7sIK6+99j4gXsqXhk=
X-Received: by 2002:a05:620a:8004:b0:93e:74e5:2b1a with SMTP id
 af79cd13be357-93e74e552d7mr706457685a.10.1791244268027; 
 Mon, 05 Oct 2026 16:51:08 -0700 (PDT)
X-Received: by 2002:a05:620a:8004:b0:93e:74e5:2b1a with SMTP id
 af79cd13be357-93e74e552d7mr706454085a.10.1791244267399; 
 Mon, 05 Oct 2026 16:51:07 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca27f50csm998041185a.34.2026.10.05.16.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:51:07 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Shuanglin Wang <shuanglin.wang@broadcom.com>, stable@dpdk.org
Subject: [PATCH] net/bnxt: fix completion metadata format type for Thor
Date: Mon,  5 Oct 2026 18:51:04 -0500
Message-Id: <20261005235104.27284-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

For Thor, the default RX completion record metadata format should
be set to Type 1 instead of Type 3. Using the wrong type causes the
driver to misinterpret completion records.

Fixes: 0c036a1485b9 ("net/bnxt/tf_ulp: optimize with inline and prediction")
Cc: stable@dpdk.org

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index a75da8aa19..70e5700833 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -480,10 +480,13 @@ bnxt_ulp_port_init(struct bnxt *bp)
 	/* Make sure that custom header data is selected */
 	if (dev_id > BNXT_ULP_DEVICE_ID_WH_PLUS) {
 		struct bnxt_vnic_info *vnic = bp->vnic_info;
-		vnic->metadata_format = HWRM_VNIC_UPDATE_INPUT_METADATA_FORMAT_TYPE_3;
+		if (dev_id == BNXT_ULP_DEVICE_ID_THOR2)
+			vnic->metadata_format = HWRM_VNIC_UPDATE_INPUT_METADATA_FORMAT_TYPE_3;
+		else
+			vnic->metadata_format = HWRM_VNIC_UPDATE_INPUT_METADATA_FORMAT_TYPE_1;
 		rc = bnxt_hwrm_vnic_update(bp,
-					vnic,
-					HWRM_VNIC_UPDATE_INPUT_ENABLES_METADATA_FORMAT_TYPE_VALID);
+				vnic,
+				HWRM_VNIC_UPDATE_INPUT_ENABLES_METADATA_FORMAT_TYPE_VALID);
 		if (unlikely(rc)) {
 			BNXT_DRV_DBG(ERR, "Failed to set metadata format\n");
 			goto jump_to_error;
-- 
2.31.1

