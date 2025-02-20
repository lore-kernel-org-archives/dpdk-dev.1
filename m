Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732DCC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DF2E4066F;
	Thu, 20 Feb 2025 17:57:15 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id DB6394065C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:10 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-221057b6ac4so21894985ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070630;
 x=1740675430; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpVuw1k4aqMqKYrO7I7yiO8TxMRKxqbJjfzjNg+yLJc=;
 b=S3vBADUKVXkXjegqN6F9qWhXiIuLkM2Qt22/cZFl9more5ftl6cbTgEKxCf+PT06W0
 JPJhnRq6JdjUFSlcaCG+LpuDGMfocAhXagVBs9xStMFP7vAc2M9DwdFPGKZ8aI1muKF2
 9Scynoktr78KOowReGTteuZBWF2717VxSSZu4AO1kDCpjI/ZstYxvpJfJybFWVG13r7S
 Set5KrFQzwk3XDsFjIE9TfdNIU4cbxbVchFFB+Md4UfSqOzUomZW2LOP20Z6Wjj4aGDW
 bTqymMbozcLCx5QrW0HaPHpIifKOP848p4idfy/YwX6QgU9TH+ZX8tu0BaR826dAdVzE
 P9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070630; x=1740675430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpVuw1k4aqMqKYrO7I7yiO8TxMRKxqbJjfzjNg+yLJc=;
 b=FdZQwvpijEO5zmiaAkE/HmULsfPAEcnFZ9x6SltKMPBBUuJQ5DEUj3Yx0HK1LkgfD8
 YznCwk+kmNRulH4zwaPY0JBC88GmWGgYvAvCYaZonubAEL18VwtuRVjiUf1bMef6cFSB
 PJQeyKvO3rRwS4SngDAaFA4TRrKib/cJqSAFM/O5PE6szN9hhzlvAz7drzqzf85jGQk5
 /lonwzh9+8Ck5/HBLbsG5UIHKfVG8ghguVFGi/xs2mUtVlIPlNkWyyb8OKsDisT8gDZE
 PuVTJnqdxLcSZe1ps/nwDIviDzqAxtugloh1I1M2bB9VFl4f+2MiGuw9wBXmIUFEEmgx
 l2gw==
X-Gm-Message-State: AOJu0YyyT+4tqeYO4bWWf5VHgREbIKnEGvyWUXEBtcodGdIyHtemPmo2
 JeCgmpJFDueXMNuakiSJIptIWHmlzBovDYIjFYXx+hv1JWIhDbvN8CVCfsKkVtAGOuKGn62xeKt
 C
X-Gm-Gg: ASbGncsRDdG3fDs4jWu6gPYPw5htV306dqAJDXA9mGpv83TAGSYCNrHHcgtmlP2fJrx
 FGDx1sSJEQKsNybm3dwbhZsnFzqG9RHJorC2VRLIkdXB49quBK/UgQhiDAetkVzKmje14VrTVvI
 ImwB9QoiLvaCh0hNQCa4C+MliDbAwfj3xg58Aa+jZ7p3zugTslvJdxIg9wauE/DY5Ifze4KEjNy
 zl0KvRLxu+b/Yp2+ygN8Pa6c0vx+T+D8XNVxCvxj9/gZLPFonXBPD54nk8991ffxTNCjqoz+Gvh
 yViSIjOXJtSNyjen7lN/sCbp1xe6GS16LouAT+Vl+pg/RWQ5Qo1Re1n/pviRfu2vHoXy
X-Google-Smtp-Source: AGHT+IEhvcK2liKA7zYcoIE46ONDJvLMaw6JqZIrJJL3owerQSZc+4sf7dhv169vhfHQbGga8Li8yQ==
X-Received: by 2002:a17:902:d542:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-22103c6237dmr382757815ad.0.1740070630122; 
 Thu, 20 Feb 2025 08:57:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v3 08/14] crypto/scheduler: remove unnecessary dereference
Date: Thu, 20 Feb 2025 08:55:22 -0800
Message-ID: <20250220165644.16421-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

