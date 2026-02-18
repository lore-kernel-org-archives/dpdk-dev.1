Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD67E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0BD4067B;
	Wed, 18 Feb 2026 17:05:14 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 8B9CE4066D
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:11 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so39999725e9.2
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430711; x=1772035511; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3Eb4uAljBP1BXMpwbAc7FrELlflaLDtFrS1HYJhKKE=;
 b=WZpSisFQC/zxsED0RTazZtN1vkTriQhYMK2Wo4djgEPnS1wI4tMAMx6meU4DjMAxjg
 zehkNKKfiIE6lrcDWD8IlnZvuUwXlWkwGHKLwdEV/fBVLShtct03n93Yv0XN2t+snCRr
 c6isRBqbDTnUhjuVHZyfK2QYVDzCQ2qcLrFiC8ByMoq/WBRclN30oo3iceIJSfDPDssq
 Krzx2Gm7xpUhUJvsgyrE8vne2jYHuBqR/l4P7X/6/de1pIjcEBFjW7UGboYCpivlBNoK
 2atU9L7YNT8nLyCgpMuEDCZ05NXVQPUV993eXM/C2jRBgwTAb9pekqZ90+X+OzB1hPfC
 Z6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430711; x=1772035511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3Eb4uAljBP1BXMpwbAc7FrELlflaLDtFrS1HYJhKKE=;
 b=jUXaIJpAg82uataknRh4Hi0KPu6f6jaZKIFEUf4BnyhMHDi95/OIepABny0liLiW/V
 0NAVY79Cd6CNAbOx3t+EEPdNdGCUpCUrQysAmQLXf2uwGirIyXR+R07gjVDM5UwJK+pb
 yPXqvNdV8Djf/NVnqQpRss0KoK3iedczePa8F+xlUg4KkAlhC1Q5doSC9VZoMB7jpzlR
 y0ozSwFtNrPBck/EUqpO2isYboYVSlkZD7FgB7J4ctDVfvCd4vGFiawJZ03B0aWfkZuT
 bzr2hWVsWKDoOklcCYj4MLjYRsmiFwml9MeHRTRu8XVRi8bpaHYtw1CYeyXKWAXFWVo4
 HVYw==
X-Gm-Message-State: AOJu0YzlFqaL6uxvdqlcn/OYNBj4Ikoy5cWB7WEaGL1Fv46y6sSDVFht
 7PXqqtnp93OQ+DwhJlG8ApBGSD+t94molWdwtTH0vRuh45NV+n21pQjo
X-Gm-Gg: AZuq6aIp7sGQaj5CaSi2TKyX3kvlM8GpbW4XQv0B64XPLd2m2EtEuTH8TRKb3R/Bkzm
 dcim6Q69RL+XmDx0q0wThIB6H5vvuo6CPWroJQ/4kv7Ap5XKoqh3aqrVtJ0FmQ5peknnzJCZGLM
 CVGQ7qBI+y2IGo4W66XZW5Y/KKIIFjF6ut9HNEjXHL6v+alSTlP5lzc94d6N9jHPHexHnvUTXOK
 5UuYmyaonVlVAC4V1DtyY5OphOH6JgNPpkHirPpOIMiTvPwPI9JCEkWiS+z43+ZQME3E6urT9gE
 n8k1Ci7KKbnE8WHM1rHV/QPgmxFS0Fr7fMrfVk0j2qnfOVLmcaXV/Tnm6mGNGkhdISvo/xguGnP
 QRz3OrHlUTdVlPRvIJuy+JXgVxeLQ//wDik7srhx/wYllluW/gLuekDJ6KORIKhy9hD6sdPwYlA
 1vnH6DlJH9TvrmmdEHOBY5/qXAkg==
X-Received: by 2002:a05:600c:4f0e:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-48373a1029emr334467005e9.15.1771430710317; 
 Wed, 18 Feb 2026 08:05:10 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:09 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 10/11] bus/fslmc: fix devargs not propagated on hotplug
Date: Wed, 18 Feb 2026 17:04:52 +0100
Message-ID: <20260218160453.142311-11-maxime@leroys.fr>
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
devargs to its global list before calling the bus plug callback.
However, fslmc_bus_plug() never refreshes dev->device.devargs from
the EAL list -- it was only set during the initial bus scan.

As a result, PMD-specific devargs (e.g. drv_no_taildrop) passed
through rte_dev_probe() are silently ignored by the driver.

Refresh devargs from the EAL list in fslmc_bus_plug() before probing,
the same way it is done during the initial bus scan.

Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/fslmc_bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index abdb0ad50d..a539753649 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -596,6 +596,11 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 			struct rte_dpaa2_device, device);
 	struct rte_dpaa2_driver *drv;
 
+	/* Refresh devargs from the EAL devargs list, as they may
+	 * have been added after the initial bus scan (e.g. hotplug).
+	 */
+	dev->device.devargs = fslmc_devargs_lookup(dev);
+
 	TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
 		ret = rte_fslmc_match(drv, dev);
 		if (ret)
-- 
2.43.0

