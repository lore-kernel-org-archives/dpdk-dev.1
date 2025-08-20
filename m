Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D6CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 18:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A6D40292;
	Wed, 20 Aug 2025 20:58:25 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id F07EE4026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 20:58:23 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c380aa1ad0so160166f8f.3
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755716303;
 x=1756321103; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=farPnt2R7OWQicjldDZe7NjYjpIlEF097iQ5jZHn5gQ=;
 b=pUwRQex4zkV/m/t1QOSlaHRhKyrtL/RZa97oQvz45c5VuTHqS9LXvP3PH93TX0vqYN
 6J4rQcBeRLsgLE7zCMdixrPpdNSlHizzemm3zxw34W1dnoEReP6oFm2Gk3axh8MNekAf
 eR5eAHt5mwHGOZmDiJEa0evT3vVTFjo0cOLeuOmpKQV/YOTW2+UvNxdNRZaAeUsv0dA+
 ZGTeoQis5wzbIW1jVsj/qzgdu7U0Wna6PKAuHsZLDZ2r0y34T485QEEMzXi/DgnZpKxM
 9aDFlBRYUtkPa6Q8VY3ZCadp1MegGi3bm8r+nT2XWMH4cFMTsjUNO0HqJ6cxs71smhNo
 5xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755716303; x=1756321103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=farPnt2R7OWQicjldDZe7NjYjpIlEF097iQ5jZHn5gQ=;
 b=r8p0WQKx/rc8gklxjuVCyiYHMZJ1MNIHDYAktTz8KmDSuElj1Ae7aFtIYIq1yj6zsA
 F7uOiGaoPqu3sUSLQnMsnxLnllw6utSiF4DxcV1Wk5aaCTCt50alSEg6wahCI8zW8rDf
 9C1/QVC82jQI2t4GbJphFGvRydF6RkZkvhKDBxLTkac3wkOhGBT7kA8zKZEs3IYTQ2os
 6yZQx3r3cTDGdTcezFQshjfflImI8iGSnUEHacjvO2NXBLqXBA5oE6k8DzUNDMK5VOAH
 +uubewgE80QwFXhDP1MdCZ5behrUXHTj1XDZxaiTfPXQjgEU5RinRyM3zXrjxc4pWIdB
 EFkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3wngEaefNcbUNgJ+Koh+fNN49U5HPAQ5c7F6zwOaQFAuPrxX3JJEnDGi6aibvETWY34=@dpdk.org
X-Gm-Message-State: AOJu0YxUeU2HqPg7cVtzR2pjPSwz10aJ6dT9qYNMVc/tl0jU/Bqv04d0
 r7ZTFH0jzMvoIwVeoRE+LyOGXJnirvUSaWGDtU2jbZrbThBYyzwJf0Kawp7ecG5Df5k=
X-Gm-Gg: ASbGnctihc6HJoM+r89vGeQpip/97Hj6v9gotd/55TE8/x7294ekL38ialUfIi9H1v2
 goKrpW2ppY3hODVWpJGUl8YKC0u7RUsjDqa4hXE5LOJB1DDAP7bw4mxQbLBezO9aOLpEjZ1d7FH
 6Sr703xV8+FqpwnjsuQ8qVzsMqIGtm+nXbZxcdrBKpq0Xs4r7wJR1IFqzIaaQA5/J0ZS7qOYGL4
 flos2qSZ66TjToPDvBKm1/kbfUe4JKBOsht4O9yqwQvsHh6CFLEZKz0Wv5rMLUFHrnlWWeLTzCh
 NkjDA8U5c+N+sVbef+sthQ34MPv+A+DVsyJ1fmnIGn+g6fll2CsvAIYrp/YWNNRWQ+8c6MLkIyg
 a7k1RdR76rFqqMx7E53h21kmSrHiaZBzK9kC5Rd/UAdFLcHXYblkra86AlvJUGNyNUMSoaCERMW
 g=
X-Google-Smtp-Source: AGHT+IG75jLSk1rmAG3Xapk1eKTMBYaOF/q7odmgIm+iELxm+KcDcmIO4oj5Yjx6AkRAsbP4InBflQ==
X-Received: by 2002:a05:6000:18a7:b0:3bb:bd05:735e with SMTP id
 ffacd0b85a97d-3c32f943d08mr3386880f8f.38.1755716303214; 
 Wed, 20 Aug 2025 11:58:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c29b6dsm50310175e9.3.2025.08.20.11.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 11:58:23 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:58:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v7 1/1] ethdev: add support to provide link type
