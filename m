Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08663CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 19:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5823540292;
	Wed, 20 Aug 2025 21:51:35 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 1AC494026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:51:34 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so1472745e9.3
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755719494;
 x=1756324294; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfy3xn/4E0YSUT9Uvxulpkv/cBEjdgNzqPTKK/Sp718=;
 b=0sXKpjT1siJwn3f/Q+oOQ45PA5alugv21UNUnwZZvyCfMUmP7VJyn6OAI4JP7q+2Cv
 j9dT0XasFI6hmGHQXTxHsXz2Yn1MXZJK+qA2tslYuUwgUdfK06ouhxjcQgzpAYJRYmpX
 S3RAoZGtcILPpJspjwsr0qEdX8xBTHyX78tIYEtvtALulyowc2wTixPkqEWk9za+9/Mw
 Cz/iiDyFHAFAlBzV2TJL3mPwYQIkGYYo+p3cdFXJuK9iCIESUymQTRwwuz+7BphDHZ1e
 erzad1/l1buTPDmw65oPh5FziGQtlvdfCSA1pgLiCW/t0j3+h+IFF2qQWVLsl6KQ8Qtn
 o+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755719494; x=1756324294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfy3xn/4E0YSUT9Uvxulpkv/cBEjdgNzqPTKK/Sp718=;
 b=b04wqp465Av94NQxJAJFFShenW5gZ7VN029IXLDF4Cx3OPsTgub/e9w/JXVaxAqkGR
 gJG1DJ3J07hxPQf8Jc3cx0kCKX3Tz1MCDx9dr4PcLYTOgJXOddQoN1tgb+zK/eAV7Qju
 6YG3eDp188i5ockDdi2fYRKzJFoa+DinXG1h3gWkXKXACcGsPHB5q2bhyDerf6Pw2Z4C
 yrjEMDW5EZDGxncqlDtOHVWGGAMZPpGMWlWWznl4HCuw/oYkEmWYosJoWK0WAukeSIzT
 ORL/kPLQ3PNSy3JDoeLHp8e6sXyQGhgoO6+4zxbS4d8mWypgAQzVrgEMuZY0zpyXarca
 HIdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIYgf4SmXQqSYyn0wfvRpCsXFWxne7Ho6+Y6W9Uc2Y1WFg3mp8fj9oDHr7JaodIhMuFZI=@dpdk.org
X-Gm-Message-State: AOJu0YzFXK7akOfkHzxPfqZV+u/qNSVjhPsIIgwrzZ9QW0rOSODHbfNh
 +G/4MeXrnUyHjsNApb/WrP9wldbEdnk0RR9ht+fal4P1+55Xmc9DTJhiRonAzQP79HBvIlLpXrD
 eY6n8vzA=
X-Gm-Gg: ASbGncuuGv0ZZoUr5LnftkW8yMKZET7rocUgquyow6vVSA4xSYAtYlA+XjIzyqQVr47
 pPA+nFewqbDMP+ywBAOcNvRMSATF1/rDT3bjfdIYcbploQCTjMzY5+NyHexEeFxkES/6zH8xzw/
 tJRLXQQXso6yIP9c9+5hHJLxf8fp8BrKdydIaVde0Y60Le77829vN6BidPlaUfsRK76iCNaeAvh
 Pj5bPeoPNH9ZhflTJrFO4eSniwcDWzXKoIHhVyGyEB5Mayd7E2699m0d4opJTussrQbOPtGjngW
 1KsLyncaqcm6gqFFHkNVGtLXA1RRotNZq8YHlBJoDRsLJgp1Len/egch1JsG9eNjBpcHTaeCay8
 strzcOLqs5bPwQ/zSMWoJCIGzNFhc3Cx+7Gig6TVLfLO31LbgklR+ZEEHeCk+qstQfFgBVXDlgA
 w=
X-Google-Smtp-Source: AGHT+IHGRCWjv28mdBGkIIuxmWTS8RSj7NQLEyke55hvOjJ2AwziZvgjOP6d9ZQqP5yjCNEPq3TZJQ==
X-Received: by 2002:a05:600c:3b0c:b0:456:1bae:5470 with SMTP id
 5b1f17b1804b1-45b479b6ba7mr33240385e9.8.1755719493631; 
 Wed, 20 Aug 2025 12:51:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c30f23sm52522845e9.7.2025.08.20.12.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 12:51:33 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:51:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
Cc: kyo.liu@nebula-matrix.com, dev@dpdk.org, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v3 02/16] net/nbl: add simple probe/remove and log module
Message-ID: <20250820125128.136bc406@hermes.local>
In-Reply-To: <20250627014022.4019625-3-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250627014022.4019625-3-dimon.zhao@nebula-matrix.com>
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

On Thu, 26 Jun 2025 18:40:08 -0700
"dimon.zhao" <dimon.zhao@nebula-matrix.com> wrote:

> +
> +static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
> +{
> +	const struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	int ret;
> +
> +	PMD_INIT_FUNC_TRACE();
> +	ret = nbl_core_init(adapter, eth_dev);
> +	if (ret) {
> +		NBL_LOG(INFO, "core init failed ret %d", ret);
> +		goto eth_init_failed;
> +	}
> +
> +	ret = nbl_core_start(adapter);
> +	if (ret) {
> +		NBL_LOG(INFO, "core start failed ret %d", ret);
> +		nbl_core_remove(adapter);
> +		goto eth_init_failed;
> +	}
> +
> +	eth_dev->dev_ops = &nbl_eth_dev_ops;
> +	return 0;
> +
> +eth_init_failed:
> +	return ret;
> +}
> +
> +/**
> + * @brief: nbl device pci probe
> + * @param[in]: {rte_pci_driver} *pci_drv
> + * @param[in]: {rte_pci_device} *pci_dev
> + * @return: {0-success,negative-fail}
> + */
> +static int nbl_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
> +			 struct rte_pci_device *pci_dev)
> +{
> +	return rte_eth_dev_pci_generic_probe(pci_dev, sizeof(struct nbl_adapter),
> +					     nbl_eth_dev_init);
> +}
> +

Since device doesn't support secondary process, it would make sense to
detect that in probe handling and return error in secondary.
