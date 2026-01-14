Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79DDD39000
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 18:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA1B340BA0;
	Wed, 14 Jan 2026 19:32:17 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id DC78F40695
 for <dev@dpdk.org>; Wed, 14 Jan 2026 19:32:15 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso1549585e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768415535;
 x=1769020335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELSiMa4VL1RSiHHKkfMVLmuXDjT+dqenjHsnemPlp2M=;
 b=TlCC8tN1r3uhCo5SRGBgE0xWSozcBCJu8puHJQ31SXr+kz3QADNh/lIoMRZp/NwX8z
 /c79Y626WyzroKhNEjyTWcklPOWZCu2rCSOhil7jFYCetG/krqEKpjxX3veQ2JrQCbJa
 9m62qn6F03nL+6rg2lg7apmo+3gYzeTgh9l1T6tOlbLSYmsFhcvHeBzj3ywF4eyV9NpI
 4RZBBBmJTjV2hfqvM1OnVArHr6/JQM/AuBIi9IOo8Xa5pu5psQg8bRQBJeliBmUoHZ3i
 BWfrzlULaQzlHGlaiv/XcYuKXNSSpdcoYZ04I0sbTWtNQWHj3p+FwcFUf+s5JSE8fq+m
 WYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768415535; x=1769020335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELSiMa4VL1RSiHHKkfMVLmuXDjT+dqenjHsnemPlp2M=;
 b=c3kBNRySSNXTWFKc49bHU2NIwZXahozii/PLsBcC/lt+p1Ya6g6hqUnzJYW2ANUa0A
 P6cf34PdiE2/Ko8t8RybdcRh8uYfNT3TBCgEIT0DsW56lsVZSm4J7YcHCJx4zWRL8T9M
 J3+j2jFfI41XS4TimA8xTf4K81femk+s9qsJYzkeyS7/XBmS1hGIT7K9qYGyozCOssrB
 EfXKCMtOPe+wat/uB3eS49TsbBaRVtYo6TBU2pa8CZyW2zr1m7LbGIwXC0I/TTlGYPOL
 BDC2fDFrl1HIaKHbOXHTQtdIVux8if2vAtlWCygSQTg17qhNxXnNBXztLQIJW8wrhe2J
 a5YA==
X-Gm-Message-State: AOJu0YwOg+ifGnAK3zZALbx55Y2KE4v0aFtsbN0va9+pmcKN9quYLKuc
 gr33aO/Ox5edfWUDExP1xu1JEO+kKlZlbB3ijaeDn/sALccIUGVFjky7i2I82aT1tY/WF6NwkUJ
 ipXPd
X-Gm-Gg: AY/fxX71qKM2g6yoS8Kk2iGoBX79nzZPSZL7e6eNzKNFHWGKO+QUuxBZvoye4TBgEuh
 Uh5MB1RP4WsBkfr+54SAw156axyE1VaOtCAVRs3TFgtXh/zBAtjaJqhDU6zP5+8H6hmmikNXYcn
 4Eb6SNtqW+eXbZFVC9OcZwr9AanxICqKK+L6ogV055GTPrBWDVXGatl/R0OuOlzWcga4X0GJ1N8
 yjLWqV6Qq/eVMF/HaHy+Ubmmb3s9maiWzXS0MMdgxQ0Vd2lAwoeWsSoxlxvlS0iTvuMsEtPB1Wn
 C1hMQqF5VOlHM3/vyPA24WYLcdc2tr5kgGKG8QzZ09Mo1Znf10EkIClPr96rAOIM35CHMJqSUyc
 vmupYn/1Mww4RyhF3AaUGn7Fb+cjFkShGeCHYhgx+2ljKAllbnUEK/Haz16G5O4sJ5jivi8jSnT
 t9lRVcjFSeGneY8C+iFo4aJpH/e/JH/kMrgOAnKW3zLnw+FISPnA==
X-Received: by 2002:a05:600c:a101:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-47ee48b510fmr35046015e9.16.1768415535423; 
 Wed, 14 Jan 2026 10:32:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm4421205e9.9.2026.01.14.10.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 10:32:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v5 1/3] net/null: cleanup info_get
Date: Wed, 14 Jan 2026 10:30:44 -0800
Message-ID: <20260114183208.14256-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114183208.14256-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260114183208.14256-1-stephen@networkplumber.org>
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

The info_get callback doesn't need to check its args
since already done by ethdev.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..3e743a23a9 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,17 +298,12 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = UINT32_MAX;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
-- 
2.51.0

