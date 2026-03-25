Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF1103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DCB840DCA;
	Wed, 25 Mar 2026 03:40:28 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id BFD3740DCA
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:24 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c1092cc08cso2271670eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406424;
 x=1775011224; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=h5uc8qEVHEsGzhPT8rj92S6ssppS3uX+uLPZFrteGnaBaQo881Nm1zKvgZdKWKNotV
 Jd0gg7jgHT2U+WWRCt2FvNSN7GcDnJeVLEwfkdwunVbG087E7ycB94h+bargYf/TLyhw
 U/bqaQJOdPHK5ZfSi4kkKAYAvN/rU31sNe3E8mjyvx/4C5W2sFseQos96pyORnjOyAtb
 Otr9EpApkv+OAcpIBUOUd4vrFexExDVfMCC1Pk1OoZlOa8EX7/O4Rc9vZ9JpqpMpz/nV
 4Oe4q4UJgcdMCuNFpb/KroPOxTYsToG7IaTWyqC2aiZtMLMdAGo5NKPz2euZK8rfbs3m
 T90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406424; x=1775011224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=OII2wo5SnohtOlHMhM67XrHFw0f0481mZGWk8/GavONcN4ucgNn1FR4HmuLxhZ1PMG
 DMW+TSOYCjp8qgR3DFQEI0FfOU2X8kr2TlFp9igaZdacKC5XU4GLE+c9rENflRFWIdk/
 /trk1enQFKrY/tR0wtV7ZsoOQnyHuBTi+G29Tc/0r3uPP8VE04YQNXb4b+RRV/SgslnJ
 cD0obVgPYqnDycAtw+e2a4HOqNhaZR4hjHQBJtuhFsFVbcHo/qFTA3oDvbB+kUZVw8Pa
 etL9Vxfi9Zm2Vh555KTWXGLI63op2xd3aZJWkdR5aRLO4C+vGO9NPK6OtxEjYEqYNFt1
 fZIg==
X-Gm-Message-State: AOJu0YxWgFsTTwutOpsOMOGy8iFF29dBRRUx904ICqVOUbej9GmTvvry
 TUVqlZXmXTSST9+r+y9x8QE0++TGwTvmzoX7dMBqEPKff6Z1jEyUYeGFOqKyRiuE033QjgXAPZ8
 DUiTU
X-Gm-Gg: ATEYQzwloRLms6nCRFK8NOh/TT06ObYHH7D/J6JMh46THdiS5z9uWFCMs8N5qyZJDTK
 8whljL2B95n+Y3DJdpp/cCwdG5+uTmyUCgNaG2gJkBbjymTj43UDFSWeDQ7wAI2B19OnliyA0K7
 ilP5eySsTXbOYS4hrY55e6vtcBYxQD837SrEnfT3mOBjgg4Au86dAbnhD5UcUHMRdPbWm8+oj6A
 5ANVDO8F8MAi0oF5KMNsFRQ09pZs+p0KrJL1iiHgZthJcu6ebKqmy89s+jnO24BXVuMf9Uspmys
 Z1M7jpKJVmgXJCt2BGwsvKIFHIbj/7C+KClPgZAJBcDny9Q26h90meFo0X/RXKwiUP6OLgNlWkJ
 sWRwVOJfMna4pdSocYX8Wg1Fqt0Xbf642JlFa3o8TrEsQPsc+4GJiEPdSPzd2WhW8t9gbVCvwBp
 6bm/373nbhtEFjpXYuZbUVNdx6gMgkgiLSSQXnGWYnhy8=
X-Received: by 2002:a05:7301:4e0b:b0:2bf:1eaf:995c with SMTP id
 5a478bee46e88-2c15d43cb01mr896231eec.17.1774406423617; 
 Tue, 24 Mar 2026 19:40:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v21 02/25] net/pcap: fix build on Windows
Date: Tue, 24 Mar 2026 19:37:33 -0700
Message-ID: <20260325024018.1275209-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

