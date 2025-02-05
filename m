Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12316C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51EB14065B;
	Wed,  5 Feb 2025 17:25:09 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 1778F4042E
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:04 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2f9e415fa42so1379214a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772703;
 x=1739377503; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyYQOw5yHwgfvcv4qIn/z4VM8/qbMnQvnHGhTrbkKlg=;
 b=ZIrrUGOqEaGCe0XY93AcLchgW+e8ECS8m6AFsiW8JKaqxEALuaJy5R/9YKaFjSl+9J
 2XmPjFhP4sHIWitmybsbCP8maqiQ4Ibr0PDuZuYkwCpBacLWgTqMsJPwnwFaOziC131V
 E3gDDddhCdlyBixPCOledlxIv8YKeFqXwpTsl1nWSuZiOzEW8ZqGMl3v2xdmucaAS5n4
 R+cGpD0+Dz4nojjTt+Z9gHORyH966bDqNyWJWQBAzqmRQTnlunfw+cjMlCWdlplsWwpn
 3R7aEMI1fii9JN4rxk/uYrV/cDshj9VLo0E9SM2pGAdXJaAX9Q/EAAhfDbnIAdIhcVF5
 wRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772703; x=1739377503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyYQOw5yHwgfvcv4qIn/z4VM8/qbMnQvnHGhTrbkKlg=;
 b=g6lIGyl4X2d8yUqnj7YH5wY9nEZgg8WQPupmKlpbI5c+W9pDT5wfE1H7q9iUQvoNsi
 2J5MpfCJtRXX3wsOzEm6amqsKLQ27BbKt5GJoBo8hd1nQRVX/548hggz7WgRjt03aQWx
 SkzHa0eJHBycDleUwkZxuBN1gXTxXIIs5j/B/SHz7zvd1gmdjDTqH8U06zy0MHwgTjdL
 FSU2Cy4Eim/6Hvi1Q1MnIAh+EY/+XIUAJZikaFKJ0+LSxOWyuq38ha3gmi4VCtEbI2w6
 o56HqsvqD+BiwPeKDv1o+Q2huynFIOT1DoeoP/YmuHByYw1a5M4dGmmlUB1as5FzDOKi
 p9Ig==
X-Gm-Message-State: AOJu0Yxdub7b4m8B3cB9x2i1lGR/8FaWIuZkXGoYotKmi13t7HIi5rOQ
 Mf9Kzsj8wJlLQaLkJAuNvUmbqBZVHu9W+B1bxfEGtsJOExWUMjulIkq3td+rrD7/cPnfNID/mos
 7
X-Gm-Gg: ASbGncvqB0YhTjWUpMI9HgUABL61dFinf5T4LFoXC/xOG4X7ASxJpvh5/Jzd+0hOP4S
 ygGlcABluCXeba/F5dIHuqav81GdZ8g8+VGXkzwiuVL6v/pqKFnue+Y9QT4f+edeBkw1rjaRjN3
 XWm2bp536cPJJtuuc/TF+MBuDsZfT1OfFx1gDQv3hYG766MPLWDgl6w91bhIZB8hfX5hP+SmoV6
 2HS36YriNvZb9/RqGE9B/cHTYFmpfkMyEk+ePPUgVfYTyOUyRIcE6tL34rvt3oK39NxCgO69c7N
 w3VF/eUtiBYQrviKciMKMMVA3RVVcUI1ipqXLOaAVziU3nSs4GCByRuZJ8oJyKYp3niU
X-Google-Smtp-Source: AGHT+IGp4YxuaiKwVhSfXB0KRyKkfSWhVXZoXtDKqlJuOxJUEwlwIIRuIGtuLhaU93/T9f8cAXcgWg==
X-Received: by 2002:a17:90b:4cc2:b0:2f5:63a:44f9 with SMTP id
 98e67ed59e1d1-2f9e0811e4bmr4253699a91.23.1738772703288; 
 Wed, 05 Feb 2025 08:25:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v3 04/19] net/ntnic: remove dead code
Date: Wed,  5 Feb 2025 08:23:05 -0800
Message-ID: <20250205162448.161161-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The loop to update speed would not work because num_port_speeds
was always zero so it did nothing. And the array of pls_mbps
was only used inside the loop but never set.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/ntnic_ethdev.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 2a2643a106..467fea4bf2 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2037,8 +2037,6 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 	uint32_t exception_path = 0;
 	struct flow_queue_id_s queue_ids[MAX_QUEUES];
 	int n_phy_ports;
-	struct port_link_speed pls_mbps[NUM_ADAPTER_PORTS_MAX] = { 0 };
-	int num_port_speeds = 0;
 	enum flow_eth_dev_profile profile = FLOW_ETH_DEV_PROFILE_INLINE;
 
 	NT_LOG_DBGX(DBG, NTNIC, "Dev %s PF #%i Init : %02x:%02x:%i", pci_dev->name,
@@ -2178,12 +2176,6 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 	p_nt_drv->b_shutdown = false;
 	p_nt_drv->adapter_info.pb_shutdown = &p_nt_drv->b_shutdown;
 
-	for (int i = 0; i < num_port_speeds; ++i) {
-		struct adapter_info_s *p_adapter_info = &p_nt_drv->adapter_info;
-		nt_link_speed_t link_speed = convert_link_speed(pls_mbps[i].link_speed);
-		port_ops->set_link_speed(p_adapter_info, i, link_speed);
-	}
-
 	/* store context */
 	store_pdrv(p_drv);
 
-- 
2.47.2

