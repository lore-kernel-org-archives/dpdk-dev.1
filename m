Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E195C55838
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB9A040B9D;
	Tue,  4 Aug 2026 17:46:14 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id C145440A77
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:12 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so53943435ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858372;
 x=1786463172; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AkYhr420gxwAQX6GL4wM1Mr8ENMfHgQxjhJfPIEae0=;
 b=Lp9oVreDTMunrk/wqlccsLULJVBU6dvpOONNTd9pXxwHwK21xlLzqX3TLrjrqs1vHD
 mlhbOqQzkFfD6FeHG7/x2ESCR8CSOyVXff4/N0UTsVSv4TsrHpBCGu+fwbnsCKeF+o0A
 lfPcWyAXem7JmTLLkPZFVrUcchhrqUq6MbCqqFilRzxUTR1Te7OoXiMiCWvOFoF8zXBt
 D3PLkG571qegpdQp2ErAiTZxs8EohTU42W1Hf2uawauQ8q0yzpCV/PkUU0LWC4bXK2d6
 78nXPPn5uXnuBdbpTAU0IImvT9WkpMXFqDvTU7FPOmY9qDn2SQP4ZIVBk9pe2OFo8apK
 7ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858372; x=1786463172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9AkYhr420gxwAQX6GL4wM1Mr8ENMfHgQxjhJfPIEae0=;
 b=SkOvc+rTevha4hGz7kFCNDepYySmKSiTTsPoSnkpl2ELucX4es4/VCbyVb5JzXFC3r
 fn1PhjF6MnaN3btuTznWfDJvCIYWGDyEcDBsuH7kyNaScEUc1Ju4QWvawQ2DwqyCmag4
 UmKwEcD7oBZWnMWtFbucVRLXsxNU/UpCX77a01Mj4cMkHZOBlQn7Wzlkp+55Hc8hHiYP
 PnBPjTZMV5LajIcrT7F6KaS8kRoWWDHhiCASIexmwzHGPjdQBHyQFrywawo3BkIyKCCv
 J67VEAvO3p8mN/ucEMafFfI/yDzVEsB7nGfLI9gdPfxjAoyeaz/65hlZyGu5UGTclU1a
 OdWQ==
X-Gm-Message-State: AOJu0YyiQRD+5/rMJpGlizMkpTkugoVuWSFBxtoE/CGGtqkmU7om8T0m
 021RYWOHX1lHZHOh8tSMVF2CGKstWvVkQkmiK8hTQoQF6CL7OIeo4Rm8eVypKUWCdGy+V00nXSi
 ql8gs
X-Gm-Gg: AR+sD11ZWfRXE7T82jpRJ+Asf7tdkRPzpNY2cP2ufxKat8AgFyBlq4Ng+HdbcxcUFq2
 JXb5LRneUERApOnsOhiZbHVy2SzaNLUXBHAKteCo3VXXb71udXNYMVPykaxND8IrmAOO5pGRg6/
 O9YKPAGkaghUHAr7+Ezkm5+zLn1I3DGNAuOErnqHgQk9BbaPjMx8NRN8apR9UR5wlrOVJcACOQ9
 hU53E9iyqblp1kqQAz0kqNqVogoEcTsWrJED01yR2LFHznMJLhHF6ig3u9uxIBqseqDN0kRJHsc
 IsolCkvIWw9fDAfxg98jUdhfbKEAfToHutytFqEIdYt+VefgR1hf+iKEiauClhooe+BScovKe3J
 hLyNHEZyTQAwYRq6kNadhlfXVyRZIEOd9pWaWQBroaLa/iSc+mqZS2pAo9109nMUylCj1t7fugx
 DvL3ftdrHxF21fDNYTjJIOodKPnUSuDGxVUERdcHfZDLHaerev2YwCFWlkzce3Sxzgwng8cmo+X
 5L2emsCRpDex/SYItrpIEn0mVg=
X-Received: by 2002:a17:902:ea05:b0:2cf:4504:feb5 with SMTP id
 d9443c01a7336-2d05229b35amr137288305ad.31.1785858371961; 
 Tue, 04 Aug 2026 08:46:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v3 14/23] net/rnp: include network headers
Date: Tue,  4 Aug 2026 08:45:02 -0700
Message-ID: <20260804154549.148691-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

