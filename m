Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C05CA1010
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 21:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5283340EDF;
	Wed,  3 Sep 2025 23:28:55 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 2673640609
 for <dev@dpdk.org>; Wed,  3 Sep 2025 23:28:53 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7f7742e71c6so41430785a.1
 for <dev@dpdk.org>; Wed, 03 Sep 2025 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1756934932;
 x=1757539732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=VAtcyRZy0KBhg/BzWTDXwsYcwz1pWoNgx04P3USjmtPqdi2PnoIQWCN+O3M8RQY27I
 oUaXQeGRB6uDuVr5P5mtd2WuFajcGHd12DZ+nVxQ9AqiJ9RD8RPW8DfAIllmSDI65+T2
 iP85mOqfiehY4LjVqhz4yphD8fI2+Oj/y/TE1bpT2RvCJ59fKRvz8LO/awqESrc5IPA+
 WrCG0cYOtTwid0p3LPvGvOWCQJ9IkB5M+DAjruXH6t1XS8b5S4NMX7bYVM9WpCxuah8j
 csUs2T9k6eVIsf8zB7hnmBu1o8YFqFBhT+BLyzXUZM0HSq4zWZRcCHLKG/UkgoIqtl38
 LKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756934932; x=1757539732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=bhd3utxXnxE/84ArnRjyU+hqX2xqNWtpqdi/Zi70QmSd9zNGJBGZaz+b8e0riwCNW/
 BvIGPlG8alUOrRQxf12qpY5dIr5HYUx5tJ7vnvmzexYFjcWCurUKsMp0AwhJ+3kpgZ70
 q7ChzaFkl/IyscTB2AwC0ZYxui4DcJiJkve2OqJG5ZxE/GERwvF3eXuPwoh5sExvtdkJ
 P/sEe334aWRLk/ogjUeiSKMXabXIeNE3xI3NZ6cuFcfFzlpWBpHF56/w7iqsG3R9/WKZ
 6FSR0U75Pk4D9HZdy5pVbFmRamj41/av06s63OlVW1FDqE8i9oE1SwjtBXqz6VsygkwQ
 va5A==
X-Gm-Message-State: AOJu0YynVGqjQ56WOrrnH1siNGrURSgr1aoTFwSZizicOpfIa7ZIgSZZ
 ISg/4ZRY+iFznJykjl/bDfdwhtVe6npHViUyAMdSGdTVBgIi1wLH7mDGeuBmEN7fESk8UDUAaHD
 7gqA=
X-Gm-Gg: ASbGncuYclj8yRqmdYORNyA0a5/IUZ5W1gVw0wxA6kwcVNEt8CJhysYARakBOp2ZBlx
 I47zuFzUTs4+UorvNx6zXqqy/N+t5BBwNw6GMX8i6BsPumM8PbkquJ2puDG5Kd5oiqljFKiBO6N
 dJsUoqZ/vd2BpQow459IMWY6N17xfSYWE2KK3KkKFRN62Z2DV3ur2xx98LNE3cYdDTECfCB87/Y
 kcH8EYywYklhIEtsUVKa1n+qyM1uNQh+h5gnbD4PNAR0h2xUb5ujfzfRzS++UAp4sRdj5GBWg1I
 k8qIIPtQ0TA2dxVFLsZfppBJsoxrCBqRGtq3qhysHT+s23WvaffYVfzPl297M3FTS2g9Jgm9rfl
 VSFNbz1NCBleVH5Emo4dO9n3ac5QIRABh4v5SliaCidXuZ2yR0wR+PKrzXZ1XEWoJSQNdT9LJ/z
 vY/vWlwSFP9vdNeI9x7jg2kBniXk/d7g==
X-Google-Smtp-Source: AGHT+IHpL1rQBSdIy7Vc8N47e7hdKR+lFWAwwCWqnLfH14ASGFV9yYS8ILkPRBnYIjF5y4DUbmfSSw==
X-Received: by 2002:a05:620a:2587:b0:80e:6ada:db21 with SMTP id
 af79cd13be357-80e6adade6fmr58826385a.71.1756934932069; 
 Wed, 03 Sep 2025 14:28:52 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aaaa1d6f4sm175929385a.42.2025.09.03.14.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 14:28:51 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org
Cc: John Miller <john.miller@atomicrules.com>, stable@dpdk.org,
 Shepard Siegel <shepard.siegel@atomicrules.com>
Subject: [PATCH 2/4] net/ark: remove double mbuf frees
Date: Wed,  3 Sep 2025 17:28:43 -0400
Message-Id: <20250903212846.268492-2-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212846.268492-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
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

From: John Miller <john.miller@atomicrules.com>

Fixes: 8b154b690266 ("net/ark: add Rx initial version")
Cc: stable@dpdk.org

Signed-off-by: John Miller <john.miller@atomicrules.com>
---
 drivers/net/ark/ark_ethdev_rx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 80e431f1ae..6077d98ae0 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -538,7 +538,6 @@ void
 eth_ark_dev_rx_queue_release(void *vqueue)
 {
 	struct ark_rx_queue *queue;
-	uint32_t i;
 
 	queue = (struct ark_rx_queue *)vqueue;
 	if (queue == 0)
@@ -551,9 +550,6 @@ eth_ark_dev_rx_queue_release(void *vqueue)
 	/* Need to clear out mbufs here, dropping packets along the way */
 	eth_ark_rx_queue_drain(queue);
 
-	for (i = 0; i < queue->queue_size; ++i)
-		rte_pktmbuf_free(queue->reserve_q[i]);
-
 	rte_free(queue->reserve_q);
 	rte_free(queue->paddress_q);
 	rte_free(queue);
-- 
2.34.1

