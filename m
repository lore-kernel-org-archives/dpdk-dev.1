Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E26CA5FE0
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B9642F31;
	Sat, 17 Jan 2026 23:00:42 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 1D1A242F2D
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:41 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so1703867f8f.2
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687241;
 x=1769292041; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=gpBxsNN9oeC1ZdvQg2uS355/CPOTIucPzYXrn1ACgZqgh0vp1IoUoIt2x7Jc9LbeOF
 wUp1C8fyieMJog/VCo1KpPVjgnQ0pTjs1BZXlgpYiBbflNxHqhR8UFunIXTWXX2lQ3dJ
 vcHsMW9qzqzKtLuGe8jxkRRcDceU6A/RNsMwPckdPb1qLoTxomMOm+kOSres5X1SmtGP
 hE7akpvesK6aWX+nAgUtnfavWDM9cp+qkYkIK1JM7t6jVpVsGQxp5o60xsZ8G0B628kQ
 CmIkgjNg+MeWSyxHnXnW2XvM7oG8V1MV0EJormMxPRAAyYYVVOjcEatK8Y7a+DM61Pec
 5nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687241; x=1769292041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=OCm6KIdPeROxE01St3FlAsri3SNUn/4W+DfA3HhUSYcgQqVaREO/gEEI3sqNzTUhM4
 a37FvpyVstnkjpGHDPr62cBb8TQcThSGZ5zFtbB2OvHuzq+NbzJUwgjktt96pRfhtZrD
 8bZJqlwLzb9pqGJ5dM6RAorzw16UdShiD1qpa04y6AaFikpimBFylmswiys0/s9PClaZ
 ZgfqBYzkS1HoWzsQeja3/zCVITrItw48IkV4Oj7wxmc3kGwhb48WYvAiVHOOZGIm2o1H
 XXhVgzM3WtgBhEEC7PN3ulvtD7kOYEWNhHs51X6cArVw2WI5fXdBNFNycO6EZko8ov9b
 i9Yw==
X-Gm-Message-State: AOJu0YyXg8iz7ixqHioYAsllx6BUt/2fFUikF30ge+2UyepyNNcWrd84
 VhIwys/ljGtH/9YYjwxGEBVJSeSg/lPUx0uhDC13wNbv9mpLa25WtH8gmUXoAgIjg9as5LKMTQ+
 uC2Jj
X-Gm-Gg: AY/fxX5R+NlOSV66fUHbiHNYOGwbVVJBviLHRn0CLXZpGLdJD1mOGYQH22u9xCL70Fs
 nGF87h43qpjD26cp/6KJCFlLla7XfxNNT30kyzHoJ7zjAqJlpGZ0DoLmhIJUMJC0Zt1/mbz2e4V
 Us/jEgWyLir2H7fb9iJW8afiOTYYO78DkeBe6stHIuK70V2RHS/kVLJm3GXim/2zh3GT21y4al9
 CR58ysgXskfAGVEM013BAVin0tn5+wlI/ghsnwbITw+vFGyaCXJCk3dMnVEy/OtAmyHt1arjxr+
 YdSWez4Mszo51vGRHVqsQsbHXe0K6f/gczXjkavsO2nG8tItYS++Uz9xQq7cFrjj+m7Akkdagdr
 bqsbBL/Z7aB/J1MJm5NFU1amvG5GBdniZUl0AehY77SEqDKViiEoSVQK8gnUP2X8QOc6MiCXugK
 ICye09ax56GhwSKf8re56oouzaLtYWwcMM1hT2yaM4BVlqeCNv3Q==
X-Received: by 2002:a5d:5887:0:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-43569bcb816mr7786222f8f.50.1768687240702; 
 Sat, 17 Jan 2026 14:00:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 02/11] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Sat, 17 Jan 2026 13:57:01 -0800
Message-ID: <20260117220030.273471-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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

No need to use rte_malloc or rte_memcpy in the short
code to get MAC address.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_osdep_freebsd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 20556b3e92..32e4a2bee7 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -8,9 +8,6 @@
 #include <net/if_dl.h>
 #include <sys/sysctl.h>
 
-#include <rte_malloc.h>
-#include <rte_memcpy.h>
-
 #include "pcap_osdep.h"
 
 int
@@ -41,19 +38,19 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	if (len == 0)
 		return -1;
 
-	buf = rte_malloc(NULL, len, 0);
+	buf = malloc(len);
 	if (!buf)
 		return -1;
 
 	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
-		rte_free(buf);
+		free(buf);
 		return -1;
 	}
 	ifm = (struct if_msghdr *)buf;
 	sdl = (struct sockaddr_dl *)(ifm + 1);
 
-	rte_memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
+	memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
 
-	rte_free(buf);
+	free(buf);
 	return 0;
 }
-- 
2.51.0

