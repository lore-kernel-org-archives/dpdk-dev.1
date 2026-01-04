Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C4C2A062
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Jan 2026 18:04:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 297AE402BA;
	Sun,  4 Jan 2026 19:04:38 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 1A31340273
 for <dev@dpdk.org>; Sun,  4 Jan 2026 19:04:34 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso19271263a12.3
 for <dev@dpdk.org>; Sun, 04 Jan 2026 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767549874;
 x=1768154674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLjm0YNWUa9VrXHdFkOPXomuWiufFStbsUqmw82+kgA=;
 b=ZukcGf4177OA+brZf7BdSPyFfJn+RYFImqSdXoS8eqSFC3/ROmKnSE+hVZrdSyeaPw
 8eRKvylrDfIRObpOdhw/nB2QxQfKWBp0Kp98YkRyUG7nlG6S2FlgJ/Afosrz/VFLiw0Y
 aCbZdS5YCoBss9uZDF3XSsByWM0VStvVDwRaJsa8TdPr+LuSxA6uGYeKhKroJHySjbi3
 FhVlLzMY62wIuhHfPVKZn0RgGqiRkoAoFw21qOuqmpk3x9KBKzLiWqz7XN9mcRSQ/cjs
 lu2gBjSIAcfWP/8SmdWZgRH+gyzhoNyGoE2wn51sm+11a8RaqmwGjSDyFmu9uQOlWWV1
 aoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767549874; x=1768154674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLjm0YNWUa9VrXHdFkOPXomuWiufFStbsUqmw82+kgA=;
 b=Fzed8BWIyjlHSEOxcHqesBhsszPHUz6bXxvJYbq/PXOhEMR95K3pam2Gu/EcYCd74N
 ODkm0y+wjNAQ8Ki9ipZfGK2NQOK8PhzjWY45/o7sjDqJGlPe5lY9YfLk+XYVdMK6pAW6
 fvgcBgE4AWVjWpTv1M3yvn7LPojYXhlD4eDAuzUdaNzyC2y8rM8MFrQetNve3928Dr1/
 5PWeG1TFlzWuXndjKqGudM9SmgkO4qOI5sgQRMm/q9/Q4WNTPtsGPyB+QrHhdMVSMYs0
 yaqrx8sh84pkZjeeBykYpVmG92HFXjYaD8rtRwbrk3PjwXZ9kJuMfsXsbmT2SoqEkNtZ
 Itdg==
X-Gm-Message-State: AOJu0YwNxZN7AaA7uTMRnQ0gumKTWKOoYsAjbkYjD80QlseC7DSqRXsk
 4kphbRoco5pwCRFyyNMDJT2ufWfCd9mi9p0qY/BknLlGzBuKAbWY86nFr+gziapEE1Y=
X-Gm-Gg: AY/fxX46YkQNY3Bm9rGG1iD9g72RfS2c+sUMSYtJD04ULtjpm6PqxWlevGSDqmH/sMs
 tXHy54wcZ0lzvLAv1NIQkWAx9T63e7FvLG4MVdEbdbTbLGY0Zdeig1Ikkaj8zKS1udVXZZZ0ggp
 FXYjZJOTjr3kkivADK9sXKnx50w83+m9DlNZYdxb/4G1qRqCxBZnOPRAUORWClpNaKjLLj2ej06
 W3H0Q12r5DxcoLHaWfj6qLo5lhOIySzu/Pxg5ch06ASO7AWQrV5qKEuvDYK3EQaufneavXhc1zD
 59BstvLHNUZqTTMDTuOOAzcqhaRqz4uA62060gIUTppvrO8GtawIrP+mkhHFxymq4ayaMmkZTYw
 wdmjrH/rjFwwaBqY+gFtKflm61m+1+bQGaX8j3JpI0vnMHbcoXa3iEOd/mG7EuDghnNY7KvGCrh
 FvCTue+EANQB5oaPThBccSH3XEAPWVl4eqnzUlvSkULOVs1MG/kxfBJLF5JegzCmQ=
X-Google-Smtp-Source: AGHT+IFs5/l7HgCccze/4LQKeZQDpSWnWycaJ6mZ+eO/wum2gIfGbNQbzJS14fJR98L/kiz8rdhh+A==
X-Received: by 2002:a17:906:30d4:b0:b80:3fff:3369 with SMTP id
 a640c23a62f3a-b803fff3447mr3707844866b.48.1767549874316; 
 Sun, 04 Jan 2026 10:04:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ad83dasm5494016266b.25.2026.01.04.10.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 10:04:33 -0800 (PST)
Date: Sun, 4 Jan 2026 10:04:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, =?UTF-8?B?wqA=?= <mkashani@nvidia.com>,
 <viacheslavo@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC PATCH] ethdev: support Rx data discard
Message-ID: <20260104100428.671ac8c6@phoenix.local>
In-Reply-To: <20260104131301.196350-1-getelson@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
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

On Sun, 4 Jan 2026 15:13:01 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> In some cases application does not need to receive entire packet
> from port hardware.
> If application could fetch required data only and safely discard the
> rest of Rx packet data, that could improve port performance by
> reducing PCI bandwidth.
> 
> The RTE_ETH_DEV_DISCARD_RX_DATA device capability flag notifies that
> a port hardware supports Rx data discard.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---
>  lib/ethdev/rte_ethdev.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index a66c2abbdb..10938ddad3 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -2170,6 +2170,8 @@ struct rte_eth_dev_owner {
>   * PMDs filling the queue xstats themselves should not set this flag
>   */
>  #define RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS RTE_BIT32(6)
> +/** Device supports Rx data discard */
> +#define RTE_ETH_DEV_DISCARD_RX_DATA RTE_BIT32(7)
>  /**@}*/
>  
>  /**

Just because HW can do a feature doesn't mean that DPDK has to support it.
There needs to be more justification.

Why not use a flow rule?

