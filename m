Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE49CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 901AF40659;
	Tue, 19 Aug 2025 17:36:57 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 7EA7640653
 for <dev@dpdk.org>; Tue, 19 Aug 2025 17:36:55 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so27024425e9.3
 for <dev@dpdk.org>; Tue, 19 Aug 2025 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755617815;
 x=1756222615; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULHUcskWC8Ts3tD/r1CROR6zC3K/gFwvpFnpmjXMtrw=;
 b=gWSLM5dwwT3mVJMV0rjh2sg01RABV3jfzdirdfFlez916dhDI3qrFlaZulSxinEa9B
 4lmiwMfFb3wngLzaBqHRJgPfagOy/sO9Rx4wMXTsbpY1tRwevTugDFStEzPvRThMwDFQ
 WLcYmE83OQVVPFR1rhrm1hTUtM1KoJ+prqtoitEOugLKwUjElAiblDhEReGmfr0BVGrS
 g37gWclu66WK5YAyj6BTxPe52f9bfg+agA4KnqMW9MWLZMmWwwUJXrjrIwbI5bMWhSK6
 eSheqPnP4KKC2n7rwAtVQFP4l4UodN97usLBk1c41CYESz3A8ucLM8Qd7cNZsXxRI6Rq
 SGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617815; x=1756222615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULHUcskWC8Ts3tD/r1CROR6zC3K/gFwvpFnpmjXMtrw=;
 b=DCEj+emHKFRkWvGLsNGYTEpT0+hsxof1dqT/VumlBspbrO2K7v5VTTKPmc3cFsVlGh
 +F9jkJ5faG3NnHDwyo6UyRgfSVQ2Oy2llID7O6I02ap4IAQwB4Ny6L2xWeAnrg9esIQ0
 JK3SR35u5jkC7yZmJsxKe2uo/8OBaK2LvKmKbaKfNI0AKV0Us9C5NkjJ8wv6ydiN0O8C
 8n3Sl13Q58ufOhPFvnYcfofXuUG1OOxDfd18Jt/hpb+2Ia20BvwQR0Q0rqRo1tfYECGy
 O1umweugbNcF/ck9syf5GxohcR4Byn5wtTDbHpBIAEMpqxgWr2m3cDwCnIA0AzuqrXp/
 l46w==
X-Gm-Message-State: AOJu0YwWzQYDl3I4NYTeir8LsfFIM/eE0JzeN2UOtlU/aPzGVhqhzS4b
 Wikh2F/LOx0lAP4g2C8o6TEeGfQIXh5QleEKgtOXFVxXMN69/fj9pBIH6a6MhsEJGrFa21O+D5n
 CNo1x
X-Gm-Gg: ASbGnct98b1AyK2RmNn3V6wo65oWdUb1BqKiRfO/9DYdKadfNp89RJfjNyPkZ+4sOsh
 2EZ5NVJvFHs/wLx28rKsk8TV9Ou77tqUjhb9OsCH+aQ2hbaAr8ZDv28VErGMrrDs7fCDBbRxOx4
 YG0dRb0RQXehoiRJcdXntgHnXDnq3es3sU9407j3hLJmmGUiarm+KARYsfBoJxyDzoH+10KtgKV
 08gPlKbXpg+SZt5zVPIWIvzzeOXU+TfzEl1aMt6khLs7FGOfjhF23Gzz8iLvF0UABGFZMJ93xPc
 vaBwZ533YQAOtwemSTMaNN00LNCaJZdWHusBlhuCx0hoZKiOaJJBf8cfEIDvzci8fFtFZjKODG4
 arNTpMp/e+In79CFlxjwgi2vet7mBnOjvq9yfzjatI+VK6kvae90I5tRYWEOr0k7k2bVlYsjUZG
 E=
X-Google-Smtp-Source: AGHT+IFL0cZb4gDSKiaIyx4yuCyJGE24VrtEVf9HZwyHrgk1mV2B6JxYXRwboaiMkyvQJa7S1YAW6w==
X-Received: by 2002:a05:600c:3590:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-45b43e045a1mr25933295e9.18.1755617814723; 
 Tue, 19 Aug 2025 08:36:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6cd044sm231872045e9.9.2025.08.19.08.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:36:54 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:30:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v5 11/17] net/nbl: add nbl ethdev configuration
Message-ID: <20250819083047.750c9a9a@hermes.local>
In-Reply-To: <20250819102237.3067518-12-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-12-dimon.zhao@nebula-matrix.com>
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

On Tue, 19 Aug 2025 03:22:31 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

>  
> +int nbl_dev_configure(struct rte_eth_dev *eth_dev)
> +{
> +	struct rte_eth_dev_data *dev_data = eth_dev->data;
> +	enum rte_eth_rx_mq_mode rx_mq_mode = eth_dev->data->dev_conf.rxmode.mq_mode;
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	int ret;
> +
> +	NBL_LOG(INFO, "Begin to configure the device, state: %d", adapter->state);
> +
> +	if (dev_data == NULL || adapter == NULL)
> +		return -EINVAL;
> +
> +
> +	if (rx_mq_mode != RTE_ETH_MQ_RX_NONE && rx_mq_mode != RTE_ETH_MQ_RX_RSS) {
> +		NBL_LOG(INFO, "Rx mq mode %d is not supported", rx_mq_mode);
Should be NBL_LOG(ERR and return -ENOTSUP
> +		return -EINVAL;
> +	}
> +
> +	dev_data->dev_conf.intr_conf.lsc = 0;
> +
> +	switch (adapter->state) {
> +	case NBL_ETHDEV_CONFIGURED:
> +	case NBL_ETHDEV_INITIALIZED:
> +		ret = nbl_dev_port_configure(adapter);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	NBL_LOG(INFO, "configure the device done %d", ret);

Should be at DEBUG level. Device should not print anything to log
when used by a non buggy application.
> +	return ret;
> +}
