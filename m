Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2836DE6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:15:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EEEF40691;
	Tue, 23 Dec 2025 19:14:47 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 1DF9640691
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:45 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso652613366b.3
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513685;
 x=1767118485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpGHnIsN2Ox2MRGFB5IUG5mMZu0Z9brH2ZO6yXcHV8A=;
 b=jKuP5gU0URLq9MLjlG9R9HImIlDLIJ7CBTVzwHC8NBk4az9Y2jO7PyxvyENN81PfZ8
 40tT+EtLkZZDKYPl958K2w6jkgjFh5f4P/k9S9zJ+JrpckF+hws2WptOIC6pTV0urCAz
 ssfCJaXiFRqWD1iJKJXLpRpra7Q8oxYyVm/XGtCov0PZlueCsJ8A5iPiwATogTpT1U0J
 9SB+4LoSZTmtvGayVzaYrxARgZjX+AILsmbVTm4b6mg9JMv13PNTd8UG0owPQ5bRbrDr
 X9mSFZ/X+AMq6KdocopYrHth3pmU25txrddYxMn6gAQbN5KsYso3vrIlFs6NuDhj+C9K
 EbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513685; x=1767118485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CpGHnIsN2Ox2MRGFB5IUG5mMZu0Z9brH2ZO6yXcHV8A=;
 b=JEuxCiSFFgpA4Njfkm0ap2nJJkGyN71os8YLl72vRNQAarxU0CIGW3qybC4MOwuI0o
 3Z6yRA0v4a4T5dkPQ9DkkAs+3AKG9t8PBzjM96kDkFkVV5Q+jxR1zswYkWTi4qk/yWhA
 dvBmbZQwXhkesY9hhjMUQ88PT7S9Ay7qqLZRMbt+8biQAgJ9TuVHSLqkKAmyzo3oeD0e
 tP4jVmWtfZOzFSMb0h2DCiFbk+X075/64wueS1D2KWefXSZEHi4VIS1pdNpMqABvLGCV
 n7PwZBqB0N0oyS7ShnJvbE1jgLj/JBmV45ZOaEue/jHSolmwkVYfMclR+BzB+3riaHft
 qffQ==
X-Gm-Message-State: AOJu0YwbBdcgn9p0nIQTDTUfjPw/7LE4HG68hJHblntLKiUyjPAV3xDj
 afyfkBpC3ted3dB8HmYvoEtmV+JvvNNAxEZEPtrqkOK2H3beA7aIzSh2k95sjorVHc1QPrS6Oc4
 Da2QD/d4=
X-Gm-Gg: AY/fxX7fqQrShdAU9yLTqtUtvLjrnHZ0sCjJZ7gmpfbFGexiCjcpr/l0weI/XUbBDta
 b8Z+KiGQKco0+Z/nPbgqooGXX7GNNtTc5SCQF3WoSRe9DhKX1JhPU3grXVZEE8z2/hjHzi80ux2
 nNgAgx/O6jAUgiYfwTrP5QtNI2EVchzLiSWgDPMLcx6KCHPzAb06D/lAPz4PhU0wXH8Ds8wY/7j
 MCr6OogtAm0t/423DIY2pzmX2vdk32lQECzcV5O1vzVtdLqlhIQwzXi8CXSMyX0XUH+kPqaGCjQ
 pBthegaVhAsGwfltd5jXaRVsplBnxB9hFKxgnNCjgGCzLhsSkoHm9BbHbqAtSZwuTVV6pUPDusa
 VLfrv3a0hrXhFGnpItcpWsvamQ+f8+GkRQqAr4to8r/vh7NeXF5E90TYN+AP7ViAX4KouNuOaRb
 hqG17cXNAdgFUDg6+omYt9uZ6dJUysPPQuEEAOZ0y4xELMCISq8w==
X-Google-Smtp-Source: AGHT+IFVKtBBYDLKklyiMMTWRVO2dMrw+QgGvu2fBtZWKHAeChx4c+mNeS5VN/l/Hg/iIXCZbr0d3Q==
X-Received: by 2002:a17:907:7f07:b0:b72:6d3e:848f with SMTP id
 a640c23a62f3a-b8036f60a9bmr1404219066b.19.1766513684583; 
 Tue, 23 Dec 2025 10:14:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 13/18] eal: check tailq length
Date: Tue, 23 Dec 2025 10:13:11 -0800
Message-ID: <20251223181418.40834-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_tailqs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..7502836c6d 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -67,6 +67,11 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
-- 
2.51.0

