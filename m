Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67056CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69D72410EA;
	Tue, 21 Oct 2025 20:58:15 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 37EB8410EA
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:14 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-290aaff555eso58112745ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073093; x=1761677893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Saz+LUnU2NUljE7rSnTwk7kDpDsiFFBwF+PqT9tABKw=;
 b=j4nLaxjJz7dRusfkkwlp6WlOlxfU2wJuuFBMtgoHR5bORTWhlJMNZC49MqmqfrspxB
 wrewciGlDxGqO/VquHod/N9WNLSvk8pCLM+rpN7p3e1RaMp5JiGhRhleaazx4bsf1rl1
 en5nOY4FYVLjdgu9Z0wsgTX5rKgp7hEf944yip5349kjvPv8aGSuHX8kP2VxgMJn+kxh
 knJ8RXweEznLmqwXicd36/3km4PNGyKPcXfwGL7Eng+aM3rLVa80ZTXhqm0AqfeMSNxs
 MRDcShU2fXydgLj9QGkJ1SVLftbSN41MS0aTGeidHGWs40eT33u0M1a4xxyzgTZc9YKZ
 HsHg==
X-Gm-Message-State: AOJu0YyApbAnFE1x5kZ8P/z6WNIhb/g3kzl7oUdZUrTepiO33SYHbozh
 qotDElQIIFfQXd0bva7HqeTl4FQFJw8+6t6VEQOGnPKsHtmei55Qzr7KmI5hqjDjrY6VkDQmtT0
 xmIxKIjJN6YSDeVlFynqjTxnrvxWwI+bJpGDljznSnQ6x2a3J1qsLAIKJlXl8Zw6M+2+AG4OkD4
 Pm1ZUhC2bRSFuWL83AmZaMMsaaQYrUMGs7Gly49xzRosBHY/XreEL+DawuKOD29MQrY6qx0g==
X-Gm-Gg: ASbGncvyPZLHhDLhgHwZuKlHeVHVj6DMC8tvlb2llechOjKs212xl0xfyD045y0um3O
 G44Ey7diYVcUVUAzonUVSs4BVAylAoEDMU5XjifVXswi7pFulsHQnjPv+MSlJ+HwNxy9VtVXEZa
 VqVJ3KqfXQesB6LU+CYqwBLUAlUEqTWYRt0d8JwqnxeZr8TDS29ye7UHexf2bpUmsySBe9bB40M
 GufquDNPffFKxnUtb0xGu5cMfocbbkBl0DiyDWUcB9lvh73Kb5qAygujWLQIbEpPzuzDrl0d7SO
 9rEpzr2wozu60WmXnaGGsUHYsth9Q3t61dbEwwXHXVat7g9+OyetO4J6APROieJv8rOs3FgA8wK
 XWNIhXRsZ8JNyJ5eQRwOHtIdhzhD3YAjf2fJOQH12laKh3kLpM9Jaex8MX7dbLzAgcTgJCsTyLR
 6+I+c4X29PdxNJSqtBpgCqRty44/gvMHWPmezR
X-Google-Smtp-Source: AGHT+IGze1vDwDOKl4VK0S5JmBtXVy1zeuUgyTLbGoeCmSbuCKbbSWZSNmkmSQ9c6Uhg8nj75jroIqxsHNYs
X-Received: by 2002:a17:902:da89:b0:248:7018:c739 with SMTP id
 d9443c01a7336-290cba4ef0amr230557455ad.28.1761073093330; 
 Tue, 21 Oct 2025 11:58:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-292471c5c7dsm13053055ad.38.2025.10.21.11.58.12
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b631ba3d31eso3728418a12.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073091; x=1761677891; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Saz+LUnU2NUljE7rSnTwk7kDpDsiFFBwF+PqT9tABKw=;
 b=bgP9bL7cRV5ODJ7kWbcreKdVNd2J3JKTwvEnS4f/k+sBUq7upCOPOJg0rX4agKD2f9
 lFRYA6YGmxMWUPxVi+tYKmBbCHQQzvw8/OWnaWJYqOW/oy3joMX5PzSDMB44OVMF5Dil
 LARVqPgipP+0+Ze1zqVHKFT5GqUas+GlYMIDc=
X-Received: by 2002:a17:903:2381:b0:240:3b9e:dd65 with SMTP id
 d9443c01a7336-290cba4ec0fmr219398325ad.38.1761073091281; 
 Tue, 21 Oct 2025 11:58:11 -0700 (PDT)
X-Received: by 2002:a17:903:2381:b0:240:3b9e:dd65 with SMTP id
 d9443c01a7336-290cba4ec0fmr219398015ad.38.1761073090775; 
 Tue, 21 Oct 2025 11:58:10 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:10 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v4 45/57] net/bnxt: packet drop after port stop and start
Date: Tue, 21 Oct 2025 14:56:49 -0400
Message-Id: <20251021185701.71881-14-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The packets are getting dropped if some of the queues are configured
to stop and if the bnxt driver is reset due to port stop all and
port start all then when the bnxt driver comes up, the driver is
overwriting the queue configuration to operationally started
instead of stopping the queues that was previously stopped. The
stopped queues were getting added to the rss context resulting in
the packet drops.

Added a fix to address this issue, the rxq structure is not cleared
during the stop and start process and retains the context, that flag
is used to set the queue state. Thus stopped queues shall not be added
to the rss context on recovery from a stop and start. The queues that
were configured to be stopped have to explicitly started to see
traffic on those queues.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 4ed2bf2a1a..50bc0f1f9e 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -925,11 +925,13 @@ static int bnxt_start_nic(struct bnxt *bp)
 	for (j = 0; j < bp->rx_nr_rings; j++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[j];
 
+		__rte_assume(j < RTE_MAX_QUEUES_PER_PORT);
+		/* If not deferred start then change only the state of the */
+		/* queue based on the queue rx_started flag */
 		if (!rxq->rx_deferred_start) {
-			__rte_assume(j < RTE_MAX_QUEUES_PER_PORT);
-			bp->eth_dev->data->rx_queue_state[j] =
+			if (rxq->rx_started)
+				bp->eth_dev->data->rx_queue_state[j] =
 				RTE_ETH_QUEUE_STATE_STARTED;
-			rxq->rx_started = true;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

