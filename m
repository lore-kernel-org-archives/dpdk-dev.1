Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2483DC021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A35DF40615;
	Mon, 17 Feb 2025 19:58:01 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id F1FC0402D3
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:57:57 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220d132f16dso66161255ad.0
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818677;
 x=1740423477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofEEZSScqvsIoCR/saAoH1DxNdeCB1dkw8HHAvdWCtw=;
 b=ppE/nV8Tp5rjqrTSIYgriYe6/DFf4j1UUOwlwk67UO2YmcLzJtH66b1tTFi/eJqeIa
 6lvavui9kNUWJlEIPR+z0hZ6sPNCMCFkP+lIz9OwNBIpNxljnSVc6a/yyP1mpUaYVjyC
 6rF5F9SteP8uK9A7QjRhkLunO6THTpyw8DCQuTjsWij24TOXbbh8T+qAZ/6VNEoRiZqk
 OhzlN6ecAp5ch7oE42L72Td8zYJwO9cbsUn5tSjl0lUfq/LT6lUc3hgx99YzgsYf/EsM
 6Zx7ETUCyPxHlbSCzK9CJOR5WxiisTpK9krkM2XBcep7jcCC3iLMFwCDpxx0/YyY87n1
 1uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818677; x=1740423477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofEEZSScqvsIoCR/saAoH1DxNdeCB1dkw8HHAvdWCtw=;
 b=F9/oCuzlQIJaFnuK1xn+DoaILOeK9125SlpQzbEvikD6zPVp0o1Hbj9+KQWc+KCakz
 Ve5TCV6QUUFat640bqZZ7C4+9ntl0UufR6OhM3l+bsZvweYDAJaZyFXp17QnPSmfsRxm
 33HCe/Jr1196HiVfUIyaHcnaX3AQOi/5k0Cb9CFVPTp0wTTGOJCgOzfyfGnzP6nS/FQx
 yBYmk9qW/E6c05xD/rvL81ps652I+ajTyJFLpAt7fhdiyM7HPAeKhNup06+Y9ijlBDO8
 k+O3IlDH8m0imQx2opAzYsz9SjLwms6NGuMYmBITO1ZNsXHoQgYk7vpUmLNgJTQ4aOfF
 v5ww==
X-Gm-Message-State: AOJu0Yxsrat+AafUgv//cgqc7mpQdXbTn8nLmmMVKJzvo5lgD/F2IZxf
 04moXbnyKII8Nt4vKyY0JgzPasV7uikI5tAd4BWYSdN0+QxYvrCrpda1M238rNe3c4E0Ic5V/7W
 XAnM=
X-Gm-Gg: ASbGncuScrM5j8zkH3EouJYXEerEh0BZ0jc3ZDa1CXckSwVeZCeMyYkeRvrDVDo552+
 maCK63VymxedwEFpick4JuF5YGxymQ9Jv/sDZfDHGo9urGONI2uRfKg5JWX9yNcykKd2zxRI8+I
 QXCT/2PZu2NCk8CuwkfkI+7H4xUIQbeSjUKeHpv6uRgV/x+l9GGyBFOgvu4erxFXHLCb+2p7DGo
 OpcGtAtCkFBqnbKqft/aoZEDgp7rdNQtSgNF6cAF/sJd9o9s4F4m2YF/L//GRr056Z6H9RXaOyJ
 rxoqWldSP+HFW3tdB6aeSnDegulGTgZc4aONoN3jF2W+xIGcvGohjDW9cHlAXDK7k+Ow
X-Google-Smtp-Source: AGHT+IGZF29Rr9FWLKmnbl0+tRlecZusgF3T2EIWIbQOU1nl/e/P2FJvMRMuoEHsYJY6pVNO9Kalhw==
X-Received: by 2002:a05:6a00:4b04:b0:732:1d12:ded4 with SMTP id
 d2e1a72fcca58-732617a0f5cmr15326161b3a.7.1739818677045; 
 Mon, 17 Feb 2025 10:57:57 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 04/11] net/memif: remove unnecessary deref of function pointers
Date: Mon, 17 Feb 2025 10:54:03 -0800
Message-ID: <20250217185743.169778-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

Since queue release functions are local to driver, prefer those
over dereferencing the dev_ops table.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/rte_eth_memif.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index c0bf1e3bbf..f7b04c4f9e 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -70,6 +70,8 @@ static const struct rte_eth_link pmd_link = {
 
 static int memif_region_init_zc(const struct rte_memseg_list *msl,
 				const struct rte_memseg *ms, void *arg);
+static void memif_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+static void memif_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 const char *
 memif_version(void)
@@ -1418,9 +1420,9 @@ memif_dev_close(struct rte_eth_dev *dev)
 		memif_msg_enq_disconnect(pmd->cc, "Device closed", 0);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
-			(*dev->dev_ops->rx_queue_release)(dev, i);
+			memif_rx_queue_release(dev, i);
 		for (i = 0; i < dev->data->nb_tx_queues; i++)
-			(*dev->dev_ops->tx_queue_release)(dev, i);
+			memif_tx_queue_release(dev, i);
 
 		memif_socket_remove_device(dev);
 	}
-- 
2.47.2

