Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF8C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D29040668;
	Sat,  8 Feb 2025 21:32:12 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 49E484065A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:09 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so4434004a91.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046728;
 x=1739651528; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FdxElZpzefFV+Y57WLqp2fcwB1C8sWQf751HME/3zk=;
 b=L6YsQ941LNfFfkdlzJTfMtGla6JHSyCq0PAdqlXyv0cWaADJG77719hDQ9fD+bR6Kf
 L7olRDlbPFQTwD9Y2uoGFpr4SiqTctJqfPY/1vxhwpGkpH+Y04uuyUm0Kc1FsFmwoRHs
 8k5UXsBEic7q/uWlK/4m8zxiujbHxCvQLmSdK3oY8SxwsR3/t+kP1ZppojSIxmcveiEy
 AeVGebITbMqsUpQfEdwx+VhhxWJr7FG0OiO2MmYbGB78E+GWxcrnwGmsK0nLfpWzli18
 K+bjCBpZuDF56nUivbpYUgzm9QizWkrZtSif9Nfkg/UelSPfdnniPlV8QnYw6tuHbmLl
 bWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046728; x=1739651528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FdxElZpzefFV+Y57WLqp2fcwB1C8sWQf751HME/3zk=;
 b=nOrOCkl1PTO17/0hi6moVJHfa9m9ic+SzAmgr2/ZS4krhTsS6jIg4x7gEweD3DRvEo
 mPluxFDyoXF3N/CBtS9PGz1ZYtzPDzJM54aLA/3SNhNw22y9UhzrB6dXqKCCai3KLWe0
 l1lr/bQmLULMJxOC9Ti+jksVsOiqLAdcbQIgwNV3ogbAkQNAXfxpcoJ8TZJSdx4QuVrB
 Qmla/wNGqIbwsUBdVFdory6CUXSMPi7lXGBxR8gNwnv1UA2K/DWyXBsBNNYJrrz3fBqY
 bSbZvNIob68k7n4DoqFN83yhWqy5RvbigIHLjQeNfDWulK+l9rne5LD5/9I3hLeTYs3A
 r8dg==
X-Gm-Message-State: AOJu0Yzjd5sB5DAftHhAFU4AxE8M39wX6yQi4SRRsTW6jwLu5PcshCFr
 3k6z2PDjQSsxQUXfN3zoUZLHGnlzT3lM9ag+XzZFgW3g4ifZ1WOvwEXBGqCXFgQHaA1Kj9vinBk
 EdjI=
X-Gm-Gg: ASbGncsv8ygHCQOk6fMOPnphO+LwERCLGYqGOJBPI9adHlgBZLWmrrkwxmudGU7TFPV
 /qhtsiLPYl75S4w54S87zgSfWeLhrr1ZtRZFd5iHP2GiDqYcwsIm+1Pgo2bNoHltreBLLb908x1
 F+xAIr2aL1FFx/4AkbBZ+829WAIE6H2V6nERcX79eDVEyPXepTeHOUZlS8Ao/Z04r4Y6VAdtBMm
 3SQju6+d2Y8CrdFVhegwYEWuSi+0CERqcYk+aGmnK7nrZm5AUQPL/M8YAZJAODqK4HQHYxPW2Kr
 d743MFZk6BVgDsNKRT7PoJS+p5UrTtV3I3dixKO+70JrxygHXQHTbC25u5a2UJaeHp72
X-Google-Smtp-Source: AGHT+IEh4DfL/Tt7FDWc0uf4V1LEaRmjVYH1S6ColkBkdCQyWguuVmORYtGbgvDKeYW7ipop46asUw==
X-Received: by 2002:a05:6a00:6f59:b0:730:7600:aeab with SMTP id
 d2e1a72fcca58-7307600aee0mr4659611b3a.13.1739046728368; 
 Sat, 08 Feb 2025 12:32:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 11/32] node: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:03 -0800
Message-ID: <20250208203142.242284-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/rte_memcpy.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/node/ethdev_rx.c      | 2 +-
 lib/node/ip4_reassembly.c | 2 +-
 lib/node/kernel_rx.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/node/ethdev_rx.c b/lib/node/ethdev_rx.c
index 475eff6abe..bcd192cc0c 100644
--- a/lib/node/ethdev_rx.c
+++ b/lib/node/ethdev_rx.c
@@ -186,7 +186,7 @@ ethdev_rx_node_init(const struct rte_graph *graph, struct rte_node *node)
 	while (elem) {
 		if (elem->nid == node->id) {
 			/* Update node specific context */
-			memcpy(ctx, &elem->ctx, sizeof(ethdev_rx_node_ctx_t));
+			*ctx = elem->ctx;
 			break;
 		}
 		elem = elem->next;
diff --git a/lib/node/ip4_reassembly.c b/lib/node/ip4_reassembly.c
index eb5f391114..c8072e6e50 100644
--- a/lib/node/ip4_reassembly.c
+++ b/lib/node/ip4_reassembly.c
@@ -157,7 +157,7 @@ ip4_reassembly_node_init(const struct rte_graph *graph, struct rte_node *node)
 	while (elem) {
 		if (elem->node_id == node->id) {
 			/* Update node specific context */
-			memcpy(ctx, &elem->ctx, sizeof(ip4_reassembly_ctx_t));
+			*ctx = elem->ctx;
 			break;
 		}
 		elem = elem->next;
diff --git a/lib/node/kernel_rx.c b/lib/node/kernel_rx.c
index 6c20cdbb1e..461330414f 100644
--- a/lib/node/kernel_rx.c
+++ b/lib/node/kernel_rx.c
@@ -198,7 +198,7 @@ kernel_rx_node_init(const struct rte_graph *graph, struct rte_node *node)
 	while (elem) {
 		if (elem->nid == node->id) {
 			/* Update node specific context */
-			memcpy(ctx, &elem->ctx, sizeof(kernel_rx_node_ctx_t));
+			*ctx = elem->ctx;
 			break;
 		}
 		elem = elem->next;
-- 
2.47.2

