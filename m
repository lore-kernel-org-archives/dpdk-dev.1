Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C75C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2EDE4064A;
	Mon, 27 Jul 2026 15:54:21 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 903B840647
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:54:20 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8eeb4508f29so24612596d6.0
 for <dev@dpdk.org>; Mon, 27 Jul 2026 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160460; x=1785765260; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e8KzzfUq2jURnopwDPeozM7RbT9G7jKH0jp6IQxPJVk=;
 b=qKDdDaL0rnP1ZYnGNm/dwww+OCveHJXz3nuT75EM87LMGK6xiSkcRXTqDzWdaN+BGb
 dsA1WG9BQ1X/WvQQHSfC8mCyVAUGZA8E21YKhoxX2eVI1iBpYyOGcBl/ylnYEcAaSqGK
 6UNcpMAHoIdDc73HWj+BRRcGG/2Zbwf3tlgViIWj7tUyhtdgsJ3jvb95+SmP8QPVi9pz
 bVvaB9aI67yuu9Q66Clh+waqjNdMgAOxAyHxchPvFuGoN5Y6LELnQfJuat9INhKSnudW
 VrMcPCxjcXesWsEzytp94EJiJmFAJfjYSRmmJwwKVqLugTX1G5323nhYUm4OwuGppaOV
 +mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160460; x=1785765260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e8KzzfUq2jURnopwDPeozM7RbT9G7jKH0jp6IQxPJVk=;
 b=jR7Xq88fHsCC6nCni47PxGoWzWyQXzG533+7PAKRiXiy37HIOpqrmyuaSfNwEXZHCn
 VAIamW/ukMfTfIvNbbENXsS3vqtk42AKLIu3RxyFfkyt/7xr02WkSbP2poKdeIWoOkQv
 khNToaND61kcu3en6LbRdHCV3QUQYOTfBF4H1Fm6OtpnumHlaXiuRsKhwlWVO/uRa6Un
 xcE6uB+HAsA5jAmUIf1hMeIzlGZVyH4KU00lir9uh4pA8KaWBDJXaHLqeHN8OJwcMRsl
 uGun9S4RgKwebsBAaTHRcQ9cvW4asjPA5CpeLBuoSKZydWi9dbKrla6iB9Gi5bdDDiym
 F6pw==
X-Gm-Message-State: AOJu0Yxm6nxn0ON5TH+bahv10TUfmWBQ21TeUrDL4Gau3Icr5tMqn4m4
 xtcQKeRpFwF29kdRi0p//uZVQWUmk0rMr9LHiXzmISngibt9EZgCMEey
X-Gm-Gg: AR+sD11p9DtphBfVqXNFJNcxIHo2Umlosj9IXpfki6bMeWFd46RvJyH1glG3ANkD1Pk
 FJl8zznpHgweEaJC8QAllT2/8H2SjmOMKMQDpKoodcaIhTDUJAMChFFWfjdN1LWS3pnfH1AyX55
 z8i0lHHAkd/9JLLpr4VNcUrtfIbclsTux4WxTi696X51E9d/4jBsn4RITahxlcwss9RN8ujTrR4
 F9dZMBZzLkemJYVIkBeaDsqQCcuKAgmMAnfBF6d/gibqIB6t/bLVBkr7AhrKQIo8ExyB4ekICZu
 zl++EKNeZPtjxgFU9UyjcWr2ZW8ts3iQrW8wJwFmiEBuEEC6AQ8X9loMPURGfJ06l/Bb9EylrOm
 PFH0Kq5TDcwwtmID0vBNVCtu2Md1zAkbb7pOJhZg7K0IZP6gCe3UNrTD/1cKYKSYAFMKLK2j37F
 nklOVU8dtcJrmHxYLcbYaWS4fp1IbqGbw=
X-Received: by 2002:a05:6214:33ca:b0:8e9:f5de:d5be with SMTP id
 6a1803df08f44-907ec850b57mr98287926d6.53.1785160459933; 
 Mon, 27 Jul 2026 06:54:19 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e858c4c1sm65706886d6.22.2026.07.27.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:54:19 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, ferruh.yigit@amd.com, Maxime Leroy <maxime@leroys.fr>,
 stable@dpdk.org
Subject: [PATCH v3 1/4] net/tap: fix crash on Tx queue release after
 reconfigure
Date: Mon, 27 Jul 2026 15:54:07 +0200
Message-ID: <20260727135411.2590931-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727135411.2590931-1-maxime@leroys.fr>
References: <20260727135411.2590931-1-maxime@leroys.fr>
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

tap_tx_queue_release() reads dev->data->rx_queues[qid] to find out whether
the queue file descriptor is still shared with the Rx side. When ethdev
tears both queue arrays down it releases the Rx queues first and frees
dev->data->rx_queues, so the Tx release dereferences a NULL array and the
process crashes.

Both ethdev call sites do that: the reset_queues error path of
rte_eth_dev_configure(), reached whenever the driver rejects a
reconfigure, and rte_eth_dev_internal_reset(), which bonding calls
unconditionally when a member port is removed.

Treat a freed Rx array like an already released Rx queue and close the
file descriptor. tap_rx_queue_release() reads dev->data->tx_queues the
same way; that array is always still allocated when it runs, but guard it
too so both paths stay symmetric.

Fixes: 72ab1dc1598e ("net/tap: do not duplicate file descriptors")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/tap/rte_eth_tap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index b93452f168..eec18a7c97 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1170,7 +1170,7 @@ tap_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 	tap_rxq_pool_free(rxq->pool);
 
-	if (dev->data->tx_queues[qid] == NULL)
+	if (dev->data->tx_queues == NULL || dev->data->tx_queues[qid] == NULL)
 		tap_queue_close(process_private, qid);
 
 	rte_free(rxq);
@@ -1187,7 +1187,7 @@ tap_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 		return;
 
 	process_private = rte_eth_devices[txq->out_port].process_private;
-	if (dev->data->rx_queues[qid] == NULL)
+	if (dev->data->rx_queues == NULL || dev->data->rx_queues[qid] == NULL)
 		tap_queue_close(process_private, qid);
 
 	rte_free(txq);
-- 
2.43.0

