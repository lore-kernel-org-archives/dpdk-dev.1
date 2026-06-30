Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948DEC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D84840695;
	Tue, 30 Jun 2026 16:43:41 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 0AE9940691
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:43:38 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso2461849f8f.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782830617; x=1783435417; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDtE+WpagDwaY0bl+TOWMTuttVnWhu6gB9+Qz0N/s+c=;
 b=XXi54NplSCjIL408CmT8YkI+mfPZYGOmfeeDw563IwScgCCHU+NsaOJBbdFn21fhaN
 k/Mvye0sJGbP2a9Yv5uHWbl37/kuMnZCfExMZHZHQFIbKoadjxohEclL1XibB7RIiHga
 28JFKzfZUeC/GiemcF3eSqvLeoRWDe8jQGPQ6x9lCyqDENVXa/JE/28PBV0fFMQ73wtP
 qC8aU5QQcKJWOhSfpqIHNMK/G92QOXtcm4uzpH4R4R3huArM5c3kkQAtUFgzArXQOb8N
 5RVJmfFCs1hFyD6bbXUA0h6VqBmpBeTcQGGEFYFO5jjrcPy/zP1b+5IU8l4Cf4Z8uOD6
 aaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830617; x=1783435417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDtE+WpagDwaY0bl+TOWMTuttVnWhu6gB9+Qz0N/s+c=;
 b=RgMqudQBVBjfdD8hbsdiTS9qTq43wkE2LVez5m94xQzTxDYcnET3PWBBfJcYXqTXeX
 HmIkQ65+mOseGGZgOWHuBx5pWeEwfyA7kDJsXCLr7Hs26paSmgd4DJcBHi9cN/wy7ugs
 zDGvhNoHWxlAiAoZTsfQrjsC7Uqx6XdSEhgiJaclnucVZ0VDzPon8r6swI7qT05NZH0T
 YAnHk1dnVN2noP7wrhoelhaNEabfn0t36c8k5fVF9kXk6PURMJEh1mwLVuNbZCwnIBFR
 9GOIFGFFz0Dw2/I+wTqtL0N3fI7tJLXPOPQRYjCFRE+WizHpldUzLXExCY9DPBYLDpVM
 8o1Q==
X-Gm-Message-State: AOJu0Yzlr8G+FPgUM63ecL8xQXe4T7gHNfOoh/AKDaxp2TIjft45C5jI
 Ic4gPqFMKh7WCbtbxR3PiIR7faEnZzjtDvV1KHnV7k15t9fTZ0/zvQlRc7zC62cT
X-Gm-Gg: AfdE7ckEbKFKkxQljQlBHvk1BtiEcVmBU4Asrx3SuI3qpNj0fCd2AeDZFcjPLdabZvJ
 OxPFmijDD9QvfAPeMgC8AGgs7MTUKd+X0UxFoyE6jrS5CiMK3pCbixRZuBPFYOiq1ku/VKZCeSt
 ewO7SN8dW1MJulCTlziLysMM0HL/hPnHU4WqvZoh1LX9bTpfYOGn9tKvlbKlfuOLHxYYYbOBz9o
 WToaFsxXTlK+z/npPKXDTH2HlJpHWrvaaid4bIPjraAfoLte0/IafH5beI6Fn4MNwFk8ZU46HPD
 jFq7aFABtUF1XQgX8AJ3g8wbxQCjIqE2FLA+focJ2lY+yPhMHzXLEFnPn5yeryljJ5sjKSAbI4l
 FMfuN//g1nLPg2XV8Di1bUjeCdcNGBX15xPQjpTh6DHaPUz6aC7euUZ/jQAYQd+PwUcHJyn5EAO
 C4CchjnTHhm1wDqcBw+VSXsWlQcLLDPytugFdJIKgX8wrWF4GMQlz2CS0=
X-Received: by 2002:a05:6000:2084:b0:46c:f9fe:1e9e with SMTP id
 ffacd0b85a97d-4755259dc2dmr5196566f8f.31.1782830617364; 
 Tue, 30 Jun 2026 07:43:37 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475671d02f5sm9052814f8f.28.2026.06.30.07.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:43:36 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 1/6] event/dpaa2: disable channel before closing it
Date: Tue, 30 Jun 2026 16:43:24 +0200
Message-ID: <20260630144329.457643-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
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

rte_dpaa2_close_dpcon_device() called dpcon_close() but not
dpcon_disable(). close only releases the MC control session; it does not
disable the channel. Cosmetic: an idle DPCON generates nothing and every
consumer reprograms on setup, so disable before close only to return the
channel clean, as the symmetric counterpart of the dpcon_enable() done on
setup.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/event/dpaa2/dpaa2_hw_dpcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
index ea5b0d4b85..f65a63a786 100644
--- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
+++ b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
@@ -128,6 +128,7 @@ rte_dpaa2_close_dpcon_device(int object_id)
 
 	if (dpcon_dev) {
 		rte_dpaa2_free_dpcon_dev(dpcon_dev);
+		dpcon_disable(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
 		dpcon_close(&dpcon_dev->dpcon, CMD_PRI_LOW, dpcon_dev->token);
 		TAILQ_REMOVE(&dpcon_dev_list, dpcon_dev, next);
 		rte_free(dpcon_dev);
-- 
2.43.0

