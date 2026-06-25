Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10ADCDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D0924066F;
	Thu, 25 Jun 2026 19:49:16 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 00E7540650
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:14 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so178846eec.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409753;
 x=1783014553; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg4sxBIwie297CkqIHuugR2RvZMbNd62tJTavXwYNzQ=;
 b=uosy/LA8tr5Lfl4Ixk648Smgp95SyJTqdk+xfwJx740OXG2yL5y2zpDoSGh5B2JV3L
 NiC7KL5GfOMXBWfHTNK44j7rjlErSY0DB4dXf3iyIvqQTjTYSf06ulkl8eT1x3eu21T9
 ezjqwYKD6fMklzsKximeYapeYAtDawJxH5l2eABB8D3GQ8mDamWoI53VZ8LKRWryC9lV
 ofq2SPriYPsv7j2mH5xbew/ANSxQ9dfEevAIni1kB9gA+lDTxtpOuFLYF+Ovrv1IqRxu
 wlgcUnC6jtZZUSATx5ktSSlOTro7yLqMC7eHsk2nzFYQbV0wc9Jrpw6KAiBzE5QGYUai
 /E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409753; x=1783014553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pg4sxBIwie297CkqIHuugR2RvZMbNd62tJTavXwYNzQ=;
 b=qpBQN4SdbOqbEkOWJYtzF42oP0Ok5QubKLQl6HXLqpcscRBHmnLFVr3z9smkzUnYq9
 1hP7PYA7p0MLEMnsYe3wvYbo2rFkAdJJnlqKLkiGhYkb0rU9ReRfLgyrNnUu8qyCe+1z
 pF93JWVna+BU6BnlGu6j2YeLhe8yG049a6s0oMEhstZnBzy6QC+w815XLdTrEbBlvHwi
 RA9qyJpp5K4X+Ffc2YIPnJ7asNCUVp7LJbLZ4oVRzq4KOGn7c/3+vK2f6Eb6DbwcJJ/+
 Ao58S+m4UXXXOyZzU2AJtxL4Gvp6+9sdMFGQbPkw3QB2HX1XUDgNcmLmBg2PSALl4TM5
 kcvw==
X-Gm-Message-State: AOJu0Yy01M0RSsjBdpf3uFQTj9zExJIbOrD3Lhd5Jget/V7VvxN1+2w+
 XXyrZtiFMEdQ4BpMcC+IE9FMr1Bd5NEPAnpIOG5Gza7VjaG5jdkP+y2fxjsroVJFZ8Z7ZeGVzZL
 dQqsW
X-Gm-Gg: AfdE7ckHZZUUXr4GNL+iQ+i6nYwmzsENEhtxM7z81yO9B95v83Tss6GuuxF6vmr4DnP
 QUOa0h6mp28ahPaq1yfO5JEZo0Tic/SM25lazpCMFrHthXd19Ly/UxQ8oUcIV6TgsQ83L1f6VZq
 Cun0Aai83/iOK1lvG6nyqzujoXLqXlPV+2DoX5mzLPgYQKVZFkSzOnLV4DVpBrIJo5czimMPMAe
 SrDgxbdjNws7QdERcdYWuRhZVGNEvtbeEAv9YjYyCPPT6mluVoJDsNIPbf1E/IwCacPuGiX0Rqi
 2bi6I2lu7ECL4OOKk+bS/ZBXJMdIFogKAUUfvULoyhklqYFoDx6vFz5OASuP5SnTvV+pdJWMboA
 RVfkZ+cZUn4/S8Ms0F+NkhYfLJGwdnk++Y5RmbqrFGtql4Bk6X3YTY9IBje0rsu1W/ssJTnWRLD
 bIeH8EFoW0fQ7TCRLB3yUVqaVv9S3EaUFMD+tAwpaMkVZvgAKfZQljlvllscVbbQ==
X-Received: by 2002:a05:7301:624c:b0:30b:e4a3:44d2 with SMTP id
 5a478bee46e88-30c84b64c90mr3749275eec.8.1782409753065; 
 Thu, 25 Jun 2026 10:49:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v3 2/6] examples/l3fwd: remove redundant Tx queue limit
Date: Thu, 25 Jun 2026 10:46:52 -0700
Message-ID: <20260625174908.278408-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625174908.278408-1-stephen@networkplumber.org>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20260625174908.278408-1-stephen@networkplumber.org>
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

From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

In `l3fwd` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_LCORE`
which is dead code.

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/l3fwd/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index df035b508c..6866811526 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -48,7 +48,6 @@
 #include "l3fwd_event.h"
 #include "l3fwd_route.h"
 
-#define MAX_TX_QUEUE_PER_PORT RTE_MAX_LCORE
 #define MAX_RX_QUEUE_PER_PORT 128
 
 #define MAX_LCORE_PARAMS 1024
@@ -1373,8 +1372,6 @@ l3fwd_poll_resource_setup(void)
 
 		nb_rx_queue = get_port_n_rx_queues(portid);
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		printf("Creating queues: nb_rxq=%d nb_txq=%u... ",
 			nb_rx_queue, (unsigned)n_tx_queue );
 
-- 
2.53.0

