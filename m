Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7A7CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC6640BA4;
	Fri,  9 Oct 2026 01:37:47 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4290D40B8F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:46 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-88b7d853b11so2992552b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502665;
 x=1792107465; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=foHSEAK05ws0JY7Yq5L2TNaWHOsP27nNNQN0SP1GeVQ=;
 b=CwRpEdngzoLLR4b5EgRCBpwTw+UCqiJtaE+PgfILdLAlPQmOg26CezTxIitzvbli2f
 nXKo7syiUh0DHF+MJZUaNzbUdIdVGKVBfN3O9CuOR/+IM2AkPOF7SNdaL0EiR/bu0FFU
 T57eUK7P5IbXdJLkzVbpO0Z5q4CatWjyJGPmpddd0pzMKdRaKPEJR/Om1hy5ZsIbjDEe
 +ZiJstH9lIdklhUK7/LalqFS4Fn/83YD4cjLDh0G5uG2dDn5KUl+o3F0dEorQ9eWiUj5
 RnKcz2T/Iy/m7tgpMWtanKrDOy0ldSbRyoKsBAf7/EYJGL9FIq4Ye5XSelJJ4akuFSRj
 MotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502665; x=1792107465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=foHSEAK05ws0JY7Yq5L2TNaWHOsP27nNNQN0SP1GeVQ=;
 b=ESflVNu7q01gxSWJrUGXsOhu8RUouCBYvNRj/BISJcOAuzSe/x42n8sEYyFOdjNFI2
 VfoGdCaYgVHyKr5ki2bxb+RBCMLfVwLESM5fnkB9GJdLadayiow9KT55XPyxYeheNfZx
 xJE3BzMtoJLS2qFDFeUs2g6EOe+5nde0J2kG2LvVqIRfi09+H5cJZrW3spZB0HBWOIzW
 6yl2mk5Nd1pm1J+NHbA67cYEpGx/304hodSKhe+qpZt1BlWJ/NhRUEJxFsS0oix12vVd
 6TPpz3bfhmqcBZe5YO6JJ5yxNSUoNZvwkWuVn4LybDOCPwkqOmzKpj7Gg2zDQFOFp9pv
 NKow==
X-Gm-Message-State: AFq9FYIaX9P2BEjUAGsnEOrMDDphrWrAbfcivo/pGnjppN7tkOmvdHus
 /Bj93XnuUh7FRQ6xpiJ8rnhYc2xYzomgOW0xFLpDFTLzSkTc0jhsIDd9M9KCkhyL7252jT83lRD
 GhWWqMv4=
X-Gm-Gg: AYBFou392oLl3rsDmFOMrvi/cxHq4xX6brZ5VSbum+hEK2745XckDTOtS9QhZ8ffJxz
 QXkoVJZSWf1TEbvAmR1r8YihfK6evsaM0lZiGbpj2IppsPigvjyzOtDCNqyHSL8XIkiO3ARo67x
 pnkmIR9r5WH8Vhjj2Cem//F0TZjL5PSJaWjHOXVbGlsO3v+hjgQULuWr/mpt6qt6us8c4OuA918
 0ldbwJjCxyPnuPbwH2fu7YqfIw1uiCeU3rj80NoVDR1PE2jUaHRSlsRnsgLDLEUqH46t7F3zpfi
 7bHFUFmtzGcrgD/hgjkKXIh3GNjuSViZx18uQxvlrKFzt4QOmUDwgJl8L3mOOGhFWpZ72Kbo+NF
 fGHgvRIZzz9ST+iE96M/YqWbOSGYJyjfp6iG6XIES/A/8fJbDHUyAf9296bKKUmHTEG1LGf/gCV
 gp9GebcGyy6Q/Xiy5McbNkv9BurTolTVkn+pgcAEJd4ewN/hcGLqhHzG1TiGPBDil1LnOT8r/9U
 pkKJT/wQwiQzyhS6cLDIZr+hCcLwJiW6wVKxBNOFhSTqHrk
X-Received: by 2002:a05:6a00:4fd0:b0:882:2195:5a6f with SMTP id
 d2e1a72fcca58-897c81b2a04mr49095b3a.43.1791502665389; 
 Thu, 08 Oct 2026 16:37:45 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH v3 26/29] event/opdl: replace SMP barriers with C11 atomics
Date: Thu,  8 Oct 2026 16:35:19 -0700
Message-ID: <20261008233649.1260843-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

Publishing the port becomes a release store of the configured
flag. Control path.

Drop the barrier after clearing started in opdl_stop(): no store
follows it, and the datapath tests data->dev_started, not
device->started.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/opdl/opdl_evdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..44a648a11a 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -200,8 +200,9 @@ opdl_port_setup(struct rte_eventdev *dev,
 	p->queue_id = OPDL_INVALID_QID;
 	p->external_qid = OPDL_INVALID_QID;
 	dev->data->ports[port_id] = p;
-	rte_smp_wmb();
-	p->configured = 1;
+	/* Release publishes port setup before the configured flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&p->configured, 1,
+				  rte_memory_order_release);
 	device->nb_ports++;
 	return 0;
 }
@@ -474,10 +475,7 @@ opdl_stop(struct rte_eventdev *dev)
 
 	destroy_queues_and_rings(dev);
 
-
 	device->started = 0;
-
-	rte_smp_wmb();
 }
 
 static int
-- 
2.53.0

