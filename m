Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C2D3EE8A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 16:19:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E11384027A;
	Thu, 22 Jan 2026 17:19:55 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id C2E644026F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 17:19:53 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso16455555e9.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769098793;
 x=1769703593; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5a6JY9hyYrF8NeA0NCBJ04r6B+6+bFXj3c7t6CRugs=;
 b=KnRubuolAFR7/WMNIKiKrrKtrROw+braPWmCGKj4es4blTeX5Jo+eO+7+LTYdqQ3G/
 SGP0T0nNgkMBEidNW99JPQAy0JuN8wnYYmfDmcmklybSr5SpcGXung/w4QC8ZQpuU4yx
 zBAzVIqKA3YNaPmf1nsRQFdc/VzsAP3Iu6ouXxCyhdUre1dgEMVBKgkySgWVqpeTz22U
 6BYr9PaSQyevHegjH/fReJM5gyXlcYR2viSZnNeCVoQwFIY6eYHX4bwoyRVaWyZBBQHC
 snLvjOT5y91ZXP2Mh3rsbUdCgxW5uOBV18jInRSoMWKEDbRl1E83P/WPkSaUKhLXbU1D
 blAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769098793; x=1769703593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k5a6JY9hyYrF8NeA0NCBJ04r6B+6+bFXj3c7t6CRugs=;
 b=eIkL4bEXgyUZ6k/MJBocfrCzPmpuYoRBT/ypTOe/33NxkkJtssg+sHekg6k6BHpkzV
 we01MgEqe3zz2N/EmSlwLQJQSirPPt447b8eQUmM/f6KJ2OImSj4H9Zb/UHugmCNUVer
 fRhBNCJbzIXVSdgAtLNNPeb+y6MABTKCvsBgMuCSyJ2tExaOEd6v+BiXEOt8nLphEsRi
 Kpjuw3wIY+4PnFTM08iMU0GL99ZryUgJ0B93hl0ddR0A0rTQelKEjl095vEyBH5HgKwx
 1BSsHV5ZZDB7OO0x3vtv7ziTmAi3nCjjUlAze8neCyX/2ETTgPm97IROicduhcnEw71k
 QEtw==
X-Gm-Message-State: AOJu0YyKQ2jxbWch5UUx1WCafNO6xNm9PTViEd92ErVBnEVH3FCFR9CD
 V2lQlz+qh7pMcPEQSW97qhr8lUZy26RGy2O7AR1G36ivWaICzd59t9YcIDmNHWBnEJ8FGRJbCf7
 kav0X
X-Gm-Gg: AZuq6aIVvBBqaFJMTAo4ppALqUoBUsjMLSoCG7EUwbEssMpXA4HKNqnxfcCdp/Su1rE
 fkkNsjso5Z8phXIL2cbLF+bOMWhzfuBvTlspH2hlGVsReJWNsqxbAYzdhOYLAxZuPzY3QXBPFNM
 K5Lg1Ajy7kgBsRWmVrj4VuS4MO9ZymjdgukdxZ5sOtdr92M5xvF4JNX6hYZiQvbvqvF8fjjaA1T
 83guTPkZmTBi6A52idEebGnakyNJYA3hR04u1CFCEDSY646H+Tv7moIrJ6PCGQP9kFjeikMCN+I
 VjuJhCZX+sgB8B3IN3uXjS6AKq8gS580QMv363AxoV0K5Hu9UmDWvkQ9BGITF4gV6nuQM+xFoTy
 KBL3F3c18FIjmcO+6dji+KcLKPCuflYOX04S2tnzyshmOx1iEYcVL/PMDmfRwAcQWnoIcOaze+C
 MPdbI7p7hercdNYaMXSwRQQ+kOUzbUwvt69JpJTuiXPWYA68mR8zV7
X-Received: by 2002:a05:600c:3e06:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-48047073a08mr58410585e9.8.1769098793223; 
 Thu, 22 Jan 2026 08:19:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm44000290f8f.19.2026.01.22.08.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:19:52 -0800 (PST)
Date: Thu, 22 Jan 2026 08:19:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 1/3] test/bpf: skip some testing if null net driver not
 present
Message-ID: <20260122081948.5ce3a84b@phoenix.local>
In-Reply-To: <20260122122354.1820368-2-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-2-bruce.richardson@intel.com>
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

On Thu, 22 Jan 2026 12:23:51 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Some of the BPF tests require the net/null driver to be present, so skip
> those tests if it's not found. If the early part of the tests fail,
> return that failure - on if they succeed do we return skipped on the
> missing dependency.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/test_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index a7d56f8d86..ae588acb16 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3725,6 +3725,11 @@ test_bpf_elf_rx_load(void)
>  	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
>  }
>  
> +#ifdef RTE_NET_NULL
> +static const bool have_net_null = true;
> +#else
> +static const bool have_net_null;  /* statics default to false */
> +#endif
>  
>  static int
>  test_bpf_elf(void)
> @@ -3732,6 +3737,10 @@ test_bpf_elf(void)
>  	int ret;
>  
>  	ret = test_bpf_elf_load();
> +	if (ret == TEST_SUCCESS && !have_net_null) {
> +		printf("net_null driver not available, skipping remainder of BPF tests\n");
> +		return TEST_SKIPPED;
> +	}
>  	if (ret == TEST_SUCCESS)
>  		ret = test_bpf_elf_tx_load();
>  	if (ret == TEST_SUCCESS)

Only the tests doing ELF load need a device.
I think that part can be handled at compile time with the #ifdef
or by splitting the ELF load tests to another file and doing it with meson.build
