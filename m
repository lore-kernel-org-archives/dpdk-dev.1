Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159CEB3622
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 17:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA43640EA5;
	Mon,  2 Mar 2026 18:11:53 +0100 (CET)
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com
 [209.85.221.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1B7EE40E40
 for <dev@dpdk.org>; Mon,  2 Mar 2026 18:11:51 +0100 (CET)
Received: by mail-vk1-f227.google.com with SMTP id
 71dfb90a1353d-56a88bfd4e3so3294619e0c.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471510; x=1773076310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3V5wDf6fOTQk1SO/CmDH8Wx9lfg+7COQYv+Uj6jReDA=;
 b=OV7qwGZD6P2Sb1k/yGjqkhiSre4HZoIw/Rx8hIAGWDJ0r+/uOTgu5G4oxJiP0JTZmZ
 Vg4tsDQ6I0/ueXf+WJRvOg2pk5gcqBLAIAHR0jvg+Q7m/n8is+pTMRG6D1hMUQA9D5ea
 bxg12KjFRjE88XkDuxkRY5f7ZGXsdf3nXIxuj4KPx/zpzOohslOb297GGPjNvZMWg6Mv
 XXDX0dAuCL17viSJge1OFjDNxG3kJ7QqIbVxjWdhhJbrAmDXd7f9k4PmzsHhWFpyJoxN
 SLdn6MdeBZMBqF2LJPJjJONo9bUtc9vu+X56gXHDz7K4So81ADlx1dVqqFERpTf2m9XM
 3zkQ==
X-Gm-Message-State: AOJu0YxbqwoHsl3tCitHMc4WC7IjqLW3Z7HAJR09pO+TUhlBD1ih0sOY
 XcETtpahkneJD9x10VaMF1/3BILTqbMKJSMK7a3tonMM91YznunTx7nyivTVOSj+rAoH58//5He
 bMFzrue97wtZn+2Cl4NpbrdpKh0l5mqORmxtBpzca6ICLNrrwLDKAHuGApnfnQLCOKOYtSOWxqW
 FnwN6PZwi7Pod0XKS6nfbIxuv8BR4KwoUFV1DnuNNwEsNMqiwfXK5QNBPNwYI4FfaXZSYko1IXi
 uZqzz/Dicgc
X-Gm-Gg: ATEYQzxUPpaQ1sQM+ILja1tYCEPzautMZ/gKI+uvdNcNaDT/IVz5VV0olEikV1U8z2e
 60GcQkGaIHTQbKVSg7WoJmb2+B2aoGx5YsXZyzShFb28ZGaZsmTmWOb/G4QOqMixt1BXlEd0Wkq
 2jpFC4nOwEZm9nl7SAfL+B3S1iqd3bUYZS1zYcKNkk9YvWXjJiTbWCgXQD6u74wiqfQTsHZB6k4
 evwLi8wheGj+R+y50BOlNi/R0928N5+Zmi5bvr9Kt0OdrEFnTaBYEo8A+6m+xCJ1UKDoX2M5Uwl
 IN8xXJ21nqZOAdSVhc0wjHzFFjOKcBsDlCMLStzSLnCcECNLWpLgjBOdIP8J6bNamj+BWtoTwlM
 2q/+rEM9kxL34M0n//GfteEmcZz8SlZ955qAGd0YtGIb7O8YrBhLZkaXXS/VpVWGoP2eraJdrIJ
 VvN5akBq//RXcUkMGmo4UPs5q1thwPY3uxY3+1w8PWtdXzpWdD+8GKwbie43/gZx6itdOvFVtfl
 w==
X-Received: by 2002:a05:6122:29c5:b0:56a:9f03:1719 with SMTP id
 71dfb90a1353d-56aa0a2a3bamr6292186e0c.7.1772471510006; 
 Mon, 02 Mar 2026 09:11:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-56a92049305sm2123398e0c.7.2026.03.02.09.11.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:11:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-127337c8e52so3215354c88.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 09:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772471508; x=1773076308; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V5wDf6fOTQk1SO/CmDH8Wx9lfg+7COQYv+Uj6jReDA=;
 b=J3COgHfNmvuO6ZP2xDZCkvnIZkgwnJwLeD/MzJz+vwEwR+erDyBeLLY+c4xjOaUqGD
 51L18N4pI1dsvsn5y7kktd+qTfL8lWIFg9wWmm1n0Wbtfvb+C5IMUESD4mwQK8nzhIDl
 SIi+hBHFYFvnBYiEYBy+O05+3e84PmS/uL2XU=
X-Received: by 2002:a05:7022:6629:b0:119:e56b:957d with SMTP id
 a92af1059eb24-1278fc28c5emr5797009c88.2.1772471508419; 
 Mon, 02 Mar 2026 09:11:48 -0800 (PST)
X-Received: by 2002:a05:7022:6629:b0:119:e56b:957d with SMTP id
 a92af1059eb24-1278fc28c5emr5796984c88.2.1772471507625; 
 Mon, 02 Mar 2026 09:11:47 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm13910511c88.0.2026.03.02.09.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 09:11:47 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <root@nic1-cos.dhcp.broadcom.net>, stable@dpdk.org
Subject: [PATCH 4/4] net/bnxt: add ptp_cfg struct support for Thor 2 VFs
Date: Mon,  2 Mar 2026 10:12:36 -0700
Message-ID: <20260302171236.98625-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <root@nic1-cos.dhcp.broadcom.net>

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

Signed-off-by: Mohammad Shuab Siddique <root@nic1-cos.dhcp.broadcom.net>
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

