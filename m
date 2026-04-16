Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F9F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:51:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8393740697;
	Thu, 16 Apr 2026 20:51:52 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 6735D40671
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:50 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso121828c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365509;
 x=1776970309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=HtAd0N+8I3qK1GaQzZGfrV1F1XnG53NQaeEkoUU1XYV8HRm9YWUNVU+ZD+h3V5pU7H
 artBcUTOoiOaA6XvCiZN02NmNSM3sk51fDDDHM5O9Zjx/Y+v9C+Dlt08R1Is8MPpsJlU
 hF3jLwUPcxqEY5sQk7GvQCE00p8tS/JRe+MZDwthwHXTNiV67a/dfAY5ISDjrZSbSrjG
 qlTIMmiJqD7XAThJROMUSBjAlowKQUjEdqMWMNhwgcSenHyqYQaBouAnYDVaXK8LeqE8
 5xG+GmD6IAXmzeWpwdvfTYvkF+GzxlSC7OnbjLbiZndI/1Gi7KIHQ/6mmEliONXD77AF
 cMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365509; x=1776970309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=WiPW//oLMYtmvXWnu5IJOtvd31RPPXcOCBwboMP3qpBts4wwh50Z3Jkt6q6aFdaEQ/
 NeWXp914yFKF3QIaAT4R7nKiWdBDD4+2qpXPhTMIFoUIDCjLMZOl+tKhh4PkcDm3Ziwh
 3KLSQiZt9Lt6fac3Xnreoh81nh6EWQya4uSW6uD1cGYCaf5I+f12ImZo38hSUOGIgxOD
 5IgI2kHiGk1P3At5We0BRHotnLynBaVYTPGWlYHUdYqq01cmw0Q34/JWS7cFBr/Jh7xM
 Bix3r/vkuFO8R0hfoNYjkn7evkEojiwFnyzHdSgzXZ35dUSVng7SC7Rg1zX9j4iLTb2v
 Rs1w==
X-Gm-Message-State: AOJu0YzKfKBLMwoaH0iaYn4qfZyKJO9jRitIu7U4m5cEkvbtREFOsG07
 d8olghf257ZjOH/Cy1FXDJ6waXLoC/o/e7wfpGinGDd5H8BGJ2Hv26IIMFWdh0Obk0YAANCJLq1
 mMQDq
X-Gm-Gg: AeBDiesxrq4uTt5d9se6YuAMwDpado/SWipY/TgAWuxN1TS9uq6OyRttMSemnYcmDmx
 Bk8V+jhQ0cqh1fxM4pFPBkxBldPcSfwxxlc3j19JKM6tHyFW6NjOlHGMnyFgsnoDYCs/LO6iEyB
 /2YbB0/ojTILNDlwgaHAqp7/XGlZ2KU9X2C2EVlsRQqbCKplKbop8Rqu7XSL7C38+zWlzg2l90V
 idj2C5ePC4XzsSyek52OEXbOsWkSJBxxXn0oyeYcA2Kl3aJ32srlAQBO/a74ewJ/uekGkHC9gtF
 FLNnEa5a+OJ7+0LJOZP//T0Wp+j73WozDsNVkfk0AEXWdmu1EBdewwqd0mPXxPMVMDJq44/4qg0
 AwBS2STp3l+SjdzaSYp/rEY9LVdxXtWoKcQAYwGk5+GJLTXmc2GWJ157SIp+MH/slJXfk/n/hXW
 NghkzgVRIAOFcqTGy33Z+q8Mex6DlQ2o+xujXVwksag/I=
X-Received: by 2002:a05:7022:6082:b0:12c:8b9:71db with SMTP id
 a92af1059eb24-12c7285d276mr167344c88.21.1776365509292; 
 Thu, 16 Apr 2026 11:51:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v24 02/24] net/pcap: fix build on Windows
Date: Thu, 16 Apr 2026 11:48:19 -0700
Message-ID: <20260416185144.1359260-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

