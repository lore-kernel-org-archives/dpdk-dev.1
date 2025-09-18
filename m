Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76CCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 15:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33C0740611;
	Thu, 18 Sep 2025 17:08:38 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 6ECE040288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 17:08:37 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-7970e8d1cfeso4574456d6.1
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758208116;
 x=1758812916; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Le040uKjjezzOMibKYrfgiOvcG7HWuMWyQT9KXoBwN4=;
 b=d3lvhU6lLAgkT3BJKwFiRAVV62HYBKUIPu0bWEh9RgpjnVBsUkiCMEixJi5PYAoeKf
 dwZyZ1+7quygfUZ7pyAARTmKhHocSjA1SSmFZ0i/ZdaWl9VLiL230/X3se5usH03hBrT
 YL6f4xiEgD5t2Z3ioTdKCV5yaKV5dcNNAMM5377A6eZXz4gAgz72pR9RzO+xHxTIR79+
 nZhFrMZzepGJ7gMTzuNHEoRyplNHpE5ov39rMAzct30Kd0qFeK/Iq2MCrd9ZSPEp3yXd
 IaUV1x78gr/eGd1pRB6TULxCMacFaCQzEUyWV9TLCGQdZl/weqFQgt8QNoCvAoqebnzl
 kDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758208116; x=1758812916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Le040uKjjezzOMibKYrfgiOvcG7HWuMWyQT9KXoBwN4=;
 b=tPAw16lQv+RPFlpDWlfzKxGNuqUhpggjBm+BRbkXtccAEFAE4xAcmlCyqXY0BAHMRk
 10jsZonJ0iLV8jdbgPcqsDh+Q6uUXjLmYH80OzzIgCe7G4hFwK4OKrBKCGCuFch3AfHP
 YQjbqZ4s1r1v07pjllHO0Ob0bTV3Jo70A3ATc6JgfX1VdipyZYb2BwQ/Wmpxvr+Sa2aI
 smLPX+zufGug4T17HJ7SaewlHsFRSfWebOD4V5lrqyNTYZxq+VUkeG3yf+yY0aCqHeTj
 gttdmg0f3Zn+DKd9QiOHPW6yaj2V74rAZJrQxWk5iFcxBiI4r/tCDlAEDxb+bqgNoh9l
 E3LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe7Id/A7wgEVuu770SU2dlAzVVgrszTKqki39+Bk4xMLOXDT+P5brZa39EpCd7gUKrD8M=@dpdk.org
X-Gm-Message-State: AOJu0YxhHRsP12lzsIaAgTQCrklZF6S9jPx+c1vah4+/kuMFr/hlxXgY
 a3AsdxxMRE9PVtdx1/lbXs6mytDX/Cfz/jinT3xLjIp75aPscHmjRcP7Ik3ANYn+b/M=
X-Gm-Gg: ASbGnctEyEnUZhugRL9M72NfY9aAAklTiJnvpDzQvFys/Ge2sAqVC8FsbQJL8WksA+C
 Nc+MD97pebF4COE59qbnxtvmnfxciCgkYikOpsjp0DqGCGRsMrJzrl+8xDKOkeivAd23q0kHxcL
 wwUa9xn1uV2YGTKbqMtln0Oozz7KHb91MgqHkAWJu9Mi8+cjnCRlVWSPleVTbraRBArAPr9zIzC
 Dnc+Q6Vvjnh6jQ71T/WHwvr5jARddhlBF81MT49zb2YvVmOtnuIFu9x9ia9vtKkBw+v6a447y3T
 3C9wNBgY6UZRFnVVYQWhJY5d0wkM17qTzR000PtZmQLl+HPlhJMcQGDk3IAEwBuCUOvRABucY2c
 G1gNwMg7h+kX8HrecJHwfULoTBp70dNsCA7Sg0IqbjQ6W4kV9Hu5sF1eWobMcEGLruYXUwQDZr4
 xgLfnjIEmZHOs2C9xZVQ==
X-Google-Smtp-Source: AGHT+IHd2J6g541B5qyfIjlpKythsjlWwIyRfTLddvktuVzIly5i6KEbrat/iF/43tKXfvsudPePVA==
X-Received: by 2002:ad4:5992:0:b0:78e:d1a1:2323 with SMTP id
 6a1803df08f44-78ed1b06601mr44559626d6.11.1758208116338; 
 Thu, 18 Sep 2025 08:08:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-79355ce6648sm14013176d6.65.2025.09.18.08.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:08:36 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:08:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, Lijun Ou
 <oulijun@huawei.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v5] app/testpmd: stop secondary process fwd_lcores
 during primary teardown
Message-ID: <20250918080831.1057b4a4@hermes.local>
In-Reply-To: <20250918064703.528973-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250918064703.528973-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Wed, 17 Sep 2025 23:47:03 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> @@ -3628,6 +3709,7 @@ pmd_test_exit(void)
>  		}
>  	}
>  #endif
> +
>  	if (ports != NULL) {
>  		no_link_check = 1;
>  		RTE_ETH_FOREACH_DEV(pt_id) {

I will drop that extra newline... Sorry

> +
> +static int
> +handle_testpmd_request(const struct rte_mp_msg *request, const void *peer)
> +{
> +	const struct testpmd_mp_req *req = (const struct testpmd_mp_req *)request->param;
> +
> +	if (req->t == TESTPMD_REQ_TYPE_EXIT) {
> +		printf("\nReceived notification of primary exiting\n");
> +		fflush(stdout);
> +
> +		/* Response is sent after forwarding loop exits */
> +		rte_atomic_store_explicit(&primary_name, peer, rte_memory_order_relaxed);
> +
> +		kill(getpid(), SIGINT);

Needed to use kill() here to force end of read when testpmd is in interactive mode.
Only other option would be closing stdin, but that seemed less safe.
