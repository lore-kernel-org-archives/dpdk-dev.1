Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C20CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 19:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C12D4064A;
	Tue, 21 Oct 2025 21:02:09 +0200 (CEST)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id C594A4064A
 for <dev@dpdk.org>; Tue, 21 Oct 2025 21:02:07 +0200 (CEST)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-783fa3af3bdso48615767b3.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073327; x=1761678127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=oUes6Oo1Q3NQy33BtvPJcUY+22YUW30b+CSk8GJoM88Pobe0uvwnbvnUAF73WIF4tS
 zpw+GJPrSVvt0Rr2jzHAaI6q/eXeBk93Z6LXxlZy67tKu5vLgoxtk9QUind3WhMNXq54
 CQ+aFXIZiGwfmtcjJh/oKfd7XMR809ZtwY6SgkMJ5TIengGhfIgKgVcfrM3AWvf2QoVp
 Us31bysDq7wRlWMVfOhHZCHauu7+DTB1pPfZU28q5XBT+tNjnMBjDK1sFO4w381JwLH+
 TaB0cXR816wQbZh7a4k5snbevSz9rIsjfYAhRwkuUS+jZQad0wQoKyX/AR5uxJ8Pm2RA
 82FQ==
X-Gm-Message-State: AOJu0YxwawHjrzb2qt1HrM9/tATD84XvzZWwTM45HS3pb1VQ8G/8fWDE
 9hfwZMpgANigMAGSLXCCR1Y7R4dEHAs5gCGq6qtBhbnO9S/V5s8vPB0U66NNMwpa6ps5TvXF0v6
 FohTO15ninByZGI49PaqSewEVMimjVoiGboHuZrKIv2M7jqL9Q0TeA9DNpRZtDtVj9zY3nyaagh
 3D2LDYd4RY7AxgXO2zwagUaJi1tmuIRvcTWGVqFNevxRqHuSFgX8WMeRoUIHW9vkeY2zUisA==
X-Gm-Gg: ASbGncvT9rI2Qe5nxzcIF5wZddpi/Rk6QKlfU98MERtqj9K/ZLpV/q34WZHXNR/6No/
 0Mikbh7VFgZCbEGChzk2FJyEq4iPDa1Smsol+/eBt4M3CSVTg2ydFZqNF1ZV5Iyswvl6rwHnm/v
 QAUbNeLJYrpPNyC1XBeIg0xFbDyHtTvkLesM8sGm19+eL0zCXahxcYxPkLl7JrGRNHJxgcvVwSA
 4G7XOCiYjKzZXF4woI1alZyiz5Ch1koYHX20LIqddaoMRvkPCm+yLg4DD/mQ2BO7sweAfQV4z4a
 beZ40wLbTG+mehBo03cm4+LlI7CRly8mrvdxlMIEfAsKG+8sOXOGDC3seLVOyD1Y1LGnpbrxJlR
 3lS+bZAOnPYyeRO9xvUaYU95DZTW/mGfm+hW6SuFwa3oM01/WsYSFP5+nrO89JNgBx1miQsjphO
 qUbVsL9eZKnW654b6E2JLNxDE/QpD0ZPpmlw==
X-Google-Smtp-Source: AGHT+IG0G/3AQIIaUSuBMXd0L8Atz8EmYqUK4m4msOj3/Fx4AGYC4P9MftWmZLtNGbJIEiEPPzTc7q6pSi7v
X-Received: by 2002:a05:690c:6d11:b0:77f:746e:e9eb with SMTP id
 00721157ae682-7836d2d674fmr154285997b3.40.1761073326979; 
 Tue, 21 Oct 2025 12:02:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7846a69946esm9071417b3.34.2025.10.21.12.02.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:02:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77e7808cf4bso3821297b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073325; x=1761678125; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=aAncp+CyxFM2H+ZZHYkl1/e1PhQPZYPm+8UxL3I2g+ZfAJv5taUhMfF279RhyDgRRZ
 WwetKO36/UUI3dSQD/nbiESNiD762XaZ6FeLfwS9aIJDFI4w8KmDf2H5+8+itAVk5zFK
 J8twsZlPhvGmLmBtfOAb5uBqGCv7vxOh5GLJc=
X-Received: by 2002:a05:6a00:1885:b0:782:d4b6:f5e5 with SMTP id
 d2e1a72fcca58-7a220a3c32dmr21112815b3a.13.1761073325291; 
 Tue, 21 Oct 2025 12:02:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:1885:b0:782:d4b6:f5e5 with SMTP id
 d2e1a72fcca58-7a220a3c32dmr21112739b3a.13.1761073324506; 
 Tue, 21 Oct 2025 12:02:04 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f256dsm12011019b3a.50.2025.10.21.12.02.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 12:02:04 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 53/57] net/bnxt/tf_core: fix truflow PF init failure on
 sriov disabled
Date: Tue, 21 Oct 2025 15:01:54 -0400
Message-Id: <20251021190158.74064-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Farah Smith <farah.smith@broadcom.com>

When sriov is disabled and running DPDK on PFs fix invalid max VF
check during table scope creation.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 878f62c115..c06099af12 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -1210,7 +1210,8 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				return rc;
 
 			if (fid > max_vf) {
-				PMD_DRV_LOG_LINE(ERR, "fid out of range %d", fid);
+				PMD_DRV_LOG_LINE(ERR, "%s fid out of range %d",
+						 __func__, fid);
 				return -EINVAL;
 			}
 
@@ -1419,16 +1420,7 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED && is_pf) {
 		uint16_t pool_cnt;
-		uint16_t max_vf;
 
-		rc = tfc_bp_vf_max(tfcp, &max_vf);
-		if (rc)
-			return rc;
-
-		if (fid > max_vf) {
-			PMD_DRV_LOG_LINE(ERR, "invalid fid 0x%x", fid);
-			return -EINVAL;
-		}
 		rc = tbl_scope_tpm_fid_rem(tfcp, fid, tsid, &pool_cnt);
 		if (rc) {
 			PMD_DRV_LOG_LINE(ERR, "error getting tsid(%d) pools status %s",
-- 
2.39.5 (Apple Git-154)

