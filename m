Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00399C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:17:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC3940A67;
	Thu,  6 Aug 2026 19:16:51 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id C86DA40696
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:49 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8f1e274ccb9so14342836d6.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036609; x=1786641409; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vizc2u3Q4MQUu3B6xpOfk2V7bI6JKUcdYZ3PTaH+ofA=;
 b=QdIW4iuktB3jxOhq8iQB+cl+Tptq20sZr51kLn/dvKtQdI1q2NrbMKHKuCw9nqqT4k
 kkwckNu2ievSXJimLwConL8hnqvF/kaa59Jxms8tXURYHmbAMnSUT54cl+ftC/A4bPl8
 fWH++ZiH9h6kILdBSwpNcb6tllHbQoQD8eLQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036609; x=1786641409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vizc2u3Q4MQUu3B6xpOfk2V7bI6JKUcdYZ3PTaH+ofA=;
 b=Qk6Uk3okIWydVv59IhSyd4K69/XsMmb8J/DOuvbotevWs84a5EzTNgNdzKqxV3u0e3
 +mIenbUu3PmguLwclPI5vXtXLLGDMfw0JuZ1UmwxsKvtGTyGBmPIAnGxIeimUrDjk3Lu
 +dqi4SQHeKB1Z1sUmVGOnxGOTiw6cN8Hv0qpn9JME9tbXiMZYf6T8O6UQBTjVq3+2ZTn
 FpPb3SsUo5aI2akZilbkZOlmbYeyyv+krHzgUGVJCkJ9s6XKuxRhqmg3URDhgLOBwzUk
 11DaUPcqG4m7WFruCbohWGnkekaug1QiU+JE0gwCf8wLVoa0mQDmZzVStoRUduetU2ob
 AXew==
X-Gm-Message-State: AOJu0YyeI/nU5VqdiGwJgWZVgaymo1+0tx+hQed+IfUdG+RQLeOl6Qa3
 JkjybDCr5E6SFkhP7UKjK4+EwiCM0hJT6NTVAJAP3yBoRUNDToHXdMzqB/7l4R/t93FrIZBnqEt
 S0JO7HjmuGSsCuHqgOPmODVLYFie9yUiA9+MubJ5I0d0ZILG/ZXaI88DQPjFqPdj3ZMqPbxb83t
 YaBn5rG3VryLUfD7vxXAaUKvuooVM=
X-Gm-Gg: AR+sD123H9oQnRN3vXG6VKrPpywHkZKq3MpICTcVHaN2ptSh4rpK2+paskLG1Afexq9
 KHdU7PX4uDQt6oetdLHO3zmlm0gc7gnQqVZQCjv3ZaRSKi/PfSExOQobCMlhrGO4iXexg8tp9gg
 ZV9NeI2oNsAX2F1fQZ5Vnc7oWJ/DiilcSy76WJPitdZuImtK+0idanS0rjToXolFrRKinYEUu4E
 rMP9nuZtZJZNuy7pHisYeIeBBxpQRRhqSEEEocPSBDdrQ098DOSSTLHTq6DQRveihlMO1256+c8
 3NDqEcxQX+sbNQ9YcDFJhcgHfkyRqOPfJ7+FUG6i0SoX2DfVuc4hCKpBGG3gC43Eytbvu+BZOmk
 rR3lfV3fEeuxNh1/9CKcTXjNavRuipHtbKySigNMU5QrUGPRRlZ1BsmYOMnevK//m19cQRF35eA
 aoMeX3sFAWQCywxM4fXTrUopkgtTYJV7zXOrSt+ru8KPPyF5MeDTmkwihsP4mUqPyN+zUrfepiz
 uhAD98UAm7a437k6KelZK3SWrJLPDOqh8hDfQUy
X-Received: by 2002:a05:6214:29c5:b0:8df:98e0:4594 with SMTP id
 6a1803df08f44-908813800f7mr186372456d6.15.1786036609087; 
 Thu, 06 Aug 2026 10:16:49 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:48 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v6 4/7] ethdev: remove flow metadata symbol aliases
Date: Thu,  6 Aug 2026 13:16:33 -0400
Message-ID: <20260806171636.656181-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806171636.656181-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806171636.656181-1-abailey@iol.unh.edu>
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

From: Dariusz Sosnowski <dsosnowski@nvidia.com>

Version aliases for rte_flow_dynf_metadata_register
and EXPERIMENTAL version on rte_flow_dynf_metadata_offs
and rte_flow_dynf_metadata_mask symbols added in
commit 56045d198968 ("ethdev: add aliases for flow metadata symbols")
are not needed after ABI version bump.
This patch removes them.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 lib/ethdev/meson.build |  2 --
 lib/ethdev/rte_flow.c  | 13 +++++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 63fd866af9..8ba6c708a2 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-use_function_versioning = true
-
 sources = files(
         'ethdev_driver.c',
         'ethdev_private.c',
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 799c5c4843..60c9a3d06f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -23,11 +23,11 @@
 #define FLOW_LOG RTE_ETHDEV_LOG_LINE
 
 /* Mbuf dynamic field name for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
 int32_t rte_flow_dynf_metadata_offs = -1;
 
 /* Mbuf dynamic field flag bit number for metadata. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
 uint64_t rte_flow_dynf_metadata_mask;
 
 /**
@@ -282,7 +282,9 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(JUMP_TO_TABLE_INDEX, sizeof(struct rte_flow_action_jump_to_table_index)),
 };
 
-RTE_DEFAULT_SYMBOL(27, int, rte_flow_dynf_metadata_register, (void))
+RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_register)
+int
+rte_flow_dynf_metadata_register(void)
 {
 	int offset;
 	int flag;
@@ -315,11 +317,6 @@ RTE_DEFAULT_SYMBOL(27, int, rte_flow_dynf_metadata_register, (void))
 	return -rte_errno;
 }
 
-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_flow_dynf_metadata_register, (void))
-{
-	return rte_flow_dynf_metadata_register();
-}
-
 static inline void
 fts_enter(struct rte_eth_dev *dev)
 {
-- 
2.55.0

