Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFBBCD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:49:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0749C402D5;
	Thu,  4 Jun 2026 05:49:03 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id E97DA402BA
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:49:01 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso2595885e9.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780544941; x=1781149741; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsH2wxCMz5R1Hj7s2YPRWdVcMaSc/J91LyDsV3M7wYA=;
 b=BLvAXZgDjNR8NBedkLnc+WR8knqBELmQRyv2Wi4hZ2k7h2Lx9iFzHyViHWXxMLUF35
 8/8JMsZeJFxF1twa+d4zU0y3XG+J5gCgxL2mHX2D/0xHO8jS/m5Ewmlvbuk5iZ2D6Nqi
 fZbj/s8YnkujMnMcPKWJitOkgZK6THEDl+HQny0Pg6c4BgZf+pnUqXR5ZWUkRnmmjWxj
 BFfzrBMuv9POXml20NbD2CJsCraKZGSiDFGKoYU+ZEN2ddBbFlWDQpsqveKrp5zhwrp6
 spc+hAwj6IOdXcqM0xycPy0xpZbT8votIwo6eK1je9RwckjuYpYHbH84+s8gj1Zq6kcv
 UAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780544941; x=1781149741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsH2wxCMz5R1Hj7s2YPRWdVcMaSc/J91LyDsV3M7wYA=;
 b=nTGtzK47IpeYvQxZbHiBVxWyx0gWRmOEvhUy7phRAVg5drAtU13rRP3vZz5JjMjoel
 4+DbaiseHGT0/DFMV8WBtT79mqxXMUibyaznixsh+DvOmhpWc402YTofEIPBrRb9i8Y5
 xBFm3hzfnp0CGOFjGP03doz1CjWOO9JbSdr6rOqt6xJxyG9bctPRVV1Wx1Iq/Vca122l
 QpPzETqP4y4TqrbGaLJqwTRvsqh32ocYgOx3XrG+wGanAMlB0qdRNVdsyptJ4MOB5H9e
 KNyvdyXIjIsPsFC3Gk7YAtng6vcST6npaIip359xd8ca5WgJCmPNxpuJV54lAtwep69z
 U9sQ==
X-Gm-Message-State: AOJu0Yzqil+kpHuAmS17GVkduSA82Cuw/hv4ugiKtai2iuEpWpXz/HZ/
 MFhhHPEVEG6c/3Ba5Az37bflHJYBTHG+C8Zrr0TqBXkl1R//wuk3t/GOimn8VoSf
X-Gm-Gg: Acq92OHQJycsoDR5cc4Tw59IMzIj4mOD8ulvzbrspyvmKfQ8VKy2aX0ULLnH81lMZo4
 pPfrUY0TwPgRMFLhoHfzdlLIlILUd/FTgSUq+IU8Z51ujyM/YG7+79SMVxWOylWTP1dsWLGx/xA
 IIIpItG00zKoCOe6SpdQNB7me0LA/GJwaBvRQR5t2qtVPiBu/NEZCeMB9Tf6RjwqwmPR9E5gUb5
 RMCu1JZl5mUZB9HecFL1UgbvPdyW4uRmtrTJ0yF7eXAUFroVxtvhm5gN5RdjI+8KF9QEGZl5sMY
 0ZeJXbGL51+6mlrFG0s9tk78575OsvFVcoEuflXViIQq4Q5/nR3/MjbHnyJSKWwRbo0HpPYbhYQ
 Pxo7Q0HYx0A/tbhx13ALNgX9IQIGGRlb6Mau/AiBnWUno+zudqgySVIvGMOe8katpSWO/cFCIcI
 TK0zQnuw5kw8UfGwDtiIRhE6KhRLk8zfk/2tyRUULLOKt6MJxU45/JQS8d
