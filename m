Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39661F8D755
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B8E40693;
	Thu, 16 Apr 2026 20:47:50 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 8E44A406B8
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:48 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so10771037eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365267;
 x=1776970067; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=CkSW7EyUQocj6yDEKLCWG54A5wBMVtQMDwFo9M53SME6pG1mtHGKaN0CPlULqSqSaM
 ViWyh4OZc1uKsGDc/XmLAthTQ7Nq4I5tRdSA0KUm/KEUiFWiTPmPxGu3IPNWhQfSgL9l
 rMnbDBxed5c+nFvYfCSlTvMQBN3IOa/HVLZIglQkyA8fccZN6FdRM30Owrr4jr09CzAr
 joUttBP8PiU6RzXBoZQuthAcI1HCxOBFQYD5A+/xTpOiD5+geNnJrpVJrxOkZOPqx7rN
 auJ/bbR9dtc90E7RUODuEScwdMslFH8kH3cEWsWr5qB+OQHMo77FehTwjciXdWWrX1YE
 nviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365267; x=1776970067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=IbjMAU9Ep8n0YvLzJwP0CPNNfUJ9ZAOqB1z5UwQS390KBlj+U/PMtj+HeE2cTUwuCS
 /XxR/zWNd+8l6uwr2r4xowvDeav6cXjqbt03ri5z0RtUAwJPeVYDfeRv9zqjJvM0vpNb
 Q11M+V0elCCOP3J6SUtR1Lj6hSm56oXFkMIoczUhL9Vz6j/7F39QlALWGUXUglu/iBR6
 ejszZyeCm9M/UYeJgB8rVh+OarvoE2pL9Y1yAXRzR85cQbDqhVwkg1aCIFr975AwuaPi
 lMIbiC/sWkdYFe3i28/oD7xtLz0RNdD/+qSn3PDgfBtEL1QaRQtDAJxhwKhC7HZe+mvG
 TOcQ==
X-Gm-Message-State: AOJu0YxEeJNsEulZ5QzHqGgM/O49UsJ/XGvJ0VsEwF0aUWBc8kNOr4rx
 CtmykMauJkaruxs1LVX0n2JNNmGbtZ9B4+Ek1lcyU6JUjZPNuXUHfLPywDwMhUfeI2DC7Dynh6d
 4vlwm
X-Gm-Gg: AeBDietgAkgDyxsl0EFDLO3Rsx91xDZVLWkO8c90wKAIg2gux5yO6+7Q/0I5eYTGcUq
 hhTR9OgfZzggkyV6oR/N2vdqiR6bBmoo8P69v8JQHY7fhb1SfY8Q3+KZ+GMvEqj1uGUr+VFiYaM
 Agc6FrMrFYBDrvdcCRVbRs+6Ief7kZjmaq64M5v6bATL9Xiu+VYDkgVWsyTgGhFA5z0dxupEZ71
 EcLDbYe5aT0M+hlsh6UrtA/ha7c9xmMLsP3cG/cYdARBoBVJu8fomECFCq0h7kYWec169u9QPHN
 5P2HvOcueLvv07Kne6ypjqA/F9QNvRQp0gq7YELe2ebQF1Qim3UkGVYtZuuaF4il9cI8DglzXDF
 hpWY9meNSwj58qFVNMSbPgng5J5RpdtZ0BDuad5lxkkfiIhHRtODRNqhaRERsa8y/drN+IcJMhw
 qHyCJFDLjwYBXTRoXS6EH5nvMQCXUf3E4LrYdMNYUef68=
X-Received: by 2002:a05:7300:a887:b0:2da:39e9:20fc with SMTP id
 5a478bee46e88-2e2e560c6eamr314961eec.17.1776365267509; 
 Thu, 16 Apr 2026 11:47:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v24 07/24] net/pcap: advertise Tx multi segment
Date: Thu, 16 Apr 2026 11:45:29 -0700
Message-ID: <20260416184731.1347342-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

The driver supports multi-segment transmit, but the did not set
the offload flag. Therefore applications would not know about
that capability.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 724b7a9038..ebc96fafe5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -753,6 +753,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.53.0

