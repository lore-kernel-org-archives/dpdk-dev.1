Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84932C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7783A406FF;
	Thu, 20 Feb 2025 17:57:21 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 0004240672
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:15 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fcce9bb0ecso2178514a91.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070635;
 x=1740675435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlWnRnm4h4oH6JPJdd8SzoHMjlJdIh+gi5+mMYs/1Ao=;
 b=ZdpAqZiYs0KR2shOOchQsUlI8so+Up69wFvy4FQ97q+iEF91JLo6xsqKmMf8EagXrO
 PKA+OQOOAdW/zib5jw8rBTcVATxh4SVbx4S8ixyLgPVsw3YljZtXJx4mz6ZygKI3hdyC
 iHRha3A6nGTSvDKKf35gsv6NnacQpEZg7aLRXSXUK4878AIY/RmLnGApOAvvh2+ySphH
 o8oYQIII1Tf8Mg0XIPKqeb+zOHU8xxP7EWpkImTI3uFnI2fRpw3BOC+jIZWsq5uKe5Hs
 gbzuBhlet6T7IfKrJfv/+eKBBRTk9gAt8Y6HxWzKVBX3huyakRXfzJ6LkdwvdgO9r7x1
 6g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070635; x=1740675435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlWnRnm4h4oH6JPJdd8SzoHMjlJdIh+gi5+mMYs/1Ao=;
 b=CfFee77cF1OKbr9XXH1vlUlRq9ngv9+orM2UwI2k4gZ33c1YYuabxw5pnO+Tun+vJd
 fFe4hTAOA6WVFbQoTESEq/mh7CeHt3si2ku0i88Y7B5bEHbERKgBaTKmEZ684JpuY80F
 q1JBa5vqT7v4GEW3RzmBjjfHpewR08WInMyuAkVmjLo0+2LMyXcoVDsxl+0PKfN7LS7A
 3pknJ6ikWhvhDaNBV4vqEpjEu4C4ffa9567FHbVcnmmG1QMrwtExRgmUwZeVkLyRkStv
 FAU3ahmB7g3LKaVcqWv8C9QVMxeCOykPVDBP7usMGdS0aSQfTWcgECUw1Gt2ezOEP4Zx
 cQtQ==
X-Gm-Message-State: AOJu0YwQYYFpmh0lpQRF2Vyzwt+kfEQN8hF4mHyIdvqysz/2CyAbfY9L
 TPqOF8b0j6LwFwc+HI4MDp5vKHGXSF3iLVtlJVM2JtpE4Q96dJwhFOAE/kezXTqAwf35gWw4xYD
 a
X-Gm-Gg: ASbGnctoXB6kx7SOBysAlOIpgreEutgyXswYypEElsCvPXQRJT6BZ3Qu/1BdXPLdCKr
 6E7bL+xqLqerUVTuKYWuBxqqzZFylJisHj4j5lDLRg2wtNl8d71icriwGHpJaJSwJVlI9TV5HK+
 uDeO5S94Y8BuYsqg3B0emmgagS5xE1dZ9z8qTdXFfg6wwox9cGvL1+Kl/GTiq1fkizl87LqiO61
 ZLDZqQXgT9LEs5B4LfHXWJsbE1xHfFafR6GYI0GtLyPUMFG/j1pFUWBOuF0BlqtSyVJTnIYXoNl
 jNvLdoUMINXzc9KtItLHL1UWUrOCir2uUUXds5SIxoWIzrZ+onVGuvcbnzU9PeqH93Na
X-Google-Smtp-Source: AGHT+IHB/PWWkQ0cyAolpbOMFwSTBpmGyfrPHhSP6sXQwYNula1xel1KeeoCRn7u0/htVFFchgTooQ==
X-Received: by 2002:a17:90b:384a:b0:2ee:ab11:fab2 with SMTP id
 98e67ed59e1d1-2fc4104218fmr29634112a91.22.1740070635059; 
 Thu, 20 Feb 2025 08:57:15 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v3 13/14] regexdev: remove unnecessary deref of function
 pointers
