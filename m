Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B6E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:43:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 732C54065C;
	Wed, 18 Feb 2026 17:43:31 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 489B640269
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:43:30 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d19bfe1190so62964a34.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771433009;
 x=1772037809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83n2R8eXQFwYvpDNQ+GuxrAR2KG4hT6o7bwNPA2OZyg=;
 b=tqL+rKVSBqFJ9ivbBvTGpPGwFFABrG/ehRl7i8bI6P9EO6FLoQE2Vgxab7CmfNfKuI
 tIkKbTX1hVUuuYOlunmIjBLF6alxUXtfhYTaeGCw1IiegHZ1PC1bl6Ve6+H69pjJVvRp
 M6wWITc/7PdipJMPmE1cb43O4vyfaHorRZkv3ZrpG/7ZehCzTWUHrN7I+/6dOrey/1Gs
 ta3vafAAAXJnVIx9yZUXzPQGwoJ6UuG2YBqh2xhuzv8UDXGQJ01p/XCfTtNRga+MCPvn
 WdrXi0d53XNL/sfRujKcpQ18ssjYgSb5jWQiq4e5iSajRoycKXia/yQqn/36n0ARC8Ay
 2OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433009; x=1772037809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=83n2R8eXQFwYvpDNQ+GuxrAR2KG4hT6o7bwNPA2OZyg=;
 b=J5NEalZ02VaWHJbUYLjwIFZELww46/NElhNLOegJik300FHGrT4UKvQskZkkWNUDqH
 zdKkqoUxDxsEPiboZsBt6Ri5ikFhGx2LIITYVydbnXmVjh9sOzveZZIjOobz4lv7rfx+
 nYmjrtbsdUys63kHDzdKSl/9pWho0o0UcXLEmu7UhNzjR0icyoRMbawTUmzav/ygyfnr
 4XC76jqsYraihdrpl1vPLpgWFvr/peCXTbGH/Hk9U2UfUnpPELH4W2bWbCfUJw8eVGBh
 k5UvwO7En4z26+5uH71e0un4tgSN9vaVMI2S1Yn5s0zUuYQJaehpci6IzKPbT8rzvBuc
 I9FQ==
X-Gm-Message-State: AOJu0Ywyunwxw0xyDIDp0LaN+ggsreNhusvCGWgjal4x/yHgdbwDXqNg
 DkS5UEISAiCoA6acbWwGRih6ZuZLlTowyDZN28fVVN7wUXxfsfNAPqcOYW1F5mfW52pjP56lAnD
 2SuBe
X-Gm-Gg: AZuq6aI+dqrIqOM68IAasBS9TOjsEiQNGy+doOi15xFT/T8/TQEPG8R0QHkbnQsYa2f
 LQbyaL6djoh7/DtIcBWZzw6AWqduuRgyCF9hmSx7kxRsOswphNfeUy3lPr/8FaE+chu0AB5J2JN
 jOT72ZwksfDJvIRXHa5hAxqAd/q1QkOopO+vyWhj2hNnNB4xvitRd0AjdK7lwDHTV/r8n9r5ezl
 n09f0wYQJeuewTfUNTdgLFQr6b0SGcrwBLyKkUGhlL+/aCA2Med8hedauReZGtiRi/J3ZdUXwas
 X3WPkzAw3a8gYci+fLhwNWbGN0u7IztKrs9hh5DglA2qAVOo5OMStPjA9FK7xyK4ZBNAM4XL5+S
 s2wxmFr+KjzZR4QiopxzZLQ0Dvfwq88zemgLCA+zFvgIuKlYDkUruhupOxqPUPDp4VcnFIbADJ+
 4Tlvlp65U0UagQG2MJYAQMolYKd8CfG+QREl3txHziTk5ifgllgu23tXVgzOMwPYn3fyMBSZxQ
X-Received: by 2002:a05:6830:268f:b0:7c5:3c7d:7e67 with SMTP id
 46e09a7af769-7d505e49fb9mr1348508a34.29.1771433009545; 
 Wed, 18 Feb 2026 08:43:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c6727752sm12878313a34.23.2026.02.18.08.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:43:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH 2/4] net/axgbe: fix Rx queue leak on descriptor init failure
Date: Wed, 18 Feb 2026 08:41:00 -0800
Message-ID: <20260218164324.915065-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

When wrapper_rx_desc_init() fails to allocate an mbuf for queue i,
only queue i is released. Queues 0 through i-1 have already been
fully populated with mbufs assigned to sw_ring entries and
programmed into hardware descriptors, but are never cleaned up.
This leaks all mbufs from the previously initialized queues.

Fix by releasing all previously initialized queues when an
allocation failure occurs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/axgbe/axgbe_dev.c b/drivers/net/axgbe/axgbe_dev.c
index 634d4ee4a5..ae2ae42021 100644
--- a/drivers/net/axgbe/axgbe_dev.c
+++ b/drivers/net/axgbe/axgbe_dev.c
@@ -1025,7 +1025,10 @@ static int wrapper_rx_desc_init(struct axgbe_port *pdata)
 			if (mbuf == NULL) {
 				PMD_DRV_LOG_LINE(ERR, "RX mbuf alloc failed queue_id = %u, idx = %d",
 					    (unsigned int)rxq->queue_id, j);
-				axgbe_dev_rx_queue_release(pdata->eth_dev, i);
+
+				do {
+					axgbe_dev_rx_queue_release(pdata->eth_dev, i);
+				} while (i-- > 0);
 				return -ENOMEM;
 			}
 			rxq->sw_ring[j] = mbuf;
-- 
2.51.0

