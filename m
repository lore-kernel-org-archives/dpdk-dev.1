Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2008C021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 319A14068A;
	Thu, 20 Feb 2025 03:35:45 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1FC9840663
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:34 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220e6028214so7925005ad.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018933;
 x=1740623733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVJiBIrb59s63UWBpRcJwZpiWb2oJqbRtfGlEF2jcqc=;
 b=TGcHpD63MWqIi+9smXEnXp32U32mnfWIEwMPqgaqSn8eDXOQVSzh4svrQb7Tieylq3
 hqWyJdhseJDQj+B+yfaaou+23P8fnbJDsvqDxqBCM29dG3z1VAs7KRnQ31QZM5nmabuG
 ukEotoz+Z97I5YywbxELlf4l8tUlnMoqsDEalFse3vyx3hageHf31L/Ioi+uTjMqoKG0
 sIilbF14FSxAzdyQUT1xOmlkg4a6qFAnFGEM7PjhPHfhfN9R+o4Z0JSA6qQwN1W771Of
 U1ffb7GfS5Y4A1Waz5DMhyK6mQMSKOdMbPFCSroWtBNSiqf6KhgwGoZ9B40tOrqKgzHN
 Mltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018933; x=1740623733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVJiBIrb59s63UWBpRcJwZpiWb2oJqbRtfGlEF2jcqc=;
 b=hZ1aXhDvJuXpQwZYggv09BfKxnN1WXVoj3PWg5QdWo+QgnSNXjXJLx8TnimZWo45mC
 SGgyUFQL5Yin/mAaDDvvdL0xmb6YAjRKHB++/oXKyF76zL5/ck/KVFodZ0JwOnV8RnMo
 5fvn3qKM0AW5gQOLOCuBcjKEXRygevdKd3kx+CdN2qXmFkzkgY74vhjEIwiOwEVVQj29
 aZbhHcA7Vf4H3UlJ8c6e0c7ydNwDbMk09n8pg2vi4X9GrHH+xdfrXgw9i/HJ4xzpE+fg
 +Cw9gmU2jUOFbAtdr2tslQvuC/cap/WRMP80ntslsQbT9agIifPbwtfrsMbF7KQAnQcd
 Yilw==
X-Gm-Message-State: AOJu0YxUSgUvoOvds3qURg/gE0ID/SKCp+TlAFF6wpRGF/7lg8sUFonZ
 HOUUMqtnt1DtawuTgDXyPWrkOH01XMEBo1t0q8S6+3qlN2C7Ds4mcpi5KmzEbznCCYAs4eHvtIV
 Li/U=
X-Gm-Gg: ASbGncvDLuFXIlBgsBzx4wp8+ZtWbos/QQPmWED3eR4ZxZheI40P8uuwlfCXf0W4R+Z
 iLOsfiGAzn5kQYZFlL9e94Rk/iNZm4olrB5PEw18KNHGd5FbLqpX2UOndEoRKAd3O+A6exrSb5u
 pjYt2Px09aP5lbEGve7HPQnKtqh/KWCnpH0ZRg6apFXWn1+kKGuoCmQNviswnijBrz3h9H9nPwp
 0uh01pNRGnMQaUT+PDL5uUHmfZY9eOsEJ6Wz/kjD4Cn54CtFRIpXBxHUtrnYDbFyrK2bDEOc1Vw
 sLMnevTz/aK3ZAlTV04fpxo+xkyx3As1dGJeAQOSxWF9Was7NOJG4DzIWq7NXA8UIhT9
X-Google-Smtp-Source: AGHT+IFRv3ZvFaYa3BS2unu1I9ekAYWAhChew2Ljj6FB697zkxz4/o9cCBdAVGTyQIEviH66Lt2A+Q==
X-Received: by 2002:a17:902:ea0b:b0:216:3466:7414 with SMTP id
 d9443c01a7336-221906a61e7mr12729125ad.44.1740018933277; 
 Wed, 19 Feb 2025 18:35:33 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 13/14] regexdev: remove unnecessary deref of function
 pointers
Date: Wed, 19 Feb 2025 18:32:17 -0800
Message-ID: <20250220023509.630569-14-stephen@networkplumber.org>
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

