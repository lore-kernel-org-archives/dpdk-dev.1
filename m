Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B3C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 586DB40615;
	Thu, 20 Feb 2025 03:35:38 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id EDA78402F1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:27 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-220c4159f87so5380605ad.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018927;
 x=1740623727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/bxf8qzNWdW8246ph2J1w6UQe+pk0syQJXMe5xihd0=;
 b=xcVto4dQazl9Q+7Z2zWFAFDV6r8NV7o0FiZgVGaDUwZTg4jT/2xl3b/S38UNDHfvYf
 DbyGbTVaQ+6imT8RvVWyGUdwWmvCf3HFzTF5TQe2LxlriTXC0XERcwvrDAw6HNcC0CdL
 0X2ekAdiXj1Yg81vamjRmuiVUjCXUZm1vRo3J2o65+QSyhBArKYkPjqPLvM0nq9ACaRD
 b9fqSAc7gONoR2CMbs3k6IFkkYF6LqbTDWfKq+DbZQ3+xlWjH3aSK6RTyr70BED8Vt50
 6KAjnFBUtlUkNa7Xt9icn1HyA7AQBdk/DH1UF/0yQ2JufcmnFQUOvMrcimyBJv78iTpS
 g26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018927; x=1740623727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/bxf8qzNWdW8246ph2J1w6UQe+pk0syQJXMe5xihd0=;
 b=SBie05S1oMgFGNceoSy86Fr/vbNf+44v5XfTwidM0WwrMRiFwzdTARvSTOBFpIDcvm
 +bjx+k3LfZfFV4jwVqb8mxu9286TnSkAFI47eWItVWc0uT1jlCdNS8i3M+3xn8q+SupK
 DV8hXdAaCkxNBo2/2yBe6oPmmeK+izuOCcKaC9/rCEvp7KL35u9570Mu9WFTlRjGwoy8
 xhy8k7mf4p/lbGYhbY4lfA9G9iqbA5AKNhNedUu4MgWf5Mmvgz3wevUMlO+P8umn38ho
 O4Qie9MFK0JksyuOhwLiRwCbB3uo+ZOfAPSLvPQR03xy3zOV3tp/RS8TC8K+WK2Wpfvc
 fMvg==
X-Gm-Message-State: AOJu0YxdDjks0hLKceHNM7rUHgetg8PvgfyL+BddVv5PauAtsMo8k+xl
 ewpCR6i+bjA5HyUL0+wIVPsJe3ZLVistSfMDCpNL0nDZu+HYwp3yzCa3wz0RZCx1f/TM+p0AZ+V
 Jy4o=
X-Gm-Gg: ASbGnctvOsAAvFORoCPr32YA0mEWrXt/8Ccsdk2epYCtJvAJu0Jl/NTz334jeO0HCv9
 skGimbEsFZMWNGvSNXxTYztl6tRRF1NJZ2Fjg6U0xXnyG/geQ1y4gkcHJ8UQy6f0jhPwgm3rSDt
 RAqVw9nzjAI3Y2lI5MbUSu5dS6roE/9spDaIl1pZMGKxp/OqhKcSv8T2jwgpUgh95xv8uJql9fs
 NSxk63tnD1kQm5U3Gpdweg5FkDEHPP9oDn8VP3CS3ofKfBzk2LyKB7C3g6sfhUzduVpkg8AbvaM
 7OwuenFb9Mv7xunhlphHKVRg5gflLA8cIcqy5RbI6/mWWPmYcmZ4i+VeIrG9YKgtBFQD
X-Google-Smtp-Source: AGHT+IHuzea+TkKlESrZ3uAHBYtRF74kwol1icM8B2o1C65FU7ZcsTrHbLckVKZsUXGNMxVz2i800g==
X-Received: by 2002:a17:902:c411:b0:220:efc8:60a8 with SMTP id
 d9443c01a7336-221040541aamr368630125ad.28.1740018927124; 
 Wed, 19 Feb 2025 18:35:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2 07/14] cryptodev: remove unnecessary deref of function
 pointers
