Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D0C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 12:12:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9E0F42E6A;
	Thu, 19 Jun 2025 14:12:26 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 46CC54025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 14:12:25 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22c33677183so6510395ad.2
 for <dev@dpdk.org>; Thu, 19 Jun 2025 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750335144; x=1750939944; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DWcbdJsCPmThkQWA1793UdEttn6IwSbjjive4G0wX7g=;
 b=Uv0tyVLIkgIa6ASsuzsnwWMMDJyzEpllQ9smrQAD+FFkM3PNiYWPW3g13/EroXpd8p
 UWwMWHmRhFrzFmEA3n5rVAUfppMkLcewFgaF4DDE5wHmWfkltiCebo4ruj2T2fJo9mT4
 YlTLEslSIMaxFCCPOKfzAv5hO0UNb4cKwxZxpIhDsqHsC9Z5+BnEaJd+HKntAimSKb5t
 TnINHDB5pjr/YgSNvIaodivX5edC5xL1wahiNdceaKv4QtB6sZDyVMyypORjuxT4qCFm
 9xJVQxNMZTisel0D4n2c54POBoyS4AqqdIAw73DmYPlm3J1za0jiCxaDOHOIg6Q8pCRu
 5oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750335144; x=1750939944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DWcbdJsCPmThkQWA1793UdEttn6IwSbjjive4G0wX7g=;
 b=CW24oz50EC+b8eaQIHnETV2BxxM0JgrYzi4DFVnX7ztBYJG6ItN/MlmJ4nUXRu/ZNa
 0l1WdJQ/SHlVPGH/DTiH5vNgUgGs55/7ZY3FZPK1X8LY7pcOucw9AGLR0CPGBRrqkRSt
 Hkjr91TLV3hocX94m81ae4MFC6yrvi6c7s6xydSbRmlDeL7IhhXV/uzNyCE0JQoOLTIM
 /Bfc54+HpvtHyNzTIRuAplngC79ovzRt0nL09e25HNk8Rznak8zucTZzlL8YMJ6E5ivq
 BUNsQULTDzZXqUGBT77TpjuYR4Gjm2PWp89KpE9Dd+7xA2qjurx0Ke61nINudQ+jbOos
 d0Vw==
X-Gm-Message-State: AOJu0Yznj4rf4FgHg/oxQMUhgBIJL4BoQBxeGtJYMK6IUb628jcoXmNr
 TCUWG0odS+cNaR/CdJB37nh3oV8fT/uvUGglfKjzG7xgiCQOIBXz0ZEU39IzkhGC3vk=
X-Gm-Gg: ASbGnctpK2fRJduUBj+KjtsBZDJFSFNUfVwzl8QufeuhCLsccLTfE2pz9DmkYrkA8X+
 Dqrb2Vdn8wKFPibFSO/DHkMep2NLPW1bYV/AsQNSdsV3J0Mx0IfmiUt+6WoW76B4ntTKVrXVjaG
 lDca5zKVndHJ/JqGBhMqUClxaaOOwuxVHuMV4IRLIKHSscv/XgCjJZl6Tu5E5kdt4y/c8XyJWv5
 DQNLCq/EqB5zW3/WtqbmauI+5YZS2//8F51NKKKtECO4UaCV6bsA8AkCRWW0dDHvbLEIBHNQ61E
 sofuKinBuG6kLYCGp/2wzebC4yYuNgFlns905UinuQo1L5qQ92+5QetFMXyzhNQxGqMDX1PIlwj
 mOWvVEDmOczxjEJY8s2cKlCY=
X-Google-Smtp-Source: AGHT+IHUn5KBR6lh9ctLkAPQ86IAWtbP4qiL47e0xqrGAbkyS2jaz8j6K2KP/PM4nfiDssuXPe8leg==
X-Received: by 2002:a17:903:46c8:b0:234:c22:c612 with SMTP id
 d9443c01a7336-2366b17b6d8mr325669385ad.43.1750335144186; 
 Thu, 19 Jun 2025 05:12:24 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2365d8a4d6csm118827295ad.88.2025.06.19.05.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 05:12:23 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: dev@dpdk.org
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] net/virtio: Drop unused VTNET_SQ_CQ_QUEUE_IDX
Date: Thu, 19 Jun 2025 12:12:09 +0000
Message-ID: <20250619121209.329493-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
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

The VTNET_SQ_CQ_QUEUE_IDX is orphaned, drop it.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 drivers/net/virtio/virtqueue.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio/virtqueue.h b/drivers/net/virtio/virtqueue.h
index 3b468bd4f4..1f0e6ae77e 100644
--- a/drivers/net/virtio/virtqueue.h
+++ b/drivers/net/virtio/virtqueue.h
@@ -144,7 +144,6 @@ virtqueue_store_flags_packed(struct vring_packed_desc *dp,
 
 #define VTNET_SQ_RQ_QUEUE_IDX 0
 #define VTNET_SQ_TQ_QUEUE_IDX 1
-#define VTNET_SQ_CQ_QUEUE_IDX 2
 
 enum { VTNET_RQ = 0, VTNET_TQ = 1, VTNET_CQ = 2 };
 /**
-- 
2.43.5

