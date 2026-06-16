Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747BCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5542640DDA;
	Tue, 16 Jun 2026 11:43:14 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 3766940DC9
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:43:12 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so1887152f8f.3
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781602992; x=1782207792; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYwJG+F/i99oD03wigHiKABjErd9HTA+XGyMICpNmOw=;
 b=Vv5j5eoGGT/l1KZ9xmtCGkJb+sN5VJ0SlOsRenHMQTXBy82JBg7tg/8Vofl5hYiEfR
 o/LPlBR4GA5h40j7zenJOB1BrwVnrvAIjUdMx8NMlWryImEVjIBUeAfQI2qywO2xtc5K
 wYgL+1SPSfVY3obPNYYQpfRyEdd/jINsW8IL5PfHjW+myKWnecf911EUN2N49qDjb6vi
 Mh9RkyE21He9pbJv5+wrMJhKGkin+EDK444KRD0izQOFRYIvfX4ITbAju02C6pwdxXfP
 /NXgQwjCoBhhvdpKihLzLVf+ieeyl6PwxRZRfkYv4Zm16/RJkMXJ38PBPjZwJph1GoLz
 wv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602992; x=1782207792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYwJG+F/i99oD03wigHiKABjErd9HTA+XGyMICpNmOw=;
 b=F9BlF/xSLWQAqCsuxPYkfWEAGEMNvv9C1jLzp8J70Jglvxh0zfCt5Zrgar082ZjYZa
 kf2MAExYoyMO1qulKT12NvFLLwjNsWCkT7YmBp3+Qfz5hWCm8y4v61mxjDZFTFtv/0+K
 lJMUs3JDbiDs3Qy8o9snd3UcbeaB3FkvD+Yhsyos+ai3T7/y+0GlyCn0eykRAzp2ATyH
 0Y3EBHTW/9b3m4aSvQCDTBTFvMzr7zAwIcxplC5STTzfnmaEKYKfMUFr1ATh2L3wd4Av
 /R91z4sy3B1eK9gGPnxVXjWiECR0uBcv/iO2G5jvUVBg1WebMqSTAwcIuDbfZ0qFcVtT
 ZF7A==
X-Gm-Message-State: AOJu0YyNBfJ63EFm3umw2lWnu6nNf3RGCXyCYgMapQl3oZLpmBWRMFBS
 6JyuWwzgks4cYPhz3Jt0Q/CK8vfT8szliH2OvmVlv7WVprRaffbAgUc0qr8A3Gv5
X-Gm-Gg: Acq92OEw6iO3n3H5gU7ZORazuetnaQHIuIvh6OYvjFvcGTGHU9fEC7Y+9dN8+o6Fkfn
 lVehUiebwUCS22z3F0A73JwLQPA0iroMQWK1kRGFvrVYfjYoCGAlVTxz7ZusSCYGkXTV7hVuRfi
 CPYbbsMcxXUvnPF3LMP2jGo3W2Bfw53fJG8+WV/b9m4+RkkOycdbd9hzZpzkZ/0Xkq/D711ZYii
 IUcoLTny6BLmVte4BrwJP7JrIyXetvYenxL7xMXdGKiCcJS3PyVpf/QnubJTRhTp+5ldcOG/v3z
 Yl3o+VY+4mGAXMOQugAtzp+qY3zfDFgcSRIQLOrtRtcK/5bdHOfmNFmXB9dcQ+9z6Aa+OTg1EVU
 sYFCtcOWSGJzMikCBQ7TQbmHZnrEXnEcGPQQXqz2/mV/VIwwwPWAo0jCFFHoWfKeObqeGdVVg7t
 egA+uXJ35/JQIT5r091b2nmoap0MuO/RMiOYvwKBstoc8camq40y3VWrsinfY2YmE=
X-Received: by 2002:a05:600c:6749:b0:490:3f7a:108b with SMTP id
 5b1f17b1804b1-4922ffa2367mr41517345e9.16.1781602991494; 
 Tue, 16 Jun 2026 02:43:11 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96b47sm39396145e9.13.2026.06.16.02.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:43:10 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Sunil Kumar Kori <skori@marvell.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 2/2] ethdev: return 0 from dummy queue count
Date: Tue, 16 Jun 2026 11:42:58 +0200
Message-ID: <20260616094259.686555-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616094259.686555-1-maxime@leroys.fr>
References: <20260616094259.686555-1-maxime@leroys.fr>
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

The dummy rx_queue_count/tx_queue_count callback returned -ENOTSUP. On a
port that is not started (freshly allocated, or stopped once the fast-path
ops are reset to dummies) there are no packets queued, so the truthful
answer is 0, not an error: querying the count is not an unsupported
operation. This also matches the dummy Rx/Tx burst, which reports 0
packets.

A poll-mode worker checking rte_eth_rx_queue_count() across a concurrent
port stop then sees an empty queue instead of a negative error.

Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
Cc: stable@dpdk.org

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/ethdev/ethdev_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 70ddce5bfc..eab5c15d12 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -875,7 +875,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_queue_count_dummy)
 int
 rte_eth_queue_count_dummy(void *queue __rte_unused)
 {
-	return -ENOTSUP;
+	return 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_descriptor_status_dummy)
-- 
2.43.0

