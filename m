Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF05CF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD183402DD;
	Thu, 20 Nov 2025 17:23:39 +0100 (CET)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id A8568402E3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:23:36 +0100 (CET)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so1173731b3a.3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763655816;
 x=1764260616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O620v5P7WPTts3LgHtpuSTvliQv5MoIk+z7gtua/7o4=;
 b=ut8oRCtuUwK5JccNaLHX7Cy+BvTCjz1wDjIzFjwui8I0A7eSLHaPTCfQfXsLIEofgE
 xSphmqrCJZ7V1L1uwQfmu2nNQAcQa2LQop2pOFI82BeVMHZ5sUob2+6PpEuvbEuJsX7e
 bT2hxRSdx30MqMjhbEB3bA6wrCTxC9isKqP40NQQ1Ch4h2PGEBMkruxL0kQ3Z1Zxaq08
 9WPParUeR+64eXc5Swqy9kjMBk+hmLhRQ7QTa00YeWiyabNgtbHKswB2lNCxHgzNABmN
 9hd8q0mWneI5mr9hoalySjJR49fM/Xbm6nn7M8uHibz0Eq5nszOtBYkjU3WkkCpXHIW/
 6zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655816; x=1764260616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O620v5P7WPTts3LgHtpuSTvliQv5MoIk+z7gtua/7o4=;
 b=BiZqhlxHNL1YiXgfDSod1+RC4vEci54LRewVTxEtMrxyVjg/mPn0vMv+krQ8WWCgw4
 /MrldRmWrCuriG3fHxf+F+uY4MLv6w3JO+aJUPUcsoyWDTjoz/xmb3Qlm8ua2g8LhveB
 DFevNxpaa95IC2rLGBoC8l1/rweyaXUCDrFdmCBc1kWK8a1tVZsEWCXt8d5izkQgQ2z+
 Mmxw/WsAKQ2GewDFbmE3CJ4dJJGsLwZMPZAz5iAtkBS7LEK+/Op4jFR8A7c1IjwQehJe
 FSVXC/6jgwQqe0yipA62Bd/6h6OfdxVWCVSFwA7uuibizVTQUrtncaD99B5zauh9z+7E
 fw0g==
X-Gm-Message-State: AOJu0YxQsfbUMOXiwaf1H50bCkdw9h3QtoTLMF33iIQOC3f8MWNFtdCW
 DiZVDaPbN6X/w0KI1Ka8T5bzIWV3JY4TJy7pZ4GrIvf5VMRMsjLb4z7Tk0vOMgU9MV5jfEkruCa
 u+UXo
X-Gm-Gg: ASbGnctEoWnPp3rRaS85mkK7MGyBuN2cLct8dZuPWPsGKPLvQH04EUvb9JQNt6XHYsF
 Kyf2kZdH747KAi0JFHLKmw+2hk0OwsKO6AYbknXuvHvNhouDSVoKQvxe65jbs/QcBA7N/jw9DwD
 grxmM91WHywcwr48P810aRjSzAzLhL1lGlBocA2D8itz1eaWLi0s7w0tttDerp3XGSj+lXPTAW2
 cI2ZYerpgtulmMFct9nanpL7mgfr4EX9yvG1BlP882odbuNmK2qSBSF8oEBjU9qAhug6j4nEVsy
 VihZ9gvSMn1qRmBUEuMq/VMChy1SyVh/adjBoKmJDjvJggD3WLmMAq23zTaSi6KtEJkRoDJTEXZ
 OP0Aicg//7KSb3mY7Dz2itKAXbHfU5kMyd2I+0yvX77Aa60P9LCE6qRAjTPt3Rcl41i1Xx/v0VH
 v9eP1yi/HB8F08cGtqjST9jkU7gk6Aoixnt4/uJH5JDEZmmEawkg==
X-Google-Smtp-Source: AGHT+IGVP9rSfgHfJkW9zRMcY/ocr3RJ94wuwHCH36ilW6nec4axfd0n1edm4gn1DBJgtc3iKBps2g==
X-Received: by 2002:a05:7022:789:b0:11b:9386:8261 with SMTP id
 a92af1059eb24-11c9480ccb9mr1362607c88.46.1763655815697; 
 Thu, 20 Nov 2025 08:23:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e3e945sm12096427c88.6.2025.11.20.08.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:23:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 3/4] examples/ip_reassembly: add check before formatting
 name
Date: Thu, 20 Nov 2025 08:22:01 -0800
Message-ID: <20251120162327.78062-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120162327.78062-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251120162327.78062-1-stephen@networkplumber.org>
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

In theory, lcore and queue could be so large that mbuf pool name
could overflow. But that can never happen since lcore and queue
will be in range. Add a check so that static tools know that.
Format overflow warnings seen on older versions of Gcc only.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ip_reassembly/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..25b904dbd4 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -884,6 +884,13 @@ setup_queue_tbl(struct rx_queue *rxq, uint32_t lcore, uint32_t queue)
 
 	nb_mbuf = RTE_MAX(nb_mbuf, (uint32_t)NB_MBUF);
 
+	/* Should never happen but check so that pool name won't be too long. */
+	if (lcore > RTE_MAX_LCORE || queue > RTE_MAX_QUEUES_PER_PORT) {
+		RTE_LOG(ERR, IP_RSMBL, "invalid lcore %u or queue %u",
+			lcore, queue);
+		return -1;
+	}
+
 	snprintf(buf, sizeof(buf), "mbuf_pool_%u_%u", lcore, queue);
 
 	rxq->pool = rte_pktmbuf_pool_create(buf, nb_mbuf, MEMPOOL_CACHE_SIZE, 0,
-- 
2.51.0

