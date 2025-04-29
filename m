Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D48C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 23:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D69BE402A7;
	Wed, 30 Apr 2025 01:55:17 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id BC82A402A3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 01:55:15 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b074d908e56so4955260a12.2
 for <dev@dpdk.org>; Tue, 29 Apr 2025 16:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745970914;
 x=1746575714; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KMop5urCKZgPEgwRRGVX4IcvOShxPnVAmalkcTeHd8=;
 b=btzXlsOm4I2yM/iWuhphHx/yWAmLYa8Fxrb02oRH39PAKLzFHJQbAMKJFRrOab9Dh3
 FtkGWIAnrXCMAgySZyvjji57ED2FVf6T0aiio/HY8NHWb2/ABwzEjsYxTS0elLSE1kt9
 imfeAmGA3Uj8pSgrYxFjcUR7Urstci/LCDNgOfI0Xrb6kGgyxZWXPFSpYHvGgOJQoG+u
 x2eqaeqLg7EYVb1gG6FryYaYaXyEYJ7qhGS1tYATItq7VBvbxtrG2McXoItYf38P0RX2
 xBh0nBt+T4bJXRiK/51o2JEZP9I8l+DJ/4CkQdlaKQOg9qRwhkARPVB1PuSazL/f0eCf
 9tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745970914; x=1746575714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KMop5urCKZgPEgwRRGVX4IcvOShxPnVAmalkcTeHd8=;
 b=Z1IJzi8wFXsThhi6z5Y8eTwYcRAUpjtuNKK3h3YXKwJxammY4+L07/qot1uLRStlCS
 z76NbfeImUtwwRiRuWt/Thh/G1sfaJnmg5VyfR2O/urZ/PofE0g0n8t0Fp2ARLs85XLO
 PFI+QDKucZyknEPcr6Ulvg/Zj88ZbEXaz4ZVoi8RfTOSaCl27zVxcpmpHEXGl9wXj8fV
 dWLm7u2sw3zAXSek9CixJzJuVHYhtoJnnk4t/m5SV8fiTRN0FOljrEBpdljC1FIZR0Th
 2N83Vz1tTpuUhGaFty7FsVSlXC+2vk94Ven1DWT81Gml4VayOmqY5yJzF7R2dbdMw9hS
 ZteA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqXOpiTAIU8LHSILseC4i5AZFgg7AjOAk9hsSdbRKc76DzfZbbzRTKeoBeF5hauI+Tv88=@dpdk.org
X-Gm-Message-State: AOJu0YzzwOS0KDYexti1gXn5taTZn2oz6SvSuoLuCAEWifExZ1squ6O1
 at98kXRhZMg8DXmlrvhyNS8jMY7Cd2I3Ff666Mnd0tbSH2Bb+oN/IOi8nC4LP5U=
X-Gm-Gg: ASbGnctcYvxSZL6QpGbIdW7OA3XhJZkpRpcBBCz18fxQdzZkp/dWyZ2XOVzcsK2n1yZ
 ZZw9sVSaaWpmXN8p1/tjBXN6uESwOc95c8Fp9c4PQE21IqXtk+HQhTRff230hfcgbKNYhU9DfHS
 6MhUeanvNinLsT5WbdOP4sC3y4S+iDtLZc8F1VQK7le5y0rCTw52rU1Hgn6MbZiDuPR0mo7NGZs
 KtDap0mRH/uMkBnea+3DOXdQ6PEavUgg1L3Cp9Pujuh5qPaKvQhwA6ynDsMvPRQoQlIeDle5Qjh
 oe6k41FgSzz+2Buit5Qk4p+YqECP9Hy5So2OG41oDQ8WwJtt3F7+i9pKwkegnTIwJNhS6X0TCIa
 uXNP8vL07yG6FWpSS
X-Google-Smtp-Source: AGHT+IFt98G8IyQxmrynzallG4Td5eOB6d/nCJ9jAP1M4+xI+njMYiu6TpC1pWhWUH1yFrtOzVqgZw==
X-Received: by 2002:a17:90b:2e8e:b0:2ff:4bac:6fbf with SMTP id
 98e67ed59e1d1-30a343ce7abmr961274a91.7.1745970914524; 
 Tue, 29 Apr 2025 16:55:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3480f0ccsm214217a91.30.2025.04.29.16.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 16:55:14 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:55:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>
Subject: Re: [PATCH] ethdev: remove callback checks from fast path
Message-ID: <20250429165511.26414666@hermes.local>
In-Reply-To: <20250429181132.2544771-1-skori@marvell.com>
References: <20250429181132.2544771-1-skori@marvell.com>
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

On Tue, 29 Apr 2025 23:41:30 +0530
<skori@marvell.com> wrote:

> @@ -7131,14 +7118,11 @@ rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
>  		goto out;
>  	}
>  #endif
> -	if (fops->tx_queue_count == NULL) {
> -		rc = -ENOTSUP;
> -		goto out;
> -	}
> -
>  	rc = fops->tx_queue_count(qd);
>  
> +#ifdef RTE_ETHDEV_DEBUG_TX
>  out:
> +#endif

I think you could just fix the ETHDEV_DEBUG_TX to just return.
Other ethdev functions skip calling tracing for
the case of errors.
