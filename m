Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D54FD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2F4440E34;
	Tue, 10 Mar 2026 17:14:10 +0100 (CET)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54]) by mails.dpdk.org (Postfix) with ESMTP id 0EA8D40E26
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:09 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d741f61ee5so2245142a34.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159248;
 x=1773764048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=wBCRQuRLA8ap0cEqgM0+oU583d4d0NaBzrLDPD+qD8PdNK3Q/jTflALWjlu2+v/Jmx
 yKsbQ769XfquP7NQhNYp7HnKcyRzb6nA5itjocVNl6SohQ31usc1P4EfYWPRZXykJPcC
 CIf2ro02XD8DtOXixY6A+0sXOqsi4AAnHO617laOPGU6LM8GOqKNPzWH8Y3/2n9pI9nT
 5hTChVXQcAGzBbEj7Ll+aZS715N5V4DdDZsQ/J0UUA35oFbT2y3rb3cS+VYDn2GP2Ytu
 rmBQ4Tur33JWMQgpmP1Ui+BXG2xicFcJkeu5amMrgj4XE8vNaV/oPnK7Af55oFfWHrmA
 yh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159248; x=1773764048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=vEwphyygDE7VBsgZgROQfC259bl+lT5/akCZz44KX+nHSkEz5lEJ9wo7eVtkwQHx89
 u5rceRu5Iedp0mCnsz5h0bFfGsWeDWO9SpZ0XL0J2n1zM6u/EYjGiRb4ILPBmx7mQQSl
 T02B4UdA5yi9XYKd6ADNrJSQ+Qiu9sPeq73SLam2C0EIyG/WmsOMU5or8pMjcrHRhTgk
 JKZLvOhMV9HDDx+JF5XrLL+tpSOHmRFAPNwTIhlKg8s7hCURXlNkhT4rNwut7IjnZ+dw
 fxoilX/uXT6kWvVEKJeFKvyXP2Vv18F/5rGTVmJh4eytX6AoUwrOF+uSRTlM+T8yQupY
 siGA==
X-Gm-Message-State: AOJu0Yz1DdNs6dW8HEx9z16oZan8BDvCjxMth3MqiHzkX8mdHikLSBbr
 EKkITNcr3/pqEI8r+jjWmooKLwocps9BOWllXFIlP+KjaNHUy4M1R77CZIT5Ap8gP6lYi8g9vc8
 3K1MxPl0=
X-Gm-Gg: ATEYQzwdsBJ0QY2Ti4dOBq8hrQOKoj3WiuMjbYU/fdseYIgdzxbar3gfhIAIDdEymhV
 /B6ez0WyanKlDdX3QZN9Vz7mou8WL5WVnOJ32bxcTBKxt5ZYC9OBmpUYjRneJvPwPz7fvMqldJw
 TkD2aR/Qeg7I25fPlmYQVrks7e9UNB/TLIt++FHlcJDdt7sw4+Na4cxLbavotm4FCBWyS5j7/H9
 jIeAAZBiWOd8yKZM1JOrG+ZJcSbNmXDD11lgWd+JZy5KIlmMX7RdOFDzkkuxJN7yMubLkL+RvvN
 a+qqK0pYZdvbaOKNPf/d7R9toepKtt/IyL+SJPlco6MdogYjBzuGm1s2n97QrwJ97MVbO5CxJGR
 B2N3dk3uhh2vTsXQeT/O7wTzuG4vmkOMapCHJ3wSsoDEtknnqcFJo5DgTs8QlGQ6jn8D80zXN5l
 l1BLXCKHBRx19Gu6XLUWEoXq2LFhxsUiKI
X-Received: by 2002:a05:6830:6a99:b0:7d7:4b65:e8ba with SMTP id
 46e09a7af769-7d74b65ec81mr4380545a34.26.1773159248363; 
 Tue, 10 Mar 2026 09:14:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v20 07/25] net/pcap: advertise Tx multi segment
Date: Tue, 10 Mar 2026 09:09:45 -0700
Message-ID: <20260310161356.194553-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

The driver supports multi-segment transmit, but the did not set
the offload flag. Therefore applications would not know about
that capability.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..fedf461be4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -753,6 +753,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

