Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A84C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 153224065B;
	Mon, 17 Feb 2025 19:58:03 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id ADC6D402D5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:57:58 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-220ca204d04so61190655ad.0
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818678;
 x=1740423478; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/bxf8qzNWdW8246ph2J1w6UQe+pk0syQJXMe5xihd0=;
 b=YaKOUMmUd9W3dRBH5bsvfKxKincEQfv4IUTi185aUSO4y9yHN43/WhaZ5MwOeyWgly
 RGCNBksJ9KGjfFoMXHdv0s3bvFEq7VyH4Zvs4ktW+MvyYZLmU7NxLX8uoNKq/CiQY/5s
 FOv13/jaYzHVXnkTWRmh1sE5fWUMtxi28NUasR5eSQWRasZsNeCuObaJulq3U1Hv3DKN
 eT+Tahezm+03Rmj8X+aIvFTn4vyLV89h7ulOINH6f2TOTuQlM3E+hQBzggJRXX7x6xhe
 KEkeoN/B+SyhLffh4y7YNtIthBO7BCjI9qYUVa49CCSoMM/Aad9T5OOtBXLmhHNL0qjN
 YIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818678; x=1740423478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/bxf8qzNWdW8246ph2J1w6UQe+pk0syQJXMe5xihd0=;
 b=uGEIg5wcvAI0wVlDcGJ20an6mPdMwe+5y2PA7pkWrGu89qdjmvF4YT216XQHyWqHat
 PiykofB8qq98AvJcYmMWcV4IlTKF7VZVyBaZiJfX+zrHG7SheRaiubkrz5Y5a3Z5jKbL
 8l6OarVRO6Z3J0UiQXvPgiz3MwzgTliBAa0Nh5SdCkEXwF5EDAzP+GEsr/7/SKVXm79S
 1BYYXnlrHaEP6KWUbsJuQJV7K3/JBIqJtyEkH7bEgxVkHtRpURUuRoEgLTdbNO3631Qs
 VGq+97KymY3eicaQ44y8ic32SqOwHRHd/kbrHNc8DjRPW053UahHNhKR5BhwfFR4yMsQ
 3WWA==
X-Gm-Message-State: AOJu0Yxz3o69gt9OphSoZfRMq3GuESe3mz9uDDWGqCSsiuoZ7X7jYW+E
 EwvHUIqZo/UIS1AYTbwRLV12F1mXcmfhycqJqBMxilv2XnTkNPMPy8CLVOtSHhldJgacud/F64g
 ZUik=
X-Gm-Gg: ASbGnctMNOGIEX2Q2szP8pxiN/OG70+phlsTJFH+izNewtNuj0hHHaAT8nkVdHDVNdm
 22C67+fH63kcXEigfjuJSQWXLnITAM5Lb6R2dflu7zz0twy1yXjbq2B59AEHR3SIxtZPwm7JUk3
 KDvuwXn0OeC6A9agIrsNdxXO0hSHVCaOpZ6gCrIVugIx/NeSwF1V1m5EYbdx5+Aa308BUsO61IX
 7u8pvcGeM6Dg0jbpSW42La9DEJZx5otoVFneY01hlSxjUIUOUSC2ntK77RpfLtfPGK2bQExcKV3
 xRBNXc8VPkfZ+Wn3y9XZOs1UDTcZqIjOJ2zPnrcRSUkFp+DaQ1JSEuGgunQqbhfZNsjw
X-Google-Smtp-Source: AGHT+IHlSvh9IqmoC4L85Tkij/CjtXxALE64+GfIJg5kfPtKP9XGb7s8Agc4+s8vm3qFdt1mPlWHIg==
X-Received: by 2002:a05:6a21:6b05:b0:1ee:5f3f:cde0 with SMTP id
 adf61e73a8af0-1ee8cbf7bcamr21523372637.34.1739818677870; 
 Mon, 17 Feb 2025 10:57:57 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 05/11] cryptodev: remove unnecessary deref of function pointers
Date: Mon, 17 Feb 2025 10:54:04 -0800
Message-ID: <20250217185743.169778-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

