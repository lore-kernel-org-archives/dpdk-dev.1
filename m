Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9BEFD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30E2A40E11;
	Tue, 10 Mar 2026 17:14:06 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 342F440C35
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:04 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d73ccee442so2925224a34.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159243;
 x=1773764043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PACg1fq4LBA/D8nP2+UHC+fbOufmClSD8MasfVYRrs=;
 b=gwYO7SJJ7gTFwJ7VW9ZD/C0b/dK86vTNOr4ltsjRdkW9zdfWH+R6AGK+4/LVZXVPhM
 cdcHXIVi9BZPJ13Lobg3D4daFCfwaLdMUVJgZhj9xNSgbI71lyiQwvw55NzptVNDMg4k
 r+vekrBzIq7lgJE7M4TDa1w+02UxM9ePvTGmV/6LUmqt2wnnBcnK3fsTdo13tSay9Vai
 zvUyuoVeMIr/vZMR3m39BtKijL8W61r7N6G5RZ/RPaqX5oMa6DwSALH4AmjNdgRqbsi8
 IFKKZbjiCChIK9oGHura1qZOshbLmsc0WwteTz9YhhZ/e7vg24PjlLFSs1PfqiCgRKwp
 qpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159243; x=1773764043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4PACg1fq4LBA/D8nP2+UHC+fbOufmClSD8MasfVYRrs=;
 b=Jex6qFtE7lkKd9WRkGTeT/Fp6VJ8ijKSffym+QsX0OESXUeM8iQaQ9hB/KpZ7LffRp
 ER09Bz9LN1GmrItT5TsFcuAJ0kV+sQdXIXGzroq81gELGslLcn+Lmh3PoXY+rMvSGM18
 H9beWKxQL2PF+Swr8uy1vHCDd/KgSR+ZTLZma0hUVUf45tn2VWrLxOG+NQSi6X82iXaU
 EZnSGNc1dBayfzAai4zrJ8sqPvP9oaSraxp5vVFTRC334A3jfxFKQNzVpK+j3danhaEW
 /yO2A4Z0AC6yxniCTTLIo4B7ErlFLQy6VZgPnRfbh2tClPZGBinBV/6a1BMxH8YqmZKg
 cf1A==
X-Gm-Message-State: AOJu0YyKYIIySz6SAAvxBiN6bvJv3RaHJGt/o4wSfHDwESmX3je7YH0S
 bax9GUdkXBLLyawxpps2qjDwHKm1uX45b6OYfh/HOqqqlHrWgsmLilwVWujyxs/VECBaG3NZtyr
 KsUI9R5o=
X-Gm-Gg: ATEYQzytbmRZQT4fbbeFh5JDt2Zo73bD7cPoxxzKIP4QdfaB70pAN2TMlD3haifKVME
 2mUP98VjdF6BXiJOhOYcbzlmkzLvCqLCFytqvfgE/Jv29qFtubRZa3gNVXNblCNTyO8+Ko5euJn
 IHSkRHYTVL69uTas2mDTy8lc8+AYfqwd+LgooWjGFfa98oH/hrItH8QTYsD31exJLPSb4olO88Y
 YIycVmmnrcsDrLodux6w91XcsWf2sTa+FXKkd2OqixcosVlwKchwWs3gKL26TaHFRbf1kTWqUQE
 tBDUuo2sVAz85R7l1Xcdj+60E9I1oz4zgU+okDGTlEkK7Ym32LNSPr7Tr38LOj+ERT7LDRwtO2u
 bmj4u0fNOOBRvCC15S5YZIYy3QKKtVHHTB58+b9fgZy3nabekkGxE+pgCTx3T0MoE9ul4tiS+YX
 nXzfbHw5bo9v7zkqJVP7ftK1tLrQu/ahWR
X-Received: by 2002:a05:6830:3812:b0:7d7:5dbd:d532 with SMTP id
 46e09a7af769-7d75dbddb47mr2001658a34.13.1773159243411; 
 Tue, 10 Mar 2026 09:14:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v20 02/25] net/pcap: fix build on Windows
Date: Tue, 10 Mar 2026 09:09:40 -0700
Message-ID: <20260310161356.194553-3-stephen@networkplumber.org>
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
2.51.0