X-Received: by 2002:a05:600c:c48e:b0:490:40f1:5314 with SMTP id
 5b1f17b1804b1-490b5eb73aamr88178455e9.1.1780544941363; 
 Wed, 03 Jun 2026 20:49:01 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3a87dasm36146805e9.7.2026.06.03.20.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:49:01 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stephen@networkplumber.org,
 Denis Sergeev <denserg.edu@gmail.com>, stable@dpdk.org
Subject: [PATCH v2] net/ark: use standard IPv4 address parser
Date: Thu,  4 Jun 2026 06:48:37 +0300
Message-ID: <20260604034837.250221-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603054742.120101-1-denserg.edu@gmail.com>
References: <20260603054742.120101-1-denserg.edu@gmail.com>
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

The IPv4 parsing helper used by pktgen and pktchkr read each octet with
"%u", which accepts values above 255 from the configuration file and
encodes them into unintended device register values.

Replace the hand-rolled parser in both modules with inet_pton(), which
validates the dotted-quad format and the octet range, and matches the
IPv4 parsing already used by other DPDK drivers. For valid input the
returned value is byte-order identical to the previous helper, so the
register contents are unchanged.

Fixes: 9c7188a68d7b ("net/ark: provide API for hardware modules pktchkr and pktgen")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
v2:
 - Replace the hand-rolled parser with inet_pton() in both modules
   instead of adding explicit octet range checks.

 drivers/net/ark/ark_pktchkr.c | 9 +++++----
 drivers/net/ark/ark_pktgen.c  | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ark/ark_pktchkr.c b/drivers/net/ark/ark_pktchkr.c
index e1f336c73c..67405ac18a 100644
--- a/drivers/net/ark/ark_pktchkr.c
+++ b/drivers/net/ark/ark_pktchkr.c
@@ -4,9 +4,11 @@
 
 #include <stdlib.h>
 #include <unistd.h>
+#include <arpa/inet.h>
 
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
+#include <rte_byteorder.h>
 
 #include "ark_pktchkr.h"
 #include "ark_logs.h"
@@ -374,12 +376,11 @@ static int32_t parse_ipv4_string(char const *ip_address);
 static int32_t
 parse_ipv4_string(char const *ip_address)
 {
-	unsigned int ip[4];
+	struct in_addr addr;
 
-	if (sscanf(ip_address, "%u.%u.%u.%u",
-		   &ip[0], &ip[1], &ip[2], &ip[3]) != 4)
+	if (inet_pton(AF_INET, ip_address, &addr) != 1)
 		return 0;
-	return ip[3] + ip[2] * 0x100 + ip[1] * 0x10000ul + ip[0] * 0x1000000ul;
+	return rte_be_to_cpu_32(addr.s_addr);
 }
 
 void
diff --git a/drivers/net/ark/ark_pktgen.c b/drivers/net/ark/ark_pktgen.c
index 69ff7072b2..05d5773d44 100644
--- a/drivers/net/ark/ark_pktgen.c
+++ b/drivers/net/ark/ark_pktgen.c
@@ -4,9 +4,11 @@
 
 #include <stdlib.h>
 #include <unistd.h>
+#include <arpa/inet.h>
 
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
+#include <rte_byteorder.h>
 #include <rte_thread.h>
 
 #include "ark_pktgen.h"
@@ -355,12 +357,11 @@ static int32_t parse_ipv4_string(char const *ip_address);
 static int32_t
 parse_ipv4_string(char const *ip_address)
 {
-	unsigned int ip[4];
+	struct in_addr addr;
 
-	if (sscanf(ip_address, "%u.%u.%u.%u",
-		   &ip[0], &ip[1], &ip[2], &ip[3]) != 4)
+	if (inet_pton(AF_INET, ip_address, &addr) != 1)
 		return 0;
-	return ip[3] + ip[2] * 0x100 + ip[1] * 0x10000ul + ip[0] * 0x1000000ul;
+	return rte_be_to_cpu_32(addr.s_addr);
 }
 
 static void
-- 
2.50.1

