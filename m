Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA50EB3624
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 17:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A29B240E1E;
	Mon,  2 Mar 2026 18:26:17 +0100 (CET)
Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com
 [209.85.167.226])
 by mails.dpdk.org (Postfix) with ESMTP id A796E4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 18:26:16 +0100 (CET)
Received: by mail-oi1-f226.google.com with SMTP id
 5614622812f47-463a94f8475so3884807b6e.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772472376; x=1773077176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XTjLdcEcjke6VBGp+hXnVc27KUWlsUXK7rYvl66V+6k=;
 b=cA+dw6l/UK0fPbXEdB5aiPmwfFXPQsYRKruHk+LGh/t97THyXlMauLA0D4/6llYCP8
 qOmsze2kE9IzB4eWVj2CgzS7t/pkglOvSdymsmSw12zz4DCFGeLQDf/6SnJs2k0dBDpC
 ER+Oza8rGJliC5ePtf0CvKMQU/QENYd7W4Ry0ValjzTsa6XK1qkGxtoHxhKO67bQGj0m
 mTiCnI1Xzs9GESkvQAm2JYQKdT+ihnKGagdWGRTFLikQjLin2DhUhNK4Uv1/bTjcSyfb
 V0sCL4bbHX/OFrBOI11JSwj9iVFBr5wVHpr9nJSmdhBJx8DPFUlS8/LG4ixFHAT2ji0D
 XaHw==
X-Gm-Message-State: AOJu0YzvnPxYGmfFcNSkJQ2HLhx9QrGoFEse5mndlkkOtMCZ+dhQoF/a
 p68DAVd7LqAbvvsZuzDkCVG6S831ZYezlciCKsRvpDzItMNxkr/vFKRByiGIdJpi0XCsW+J9exw
 VNdcL1ouhIoJX0tVGyB+/IIFylTvJzweYV1Xlti4pYwXfNBVzQTY/ElyLeXra+YqWHadC10QUvB
 YyIkKBhvjufyLhLKnhPx3ijnnDT3SKIli40RTXFJ/K4+Lhx5xHDI+UzMVhJ/8HPqfl2foKy5n+o
 tL+M/8KkY7R
X-Gm-Gg: ATEYQzzKTSRRCGWfyVdwjX+3zZsqdlGV5V/VSvfMEhjOv0LIKZ6EJY0j4d+PH4pkBVn
 zWGubYilwMwntYbSjTaDONGLW2T/T3HtwicEm8y9BfTWlO2GrTlwUGGK6L/6DkPCCBdRw6kWdaY
 fNrgM4+3QQAD6NOwnZT0W3mTqnHbFv/4sV2eH9WDp5JbxkmICkT3y29ZM47nE7A8a7T4bxIevV/
 nj3HRFJE0E22MxjvDKOH/lBjosj+FE0E4oocR/MUZHjJeO2cLTQwIoLyGj3IeSAJcqetAR/Bl/g
 4jgqs3HBW/SKB4Iru9cv8Qli3t5mUMSqwsmHiZNLxi8dpOBO9YW2GZFs6Fh4FEqUvDQTpNGkMde
 quWkXahJYUiX77ZfZgxYeZfjkV7Q8CfDfx4ME4ELSJpSmxK123VdrFFjS8ADSqDUlxmhbsqId2J
 g/Gi75yqKSJRgCTmiFXai4yaikqtL62c4LlgW1A34gQeTmJBz6BXOEFm1We7BUTpgzaIlsXrnKb
 g==
X-Received: by 2002:a05:6808:1645:b0:45a:6adf:4d44 with SMTP id
 5614622812f47-464a5dac614mr8674297b6e.12.1772472375598; 
 Mon, 02 Mar 2026 09:26:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-4160cf72dabsm1821075fac.4.2026.03.02.09.26.15
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:26:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1273dfdaf5dso3252229c88.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772472374; x=1773077174; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTjLdcEcjke6VBGp+hXnVc27KUWlsUXK7rYvl66V+6k=;
 b=YqEjv7NCNzHpRibBIcTBP1/+TJkfonRBdzbpkP9SGtf2DeFUmbAyxosa2XI4zL3bNk
 OBqusPOTMC7bb0gMKF8v24anTRaWIqdt8+Z3QlHdAQXGbHLBUvuQdQHrCFpSq1OOP3fQ
 IoJHPQlEP98GDchphIUxJUA+xbZE4lLO7DcGM=
X-Received: by 2002:a05:7022:61d:b0:124:9f56:832e with SMTP id
 a92af1059eb24-127890fc341mr6175233c88.18.1772472373977; 
 Mon, 02 Mar 2026 09:26:13 -0800 (PST)
X-Received: by 2002:a05:7022:61d:b0:124:9f56:832e with SMTP id
 a92af1059eb24-127890fc341mr6175206c88.18.1772472373155; 
 Mon, 02 Mar 2026 09:26:13 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a52ab0sm19075530c88.15.2026.03.02.09.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:26:12 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v2 4/4] net/bnxt: add ptp_cfg struct support for Thor 2 VFs
Date: Mon,  2 Mar 2026 10:26:42 -0700
Message-ID: <20260302172710.98978-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302171236.98625-5-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260302171236.98625-5-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Modified ptp_cfg initialization to create the struct for Thor 2 VFs,
enabling RX/TX timestamp support. VFs on pre-Thor 2 devices remain
unaffected.

Previously, VFs lacked timestamp support, causing "RX/TX timestamp
registers not valid" errors in testpmd ieee1588 fwd mode.

RelnoteHeadline: Add PTP timestamp support for Thor 2 VFs
RelnoteDescChg: DPDK driver now creates ptp_cfg struct for Thor 2 VFs,
enabling PTP timestamp functionality in ieee1588 forwarding mode
RelnoteIssueDesc: RX/TX timestamp registers were not valid for VFs,
causing ieee1588 forwarding mode to fail on Thor 2 VFs
RelnoteVisibility: Default

Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0cef22b5ec..3632bebbd6 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1258,7 +1258,7 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	 * sends another hwrm msg.
 	 */
 	if (flags & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_PTP_SUPPORTED) {
-		if (BNXT_CHIP_P5(bp) || BNXT_PF(bp)) {
+		if (BNXT_CHIP_P5_P7(bp) || BNXT_PF(bp)) {
 			bp->flags |= BNXT_FLAG_PTP_SUPPORTED;
 			PMD_DRV_LOG_LINE(DEBUG, "PTP SUPPORTED");
 			HWRM_UNLOCK();
-- 
2.47.3

