Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648EF9D0DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 907C140661;
	Tue, 14 Apr 2026 18:10:19 +0200 (CEST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8F0DA40652
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:17 +0200 (CEST)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-46aa216a5edso3351383b6e.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183017;
 x=1776787817; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=Jtsu3SuQGniyS/O5HxmiJdfM6vDmSSERUTfkownp7Hr3OD8jSSY0kFs0NFbLM0BuO4
 Tjd9yfe+wMvz7AfeiFgxjOCoPld9HNfotvZkcImIniNAOcgecuTcVbw7U+WK43aIG3wQ
 2sVUBFjgj1UyKqCJRvuzUPd86yCbIHjKWObUMeNMhPDgiCMI4ccHjlW3U3hl3dAXV4GW
 c2cSxcG6YAzTs4TjSwslmjTWNKG+wsYmmbSH4hSSoGfKDpgmD8IP9oDgzZmyLS8XeD/F
 yk4NT7awVzpbm2SVLvnlHF1Ips/X5wAMi8d0SZGMsLXD1CDMZF1Tm5teyvQaCUC1zIok
 UTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183017; x=1776787817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=g6QkAeImbjb93xSptWhfgITYzSR5I//NB97VhHKcmx8USsTEBHETF2QVlsBdDgk2El
 IWZRXgYkIXoqB2Jav5e/y02a4GCCnVt9HLlHrtvN/Ob2dLb7kUGJeHi9c+baV8PzJDHy
 Oyt60ZicBeZ+HTvnrg5V17XwZLnhnez79A13xky4Me+k/h5A5pMQnPvoTJiRjj/SHOEt
 906nZM8/YxrWFpu72fUN1mX/6RCJzqfo6n41k7l2TbEiOat84nOpelZChO0/xVhTRzrD
 l6pxM2+GuTwPiAGQNfwxNPvKyjERZ1SQIFudEgCOEX8BITKleudVyvcg4oI9VGWsK5m+
 47aQ==
X-Gm-Message-State: AOJu0YyF+6uhJNraYr7VpQxQzTO1VELVudcqG3X9u5D1IdjDbnHP1NQl
 QpTyXw0Xmx//2pWPoJ9o3nGHiI5xr/zDvE0JBytIX4ySQ+a4FElPAX9rw2BbU2thTNRM1iuH5RV
 XVbqn
X-Gm-Gg: AeBDievtSYSy+hP8YdDHN4o2TZ2D9mtITNOg0WqBYDpit9d9uevTLlNiGtjgYNyeyHJ
 kKoGkKtp2Uo5zFB+xfa/ZIcNnfgormxGK9xWaVOYMuymzO5aPWMSKTQxLdX5kf+YIsnVjmJTHQb
 tDxCh53l/GDinpMRDVoaYQjCDnftgDX0gEZmClJsHu9HPq2mA6FqC101JYQ/kdZ9oEgJPzMhXds
 MGGCz7uZesTdVAeeGyxdwd+VIwFZHJ9v5QsstNUfcJ/fUpu7xvUI2FCpgNVdwHrS6xA/5Pe7P6d
 51m3eJMiUNjJkiLj3voJadxOVKUm6C2L96dMkOAmiKJyjd4QWcSAzTt+Z3m7JHuaXgKUrIKIqqI
 U6iN0XHF+7X3RUSCmdZIaA3Q7E3mrDskJfhrhzRXurvedcG/RprMkUvxxk5bxUllTD+nRiEQp1I
 OwR10FmCVl7P48wixwweCw7M1hLSGxeQ5Y4ktMcGBXAtU=
X-Received: by 2002:a05:6808:19a3:b0:467:1e5:6769 with SMTP id
 5614622812f47-4789f900cacmr10067747b6e.45.1776183016768; 
 Tue, 14 Apr 2026 09:10:16 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v22 02/24] net/pcap: fix build on Windows
Date: Tue, 14 Apr 2026 09:07:53 -0700
Message-ID: <20260414161011.756101-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

The log messages in the pcap OS dependent code for Windows
was never converted during the last release.

It looks like the osdep part of pcap was not being built.
Building requires have libpcap for Windows built which is not
part of the CI infrastructure.

Fixes: 2b843cac232e ("drivers: use per line logging in helpers")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/pcap/pcap_osdep_windows.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcap/pcap_osdep_windows.c b/drivers/net/pcap/pcap_osdep_windows.c
index 1d398dc7ed..0965c2f5c9 100644
--- a/drivers/net/pcap/pcap_osdep_windows.c
+++ b/drivers/net/pcap/pcap_osdep_windows.c
@@ -53,7 +53,7 @@ osdep_iface_index_get(const char *device_name)
 
 	ret = GetAdapterIndex(adapter_name, &index);
 	if (ret != NO_ERROR) {
-		PMD_LOG(ERR, "GetAdapterIndex(%S) = %lu\n", adapter_name, ret);
+		PMD_LOG(ERR, "GetAdapterIndex(%S) = %lu", adapter_name, ret);
 		return -1;
 	}
 
@@ -75,20 +75,20 @@ osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
 
 	sys_ret = GetAdaptersAddresses(AF_UNSPEC, 0, NULL, NULL, &size);
 	if (sys_ret != ERROR_BUFFER_OVERFLOW) {
-		PMD_LOG(ERR, "GetAdapterAddresses() = %lu, expected %lu\n",
+		PMD_LOG(ERR, "GetAdapterAddresses() = %lu, expected %lu",
 			sys_ret, ERROR_BUFFER_OVERFLOW);
 		return -1;
 	}
 
 	info = (IP_ADAPTER_ADDRESSES *)malloc(size);
 	if (info == NULL) {
-		PMD_LOG(ERR, "Cannot allocate adapter address info\n");
+		PMD_LOG(ERR, "Cannot allocate adapter address info");
 		return -1;
 	}
 
 	sys_ret = GetAdaptersAddresses(AF_UNSPEC, 0, NULL, info, &size);
 	if (sys_ret != ERROR_SUCCESS) {
-		PMD_LOG(ERR, "GetAdapterAddresses() = %lu\n", sys_ret);
+		PMD_LOG(ERR, "GetAdapterAddresses() = %lu", sys_ret);
 		free(info);
 		return -1;
 	}
-- 
2.53.0

