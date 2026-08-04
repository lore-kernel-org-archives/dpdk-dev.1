Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2366C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06A8F40DF5;
	Tue,  4 Aug 2026 17:46:18 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 7A99B40DD0
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:16 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d01663d816so38084305ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858376;
 x=1786463176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lapvp/IodBZRVG3QgR46Yu+3jZQ1Mm2TKg938FLk6VM=;
 b=Q1XMCdi4DUBe4IWgdKiU+grXAG+kum63x0r2EQOZRWOqF+fqxh3j8cYE3VAkvpaTyv
 +ptI2Zcr13DHjL2n24/2JQdxwOA+59y3sHMKCE0bOBNIbqVkyEowFl/QQhfTc+ieLNC/
 HSC2jMcRaOP1ruAw5eMU8eiQRBErBqFwjaRoCIaEeAL9sf0WeUMPPBnpFS+lCHuOLINi
 hTgyNYYoE1joVcmXK7TDprfNsJsA1QMR5iKdKj/a9b+mQUaxIUsFDtmISV4QYHCYuCzK
 Jj8PScGIQC/z/visqccb4kAmpxrjh3zgPJ++1F2qfqIhWXp1ju0LRzeHKZZW0wIacZOY
 gGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858376; x=1786463176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lapvp/IodBZRVG3QgR46Yu+3jZQ1Mm2TKg938FLk6VM=;
 b=e+UcPC3xl9/7jrIAjTAOx5GT+ng6XxuTHxdk3aeeKnG2uJfvIfyIOqCKZ9Qae1YXbD
 7tODYLq7Gf5uW0dpBOUBf+oo9mWflsvoQZDSdK9QQ29YyO+BPlqluy1k7npP8HoZ/G63
 2tRVt76TJIcqyCe3+vBY/e7h8m+M7Dna+yeXBKPSmGn+LaLJsxL/ys6QoXdPp7l3iMCE
 4BdOkuV2dc4OhRyBgD7IDEBDgCD22iCMRrBbMfS47n5E2EkMOMSnGmLOpS5V5pmlioXq
 YQLggV2yYTOQc20kGTaBPdXtUYtz2UNxFLqkFhlAHvCOW6IGmPZGfhxjk5yvFjb9FtKL
 rRbw==
X-Gm-Message-State: AOJu0Yw6iUJsN9gPxmAh8xwEbH3RsRwPy7OVui8wIJWbmC3wieHqRMsj
 s2psfo8/lArLK33T4pniNiMiEVZEI6Hd8TOdK/XVqfHtCtKeb/JboIVt4tVxrAeLURGMQE3Dcco
 Bwxxv
X-Gm-Gg: AR+sD10ptMdYPxiTfbDs3cAlPWy8idp6iLBF/11OyNLL59PimtVB3SHl3V2On2nz9LY
 FxNWqXiNPNHmk8KxJp+Tj9PdCQCRzKDVO8LjCI81aJk5jEEsqMqQbU8Yn/tUZA+hFEQxaHSc+ZC
 kR1za5pYIQjf5OzcOAsxIqzBwzOP5VQ4RJ9wrD0Vp7skvwCG4Gtlheektl16fQNZ26dTmNFeNSv
 rLLkN319qoX6xSHN2ENRoqOm6dwdcfz6ob1mg4X6vNYGrPzqjtNt7Z3RPjflYpLkVLmiFNoYS81
 NtFRtytJMR/ik2wSSDn0BqgX/R8RWMrBz4SicXesAiWfccjj96RRIZyfPqbD/6q/3ryzU7U1Ws1
 U7WgL1cMpujbhXEnJRnfWHulAmlM7UALEpGwyTNtmEdkrUNZntJfNSfJmU6H6eypNqCHVvodUEP
 tWrFZo23ox/uRrwryYjqjyJOEgZARu+1TSIqogvavD6NbqU/fUkfY/OuYTvMU7uHDJGXOYXdUPr
 czO55GkBaHt2dQIMy5JE4GfNHk=
X-Received: by 2002:a17:902:d986:b0:2c9:8f4a:90b with SMTP id
 d9443c01a7336-2d05219f70cmr170338795ad.3.1785858375589; 
 Tue, 04 Aug 2026 08:46:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v3 17/23] examples: include network headers
Date: Tue,  4 Aug 2026 08:45:05 -0700
Message-ID: <20260804154549.148691-18-stephen@networkplumber.org>
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

Don't depend on network protocol headers getting indirectly
included via rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-macsec/main.c | 2 ++
 examples/l3fwd-graph/main.c  | 1 +
 examples/l3fwd/l3fwd.h       | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..e07769bd57 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -33,9 +33,11 @@
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_security.h>
+#include <rte_macsec.h>
 #include <rte_string_fns.h>
 
 static volatile bool force_quit;
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 5f89286dce..79dee4d103 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -36,6 +36,7 @@
 #include <rte_per_lcore.h>
 #include <rte_string_fns.h>
 #include <rte_vect.h>
+#include <rte_ip.h>
 
 #include <cmdline_parse.h>
 #include <cmdline_parse_etheraddr.h>
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..db7b746f59 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_vect.h>
 #include <rte_acl.h>
+#include <rte_ip.h>
+
 
 #define DO_RFC_1812_CHECKS
 
-- 
2.53.0