Date: Thu, 20 Feb 2025 08:55:27 -0800
Message-ID: <20250220165644.16421-14-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_get and
dev->dev_ops->dev_info_get are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/regexdev/rte_regexdev.c | 72 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/lib/regexdev/rte_regexdev.c b/lib/regexdev/rte_regexdev.c
index b2c4b49d97..431ed911a1 100644
--- a/lib/regexdev/rte_regexdev.c
+++ b/lib/regexdev/rte_regexdev.c
@@ -189,9 +189,9 @@ regexdev_info_get(uint8_t dev_id, struct rte_regexdev_info *dev_info)
 	if (dev_info == NULL)
 		return -EINVAL;
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_info_get == NULL)
+	if (dev->dev_ops->dev_info_get == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dev_info_get)(dev, dev_info);
+	return dev->dev_ops->dev_info_get(dev, dev_info);
 
 }
 
@@ -212,7 +212,7 @@ rte_regexdev_configure(uint8_t dev_id, const struct rte_regexdev_config *cfg)
 	if (cfg == NULL)
 		return -EINVAL;
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 	if (dev->data->dev_started) {
 		RTE_REGEXDEV_LOG_LINE
@@ -289,7 +289,7 @@ rte_regexdev_configure(uint8_t dev_id, const struct rte_regexdev_config *cfg)
 				 dev_info.max_rules_per_group);
 		return -EINVAL;
 	}
-	ret = (*dev->dev_ops->dev_configure)(dev, cfg);
+	ret = dev->dev_ops->dev_configure(dev, cfg);
 	if (ret == 0)
 		dev->data->dev_conf = *cfg;
 	return ret;
@@ -303,7 +303,7 @@ rte_regexdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_qp_setup == NULL)
+	if (dev->dev_ops->dev_qp_setup == NULL)
 		return -ENOTSUP;
 	if (dev->data->dev_started) {
 		RTE_REGEXDEV_LOG_LINE
@@ -324,7 +324,7 @@ rte_regexdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 			 dev_id);
 		return -EBUSY;
 	}
-	return (*dev->dev_ops->dev_qp_setup)(dev, queue_pair_id, qp_conf);
+	return dev->dev_ops->dev_qp_setup(dev, queue_pair_id, qp_conf);
 }
 
 int
@@ -335,9 +335,9 @@ rte_regexdev_start(uint8_t dev_id)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_start == NULL)
+	if (dev->dev_ops->dev_start == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->dev_start)(dev);
+	ret = dev->dev_ops->dev_start(dev);
 	if (ret == 0)
 		dev->data->dev_started = 1;
 	return ret;
@@ -350,9 +350,9 @@ rte_regexdev_stop(uint8_t dev_id)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_stop == NULL)
+	if (dev->dev_ops->dev_stop == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->dev_stop)(dev);
+	dev->dev_ops->dev_stop(dev);
 	dev->data->dev_started = 0;
 	return 0;
 }
@@ -364,9 +364,9 @@ rte_regexdev_close(uint8_t dev_id)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->dev_close)(dev);
+	dev->dev_ops->dev_close(dev);
 	dev->data->dev_started = 0;
 	dev->state = RTE_REGEXDEV_UNUSED;
 	return 0;
@@ -380,14 +380,14 @@ rte_regexdev_attr_get(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_attr_get == NULL)
+	if (dev->dev_ops->dev_attr_get == NULL)
 		return -ENOTSUP;
 	if (attr_value == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d attribute value can't be NULL",
 				 dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_attr_get)(dev, attr_id, attr_value);
+	return dev->dev_ops->dev_attr_get(dev, attr_id, attr_value);
 }
 
 int
@@ -398,14 +398,14 @@ rte_regexdev_attr_set(uint8_t dev_id, enum rte_regexdev_attr_id attr_id,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_attr_set == NULL)
+	if (dev->dev_ops->dev_attr_set == NULL)
 		return -ENOTSUP;
 	if (attr_value == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d attribute value can't be NULL",
 				 dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_attr_set)(dev, attr_id, attr_value);
+	return dev->dev_ops->dev_attr_set(dev, attr_id, attr_value);
 }
 
 int
@@ -417,14 +417,14 @@ rte_regexdev_rule_db_update(uint8_t dev_id,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_rule_db_update == NULL)
+	if (dev->dev_ops->dev_rule_db_update == NULL)
 		return -ENOTSUP;
 	if (rules == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d rules can't be NULL",
 				 dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_rule_db_update)(dev, rules, nb_rules);
+	return dev->dev_ops->dev_rule_db_update(dev, rules, nb_rules);
 }
 
 int
