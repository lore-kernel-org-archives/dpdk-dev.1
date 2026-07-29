Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7265EC53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 945A640E20;
	Wed, 29 Jul 2026 19:57:53 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id E030E40A72
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:45 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso11312935ad.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347865;
 x=1785952665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9SRYJA6kGluYRuHR+7eOHy9YKHPYkjSgvmYyE4dZVz0=;
 b=ruFxa66NAXGT/gxs6hwYj4CjQDXDbfCSlemXi7raCZPYCSDZ4O5T5Htiwrd039I+II
 iQ+ReAlBfN7DpLlOly/WyrItd5IG1GPqqZCXpZQv4zejdVUcStn97vxai7OHUKywSxhK
 ZiBqU9fqOIzxTP3NUTG8z3D+GkTWskRDNTrYws2Ihn26L8DaogL/FKyMt8NeTLYnBEgw
 1ohT8iErAV0r0N51vyz2slaq4eqGLZi0W0eGURKvqZ4iCLHc+ytCU93kmFpzNCO2shNh
 CnCnjCZziKDuGa0uyugar42vpmFXCfrt6cGaAeZiP2Io9zpYxWkArqqWtfoJ2pcr7yMo
 VuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347865; x=1785952665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SRYJA6kGluYRuHR+7eOHy9YKHPYkjSgvmYyE4dZVz0=;
 b=d4fV3qUPY400B1V4QZuefVwk1BhNM8d87BNzocJXRHSERTNMSE9+4uiV2Pn4/JBG1S
 s0LLGN/08rXQHZVmqQlWlv77+gG11WxNyoSQk/mApHPIjzA/P9Lx4EihqRcswGbykizV
 EWlwT+8/N8+VpogUYBNH8I4O+R7vzEqxiuan/HLDV1a7kjwQxfL0TJyin+5+v4H/ooo1
 x2I6yrygP3HOsjyB0dY2MuGX15gy8S021KhTuNoQU/3aESC0BwrETNRouEPHWe5jAU84
 9QyrMNZJ1lOdTE2RQruS9sJHtmoniXsIyGoKaSquSU5flnteVIn+2nmPRGtR+SvaKBWw
 0WYw==
X-Gm-Message-State: AOJu0Yxs1kZZ61rvK+lLOhMsZa8StMqJhmEt4SmpgiqIQoiqqOhurW0z
 qKZ5/+3SQnB1s7oAIrmu3L49OmJKZ3Zq/zde/ihlFz64JX+QuvIk/ZaSYnJolFyBJ+SKDOF32cB
 jRihn
X-Gm-Gg: AR+sD11x82mmuNsg95PsOITTbA1doAhvrPOFmzVidZ5nPoqgVWcAgiFOzBIhE3nyFQi
 uznHVKCn0CZllhBqhI3957nStsi9HELcB0y7v5PYYk495JvYgBYPfmLUOKaSNlA4VY7LJJ5ayHE
 TKB8vyQqdJUtgDoNO3FomuGCmeeqMm2wZTy9TJPCPFEbmVPGmmPFq+RQVpRqq7e+fdN6Bzg+b8B
 9XnyuE8T1w5Xl2R2dB/EVYLc/MWiUIIb16WMWVqu+DTZh0tY31DYbkYpl+/fG8efjf1c4wotDWM
 a2W/bnkLAlC+1WWiYRfSxQG+ncmQd+bP8AnAIe2AU+Vgkgb5ZRFY+yuFSsBd/np7IZ74cvaTKyB
 qu/KCIi9J46vNpseQMn4VY5ATdSWmgg0UfO0Up/R1VtphkZPnuQpw8JBZ4rMuywU7BxyRwufs7w
 30wxe35FXutCGMXOR5H/1QHRaSi7Mpz/NErJDZSQggOnNHpFaI9XALHUBzXyOGyaFWV/HqZ8IH6
 6zOWIUVZrDoepBckfj3RaCN7zg=
X-Received: by 2002:a17:902:f78e:b0:2ca:d151:383a with SMTP id
 d9443c01a7336-2d015a996dcmr90987565ad.20.1785347865048; 
 Wed, 29 Jul 2026 10:57:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [RFC 25/32] event/opdl: replace SMP barriers with C11 atomics
Date: Wed, 29 Jul 2026 10:54:18 -0700
Message-ID: <20260729175715.165120-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

Publishing the port becomes a release store of the configured flag;
the barrier after clearing started becomes a release fence. Both
are control path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/opdl/opdl_evdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..1450fa5ae8 100644
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
@@ -477,7 +478,7 @@ opdl_stop(struct rte_eventdev *dev)
 
 	device->started = 0;
 
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 }
 
 static int
-- 
2.53.0

