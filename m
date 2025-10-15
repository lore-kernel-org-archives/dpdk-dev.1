Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFCCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FB30410D0;
	Wed, 15 Oct 2025 11:05:17 +0200 (CEST)
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com
 [209.85.166.227])
 by mails.dpdk.org (Postfix) with ESMTP id 32EB9410FC
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:16 +0200 (CEST)
Received: by mail-il1-f227.google.com with SMTP id
 e9e14a558f8ab-42d857dcf92so23875165ab.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519115; x=1761123915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7O0q2HyM4GTrzmKAh1MoIZWWaXw+xyJ0JG4jLWcsGB4=;
 b=Q8xwKaO3esORm7CWRTNS99OknLh0hfhRCIbK8wrQv1IR+7QuMAh0FjO3qUXqV0g6Zt
 mmRsix/1LNex0rj9tUt2Wp75tz0NmWrR6y7hOinqPLH2H99FLM3g+c8m+kSQUfv2zBFL
 txFD2ZLNcVQobw4/WQGDv5EWltFvm4wL9I2dDnYpEehGZoRIXFd66RKC/ogd7X8+G7MT
 2hMizBV/jryPZhJb7F2pTTBdnYuJixPqmZK6pJcUJih2LXG6Sn/gd+tKqZwkcq2znDkf
 ZVprJQ2tTCzFxBK5hfCNfVjfFP2FnxtasAVfjsnPz2e46EuN9OGHz4uzPtZapMl81miI
 m9qQ==
X-Gm-Message-State: AOJu0Yy0kCxOaHdJeYHwl5gt5ulpv4SSliaVVJkm/tzZpwj+5q+a0R6B
 GC7DEuGhYDINp0FHzaNP0vtVESqcPnPZf6KATvvdK/cfwv0TYXqWpaP53f7E7FsVCbd+1QlTmDA
 AN01JYmG7DB5AFAl/n7l/As/BUBqko27G76eJNQNK+9Ngfy2MU+RTFUXNRp9G3H4LCJtqtmBPyv
 BEF/i1Z7XEJ1gKN+gn1J7XjWbiWi1deD+0ix2yqnlAWvGCTHLQYJY/2Hj5n5fR0fUoq7rrwg==
X-Gm-Gg: ASbGncsqLe0VGGn+JkrT3shjZO5HIe0r7YcwNW92CJNJqSeEKyKABNO/33K1h+feQPZ
 ENIRxnrCIAPFoAcG+Bk914g5S9PTa6HoS21A08pW+jedbwsjbx78Y2M9BagD73DTKu5AQvsG0op
 HNeJtrLgPLjQeagddLLrvB5wnTOj5goCXNNMtCG01MbbUuD3g1mlgd88WPeIXIDek4ngkTphSYw
 h2ZhX7sDEcqtEX8/QiiPLqv9tcyvmnNc6sNjn8Gge4isW4Sxmp8zMybhMgGvwgx7GSMyDtwNyqZ
 Fo9CNj2CqjX32zgXwDmXDxuGCML9KiA49WXrq9J3bvhPpbMC5PRyZomOAw85dAtj2lN2LleXsiz
 bUj/m91xWy/BGEffPaYhaecO9G8dwpX+PtRNKCHVwpuVRZW8tyEFBzTQiIau7PKS8zPemZDAh
X-Google-Smtp-Source: AGHT+IFdIAnDMzWMs/KvRZ/sT7DNWCZdS9gIvgcqrO7zB8UL0tWNMmhtSYMIt4jMPZeGRy8fLAY7YqM3aulE
X-Received: by 2002:a05:6e02:1d8d:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-42f8737f064mr320598815ab.13.1760519115284; 
 Wed, 15 Oct 2025 02:05:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f6d04111fsm1246498173.4.2025.10.15.02.05.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b5516e33800so13830538a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519113; x=1761123913; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O0q2HyM4GTrzmKAh1MoIZWWaXw+xyJ0JG4jLWcsGB4=;
 b=ZMlaexHrggSFnaAPTRgPRu0GyIsW0DYaW/GUsDQcaos7F+8uechlw3gmz1XdjMNW5B
 8fSni9oHBSzwQQgXWnu7NZWNwLL/i/Ve248Kp2yF6OHzAnioJzrfm6pwPV6dydarS/OZ
 StQyyAe4tV8yUhFipSKAae4ZazkJ8qmkl9+Iw=
X-Received: by 2002:a05:6a21:998d:b0:250:1407:509e with SMTP id
 adf61e73a8af0-32da84e8f05mr36106364637.53.1760519113093; 
 Wed, 15 Oct 2025 02:05:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:998d:b0:250:1407:509e with SMTP id
 adf61e73a8af0-32da84e8f05mr36106322637.53.1760519112413; 
 Wed, 15 Oct 2025 02:05:12 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:11 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v3 42/54] net/bnxt: packet drop after port stop and start
Date: Wed, 15 Oct 2025 05:00:12 -0400
Message-Id: <20251015090024.32250-43-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

