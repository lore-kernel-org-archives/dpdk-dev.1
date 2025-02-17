Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E37C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B32334067A;
	Mon, 17 Feb 2025 19:58:09 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8A7C94065E
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:58:03 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220dc3831e3so66258085ad.0
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818683;
 x=1740423483; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVJiBIrb59s63UWBpRcJwZpiWb2oJqbRtfGlEF2jcqc=;
 b=jUGcmowBhBZQaTmo8BRO9W+YpRsMjggvg5qPHjtTpJLIiGx1+61pm0SOh6hxYfPRYr
 DEV5vZfMT7GCCYcZvuaFcgvmLnmG9xJSSdmpsoLp/Wp/bym3ALH45W6H4+X1MbW7pYhk
 zr39wFXPc1caB9VJV2T6J+pCPjc/7vkosa0KMyEFKZAU9r2FYnXkRJhl25dBYssmBNQJ
 Xg4us8Wau3IUa1oEbTE0kCcuYEusPVE3vJEdu+5qZSuH63pbSwFV0QonXWBnh/ovtj/S
 cPkcOiadhzCymfqv5YYW80n90EGygIRIhMFC2S6zF8/eYGpkz1Gs9sP3osI1NI2sqqvz
 iqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818683; x=1740423483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVJiBIrb59s63UWBpRcJwZpiWb2oJqbRtfGlEF2jcqc=;
 b=EdqM722RtUxm4kNBCVk8Tjb1ivlwoZGXGtzecMtshUbWRzhT0wl4y0+3aRxG3M2WXQ
 LS6jHge/ynA0JrOw/xjc/D8tv67FNjJfIVIQRsNDW10dTCv//oz7xJLHM4GDe6fKw91q
 dZn+aPZBdx8z3T1cC7guFUBeSqrWadEutnbWR6afLN0ricVwHvsh7lSUDhIVlCF20Z1n
 yYKVVIEMVFh+BN+DyG05MITrzcEnIzDe3yhbw6gygCrm4gvVyVdRkzfvYF0LVex4iYcd
 Lgf5vIExyFy9IPODSaFef1JUeWwasdM6BFlIcb541PgHdKefSe9EOAUHbH2twY0BeIlQ
 TgDA==
X-Gm-Message-State: AOJu0YwjlnwyR+WQ9DtkejZZb3dQcxrPWf//KuAIEjpWHoE8+mDVf3or
 Fh9tLbHozWoNlfuAaFQy9NUCpoJMqffzjDalVJLDv13TOF+UN0Gq6t5f49nQoW+DRdhVjb7f9bG
 SKcE=
X-Gm-Gg: ASbGncvcAvVhWFg9zWlKv5RCDbgrUBvl6k/Wj8kWia4sYKWOYw7fPBEImznc4YET+gl
 gj9Gszoaa149GaNRQBDfzkQ7t5wfcnL9+5as/EtTEISXS+uDx76sU8ROIhOj1GjWf2gBpNDPH6u
 eVEjzR1eIqpb1s9ZR1ZM1Pi/QqFnvIvKwQ3WTj/UjAvU0OKRVgCtcFlJ3twdc60XBghTm+sKlNN
 xQAVSi5oAmSwx0k3EtcsmAa/iNmnNoc2ZYRKxY8m/XcLSk/kLMPA62KClyoUYE3b2X4N7sJMACG
 KrZ6eAye38mW1KtAiOoTxWvcYItn70Rq+dNQLbzIs8Fsh9u65K7LeKWrrO1fajDwaJT9
X-Google-Smtp-Source: AGHT+IHxvoZ0+EAnLhdhWhswZS+mRg1OwRWDQa4crzic+LOJVVr3lw8eU+e1eg5EXDhuDcN1Zw2nZg==
X-Received: by 2002:a05:6a21:6da7:b0:1ee:47e7:7e00 with SMTP id
 adf61e73a8af0-1ee6c6ad940mr30068841637.13.1739818682765; 
 Mon, 17 Feb 2025 10:58:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:58:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 11/11] regexdev: remove unnecessary deref of function pointers
Date: Mon, 17 Feb 2025 10:54:10 -0800
Message-ID: <20250217185743.169778-12-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_get and
dev->dev_ops->dev_info_get are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

