Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD291CAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 15:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8337040697;
	Mon, 15 Sep 2025 17:02:25 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6126140671
 for <dev@dpdk.org>; Mon, 15 Sep 2025 17:02:24 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-43b40cc73f3so2621781b6e.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atomicrules-com.20230601.gappssmtp.com; s=20230601; t=1757948543;
 x=1758553343; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=FxV0kAjXA5YzB4xP2SwAb3S95skbeQ/TBmka1aaYIGpi+u8XY7MbI+2V/1Vrby93PG
 ZYF+ptkR/8xSUVarMWaV1ypSl6QlHPEUdZdgM0gr68lb9eQ5qhgX9ei6r7L+Hv9a27io
 38eZ2o2hDbfLShNexOUhLdHNms12ghJqLQAX8cSlqzE/efjuElDjdYdQSfJuiPfxXQhd
 0DFh2KdlGOi4E96m6UhouFToKktrGTpYJ5knPwU8ju49ilRCPh9w7xwH/Va/weKFo90A
 hz2cRWetgwrRQjQHiCI7LGcZKtsuObpWvW6lz9ODLTYNL2S4J1fnQS/loPZ1i9tDjPVE
 LdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757948543; x=1758553343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5CLORycxzUzZGXTs+kr7fOTjhEEdeMYtMIL+2jLHH8=;
 b=Mh9CCn8gRiQeZY/IuxOO3UktvJDnz27uOwDDshlKOHjBkuR2Kqtnyj6vL8A5KWsoMr
 obbewBi/f4TdMapZqwjbj5+sCvPTFOtrYSZ8yMVvGtndzKSLAgX1rBlQC9oSW+V45OYm
 QL+CWBme1EN+YrCaDub9YkpVwMAmsihysIUaxw5H0iMBrP9Id93ohCqCeujIdhb01rX3
 iCyDslzdOU3BozkGrFEkNTP4zPdljgAxEirB8au76zKaiHg7FbxGiiueFPITNKdogVfr
 1TV/Jlep3m9ZjGtjXkeki64OrnoUZBgZIxeT7Ga97pJN2/4OjhgkJEj1IM1VCUeUBH63
 Yjjw==
X-Gm-Message-State: AOJu0YyDa/EH8RtnHZV9q+ucS7BIKArwUss1VcMhyIcUXUL+Y0GiUOxQ
 Cd3meCohXjUHrH/E7vQlweOd/wlYWXG0nlwYxFRDt1ePBvmisKOuMV77OLzV/MjphAsz9CncvHv
 ARfY=
X-Gm-Gg: ASbGncsyJ4buTLAzdcvqhxc47zd6vR2Gj8OWKx3Yz6A26GAYxdPTZz+0i1sHeWILdgF
 kZO35f8Xpws47UCYNlyWReSJhwegsmUR6eeStQZEIRuWh4tCoL/nKILRZbFju3YjGl5HT3TaBic
 o3gKTrkzxbC8VhGp+JCD63Avmfkmy1EPdghK/5tCHSkLl0wrB4J+mIQPbh+i+VgqWJUXsY2BANQ
 RtkFssO4DWs2aDkqIDhgB0VrR1v4zV9ICYuZpH9AvTQkewUR7NmfO41S2PXGguuMstoJmHhVRF4
 7Z9HEH9p8+MBNvT6m3n65v0g1fbgWAuqr2xvD2ExHTPOVKzlGNWMR2NyGmp2ap8xoHSSZjE7ndv
 toklTkrz784umUJR6kbJMsM6564twRb8oCPvTQtKYnh9KF0FcJRGtWdU4RkLyButajbEdBNwBXi
 mPbEMh/iQfrZPV7do6h1M=
X-Google-Smtp-Source: AGHT+IHCUwByVHuFrokRj6iPAIg8CBP3qgY6bAnkvnCJ4DwH7WSL1cC7FQWfegOUE6ulOZSL16r8/w==
X-Received: by 2002:a05:6808:4e04:b0:43d:1f49:7a9a with SMTP id
 5614622812f47-43d1f49a344mr2762777b6e.9.1757948542401; 
 Mon, 15 Sep 2025 08:02:22 -0700 (PDT)
Received: from z690.czeck.local (pool-108-20-194-239.bstnma.fios.verizon.net.
 [108.20.194.239]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-783edc88db3sm18930486d6.66.2025.09.15.08.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:02:21 -0700 (PDT)
From: Ed Czeck <ed.czeck@atomicrules.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: John Miller <john.miller@atomicrules.com>, stable@dpdk.org,
 Shepard Siegel <shepard.siegel@atomicrules.com>
Subject: [PATCH v3 2/4] net/ark: remove double mbuf frees
Date: Mon, 15 Sep 2025 11:02:02 -0400
Message-Id: <20250915150204.1719628-2-ed.czeck@atomicrules.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915150204.1719628-1-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250915150204.1719628-1-ed.czeck@atomicrules.com>
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

