Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F40FD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86BE440DD3;
	Sun,  1 Mar 2026 03:07:39 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8E838402DC
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:37 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8c70b5594f4so352846785a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330857;
 x=1772935657; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zd5JhqEBY/oYBmtSYSckcZFdeTIUTIZyC5Mb+Ypf6X4=;
 b=b4691Z6EhMTgXTtlzvqgSJSkqTvboLPj+/qm+jmTWqh/qJyngSRIrxF+qoBU6x7v5h
 4BiERWAHNxYj6mhEM26IFxep2+hKX+H4EpzyJFxH/ZD9IPSdQMZXNp4C3BR+Re8BufED
 MzG05MpPlvXrjjSewDfXOB4lQ6gtokCrkkW3XDO26hqrrIWz2m9vKceFZrmLkTGDPxYc
 q3mYV3PKN2GOpfUFsD6LOYrtLGAHEVDQW1GceVB2UzaTuJ0rJKeq/VS8lA02LYQkqElA
 cpo9I8JRxxDm2RYEGPAh2ZbplBCb30PaetgF4Tl+glw/OhjO0LRnnbUle+W4QkKOoh5a
 6jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330857; x=1772935657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zd5JhqEBY/oYBmtSYSckcZFdeTIUTIZyC5Mb+Ypf6X4=;
 b=b2/RcRtrmxePom5pVC2aN+IGGQFeQC64lQ8wXzh0GJwFGbAGd2+UoC1fgchcQlb4FR
 Fggr9GVtzgN/ncbJigOOtMQQ4aM4nF2YGLdIABqvTcl3IDx7yWrgC7C3C4mW00gQVDfS
 Rl2xOHDpy7MDOiKaswTrmgxbPj1kd2v3c3/5+2lFlurGizmY2xKv4H5JG+TgjTxOtbwP
 kNNbfmOTjfJr5CDATi8GfblkUkB6Jzv6xvHtyer1e2bnsTZM5zLJqlc1T/ZMuhkDL/9s
 M2mEavAnwKQnWqEci3ARZ2HAyS6mqrsHi9DlZQdSv+rVVzGUWXYJ6tqBDp2RE6ckiMYv
 N1oQ==
X-Gm-Message-State: AOJu0YyMPn+WSOOKc3JYm/8A60VQ4BUxY6V60n3u4cfmK5ald1YewVKw
 nKq8GNj5xVgkuGTxHZgzT7XYR/Zix4isb3ndjd2APKR1j9SVgQc6kZFRsYaeqtltunlEc80DE/f
 Yr9zN
X-Gm-Gg: ATEYQzyecybpCT8nWFTyBby9WSLsC5p53o4gXsqOGMYFtbts70hTsB15R08I5YDSRlc
 3Qbh8XtQkLLGTiNwEZLPi9NtUFRNqW/KW+oejprtvFilvaWp0+iXrAtQKMZq1i1rykN4pGsRo62
 PPN14q9gh0qq6No9gg9MC4I4lhDwGKcJS+wWAPK7akCPFVOEbeYHrDV7glXo9xUrJ81JelqSBL6
 TlnJAPo51kobMnRQjtDWgWI2TT8Ea64hBUk/ag73MOT4OgdkMO7t2bopzQuYYvo6I/u8baWzqpr
 fDZN1ko/ptfj7QtZiNvY/hrFOHMqrSO8QyCtOHz1KiRBCE1c9gPYyzaF2iwnQKDHFbRKKch//FF
 IgIgLRSBVyOp8fMmbIV8pnKdQDG4XHoCGcUYzTalGHIJPvnJy1t0bgyCOjYBZbH9M6FtC/PkaCJ
 Buk5NkAPRMYikneic0bo/305wzv5PfHgzL2q9R8rObAe2HYWBIErL1Reyj0FMASQ==
X-Received: by 2002:a05:620a:294b:b0:8c6:c983:dddb with SMTP id
 af79cd13be357-8cbbf28a35dmr1303213685a.0.1772330856712; 
 Sat, 28 Feb 2026 18:07:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v18 02/23] net/pcap: fix build on Windows
Date: Sat, 28 Feb 2026 18:05:35 -0800
Message-ID: <20260301020726.852401-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