Date: Wed, 19 Feb 2025 18:32:11 -0800
Message-ID: <20250220023509.630569-8-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_gets and
dev->dev_ops->dev_info_gets are equivalent.
Cleanup and remove unnecessary parenthesis as well.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/cryptodev/rte_cryptodev.c | 72 +++++++++++++++++------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index a49b0662f3..8df36ea057 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -1194,9 +1194,9 @@ rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
 
 	memset(&dev_info, 0, sizeof(struct rte_cryptodev_info));
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->dev_infos_get)(dev, &dev_info);
+	dev->dev_ops->dev_infos_get(dev, &dev_info);
 
 	if (nb_qpairs > (dev_info.max_nb_queue_pairs)) {
 		CDEV_LOG_ERR("Invalid num queue_pairs (%u) for dev %u",
@@ -1224,11 +1224,11 @@ rte_cryptodev_queue_pairs_config(struct rte_cryptodev *dev, uint16_t nb_qpairs,
 
 		qp = dev->data->queue_pairs;
 
-		if (*dev->dev_ops->queue_pair_release == NULL)
+		if (dev->dev_ops->queue_pair_release == NULL)
 			return -ENOTSUP;
 
 		for (i = nb_qpairs; i < old_nb_queues; i++) {
-			ret = (*dev->dev_ops->queue_pair_release)(dev, i);
+			ret = dev->dev_ops->queue_pair_release(dev, i);
 			if (ret < 0)
 				return ret;
 			qp[i] = NULL;
@@ -1256,11 +1256,11 @@ rte_cryptodev_queue_pair_reset(uint8_t dev_id, uint16_t queue_pair_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->queue_pair_reset == NULL)
+	if (dev->dev_ops->queue_pair_reset == NULL)
 		return -ENOTSUP;
 
 	rte_cryptodev_trace_queue_pair_reset(dev_id, queue_pair_id, qp_conf, socket_id);
-	return (*dev->dev_ops->queue_pair_reset)(dev, queue_pair_id, qp_conf, socket_id);
+	return dev->dev_ops->queue_pair_reset(dev, queue_pair_id, qp_conf, socket_id);
 }
 
 int
@@ -1282,7 +1282,7 @@ rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 
 	rte_spinlock_lock(&rte_cryptodev_callback_lock);
@@ -1307,7 +1307,7 @@ rte_cryptodev_configure(uint8_t dev_id, struct rte_cryptodev_config *config)
 	}
 
 	rte_cryptodev_trace_configure(dev_id, config);
-	return (*dev->dev_ops->dev_configure)(dev, config);
+	return dev->dev_ops->dev_configure(dev, config);
 }
 
 int
@@ -1325,7 +1325,7 @@ rte_cryptodev_start(uint8_t dev_id)
 
 	dev = &rte_crypto_devices[dev_id];
 
-	if (*dev->dev_ops->dev_start == NULL)
+	if (dev->dev_ops->dev_start == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started != 0) {
@@ -1334,7 +1334,7 @@ rte_cryptodev_start(uint8_t dev_id)
 		return 0;
 	}
 
-	diag = (*dev->dev_ops->dev_start)(dev);
+	diag = dev->dev_ops->dev_start(dev);
 	/* expose selection of PMD fast-path functions */
 	cryptodev_fp_ops_set(rte_crypto_fp_ops + dev_id, dev);
 
@@ -1359,7 +1359,7 @@ rte_cryptodev_stop(uint8_t dev_id)
 
 	dev = &rte_crypto_devices[dev_id];
 
-	if (*dev->dev_ops->dev_stop == NULL)
+	if (dev->dev_ops->dev_stop == NULL)
 		return;
 
 	if (dev->data->dev_started == 0) {
@@ -1371,7 +1371,7 @@ rte_cryptodev_stop(uint8_t dev_id)
 	/* point fast-path functions to dummy ones */
 	cryptodev_fp_ops_reset(rte_crypto_fp_ops + dev_id);
 
-	(*dev->dev_ops->dev_stop)(dev);
+	dev->dev_ops->dev_stop(dev);
 	rte_cryptodev_trace_stop(dev_id);
 	dev->data->dev_started = 0;
 }
@@ -1407,9 +1407,9 @@ rte_cryptodev_close(uint8_t dev_id)
 		}
 	}
 
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
-	retval = (*dev->dev_ops->dev_close)(dev);
+	retval = dev->dev_ops->dev_close(dev);
 	rte_cryptodev_trace_close(dev_id, retval);
 
 	if (retval < 0)
