Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6831D2F35C
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E544065A;
	Tue, 13 Jan 2026 20:25:47 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 7ECDD402EA
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:44 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so10870844a12.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332344;
 x=1768937144; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=LKvhtOEqKa34F2tugtiWZjSsp+UHAdzdVm5Akw5i8dPg0zabLHsUfumL0xMQIPluxg
 u8jRNBofImgjgvzJaQ16sq1XRD+jAYZlLjED0xcuEb5FyaYMV3z6nlrYEm8AP1iQ1NuY
 GESl8NmM4QWlDHm7/28pFm5gTyIekHSIBbcAicpwtFZFmpUlS6hPn0/h4rGOMlaImZHj
 MX+SpNzUKeUKJgYfhL7t0kS6hvvDwTImVZi6/0o1VNSshMs/7vIpKVJJdtaTdN46Ok3y
 mqP1YGyLUkhYeDraEWgkTP7EUc+lw9vdzrzTh97guiXGDqoIsre/ryktMX4jbgjlzDUM
 lMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332344; x=1768937144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=HsZNWklItA3emkzRpTktVaAMOaSYIV+GxeCJZdUdBz7EpXdMhhY+MHddnxxGRh1p2b
 Z1HeKYoNnUja5ez+N+hOQUHhYEQCA/ss0XKdcNnvOPx82aYrwJiFctiZW20HtBElW4eG
 Beemq3G3X41v/7z+ikqAUydiUuBNZsnXuVMG9J93N9VgWTt/X31c+R9+YIhbKZt38sAf
 uMJfFUnSwoElCuH4GmDu6whsuASBZlN9gu5SV9LAGbZI0AHEvA3mWDxUvcHhkJ0DOWsM
 ryE6lbt5XrXT5vvVjy4yNMMtJPERYmfFJcKNMh8Xx6r5MQt8zcZXufWq1nquhWTYT6x/
 OaAQ==
X-Gm-Message-State: AOJu0Ywd6PSQh+RH2+HNJ7EfoWrlsQLbOwUDVJvcFUwcn0oPezCwnj17
 ZFZxV/S+gaO6Fz1srfMd/G0KiovZToOffw8Rgmw0E/hrjTiIbPpsqnbFobkIbbGdqiNkUI8T2ox
 MEsYU
X-Gm-Gg: AY/fxX5onKeAuVOTRofkuk5jT6TdorD9naPLEKtXsgMGKz8OotBq2o8+ipJx+6ADADx
 cX4B9C3/ALPm5VctokB0PRTlrJFC2nfcOBZCqhpSrBO19zRj9/mNu3F31k2I3ktqXN0cIC5SyiS
 wVR5w/kCiJz+wiS7oXSKNMoVn8+hb8qb4M5sMnO3n08VdOZdDZY4I8WbG4cq4+N8+mQ7LicbWdw
 EowqXPEBV5CKQItsr0aD42u3hc9JhPMBBMDX/N9qpf0Bd/tDSdYvm+1MMo5ESeGXE/L4/a9kBWN
 s3EQDs0kbUjeK8UwjwNgIp/iyWTPyiITJ2QKRXiJphMr20jb9PgpQEidtZUEjbXgqPv5InW+zN+
 8YGQwuBx4MCPq3GvDvZH+rdJiRtkUnk1UU++6PKeMGopxfj9+e0UwKgTcNf5+ABoSR01bDYgW8T
 S1qsTJDikprgWdL3bguxNP0hBNLj4CyGJ9lWIsPLORvXCw0JsIog==
X-Received: by 2002:a05:6402:34d1:b0:64c:9e19:9831 with SMTP id
 4fb4d7f45d1cf-653ec128bf3mr81860a12.12.1768332341260; 
 Tue, 13 Jan 2026 11:25:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/9] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Tue, 13 Jan 2026 11:23:34 -0800
Message-ID: <20260113192530.116470-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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

