Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E9EA719A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B167D4066A;
	Sun, 19 Apr 2026 18:11:17 +0200 (CEST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54]) by mails.dpdk.org (Postfix) with ESMTP id 0034340654
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:13 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d9e22176a7so1247446a34.1
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615073;
 x=1777219873; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=N6FW95pQm+SxVgWrK4YuD2g1TTKLaEcAtQP+h8Qw1WhMxqKfjsB/B4DF2yNw8+j5ls
 +1AZZBvrVnLmN+Vgx8C1KNFoSb0XPmTvlpXTEBmT8D1MGN8+lNhDdjVllg+vpXp0dOY1
 +r1DM6g2+6dky3P+a8q2RxcMWG2GomS4qIlEj3XPjqw/lO9Nb9jOkMC9+3gl+LhO6LyN
 GWTKvKZYPV/Ft25LPAAUkAm6tb4Wk6CpmgcwoOw5mtcH21a0Xly0sPLFdiXQGf3zcLsu
 DpWssN8cwaM4KsBMeYlrth+sAOch+3bj6fMyXSFh8KxJ3lVLM/FD2SfwjYbilPLcZAzy
 tmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615073; x=1777219873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=S7Cx7LFcQ8NqFRU3kjv3Y7nGZMlmhJVHfYyuNrLxQstawoYJDioB3uH7z1m2CDXjlw
 Yxy6k0vocJYHZm8xxNWxuHBKOFbp3kAh7yOphz3BREJkD1h9A3EfaKzI0nFkJuRuGDBJ
 aEJkNiaTtZSTTQnE03dZIT1Nl6edMhX5T5W7h6gRdqG0eLkyMZxNOeLfEyje27joHRrc
 /ykPl8yacIaKFCqVN0YUa7yfr7BW0APKIWo/VVIJOiEUgixAzwTdVgorq4ELe9Eja4cF
 Zkeb0xOb/t47llhHBxdDfaMd7grJRVb0KxJUE6+x6ArArqgAJnKMhp1Oe15s7Sqqb923
 5qfQ==
X-Gm-Message-State: AOJu0YxeZJ0wKvZ2XmT/WQP7W/XAINaezz4+2B8bNwoLy8ni11397+tc
 0pSMgefStAAb+NTmSBv1V8BqhLGcPWEFSUjgPdX/jDkxRo2iCxzr2zXwPnYjfcw/wR5Ndoj+s4X
 wLCoN
X-Gm-Gg: AeBDiesXXNtkkMpCcV13IGVM3LRcdsu2NPVHL7Sm3kEsFV33DKfHZexCPkw3EnNnSNf
 314sPEX5Q84Jre1k8SO07bfL6Ln1UxlPLYM2rQPVWvXXNiRYXHweAdga+rnzbMVmA0k1Q+HmuQk
 /LofVncgAlj3hqtKzAQaF15vfNUTwCDKW0exKmRZ/4omXzhcyFBhySwdtZVTTsvUNeh9ZUoXsaY
 odEf5PEu3l02TvR3jZY5VdkTjGGdmOyL3TBt7IYX9Fdz02VxT7ZG5AD7c82AWYOP3J3a1qzEewH
 SNxSjSDGHpTfZSh/zo6EHl8BS4kOedeBgg4ImlQ2EZ2J6QVp2bqfDp6kx3kf9FhBInuQnTucx9/
 hyocunX8EykxiGdymjv0dtwQugNSkNYYdEyQkO3bR2oobKanOfNDwx8UVG9MiGaf1QHsR+vI7dJ
 TkH0y/9lQrZPBI8wvgPVvBc5AZED00xizkIqLhuVPPFl0=
X-Received: by 2002:a05:6820:2902:b0:68c:762:de45 with SMTP id
 006d021491bc7-69462e63a53mr5762914eaf.20.1776615073304; 
 Sun, 19 Apr 2026 09:11:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v25 07/24] net/pcap: advertise Tx multi segment
Date: Sun, 19 Apr 2026 09:09:40 -0700
Message-ID: <20260419161059.205954-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

