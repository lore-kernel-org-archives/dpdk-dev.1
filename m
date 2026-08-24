Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0AAC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 18:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7A6840270;
	Mon, 24 Aug 2026 20:10:21 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 82231400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 20:10:20 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84847482584so166458b3a.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787595019;
 x=1788199819; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kf5+3/mCZ5MvE724HnzSgpLY95cF4wJmDUOtw3SxSOw=;
 b=Ol/hl0wHmu1pUjdWr1lhrFT/RoKa/cvWAERgLrACvvZfneGzSB6lPwu6lP/SjyF3m2
 oC6Ghp7Ga1wciHRRAlrfIiMsmXxvhhU6PP0VwoRBWoBykOSizqMwrMdJ4ikoHg/vozVu
 V7YGxcGMkYrkFE9OBMLcc+3ZvJceOz8GjqqMrrkpXX09yNmUcOXx7uTWLzBoNiCu8D0g
 bzG7WAbAm3BdeUupaZcCXq5Kp0w4lwFGafFH4/igg75ZzW2rTTGMK52pzMd3a8rg5zGT
 7XmL6vYb+GnsOeYCHCv2JUNjZNzTojgCeMiLHTO0ygLPkDHcpfluMVHi28wrMGMfqLtp
 CIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787595019; x=1788199819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kf5+3/mCZ5MvE724HnzSgpLY95cF4wJmDUOtw3SxSOw=;
 b=qu6oOGlCWx0AfivyEh3E350tcXbjqUCSVdHtZWa4SNyVpO7wMA+6Kcr3LyDKRzZ5xT
 v8n5XDwJJ7EsoWkzN5Mmb4owAlevD3CMH/TbDQ16aof/8lPA0VtTwGTn9XfoE1fP2GJA
 V1ICTHt7sDnyVqnk49R8ynKHZ0PxZdGgO7U7wDC9STbp3b/NpxuwOwHN7zPk7zoRhew6
 sPCdyqmTxhMRm+DoEKTa1ckETI8ivhYOdiThrYUIacUzS2JcxfdwiICyeDdsVxUaZoKt
 sSYmd12rK25N5vYkTMcNVGb5HuXjwJI4tsnLJDntuKyVoTsq3LXTgAoiS3iauApvWBMQ
 O4jQ==
X-Gm-Message-State: AFuF++nK435JlfobtkEWRNGcQO0osEtMtKVuXBoPROFO/4YZ+lfTVtS5
 SOYUJXbyYGyMGkmDhIBJ+GnwLSRUBhsJGwvqtk2lbUVV/cS4CGYTyoOzqywUz5nN7Uw=
X-Gm-Gg: AR+sD13iDCvjQ6st1lue8XQIwQzEW7xy2vOxM+lQmiGbQksDt53wrmcBbAwBMCqKIQo
 XVAAsTrEer7VEAeXTNwwsrlbcHnIR3sJavaz8ff8THXpt17xrJubrrOZMlcysIqxX7nqWW7kKJW
 uo9IQxTDlQUOabcFvVm45AzE8DWDwGEVBiJJyvB8zbUekx4OhXzO5pW3WyecD1DK6yANc7LoCTb
 IG6zlXFwPvv0Zz6NtV8IbVuMbHw+yqgmcTkEpa7EqSZab0xOUlj/jSOcAxNo+/YspAtechTvcaz
 U1NlVxdqbzd+LAcSHcb3uAYXbX82dczl0J1U/WG8uL7p4n+s5Pbd4E/a5YPUqYSmKohTYdgmFFB
 QtaM5aeSJPuZjmk/ljpHwSch1jBGieHwY2zRY5z79Fegp2vczfokV/T+1I7zbuntgO5o8486DzQ
 dGL8/HcWNRLcFz9pT+yYG//Kmy/Dpnb7IT8uCgeJlOUx6mmoC3nIePNB5QQDesLOBRQzBcCfNhD
 lNaBlwb+XkAq9V7h26IoRo0yV3wTw==
X-Received: by 2002:a05:6a00:2d84:b0:851:80de:db56 with SMTP id
 d2e1a72fcca58-8523bc1334cmr934053b3a.13.1787595019323; 
 Mon, 24 Aug 2026 11:10:19 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520eed22c6sm2180135b3a.5.2026.08.24.11.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:10:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:10:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v12 15/15] net/enetc4: add WRR Tx scheduler devarg for
 VF rings
