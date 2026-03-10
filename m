Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662CCFCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B48E840684;
	Tue, 10 Mar 2026 03:49:33 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 12D1540678
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:32 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d744d9abdaso1683087a34.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110971;
 x=1773715771; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PACg1fq4LBA/D8nP2+UHC+fbOufmClSD8MasfVYRrs=;
 b=a2c934poJBlNJF84ehNTr+bWKYq0Tnnn7HhWNkMHwardOJki3ZEi+dSoMttk8lFL3Y
 WuIQuDi05srVdZRZo2Uge8nF1IiS9XVa4gTu8iF7OPM4Bg8N0P1cNnyd5SakMG9umLdD
 y4ZXiTQK38bJ8XIPOw7t45bpj9g7H2H0cmy2crE/ULqTtBUFlBnkVkssxAFYQX3T/ogC
 pTWDAXkCE41WYn211KuNAK1gXPonC562aie8kRccFrz6F8/yLLhMepNC8QEZVM2mpzep
 jLcOhcUYcmLoeJFPbOFUEoWpmuBLmv5GjWVIcsBIiyNxqG/9wfVxYANPDBuIDE0BVmgc
 SQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110971; x=1773715771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4PACg1fq4LBA/D8nP2+UHC+fbOufmClSD8MasfVYRrs=;
 b=aTuZyaD/ci1zxC496goC/0dtnNgtGNpDrqoqPYtLhFUQGBT3jeoWkdjjg71w9CUNwJ
 JQZz6Yi4Zf0bB6Ihd/o9jRzQUGM0LJDbdGKYnAvGK71lkInziW4UfTuGEYbgrKOc1BZk
 UF6EMHM8BAC4K9/ILE/PYbL90BSo2V4gviFqiKVIdQWcnQWGWrRs+po11tOa4BUfOGbH
 KkSca8mpJyWtkAjRbLHszXDn6Qsjvm0jCOk/jhcDqj1coVwDCrB9DviaXHHIb+Tv+wyf
 nLtbez9yTyLoX37V9rJOucQwMs5PZxETALvC7CfsnpwqlyIau2XFxynNJFRS1SDkjETS
 mG8A==
X-Gm-Message-State: AOJu0YxS/vHhWIBYxgxMCVXFrtp/nx2ldE2KvkmDydy5LApuF0QutHFn
 +yYusJX75WTBlp4W0o4SlizOEQbCJz+Q7IGJc4P0OPjWctz8qZo23+A+hgSIY2Zy/4K/PNmUC7Q
 9GZR1zCQ=
X-Gm-Gg: ATEYQzxUxmQCZBnjX57hRDhtHdGi/5xYHRQPzUW1GHjBWeaPOVestNXPZkA8R6aMuxF
 cKRRNsozgRIWTeZLJr5nLb9IycY6Bpc0SUAJLvQGZZzFs4rcNUwY4Zgb/UzQJQzKNmg0pmpu+e9
 S9QhQPjqRQ6PtlucKbjewzNo+8VB46X5kOg0Xw2Ah5mx9ow/BU7aKfwNx+kqcGwyhyWIcX+7rvR
 WTJsFvEOhQBe4TF77OUXAxq2ALKG+JlpJpo1EffszjWEIVebz+YpHVPd3yP/WvWnRuSYFHXBal1
 6lNSzJUmpDTKy8h3f87zUUyBBJMWsEJArqdBgBqWDu4V7q2/pfPfOIVCiaXDUpdJB9Zgnv3PwO8
 hGYKxh3ZPA4+XoWXr/tZ+eIGsgXPH5Uw0j7CXlsWWZaMGRMipXQAUAnq4QkVTL+U+JhB3nep7qe
 Bvn3y7mUBIjQ8wt7R3QPxUDPcVEminDL9r
X-Received: by 2002:a05:6830:40c7:b0:7c7:52e0:9f69 with SMTP id
 46e09a7af769-7d726fef7c6mr9066704a34.31.1773110971283; 
 Mon, 09 Mar 2026 19:49:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v19 02/25] net/pcap: fix build on Windows
Date: Mon,  9 Mar 2026 19:47:37 -0700
Message-ID: <20260310024925.476543-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

