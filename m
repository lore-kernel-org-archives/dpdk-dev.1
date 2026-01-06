Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D98CEFCE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B454540DDE;
	Tue,  6 Jan 2026 19:33:19 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 8D25A400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:17 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-64ba74e6892so2081429a12.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724397;
 x=1768329197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=yL05QWJrHWTCwx+cwnqCGI8RNn+qAeKlJsEWOvFYuU2HFqpZncA1kFeBjVCd9ZN/Oa
 8Y9tNy4Qa5QHFN37OdQiI7tAefWXJKwDFp9s7eXwcMfabreWbT5rG6HuvEy1yoQmt0Cc
 mOnOH0FtUv4hoerM1w66R3lTIJEWso06iley/ggh9NfSFT55KD98nQtyh4n0O5xpdbd9
 FI5hgYFb9eexc1LqlCrIKeDXGwwypZqfAHCn8IKkQq4bNbCYxiPb95sq1rrfufkG+VrG
 MwAGnLLRFQNKCdKvGPx9VPm//XPdVtpB2W27+ySQ72bGd8gUlNq+5lzeStokmZvs0yfi
 q1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724397; x=1768329197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=NyzVlsdwyIekBFT6PY9zy2Lu1YD+lAB0unjmMLtml1Hkemt9Y/M2lnpOr/Os2Zaosa
 69eYQlqRK0XU37uAGKaSXrrfp/Yx9d2sY3lSs3DH5X4r6sz+/oYuZsLLHSS1h7GGQFYw
 poKMOcJl8ynRGVDC0Nok62obKmlyiYeYIPYTEnuj7crkXC+IRlTb7M3dPoVj1pSbEEZz
 sxfjZ+/J5godJ/WzRs4PZ361X7IT4I1HsyUZA/cRcj+x+1CrmYM+JSq1+aqP1Kk1A1/C
 7dYkW8R/RILt91kdTMyJ+RcHgAugTCen6+icSfuyEfCLHoXgs/oPfjA9jI0TiFxvixIr
 u8Kg==
X-Gm-Message-State: AOJu0Yw+w3u45Tpcel7KdzW6S5z90X8fznLVHgNjva9BsdMKdJhI1RDZ
 MwJL65fcAbE2F47blXLUpwK/U3zqFeWBIgUFeR1KbFjQ+iNl+pY+iKjIZvlatL4Lcez0AYrrNH8
 mswborjg=
X-Gm-Gg: AY/fxX5ETbQF8nUzpSEDn0CURnUE+HTo72RXf3TdqCWYn++s5N+9xemastLnDTIPlsP
 GN9/eEDHtyp7iPrzpdHQCImYmBEabP1psPqN/iiQDODfM8KPwd05hwOKg8FLDX7+evMYKNS1juZ
 gkH3T6C6UPePmJVptyWaoamd+zqhpWqm7IKbIV8C7jOcKbWihxw2oKHh9dCPJB7abBMBKc9n7kx
 5Us95XR3nu2xAwo0SsMj5PXhhObuX808Zz+PTnht69x66zV9IQ0M1o5iEnCjY6XgXaXiM6w8cpU
 NLkJrTkW+g2aOKoo9CB5+nlDA2s3L02Rr1W6XFur2eckxvWD3MkJtjKjKB9nlMLHXXm0qjprT2a
 7+wsFfZ0m1/abURQLEpAADP+8IUmMB2X9cmu7PFMTuub1tz4zyUDwAnkqsHb2BQMoqJD5+lbpKo
 TuM/EnY/9MPvrBl08z+mX2jsXqMCK1Xt4b0hMC+cXoWp973y1Xew==
X-Google-Smtp-Source: AGHT+IHpDQfcKWQ0vRjiQByT3WFha7FLRDdn+JDllwP2ual+dD6i6y/8u1jDZZxB3mDzFrF38M9mHw==
X-Received: by 2002:aa7:dac1:0:b0:64b:74fc:f3ae with SMTP id
 4fb4d7f45d1cf-65097dfbd97mr295a12.11.1767724396974; 
 Tue, 06 Jan 2026 10:33:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 01/12] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Tue,  6 Jan 2026 10:26:40 -0800
Message-ID: <20260106182823.192350-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

