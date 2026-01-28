Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F31D46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD2B7406B8;
	Wed, 28 Jan 2026 20:01:49 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 4D4EC40673
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:01:41 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-432d2670932so180940f8f.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769626901;
 x=1770231701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDDS0HkuzOzBl/TXkSHWbLnO+E/BHqYirw0R2QAbNmY=;
 b=zNl67wCO3o3N+h3aRoDjGtbGCh20Z4AQvcVosliNpmRsutBryfIwrVPEY8SqlWcVl9
 wGbfkU8uZQ0sTSwhKRMe91Ephn7oQFi5eiOycK1bkEqV6IDqDIsMUQpWsSaUeUDFVrXt
 KVd4u3RYbmxFRxVr+IF67dQV7dz9jCMN17Yan2SS7Dta2OJSEDJHXzBEGKX6+l7vYHZ0
 j+gBY9aAl/zE7imAazfU+XquoTTtwQsji9a0BjpuZLPIrulPcuK8/6mKTQyNM29oo9Dy
 PdUQKc3uHvau+Vhfz8nPzXhey3hUDp3GyLNCRwKh5S/BJLMjF0IFwwhpno1zYu1f++xd
 avKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769626901; x=1770231701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MDDS0HkuzOzBl/TXkSHWbLnO+E/BHqYirw0R2QAbNmY=;
 b=xDC9HQoHZReqVVV5UJ3M0hqruSOmW4QNHoXmSPCrKCMcklhLhJQMYIHzx9keFF2ZcU
 VasFm2x6SvsMW+7kwfx3xDDQu2FBiQbPTWjwCeU/dXdcbkOzMaA3TajbsYcR64EuHBZB
 dPtiZVnt48y73EhjvJPu3dYiIO66bpq5lgTJ/CuhI7OHH6EpgvMCKX5ACPv8aAXE8Y4u
 +TjCOvFJXor4Di1lscwSmryCL8zo3lnoXR+RWKfxq0Z8JWS/KwIi5qOJbZ6InZ9Fipbx
 rBSXainYIOGSMfzd2aB3Yb1OEFOThQlYUyOHjIjNXTEw4XKyVW+4iLpOiSfDogZNrizN
 eEWw==
X-Gm-Message-State: AOJu0YwBOE3iJ1B5Vu5oA88IYxJJc2PbEEk33ZV7GYhBvPvHkpyVUO/U
 f3EPYYhcCcb+xp1OZAhYbjB9LKya6GLHb0Nf8Z8xeBJAERvsDk78uh1HEqs/c3EFrzn6zpvkMam
 uE/RN
X-Gm-Gg: AZuq6aJ3goruB5hTxHPzwA/5Ng6t9ygf++zzpL7PGv5x8lLwGZhYZ+eImf89uo2Ywrh
 KLZcYCFkKaaJFoxHZm0G2NsctS60rj4P5cIiuJKDUUbMB+SD9uiy6WSjBCQl7LM1laAA0i+Nepo
 K9gzurDM4mXldAa0djFfPZSV5yHp/dzWUfAQBh4IIPxbRWUeEnBHG1wFCroeAejRFxlL7Y/fTj1
 G7XvqDRj34/rJUyaad+snemFpq73XNBr/eHjAs8ZC3oV+BROsvlL8fyk6rXvEgYHK3IF4ckQszy
 QfOKlJeiwcgjNIeFTrrPbLbZzs0NuUKonzMl4NYShMKfA0zVIhfn7qIE6rVApA+yw3AoEijrrV8
 U4bNryBTk0zjnfLm1347naOzcZE6Y+G/5LXE0wzNHxsF62iI4jXfFe5qu9mle5ex3n4gDte8RtF
 CeAH1hdVM9w4rrU8GuqDL35BbmG/fQu8QNmP7bZ2QIx2RpKST6HA==
X-Received: by 2002:a05:6000:18a4:b0:435:a9ad:d20f with SMTP id
 ffacd0b85a97d-435dd030475mr9549030f8f.19.1769626900803; 
 Wed, 28 Jan 2026 11:01:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm8673333f8f.3.2026.01.28.11.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:01:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH v8 4/5] net/null: add check for pool vs packet size
Date: Wed, 28 Jan 2026 11:00:12 -0800
Message-ID: <20260128190127.465743-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128190127.465743-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260128190127.465743-1-stephen@networkplumber.org>
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

The mbuf pool passed when setting up queue must have space
in the mbuf to hold the requested packet size; otherwise the
code in eth_null_copy_rx() would generate invalid mbuf.

Fixes: c743e50c475f ("null: new poll mode driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 4496c093a7..4b4d996686 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -241,6 +241,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 
 	packet_size = internals->packet_size;
 
+	if (rte_pktmbuf_data_room_size(mb_pool) < packet_size)
+		return -ENOSPC;
+
 	internals->rx_null_queues[rx_queue_id].mb_pool = mb_pool;
 	dev->data->rx_queues[rx_queue_id] =
 		&internals->rx_null_queues[rx_queue_id];
-- 
2.51.0

