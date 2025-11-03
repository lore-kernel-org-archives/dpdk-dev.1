Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B8FCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72AC840E39;
	Mon,  3 Nov 2025 17:50:05 +0100 (CET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6703940E15
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:00 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so1671897b3a.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188599;
 x=1762793399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKROHCMShd0ZvpI/xvgk7qQfwcFjOGYYUigrzpGergQ=;
 b=AnSJLsNAv/uC2WfY1Da/4F3OIPj5O/xhUUaZ8phnkburh1FWLOSMPYyxwNHeMT+UT3
 LBaNycuMYp+/+2YbcCUd+oRhag+0OlGKlY5FIZ1QFe2EcL5VA13BQlLp8F2n6nBW/HIg
 EJCBtpHBPRH6wlKrWV5eaxa2YcD0VF4Q784oegkf22+PEjw6XyGrcZIg+XBSQAUylP0j
 ELL7Xyezij2/afl7Ha5FvOaWnhIhxiu/h1w1ca8chixjHsjW4AAQaYbfJ7Np+sXHaewl
 H4d8lRaaa51+zghP5Y4WYC9trRpezX+62MG8coaaGeutF/MpLlRDce3IGTfFDpfFCq01
 agtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188599; x=1762793399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKROHCMShd0ZvpI/xvgk7qQfwcFjOGYYUigrzpGergQ=;
 b=QP+OR/Zean44y7xsIfgyxq7B8qynxiaYFF8jIO+x9pEcjGGRtTTY53brIDYYbQLm64
 Tr82mxU1UxOi5Po1pZaszTqiMEDyYC8o0LGlildtNPmSLNQpOfwFBVH99XqS+kTTLipQ
 X7XDLJ9txwAO2+5tRdGoBpC7CgfuQwzPpyYskBfAp40R8AjpRr334RwhFfpvy3vUqHRe
 PGZ6Ac5nEv6tkV4nipZIIRTghSPNoVKsVdwrmAlqhlSq40/HtiL25CR/bAVFLjyC0DcK
 hG6qxcckdcKQlZ/FZ9l8epl8o+W1jW8YlCwn+SvvNYb5jGD2bi3nyhNg7ro7dITmcsbQ
 Ivcg==
X-Gm-Message-State: AOJu0Ywwsgc+AtXkFw12l+aM4a6ZclhRJ6HgdPiyKpOyrVcwkzVWFNNc
 zWWXx63rP/cFOgO4f63tUi4bhhLUp58JT/13dD14XAyb5pHSPGrMAdwky9On9NB9gbxWBbLsXqj
 qlolD
X-Gm-Gg: ASbGncuPW+JLlxE3SeDt+Rf6cyQkmlIfCs3UdknzA3ORhVy3+dv4DidqAmCkRnAajA4
 i21ZEUYpSE8/xJY1ftwGOKbT/R2KBxMrquuMijmvJyP8d5QHyX0cEbAkkVBqT0CdpsDpbrplM8L
 GMrR1HM60azP7aS//mhJ7i1zUcL3X/6ui6K35fXndmZAXQv7QCLhduJu0bmEu5gaL8rScEhvjkF
 fkzmhLqpOqd+IZfKUcMg4Tplt5g5duCF3YyLl/a7FjUoItF4P6jsRB7aVrzb+hHeUSUteWw/ZuT
 DQXFB8xBkT4O3T8YarNfSU1LazcWjSxrphTO7A3p6n2vsicIMjxRIPM5lAFsNJBPJifVxScFH36
 3H4cU8ns3+PIjcBdXACA7CuTGYscw/npmJupVcTU52R/q0S9nBB7QnmzfyV3XJoN+dtBg5Bf8+Z
 lIiUwALMDYJM+IRaAI03zLh9pmNSUbAmemZUZtCIuE18NuVlXcFw==
X-Google-Smtp-Source: AGHT+IGnHCMgzUpLxOMrQ8GQfs4em8bH5HY6fzj/q78VZ2221Wlk1qbV0gbJtcsYNeG/nHftwgk6XA==
X-Received: by 2002:a17:90b:2b50:b0:32b:9506:1780 with SMTP id
 98e67ed59e1d1-34082fd996bmr14374975a91.9.1762188599604; 
 Mon, 03 Nov 2025 08:49:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v3 31/44] net/thunderx: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:36 -0800
Message-ID: <20251103164915.101713-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_bsvf.h | 2 +-
 drivers/net/thunderx/base/nicvf_plat.h | 1 +
 drivers/net/thunderx/nicvf_ethdev.c    | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_bsvf.h b/drivers/net/thunderx/base/nicvf_bsvf.h
index 4c7615ca99..74019818e3 100644
--- a/drivers/net/thunderx/base/nicvf_bsvf.h
+++ b/drivers/net/thunderx/base/nicvf_bsvf.h
@@ -5,7 +5,7 @@
 #ifndef __THUNDERX_NICVF_BSVF_H__
 #define __THUNDERX_NICVF_BSVF_H__
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 struct nicvf;
 
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 8421f57040..ccc6aef0fc 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -6,6 +6,7 @@
 #define _THUNDERX_NICVF_H
 
 /* Platform/OS/arch specific abstractions */
+#include <rte_bsd_queue.h>
 
 /* log */
 #include <rte_log.h>
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 76ed76a045..d3457aa1bc 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -12,7 +12,6 @@
 #include <stdarg.h>
 #include <inttypes.h>
 #include <netinet/in.h>
-#include <sys/queue.h>
 
 #include <rte_alarm.h>
 #include <rte_branch_prediction.h>
-- 
2.51.0