Message-ID: <20250820115818.0a3628ee@hermes.local>
In-Reply-To: <20250820175317.3063659-1-skori@marvell.com>
References: <20250820111350.2992591-1-skori@marvell.com>
 <20250820175317.3063659-1-skori@marvell.com>
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

On Wed, 20 Aug 2025 23:22:31 +0530
<skori@marvell.com> wrote:

Patch does not apply cleanly to next-net, there is fuzz.

> diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
> index 482befc209..bc6c3a4a02 100644
> --- a/lib/ethdev/ethdev_trace.h
> +++ b/lib/ethdev/ethdev_trace.h
> @@ -2110,6 +2110,13 @@ RTE_TRACE_POINT_FP(
>  	rte_trace_point_emit_string(ret);
>  )
>  
> +RTE_TRACE_POINT_FP(
> +	rte_eth_trace_link_connector_to_str,
> +	RTE_TRACE_POINT_ARGS(uint8_t link_connector, const char *ret),
> +	rte_trace_point_emit_u8(link_connector);
> +	rte_trace_point_emit_string(ret);
> +);
> +

IMHO adding a trace point to a helper function like this is just
extra clutter, remove it.

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_connector_to_str, 25.11)
> +const char *
> +rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector)
> +{
> +	static const char * const link_connector_str[] = {
> +		[RTE_ETH_LINK_CONNECTOR_NONE] = "None",
> +		[RTE_ETH_LINK_CONNECTOR_TP] = "Twisted Pair",
> +		[RTE_ETH_LINK_CONNECTOR_AUI] = "Attachment Unit Interface",
> +		[RTE_ETH_LINK_CONNECTOR_MII] = "Media Independent Interface",
> +		[RTE_ETH_LINK_CONNECTOR_FIBER] = "Fiber",
> +		[RTE_ETH_LINK_CONNECTOR_BNC] = "BNC",
> +		[RTE_ETH_LINK_CONNECTOR_DAC] = "Direct Attach Copper",
> +		[RTE_ETH_LINK_CONNECTOR_SGMII] = "SGMII",
> +		[RTE_ETH_LINK_CONNECTOR_QSGMII] = "QSGMII",
> +		[RTE_ETH_LINK_CONNECTOR_XFI] = "XFI",
> +		[RTE_ETH_LINK_CONNECTOR_SFI] = "SFI",
> +		[RTE_ETH_LINK_CONNECTOR_XLAUI] = "XLAUI",
> +		[RTE_ETH_LINK_CONNECTOR_GAUI] = "GAUI",
> +		[RTE_ETH_LINK_CONNECTOR_XAUI] = "XAUI",
> +		[RTE_ETH_LINK_CONNECTOR_CAUI] = "CAUI",
> +		[RTE_ETH_LINK_CONNECTOR_LAUI] = "LAUI",
> +		[RTE_ETH_LINK_CONNECTOR_SFP] = "SFP",
> +		[RTE_ETH_LINK_CONNECTOR_SFP_DD] = "SFP-DD",
> +		[RTE_ETH_LINK_CONNECTOR_SFP_PLUS] = "SFP+",
> +		[RTE_ETH_LINK_CONNECTOR_SFP28] = "SFP28",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP] = "QSFP",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP_PLUS] = "QSFP+",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP28] = "QSFP28",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP56] = "QSFP56",
> +		[RTE_ETH_LINK_CONNECTOR_QSFP_DD] = "QSFP-DD",
> +		[RTE_ETH_LINK_CONNECTOR_OTHER] = "Other",
> +	};
> +	const char *str = NULL;
> +
> +	if ((link_connector < ((enum rte_eth_link_connector)RTE_DIM(link_connector_str))) &&
> +		link_connector_str[link_connector])
> +		str = link_connector_str[link_connector];

This can be simplified to:
	if (link_connector < RTE_DIM(link_connector_str))
		str = link_connector_str[link_connector];

Since enum's act like int in C, no need for all that casting.

> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * This function converts an Ethernet link type to a string.
> + *
> + * @param link_connector
> + *   The link type to convert.
> + * @return
> + *   The string representation of the link type.
> + */
> +__rte_experimental
> +const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector);

Need to document that it returns NULL for invalid link_connector values.

