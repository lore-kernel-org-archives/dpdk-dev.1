Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0EC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D26940697;
	Thu,  6 Aug 2026 19:16:52 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 6D4B940A6E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:51 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8efbafa1bacso14079686d6.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036611; x=1786641411; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=neWwG0ocnoh44VZL+K+jWg8PbDE/zt+quzT6ph+vqt8=;
 b=fiTiswnlWnyXzdOCrKTOy3DlBttRPesayucx85ZltrN/ecGSW7Bm1xFVfdlYlUl2O8
 4kJfNM4ooCHNXhT433XXb/KBs4smPCy2RkYo8TWqnGey85QkzzVpoH1DHhxLOFPYIStB
 QoyTybTYMiaJ0TlOZFwKmWLhrje4nMFAsFvSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036611; x=1786641411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=neWwG0ocnoh44VZL+K+jWg8PbDE/zt+quzT6ph+vqt8=;
 b=pM4LcASF+fuBlqlu6+1kikurdPaNNrsSX4ZF6cqcWEXAxSiGIXYkbEmB5lfzxUplAu
 N9T/CdPeB7Bxx/O8aJy3dSVCYaCIfhJHkR249csngjGJSQdN7bphxl5MOtX02A9AeYVa
 MGS3IUpfFC3xmS0wmMBKU8kOjQGWTwsDucKrzfCVV0gmudFjn++XGyfaNDW9pjmAGLhM
 Bz7pi5Ia3+W/emBlMOAmEAKt7/vNxhn0hUylXoXT4oGYlmOowdne9QTiihSBqpgEORTH
 R1ykNOZ1n7EGEUvi5RDeyNCATh+2N3a7pusxRIktBqzO0pDD2bSyZ89FwOm0dk4Ygh6S
 esOA==
X-Gm-Message-State: AOJu0YwL2IobdoKVp3M9Rn+jtnwo8W4TYMqJtnf6RnaDcTZLdOZCxnf2
 R0g/3Jaq/g557OxoweddXZiLfGrnmZ75FUVx1qNXszeMDsF8OX6qVEdjzR5RP1TjjNFjH7+zW4N
 lHdj+sVkPhiXCjRahSmCxDtybi3PHEChpRHcjhSRmv1TFzu4B4HGWAO1qd0fqFK31jK3r5Gdo5A
 lXrJ3RZV49C8Vi7NOitUcIrcTIikM=
X-Gm-Gg: AR+sD10LdEXn3/iPjm2kTac9KBqCmrep1GYCEx2W9k3rrPKHy4NVIZI2koH6KEo85mC
 JE4DZs9UdaLnmdDgazzOav1eIsNVVijpa1T4qyHy8D6/azi85xI0ntGvSu0Wmh6sNIJX9Abx6i5
 J6+PuWVfAgsc2UZ+vzF664vNSQzrEGxoSgxGLNay5t7SbMxBeP+rfHsJ5T/ARYaBvig0A9e642E
 F0OQ2O4bU3mDC9A1ph0LXx4+CIixpou0I3XVqyrSqBxkrQMlLCHugWf+PWVne1O8q/MeGptfIE+
 jhtoyEm643IC9rmsMmuzqbZu8IWEXECbsBk2XVo5QI12a6JaTPQNBNL8TOuMP9bjm5McJWNGxe8
 Cvj7wvr0qygACMrbv/6PeM8tmDKn0QKiomhQ+5hxVLscYu4CTL2HxoVkNj4zWVO+DcyvFdGlrXb
 /UWGimYc74jlgcex5erx/SRq80anYwepdpVH1qulT5CdvvyZ6KYctAhZG40xLN3SDGrU9fGRVEf
 hLrQRLNN6hIDYD6+w3b7BPpRkfhZbvxk30fsmYq
X-Received: by 2002:a0c:f014:0:b0:908:8f97:7d8c with SMTP id
 6a1803df08f44-9088f977e8emr118017406d6.4.1786036610659; 
 Thu, 06 Aug 2026 10:16:50 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:50 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v6 5/7] net/mlx5: remove versioned symbols aliases