@@ -1518,12 +1518,11 @@ rte_cryptodev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->queue_pair_setup == NULL)
+	if (dev->dev_ops->queue_pair_setup == NULL)
 		return -ENOTSUP;
 
 	rte_cryptodev_trace_queue_pair_setup(dev_id, queue_pair_id, qp_conf);
-	return (*dev->dev_ops->queue_pair_setup)(dev, queue_pair_id, qp_conf,
-			socket_id);
+	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
 }
 
 struct rte_cryptodev_cb *
@@ -1837,9 +1836,9 @@ rte_cryptodev_stats_get(uint8_t dev_id, struct rte_cryptodev_stats *stats)
 	dev = &rte_crypto_devices[dev_id];
 	memset(stats, 0, sizeof(*stats));
 
-	if (*dev->dev_ops->stats_get == NULL)
+	if (dev->dev_ops->stats_get == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->stats_get)(dev, stats);
+	dev->dev_ops->stats_get(dev, stats);
 
 	rte_cryptodev_trace_stats_get(dev_id, stats);
 	return 0;
@@ -1859,9 +1858,9 @@ rte_cryptodev_stats_reset(uint8_t dev_id)
 
 	dev = &rte_crypto_devices[dev_id];
 
-	if (*dev->dev_ops->stats_reset == NULL)
+	if (dev->dev_ops->stats_reset == NULL)
 		return;
-	(*dev->dev_ops->stats_reset)(dev);
+	dev->dev_ops->stats_reset(dev);
 }
 
 void
@@ -1878,9 +1877,9 @@ rte_cryptodev_info_get(uint8_t dev_id, struct rte_cryptodev_info *dev_info)
 
 	memset(dev_info, 0, sizeof(struct rte_cryptodev_info));
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return;
-	(*dev->dev_ops->dev_infos_get)(dev, dev_info);
+	dev->dev_ops->dev_infos_get(dev, dev_info);
 
 	dev_info->driver_name = dev->device->driver->name;
 	dev_info->device = dev->device;
@@ -2017,7 +2016,7 @@ rte_cryptodev_queue_pair_event_error_query(uint8_t dev_id, uint16_t qp_id)
 
 	if (qp_id >= dev->data->nb_queue_pairs)
 		return -EINVAL;
-	if (*dev->dev_ops->queue_pair_event_error_query == NULL)
+	if (dev->dev_ops->queue_pair_event_error_query == NULL)
 		return -ENOTSUP;
 
 	return dev->dev_ops->queue_pair_event_error_query(dev, qp_id);
