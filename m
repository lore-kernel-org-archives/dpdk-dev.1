Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F32F112584F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C914060A;
	Wed, 11 Mar 2026 17:32:07 +0100 (CET)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53]) by mails.dpdk.org (Postfix) with ESMTP id 1FC84402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:32:05 +0100 (CET)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-67bb04151dcso65389eaf.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773246725;
 x=1773851525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+PnLn2R5clRB2KSd4aFqhLXxfjLv0BSog5E5Qto9O8=;
 b=lbrR+O2h2SC/ve/StBp98Vl7QzSQPf+DfA/PZ4kZZLm41x2I97nX2UzQBgvmFXDHbT
 zLYT8H871LtlaXvTfA2QsH1JROf6Ee44Qtijdw7bwYKN0gx/uUxu775prGjVxViqXN6U
 jphAcqMh4S5KbLrKotqJAueRm7McSu3Ef3lq/ny/0AsZCR9wzdasJ9/0QWCybChhEIGs
 ZOKCDXXcbyas8WbDtboOYydlGM7AY1K1Yr2WFS5BfomPcmqMAhZ5ZygSV+SKZoknbjAL
 YpdfWti41O3YkytC88zumusjVj9tM2dTiHpdnj2JMPDKBBLS9bqNI9h4EsNlb9xRJ/eQ
 N3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246725; x=1773851525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+PnLn2R5clRB2KSd4aFqhLXxfjLv0BSog5E5Qto9O8=;
 b=PwpETu5cIiqsoCdGdWh/RA/vrVz86St3AxBoMpk7aIPUXb1aSJFqC8AUMFa/xf1Rf7
 Ue547ylpifxo2Yea0c2TPQ5ewIFdDYcwcnbZYQG9As0Dk0WqzphZ9RHm0gKX/KQI+ijo
 wPUOAQtf0e1q4ZrvNPat6gsFYypOuaLWT0GBvEEKZXmrf3AlIC+asJFGnlrfbW/DebCS
 RQamwd/KFdaY7xtkDZ4HlCWhuVNNwQmVJVW+dOhGaCKIUNQVQ1GqGHrQiguWuQMGgbXx
 TZMel2THB9Ib1gaFC8U3+2Gd6/KfLGJUD/f31rYCzYDB2tnoWLmhdYVa8dk4sIpsqDTQ
 S+Xg==
X-Gm-Message-State: AOJu0YwmgOazrK/JRuAjIewwvXtNlenVo7AkkTZHJp3xR5juftjutuDm
 wH8hK4yCCo7CsV8ut+oKdVZyUXXStlmlCdeoHW/oAilEuaNP1gKbtv+hf5hiBgKTyq0=
X-Gm-Gg: ATEYQzw/PWfbzWEmcYugh00Gh78J8nvKjs1y+4vn/XGg1Br39HLYexPJ5IaJiIJVFTo
 QdU9YQQ5u+M7b/cTmDinfxj1JwEkwPcGCABSB8jDszH1G7v4KX4zGdQcpMCh7oL3ol7PcKTzMwN
 YAwWe80FjRLCMngJ3eYaXL8Tijiejp+bXZAoj3diW+Zb5tTp/HkUrY/XfKPMBsFReZNhWu369ZE
 dBfx/f56F84qzmNQ2X1uK8dd179kvbnY8jdEdSJPwC5QDg+uDwsZn2yDQNo05kXojnVVbhG1R5+
 uDrMpZGWCkMQXwKTQwGoFX4LDUTsze9dROYTwF8T+Ojm36UPEBA7Ytf7obe1P/CzL8Gh+cddbos
 w0lREbQO2arOwkJSw4aehJftDK8+qevfumzylbaq0dvm3JzhOLERUClrv+pMoq25lWJfBj9GMzx
 633P5a+AlEnrRlSoN8Mdqopg+P7cCp6l39k8w=
X-Received: by 2002:a05:6820:1522:b0:67b:bd6e:80d2 with SMTP id
 006d021491bc7-67bc8a9041emr1774045eaf.72.1773246725054; 
 Wed, 11 Mar 2026 09:32:05 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc93061f2sm1686372eaf.10.2026.03.11.09.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:32:04 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:17:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 08/10] ethdev: add getter for per-queue Tx rate limit
Message-ID: <20260311091718.730d7cae@phoenix.local>
In-Reply-To: <20260310232653.2935764-9-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-9-vjardin@free.fr>
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

On Wed, 11 Mar 2026 00:26:51 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> +int
> +mlx5_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
> +			  uint32_t *tx_rate)
> +{
> +	struct mlx5_priv *priv = dev->data->dev_private;
> +	struct mlx5_txq_ctrl *txq_ctrl;
> +
> +	if (queue_idx >= dev->data->nb_tx_queues) {
> +		rte_errno = EINVAL;
> +		return -rte_errno;
> +	}

This check should be done in ethdev not driver; to be consistent
with other ethdev API's.