@@ -434,9 +434,9 @@ rte_regexdev_rule_db_compile_activate(uint8_t dev_id)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_rule_db_compile_activate == NULL)
+	if (dev->dev_ops->dev_rule_db_compile_activate == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dev_rule_db_compile_activate)(dev);
+	return dev->dev_ops->dev_rule_db_compile_activate(dev);
 }
 
 int
@@ -447,14 +447,14 @@ rte_regexdev_rule_db_import(uint8_t dev_id, const char *rule_db,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_db_import == NULL)
+	if (dev->dev_ops->dev_db_import == NULL)
 		return -ENOTSUP;
 	if (rule_db == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d rules can't be NULL",
 				 dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_db_import)(dev, rule_db, rule_db_len);
+	return dev->dev_ops->dev_db_import(dev, rule_db, rule_db_len);
 }
 
 int
@@ -464,9 +464,9 @@ rte_regexdev_rule_db_export(uint8_t dev_id, char *rule_db)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_db_export == NULL)
+	if (dev->dev_ops->dev_db_export == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dev_db_export)(dev, rule_db);
+	return dev->dev_ops->dev_db_export(dev, rule_db);
 }
 
 int
@@ -477,14 +477,14 @@ rte_regexdev_xstats_names_get(uint8_t dev_id,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_xstats_names_get == NULL)
+	if (dev->dev_ops->dev_xstats_names_get == NULL)
 		return -ENOTSUP;
 	if (xstats_map == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d xstats map can't be NULL",
 				 dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_xstats_names_get)(dev, xstats_map);
+	return dev->dev_ops->dev_xstats_names_get(dev, xstats_map);
 }
 
 int
@@ -495,7 +495,7 @@ rte_regexdev_xstats_get(uint8_t dev_id, const uint16_t *ids,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_xstats_get == NULL)
+	if (dev->dev_ops->dev_xstats_get == NULL)
 		return -ENOTSUP;
 	if (ids == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d ids can't be NULL", dev_id);
@@ -505,7 +505,7 @@ rte_regexdev_xstats_get(uint8_t dev_id, const uint16_t *ids,
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d values can't be NULL", dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_xstats_get)(dev, ids, values, n);
+	return dev->dev_ops->dev_xstats_get(dev, ids, values, n);
 }
 
 int
@@ -516,7 +516,7 @@ rte_regexdev_xstats_by_name_get(uint8_t dev_id, const char *name,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_xstats_by_name_get == NULL)
+	if (dev->dev_ops->dev_xstats_by_name_get == NULL)
 		return -ENOTSUP;
 	if (name == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d name can't be NULL", dev_id);
@@ -530,7 +530,7 @@ rte_regexdev_xstats_by_name_get(uint8_t dev_id, const char *name,
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d value can't be NULL", dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_xstats_by_name_get)(dev, name, id, value);
+	return dev->dev_ops->dev_xstats_by_name_get(dev, name, id, value);
 }
 
 int
@@ -541,13 +541,13 @@ rte_regexdev_xstats_reset(uint8_t dev_id, const uint16_t *ids,
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_xstats_reset == NULL)
+	if (dev->dev_ops->dev_xstats_reset == NULL)
 		return -ENOTSUP;
 	if (ids == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d ids can't be NULL", dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_xstats_reset)(dev, ids, nb_ids);
+	return dev->dev_ops->dev_xstats_reset(dev, ids, nb_ids);
 }
 
 int
@@ -557,9 +557,9 @@ rte_regexdev_selftest(uint8_t dev_id)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_selftest == NULL)
+	if (dev->dev_ops->dev_selftest == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dev_selftest)(dev);
+	return dev->dev_ops->dev_selftest(dev);
 }
 
 int
@@ -569,11 +569,11 @@ rte_regexdev_dump(uint8_t dev_id, FILE *f)
 
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_regex_devices[dev_id];
-	if (*dev->dev_ops->dev_dump == NULL)
+	if (dev->dev_ops->dev_dump == NULL)
 		return -ENOTSUP;
 	if (f == NULL) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Dev %d file can't be NULL", dev_id);
 		return -EINVAL;
 	}
-	return (*dev->dev_ops->dev_dump)(dev, f);
+	return dev->dev_ops->dev_dump(dev, f);
 }
-- 
2.47.2