@@ -2237,7 +2236,7 @@ rte_cryptodev_asym_session_create(uint8_t dev_id,
 	/* Clear device session pointer.*/
 	memset(sess->sess_private_data, 0, session_priv_data_sz + sess->user_data_sz);
 
-	if (*dev->dev_ops->asym_session_configure == NULL)
+	if (dev->dev_ops->asym_session_configure == NULL)
 		return -ENOTSUP;
 
 	if (sess->sess_private_data[0] == 0) {
@@ -2286,7 +2285,7 @@ rte_cryptodev_sym_session_free(uint8_t dev_id, void *_sess)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->sym_session_clear == NULL)
+	if (dev->dev_ops->sym_session_clear == NULL)
 		return -ENOTSUP;
 
 	dev->dev_ops->sym_session_clear(dev, sess);
@@ -2316,7 +2315,7 @@ rte_cryptodev_asym_session_free(uint8_t dev_id, void *sess)
 	if (dev == NULL || sess == NULL)
 		return -EINVAL;
 
-	if (*dev->dev_ops->asym_session_clear == NULL)
+	if (dev->dev_ops->asym_session_clear == NULL)
 		return -ENOTSUP;
 
 	dev->dev_ops->asym_session_clear(dev, sess);
@@ -2348,10 +2347,10 @@ rte_cryptodev_sym_get_private_session_size(uint8_t dev_id)
 
 	dev = rte_cryptodev_pmd_get_dev(dev_id);
 
-	if (*dev->dev_ops->sym_session_get_size == NULL)
+	if (dev->dev_ops->sym_session_get_size == NULL)
 		return 0;
 
-	priv_sess_size = (*dev->dev_ops->sym_session_get_size)(dev);
+	priv_sess_size = dev->dev_ops->sym_session_get_size(dev);
 
 	rte_cryptodev_trace_sym_get_private_session_size(dev_id,
 		priv_sess_size);
@@ -2370,10 +2369,10 @@ rte_cryptodev_asym_get_private_session_size(uint8_t dev_id)
 
 	dev = rte_cryptodev_pmd_get_dev(dev_id);
 
-	if (*dev->dev_ops->asym_session_get_size == NULL)
+	if (dev->dev_ops->asym_session_get_size == NULL)
 		return 0;
 
-	priv_sess_size = (*dev->dev_ops->asym_session_get_size)(dev);
+	priv_sess_size = dev->dev_ops->asym_session_get_size(dev);
 
 	rte_cryptodev_trace_asym_get_private_session_size(dev_id,
 		priv_sess_size);
@@ -2474,7 +2473,7 @@ rte_cryptodev_sym_cpu_crypto_process(uint8_t dev_id,
 
 	dev = rte_cryptodev_pmd_get_dev(dev_id);
 
-	if (*dev->dev_ops->sym_cpu_process == NULL ||
+	if (dev->dev_ops->sym_cpu_process == NULL ||
 		!(dev->feature_flags & RTE_CRYPTODEV_FF_SYM_CPU_CRYPTO)) {
 		sym_crypto_fill_status(vec, ENOTSUP);
 		return 0;
@@ -2497,12 +2496,12 @@ rte_cryptodev_get_raw_dp_ctx_size(uint8_t dev_id)
 
 	dev = rte_cryptodev_pmd_get_dev(dev_id);
 
-	if (*dev->dev_ops->sym_get_raw_dp_ctx_size == NULL ||
+	if (dev->dev_ops->sym_get_raw_dp_ctx_size == NULL ||
 		!(dev->feature_flags & RTE_CRYPTODEV_FF_SYM_RAW_DP)) {
 		return -ENOTSUP;
 	}
 
-	priv_size = (*dev->dev_ops->sym_get_raw_dp_ctx_size)(dev);
+	priv_size = dev->dev_ops->sym_get_raw_dp_ctx_size(dev);
 	if (priv_size < 0)
 		return -ENOTSUP;
 
@@ -2530,7 +2529,7 @@ rte_cryptodev_configure_raw_dp_ctx(uint8_t dev_id, uint16_t qp_id,
 
 	rte_cryptodev_trace_configure_raw_dp_ctx(dev_id, qp_id, sess_type);
 
-	return (*dev->dev_ops->sym_configure_raw_dp_ctx)(dev, qp_id, ctx,
+	return dev->dev_ops->sym_configure_raw_dp_ctx(dev, qp_id, ctx,
 			sess_type, session_ctx, is_update);
 }
 
@@ -2556,8 +2555,7 @@ rte_cryptodev_session_event_mdata_set(uint8_t dev_id, void *sess,
 	rte_cryptodev_trace_session_event_mdata_set(dev_id, sess, op_type,
 		sess_type, ev_mdata, size);
 
-	return (*dev->dev_ops->session_ev_mdata_set)(dev, sess, op_type,
-			sess_type, ev_mdata);
+	return dev->dev_ops->session_ev_mdata_set(dev, sess, op_type, sess_type, ev_mdata);
 
 skip_pmd_op:
 	if (op_type == RTE_CRYPTO_OP_TYPE_SYMMETRIC)
-- 
2.47.2

