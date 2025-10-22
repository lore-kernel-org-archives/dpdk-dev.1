Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341CFCCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 13:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B6534029A;
	Wed, 22 Oct 2025 15:35:52 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6637B4025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 15:35:50 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so5604806b3a.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761140149; x=1761744949; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wEyte0nOF4Xh9c7ES3RPQa2L1UQt/wIOWrjQvo7AuI=;
 b=BW/3sQh4JFFp+vvW44M5XCdF6L+fkISXVkLcKAm7ehA4A13Qd1CPNvScQtspqwxldu
 8ROwFXPAgjzU9jCVO7qewio1D00gs0YepLVoE1S1N3YlYqFdQ0tbuUXjEdD6ryvGokdT
 bal83ai9SjgDze0EpwiQbXKODDilTdsnsR/WCXoOr7bRD4cx2d8Ip+tWCkLuy64fjZ95
 p9kdhhyAyZya9xlFyMc7+kXZ6tl1nto58Rp5a3Z8YRZUySGVCplv7AWmivZ2Xa6SvBeA
 WjL4y2kylETpYkyiIxmTabc5tv+mHtBhjuF1GCp0MGTwZQlFdm1dlq3LPT0OCl7Fdkdv
 u24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761140149; x=1761744949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wEyte0nOF4Xh9c7ES3RPQa2L1UQt/wIOWrjQvo7AuI=;
 b=og9lnwd/K5ZVXMa6xhcDWaL9DuPdSDARKOeT2jhTuCvGUMgdVX2h3jtn9FOF1hj4/C
 gLHZ/OzLLHWVENeqAXqj4AsErCQM2WWcOXqon9aqluP/NwlGV0A3xOPAofNHiTG/UKe+
 lBrsKlC75FrMfIpS6LEDIor9Hd3i1Jj9MON2apqRtWmRi355KCJWv299vZkT0zRP9o0H
 3qfNCtpETjSK6M+AyWmCSdU1B51WfjgbqXn2rIP1sDg6awxx2psGPipV/lS2XLHd6z3z
 2to7AYEY7yyu84YoB3ec1MKOraJK23cebrS7twMQSUnFEVDoLkt0vSoT3IsXqgKq2bkU
 fPXg==
X-Gm-Message-State: AOJu0Yy1L7B9bSCio5tF6unVxBgurpaQejjHolLBsV1fVL0fV90EGOFg
 7/aKZUkty+qYFGaePjF1YSJDdtr1FN+hsp4Pe47VpVJ/ou7rFQZeZwg8cnIDZg==
X-Gm-Gg: ASbGncsOLd4Ye9yUhOlQBLy919NLGPdUVb59OuQa3hUYpmO3O9yk2OB1yEMbTGBVude
 ModttluABId5OZkqP68H7bO95uLwTj4GwcXFxwwWIkbcqFtUdt/UylU+NQ74d8BqK0lNMc0xSqq
 FUVmyuwqMH20fqeMBV+mGW6VddazozSk2NapGzjfqBGoNnSWlVEdwHcdXyKxxevMY2O89h51Y2O
 SVOChGt/RMH37Ey0RGJ+CboWEpUMePuBOgzl/W6MQcSHCtuUeKeZxvC3xvRNZ+0GA5jcuL+jq4S
 9SaHrNwAHAi0cTX6fsEnjc9og1UuP8SA3MZKiuT4NEj7jGqghzzsKXdJTQPiWyqRlSc7StnWGPr
 C/IK+j7foe4N16fDnU8lpr6nLfueUUw+5JLcFR8VYdExfIhjrD+BiiQ4fxzTIz2xHXKTBjUO2gO
 rDXpJWko3La+hJjatLfw9kXE2PZpPWpVeqFPd+QIvkzf+jhhI8S4zi6p6UDqsOneXjx2mv
X-Google-Smtp-Source: AGHT+IG0JpxWyXhuIfXTISx6RAFw9CG38Tg8mDBfHut0HCTGzJD+slExtQtiGT9isGXHOsAA3ljp8A==
X-Received: by 2002:a05:6a20:3d8a:b0:334:8dd2:8377 with SMTP id
 adf61e73a8af0-334a8585bc3mr31010247637.26.1761140148962; 
 Wed, 22 Oct 2025 06:35:48 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:50bb:5301:cacd:1307])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2301231a9sm14645751b3a.74.2025.10.22.06.35.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 06:35:48 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH] net/vmxnet3: disable RSS for single queue configuration for
 ESX8.0+ versions
Date: Wed, 22 Oct 2025 19:05:23 +0530
Message-Id: <20251022133523.6977-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
References: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
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

It fixes the issue of v4 RSS configuration failure in
vmxnet3_v4_rss_configure() whilw writing to BAR register. It's very
specific to single queue configuration.

https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..3c0ddba80c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,12 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Disabling RSS for single queue pair */
+	if (dev->data->nb_rx_queues == 1) {
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+	}
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-- 
2.39.5 (Apple Git-154)