Message-ID: <20260824111009.420e4187@phoenix.local>
In-Reply-To: <20260821055643.1359277-16-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260821055643.1359277-1-g.singh@nxp.com>
 <20260821055643.1359277-16-g.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 21 Aug 2026 11:26:43 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> @@ -71,7 +72,46 @@ parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
>  
>  	str = strtok(input_str, "|");
>  	while (str != NULL && i < hw->max_tx_queues) {
> -		hw->txq_prior[i++] = (uint32_t)atoi(str);
> +		hw->txq_prior[i++] = atoi(str) & ENETC_TBMR_PRIO_MASK;
> +		str = strtok(NULL, "|");
> +	}
> +
> +	free(input_str);
> +	return 0;
> +}

The arg parsing in this driver has lots of usage of functions that are on
the naughty list like: atoi, atof, and strtok.

Suggest reworking this to use strtok_r and strtoul and strtod.

Not a fan of so many nerd knobs either. These kind of queue configurations really
need to be under ethdev but that is more work.

Something like this?

diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index bb579a0b90..3e13542302 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -2,7 +2,9 @@
  * Copyright 2024-2026 NXP
  */
 
+#include <errno.h>
 #include <stdbool.h>
+#include <stdlib.h>
 #include <rte_kvargs.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
@@ -49,85 +51,172 @@ static uint64_t dev_tx_offloads_sup =
 
 #define ENETC4_NC_MEMORY	"nc"
 
+/* Tx ring WRR weight range; ENETC_TBMR_WRR() encodes it as (weight - 1). */
+#define ENETC4_TXQ_WRR_MIN	1
+#define ENETC4_TXQ_WRR_MAX	8
+
+static const char * const enetc4_valid_args[] = {
+	ENETC4_TXQ_PRIORITIES,
+	ENETC4_TXQ_WRR,
+	ENETC4_NC_MEMORY,
+	NULL,
+};
+
+/*
+ * Parse one unsigned decimal value, rejecting empty strings, signs, trailing
+ * garbage and values outside [min, max]. atoi() reports none of these: it
+ * returns 0 for any non-numeric string and is undefined on overflow.
+ */
 static int
-parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
+enetc4_parse_uint(const char *str, uint32_t min, uint32_t max, uint32_t *val)
 {
-	struct rte_eth_dev *dev = (struct rte_eth_dev *)opaque;
-	struct enetc_eth_hw *hw =
-				ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	char *input_str;
-	char *str;
-	uint32_t i = 0;
+	unsigned long res;
+	char *endptr;
+
+	if (str == NULL || *str == '\0')
+		return -EINVAL;
+
+	/* strtoul() silently wraps a leading '-', so reject signs up front. */
+	if (*str == '-' || *str == '+')
+		return -EINVAL;
+
+	errno = 0;
+	res = strtoul(str, &endptr, 10);
+	if (errno != 0 || endptr == str || *endptr != '\0')
+		return -EINVAL;
+
+	if (res < min || res > max)
+		return -ERANGE;
+
+	*val = (uint32_t)res;
+	return 0;
+}
+
+/*
+ * Parse a "v0|v1|..." list into vals[], validating every field against
+ * [min, max]. Returns the number of values parsed, or a negative errno.
+ */
+static int
+enetc4_parse_uint_list(const char *key, const char *value, uint32_t min,
+		       uint32_t max, uint32_t *vals, uint32_t max_vals)
+{
+	char *input_str, *str, *saveptr;
+	uint32_t n = 0;
+	int ret;
+
+	if (value == NULL) {
+		ENETC_PMD_ERR("%s: missing value", key);
+		return -EINVAL;
+	}
 
 	input_str = strdup(value);
-	if (!input_str)
+	if (input_str == NULL)
 		return -ENOMEM;
 
-	rte_free(hw->txq_prior);
-	hw->txq_prior = rte_zmalloc(NULL, hw->max_tx_queues * sizeof(uint32_t), 0);
-	if (!hw->txq_prior) {
-		free(input_str);
-		return -ENOMEM;
+	for (str = strtok_r(input_str, "|", &saveptr); str != NULL;
+	     str = strtok_r(NULL, "|", &saveptr)) {
+		if (n == max_vals) {
+			ENETC_PMD_ERR("%s: too many values, at most %u supported",
+				      key, max_vals);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = enetc4_parse_uint(str, min, max, &vals[n]);
+		if (ret != 0) {
+			ENETC_PMD_ERR("%s: invalid value '%s' at index %u, expected %u..%u",
+				      key, str, n, min, max);
+			goto out;
+		}
+		n++;
 	}
 
-	str = strtok(input_str, "|");
-	while (str != NULL && i < hw->max_tx_queues) {
-		hw->txq_prior[i++] = atoi(str) & ENETC_TBMR_PRIO_MASK;
-		str = strtok(NULL, "|");
+	if (n == 0) {
+		ENETC_PMD_ERR("%s: empty value list", key);
+		ret = -EINVAL;
+		goto out;
 	}
 
+	ret = n;
+out:
 	free(input_str);
+	return ret;
+}
+
+/* Parse enetc4_txq_prior="p0|p1|..." devarg; priority 0..7 per ring. */
+static int
+parse_txq_prior(const char *key, const char *value, void *opaque)
+{
+	struct rte_eth_dev *dev = opaque;
+	struct enetc_eth_hw *hw =
+				ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	uint32_t *prior;
+	int ret;
+
+	prior = rte_zmalloc(NULL, hw->max_tx_queues * sizeof(uint32_t), 0);
+	if (prior == NULL)
+		return -ENOMEM;
+
+	ret = enetc4_parse_uint_list(key, value, 0, ENETC_TBMR_PRIO_MASK,
+				     prior, hw->max_tx_queues);
+	if (ret < 0) {
+		rte_free(prior);
+		return ret;
+	}
+
+	/* Only swap in the new table once the whole list is known good. */
+	rte_free(hw->txq_prior);
+	hw->txq_prior = prior;
+
 	return 0;
 }
 
 /* Parse enetc4_txq_wrr="w0|w1|..." devarg; weight 1..8 per ring. */
-static int parse_txq_wrr(const char *key __rte_unused, const char *value,
-			  void *opaque)
+static int
+parse_txq_wrr(const char *key, const char *value, void *opaque)
 {
-	struct rte_eth_dev *dev = (struct rte_eth_dev *)opaque;
+	struct rte_eth_dev *dev = opaque;
 	struct enetc_eth_hw *hw =
 			ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	char *input_str;
-	char *str;
-	uint32_t i = 0;
-	int w;
+	uint32_t *wrr;
+	int n, i;
 
-	input_str = strdup(value);
-	if (!input_str)
+	wrr = rte_zmalloc(NULL, hw->max_tx_queues * sizeof(uint32_t), 0);
+	if (wrr == NULL)
 		return -ENOMEM;
 
-	rte_free(hw->txq_wrr);
-	hw->txq_wrr = rte_zmalloc(NULL,
-			hw->max_tx_queues * sizeof(uint32_t), 0);
-	if (!hw->txq_wrr) {
-		free(input_str);
-		return -ENOMEM;
+	n = enetc4_parse_uint_list(key, value, ENETC4_TXQ_WRR_MIN,
+				   ENETC4_TXQ_WRR_MAX, wrr, hw->max_tx_queues);
+	if (n < 0) {
+		rte_free(wrr);
+		return n;
 	}
 
-	str = strtok(input_str, "|");
-	while (str != NULL && i < hw->max_tx_queues) {
-		w = atoi(str);
-		if (w < 1)
-			w = 1;
-		if (w > 8)
-			w = 8;
-		hw->txq_wrr[i++] = ENETC_TBMR_WRR(w);
-		str = strtok(NULL, "|");
-	}
+	for (i = 0; i < n; i++)
+		wrr[i] = ENETC_TBMR_WRR(wrr[i]);
+
+	/* Only swap in the new table once the whole list is known good. */
+	rte_free(hw->txq_wrr);
+	hw->txq_wrr = wrr;
 
-	free(input_str);
 	return 0;
 }
 
 static int
-parse_nc(const char *key __rte_unused, const char *value, void *extra_args)
+parse_nc(const char *key, const char *value, void *extra_args)
 {
 	struct rte_eth_dev *dev = extra_args;
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	uint32_t val;
+
+	if (enetc4_parse_uint(value, 0, 1, &val) != 0) {
+		ENETC_PMD_ERR("%s: invalid value '%s', expected 0 or 1",
+			      key, value ? value : "(null)");
+		return -EINVAL;
+	}
 
-	if (value && atoi(value) == 1)
-		hw->nc_mode = 1;
+	hw->nc_mode = val;
 
 	return 0;
 }
@@ -135,45 +224,41 @@ parse_nc(const char *key __rte_unused, const char *value, void *extra_args)
 static int
 enetc4_get_devargs(struct rte_eth_dev *dev, const char *key)
 {
+	static const struct {
+		const char *key;
+		arg_handler_t handler;
+	} handlers[] = {
+		{ ENETC4_TXQ_PRIORITIES, parse_txq_prior },
+		{ ENETC4_TXQ_WRR,	 parse_txq_wrr	 },
+		{ ENETC4_NC_MEMORY,	 parse_nc	 },
+	};
 	struct rte_devargs *devargs = dev->device->devargs;
 	struct rte_kvargs *kvlist;
+	unsigned int i;
+	int ret = 0;
 
-	if (!devargs)
+	if (devargs == NULL)
 		return 0;
 
-	kvlist = rte_kvargs_parse(devargs->args, NULL);
-	if (!kvlist)
-		return 0;
-
-	if (!rte_kvargs_count(kvlist, key)) {
-		rte_kvargs_free(kvlist);
-		return 0;
+	/* Passing the key list makes a mistyped devarg an error, not a no-op. */
+	kvlist = rte_kvargs_parse(devargs->args, enetc4_valid_args);
+	if (kvlist == NULL) {
+		ENETC_PMD_ERR("Invalid device arguments '%s'", devargs->args);
+		return -EINVAL;
 	}
 
-	if (!strcmp(key, ENETC4_TXQ_PRIORITIES)) {
-		if (rte_kvargs_process(kvlist, key,
-				       parse_txq_prior, (void *)dev) < 0) {
-			rte_kvargs_free(kvlist);
-			return 0;
-		}
-	}
-	if (!strcmp(key, ENETC4_TXQ_WRR)) {
-		if (rte_kvargs_process(kvlist, key,
-				       parse_txq_wrr, (void *)dev) < 0) {
-			rte_kvargs_free(kvlist);
-			return 0;
-		}
-	}
-	if (!strcmp(key, ENETC4_NC_MEMORY)) {
-		if (rte_kvargs_process(kvlist, key,
-				       parse_nc, (void *)dev) < 0) {
-			rte_kvargs_free(kvlist);
-			return 0;
-		}
-	}
+	if (rte_kvargs_count(kvlist, key) == 0)
+		goto out;
 
+	for (i = 0; i < RTE_DIM(handlers); i++) {
+		if (strcmp(key, handlers[i].key) != 0)
+			continue;
+		ret = rte_kvargs_process(kvlist, key, handlers[i].handler, dev);
+		break;
+	}
+out:
 	rte_kvargs_free(kvlist);
-	return 0;
+	return ret;
 }
 
 static int
@@ -1129,9 +1214,13 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 		enetc4_txbdr_wr(enetc_hw, i, ENETC_TBMR, ENETC_BMR_RESET);
 
 	hw->nc_mode = 0;
-	enetc4_get_devargs(dev, ENETC4_TXQ_PRIORITIES);
-	enetc4_get_devargs(dev, ENETC4_TXQ_WRR);
-	enetc4_get_devargs(dev, ENETC4_NC_MEMORY);
+	ret = enetc4_get_devargs(dev, ENETC4_TXQ_PRIORITIES);
+	if (ret == 0)
+		ret = enetc4_get_devargs(dev, ENETC4_TXQ_WRR);
+	if (ret == 0)
+		ret = enetc4_get_devargs(dev, ENETC4_NC_MEMORY);
+	if (ret != 0)
+		return ret;
 
 	if (dev->data->nb_rx_queues <= 1)
 		return 0;
@@ -1538,8 +1627,13 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 	hw->max_rx_queues = (si_cap >> 16) & ENETC_SICAPR0_BDR_MASK;
 
 	hw->nc_mode = 0;
-	enetc4_get_devargs(eth_dev, ENETC4_TXQ_PRIORITIES);
-	enetc4_get_devargs(eth_dev, ENETC4_NC_MEMORY);
+	error = enetc4_get_devargs(eth_dev, ENETC4_TXQ_PRIORITIES);
+	if (error == 0)
+		error = enetc4_get_devargs(eth_dev, ENETC4_NC_MEMORY);
+	if (error != 0) {
+		ENETC_PMD_ERR("Invalid device arguments");
+		return error;
+	}
 	if (hw->nc_mode) {
 		eth_dev->rx_pkt_burst = &enetc_recv_pkts_nc;
 		eth_dev->tx_pkt_burst = &enetc_xmit_pkts_nc;
