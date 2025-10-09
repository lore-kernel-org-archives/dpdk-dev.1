Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA1CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 243D840DF8;
	Fri, 10 Oct 2025 00:16:33 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id DAD9040E31
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:31 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-339d7c4039aso1482539a91.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048191; x=1760652991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7O0q2HyM4GTrzmKAh1MoIZWWaXw+xyJ0JG4jLWcsGB4=;
 b=wDqM1Ui+rwsZKBsbIZj9o0raDtQohcNRAJO/7BoWS2qJdgNQeY32ggfjyMMp+Nqkhn
 p2HY8vKEucixNOPZJiKjH0iLz4PHecOKJuRiSnQdThbbswfDahSprsMpoGKv59Snc0nE
 xxXa5nV93+JDXzmfGED25+UgIVgLZk7usZn4mBa2MWs74e1Dc7DC68/NhhM4szFGMjQp
 4T+aqxN+extEnTG/RnPO5bXcrbanaeOWamkeYK5CTjfwM7X3/wLmg0pNyHI9W/P3Ve4+
 o0+xi/eWwT6ETN6SRPvHKjWLgJWlwckrZdDwstcRB/6hDDNEIHYKhIWFitXbHdBbG3Ig
 Y7iw==
X-Gm-Message-State: AOJu0YxtgdAo7R+Qtdh6nJMV0JFLTggCDpK6pM2Ds9ARkG4UsQNgibK8
 e1tgwo0eejhGcD312HgPpH47QiatHMzK3vgCiFsLdvql89wIJHvpd4FnEOxS3MKw0pBSFT98CjU
 aEFj7EDr4Y8atxxMKKA7vy94p4i1+t+LEFxESH9DUh3xibqtvdJepaFfGpso35esFU6bogzg5Cw
 CeUnLGppJsR3M+oc2BelUOlVpUM6Xlanyo67E7+iugNZfjZ96wWa0Yu8fUiLM8QzluqSU+HA==
X-Gm-Gg: ASbGncvnN/3tHutpTONExm/lhEoKIoeFQTtv5MO86Dl988QEGZ4MkZ/Z3LOyFk1gnBt
 YC1lXbzvqSAWbgJFsHpP5DxL7gDcY+49IWtryXSOuYnxRTr7ijyq7VPSquy4rCUGAThnCbUlxVj
 4aWOqvtLLMLgKLXf2GCVMMQAhdyOCemfHYlfJByQVwm/myY7zhvpwRB7CS46tjTtzJrfOexMZo4
 jI7k3w8urXsIuZDXIbDJ0qieYkKaYz7A9U3Bu7geBRVi+KNkc6s7b0YqgJWiLXJbMmqFfLZRdRN
 5DLnoENBrKnsyozHobG+1AH8Paiijf8ya5hWfT0Ks9Seno7DjhDWFHgntTfm5U73y7Fv0YONpZg
 ilg54yP85OEawnVBYjbwcZ+sWmjumJ/FOJiArjqZkTSouFzyHZOwxN0dVS8bN9XVu8oOcg0r857
 S42q4k
X-Google-Smtp-Source: AGHT+IHCBC4SORGJNgfqZfheJe6wTSQBSIK+L5doJlpTHYhlPp7ZeQgDdCuz6nOHSI6MjrMj1tMtxq6RYA1a
X-Received: by 2002:a17:90b:1645:b0:32e:7340:a7f7 with SMTP id
 98e67ed59e1d1-33b511174bamr10691683a91.2.1760048190927; 
 Thu, 09 Oct 2025 15:16:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b61a1d3e7sm92344a91.2.2025.10.09.15.16.30
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78efb3e2738so44968546d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048189; x=1760652989; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O0q2HyM4GTrzmKAh1MoIZWWaXw+xyJ0JG4jLWcsGB4=;
 b=M05JLC3B18sghKUH/Z2UHmoJrcqWzEmBuwYLk8KyV0N/LvAuNbvnAMNKCitdTsAXxs
 wRDWGr4HHGHB/zMe/ctu59l1dUoi3+Y4Cu6BCsj0GLIZrhymx5C50oVrppLupRi4Ni2G
 2+XNKaJdPEVSYCKklRwh7zKFrrgdiqOLYWams=
X-Received: by 2002:a05:6214:5199:b0:720:3cd9:1f7e with SMTP id
 6a1803df08f44-87b1bb42849mr121694666d6.0.1760048189259; 
 Thu, 09 Oct 2025 15:16:29 -0700 (PDT)
X-Received: by 2002:a05:6214:5199:b0:720:3cd9:1f7e with SMTP id
 6a1803df08f44-87b1bb42849mr121694236d6.0.1760048188650; 
 Thu, 09 Oct 2025 15:16:28 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:27 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v2 42/54] net/bnxt: packet drop after port stop and start
Date: Thu,  9 Oct 2025 18:11:17 -0400
Message-Id: <20251009221129.28256-43-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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
index efecbba2c3..c92e335a51 100644
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

