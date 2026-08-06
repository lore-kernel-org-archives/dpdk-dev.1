Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C39C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4B2B40DCB;
	Thu,  6 Aug 2026 07:10:31 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id E111740B91
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:29 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1615708a91.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993029;
 x=1786597829; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AkYhr420gxwAQX6GL4wM1Mr8ENMfHgQxjhJfPIEae0=;
 b=nV4/I397flenFO178lu6OXv/Z5nd715cEMF3w9927950TpU+RSr38lIgQh6NxOjXjp
 NNYT+15Z7viDNHOzCObqfLbc1Rk2lElSQhA0ha102yCaT7RbsccUrtM/lVoCY0HXOBhL
 5dW18eyLORSfqWmTGbZvSQJjsTahDlx11hDo8rr9M9NvYc+oZe+NbptdFegTNNqceJsp
 5iooL6yCicPlgU81ETxll+gqpMycQQNhq4MVNDXMLuYBbTVk3InmbSePBi1i5IuiNzC9
 QrMi63PLHY+kTCUYfk0g0zzNFfGwUM7pJQLlR8v4/Ah58etqbmFkkRDBRRqLtoLjBCrJ
 b6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993029; x=1786597829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9AkYhr420gxwAQX6GL4wM1Mr8ENMfHgQxjhJfPIEae0=;
 b=r1ky7wj9oMXPRMC/zlAyIMriDrV/JRJiHVmEf/Sbf+EXBJSDRY+QerUPAys0y2Hy29
 hYJwuO+2PeLyqBFRnyTlD8pDzzUPidQLL6GRzjgUPHgUBAb9ECIOZ+mgvoAKQkX6OLCB
 qZFXUOvAQFM5pxRu0hpBpBNT8t7tCEMSpEGtj3PYC7x+wz2q5GlC55v0kBF+hL3BIaAL
 CC+ufyYz0QPK7UUHF8cMgjTjJQDaLcgK5hKGGX7+upGaaqDQGl5Yj126qx67y5eLHZaE
 d1dRBEOYJFcOTeGStUON9ruqr5oCxKO1CIa1cFRlzgMO3Gp/URJgbRcQ1RlMZll2j/0E
 tKmw==
X-Gm-Message-State: AOJu0Yz2ZDE0RKNnAGWHiydLezgVpFbZYXMmgW16uwKP5TK8d++uC176
 fA4qSR1BEpJOEGqGtLP+VtpGgSpRq5NvQNLWR71ZLuvH+33sdWdk6xlNY9ef9ZHrsLvZmw6k8rc
 EAuOMdvI=
X-Gm-Gg: AR+sD13oHnxG3FpsOMqnQGfxu7qsfxvj2VXfsaZgIyW9ocFuihzaBKivwd44TZ1NPmU
 Zgr3YcjP40qfJsxDjjaHDWEjRUKKJitVn5H6FD5XcV41gQJqkKOYYnGWlM0Lea17TatLJR6jp+q
 chMAuuCAYBYtg6urrX5/okkjrNEQCqq4Xo7AHVONDnb6EjY5hL1Oczm/XLTJqcZ+DwXE1PeFdmL
 GvlmgTVJMy1VHrx3u7MyOUWnu7lvWMA29g5MIuqvyAhUKEi7MgXlUIUciLkS/RHR4YU1ZSTzLgS
 6g6qSGRA+feylrB6RYN3LASqk5lZ7fwH0yzhdu3HgDfifPoUrZ3HnG0rlt0DW6bHwDSpbe8/Qpc
 +TRfoXB++ZCIf3BRM/EXHCMVAxccnlVZAVeU3qWvZh4owp6ISRTfbMzXuXXqyzmActxb9CzTW5L
 D9XTQW3l7C22d2Jzz6BykHZJKerG/FxSQezP73/GN94FZQmuCv9Rb3hXiz/9cLkPurbgfGAd4AX
 aJHQmOiLsJobxC77vTXS3+uNs4=
X-Received: by 2002:a05:6a20:4309:b0:3c3:954d:278d with SMTP id
 adf61e73a8af0-3cb85df09e3mr13929880637.9.1785993029086; 
 Wed, 05 Aug 2026 22:10:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v4 14/23] net/rnp: include network headers
Date: Wed,  5 Aug 2026 22:09:08 -0700
Message-ID: <20260806051004.166778-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

The driver was getting definition of standard network protocol
headers indirectly from rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/rnp_rxtx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 81e8c6ba44..93a3372e5a 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -8,6 +8,12 @@
 #include <rte_memzone.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
+#include <rte_vxlan.h>
+#include <rte_ip.h>
+#include <rte_gre.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "base/rnp_bdq_if.h"
 #include "base/rnp_dma_regs.h"
-- 
2.53.0

