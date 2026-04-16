Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E73F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:47:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC8EA40659;
	Thu, 16 Apr 2026 20:47:41 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 8512C40665
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:40 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so15832369eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365259;
 x=1776970059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=F27qcgxVfMGwO+bo11yW0b/6HPRd/g2yv7Dq8dlJXcIkX0hySnTDKoJCNGbrl5HiQw
 4lARF9tYGkVQHVGZUj9xAvaHzNIjWbQBYZWzU4gER2RdPgXzLLAYjW9MRgnKy5qwAPcj
 JceNZyBSvRJwlwpfTPWn1JtiM6IgxclR1CiPCDy8WTZvlFt+UUP8qxg/9zXwqcP9EDEt
 KMf2s/qttSK9gfL+xvI8N2fcJUlfU3xrrGisRzOcAY7lNb0JW9HbWymRCyHiJV7Tqa5R
 rHj2i6/rKKDo/859PX2OmqSjuYFlnDWLD43Uwlu9KtY3xz17o3UyCM+d6N1pw0BHMEpg
 nkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365259; x=1776970059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=EEb0BmTL2wRhDrCderVmIM451uDMeasTtoNhncoRCQ8CNgnUtidDNhiQxoMRs1iKpi
 VK44m1dGNRpzXcv0CS90At3mMxE0EUFjgR04EkNxj0srwSNNmJr62IoR/NfuYIjBtuWy
 JWXxGfRdcSSGMoLgmheVORh/G3FcMvXpKrhVuG6UyRTNEGan28BQzaeARItuUSpsJ2c6
 tpRTJ3sKerhE+WD2p/1uLQ13eDdvijZrPwxjaXUXKIqXl6AiHT6cC2M6xBpXov5HWL1k
 JughoAkhelL+QrUezVTIgyCR72Oacmokyc9bnQ4U/ipo0c8czGFt96povaqT6EzFYC+f
 6SKA==
X-Gm-Message-State: AOJu0YyGfHD5NyQXY/w/YDAMZfn+0ULVXpfgC2f9FMOkXUzmRIxxNN8D
 0+NPFrAIAcCadkcJIw6/8lzJWDO14WplaKzyY6b7EFX64badbw/Wl5bplNqRyInYoGc+OsKUF01
 KpDyQ
X-Gm-Gg: AeBDiesBrO6Gg6Qm63YsyFAawZQbmRabJwBF7gJYO14uFZz8T5HOmMQHjfYfqj8Lfzl
 Euo587XSB5IvmMGO2l4M+/uv9aLaJLFJ/GyN3nx8Wk/gkwIbwvSP7XN6MYdn0a7M6uGTJ2U+6VV
 BU72L/GrJUdprqPKxv51k1ZqaStvBXTOsCdFxURLBAIXA1xdTTFiO6MMz8fygb1ZnitJ+5yr7S7
 cG6WzbbFK7/m4st8+mZu55BBojuv1hbbM1WhhP2tf1zb91IXwYRPQZI49spQCo31xNC9tHVLO7Y
 qYk2wDnsYu3sYH49nW9jvZntRTav/0o2Z/u/rCtCCXN1Cdp+3uqKI7rfbQRNI0PVXmd5NFoFSYx
 LaZCAohV/PSybz+6/KyKOS+tamHSd4UJrVovRlWnG82Lcn1gEdp/LlrAt2zyIlhTxlri1XwYXJs
 vvpKLPsqu68i9Bu977IHJDx0xT79+dvGhS42VK9IC81Ko=
X-Received: by 2002:a05:693c:811c:b0:2dd:649d:751d with SMTP id
 5a478bee46e88-2e2e3584161mr183790eec.8.1776365259542; 
 Thu, 16 Apr 2026 11:47:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v24 02/24] net/pcap: fix build on Windows
Date: Thu, 16 Apr 2026 11:45:24 -0700
Message-ID: <20260416184731.1347342-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

