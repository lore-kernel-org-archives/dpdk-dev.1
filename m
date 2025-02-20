Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09338C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C62B40654;
	Thu, 20 Feb 2025 03:35:39 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 0800840292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:29 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22101839807so7878585ad.3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018928;
 x=1740623728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdUcCY8M8GDykIOz13rvXqx1PJAn1qC58agSRPIKkB4=;
 b=egXT54n7WFlBI1Yj4Bn8psDifREo8hYhP+3VS1JWXT0cL6XOMDsR2L2OxfYYYmw/Id
 KNo6ugCAgHutZhWqbAVI48azOdc6rnckqBiKQgGyeZimpEmL/lA2sH6WeSI0MP6uu9+f
 vQJl7Zvb94go/RIn32UwQnNcJ4pkfbRMItTT93RwEw2YH/gDk5J89nP7Ft9EkXJtOoeH
 aR7w/dFBeLpcIH0jALhn/v67zn6yR5nCJpUQ4p2UYcmtKebd0MriS4O2IXl2KtRVEu50
 TgfpyNbq60uW4vG2B4sdv42jiVNOheSiOWiEwO9ad/f7h5NGIhir5kXPJPZNTgFALOZy
 0quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018928; x=1740623728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdUcCY8M8GDykIOz13rvXqx1PJAn1qC58agSRPIKkB4=;
 b=jDzqWFPn9GqJ9VwAfzU4I7IlWeuU+cINS+gTC3CkdsLoL6KeBRHzyVVoZPlj5RRl8r
 O773gefsk4BXiFzI5I5b1J9dQz3TAlkQIgomyJ+FIJwBbEHqE+C3r7xmqrwqxbTOZEgV
 VnTW1acUSB53/evsL0b0gVu8g5Rut8rc7XexU7ndv7hidvjIgC3RVSZmG3CnKmnI2K6G
 auXUJDn1NSF+rIEBKtLUMFlclKQxtvfgGSwkVHvxjIne8JkT2+4G2P+wP6IFeoGomZm8
 b8ZyTgh1PjbzDMELc5L1jw4okUGHxAnDUuVVOUIEKz6LrKdxaF5BNfi9Hh3xM/R33z7P
 cu1w==
X-Gm-Message-State: AOJu0Yy0+c/FD9TeWeQjh5r2VwnAv3+uIaeZ5bDQ+QA38VvC8sPVCj90
 SkHlaKToQgYo5EsitGl7ifE2FVhP4ryS0zJuCSEDF1bGJwzd0PpXOysKQGVplEO1g9fVdeukV6Z
 kJ2Y=
X-Gm-Gg: ASbGnctdUtcOHIIdhM+XDmyZcvWsm6Z3WI9X+5DRZiD+FA9wUVWXkXVnpbf3RhA9j+M
 SmyxIYlU00MxLKvg5iAvcnpLG0IYBhohkjY5py8c8A8qFoY6CHXdtilFIgGQmzZFxA+XtSodjct
 +J6p2J9jHCgVKHBWVMl+8Ltq2Rhsn80YW9rKikEh1+d84Jf+DqVtlhxISJ4OdiZKZ2nuwOJ63h8
 9h3GRoU5380U+Inol6fwAmvMHO6wm+V0aAE7qiUaWJNo7VRUNTCBkkp8FpmybrFuo7KnYhnMV8Y
 xeWpeDZLXyx9ronf7Ir7ABRonYscNbr9tMaaeskHdpeVtJHJVO5k1Hj5r1uVOhzsErEZ
X-Google-Smtp-Source: AGHT+IEuHXURlKhfRNKNQjaIA+C/mgsZuuR8kf+4nxAFBhih513/b0FFCl1kFETfY+X8wlwR4JqD7A==
X-Received: by 2002:a17:902:eb83:b0:220:d6ac:b5a3 with SMTP id
 d9443c01a7336-221711bbd3amr89370785ad.51.1740018928191; 
 Wed, 19 Feb 2025 18:35:28 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v2 08/14] crypto/scheduler: remove unnecessary dereference
Date: Wed, 19 Feb 2025 18:32:12 -0800
Message-ID: <20250220023509.630569-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->sym_session_get_size and
dev->dev_ops->sym_session_get_size are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../scheduler/rte_cryptodev_scheduler.c       |  8 +++---
 drivers/crypto/scheduler/scheduler_pmd_ops.c  | 25 +++++++++----------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 9a21edd32a..6013f66aa5 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -741,10 +741,10 @@ rte_cryptodev_scheduler_option_set(uint8_t scheduler_id,
 
 	sched_ctx = dev->data->dev_private;
 
-	if (*sched_ctx->ops.option_set == NULL)
+	if (sched_ctx->ops.option_set == NULL)
 		return -ENOTSUP;
 
-	return (*sched_ctx->ops.option_set)(dev, option_type, option);
+	return sched_ctx->ops.option_set(dev, option_type, option);
 }
 
 int
