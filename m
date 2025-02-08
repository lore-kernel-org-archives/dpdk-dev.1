Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7009C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EEE402EE;
	Sat,  8 Feb 2025 21:31:59 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id B7FA3402ED
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:31:57 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-21f4500a5c3so57623315ad.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046717;
 x=1739651517; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1j9XiGDKApfoOd4c39AuRDGOI3XN1cA413jHKpZ2h0=;
 b=CVfvF2cLtpl/Leu8LswjR37BoHnFUSOnwEUBa7fO+aTx0ApvwuxTNpG7nXnGGSy2eG
 FQQOldkvPNMKUAoSVkim89er+pvvX/HcAS7CCjjINqWhxQB52xdBQDaPWPb+gKKr+ZIo
 f89lSYNLZaLN8d3S7qGFZVnVwXclh2w4mtAHed2lXaAyL6zjLkeWQUrc6ZW8vV2lGfdc
 mQmXc1eGuw9MJ6Ty2oEbEXTrI+otmIbRs2Hi1g39xOoVOwKY+qlGxPHxCuQJV1webXu8
 UhL0qL+CeoUdGIBAY1wUklTeWazabM8oQL9OEJXsZ01qrR1rzMnxD8yYF7EJsNMpC72Z
 sjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046717; x=1739651517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1j9XiGDKApfoOd4c39AuRDGOI3XN1cA413jHKpZ2h0=;
 b=n/tqOwhDgaRKnufqsDdQs8vR5Ez+FICt0NavCSJ8K9hgiaQTtcllkUTxsgr1h/CInm
 /M27WWwVUb3ijUbwUQFC53CIFnu6nnBg9jUUIvq2aH2SgFIBmMR57d3IacOWmcd5cRrJ
 n0rtsWhda6zvbY4HAhfxtKquxBqfmhfPJnOoUzIvU5zH/OYINwumJ4oVJXHQHjGkJBHA
 gNHa9oZNrMyUzC3t0TwthYt4seTRS+FznhIspK743VE5h68wJI9GmZhpBfQ5bX6rlD1y
 rAmz3rMtl8oLwfn6hCHHa2sGQytY5uncGg8AZl2/CiLAvvBmPa4M5h5xSnISFD+XNIUy
 zWfA==
X-Gm-Message-State: AOJu0YyLqTgjvFPPQ1b4GQx5lEJk1ILBIIfFhOzG5W3jgjlvfYcak5AK
 qqvnRoI+Ax4+5NA2W4DzYJzaQ96v7MLHjpXHRO4jJkE+p0HCkpaXgmYTCt0CsrBqJLiUEB0KPBf
 TX78=
X-Gm-Gg: ASbGnctl1GEtq4T8lHyyAt93qwIX3Plcwpp0dwpTRIwzYCBtyHtyLU5cLWapYuwH5iU
 QduS5IZ6pvXiw5Sa9njIGeg4EMR/Sqk3OqVqLdjX7Lr5XAPSKrwMG6wrQjOYEzPWd7uFW3YlwSN
 J8YkP/41gJ4cJkMGzgwZiW3VmQ1Ju1NUkldmIkdiWtanMUdz05UQSRRx6hXYaFgVMbAKIcHnrk3
 L3FvsxG8iSnXwb0LvlPBQu2kv8VNx6AfwHr+bB3ksa1ULI27ICCYy6VEP2Ut9FPWMk5WFDkYCdN
 8FKOfTDn81Rnq4/TWbtrP0XkMQU+doMsDlUUwoRPheHEU5yWkZgvo+yLMqblUma3i7zK
X-Google-Smtp-Source: AGHT+IFMq6WLaalS2iRzgJ7FU1nh5w4nuMY0xvru69Gbqh6gA54jNMC+nrT2KkHhJIYrx+saMlpG/w==
X-Received: by 2002:a05:6a20:9f48:b0:1e1:bdae:e04d with SMTP id
 adf61e73a8af0-1ee03b708e5mr14546319637.36.1739046716824; 
 Sat, 08 Feb 2025 12:31:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:31:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 03/32] app/graph: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:21:55 -0800
Message-ID: <20250208203142.242284-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/graph/ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/graph/ethdev.c b/app/graph/ethdev.c
index d343235dae..2f4cf65c96 100644
--- a/app/graph/ethdev.c
+++ b/app/graph/ethdev.c
@@ -422,7 +422,7 @@ ethdev_process(const char *name, struct ethdev_config *params)
 	}
 
 	/* Port */
-	memcpy(&port_conf, &port_conf_default, sizeof(struct rte_eth_conf));
+	port_conf = port_conf_default;
 	if (rss) {
 		uint64_t rss_hf = RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP;
 
-- 
2.47.2

