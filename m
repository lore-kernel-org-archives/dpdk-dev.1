Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C0F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2A5A4065A;
	Wed, 15 Apr 2026 16:48:14 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mails.dpdk.org (Postfix) with ESMTP id 485BF40658
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:11 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-47018d34159so4995251b6e.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264490;
 x=1776869290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=bW4Tw44rLNK7MGcw6xXwOfCcKCeW678fQNw2+wbgyoHdauJL5w6NGYtJhJWVI2sJ2b
 BC/NjqMr7DBn7cUcK0G02PBG1c8N7+5hQ3sQa10kmN1A0NJ76gDztOEeNX/nKI89N/pl
 Dx+F8VfSNMpAppo0yZRqNkZ/0I93y+3BZ8pOWHnPB05luqG7ap7O0qJHXtiBZE/Gn8fL
 DFNLi6ZGKiIdsyt0TPPdrfraN6qBccztYZsKRVv9+9s42SyhJIBhE0x74X6gl3rAsMSW
 j6dB7zIWDKsuT0G/QUqvuEofZHstNT8onqd10XW5WnhkPcokkJU71ofSOsTDxEihn2sU
 icBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264490; x=1776869290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+g3M8JUHPzbXrTMsGrSCsacJ+kXkE+jTUGXNaJTKQ4=;
 b=LnY9l6TAkm7oAQsBYaL1BKlwLHJLK7MOw1Frfr98xqSo0KO8bp2KEyaiyEhtukjoXN
 vWo73fOLHI1R/MPirYQ7QfEL2udHfoBopF9D6MqZYSB/LPh7aTrxG1iK5Wwe8BQ1T1cr
 sWHUxrxSKbcvButgEQQdZTYKZVgwqtIdp+gSD5Xksd95iUvSzcs10UIOnbfT8y/qdVGy
 NV4vBaypdMB38uR1QeKHNn4+CDfeXZTRf4V9DSYZfMOf5YpNZ9NdCGXskNxVr3123YIY
 53NZyU2ZBFDgvdB5FlaiIeYeuyNUOAFxFmH1C5AGfj0SnuuWRf//t0muFFdcIkz3zWUY
 74qA==
X-Gm-Message-State: AOJu0YzrWaX4xX4DINkIalnhKEfmg9C3OMVeFWYsHSIiMAjzKVMB8ujB
 N1LTy2dW7bUSc16WIT/L3k7jIu9vnoycIex6aizrtB/ai0vqtABR6lKG4DvTaA7GlG4hYYk3Tcf
 uJD/I
X-Gm-Gg: AeBDietBnq1A6RvK653qdRt3+sCODUXferkIaXAN9n3Q6gaO/mfan0CY0nZizhPAoo8
 7/1ZYIHRQmUi5GuJvGdTy1OTIBhthmPhbIQvo29C3dLWA3pjT4y04wcN3kXYbZ+ByrE03IX0i5h
 PwAej4EcDYDG4THiAasPedn0wjV4L3QSJdylrVoetAemb8pjVR4FZkiUEzOFCvicYRNk0vRKbGY
 h6Rp+8iiM5kTfcgolbe4/g6yDLXzORDCnzkVCq3moaOiZ6E5WA7TF7eqDUrBHCgqWa7nWhoasII
 jrWO0VXPw8kXvUMj3LB8H2n7Iul+AfjFzliwZrPMEoviGsPf5Mv0qPxY7mEtuHKbhH8SjvQHTo+
 Sisa/QoxMs1Rd6zqonGKJrNzhg0Uqzerdt+7SzAwxIH3mWdvVyXqSTNjK15FsOpL4YIu1dHYKOR
 T2KVU7yprjUd112C5KsfMyObDv6ouQ2FTn5N0hLEfpka4=
X-Received: by 2002:a05:6808:1993:b0:450:bcc7:18d7 with SMTP id
 5614622812f47-4789c847e64mr13147165b6e.2.1776264490431; 
 Wed, 15 Apr 2026 07:48:10 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v23 02/24] net/pcap: fix build on Windows
Date: Wed, 15 Apr 2026 07:45:51 -0700
Message-ID: <20260415144717.226161-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

