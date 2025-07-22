Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6DC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20FDC40B91;
	Tue, 22 Jul 2025 19:36:12 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2FC2140A7A
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:09 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7e32c95775aso587824885a.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205768;
 x=1753810568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=jzxT0+MQJNKq0wEE4JYbpDAj0U4hMTudFXs5T/Kzd1/UQMzGYhM1Thxsljvg5FavHm
 V6L80EKUJrkcgmCch+H47sK3JgArazP78jRKVz/vhUBxv4HxsD2YLDNQr1t1fZxMdWWW
 VLxNqlPIkoXzGfPDVciz0xFYcvI2r5Mt5Hjo8LSRLeuqqGriwTUu2/QTvpqYxCWH+xX+
 +dVkxiiLg+lDJhhszR5v8QDFPS8AT93ttx2kuDEUMiu3MMWRj6f1mhQ9CyOQF4F68c/y
 kjU/OiAYAqdB8dRSOc1t2rEkJb6rNjWYgkw8wIR32sjCgBS2zIHPHkbeb9Qskv+qeEH3
 6fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205768; x=1753810568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=BKDJ8tHgrf3B8aiccoV6jtASwtttrA8DgYFQp639+smXs63NBnUT0HqIckBztxDVSv
 4538zjrpAwon27X1zI7WrXvPbdJ5VPupxyTMPDWgUa9AVg+0UZaP6Us+NWcpKyjF2ipA
 AKBJ5Fepftl7gkDuv774NWC6jWhVlR1x5gOJxRjiAzPqvnmXqfK65wm39og8ydnXnNiX
 le+8CX4S6i4+xSEW3BeCxeSyV2TC1F9TbPiYTf77JYKei59PGvrLULwFIev2vSGCQH8n
 OaI2plGT9ksbMNVo7NNcoiwsjO8Pj51qgbNO7Im7sQ391nX8NIMwxzA81bbLgeOnCXdQ
 zZoA==
X-Gm-Message-State: AOJu0Yw2c2ACRmsnRfAwyrFSrQOyKNM6oppgouwiQwgqrVl3KCseh62y
 o4iZWraLvJPuuxDv9oeFPKkrV1ZNz+ZS8LtNV1DnIPjeBifju06kOGhUIG6AbqicayMHweGFOWk
 My3wr
X-Gm-Gg: ASbGnctocF02KHFHCxvZQSImWWgWhlzw+0mJDr1Z2kImsqszwwf3yxg6lexnYSy+z29
 BctnJZJiAaAOYRF/hp36BRP6YTnMqtGcBHPX7+ZNnYXJCwxWDe93B4IHLD1ZJCiurb+Cmh9Vyzf
 wiAWEXFBHSTEszxcl/Oc/HowE7J+SRKyMkg/eXXdW9McTrIchoRFPZ6KxAqYkUlAdwm41HSWXpJ
 8OF6DlYPrZjhfSLWpVL/tgzLHO/Hyyh3FGcvruKDJww7OL/GtG0bf9lyR1ywQAyJNuO4hgv3cJI
 LQECdEW8YleRjxyH7qY8bwYm4CfPHAzFbr3CV55f+/M1u4GaeKyGVcODCFLULZuyRTP11S3xpZK
 xnay6U6IZbH1RfmaStAfcvyg3Zci7aY6DJegXUoTMLRX10TEnTy8eLSPP0z6hbqnFS1bfXsH6
X-Google-Smtp-Source: AGHT+IHoH9TMmQPNNp+V/TYErC+9MPc+mutzQZHDWxEqv7SNzmORevaeUkx6gU+6WE8UGD3ioHjRAg==
X-Received: by 2002:a05:620a:1a82:b0:7e6:2435:b6bc with SMTP id
 af79cd13be357-7e62a17c789mr11365085a.29.1753205768301; 
 Tue, 22 Jul 2025 10:36:08 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:36:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 09/13] pcapng: make queue optional
Date: Tue, 22 Jul 2025 10:34:40 -0700
Message-ID: <20250722173552.184141-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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