Date: Thu,  6 Aug 2026 13:16:34 -0400
Message-ID: <20260806171636.656181-6-abailey@iol.unh.edu>
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

Version function symbols added in
commit 556b2a33727a ("net/mlx5: add aliases for some promoted symbols"):

- rte_pmd_mlx5_driver_event_cb_register
- rte_pmd_mlx5_driver_event_cb_unregister
- rte_pmd_mlx5_enable_steering
- rte_pmd_mlx5_disable_steering

are not needed after ABI version bump.
This patch removes versioned symbols.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/mlx5/meson.build         |  2 --
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++----------------
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 0fa6322779..82a7dfe782 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -2,8 +2,6 @@
 # Copyright 2018 6WIND S.A.
 # Copyright 2018 Mellanox Technologies, Ltd
 
-use_function_versioning = true
-
 if not (is_linux or is_windows)
     build = false
     reason = 'only supported on Linux and Windows'
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index 52e6ad7824..89e49331c8 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -236,8 +236,9 @@ notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 		notify_existing_queues(port_id, cb, opaque);
 }
 
-RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_driver_event_cb_register,
-		   (rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_register)
+int
+rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque)
 {
 	struct registered_cb *r;
 
@@ -263,14 +264,9 @@ RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_driver_event_cb_register,
 	return 0;
 }
 
-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_register,
-				(rte_pmd_mlx5_driver_event_callback_t cb, void *opaque))
-{
-	return rte_pmd_mlx5_driver_event_cb_register(cb, opaque);
-}
-
-RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_driver_event_cb_unregister,
-		   (rte_pmd_mlx5_driver_event_callback_t cb))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister)
+int
+rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callback_t cb)
 {
 	struct registered_cb *r;
 	bool found = false;
@@ -293,12 +289,6 @@ RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_driver_event_cb_unregister,
 	return 0;
 }
 
-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_driver_event_cb_unregister,
-				(rte_pmd_mlx5_driver_event_callback_t cb))
-{
-	return rte_pmd_mlx5_driver_event_cb_unregister(cb);
-}
-
 RTE_FINI(rte_pmd_mlx5_driver_event_cb_cleanup) {
 	struct registered_cb *r;
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index fb90caf178..b0eac185b5 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -12537,7 +12537,9 @@ flow_disable_steering_run_on_related(struct rte_eth_dev *dev,
 	}
 }
 
-RTE_DEFAULT_SYMBOL(27, void, rte_pmd_mlx5_disable_steering, (void))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_disable_steering)
+void
+rte_pmd_mlx5_disable_steering(void)
 {
 	uint16_t port_id;
 
@@ -12561,12 +12563,9 @@ RTE_DEFAULT_SYMBOL(27, void, rte_pmd_mlx5_disable_steering, (void))
 	mlx5_steering_disabled = true;
 }
 
-RTE_VERSION_EXPERIMENTAL_SYMBOL(void, rte_pmd_mlx5_disable_steering, (void))
-{
-	rte_pmd_mlx5_disable_steering();
-}
-
-RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_enable_steering, (void))
+RTE_EXPORT_SYMBOL(rte_pmd_mlx5_enable_steering)
+int
+rte_pmd_mlx5_enable_steering(void)
 {
 	uint16_t port_id;
 
@@ -12583,11 +12582,6 @@ RTE_DEFAULT_SYMBOL(27, int, rte_pmd_mlx5_enable_steering, (void))
 	return 0;
 }
 
-RTE_VERSION_EXPERIMENTAL_SYMBOL(int, rte_pmd_mlx5_enable_steering, (void))
-{
-	return rte_pmd_mlx5_enable_steering();
-}
-
 bool
 mlx5_vport_rx_metadata_passing_enabled(const struct mlx5_dev_ctx_shared *sh)
 {
-- 
2.55.0

