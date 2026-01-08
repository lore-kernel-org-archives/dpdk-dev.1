Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE5D1D494
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 20:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1108402EF;
	Thu,  8 Jan 2026 21:44:56 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 0BA414042C
 for <dev@dpdk.org>; Thu,  8 Jan 2026 21:44:55 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b7a6e56193cso607624066b.3
 for <dev@dpdk.org>; Thu, 08 Jan 2026 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767905095;
 x=1768509895; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+6ZCqVFFxpVXJaGWNPJiAEhJG/a+J5dvGWKR5emRAA=;
 b=HpK4IYZyKvpd48P50/o/2zkDjsaYO1X1yCxW378Acvd4HoMkXMssLDKviyKAIuVDjD
 DMyGI5/yUaXP/sIblqOTXjR+ZK0YPw1KrnaPyGVZtw4Vjn4kBrs4p+WunuRKHtHytBje
 2kQ5L8We86JbHGGfs1lqkIAPgULjeMv5Ctuy6dBk8330DS/SzY0eBx9UNQxOcFZaY+Zy
 /wC6HvU/Z4AXMzKuK8/MifKGVzOQyxNaC88PNkWeVbFV+spSA51t9vEUEcTtIeWxUaPi
 zfQ2t+9TkoQWuaCDef5EL88GB1d0OcbHmMKnAQ/7Niksdey+D0YF3G5OmPlGAvNXqRZp
 0E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905095; x=1768509895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+6ZCqVFFxpVXJaGWNPJiAEhJG/a+J5dvGWKR5emRAA=;
 b=g4C436bVdaFOEI7JTSL66y6LVPVKZB+FlmrHJRyTdY3iO2kZZYDKw5+QxpLqqQuSse
 +cyoM7hTpAGqp+9pUPPDdbtk18/P9202sll1lC/pVmBQ/aBIZh3pH9LlwtnyLA8AidRe
 Ng7Rz4tu23HQiEUMBfnDBBJJN4bATFfj0SG0ST7Vez2bl5GXe9JCfEP87b7JjL3JrKnY
 LHNeTI4irDmq0oF7htX69MMh+DQUq8AuD5Godh4B0tyn5ZsI22Ez6YvhK9vP/qQtFxVg
 zccGV4dNo0OP5DnBKA6M0sZytiF078pvZe9I65lh4BWJ76T6nls5TPDK7P1+PqT15n2D
 KUuA==
X-Gm-Message-State: AOJu0YzUFLTQAKbRFzERIcyIEk9yihTe2koRqL/CTJnBF1ttg0yflewr
 FibweOAcWD0y7KYX/rozhM7+bmYmBGKgCsDkO+q0bhPo4ZEyrJGmpIK+yqwi5QQPqgsLsNgSchf
 rUspD
X-Gm-Gg: AY/fxX6SMEf9XNFqW1WqIRnm5ArirtqC2GwsVnRR76Mkc07kjVmgaHs5XDIX0rkoSUN
 d4KrK3ZgCME5PDUtbQtgvmXw7A7iLbUQGmsasVXi2hMfVTIe+41pgdbdVMKt2e/B56PGH3H8zbJ
 dDWjhudItCq2RrYoWOSzI9chOBmGdUAvzILp3hjNkgrcVADI5dJWzaqNwHmPVqGkS6XFOAij3MG
 tCLUX4NoPHho0wwKWnXeSdJ48GaWIQtoGCVUAoCGEwpfCNZ1UBwOdrBG+PDb5SxPG8v5MCRvmXZ
 Tb75D8VR3PNz3q66hZt6E62lekobyvP5FgPIbHUeQp6My67Ws37rEhuFhLAvMjy8i7CqmTKdK5k
 mm0C15xYDFJhlymnB5zum9Cf9FtteNkN2zMuXVN3gZul9Kq4P8l+EK7Cg/0aHIXO+CZRxMuXVUN
 vDA8YN8cE80gCAB8p8wzqwckK0QlmIDVOYxLv/SmYBOnE5P+Fc9g==
X-Google-Smtp-Source: AGHT+IGgJDu6pNlk8UAEvBOVbEGvTk9UXLhTIl6KCzs9PMxg9JDHsCgM/nGltJZZclRzqdhhnmn/SQ==
X-Received: by 2002:a17:907:7f86:b0:b84:2b4b:ab12 with SMTP id
 a640c23a62f3a-b84453a1251mr687160766b.40.1767905095336; 
 Thu, 08 Jan 2026 12:44:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56962esm921348766b.66.2026.01.08.12.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:44:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v3 1/3] net/null: cleanup info_get
Date: Thu,  8 Jan 2026 12:40:46 -0800
Message-ID: <20260108204449.176087-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108204449.176087-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260108204449.176087-1-stephen@networkplumber.org>
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
since already done by ethdev. The maximum packet size allowed
by this dummy driver is limited only by the maximum values
in mbuf fields.

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

