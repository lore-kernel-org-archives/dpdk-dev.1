Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524EFFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C325340E1C;
	Sun,  1 Mar 2026 03:07:45 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id C2A6640DFB
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:42 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8c70b5594f4so352850785a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330862;
 x=1772935662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=D+z8Reig4Q+HEinTwWlCfROCLa2DQNK6qRz+F+y8cAig8sKU+zn/+ngMHogN/oalfO
 v8ZAu3ZR3jTPHBgsrliyADnQAQk51X9N+Emi4YW9ROcg476oofBEKbEVdkqbWW2yf8cd
 DwgRz4EFhSQcNQ8Ey9uHn0ubBAiZAs74BTb7wYcGIxp3KG0xVdyr2LcoTYEGpb/WvFdR
 Pu1jfl1GRU6CBXzLPyU8z/KzuqvByVuLAepwVzKnk3sk6Buw+A+0a26xCmE+xn1qbWVN
 J0gIlZxChSYIuw5+FRJPoY1oUrkFrA+aQRuDdXLtQvM/+6M94kwYi727hnAjzrDiM4V4
 0I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330862; x=1772935662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=PJ4oL6HXLWHCtbG8n8+lTJts8ny1b6H7TcU7lUuvT+b6uh4GspuSyyXWWaQg/LcsIl
 H8yGscwGnXmGOKa6aHnhaKCySGZ2T61TjtKCtY91rabbOZCFexUEe4OlLeRCkU7ne5IN
 rV83hEFHRqc3n3rqRxe3qd97xcoNNA5MJpdqyf+mvxTh5y/OiFQsn5seTYt6QOklvD8f
 nDZgIXCVd3MMFwuukKlqiK8CYaqES+Tz+glLhdnf+s8fJJVFblPblKSjuDifUtJ4/J+M
 jSc7lw2DSQFz9li+KtGozCb9NYVgphHxqReF4Eu6/V8KCkiSIR6Nu/zgC5ugfPY1/T+Y
 R8Sw==
X-Gm-Message-State: AOJu0YyBEBJEW0gOF6sCNBi3TQcgWjNgV1ZZoLjAppjXk5vMpLWEpvjW
 uaio0NOuRQ2yUOS5m7WwmCEFJufu+as0hxiC1XTX8q02Bp3nKbbHMv81PO5pSi6uTs778ZfTVO3
 qLrJA
X-Gm-Gg: ATEYQzzUE8M+RE8z8tu/W5bRkvToYOA3J4aXY447lm2cKcMxR/L37Kx4g0p6Cs5lb0O
 OUBri6pr8q4BDpJRet3pEI3bfa+cJSZRQOSv3Rm5xhLAA/3cA1ClRKF6N5cRAqMO8sPRnbIbjnm
 ZduajLn9sySzcRN+leN0rCNUaUUy5RGrOZM525hV6DNCk1VbHMDiFkYpQmOZ6tNX73SmE292snt
 G1yJQTHVvJQrG22GZu6SZR7qn4QmT6U3PjDaptw8X+9GYMmpqcW3QlRsdxQcpRbhO7ZUDRxTNWK
 gu2iuloftJxYyuekLE267vXF/T30qxTIOHd7alfUPU6U2xPrO03htVfwWqYbIa/YARhvvnqsMUD
 LkMgsqvRZGyCvLaXQGxfGUegJbHgT8yE1xj0oGZ3e4bZ8zF1tNuSPhbOVv97JBfna2FQD/L1piN
 Aq2+Ujtzvl0pVn7+Ne4QLvRvMcqZP2cTYbnx5zCb5dwOlHumJBCti+Y/XIPRUvehHWlHkI+TEY
X-Received: by 2002:a05:620a:3715:b0:8c5:2de4:d6ee with SMTP id
 af79cd13be357-8cbc8ce7d71mr1070228785a.33.1772330862101; 
 Sat, 28 Feb 2026 18:07:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v18 07/23] net/pcap: advertise Tx multi segment
Date: Sat, 28 Feb 2026 18:05:40 -0800
Message-ID: <20260301020726.852401-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..fedf461be4 100644
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
2.51.0

