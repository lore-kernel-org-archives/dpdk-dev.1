Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A55C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D4644065F;
	Thu,  7 Aug 2025 19:35:12 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 56ED440A6E
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:35:11 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so1099057f8f.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588111;
 x=1755192911; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=12HrVO9sR3ZyBVQaIo7LAnxIDNQVIM+95J6jqF5Atz4LXnjAm0cdLV7PiALm8RYDFk
 ZobCHka4OvaURuaa7Vics1q3nfhulbPoLbPxWn1akfYO52yPBI4p2te59YK7KShhcbCW
 HjSsA5pk+fEbFahuR6pcRF1d9DIigw/tWnCLCS2xdh9zi0AYfGrclRnV3kBhPwSKEYqb
 oOsngd696sFBAZUuNbBcSSRiwv8CbQGZ/2F0QdZDMzRbN9Zr4gtshW1DPb7vyRlXgZwj
 4Tl7sJGBN2lBuysZwRadXc9V86/4c+mnO3W8ofg2PwH6KCZIlhHbmad9u0ffiJ1T09bn
 /wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588111; x=1755192911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=QEV2m1SkzcdMwEuwwjmAcCLFUdFXTLMVRdjz3ZcXYKjeOgkHEr4HBrw63E9PI4Ty8l
 G62LR1Fm45a1uRJJnFD/iMQwcwXtOuOwUBY/k+c28P/FDYMND07YqwN0RhlYs14UxsmT
 pCKTPl295R+G+aToIRcIXbMZyQcW6Zrvulka3pMdVFyrjIjhAhtZVaIPO/tG+gcjydio
 GfPaBDZgSSN1D9tkOKnSTAYNgQg25vkaS6DIfZSFD5j0/QiXbXDV2s+Sdo0246JB4ZBd
 AvRtgqBKRkcos+ggFf9b5akZKg1JoPmRvX69ySYnCfE8lW0DCguBBFlySyy9PmzHpzJH
 GXUA==
X-Gm-Message-State: AOJu0YxAoYQ5fm9zbHKVU8/C2QnpC1GanfLmHUXp8ZjUVnGQHU2LC/oz
 CJ1wDjBbi6A4Vpwb1PrAiwEeZlZXcJiP7AaALfHUUWuej3eOj8u8m9HyGoIe7JUT+icVR84BAi+
 qb8na
X-Gm-Gg: ASbGncvq8GckJ3Cy47Duf85IuKMVLuFqPDjpyDIrhIcbhPeOorqtjOsEIjKhrbzdj87
 N7mb3ccyIpjzjd3XOn+S5ovYbYpBcbdowRJHTD5TBtwNP1CXyFJySafOXsqozxgfQrM8Ms3dz8u
 lhgAV6U5gNFY1ufT1Mvi1L8zha7YEcYmgUKTRkSegQHel/MiYpbl5W5yQWJQqntzi+V3iAD9Eil
 Fu+rTDHfok9vA/ROE8KMf3SJLCh2j8quJrFqjJ/waEmffHmES6RwyDuZhaFKRhW4r6CVmkPbRmz
 4Pq1zevuLBDcECugY1/TJWetLQhxVx5pTSwQXjUA8K+45lstsVP7MwqVC/ynWCdCGZu/QW0tAM6
 ievM+aGE3jKsIt2hrN07YGR8u3kdBG5uwD19wuO4D45lcu6P6RHaO9IbjZS0uLZ6OccMtw0HVrt
 sNNIE+INY=
X-Google-Smtp-Source: AGHT+IGVgUOY0dKMS4NpxXgDI2ba3RSUeiO2Inz3A89SLNc6pP2Il+CIRtpx5rFc59hsDZBY4quBEA==
X-Received: by 2002:a05:6000:2004:b0:3b7:78c8:9392 with SMTP id
 ffacd0b85a97d-3b900b5052fmr74256f8f.19.1754588110908; 
 Thu, 07 Aug 2025 10:35:10 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:35:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v10 12/14] pcapng: make queue optional
Date: Thu,  7 Aug 2025 10:33:26 -0700
Message-ID: <20250807173437.11442-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

