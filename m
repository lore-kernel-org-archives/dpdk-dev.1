Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9040EC53216
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DADC40679;
	Fri, 20 Feb 2026 06:48:48 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 213934066B
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:46 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-896f4627dffso23971276d6.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566525;
 x=1772171325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=0SQthPtyBhFVYafu9sn/aAzhWPKfGBGBCavzwmqd9fD26AYq6tntEDDHTRjDpBIhUD
 uI5TNfpD+HpuCv8RcORWSjC6sfJrd1RlAXCCQB4zW+YJ5/54u8x+Ws9hw8B0q7kPjCqW
 mFST6/oUMoD5k9hl7zSaSamvOLijUEOnzsoBLgq+vPFSooStHxF8O5Hzb9HrKxc2+HNq
 PFEj3RS+QL3dkzG1Yf5Z6FJ8NDMJAhpt4gjsMhMQnF/KkmXHNrQt4ET6L7IgBJZVS2EW
 WulHROTaJMF3Qg6EQQ+FQih9UfwulbC10iwN2OHS8WvgOgQuEHqD3vabw8lTiVhHzB1h
 4UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566525; x=1772171325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=EJZCkERGsQW7Kx0xbjpcO/awhh8DlzMQWvvzqzWSsz40oeS5Oh8EFrRgbSNgJ9UTKr
 mF/t1PxsRx1BxBITPfZR2THcRjTRiLrxOKz2g/0nuGsyW+UDmVjJk7n3PtJhJ5zO26bG
 n2iwSvgNanNdPXcaVLXbuoDku+9Qjw41RHzVETmz6/xAR4PVfKqf0tbAkUWG49+Stlk+
 dNTz0r3LJP4LDFUv0VfH+52CAYoVceKJyZ09ZqNXLY33KnBQ3DOL6mm+YV+qvcsWiPPX
 zKntfYuhO7e0VF2EoLbgMZsTx8j59XMQb2jKLRw8M4l6OA3u7SJEKMEWep8GfpxYepvB
 X6rg==
X-Gm-Message-State: AOJu0YxjUGQf62pA9YVfiOiJU+rBHsdHOvAYZuxpvDJ7wRsIYF/Aussl
 vVNDf6E91OLbVot/kTb0C4mA8WVUeEtqzZE5XJMMdpgTZTnCfsFaFPtVMhUFePU/RQAgsU61RG2
 quOdM
X-Gm-Gg: AZuq6aLvIkr4LBvRQ1Rs2gWLZJZGqNN7Fy82O+VNxXtu8QLbOAMjUy3pDB5ajQam5Pe
 Zos/vd2Go4LEgPCsK8ELmKLrvuzzmPIjIn+SphVXDd7gWWlSS1vO/hIQF3NnilZW/nJhLK9o+OR
 bW25lUJLUhwcz8lStFArI4ksayItZSmcZBcq09mk3kTNIXU1CiIqKjPvjsfRIhDQSde64M8oVCN
 /twU4pCEcxqAqGlA0peiIXtqBawaBj9UaRssOn5A0yN5IbxqIWZuzkBRzphMVkSHMwl/Uym0VVV
 64nQVsBAefZ3MEnXWSGuZzV/QOaUDMmyaOUzjQAlZ0G9Lj/y+ANPf/WDJ8PrIP3zDen0q6kqUOL
 qxIdyBJEA9ULw433BkvXidkGXZznKLj47jgLRU+1Yl5uXQGfJWqVxyqyq/fFeVZlfL3ViYuxtXV
 /S/h6vZy4cedjwAO3bs6MUVd4r4OHsiGhfAms2cFKaRSw0HbY718o4Wk0i31u3wQ==
X-Received: by 2002:a05:6214:d89:b0:897:2aa0:f88f with SMTP id
 6a1803df08f44-89957f735b8mr114419276d6.15.1771566525504; 
 Thu, 19 Feb 2026 21:48:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v17 07/23] net/pcap: advertise Tx multi segment
Date: Thu, 19 Feb 2026 21:45:42 -0800
Message-ID: <20260220054834.1632201-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

