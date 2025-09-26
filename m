Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C22CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0BD040A67;
	Fri, 26 Sep 2025 18:25:49 +0200 (CEST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 0C32840A81
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:25:46 +0200 (CEST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-634bc2d6137so1504842a12.0
 for <dev@dpdk.org>; Fri, 26 Sep 2025 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758903945;
 x=1759508745; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuB8uRELX91FFQaQ6WLcMGfxFHM8EuiAgKAJMQwkT4A=;
 b=luMrlKgwdWer9FxA5d0Y7cnQAQE5fMdQA8vf6nDRQi76KO1EFluxtOuCZZvvXfg5xT
 VjRmhi2z+ig27TW0MnDsbRYzXDJZs3Z2aE28phsxBH8jhMPoFy9LqOCGV6w7Oj5zBKgj
 OZGkNMcaUoAzzTZRFW5SqbAqcjTbPZRvyQD86LXuizJfgIc5YoCMRulFNATnc4CrDbAu
 p3VNQPfvRqPoe+WBxvSyWuEp2eie9fpuNyi5NMHTs9hRwizWvuo34hbeyWNChtj7WRyU
 8dvj/57b09N1GIq/e842trgqPgV6uiYgISDtWBxaRqHLTRDZVnOchgDAs9HnBSgR6Xqi
 3gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758903945; x=1759508745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OuB8uRELX91FFQaQ6WLcMGfxFHM8EuiAgKAJMQwkT4A=;
 b=X9mw/ATKsaIW2Ck5Sz7tisjhhKwr35uGHM10+KNRORBOegwhxRt/Pl1/r67q08Rog4
 VbqJ8cPCDWnGWaFIWd6ooSAvBLNHUNnFjVIo95kYuQ8WNoLRDQG8WPIsh6djBjjP3lUA
 kP8t0vrtjH/u9wpNAdes8vFxx9jp8ZhuW3MsmSYoRWp5QIG0f6b8zUOyLgBpLcB/PiGO
 WYMdSHPVQNbxPuF6oArWv9PwCgFGdUfMOnVa+QiYOG/QDtENAfdsS9c6IdP3EyTGEsdu
 XrtXvkunhCRciNxZQ5rwbA7BfktaOcfUKY5DPWgD6Hv4ZMsNZLtY0tQdU6jLTJpaS9Cp
 I/Yw==
X-Gm-Message-State: AOJu0YyGACKslOVe8Da1lSU2LcvEzt35W2pDO2ksL4glQpDDAxx96ewV
 /l7Cot/hfkqpI6wEOuqe4H1EVZZz/Awzn2Hr+AKBRZ/Gw9tzpgg4NbVM5g0/0OgLPtd2g/z1b/D
 m19LiALs=
X-Gm-Gg: ASbGncuztJ1jEe29Zv3IewB2Y5QSCZhxd/ASQqSWUQy/RnJ4ttfYAp75lt6zB3TghX9
 ZHblrAsE3tG9oA9SJf4C4VHk9l3fh0SOqKQTc4J9mtg9mSJ5Hwqk/sLAKh5VG9KlE9gJgat8vk6
 3qs/Dg1qS9/bYBya+IA9otsRA+4hXFw7h8SSMQFRSPkFz41Cu+tq7xy/rVhzMAp3uoGtA6ueI/4
 4xkwZ9mwwH0R4+kPVTN2f9vEJE6TUsbLrZ7ztHF4myUfkW3xmBLMOGG4AAbnraMvpnsIrs+kIJO
 O8JZjYU3q+Xf17g8v1spHZmeNqfqQmniw70Zhj2MPYzgefcwcmm2YLAJ22ykGXiibYbv+ZWVfd0
 ZG7Z0WiYYdn9OLlYqFDXs2HgFa4B0K1MQjz9CP+tVDqxY8r78QC03L062bF20pvahTDKHtyMnqM
 0S9Bdote8=
X-Google-Smtp-Source: AGHT+IHHV9RrBgSqrC/dB0Jgr6kz+2wOgFwtlbzGRzEi+9WeEfHOn9QGUsG8+rXBZFNcAAbfDdeHHw==
X-Received: by 2002:a17:907:bd90:b0:b37:186e:8f95 with SMTP id
 a640c23a62f3a-b37187dd397mr569075866b.57.1758903945429; 
 Fri, 26 Sep 2025 09:25:45 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353efa406asm386638866b.23.2025.09.26.09.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:25:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [RFC 3/3] net/ntnic: make flow_lock local
Date: Fri, 26 Sep 2025 09:24:48 -0700
Message-ID: <20250926162534.401577-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926162534.401577-1-stephen@networkplumber.org>
References: <20250926162534.401577-1-stephen@networkplumber.org>
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

The variable flow_lock is only used in one file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/include/create_elements.h   | 2 --
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/include/create_elements.h b/drivers/net/ntnic/include/create_elements.h
index 7593ab4687..7d9d8d1d89 100644
--- a/drivers/net/ntnic/include/create_elements.h
+++ b/drivers/net/ntnic/include/create_elements.h
@@ -58,6 +58,4 @@ enum nt_rte_flow_item_type {
 	NT_RTE_FLOW_ITEM_TYPE_TUNNEL,
 };
 
-extern rte_spinlock_t flow_lock;
-
 #endif	/* __CREATE_ELEMENTS_H__ */
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index b68838461d..647edd6359 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -28,7 +28,7 @@
 
 static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 
-rte_spinlock_t flow_lock = RTE_SPINLOCK_INITIALIZER;
+static rte_spinlock_t flow_lock = RTE_SPINLOCK_INITIALIZER;
 static struct rte_flow nt_flows[MAX_RTE_FLOWS];
 
 static int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size,
-- 
2.47.3

