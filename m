Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C246C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96C0B40A81;
	Sun,  2 Aug 2026 20:19:01 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 0ADCA4064E
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:53 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2809435a91.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694732;
 x=1786299532; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r+YtG5XVkCTRjn7ohWmfO2kpmE5Fm4Z0zHaY5u+6e0M=;
 b=Z/SW8IFxX4Rs+08l//mYf4pNreYj66gJ2sJYFWf7ofA4U6iaJ54rOxmhje4WUVk+1A
 nrLGfoIvRSWLKW9G64cLyPhtIf9ru+2CPkeFHC8yqYaVG6+qow09HIWN7S2MAqAnX99u
 jiJX5BJdX+aXrYVwkSlmtA+QsNgNT2xyV7K0eDusIvwgxAHnYoho4hG3EybWnApwnGsU
 D/XaUm1eE7fPsmsmVA6uOREYhSSYbe/ED3Ba6Y0msZbBZCa21ntKwlOyRdX74ALZDsPU
 ts1P9M9b8bItvqwnDyEt9OLVE5FXenxAiUYiGGNrNMGjlOGJJRAiuFcNe/0P+tDBgJIU
 JnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694732; x=1786299532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r+YtG5XVkCTRjn7ohWmfO2kpmE5Fm4Z0zHaY5u+6e0M=;
 b=osE2V6EsgSgXkLRB3Bgty3C8IfA8d3BWLqq8iwort3Oik1x48aglzfTmsRUTjW5MiA
 1PQM0HIXk1Pa2NilSPR1vqMNOA9rxK8APsckYsEQPeiAFZb3tM2pxbEN8UNHarMjmcJd
 p4+R4hmAzyR32VHUUkRnZo1vRnSDaqjTy6J+2bJGh5kJqKYMkDNkm8LBhb+KZ1WLDz7d
 QTAvylszMm1gPlpr+3OCAzA3jhk8tR5ZbZoXmwyb8w/1dSUWfr2LDoO9wsUMjRrCuqen
 VlBEjvCaq+lZGTqbA7k6FYahntqvEUytFfGOrUmyLCAYlvNar+5BeiWz4+5V3c9cEw7s
 jI7A==
X-Gm-Message-State: AOJu0Yx8qIxuP3Y/jU7R599eNd4k4D4ZLSBwE5e4IXzTjGr2SWbhLflu
 WrFIU7xqoh9eHytyG+12RayDH1qrPy6MUVSc6BRTF0KzWZGP4eNMw5V9bYjNjbLjibOPFD+Ynap
 L+Cm1
X-Gm-Gg: AR+sD12xoOcf0vjS2phc4wDL+b+9PLOwcF+zhytLcooi5JnlinKGf5kuIZZ9RZKW8N3
 LxhqZzJqVPUR/+wo3+Xx9AM6YwZYu2z+kLKsiOMlFDz4Hhd7dLrGNF0wiFPesfhj+2sQW89mIpl
 8ytCf8Np74+FyL3HDryd1+VcfdCL99/ljDSdLuEQnRnnx3RDfhW7XTgucRYL/vB2aewSJ9jAeVk
 AV5xb2OP2YDDwCXyuEscdUnLM3tAdToc8VLPh0nsc1wqsA3GgjgAngE7aCbNQHtN2gza3ZqqUwa
 kMH3XUI98y7Egn3z3EAglgppv/whYtnwsxE1XKjDxVboekMyjbTv5v29w6yjm9fQsBGdLI3/CZB
 P9xcB61LM9uZrtG2yHkRR/LRoJ0wIcUh+R6XSQ0LOOcjdmhU/GM2ZFbrV0eqhwHXcSqY7UtbebV
 gHtbb7jgDvR90OJSbJVpzXlc1ArV4yOFGp5x82nLWyN4j1Kr/Eq6JKYRe0O4NwIKqWcx2oxjKia
 sinisax8I/2gXIu48ZUj+QuBhc=
X-Received: by 2002:a17:90b:1b07:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-38fbc438047mr6437759a91.11.1785694732034; 
 Sun, 02 Aug 2026 11:18:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [RFC 13/21] net/rnp: include network headers
Date: Sun,  2 Aug 2026 11:15:18 -0700
Message-ID: <20260802181835.476887-14-stephen@networkplumber.org>
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

The driver was getting definition of standard network protocol
headers indirectly from rte_ethdev.h

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

