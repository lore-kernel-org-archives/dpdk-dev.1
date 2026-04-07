Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8DAFD5F8F
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63FC5402A9;
	Wed,  8 Apr 2026 10:25:40 +0200 (CEST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47]) by mails.dpdk.org (Postfix) with ESMTP id 389604025A
 for <dev@dpdk.org>; Tue,  7 Apr 2026 09:57:38 +0200 (CEST)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a2a70bb69eso5072501e87.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775548658; x=1776153458; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bwVteRQkdChTSJSm603oyiKm9cuhGtiMTHR0hJ88hO8=;
 b=amaRS0JhC9Sg8tY3J+fwk+z9um/o3rMcZ4avcsoUrAV1StQnzye3PNvQVnNqMN7zcw
 3+SsaTkkpIRvJiaZEtlX+BiyupWGU7Z2qqO6oz159qgUSWGyR1uxooVT8Mi7UbHJLwB+
 6tf458JbRd7luE6suQz6PdSJf3d1pxEkXK4Sv9UbjM0bKMqUWXvnC3tEo30XS/y/CY7I
 V2pz6bkHzCLX1WLVLX3hgkDiXkVphmo3QKX58LiDVJW0yIxK+DmLULcoXdUJxFV+2OEr
 ued2Rfh9InV7jJuLgDE5vzWtqHKT/XpZjF/bhI1KQjvJ0IFPbaVlvuwvsBHWuGiGIrwL
 o9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775548658; x=1776153458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwVteRQkdChTSJSm603oyiKm9cuhGtiMTHR0hJ88hO8=;
 b=Dnb05nm23iHEJIAeHBjeZajogEjubU8EplPoiiKYbxqcxIXZBSLHGdd9yzpM87puLK
 VlNi+FMPTV53pHU+mmLoAOCl1le0YYzE5DEscSzONQ9B3HXtrAlzI35+L7lPuSbDQbg2
 ZjumvZNLEFNQdtvXSsefS3V8OdPXJ1delBAHC6C6FjZ1pjfZq85q4xV28/E0iOP5WnL7
 TndPj8SHHFyCakPHfcK0bAfnkUN4tpU14PbBcFBaTa9pSbg2KjFGrCIDGe1bjlgBBZXs
 WsSJlzZKUnuOA8Hk6vWP7C9Q2/LaOIrhrl8qsosN3no8aLrQ1xJLdIHb+uieeEOFbrj8
 Ey0w==
X-Gm-Message-State: AOJu0YwKxJ/IR4+CZ9fzchdnHc3hRkRSEssg5b76BOX9yB+a9Xb19ou3
 LYnhc8ejVsAgFwryT1t/zj1Wo7d9EkEtwf351jfCYQInuanDCx++284=
X-Gm-Gg: AeBDiesGyNDcCGiFxocgguF5ohJIR82HqmiZkUGRTCrlouSx0Mr0ucYc4exUY0P5Feo
 H1UzbRHecQsVElsNgy9KwLW3XcNdnq8M5GGcZzP5KF+9iisjnaSymbh/b1JSeb824xLS2xbnOKR
 Iub5sC3GxD26KGtAYqPECevKDeuRHguCCwAM1WYccOH9HJMmUi4iEbRM8OTYoBfOEWVt6pBU6Tu
 C8KJtNn6FLAzUiCJy6uc+vXc0dM4uvconswj2eRe37f3dGtLKjgOysb/xE8HDn3+o3sb6NQ/huo
 nsmL3DGUU17iJdJl9QmeA9FhJkiowZA5KA8u/YQF+UP275fMhBF6fJDzlrL2fY70PgubbiaFkk4
 OGYqERopXZmL4RYWlemZ72nIZRgMwfhywlQJlYyesiwH/fcOolu9v06Pe85GPUH9ldHi6mkG6VP
 tP9fcbtSDykZF9pEtE/OWCpWurg9T5gvRD
X-Received: by 2002:a05:6512:40d5:b0:5a3:cd94:df73 with SMTP id
 2adb3069b0e04-5a3cd94e104mr2960805e87.38.1775548657246; 
 Tue, 07 Apr 2026 00:57:37 -0700 (PDT)
Received: from dev-debian-1.home ([81.94.128.221])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cccc83sm3876164e87.65.2026.04.07.00.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 00:57:36 -0700 (PDT)
From: Sergei Iashin <yashin.sergey@gmail.com>
To: Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>
Cc: dev@dpdk.org, stable@dpdk.org, jerin.jacob@caviumnetworks.com,
 Sergei Iashin <yashin.sergey@gmail.com>
Subject: [PATCH] net/octeontx: fix buffer overflow in device name formatting
Date: Tue,  7 Apr 2026 10:57:32 +0300
Message-Id: <20260407075732.1175609-1-yashin.sergey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 10:25:39 +0200
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

Replace sprintf with snprintf when formatting into the fixed-size
octtx_name buffer in octeontx_create and octeontx_remove. The device
name can be up to 63 bytes (RTE_DEV_NAME_MAX_LEN) while the buffer
is only 32 bytes (OCTEONTX_MAX_NAME_LEN), which may cause a stack
buffer overflow with a long user-provided --vdev name.

Fixes: f18b146c498d ("net/octeontx: create ethdev ports")
Cc: stable@dpdk.org

Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
---
 drivers/net/octeontx/octeontx_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index 21e3e56901..e4dca30d9d 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1555,7 +1555,7 @@ octeontx_create(struct rte_vdev_device *dev, int port, uint8_t evdev,
 
 	PMD_INIT_FUNC_TRACE();
 
-	sprintf(octtx_name, "%s_%d", name, port);
+	snprintf(octtx_name, sizeof(octtx_name), "%s_%d", name, port);
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		eth_dev = rte_eth_dev_attach_secondary(octtx_name);
 		if (eth_dev == NULL)
@@ -1711,7 +1711,7 @@ octeontx_remove(struct rte_vdev_device *dev)
 		return -EINVAL;
 
 	for (i = 0; i < OCTEONTX_VDEV_DEFAULT_MAX_NR_PORT; i++) {
-		sprintf(octtx_name, "eth_octeontx_%d", i);
+		snprintf(octtx_name, sizeof(octtx_name), "eth_octeontx_%d", i);
 
 		eth_dev = rte_eth_dev_allocated(octtx_name);
 		if (eth_dev == NULL)
-- 
2.39.5

