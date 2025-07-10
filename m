Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DFC83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:43:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E66740E37;
	Thu, 10 Jul 2025 18:42:56 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 8C5B240E11
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:54 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6fad79433bbso11461596d6.0
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165774;
 x=1752770574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=wjhH1zwHv6rcxdT6MOHLhR6UreG3YZSD/dpkXKRYBQv5icorC067viLIOR2V1PMdHy
 f6qfEeZTVhZypScBrQm+RQ8wctqJ16eo35QWbh9CZ2IKJbG+BJ9eEGkxgtiVhINP7MwS
 5AydI3dwiIVZmcJbZ/7DewBiA8xfjFmJkGa9cPQnUMW7bS6AUEPIxTkmiQ7KEpr9ZFaZ
 T+r9y0se53+jDZI/UuF8A42Wa8PMfwfFjkxspmbeiQhYXKlqUlTF5wEGPChWye4v9JFD
 FZc0ckVWJ+oWeS1Jgr4OpOyal3E+ygY7wDmmAIrlM97dFIDIowWbMSk9NzWPr185pxYg
 +WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165774; x=1752770574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/RQJUCWAWOmFgBocfh6R0dp7bChsllmJyikY1zuGmM=;
 b=hyjER8AYpAbuajftVcYJuxiN4b0vR+zSi6qbuhLKXL7emTInCAZgTm8W/i7D2ef8Gx
 Q/R7s7U7tWjP6S9WRUWU0XeZD92+x/7BWavlic+8WOiZuQDkg6DgCZ7hNTtnTJMmLlMG
 UKtWRre6cS19HUKFWdspKP7mQleIiG27gMVkTPQBfwdaUfxs8AdeNFJODlag2hQvWWGV
 iU1owzuGh/YiwvoMN31cB0kSLzzjvvvLC8P2OjX/TZ6baklDKwd4ihDfNW6GlBOFJwf9
 D13GkrFswy00ZtaR6upx5aN+jjrjeVL6B5c2Bj43g+ErIfxc8YG58qqBfQ5C3wyFzZbT
 rm4Q==
X-Gm-Message-State: AOJu0YxR4xos85OsjW9hWEmNGuS+wu2ukrXGOhRz/X4qM8UZjql7/s3a
 iOyhB433E8mCdgTF+WZqrypjwvDv7/NhDlsk57M8xUd02xSi3YdE93AIgtty0FlQTCmZwac8DuH
 WeQqq
X-Gm-Gg: ASbGncsctwlIOzuA0i1TY4dIvuxBHxnqquGA1iOEo7cT4BBi3SNfhDqXGwFu8ww0R03
 RbpWi9Zx4PQOuZOPFi3M++APnHxtemRhkonMN6/YpaCZIlcq36cjgLoDx+iyLCH4RUvuUaZ9TFI
 PLD28shfEEphJt3WaBB3SRAq8dyG4Lj751XlLt6nHNhS09UjxMG621y+agsu1rpdZqqHFgXjypv
 YCeWOVmOQAHQfnsiMI2XcuvryAVJc9VOSY3s6/VRYT7sVIw22JutoeeR/mgTQgPcp8ZpDEigvNS
 8Z4fwMIvb+4SCMIMijFgLdWlRymMVpJTqV3WKBL1AgPYJv6iWjSCJxwDFQfCDB1mxyYvT8HLI5J
 gy4wVY3G+pj+Vssnna1YKpDaihAM2aeIKEZzK
X-Google-Smtp-Source: AGHT+IFG5JlCe/LI7DmEi0+Txqi7kLA3hgqjEDxG7kYBykuhZFA6KS38twEbDoko6cUTexZQGMeaDw==
X-Received: by 2002:a05:6214:468c:b0:6fb:6775:4fb8 with SMTP id
 6a1803df08f44-704a33a5c9fmr1151716d6.13.1752165773890; 
 Thu, 10 Jul 2025 09:42:53 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 09/13] pcapng: make queue optional
Date: Thu, 10 Jul 2025 09:16:50 -0700
Message-ID: <20250710164237.8630-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

