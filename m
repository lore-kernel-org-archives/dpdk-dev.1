Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E9FB5188
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5922C4065C;
	Tue,  7 Apr 2026 05:52:24 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 9398C4014F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:20 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so5068319eec.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533940;
 x=1776138740; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnig79fSwv3kDK1v754eqvuIGNGi/aD8ZOoztPYpiSg=;
 b=QXOsMgkZ45SJffhAEk/6ZdYp1W0T7kUPXt2o27XMiRDgcqUf3PurjZhFlyRIKohhTj
 uUeAd2s4mdTxpNqAAUPifUPZ0oDvU8tM4aboeUTVzgonlcNUnPlfSB8o84JyfZ4AY+17
 yFweT+EaG+zvd8n4G+KU776o0Wb1FaIrRPLRISMTmNjOeW0oZ2+6GaUxmF5KE3h91e8u
 ynGt4RGL3a1hOWPmdxvsekld1MvcrgS9gXWSoDobIiNTIh1HSWihYtGDQTnVkUzW1ecd
 jyTgPA3jXLcjaNb5NcpqhZvPFgb5Pt0o60Cp5c3+vr5ICDf2+zXFWfJm1tq5aLwgr8FR
 mgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533940; x=1776138740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnig79fSwv3kDK1v754eqvuIGNGi/aD8ZOoztPYpiSg=;
 b=GeGfVAFieKFI0orZnsMLxo0m5X0fsY77Xqf6bdmCvNy8ekLwDmDJhuf84v7xne8tMn
 auim8YtykpFacy+ISmVx36fJUhq8nFkmOqUHW9BE+mqJYTPcrOAINf5LmL9/mSgAzCkl
 WmBka7nbXTmYNvgWRpFDeNTHmGAH6BbpbpkztLYZypQh3XaOaDdtbpocajmcd3Gxs7Z0
 Pfy2TlcstKGAkAojGgkmTYNxlnTsgB4aIHAHryANfjd8nnpJwVvWVQNOMRmtEkH4u6W/
 NTvqtvlVuqxZxaiz75ifQ51jj3tmJfLww7Np5F+RHxgQpRezkvsTbWbc+KPv1SqnuDtB
 paGA==
X-Gm-Message-State: AOJu0YyzhskRS46T+8SiGC4gvjJcJ/lVkshX90IEERBPOPZ7WwqCjms6
 aOLRQC1+lEXO/esJu1YKO3fTWxfznauzbnUKbhzB1fe67/ifs6RvFPATfuaeBpTTJ69p7XEKmgP
 IW66T
X-Gm-Gg: AeBDietETtW1tk+b9Mo3qCrJZ1m+Io5cOFK+ovR/jKh5uex5stI5cmamgQNW3mTf47Z
 octrgYAJ5tHTj6NjwWDN+1PZ5OM+MDgDvIzNjtVBHj1ow5NAoShD3Zvvno1ZxHEwUvQucQFRPXl
 SxlVyJe1ppdPLs1FbzDnuAUR782cNrZHTnlaedGTfr5G24Yg/BuP2g2CfTS7F/5JuFAxQ9qaurv
 wEF5i7odlf0ekZWzYQuHrE5uy9r8vBvrq8lw1AMMP53xWDT3ZOrz+kskc8uByuwBE6S06I5cW5c
 KWmALBd25vYbHFia/H1JvB2T9kBVqKpcPPQwqhhIgsd/ZeBN7AjiJ86rOQZhvphWQuv4L9BmK+k
 Cn58AyZyKGweBuWMsH7bpfKaj6Cqj+zGJN2PXhOydD5DaqLZNRV6/Ut8WdaP1rNvNn27cPeuwwa
 E+MXHseekpgcr+ZVpN3ZuoiivERKyUaLE9
X-Received: by 2002:a05:7022:f503:b0:12c:8b9:71d9 with SMTP id
 a92af1059eb24-12c08b973fcmr2009764c88.27.1775533939549; 
 Mon, 06 Apr 2026 20:52:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>
Subject: [PATCH 08/23] examples/flow_filtering: fix shadowed variables
Date: Mon,  6 Apr 2026 20:49:34 -0700
Message-ID: <20260407035209.650419-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

