Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D79CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:16:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87AC84067C;
	Thu, 28 Aug 2025 01:15:51 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 0E23840677
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:15:50 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45b618b7d33so2840625e9.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336550;
 x=1756941350; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2x9Hp4nP4Vjmcp5PGEqE5eIrxFcOiG2wTfQKBjWQ1GY=;
 b=SnYtcITYLmEztyVDffw8ygHxERUJStktJv0wkc89rxpsU/OU9BZFf1dFNk3SLD5R1L
 F9FvEQOrPP90sMl6qBIjcmBhBkZE2Gxor7h3p1NfOXL7k51orTjTv/mcXtpCEP3e3yS+
 l3GB6ZhP7q0Thndq0omohg6FCGMTjTSdJlvdle5rxvGiDZloRBZhVHIlXQ13MAO9vCsG
 9+CDJfSgoM5EOH3Ir/JeEvISAT+R33vX98HZsx947LlNxaFPdm1qOrL5I9045N7mQB0I
 R/yJxR31TH1+Z3Zuuj8LXWw88J2Ve/conLLpAM+K+gF6E29VfeXZCOaKOpYwYlCrfar9
 QnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336550; x=1756941350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2x9Hp4nP4Vjmcp5PGEqE5eIrxFcOiG2wTfQKBjWQ1GY=;
 b=M3gxeGvQbUqJg61Mw4u2su6nwUpdcB66dn7lVI/imflYvdrE/9XotU+Q/RfjiMtBCz
 632GEabBo/bLXfjqyz63oB+0JAa6X1E+M3pQyUCpmFcwpzLU7l936gEZfcFZSnzULLJD
 7Jw5VERMqmS9HA9FItbrxK1Wii5Cx0g+IuaYdtKiAPVP2AG4TCSVW5dwNaZXMsAIjWqC
 +BClO2O3YD6JqeOOtVkTDJNa4UUPCdM4SYtEFVeiyPrqhhaiiUfKn2N+KdJ6ZZ5CtR6U
 h0dkioRiG5vsrPOeDORJdFXA8s6sPEVcZjB9oS58NjliZpQQmlBX7V+zWmi0Msv5gwKn
 ZjbA==
X-Gm-Message-State: AOJu0YxsKaOpiETmvXo71BwAeGjucD6VT1PZvUZuDh6F0MOThjA4vQ+0
 3JKpFpkcClUaaNH0s2yGDDdT4skzSIUG1oYdHooKMTiyvZGqh1ugU6mfA+d4Fr1TupU0IY5XNxc
 KgTxq
X-Gm-Gg: ASbGncsHVJg9MINA/cGiRGk9Lu9XPNUBDybqLTYODEgahvQspUtMohWA9wTlHG7Cgqt
 luwowVhY4iM36tMUXXIn4eajje5lHXRmoOR9siOuUDNmdAxGroKYZwXGVQxyBYbgfbDOyJqT6Q8
 UuO9JSkwM57Pm7JbuZv0YFzeBhCeSjCi8FRrdadiDfQLZJOj08Hg5QWTcGHf/JuS7QgCl3QFzQR
 mTzZaqgQ6E77asWWz/Ajqe7jIS3KO2cGkk3k7Z3jAfIKemV+82ihWGxgT7P+j1xSO7DcQ51E52R
 XdGhAusg466soHdujF48ScIg0QMjqW+cmUTHXXgDCfK1QMyGBI3KD8IpI9iPKytzeO+YEzZd9aq
 r5Mwt1tV7xikQDLEydJCOvkd5VJYyMY4Wqo4lIfdeHj9TiIwjNU4gXvs3BUmqn559faoHKa46p/
 7jJkLMC6E=
X-Google-Smtp-Source: AGHT+IE9mTeX4BdYPp4R8dn3EJDDk9kFwAsaL9334h+18XaUPfN0rxRZBh+aBYVSw8QE7QfDzCxrBg==
X-Received: by 2002:a05:600c:1d0a:b0:456:1204:e7e6 with SMTP id
 5b1f17b1804b1-45b517a0c10mr179423075e9.11.1756336549656; 
 Wed, 27 Aug 2025 16:15:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba046sm24254652f8f.1.2025.08.27.16.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:15:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 6/8] ethdev: avoid shadowed variable warnings
Date: Wed, 27 Aug 2025 16:14:09 -0700
Message-ID: <20250827231528.236172-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827231528.236172-1-stephen@networkplumber.org>
References: <20250827231528.236172-1-stephen@networkplumber.org>
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

With shadow warnings enabled there were a couple of cases
to fix. One was simple reuse of 'ret', other was overlap
between type and variable name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c | 2 +-
 lib/ethdev/ethdev_driver.h | 6 +++---
 lib/ethdev/rte_ethdev.c    | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index ec0c1e1176..11ffaa2219 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -295,7 +295,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_create)
 int
 rte_eth_dev_create(struct rte_device *device, const char *name,
 	size_t priv_data_size,
-	ethdev_bus_specific_init ethdev_bus_specific_init,
+	ethdev_bus_specific_init_t ethdev_bus_specific_init,
 	void *bus_init_params,
 	ethdev_init_t ethdev_init, void *init_params)
 {
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..4c2f2e3489 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1998,8 +1998,8 @@ rte_eth_devargs_parse(const char *devargs, struct rte_eth_devargs *eth_devargs,
 
 
 typedef int (*ethdev_init_t)(struct rte_eth_dev *ethdev, void *init_params);
-typedef int (*ethdev_bus_specific_init)(struct rte_eth_dev *ethdev,
-	void *bus_specific_init_params);
+typedef int (*ethdev_bus_specific_init_t)(struct rte_eth_dev *ethdev,
+					  void *bus_specific_init_params);
 
 /**
  * PMD helper function for the creation of a new ethdev ports.
@@ -2026,7 +2026,7 @@ __rte_internal
 int
 rte_eth_dev_create(struct rte_device *device, const char *name,
 	size_t priv_data_size,
-	ethdev_bus_specific_init bus_specific_init, void *bus_init_params,
+	ethdev_bus_specific_init_t bus_specific_init, void *bus_init_params,
 	ethdev_init_t ethdev_init, void *init_params);
 
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..9934e48415 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2468,7 +2468,6 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	if (local_conf.offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO) {
 		uint32_t overhead_len;
 		uint32_t max_rx_pktlen;
-		int ret;
 
 		overhead_len = eth_dev_get_overhead_len(dev_info.max_rx_pktlen,
 				dev_info.max_mtu);
-- 
2.47.2

