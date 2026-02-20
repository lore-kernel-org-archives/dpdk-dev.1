Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B68C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C458B40608;
	Fri, 20 Feb 2026 06:48:42 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id C1C8C40395
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:40 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8954ae375efso23410716d6.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566520;
 x=1772171320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zd5JhqEBY/oYBmtSYSckcZFdeTIUTIZyC5Mb+Ypf6X4=;
 b=Ic4dasQ0rInwbcUr8fbfSoKPcp/zPOubVZIOGYycJtg7aNV9DuVFABWI0lEw3jT6ql
 y4NJFN5ZrAF9M+k7UAF0apltKz9aD/qPA8Vnfxa2ZE9dR0oeVH8f9O/Xii4A2xJRDnb9
 F1BhKffW8IA5ApPoxLx3IBKRebmC26yTaAU36xHnP+FRuS/NBKhG+WsBN8yUPpKuX/Pg
 eqSm+fbXc523VkeFXmGbQpHhSLQREqm8MKNmVHlmjr2q9oABpOLrMb6/RE/KXm1FFNkP
 sCjLXQasBZ1D6B2fqgFjLr04gz5UW3iEHSS7KaPEYviWA3Mtfkb5vqsSoNzlpCKUWwOi
 y8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566520; x=1772171320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zd5JhqEBY/oYBmtSYSckcZFdeTIUTIZyC5Mb+Ypf6X4=;
 b=OdYdC9sALF2hRtCt++lJflaCl8vyd2MLZWMj7N9KgrEOYUuPUotKS9y7W9DUx+/lvN
 N+8CoMwiOOT7SmhJ57ZepHpmxPDtpnvv38r6JyTc4F8ac4mXc0b4bgEfnoSLaKxDms41
 i8ULktFHH2hOkMggYpqmMCH08ewCEtcDZHNdNePU/lI5jTr5oEiGEZxDXU1UNRcYzC9D
 pCOrasedo8RuR1rPNItj9rT/E4/SbqGn50/UcIrkulUZcEHiwmaV1RPFQS6vPaTdZ8PM
 amQIfxkoelGfGrVroveUocXl2noPib0kVHjlJk9M7YxlgkJN6CavYCLUZJ5twKA8p9Kl
 /+5g==
X-Gm-Message-State: AOJu0YzUghghFTMoXK06dQzO1N/vFcplr24OxUQ+jhmuTZ+EpDkVhWgP
 HS/al2z4Q4VFnBRilvOtYMJ0bgWB8r0FIuyweaHSsti0QaXN0iVB/6UofeQY2IswDNQTTmBanjo
 jO3w3
X-Gm-Gg: AZuq6aIT4NdCrMvH8URktfkQdgaiLz/LELcexraPWdom6xQnpD29E6k80bV8Trlr77g
 XSxQ+/4qFUSdCUl3217wte9VnY1GD4McqPtayWfBznCcnMwWJfm/76bwDORl9hb4kbBIsGSnoTC
 Ofz46uyVWoGwufXNGBeEYbBwXhscKfDM2ju9bMbIOlK/xQcFIpUnwGnQO0NqzmlJKUC28EZXU8T
 kjnB7IdAVtIc6qt/x3HBVZHYlmxXYP2qHhX96vCw9pt8IwgTh5bauIR1tcNiN+mdgdOdiL5Ggh3
 eXHAfmSJxX+IashB6YmU2fv0KdZyP05ktk+yDQ3WkgIkO0+LR59nZ1s0x7YA8WRGFBokk6sgpF7
 TaKn7HjWYmI+aSIUrhl5eKbYpsDBdUj2IOjZXM0oKiLu5n6Fcjwv/DekXoibi/pzLlJ+gh8t61c
 Mz5PRlrsei6IrBWF9EwSfAfHL3W6zPE2RryEhD+7+iQb3SIBfUEO+B3LD+mQm5eQ==
X-Received: by 2002:ad4:5c8e:0:b0:896:f589:cd7 with SMTP id
 6a1803df08f44-89965acde4dmr55676106d6.6.1771566520112; 
 Thu, 19 Feb 2026 21:48:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v17 02/23] net/pcap: fix build on Windows
Date: Thu, 19 Feb 2026 21:45:37 -0800
Message-ID: <20260220054834.1632201-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

