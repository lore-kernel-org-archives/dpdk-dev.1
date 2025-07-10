Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65EC83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8423040A89;
	Thu, 10 Jul 2025 18:42:51 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 6142B40A7F
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:48 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-702cbfe860cso12197456d6.1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165768;
 x=1752770568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=splS417b6rcjP4n1yjWkZw8KRzT/RLktmmJAv7xWhbygyGOH6SuTn5vD5j2bWTbTXW
 DdE846Yk3EqR2KW9jOy5yHfKwIdXTUuzYZIJwIjQqMPAJhb9BqasIdPGU/85SfFWT6bL
 WkFyi5+ScR0AFaP3cI7dhkcx22U9LSh4x0vjwI3+sXw1g+feLoUcyPKvRgVSobb5b/XZ
 rc3XNtlQsffDz/mB1m9f89ZGkfBGhbqfGCRAFf3P5tPtfE+iQB/zJKdl4W7CK7OwjzBS
 GqWiikHiWfR8dq+nZONTFBpLYncQgcbRMag/BFbAyTbXGXSaYunLkrwt4NvfgGnmd9Cf
 gsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165768; x=1752770568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=a6Aep5WAjK+M4VZ8VLJUxAWmf0NluILFn7LjL1OmY3vafqedR5zV8jNaQMWUHYplGY
 FQgeZuc0AH8tRDCWx5UnexM66IN0SVmwcbG8uqrDuaSdDq23ZN+92OKDthvlQV7e7pll
 owW2iW1AuCfVV5iIAPYkH4m5VjYQeiXzJXyhpKFpuZknOgfphd7VWeQD58WONdhpnzdb
 Us+5YySR/yEWWXxIdKmF3XI8TfplYE7YkTVysFh/qZTHCZxHAj/eJdfZYkVi6QOyPZi1
 0XoSvm51n4lLXqchSu9vMnCnx/YmOu7cJuNOZslqm5nN6VWdSIewD3/5RjEMyGc4vJv+
 X6Ng==
X-Gm-Message-State: AOJu0YymQdWXzXKlBN/XVmFHHZN5eGmC9wDl3lNaXeBWhvFimv52ar3w
 2N8mpVekithOQCV5VCekNRH8Y/RU1TGBkRxCo1VgzgpwICUzeK+quz/hIWCauisr8F70Nzrroj4
 huTFX
X-Gm-Gg: ASbGncuH0xxR8T/YZRMbga7Asx2ZnJpIMvDQK+RecYzs/w+66G4sbmxUan1r86K5/bg
 Gz4BlaWvNCibfuxA6TSpintePkLzYxPfMrkITx8VpJ2RI+T1qQEqt+vK70365T5q7LDE4FmRfDW
 qx19eFjnzlxykKCprMQBZejWio8MEDnAhTraHJvbdIzENCQhmuD6yn9tCqWaKJY9+bfk7NmTtfY
 PvJ8kEnvp0sRjodxapTgF4YkHJf8B4mZXB0XlA91SouoP5oJMtJjucBiY25wGixKcSe6Pufp1gw
 IBvIsULH3t5nJ6FQL8YLpcIKph+AHiA1ZtIQI7zIHRvF1UiUgG4Vk6Y4z7KZiJR18XH4kL9yvX9
 cFi4bkpA8J2X8OSjZ92H9c4WdcycMKoKDdMWi
X-Google-Smtp-Source: AGHT+IFnTktJBq0QOxZvftVNlXuEKRq0mtoUhhvkQUu9zHTJtjGobCl7x3owjt7qwDEGBRmhtIDsvQ==
X-Received: by 2002:a05:6214:5d81:b0:702:c140:b177 with SMTP id
 6a1803df08f44-704a355600bmr858526d6.8.1752165767747; 
 Thu, 10 Jul 2025 09:42:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 05/13] mbuf: add dynamic flag for use by port mirroring
Date: Thu, 10 Jul 2025 09:16:46 -0700
Message-ID: <20250710164237.8630-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

Add names for new port mirror fields.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mbuf/rte_mbuf_dyn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 865c90f579..72a31b22b3 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -327,6 +327,15 @@ int rte_mbuf_dyn_tx_timestamp_register(int *field_offset, uint64_t *tx_flag);
 #define RTE_MBUF_DYNFIELD_IP_REASSEMBLY_NAME "rte_dynfield_ip_reassembly"
 #define RTE_MBUF_DYNFLAG_IP_REASSEMBLY_INCOMPLETE_NAME "rte_dynflag_ip_reassembly_incomplete"
 
+/**
+ * The ethdev port mirror needs some extra packet information that
+ * includes information about the packet before it was copied to the mirror.
+ */
+#define RTE_MBUF_DYNFIELD_MIRROR_ORIGIN "rte_dynfield_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_ORIGIN  "rte_dynflag_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_INGRESS "rte_dynflag_mirror_ingress"
+#define RTE_MBUF_DYNFLAG_MIRROR_EGRESS "rte_dynflag_mirror_egress"
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.2

