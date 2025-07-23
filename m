Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9811C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:30:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8C6440649;
	Wed, 23 Jul 2025 06:30:17 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 11A93402CA
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:30:16 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-74924255af4so5403920b3a.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 21:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753245015;
 x=1753849815; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWf0k2rOjwRN9rM06Zq0TfeEO/EBv9g7SCSh658YOys=;
 b=AbL38duOM6oNY43wKjBQui4wZFmbajsm0xuFxEFcyEtOzxbaFtO9M/X4shCV+AiosR
 CFW7+t6/0NmYMrs/hXW0pcKrCAEgggMgOC4ZoRKadSWtu0tQnWNOC3Feo+jyr0oLZyAt
 WEy1P45crEAYfaOy6t57+Iun8ucFbRnjma0udHQJPOo08GToWDzdcMIWDwYEEPMc2oma
 PSLKHWyg8vjfuKBKoUUVe3wcu+GQy2s3fwGKibITKBKqpWWlptLudejgIpuS+p5EIbm6
 JvE3kCN7kC8qQYkaLZ/J6WKRiumKlfvc9BNvo/cMUAmykh55Zs8/kcxE3dseuIC081Sa
 3iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753245015; x=1753849815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWf0k2rOjwRN9rM06Zq0TfeEO/EBv9g7SCSh658YOys=;
 b=AMGNqGWr/RACZLk5g4wU4m06gzevaeZrOIpxpCC8a9l3g4alGYuYw7tUVMvtwnB99S
 40SdFuTRRcrBjVJ3lxPNibjQ/xGxVNoG1HDr8Fx5PVd+wS6X7ds7aoG+5ac2NQ+h5CSs
 UcF5ETLFfAwe3OX5kF/OHbBxo5FtxPwvWw6TTgcAcMXX5GjUKO+D7c/5L0DmwsfSNFR0
 RQhrEDaXyJopWzHbdvs/Ng9es58uPWlQF+Y/L7MmgoZAuooFE4bCvjsWcvcYsfslrS8U
 kFF15l1LDSLUaCxtpQox6OGLl5bl1iWg3fDj009441yM+MR30xMa+TpRepJKBKjt3yqX
 I96g==
X-Gm-Message-State: AOJu0YyR1O+EWcfbPpxXn9wLXCPB553skDybCief8bj8HGFnUTzuiPCH
 e6Qcqwhs1YlSOU46gM/0ZalXyK2jPFJ1mrtUKy7sQkJCa4Y/J2cGqaTuqDGTvEMrmAE=
X-Gm-Gg: ASbGncuJ7ddAh3ytEvd8jxCWDOtL2Pot+6vWQLYSKlylJ+nuhEuLbafEXhX68T459u1
 Y2WJsy6xo+HCWFvsq4SKBgnNgC4TYzWezD/9yEQI2jfVz+C1MIJgHqacol8KSu8rfIvuSYJVefI
 rdsFqdU/ZY2wsqmGmOs72w/MYUtiI8xuoq9UEXdMBQH5qwGpWD2fw83QDTvzqbgF0Od4n2e17s2
 FammlyehN7wuaODVc1cMwyJKm4tG8hEuqFIPlg4hv07wG+U+ysTmKP2DNXZV/bbdpd72y7+M56/
 76uzRpCBXUZhKS/xbedI1SbleTE62uMeJp1iINBYfYh97S/Wqp4i3fcfih2Fk8lU5jamnaz8UcT
 altaYOKRr4MzuAeRSLgQFVlr0lN36deF88O3ZfiP/mccFgsK/X7l6y8iuFP0=
X-Google-Smtp-Source: AGHT+IGZprT78WgRApbt4V3tfKqboFsi7eA1e1by8dxXR9WGKjn/6AhQGAzqqFlsKiw5zqUeOar7ig==
X-Received: by 2002:a05:6a20:430d:b0:234:4776:f418 with SMTP id
 adf61e73a8af0-23d4913b9famr1997021637.33.1753245015031; 
 Tue, 22 Jul 2025 21:30:15 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb678fecsm8573372b3a.118.2025.07.22.21.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 21:30:14 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: thomas@monjalon.net, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] lib/ethdev: fix segfault in secondary process by validating
 dev_private pointer
Date: Wed, 23 Jul 2025 00:29:59 -0400
Message-ID: <20250723042959.1576338-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, directly accessing 'dev->data->dev_private' can
cause a segmentation fault if the primary process has exited or if the
shared memory is no longer accessible.

This patch adds a safety check using rte_mem_virt2phy(), with an
unlikely() branch hint to minimize performance impact in the fast path.
This ensures 'dev_private' is still valid before accessing it.

Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/ethdev/rte_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..ef5dc55f2e 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 
 	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
 	if (diag != 0) {
 		/* Cleanup already filled in device information */
-- 
2.43.0

