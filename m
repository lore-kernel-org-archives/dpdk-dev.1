Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D6D232C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 859D04067D;
	Fri,  9 Jan 2026 02:18:04 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 78A7040281
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:02 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b736d883ac4so704581966b.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921482;
 x=1768526282; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=tkFVZUF1f0f5O4L/VgIoeHZT2afzIe5ZxhkKCIAnVIts4U4lQi5n39v1Pr4U0by19Y
 hJFtZzSgudLHQbAP4Rd/Y6d2IfBp2MGoeOAiA/0D3KF5f7mvoHKFcYZFu8qEmweDmfts
 k6k+CA4kudRbVF2djbdQLlDBZEyGC6H2Ey0bKrhtITl3Uy6UDK4j8CIvfUFLtzo8jakg
 AbrvKJeaYriwrpltk1PfAtCf0Bk1WroyMLXkHIw+NHGS5sKbqkr7Y1YSkqRYRGNlL1GL
 WVdtRpJMF2ovW01TysIcdzxnxcZsgnjW3uMl1hwmSGeI4Vc/eWOPd+VSJjcHXfbkJRCI
 HW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921482; x=1768526282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=BCBQtLkLt2kn4M492ysUMPwnCd27Vk0WrmxxwlQy3FJlMdLBkgr9WoiSLcey2+Yu4o
 t6RiHG1h7hcDx4Hw3uypr6g5AHyTeNKmBeRVdGhmqsebcSvIvNQHZqPIe96wlev+G90/
 6z3+Y8zQtu0MDmjOUIAxLqweqcTvwZaEaGQlZJw1MhSXZQiq5eVGWAundmj0CeCs0sMm
 28liwvqLFn3Qmjkydkio/DBTNkuJVXeDlnI8x6Mmi75lLV1WeEGjjWQCEvOHH2qGFD+c
 klEUJq8MyWhf7yZkCenDEtV/wM1M0o12iYxjFQpt0W5se7cfmHHW0VvDRQdjC5mRXILI
 Je3g==
X-Gm-Message-State: AOJu0YzgfBj3wqy4GLblrd1vurB2f8P4SFKt3Dv1OUhsjeM8U9aaL1OH
 AISFEETAYlR4jwOhUFADOVGyA2KTvOir4agYD+DWwj4Fd5C63v5HPgc9fYRNPL9MjVOifTMdblx
 nfmpw
X-Gm-Gg: AY/fxX4jm4IaUM9AxkQHhzdQ5x8S5e3Rr/mFxot9lPhMYkdBCJHS2MLBj7XiAaF4NZP
 AKSXJpMYPrhyfVByK/N+GTg8twLP2Ms2TXyY7B2+F8AiBbOd6zieHsOENEDe2N0vIQcIMh0IKWV
 nHrKAbm74+1zrAUioyJzneutYN0EdFdNeVnIAH35TMJeIeZX6nkhJI/YuLlqxceRikk/0H/teK0
 Csx6Pz6bbshjduqiKm9KvYMVFPJZo6vCwDoEEq9L3nDTcGlVTDdZaaozMRCNZOw/fFmsWvSfQVL
 cQ4EAkrQY4fGSVtJIGu1WqZQvgVLRdUDAlpzaHd2siWuu54bRG2YsCRCKdIPk4qD4hr6bG9Wdoo
 EadPj1fHlEYhNblCaWWdoDKpgNHQ3xzWfQBEfgnYctMFaRrimpFQLzwh3hQEIzyC60QWQLxtx0z
 ctrcynOPq5lOUVaeupFziSRzx9cu29ns9IGErd2U667i3xyDr+Qw==
X-Google-Smtp-Source: AGHT+IGRRCvC6egMZP0XiNX4VCLo5SJZ5rkvby7e02vC5hQlX5LENPRF64/dnoVG9KAOJhbbQsKuUw==
X-Received: by 2002:a17:907:9701:b0:b80:3fff:32ea with SMTP id
 a640c23a62f3a-b8445034cd3mr811867466b.57.1767921481609; 
 Thu, 08 Jan 2026 17:18:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/9] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Thu,  8 Jan 2026 17:16:18 -0800
Message-ID: <20260109011755.362857-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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

No need to use rte_malloc or rte_memcpy in the short
code to get MAC address.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_osdep_freebsd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 20556b3e92..32e4a2bee7 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -8,9 +8,6 @@
 #include <net/if_dl.h>
 #include <sys/sysctl.h>
 
-#include <rte_malloc.h>
-#include <rte_memcpy.h>
-
 #include "pcap_osdep.h"
 
 int
@@ -41,19 +38,19 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	if (len == 0)
 		return -1;
 
-	buf = rte_malloc(NULL, len, 0);
+	buf = malloc(len);
 	if (!buf)
 		return -1;
 
 	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
-		rte_free(buf);
+		free(buf);
 		return -1;
 	}
 	ifm = (struct if_msghdr *)buf;
 	sdl = (struct sockaddr_dl *)(ifm + 1);
 
-	rte_memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
+	memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
 
-	rte_free(buf);
+	free(buf);
 	return 0;
 }
-- 
2.51.0

