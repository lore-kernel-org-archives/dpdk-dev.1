Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16751FF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 14:06:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D77D4021F;
	Thu, 30 Apr 2026 16:06:36 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 07006400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 16:06:35 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2ed0a45e970so1089624eec.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777557994;
 x=1778162794; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocS0nqdzC4KFCMYdJA2X4i5co+RW7f8vIy4z+kSY0v4=;
 b=jAz4iqIdcFbMOp1jPY0XVpwsARPUsXixKssc21V2VvuegY/7E/UElfHY4GYGzN6a7a
 bHaYtGP1KRqLF/BLH003ZpxhALiOZgb0gbEFsQoAl91rjKCTPQD5/LhwrcHxcXHjZgZt
 ck1CHHPrECZm8XGNdEPygtrCCjYLz8GMNnH+azttiv3NGsN4pfE56JPhP+T5DRJFtObG
 uPIekyYR4eqClONdIJpr667Y341MF2ujWHrYb7drGuRt4VomEGIuEJehN3NnS0XvzZn9
 NEqAn42wyyXORBFii15thlg3Wiqvc7YUYxAqSPdiCy/lgQtx6EsC8Xu9VZHqSA2795Le
 Snaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777557994; x=1778162794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ocS0nqdzC4KFCMYdJA2X4i5co+RW7f8vIy4z+kSY0v4=;
 b=a3l5TZppjTpCg6Qi7H6NfjRWLyuQpfd81KDtiIMi0esROt7DCGI3AouXBkA8uOVA3S
 dmGsc3Ddy58Uxic4uBXm+Dt83xDy/7jjpocy/S/Lld8IDwnCE76ZSdrxZy2iVnec/vA1
 WtHZ/3r2HVphs8+4zyLGAVlEOvTA6MNT2jk5f+Ria5JZaiRCMxJKfEC4+0sh2vJ9d9bx
 9Ih1BB5Grdj2P6Ej9qzE8535m6uqm+KvXE+8Jgzr40DPaSIwtz6AwxHflrhjTpYYnaWC
 /uSAmdbe8UcgZN1J2cyx4Nah31qidllGE5WS7sDa1lMW0YdjW/L6+ch3r6MXySWDsti5
 KASw==
X-Gm-Message-State: AOJu0Yysm1ul3jqJ3OjqALKWe43POaiX9QivsNZw/QnGg615ESLyOxSC
 E9duRlUqJdVMiG0UNDubYVcwss/nosYipz3kMrFLkeUepIv7gVWIpulxkFTYm3Sz8ME=
X-Gm-Gg: AeBDietXm0XU6SCC2k3izDAeAJWNH4WB1W/HGOr8+ly1WX147dFShNhy0W+9DX2embV
 GEpnImprXgjluTh4bIY2ghPTooYeZbdp2XEMIUPI9Hyorz9ugxu40ACKVzkYUTLIaEgZypfv9oE
 2g3oxTLOm2GgXSQQR7uGDi8P+ceVK4TBhwx2WMy+btJgA295Us9tSktNsppwT5Pgm8tmxSnYYll
 stfHsGgcYKfv9tLdFicX8+JQCXxdEN/64tGbGcenes7nrrNHeumEs1aW8OcMkrfpXwWMMt8CUol
 1HeVMDgl7U43vc0IX4MvK61tm+3Mx6iluoB5VcGl6zBlK4hdG7P0K84CD/ogHHjUIkGLMfWl/as
 Cw5NIfvYrOPEn/ec97ZXbiZ45ZexI9cOeMpjYQ2bQQGJ6/I+VCHRf5IazYFY3ZJd+n0041+upYC
 Ho7tMx3z+WEDQJyREpnyoC3guQAqi7I+yJT6+tyRIwwaS+Iw==
X-Received: by 2002:a05:7300:2383:b0:2ed:e12:376c with SMTP id
 5a478bee46e88-2ed3e87c86emr1480402eec.34.1777557993687; 
 Thu, 30 Apr 2026 07:06:33 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c07058esm8898475eec.15.2026.04.30.07.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:06:33 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:06:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, reshma.pattan@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, marek.kasiewicz@intel.com
Subject: Re: [PATCH 6/7] pcapng: add user-supplied timestamp support
Message-ID: <20260430070629.2bc79119@phoenix.local>
In-Reply-To: <20260429073111.3712950-7-dawid.wesierski@intel.com>
References: <20260429073111.3712950-1-dawid.wesierski@intel.com>
 <20260429073111.3712950-7-dawid.wesierski@intel.com>
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

On Wed, 29 Apr 2026 03:31:10 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> +static inline struct rte_mbuf *
>  rte_pcapng_copy(uint16_t port_id, uint32_t queue,
>  		const struct rte_mbuf *m, struct rte_mempool *mp,
>  		uint32_t length,
> -		enum rte_pcapng_direction direction, const char *comment);
> +		enum rte_pcapng_direction direction, const char *comment)
> +{
> +	return rte_pcapng_copy_ts(port_id, queue, m, mp, length, direction,
> +				  comment, 0);
> +}
>  

Turning a function that existed in previous release into a inline
breaks ABI compatibility. 
