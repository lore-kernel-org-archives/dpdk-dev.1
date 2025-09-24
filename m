Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12660CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:55:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 313BF40B9D;
	Wed, 24 Sep 2025 18:55:37 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id E03D940695
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:33 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4c7de9cc647so530081cf.2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732933;
 x=1759337733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW/Got6uYrdklgJgNryDlLHJLOEDVOT9F52gL8wMthk=;
 b=TqF5BXaOH1et/H66MiMvovZ3Q6yi5PHm9z/DYoK8R80TQEV2LSSlOKlIn57buxuWYw
 qE1R8IRYi8oQFIcHXb1pWXEBrKaOKVosneDSZTnyRmiFIPrVMDG7DsSn6UH9aKYJAGYA
 qk4ndlAP1lEBJ5KK2jM1IgW4YY/Us3h/PUrAFP2UWe9APbxJ1/ZwoZ+a+NI0hZzzD1VN
 dBQjnOqReLHynKKyH7+XAZix9VRn69fwruNRb+c1RzcIj5tUDzOxrSQXE6n9C89zgkzO
 A7hSHhewsFuN7z41f1timxewxK6JqksmhgaM58sAvyMUvnXfZLvcjWesGpqItR3upOvY
 uS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732933; x=1759337733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VW/Got6uYrdklgJgNryDlLHJLOEDVOT9F52gL8wMthk=;
 b=L84cXkx5Kngn1VczsBHelaNajSqDafvTPdifUaUQ8P3jMrNvZtk8/N+hbtL2Px4NMv
 5NzDm6iqvFZfSrCWqqbb1ODdIpe+GH7Jkjl7uMvbo1QlTfRQHLB72uvvs9T9FVwwDXVJ
 g7NA+Kf8uhxBk0Ae27lx3+EgtnrML0JKh0lk8CcgcZLDjR0gQpzTqVqVeyreWSw1ETdu
 Ir+YxaJlEcu9ZHfgLaXfGyZnLt3DjITScu4a4zi+EuvVFkhAgkW0d0UlrlFZYJtvUEct
 81CsE7Rmfe1s35GKiGQKE0jbZtR7+0BeDVfm3cbCE0hPILfPcvoOxzA5WOuVvEs7MF+9
 x06g==
X-Gm-Message-State: AOJu0YyEdCwds88TvXmmvZofQxGuP96mjKyMCVedcB7/lwbvn/fXsHMe
 DmJw2zrY/ta2Dhb0JAAasYSdwm3K+/z9mcX1LW2h+dvGgNUjWA8lHAxhdngTyPDFk1jd1f4kT3s
 0qIRA
X-Gm-Gg: ASbGncsvplq0TUmxTcdKZowm/cXg6dRWxWLwPIDtzK9m8yjqB7AzegpWrMrL79T4iPt
 0R/6sShgd1LzBquXOjMWXtV0NyfslYfnHH7N75kHqxzD5r7fg8vHvaefQWri/w6tF7GJ3ncBl8f
 /nQvcMkAaVthJFWajZ+Bk60m8sX677aVMMLIG/qUXB25Zh8/p8vsCKoDEFkUabssUVT9ojl39Rb
 sbSvTRrmm3uXKAxtduXLeSxK+3mD9YF+dKYACceekf+gnuo8csC5c99fIIGX8oT44DUWz1D4Gg4
 TLvkkDYXul9F0qNi+KcSSqpjlUHPQBFNG/7rwO4wsFYDgkWzN4paEgikcB6+xsx1X8CHA/xrJ2X
 VLbKRjki2DSyV2cQZ6whm9g/APSJgd7gTiQWs5lfqaibUsNuYp07sDJC7I2GYxjeSHCqIEoQV
X-Google-Smtp-Source: AGHT+IG3sfTV4IbcD9Ksxo6piXphA39Ki/k2TYM5XFgb5f5CJZ6C8ABOpKRAYIuvatnNqdN7jtbmDw==
X-Received: by 2002:a05:622a:454:b0:4d5:c429:da9b with SMTP id
 d75a77b69052e-4da4dcc6beemr5670321cf.74.1758732933150; 
 Wed, 24 Sep 2025 09:55:33 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [RFC 2/6] eventdev: avoid use of pthread_cancel
Date: Wed, 24 Sep 2025 09:51:09 -0700
Message-ID: <20250924165527.268645-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924165527.268645-1-stephen@networkplumber.org>
References: <20250924165527.268645-1-stephen@networkplumber.org>
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

To control the rx event thread is simpler and safer to
just close the file descriptor rather than using pthread_cancel().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eventdev/rte_event_eth_rx_adapter.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 994f256322..95ceb35c5a 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -1173,9 +1173,11 @@ rxa_intr_thread(void *arg)
 	while (1) {
 		n = rte_epoll_wait(rx_adapter->epd, epoll_events,
 				RTE_EVENT_ETH_INTR_RING_SIZE, -1);
-		if (unlikely(n < 0))
-			RTE_EDEV_LOG_ERR("rte_epoll_wait returned error %d",
-					n);
+		if (unlikely(n < 0)) {
+			RTE_EDEV_LOG_ERR("rte_epoll_wait returned error %d", n);
+			break;
+		}
+
 		for (i = 0; i < n; i++) {
 			rxa_intr_ring_enqueue(rx_adapter,
 					epoll_events[i].epdata.data);
@@ -1643,10 +1645,12 @@ rxa_destroy_intr_thread(struct event_eth_rx_adapter *rx_adapter)
 {
 	int err;
 
-	err = pthread_cancel((pthread_t)rx_adapter->rx_intr_thread.opaque_id);
-	if (err)
-		RTE_EDEV_LOG_ERR("Can't cancel interrupt thread err = %d",
-				err);
+	/*
+	 * close the epoll fd used in the interrupt thread
+	 * this will unblock the rte_epoll_wait().
+	 */
+	close(rx_adapter->epd);
+	rx_adapter->epd = INIT_FD;
 
 	err = rte_thread_join(rx_adapter->rx_intr_thread, NULL);
 	if (err)
@@ -1671,9 +1675,6 @@ rxa_free_intr_resources(struct event_eth_rx_adapter *rx_adapter)
 	if (ret)
 		return ret;
 
-	close(rx_adapter->epd);
-	rx_adapter->epd = INIT_FD;
-
 	return ret;
 }
 
-- 
2.47.3

