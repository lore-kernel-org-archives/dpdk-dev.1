Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F076BC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 11:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3477D402D8;
	Tue, 22 Jul 2025 13:54:51 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 84EAF40283
 for <dev@dpdk.org>; Tue, 22 Jul 2025 13:54:50 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-234f17910d8so47635735ad.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753185289;
 x=1753790089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OFlkxXxEvhMxJ6O5O6X2a0Pmpnvx9QADNavd4cExEls=;
 b=eEWIzuBsZzWgohqpMJ2NjCYMOv6J28pCLeq3a34iGhK+hwlRsNhZ2zz8yoCbYLud9t
 yJvu4QI0MinjKp/3UhyRuWVyPN5TwBzgC55SI2AZyazFPtUkpOzpDCleWSNckfVJ700P
 caEnQu5uv8+NMwd/ZM4x64pDfdWfA1hKEzpYZ9EgJTdA8k9OASMc126aIbgy4825ngbX
 9BD6hnR+TwiXE4DBYt553/h6gG/V5nZSq5Wg6mRPthj8bUE5XL6HZDDssO6PFohOw5I4
 FUO0A76fDc0BMrYaJs8OJl7GbuAyRzOyKJWT53zImr9o86i3Rgl6xPYfj28VhMketgrQ
 Y8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185289; x=1753790089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OFlkxXxEvhMxJ6O5O6X2a0Pmpnvx9QADNavd4cExEls=;
 b=klS0PlxS/GVF6u+PN1UYkaecvr4EeLATdI/LmbfUaDmApWP2w7q2VCPQiP4eXE6FCX
 Die7Tokj5hKpx34tCbiqC603sKG3txiUzXpkwy4Gv66m1WWYxiMYyatbM7r1/fAN9lfP
 6OgktBl4roBw48OHSPwn4SHFK7buvXghOaNC4kbfpNAI379uSejR0U+Gw2f/KYOVsN/y
 bb0b1KlUheDG+7xXWhDl6/uiHG5QgAiOBN+KEEWtTuV5Yfj30zh3giZmiU1Km/JWWJuZ
 XTxjRTE11tDgVaFGpY8No27N3H+sXl3WPO/LCtOJ1MLiJRhgKPm7x/oFJzUWjrFfhbaf
 2H4w==
X-Gm-Message-State: AOJu0YzAHaaPxwFogJslKBTooOjQdazLIeNwjfLFeRP/1cLUq/6+ofRi
 MxloJfzFRQ3eSeVlbNBpV0Bq+cOS1t0UynwanSevBTw8eNbudiU6Jz1bI6WmxMwMmSI=
X-Gm-Gg: ASbGncubwfQRZN/YVjCCC4U/b652IkdSSKKp75lIVMSd62sLPkLH0lWI7d6H6RTOM0p
 Z0X7oGAMTHox/Vk4ZD4wy4/64anrKoogHsyNquyMcc2f/ZJzk8NWBaJZr+DmhL62nBqojHZscpp
 xPXmHN5e8XqXVpIgLsXRIPMw/6VdoTQz9/1pbuBzel4Bahtrmsbsg+d8Dnobsnfq10PyUb5G9w1
 h/mRWFbXIiOzrDgVj6QIMWivE22ySD9kSD14pqiSYxTSl/HVy9nCogaruKDYO9TxyKcP40CY9Mg
 TIwlqkJiq/MWiC0zB/7NMBQYv5ULfdRvdWF5Kktn3NBh52RXi/v0e6AllmuvfP2PGnDdOm0ZyuX
 g8xsR67VBjr3JaJq8A3ISDT/5EUXy9qzwInqZOnrMWMqzL/uj
X-Google-Smtp-Source: AGHT+IFZr14/TFWLiQMtMRd2J0z9GeWlD2uUHFIPGPEnbGmtBZohAwGC/NSE+qBvMa+V2PPjkFm0Gw==
X-Received: by 2002:a17:902:f906:b0:234:d1f2:da31 with SMTP id
 d9443c01a7336-23e3b766079mr175530855ad.2.1753185289504; 
 Tue, 22 Jul 2025 04:54:49 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b5631sm74684865ad.124.2025.07.22.04.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 04:54:49 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: thomas@monjalon.net, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] lib/ethdev: fix segfault in secondary process by validating
 dev_private pointer
Date: Tue, 22 Jul 2025 07:54:39 -0400
Message-ID: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

In secondary processes, accessing 'dev->data->dev_private' directly can
cause a segmentation fault if the primary process has exited or the
shared memory is unavailable.

This patch adds a check for dev/data/dev_private and uses
rte_mem_virt2phy to ensure the pointer is still valid.

Fixes: bdad90d12ec8 ('ethdev: change device info get callback to return int')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/ethdev/rte_ethdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..03ef446a96 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4079,6 +4079,15 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 
 	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		(dev == NULL || dev->data == NULL ||
+		dev->data->dev_private == NULL ||
+		rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
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

