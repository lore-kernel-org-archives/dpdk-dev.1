Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6562DC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A5A406BA;
	Sun,  2 Aug 2026 20:18:59 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 8BD2A40671
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:50 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so27135a91.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694730;
 x=1786299530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dI4k6+wtsW3WCDwnmEaPVMk2vMvSF1VtNWWq4tTKtKQ=;
 b=bMx9YeO0dLZmlKaG/+9otoTIefozXtM7d0pLbW7RHLly8SrNXpCrjkPN/QY5lTQbRx
 hk/MCA8fDDSW30VTQC0utDvLWfV+JFHXWzlES110B7jTI1xANe8YfEJfxg3vCW0sbo21
 Bpoz2yLpFKoBZvaVyKPXRDsY1otLE/E6YAE9OJBjwDqCqAhuak6qzwp5f6i9DeJrW3dI
 GtvpuaR4l3n6eGu7i7CbjG7LS3rKDDkVt45Lhmnis1iKWGf5lcS0QDr2pWs7NEG5VOjo
 jWw4EXbeZ74D4Fg6KraGHsy7UNrIUMGG3nw6HkNMdo0i8kaO7kSUFAzdHcZcHs/X3drR
 1uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694730; x=1786299530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dI4k6+wtsW3WCDwnmEaPVMk2vMvSF1VtNWWq4tTKtKQ=;
 b=tMuvZQR5VqhbYydlgAoq3MnT3vLU6VuIH8RIiXAF13r5s7Z/lmSZcq1bOVC/jDmQ1S
 fCc/k4OyeMJFyPnrpn1Ri3wMUe7Kii26zfQW0CItkygVl1nNFXdREDxWR54KWzhz736h
 Fp/MY5J1BdvsZ8lY6f26l4B8rkk6Oy6QqKjUHmjVcbdaCm5awcxyJtKnnj5gYAJ2+jZo
 Atg1iLUc7l9Qk4Y/fY+rl2fMGv5RO5tOACLCG2CbLcmXJoBMMfqwji9zttpS/1Uq3lIG
 UoeSv2QfqShgZWYB1bXp1WzMt/Hbe/hxjIfrAqE58+yPCkYlsyjtFJbaW7xu5zX2hqU2
 Ofbw==
X-Gm-Message-State: AOJu0YwDXcUGeuls2VUATQjcb1zCCPY2JSwxsHy9zuWbsIyQyrpgiGoC
 GaIiQINpi7Z60EDuBvfbeoUs2IKtdfoNt+epVQJNGofZBi3c0PmAJBVr8zUUwcKiMeD60mcwUUU
 3eLMu
X-Gm-Gg: AR+sD11a4iBRHCgKugUjfhYHpGIT8yEyLYgcksGGY6+o10K/IIegBf/kH1CHmQ0x8rO
 AP+NR6PT8csn3cV+Q4sFET7+hrbsSWut+lEJuvblBWxDif7YIJPzwWHmkhNkrY5P5Km0WQGx4Dl
 co3geuixs9vnq6IWUVN6NHEofpHj10d6dCaA3T6U7Q304b7sJI/2AcHKpvdwHLZy40tR5T5rmvW
 eUXkCxOkvG1MDcn3EBRu2xn/byyCq9QPK+Arh/8WvtZHerTPWqv8N+YxohEPwKTE1rpjN5Ga/vQ
 D1aW1DDerUsI4yoB1YCvXySCYH2Vupb70jL9vpZvKRfY7QW8yFemYKqtbzygEum2gv8SaBlsKLd
 0x6ViNqfRPif7mWxLMdh5CiYaeddis1Rx13PdRuovUQzteglJuxkijwAfJmZNtiQauGVW+suAL5
 vgVnaesKDoV3Ny1X89+4xZIKzymcbgehZXOcKYd3Xr6zBv/cdJb5mlzqpEg/7vYCmCOPjaXwio4
 kqThtyxa+9lKSm1PN2h1YKDqTI=
X-Received: by 2002:a17:90b:5605:b0:37f:9ce3:ca95 with SMTP id
 98e67ed59e1d1-38fbc560e9amr6515371a91.30.1785694729777; 
 Sun, 02 Aug 2026 11:18:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Akhil Goyal <gakhil@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [RFC 11/21] test: include headers directly
Date: Sun,  2 Aug 2026 11:15:16 -0700
Message-ID: <20260802181835.476887-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

The test code was getting network headers indirectly via inclusion
of rte_ethdev.h. This will change in future, instead get the
headers directly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/test_pipeline_common.h | 1 +
 app/test/test_bpf.c                      | 3 +++
 app/test/test_security_inline_macsec.c   | 2 ++
 app/test/test_security_inline_proto.c    | 1 +
 4 files changed, 7 insertions(+)

diff --git a/app/test-eventdev/test_pipeline_common.h b/app/test-eventdev/test_pipeline_common.h
index 61370fb799..e9f20e7f62 100644
--- a/app/test-eventdev/test_pipeline_common.h
+++ b/app/test-eventdev/test_pipeline_common.h
@@ -12,6 +12,7 @@
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
+#include <rte_ip.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_event_eth_tx_adapter.h>
 #include <rte_eventdev.h>
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..32389c803a 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -15,6 +15,9 @@
 #include <rte_random.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include "test.h"
 
diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_security_inline_macsec.c
index a929ff5326..43672ef237 100644
--- a/app/test/test_security_inline_macsec.c
+++ b/app/test/test_security_inline_macsec.c
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
 #include <rte_security.h>
+#include <rte_flow.h>
+#include <rte_macsec.h>
 
 #include "test.h"
 #include "test_security_inline_macsec_vectors.h"
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 0b1f7fbbab..99111e5432 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <rte_malloc.h>
 #include <rte_security.h>
 
-- 
2.53.0

