Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06ADE94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C06D940663;
	Tue, 10 Feb 2026 01:02:15 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 4BCE3400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:13 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so72914695e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681733;
 x=1771286533; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=ksxlBpn4dHTnpD+4/duIbGn7QvvqRydP8mFeIdflv32OxdErR/rXP23DLFRlQi/Bje
 SN7nDqHR5cgFeTTxO5yQRJy/aKj+n0YwAN2l5qLdJdGRYZuqX6G2JhOjqJe/gYb3/cxo
 RSfO/FQzwQ0/wrNHhXItz9ltFYdYUQFTpVs2AkJhQs8d1BqvZEiLatbCuFr2bZJH8eXb
 dphL9Dz1OMC+K3iGWOwcD4UzuWQUCXEcdZJqGnNOL8MPDMhsY9Ug5GfypXjtypy+Ev4M
 iTJG4/0or/xN+ibBIaiEHV1tfl9wZ1LUlm7G6S6E7zycDGtffdEAA2tWUsmdZIutoZQC
 DSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681733; x=1771286533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=W0QvmzzakgQBbvzVZqn6oUN0V8gUp8kBtaNPnyMy/yxYibTVQB6VgrVJpG/TVA4RVk
 UkhEnzIs2GSKyWNhxd7Z/agW1IZFUAQrnkfEXpihBtveoQumTb4BuBy/8+YXt6kgXQ3v
 55kpGWMbVjsqArBNUq7Nc6zVE81buAc4i6YQe3vKXZHz5RKI6bxzZs4mK/BleYIWqnV7
 76roBVGlVi8lmJTFdhWoXP/lERcOvCNQfz4r/C56KO4P/M7lEj03lXemZDcbD8HgIfmB
 qbA1yjkREZRHbZVVx9IWXGkvJ53QDMajc2WxTcDe05rPtKTESUU47vtwE5DUIkeWwlwr
 fwjg==
X-Gm-Message-State: AOJu0Yxap9BbLP4M0XqYtExE1wvTppERXRcOKA5xLYKqMt7KO+MKHt3i
 yT7fHSoPmluLe0BZmqoj46bX4fvZmthkwQletW6Qu9J+ZDpCcwGCI2JgDY4+9LlZr6FSW0huEKe
 1USQ9
X-Gm-Gg: AZuq6aLXZVA82Y0U05dCwlHVhwfAL/5Q53f2ZiVrwWkut5fCPArrMnYzy8NV12c4N8o
 wAVPPWLjycJ3UKSz3XICXHv3l1iVXybtF8F4/8q9cqeAW7DMikH3JTjxZhCpzt0cODjuf5c6pf8
 7FJp+w+iipZIAAF8VxCVqgLS0AMj+FZlnIDLarDnCxEYQs9K0HzMUTCkkE/NcaNWqLYY/+TDKLy
 BbBGdIbtufJjxkln+oDTANHg+K4lb8TzVJJv8Z1nCGOpGYKEAvdri/slHScFujzk35amsPbDrw+
 KhofyGl+W3AHmPEzQSWtJF835MTMjs5+r7zRD2KbN1Yi/WzUtliVDfJgLVBrFIS8wfSeYKTnydc
 seItf9gQprygMB4zEn3YBf3zlULTfCKFKeRLxVUEpXalYxKuTfq8smNTulLCOt3+nga5imnv6DM
 riwYAtVOseJzjTJx0p5d4ViEfnxG0arkLA5sN9h3ITlGunj5RrGrCOvYvInoYH3UBhctsCiVC+
X-Received: by 2002:a05:600c:548d:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-4835082d198mr5834555e9.27.1770681732722; 
 Mon, 09 Feb 2026 16:02:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 03/16] net/pcap: include used headers
Date: Mon,  9 Feb 2026 16:00:34 -0800
Message-ID: <20260210000201.295839-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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

Include the used headers instead of relying on getting
the headers indirectly through other headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 9 ++++++++-
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..4513d46d61 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,23 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-
+#include <inttypes.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
 #include <pcap.h>
 
 #include <rte_cycles.h>
+#include <rte_ring.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 2aa13f3629..a0e2b5ace9 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -6,6 +6,7 @@
 #define _RTE_PCAP_OSDEP_
 
 #include <rte_ether.h>
+#include <rte_log.h>
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
-- 
2.51.0

