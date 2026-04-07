Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75917FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79DD340430;
	Tue,  7 Apr 2026 17:18:09 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 82DFC4025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:08 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c76cce85bd9so1898794a12.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575088;
 x=1776179888; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHHr+gW0MWUCU5vdR7kcKUiiTq+56gHzGd4shfZAJTI=;
 b=a900ezPglFnO5UyY1cwneVl/tA4cK+/gS3anmWyNajmFxEl0AlRBDEPixQ0qY3Tavl
 uKY7gBu7ZPCDJ3fE8tuyCkLcycZMQIepCedVImm8rH7NCLq2mc7vCAqkWNaAKN34jAnD
 JLwacC+OJI65YgTrSop271agFO2nxl5Gnfsum7qB+AsDT1PcWsqmZlHMKQObNeKCQnoW
 LeV71A+jShbGqiY6iUi4S5t76ha/dXCNRfg0EwXLDpDVUoPIrVq4RhWtUDu2NF7+c4Uf
 2wM+hV3lJ4O7gzWEE+QMT3XMDSGgQKSJJOyQK3qKSOAp8o0XzQ8nQxReysUq6t2lrVZV
 5JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575088; x=1776179888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHHr+gW0MWUCU5vdR7kcKUiiTq+56gHzGd4shfZAJTI=;
 b=soGNPW2EfTUIQz2orznaqQTk90tw51QjYMBbctK1kmXV/sNfvdE1a0wilxPwHJiVIk
 8juC9ajzNp70p1I3GpnSO1qb/5CVE1y0K2LcZkevDc7SM0MW9BROlvSOofUsK6+j3mxI
 BthYeS3NRyBulCiCwzzPgNzBbcjMhb4gZv5Sobw3zkCkFHfCi98gYClPsmQKxSoDGrdJ
 RXoL1e1FWX+83NXQiNt8wrZmOnPJ1akB46YVyR/wh0E64/5MOCASdUBw52MUlcnQshUj
 j7BlrxkaaktgUTo/RWJkxuflujz0TH7NjzW8F4BDKWOOWvOEImh4QZ7NHmj/myQ694Vx
 ltUA==
X-Gm-Message-State: AOJu0YzBzH43o+KkcJKCoPWSnr4pCOVIvstUZWJBqtbg7e3q2i7Lv3hM
 4/BUXtXL8H5+K9ITeXsovexqJBZ+gDYNyrDeYTm4H5okNzFiLKMqCs27QnJQRBXEznWFoAehOew
 wDIaA
X-Gm-Gg: AeBDies7b4SRpvIvhy9OfOHRnOsuQlzZlfeRGOWWdl4UcWuujAYHQ6fRQUfSl5l/RgV
 h7Y7A0sNdLG3QYNphK5M1UpQ8dBIAJqvq6wHtmN9SBmrmoYHHmlr7nYcpKciJuuasoVc5RzxR3A
 60pk4z8koFwSh6MlRp0c4tGONgJLH3BlV/ZJowHZs8RR60enuClMDTNPzNisHbcLoZLRyqKzLMl
 PU+agNycurIc6JbxnRpt/fhFds9D+fmW+xVN4vndGRkvpbM0JfY3pYg30rdigum9zIC99Z0ocVq
 OG/OCJRzTfDUai58zGkgW0H8gF20TufhoOx9GDv6PB5emWZwrvcQDXQUunUZ/T4Fi2u/3Dy34tE
 uU17Zk+rpI51svClydSaxJcPSgI2iUvFBMmowYmJ+V2KIRaCJ9mO7te52w87iwT8SEdIOsZUfj5
 hqFEgQMswz+2y3t5ZNkbBCZGix0qIfhTmS
X-Received: by 2002:a05:6a21:6daa:b0:39f:2ad9:e547 with SMTP id
 adf61e73a8af0-39f2e93f0dfmr18704998637.0.1775575086700; 
 Tue, 07 Apr 2026 08:18:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 08/23] examples/flow_filtering: resolve shadowed variable
 warnings
Date: Tue,  7 Apr 2026 08:16:04 -0700
Message-ID: <20260407151732.272195-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Rename places where argument name is shadowing a global variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/flow_filtering/flow_skeleton.c | 10 +++++-----
 examples/flow_filtering/main.c          |  4 ++--
 examples/flow_filtering/meson.build     |  1 -
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/examples/flow_filtering/flow_skeleton.c b/examples/flow_filtering/flow_skeleton.c
index 7e57b13b55..bc1d07fbe3 100644
--- a/examples/flow_filtering/flow_skeleton.c
+++ b/examples/flow_filtering/flow_skeleton.c
@@ -14,7 +14,7 @@ struct rte_flow_attr flow_attr;
 struct rte_flow_op_attr ops_attr = { .postpone = 0 };
 
 static struct rte_flow *
-create_flow_non_template(uint16_t port_id, struct rte_flow_attr *flow_attr,
+create_flow_non_template(uint16_t port_id, struct rte_flow_attr *attr,
 						struct rte_flow_item *patterns,
 						struct rte_flow_action *actions,
 						struct rte_flow_error *error)
@@ -22,13 +22,13 @@ create_flow_non_template(uint16_t port_id, struct rte_flow_attr *flow_attr,
 	struct rte_flow *flow = NULL;
 
 	/* Validate the rule and create it. */
-	if (rte_flow_validate(port_id, flow_attr, patterns, actions, error) == 0)
-		flow = rte_flow_create(port_id, flow_attr, patterns, actions, error);
+	if (rte_flow_validate(port_id, attr, patterns, actions, error) == 0)
+		flow = rte_flow_create(port_id, attr, patterns, actions, error);
 	return flow;
 }
 
 static struct rte_flow *
-create_flow_template(uint16_t port_id, struct rte_flow_op_attr *ops_attr,
+create_flow_template(uint16_t port_id, struct rte_flow_op_attr *attr,
 					struct rte_flow_item *patterns,
 					struct rte_flow_action *actions,
 					struct rte_flow_error *error)
@@ -42,7 +42,7 @@ create_flow_template(uint16_t port_id, struct rte_flow_op_attr *ops_attr,
 
 	return rte_flow_async_create(port_id,
 		1, /* Flow queue used to insert the rule. */
-		ops_attr,
+		attr,
 		table,
 		patterns,
 		0, /* Pattern template index in the table. */
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index 8ea6596ed4..f2124881a0 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -125,7 +125,7 @@ assert_link_status(void)
 }
 
 static void
-configure_port_template(uint16_t port_id)
+configure_port_template(void)
 {
 	int ret;
 	uint16_t std_queue;
@@ -254,7 +254,7 @@ init_port(void)
 			"rte_eth_dev_stop:err=%d, port=%u\n",
 			ret, port_id);
 
-	configure_port_template(port_id);
+	configure_port_template();
 	ret = rte_eth_dev_start(port_id);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE,
diff --git a/examples/flow_filtering/meson.build b/examples/flow_filtering/meson.build
index e2d5850a19..e82d63ad8b 100644
--- a/examples/flow_filtering/meson.build
+++ b/examples/flow_filtering/meson.build
@@ -33,4 +33,3 @@ sources = files(
 
 # The code snippets are not utilized.
 cflags += '-Wno-unused-function'
-cflags += no_shadow_cflag
-- 
2.53.0

