Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEBBCD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1950B40262;
	Fri, 29 May 2026 17:46:57 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 60DC5400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:46:55 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304d8e3bb72so828318eec.1
 for <dev@dpdk.org>; Fri, 29 May 2026 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780069614;
 x=1780674414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JVhoeaXK/cztBJnj0unTXX+jm5t5xCMgJ809DJDvBcA=;
 b=N3PEFiik0RBGAs9sAc6XDaKXYiwwqlAjLVHxx2NftlRrFHdaQYdjtWp1XaSvk0bEOJ
 5uuYk6wYBqpEjSNtlTy91c2RmBmWG4MGj2jzmK45Q5/iNCUIhYsPaB9NGqh3sI6k/B9z
 tl62KBIbRzjc8pmlSosg27Ks+TisYr/Nnq39vpZ5OYim+Fa9MCAu8ynyAiXOGvwcMLo8
 wMmbjV+vBKs6xnMF6vNxzLU4uIYF9hnryTdZzzLXrhTHDcAOUCH6YV2cdjJoL49S+ZCs
 96UIrPtbL7EgRvqV9lNzU2KDCTYQ0MwgXf9zFiBh4Hg+nTYy+BwTSLXX8bJA+P4zj0GO
 JodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069614; x=1780674414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVhoeaXK/cztBJnj0unTXX+jm5t5xCMgJ809DJDvBcA=;
 b=l9/MscuZQaVL0rSM6HGM6YVklK1BZnkKG09oviqBdYq+aBcol9relIsRRZMlNpC3zk
 Mak9SxTvGbWKNdOGQPa+OtYijieOK0MgpAUtX0x0+wDl5HfGgEYRc/uZiUcogGMVqWq4
 LdVxtVU6yCZMaPcYVT534jURth2cKWQOjYTsRJIZrCBWahw3IVaV3yQlbQMdQ+TKR7pc
 WxSM3qNTm7nx4BXlNTAgoGQg2lvUMWeY+5cn5+cS0sNXjcP0ZMYhirNvgqjsQKaXFl1u
 1sJjhQgUvgRb1F7tkk8XmPV9wxKHJIvYmxm47dswN57ooj6t9anTIYB4Xczj5U/65kEm
 1Dgg==
X-Gm-Message-State: AOJu0Yz++2ym+lPhbik4QPY06gs7mMwa2vm3zVAR9v41hKNt0V3LIudZ
 WCUV468v7OcAWNWboAWVb/WgtZ2glKe/XF9Mmb/Sf6LuJPU6uaFnjcuJdoVuLMKw4qbh31cCfL2
 FW2Pb
X-Gm-Gg: Acq92OEOmyhZW50ui8oX8YhYh95Ts/rXlEJv+2emZBPEixrlFxcAvjOA+U5pI5FJrjm
 NcK8sH4IavYhFMQ64ww3BHKq0Vb9B3u83v5M50MxLtK90a+cxhO9/BBvRyqNVqs8Y3ahV2b63wu
 N/KZwkTEOXq3ValeArI2xGj3p0pPJINgB8bV9pGxbZsXGU44psMwqqRkbeUvkaspvTY0aHb85ys
 D4BO+2dmNWnrvJpXH1dCEa+vD1koCO/dsiXg3Znrmdm5j4LBd9+oKxavwOddurOWGV3gnHCqK/m
 WN5d5s31Gf6/4TduaXCUovOM/iROPgU5GnwWoz2zmPfF1fCx5wYcRHEGUBwAYaow7P3/mNgxPUK
 EQljAPsI9MgsG6OqN3Wpj+CBBIUjMVHeruGyYndBdt/ePjZkO6GN3dnHm0ZGClk6b+vZHfvYJjl
 xSbVPZapCcRbQ2GFpuulpC+BTUAVPSdo+TnrtTEIf7i0jgdAL3omUMMM5O+sw4m73s9/1iKg7A
X-Received: by 2002:a05:7301:1293:b0:304:d14b:b706 with SMTP id
 5a478bee46e88-304fa751469mr145807eec.27.1780069614145; 
 Fri, 29 May 2026 08:46:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm1653143eec.25.2026.05.29.08.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:46:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] app/test: use memcpy in ipsec test
Date: Fri, 29 May 2026 08:46:51 -0700
Message-ID: <20260529154651.128372-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This test has tables of data that get copied with rte_memcpy.
But when compiled without always inline the compiler gets confused
by the inlining of rte_memcpy and thinks that it is possible for AVX
code to reference past the input data.

Workaround is to use memcpy() which is better for this test anyway
since regular memcpy has more static checking from compiler and
analyzers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_ipsec.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/app/test/test_ipsec.c b/app/test/test_ipsec.c
index 139c1e8dec..b5a430996d 100644
--- a/app/test/test_ipsec.c
+++ b/app/test/test_ipsec.c
@@ -10,7 +10,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_cycles.h>
 #include <rte_bus_vdev.h>
 #include <rte_ip.h>
@@ -559,7 +558,7 @@ setup_test_string(struct rte_mempool *mpool, const char *string,
 			return NULL;
 		}
 		if (string != NULL)
-			rte_memcpy(dst, string, t_len);
+			memcpy(dst, string, t_len);
 		else
 			memset(dst, 0, t_len);
 	}
@@ -604,22 +603,22 @@ setup_test_string_tunneled(struct rte_mempool *mpool, const char *string,
 	/* copy outer IP and ESP header */
 	ipv4_outer.total_length = rte_cpu_to_be_16(t_len);
 	ipv4_outer.packet_id = rte_cpu_to_be_16(seq);
-	rte_memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));
+	memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));
 	dst += sizeof(ipv4_outer);
 	m->l3_len = sizeof(ipv4_outer);
-	rte_memcpy(dst, &esph, sizeof(esph));
+	memcpy(dst, &esph, sizeof(esph));
 	dst += sizeof(esph);
 
 	if (string != NULL) {
 		/* copy payload */
-		rte_memcpy(dst, string, len);
+		memcpy(dst, string, len);
 		dst += len;
 		/* copy pad bytes */
-		rte_memcpy(dst, esp_pad_bytes, RTE_MIN(padlen,
+		memcpy(dst, esp_pad_bytes, RTE_MIN(padlen,
 			sizeof(esp_pad_bytes)));
 		dst += padlen;
 		/* copy ESP tail header */
-		rte_memcpy(dst, &espt, sizeof(espt));
+		memcpy(dst, &espt, sizeof(espt));
 	} else
 		memset(dst, 0, t_len);
 
-- 
2.53.0