@@ -772,10 +772,10 @@ rte_cryptodev_scheduler_option_get(uint8_t scheduler_id,
 
 	sched_ctx = dev->data->dev_private;
 
-	if (*sched_ctx->ops.option_get == NULL)
+	if (sched_ctx->ops.option_get == NULL)
 		return -ENOTSUP;
 
-	return (*sched_ctx->ops.option_get)(dev, option_type, option);
+	return sched_ctx->ops.option_get(dev, option_type, option);
 }
 
 
diff --git a/drivers/crypto/scheduler/scheduler_pmd_ops.c b/drivers/crypto/scheduler/scheduler_pmd_ops.c
index 6e43438469..105d9cf02a 100644
--- a/drivers/crypto/scheduler/scheduler_pmd_ops.c
+++ b/drivers/crypto/scheduler/scheduler_pmd_ops.c
@@ -195,10 +195,9 @@ scheduler_session_size_get(struct scheduler_ctx *sched_ctx,
 		uint32_t priv_sess_size = 0;
 
 		if (session_type == RTE_CRYPTO_OP_WITH_SESSION) {
-			priv_sess_size =
-				(*dev->dev_ops->sym_session_get_size)(dev);
+			priv_sess_size = dev->dev_ops->sym_session_get_size(dev);
 		} else {
-			priv_sess_size = (*sec_ctx->ops->session_get_size)(dev);
+			priv_sess_size = sec_ctx->ops->session_get_size(dev);
 		}
 
 		max_priv_sess_size = RTE_MAX(max_priv_sess_size, priv_sess_size);
@@ -355,22 +354,22 @@ scheduler_pmd_start(struct rte_cryptodev *dev)
 		return -1;
 	}
 
-	if (*sched_ctx->ops.worker_attach == NULL)
+	if (sched_ctx->ops.worker_attach == NULL)
 		return -ENOTSUP;
 
 	for (i = 0; i < sched_ctx->nb_workers; i++) {
 		uint8_t worker_dev_id = sched_ctx->workers[i].dev_id;
 
-		if ((*sched_ctx->ops.worker_attach)(dev, worker_dev_id) < 0) {
+		if (sched_ctx->ops.worker_attach(dev, worker_dev_id) < 0) {
 			CR_SCHED_LOG(ERR, "Failed to attach worker");
 			return -ENOTSUP;
 		}
 	}
 
-	if (*sched_ctx->ops.scheduler_start == NULL)
+	if (sched_ctx->ops.scheduler_start == NULL)
 		return -ENOTSUP;
 
-	if ((*sched_ctx->ops.scheduler_start)(dev) < 0) {
+	if (sched_ctx->ops.scheduler_start(dev) < 0) {
 		CR_SCHED_LOG(ERR, "Scheduler start failed");
 		return -1;
 	}
@@ -406,14 +405,14 @@ scheduler_pmd_stop(struct rte_cryptodev *dev)
 		rte_cryptodev_stop(worker_dev_id);
 	}
 
-	if (*sched_ctx->ops.scheduler_stop)
-		(*sched_ctx->ops.scheduler_stop)(dev);
+	if (sched_ctx->ops.scheduler_stop)
+		sched_ctx->ops.scheduler_stop(dev);
 
 	for (i = 0; i < sched_ctx->nb_workers; i++) {
 		uint8_t worker_dev_id = sched_ctx->workers[i].dev_id;
 
-		if (*sched_ctx->ops.worker_detach)
-			(*sched_ctx->ops.worker_detach)(dev, worker_dev_id);
+		if (sched_ctx->ops.worker_detach)
+			sched_ctx->ops.worker_detach(dev, worker_dev_id);
 	}
 }
 
@@ -631,8 +630,8 @@ scheduler_pmd_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 		return ret;
 	}
 
-	if (*sched_ctx->ops.config_queue_pair) {
-		if ((*sched_ctx->ops.config_queue_pair)(dev, qp_id) < 0) {
+	if (sched_ctx->ops.config_queue_pair) {
+		if (sched_ctx->ops.config_queue_pair(dev, qp_id) < 0) {
 			CR_SCHED_LOG(ERR, "Unable to configure queue pair");
 			return -1;
 		}
-- 
2.47.2

