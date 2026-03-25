Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459C2106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE18F427B3;
	Wed, 25 Mar 2026 21:46:09 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id DB3B44270A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:07 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso186430f8f.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471567; x=1775076367; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmS+fKWJt0UVzRfmVMd53fnno/4FHOQJsA/ZMlRkdIM=;
 b=T2+tr7Z5uvtfgpkS0PHEJLxMgSbmTi7f5ArzgYqp0yajqhVkKAvlwVKDxmBpmDjq/v
 56i94cL9ar2TBR/vXwFqwf4qtAHoUQtP+sQWmepgmpfZ18jK/VexSkt1SC8z2blCW2Qg
 CEpFL578OsvYKB4PEcABY0q1f0aqFbGdDja5tySKPEqmTAsQbZjvfGZi3V5z95B69WzA
 SLfh1EGkuod2prAN3V71KT91BGqBsOT0nGf1CPIUjyKGZCivhi/rSdrcb4gigM+ADBnu
 tM2yEBzBQUMon3ciUxorGt4gLZ3wZB3fwGS3D3UlzxrZcKZqQHKDR7krPH5K+I3ecA4D
 vu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471567; x=1775076367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmS+fKWJt0UVzRfmVMd53fnno/4FHOQJsA/ZMlRkdIM=;
 b=bDWIvtojBRwfC75nG11lxGHRM3LSCoNHIfjs87bvqptrJ3CyOb7LSbLXoCyARSPIVc
 2YVTyYnA7gnf+/d30QOR+19MkhkutTvlm9JqUgnmYlWYG6jOKecELoJbTaEk2HSKHhQN
 W59+4+1Ei8W3vTxlr/jhCygGn6F4MY4I++BXj2EdzxOSQ6Io8aGF5lAefGmW8XNavkog
 nX9XZEUPK4z06IsaesYSBZmKjmknuY2Mq69ukS/fEGw9L9vktXMdb6h3sDYKELuv8lBE
 o1gqNINEnRaV1WQ3fd+i+m8223FWJK/bOYdhRE3jlVt59c4OG6Ityq0dG9uIenR/7IoU
 QR5w==
X-Gm-Message-State: AOJu0YzbhkazcpewO+O2sGpPYh0K9jL5zlPnkvyqAsXoNeDByL/Etpd7
 QyqjMdMM3V1PoGylvAa4IYRbY9OEhkxKYVRl6sd2O4qpEX1GAA/NRDe6qajEksqj
X-Gm-Gg: ATEYQzx48z37sejh802uBRQyoZO8Z0BEUGAQJzOWybHe1XkLV02w7joCTIHvMdVpvU6
 lBEK2+4r+RXsoGO39334OR1qZOjPnFBAu9+KdkHkyPOZvGE4zzJHO6PcLttntyYnJbMighSdW+4
 GsrnrmO4OF0wBi8YXhb2lD7y2Bw4YwtKmSCbWdyKkOEpl9Jtnk9YisqDTFXf9aPa2n7nyKwPVgQ
 pHBENluvXDBGqgwYOyRwzCPgMEup5DyvYl8XxEYdB/eYEMv3IE6Rp62LVlmeoztaPbhokBKwigu
 rfJVJtXn/UeqQin5YFnibcALNCin15z8BHexrOZy2KHC/aR9Ehe2IuDRYEXgQlNYgCJs0fc7YAz
 Ud+tdKhQYXmcJxhKQm28K4UtxZQcd0ElqiNVPP5pZ1xSyjOiqNq2fu6bW/e+a/a5J9xlqLyfjFL
 daJCCFYIt2KbzxTdxp
X-Received: by 2002:a5d:44c3:0:b0:43b:8fa4:194d with SMTP id
 ffacd0b85a97d-43b8fa41b04mr3032671f8f.6.1774471567332; 
 Wed, 25 Mar 2026 13:46:07 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df7dcsm2785431f8f.27.2026.03.25.13.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:07 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 06/17] bus/fslmc: fix devargs not propagated on hotplug
Date: Wed, 25 Mar 2026 21:45:33 +0100
Message-ID: <20260325204544.101444-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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

When a device is hotplugged via rte_dev_probe(), the EAL adds the
devargs to its global list before calling the bus scan and then probe.
However, when the fslmc bus is rescanned, it returns early without
refreshing devargs on existing devices.

As a result, PMD-specific devargs (e.g. drv_no_taildrop) passed
through rte_dev_probe() are silently ignored by the driver.

Refresh devargs from the EAL list on all existing devices when rescan
is triggered, before returning early.

Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index abdb0ad50d..d058441a3f 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -322,7 +322,11 @@ rte_fslmc_scan(void)
 	char *group_name;
 
 	if (process_once) {
+		struct rte_dpaa2_device *dev;
+
 		DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
+		TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next)
+			dev->device.devargs = fslmc_devargs_lookup(dev);
 		return 0;
 	}
 	process_once = 1;
-- 
2.43.0

