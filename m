Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7297FCE08C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53EE140A70;
	Thu, 26 Feb 2026 15:34:16 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id B602A4065C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:08 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so1443278f8f.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116448; x=1772721248; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTtwVioK0vfv0TXObAuh4xeoepqtX41E074SpvnJemQ=;
 b=bLuxb4tDzibQBy/HNmlq8lyBQbyCCmEpwVRqGmgOMQGKQnEGbv4V7sZerpJ40sW8Au
 mpkzTzklCOODKoQLJq02+rBQkM1Cgxak7yKaJN71oU3tRyz5ZRkCsUqB5WuyKIFS1HUY
 5xbFWloC3FlaNFaW2n3EVWD/WiBQBvZMb0X44ZH3l25p0qPNGE9QXJh5i6Un4FNVeflE
 2TkUCoQnddjBGpLnCMeTzshvoNBDgrUODeThRmbQ36KVxuZm/TQTIAXmqZbWc/LU/uYA
 9OOwBZ0bTFUNwpcf04J0RsSQcwAhSU2z9QlwL9IIXUGPshJPpm5Sfud8eiHlJIZYZlIv
 Chmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116448; x=1772721248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTtwVioK0vfv0TXObAuh4xeoepqtX41E074SpvnJemQ=;
 b=Tl+nDBmZ0avpTC77SlXWI6ZPP1dbCIWnInNOi9tP9rURvQGJt+TsXJVZDtfTz97YWM
 pg7BM8OCJ3fwaA0hO/mGKlp3jcEGZUJSLIcC5+6MB38u94EOgDNpXxWvieJz6EJpJeXI
 ltjnN2TUFN8jra2gmh26coOxDYiwFa2Rw5o9rfyiAZukWIxb0AnZ5MYCSvpyeX/mXcRz
 BqVPeXJmcNA/JOfvGmeKyOeTIQEmm+vDZz4dnhmATIh14ZtDo/ptPVSJNd3h3sn8CEwb
 M0/cWUM19dWsL8lGkLXnMI56q791go5VwYiZKhgM6p/7N7BI1gCX68x9xz5WGLsYbRs/
 v1Yw==
X-Gm-Message-State: AOJu0YxJ2yFxVrW7EFxrsc+tcvTYJulOMBcIWUuGqdwyWRu8ZtOHf1II
 OI8O1zZm98Vh3TalcfqR5Pbe1KfstDCFX6egNdZc2NPgtYNEzZhgM8M+ArQNbg==
X-Gm-Gg: ATEYQzzQZ0l8sWXiWtD/R+0a8cnnlZFAKAZiqL+X5BgYGJpVzscSoGa8mOePtCoZbFh
 Ujuq1Y+g4Ygj88+WsEyA5iCygWtCfbN+Rshy3+3ZdGaHxi9+oPwy3SPv3PH0rDT51I2r0KZQPAB
 8WoOqQcQmPDj8SzttluQs463EFt8M6QLGLss+pzcIH8BPbnMpITrHcTb9A4onxphY8SwRI2e1f4
 l8wbOHSzvGNJBZoU7L6/ZYrnIiywIWTOd/U3L7hrqueDPVzHeriajCe+AC4QzepNPGXRzOPR/16
 TCB66zHnWIcPh5+uhWZ1uBaXInqAfEGnKvuYXQKOFc2nJl0B12v2OlBSQv0zIbjEjPMPivBCNIP
 mYh8nLmECNvSCHpCujmYe/+TNU8WxghSBuke9zdPQjW332AWZKXNATLX3VHBzGcKD2iZTsIWWim
 tG6UZ/zJcV929QYdUnOIT3iE2zeQ==
X-Received: by 2002:a5d:5f52:0:b0:439:5fe4:421a with SMTP id
 ffacd0b85a97d-439972048a4mr5622240f8f.30.1772116448203; 
 Thu, 26 Feb 2026 06:34:08 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:07 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 06/17] bus/fslmc: fix devargs not propagated on hotplug
Date: Thu, 26 Feb 2026 15:33:30 +0100
Message-ID: <20260226143341.282188-7-maxime@leroys.fr>
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

