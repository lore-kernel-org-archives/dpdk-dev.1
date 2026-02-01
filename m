Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3398EE6529D
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F3FF40609;
	Sun,  1 Feb 2026 18:19:57 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 2D2A5402A2
 for <dev@dpdk.org>; Sun,  1 Feb 2026 18:19:46 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so49183125e9.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769966386;
 x=1770571186; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dShM9mz1LDLr7WNu/7z1v37nf4QY4MJXKxbCTRaTits=;
 b=B5HaRwN4OU4pUFjWeG9BcWnWA9bltVe6tQkAdUQtnhGwZgQY7xfgVG6QpRAiz9i/1G
 HJG/AoYIHiqVGDVQ4ENmI2X0OJ459zg5VOkr3LzdyS4shIj4W0L7iiPDi56LPQU3FSGb
 GggWfzm17lScHkfG5I/VoiB6jACVS9EXVI3DFvDgMZnDzYqMSCT+y/Yf9T30xWFeXoyW
 8XFd/jSN18f5PkgpTTHxYcJXGDYKy8a9yjSfun5ppR+3LCuhitWD42c1e2DWcHGrPQFC
 t7617wXw2EghqUBTdmD4Havy0YZJGqKyJ0q+CiYK92GzC+BymYtQ0cXJTntrMeG1pAK4
 Y2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769966386; x=1770571186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dShM9mz1LDLr7WNu/7z1v37nf4QY4MJXKxbCTRaTits=;
 b=eQt7RZMtv/nA5yxEEPAAMYS101OIen4YCoSSFLt8YuqNPKcUNYMtXdVJh6QI8ie5dm
 nTG4CdkkvRjwYlMEQpiZRSQD4F5PlZSIXbR8TFGgtGNjx/ejtjL2K1/G4zy5pRBmKiB0
 PsG6rv85HL7G1CgupQntl8AwTXGVxtlohJxu8CJUTN/4HiHnsPl6n7Kuzf/xTKLZrnFs
 NDE8bJ2iqJQO/NWeBn5TCweR6tprd5/hvW5ftqktYP2FLIlKinIpyF5UsrIn8A0sFvpt
 ktKIpl6NxU/IfekgdfdVqoM6uuk2l0kuauWSJPLcwIPgpd/m3WEFf3JmnBiIjPhWz2Cl
 tiZQ==
X-Gm-Message-State: AOJu0Yx7WiVL+3jE+B7w2NjqoonapAwIWlVAZLCu0Q1EW/GsXYugy+Nv
 x9TaAvRtNfkqXDY93LcQEmZ1Yly/ymfs9drvC8NHvfI/6DGSdBNGQ9gTNwhVUUvxb8vXv9/A/HQ
 dXP37
X-Gm-Gg: AZuq6aI1vBa+9S1xz4t1RiyTijE5MIELFgI/f9aXZbv9YvmaHskA3uDfMuK4Ft2fYSG
 6ds4mjAys3SBoTHv7T1kpfE8qgaGAM0sYVdZEgvxNNuu+zGUAS23T2WFjkBBx39wmEQGZZWg9nI
 sIQNELxb5ZkJ3/qwhWFNkY1h0u7oUbGUVkYRn+3+J8I5kfgLNvw6BTCDgANFObU+0JHQl7viW9D
 wmVQqZph88KgnWf1dxzh0i+WDztzKCuZRzW7FUe/AwriEdaCAcMvRpk8iis7Y4T5fn1GtfHFb5v
 R74N8jh8uQl0M3R+yUIiPmPSS/ICiBtw05K7pqN/9WvKuTJrjirRnhq1MwwE44ePtshrDN9CYsM
 0oGOZz3hp2XIV1KQiMiHaAtvaiHozeHGcq61ucqrLhtI2qw7haY8W9ObCb9RK0XqVmb6VmmPnJd
 CbrwduL7UvTiDYUP5qECLZFxSCzVCBl2M+Nvbf95sEr/cmgMnAiw==
X-Received: by 2002:a05:600c:4443:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-482db4a0fb8mr130467835e9.30.1769966385723; 
 Sun, 01 Feb 2026 09:19:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm346810765e9.2.2026.02.01.09.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 09:19:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v10 1/6] net/null: fix missing mbuf leakage in the copy
 transmit
Date: Sun,  1 Feb 2026 09:17:32 -0800
Message-ID: <20260201171938.89492-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201171938.89492-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260201171938.89492-1-stephen@networkplumber.org>
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

The transmit variant that copies the data into the dummy packet
is missing calling free. Looks like a regression got introduced
when optimizing the transmit logic to do bulk free.

Fixes: 9946ba548bf8 ("net/null: optimize Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..0931dac12e 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -172,6 +172,7 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
 		bytes += m->pkt_len;
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_bufs);
 
 	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_relaxed);
 	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_relaxed);
-- 
2.51.0

