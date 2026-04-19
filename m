Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A49EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 960F0402EB;
	Sun, 19 Apr 2026 18:11:08 +0200 (CEST)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53]) by mails.dpdk.org (Postfix) with ESMTP id CDC2540653
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:06 +0200 (CEST)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-68a3b605bdcso1325006eaf.2
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615066;
 x=1777219866; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=DDrvXlE/rRb7jQTI8DpOte3lJacLKJNOjPI6jGqlcuqASSzIqbonu78jexg6CiYIAC
 LihNX4AFQETUtwZsrrqAkWJTeMRLfQO05hMXXWuHMwK9+xSknt1c4SapAcCRm9Q4IzZ8
 0G6Yevp+YxCiy+hSlPj15AzuGtVxvZY/4Nz4wyyx2+VzfuHvEqBV0hm7VQSLsDF8XLew
 pfnUQ3Q0WC+7yTYn47XqvdcZmOx2MDoFHCkYLSH1cDs7QF1kve4Pe+0gg7ksimvYJi0r
 hTvwwARIXBRyk3l58FY4ZEkskgWThNhIsBFBxbGtNln7rVaaNLQkyaaFCbCFrobfCd8w
 9XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615066; x=1777219866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=oaNvpvP14ZBr+NAegZtvJexrSw7wVpN5IGjQkla7CZI3xeH1uWLfKvWnbueBESRr50
 3JWCbqfia0kyka9w7tmEp9Tbo6vRo/qvGIsUsRhstoCvH1ohrNP0uY7AgIHlN0nAwUhc
 vPhLBT1nyFaDawuAavraCzM0hCjsf2gInO74fSSJLemrjaAI6Li4eFEE2xmWwV8myxVU
 Zh9VejoulbbfZ74Ja48p2LN/DGI37fT4uhh5yyXouEx0YAJFH4Z8iP/6ZZyP4ZZPdkPl
 DZtoSYgenzRpPTmqqf56w7gUkwIMGPNr0CRXq/ZKSqjxwSKMLg2E3QuAWJlru1Y7pvLD
 YEBg==
X-Gm-Message-State: AOJu0Ywt/mdbFSijxKOFnmc+i765A7whlnvnu5HPPVHXx17e5+sEgfor
 5ONN83dI5jUXREXtNYr5vRdYM2xuWjBjUrNZvKeFwNObt7/HodcBdohlrslECMDtW6upqS8VxmI
 yOI8B
X-Gm-Gg: AeBDievSofBoNz5zxDIwuzECFPiDWW5rXnJv2iuMAp6hEF9wzt0F3JTHsPLpjfnaZZS
 CYiQmzqEj8KGBtkLaLRt7GRK8tbs0mTazH4DHukDCk9V9nmvUKhSv8Zu0zkcizKZfRfjXC8x/ZT
 53gMEz4GRpH7/z2CXfAzrexK5qe4he1gwO21APwaWuSgaytejzaTNlSF7eOhUAJQYFvj0CyHUjc
 XSzfR6EQigyna4A7KBhScwqKmFxM/5JN7Xmu9r+HD+QRKieOPaxVGNkI2dZ7R30lRJEI3dHwtJO
 4k81HSD0tR2ELiFV3yHHVTQe4bQG5up6rEN4b3/gQHjlTY6LfyYZ+ud3fIiTSFgP7j+Q4lOIm7x
 cNtite15qRoE5DNNMInDIvordG1UW8D03xhcoq/nNwc8QUgQAEdXpqZ0yh6JprnUuLViCobLjly
 YUqRySxrcOG2C6iXdC1zVyqCdVUa3fR5GKZoA8bGpIur0=
X-Received: by 2002:a05:6820:210e:b0:693:7a6f:b313 with SMTP id
 006d021491bc7-69462de0c1bmr6128905eaf.2.1776615066069; 
 Sun, 19 Apr 2026 09:11:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v25 02/24] net/pcap: fix build on Windows
Date: Sun, 19 Apr 2026 09:09:35 -0700
Message-ID: <20260419161059.205954-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

