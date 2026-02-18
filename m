Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42112E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8A134067E;
	Wed, 18 Feb 2026 17:05:15 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id A387E4066C
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:11 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-483487335c2so51497855e9.2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430711; x=1772035511; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGSIJAXYABIzxpUwHOac4m6qbVm5zDijavtMFoLOvD4=;
 b=RcJpb67OnSV8jH7i+DZUKcTpwfHNOhRO2fAkm8dXTMaP5+sEKZKKe7t9KR1t1LGdPf
 ZCcnSUlWPkTCkYp9qAepHJegdBnJ0PTpWlaj0Z1cZVkepN+4Qg7NF09iNPOnf/9aHcxp
 L4D3FIg4I+QHvAgbNzcLCKyPCPER0VYxxLqmBgKv3377xOMsP/Hy2Vg9JEgn4hedAS8w
 WxUwIkNqmnICFMPRW+qIl4sJO8Brmza81LrTdy7yI5MO3FMNLg8LNSxg0vNwsRNV8iRH
 8HBJ6g+YkYNc8l4osqrtEul4aHzRhun3/vZrMZRXZC2Izv+r/oTO9W5E5Exk8iqipQx1
 hS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430711; x=1772035511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGSIJAXYABIzxpUwHOac4m6qbVm5zDijavtMFoLOvD4=;
 b=Q6qiBfRFZdlVsrv4+qmSwDA/rK1uVSOvoudM8yw+4fIW4gk1bV2RgkVw3LyqbtJrNh
 ZkyGnPo3fhgqchS//M2/rdHdQ0s/4DjOBashjAJRVjJrZzZ3ScaHbgGwgE8p1YcewISr
 wsql5SmKRciUviC4You7X58CkoevrVOTgzF1dwC3tmsczp0XvEG94PnlaCNZmbDSPJIV
 OOcRFXUJHPlstHJtJnZdhUZjIYF0ZmZHThqjAqbgvyWVUMgeP2zvG+bCx4yPSiJgYSnx
 Tv3JKpTtwVGZ3bIL22PoCpP6JY+l2xcxMhD7T66NvGwg2YVW9st3ZHDJH0BPay0e3hiN
 tCSA==
X-Gm-Message-State: AOJu0Yyf+1lcgyUGqN2q7Yz8akdO0v3kkguUMaJJVSU12FZXJfvO6aU4
 YBmmsIm9+SiRZ/4tydywCfCjDYRCZNPrvx2glMes5IoffJH+0CPZQmXG
X-Gm-Gg: AZuq6aLL5ul64ehaGWn1VOlYQTB/tlsJmUtGMjQiNULr+Cun69nsQsvCY+HArRZrX6H
 2SoZzGA5b6K6fbC8PZ4LeIx4qbk26qKl+93YzKtivbjoFDcUAiHMzKWWmyHCmKFRAICERzgHRFH
 V+KX8CLsXPm8jOSdMwv7fmb664rOevvy0+FroglIFD7n2HhHlwNvouiDVKR33n84H9r7fIkBK8h
 edDCH8L22zqCXdT73xLCiOIcAKrSlpZCPb325MEo5vEUKI1WZlFg+BM/W6qSSu1DZ95jKrO+XHh
 iWDBIXI0Wk1h69YvHUtIxQcY8xIN/aU7zBkBjjA1QY5nOHZF86Zw8PSqqhKVaZ7U5KwEeuVZG+F
 CIMMT/zAtQJCDSIGxaPXeMr/mZzYnKBhkKgNVxoaEg30t9h6sjZ1mFsW3rPmg2JQI0FFgNe/Tvk
 G5JkYQ+MANYkdESYBzbh7AWeruYA==
X-Received: by 2002:a05:600c:4f4f:b0:483:612d:7a9a with SMTP id
 5b1f17b1804b1-483989c6b80mr42637925e9.0.1771430711107; 
 Wed, 18 Feb 2026 08:05:11 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:10 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 11/11] bus/fslmc: remove dead blocklist check in plug path
Date: Wed, 18 Feb 2026 17:04:53 +0100
Message-ID: <20260218160453.142311-12-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

The plug callback is only reached via rte_dev_probe() which adds the
device to the EAL devargs list with RTE_DEV_ALLOWED policy. There is
no way to reach fslmc_bus_plug() with a blocked device, making the
blocklist check dead code.

Remove it.

Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/fslmc_bus.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a539753649..6be48754e3 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -612,13 +612,6 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 		if (rte_dev_is_probed(&dev->device))
 			continue;
 
-		if (dev->device.devargs &&
-		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-			DPAA2_BUS_DEBUG("%s Blocked, skipping",
-				      dev->device.name);
-			continue;
-		}
-
 		ret = drv->probe(drv, dev);
 		if (ret) {
 			DPAA2_BUS_ERR("Unable to probe");
-- 
2.43.0

