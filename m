Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BBC87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAE0F40DC9;
	Mon,  4 Aug 2025 18:31:11 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id E214A40B95
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:31:10 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4589968e001so30367985e9.0
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325070;
 x=1754929870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=IeoZrRGFeknVpq44raijefel7adxfP/PuUgYPLdStoCcqw67lu/tnSwlF187elmtE4
 0EH6TTJZiVwhweZJPD/ZnPDXalQzNW81beZBpI4lOAh0TP6OBCg7YdjzmnkWn5WSfpVa
 KJv8NsssW8lQRm/JOdIEegcL/oZSue0uDt6BOWjRAH0+5Hj4R0xvSJGWI2mYeSulKyOB
 B3lQ+suQB3pYDM+9f8vgnisSzwKt6NZKnQ2D1i8Zqpruu3Nlqo64+F+7ywAwpf+HZgFk
 r//Eng7NqcWkhJUyUfGfbqdP5vuCOQifsq91pEsut2vDv5wlvS4sPOMm4K5G5dleafXZ
 qEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325070; x=1754929870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=Ue2jhPxtkHFVQuU3jc+imgmJ936ov4YIUTGgTafp0NKU1DLD/ahfKGa4e6KpGy9WrU
 ew4mXaqrYKUcO3QL+spJ5RBgRJmHoaG0+dgQN8a4GLF81GhWMukHVxdv/u4LUS3Ahu6c
 fTYWfY0HBNU4hm8iZ0Nc0tp9izrjONILhW/e21QbIQI0Gj19kHxPahTMU/MvQXMW0+rH
 wLcPn7LVfc6/s7nyf7NxB62Jh1xsdf6+P7kqA0toPk4AoiVT47nP1zLuhK0BBd0rGSPn
 LKJxrk8XigpmjVBIzh3woyQkxdyakKiptH3r6gJ+Df3mMvLkwBPPNiSYnQ0ziAnDRJ1+
 NmDQ==
X-Gm-Message-State: AOJu0YyM2SJnYebFhUHVx73Duo0+bHXFhjn6VkRaileW7tugosQAl0kR
 G8LP6OW+VdP15ItL0Z8eyBDj4C46DA65DJq5jWTpoJXeYPVYVzpo8x++00isHem8I0xvaK1X5xa
 0juqR
X-Gm-Gg: ASbGnctGJ07+NY3nGLdEQTi53XA+Ad0NUzMxBKYG0x3VvAfM7gcLHTCpbgtOqsZPZyO
 dLJEn7wH/hBrLaF1sIs2tt0AUHZakTnpOmxPJsxCwTmaOb637SMloijPGzXCo/lLIzhwCXOgUo9
 f2ArBkJJXjFgDp7fG+vZuFJd75ekvEfqGOU4GuOJCB5Mhpu9Mi1UdsKdQqWuTM7S7GZir+FE5M0
 bI8m+UV1FQMvBJecrh67k6qmIh36AlU1oyGC5SKku3Rj+qE4/SzrKC5uXg8aJ2MWb0XvV6BRSXK
 DG+IhpbWdhBYAJCO4yxTHnyVrGqdolY2kSGgmqa2zUFuLKM1+aSNrkfBgcDkJaqC6ZQz8+z8nIa
 p+6YaaVp2yB1wAZVQu6cpBINEc/oYPyzu3Wg6spQPzjo3+aszIEWX7h9ChJCpSkcOD4Z96var
X-Google-Smtp-Source: AGHT+IFZzndQKPuz4mXywCCPrz3bfHeFz9UVQghLSnjMQi0Dx0VlLDVsqJt6/n8amF4DXzLNrPP6dg==
X-Received: by 2002:a05:600c:4692:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-458b69dd831mr72342095e9.13.1754325070509; 
 Mon, 04 Aug 2025 09:31:10 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:31:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 12/13] pcapng: make queue optional
Date: Mon,  4 Aug 2025 09:27:43 -0700
Message-ID: <20250804163039.138959-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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

The queue field is optional in pcapng received packet.
Use UINT16_MAX as flag value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 7 ++++---
 lib/pcapng/rte_pcapng.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 6db5d4da50..c27cb9b48e 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -500,8 +500,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 
 	uint16_t optlen = pcapng_optlen(sizeof(flags));
 
-	/* make queue optional? */
-	optlen += pcapng_optlen(sizeof(queue));
+	if (queue != UINT16_MAX)
+		optlen += pcapng_optlen(sizeof(queue));
 
 	/* does packet have valid RSS hash to include */
 	bool rss_hash = (direction == RTE_PCAPNG_DIRECTION_IN &&
@@ -531,7 +531,8 @@ rte_pcapng_insert(struct rte_mbuf *m, uint32_t queue,
 	}
 
 	opt = pcapng_add_option(opt, PCAPNG_EPB_FLAGS, &flags, sizeof(flags));
-	opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
+	if (queue != UINT16_MAX)
+		opt = pcapng_add_option(opt, PCAPNG_EPB_QUEUE, &queue, sizeof(queue));
 
 	if (rss_hash) {
 		uint8_t hash_opt[5];
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 4914ac9622..48aaab365c 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -135,8 +135,8 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
  * @param m
  *   The mbuf to modify.
  * @param queue
- *   The queue on the Ethernet port where packet was received
- *   or is going to be transmitted.
+ *   The queue on the Ethernet port where packet was received or is going to be transmitted.
+ *   Optional: use UINT16_MAX if not specified.
  * @param direction
  *   The direction of the packer: receive, transmit or unknown.
  * @param orig_len
-- 
2.47.2

