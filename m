Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F80606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GxCbuHcc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0526240655;
	Thu, 29 Oct 2026 16:48:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 1B5DA402D4
 for <dev@dpdk.org>; Thu, 29 Oct 2026 16:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793288921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KseZJTcVHFfPtaIGqI66Mq/Ujzj8PsHXkDDB5NmSBTE=;
 b=GxCbuHccpbJ6830bhs52DmKwwboPg4vDHJpAW0XzjiYPCVvGQs9w2S1Bb5HVhfH2at/DaK
 Ns0l+SnvsimLrNlIV1wOiAjuqdES/HcaouX1l1ivnwHIyodoUR+ieZVYEXyMqWCWP+PZGB
 B/h+3EmRYnAC2DqhW8NqSd6BuAhXayI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-eNi8K78pOJ2Ti1KD1_0a3A-1; Thu, 29 Oct 2026 11:48:38 -0400
X-MC-Unique: eNi8K78pOJ2Ti1KD1_0a3A-1
X-Mimecast-MFC-AGG-ID: eNi8K78pOJ2Ti1KD1_0a3A_1793288917
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6b1d35e3c0fso2480020a12.3
 for <dev@dpdk.org>; Thu, 29 Oct 2026 08:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288917; x=1793893717;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KseZJTcVHFfPtaIGqI66Mq/Ujzj8PsHXkDDB5NmSBTE=;
 b=goTLJN7IGU9mqqIbfgi4NsvgiOBYLMLd2gwppVeBvpP82QvSh5Rr8+cGKdCfWpWIBc
 E6MFek4etUQC1rKBe+EbQVDopmNA0JZUXw6aWZT6MKUgtFCOroKJeCdqONAPt/YuSFFT
 slxlq4h9blvDvaP8nVEGwIrtFQ2GZznGjMcMds1/aLjn4frqCItQMiubg1WO3GaScw8v
 3sse91hucx3gWv9tSbmhcjfouAwW9eAMENbLM5OfkalsxKXhoURNorq8mmZnIbH/ZMBT
 U5WIcXlCwd3+og40+iEA9uJBoEW0qEXV3kLuXFHr1GWWDeFxUnikWiqSL4TY2d9YhpRp
 jB9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdBTLDRJJvcsyCtUsEJiajPhTOipuzPA9l1gmcZY9HH859HTJml7B5eEcUhDA7bxl50MU=@dpdk.org
X-Gm-Message-State: AFq9FYLPydC6Ulkkw7wdskxN7+y/g3oZBf35zrNVVhLaaImqF9BV8i9y
 3R+B8jxOfTT5Pneg7RregEY2jwo3rYQgnaEkthcuBKG7lYoZqWh9jsW+cMguHriVUjxnn/nT38Q
 rtX19ZLZLJPXifGBsM4JIWm5kk4ckW0VVT0PAZ8EKkPLs
X-Gm-Gg: AYBFou119JrmLHWalfKdVXZs7l/HTitkohzzmDj+KfueocmV6DgYrQCS+HwT7+iSBQH
 IHobD8cTH5y3VcIge77giR1wEWk8r5MBdSqGIPTLNcRhNW4CG/44+9lC0eubGui7BXKcSkfAiPy
 ukkChkHy9P4C/Os19jHLJtlD/AqLQ4gVYiFfDIbCYoWpHHSF31+kF7uLTRahHhp41ds0wRiksc5
 izn8Q0ynOSFBomYRUz9Br/08iJ/G/F7ihiUluMU+Z8Tbj1VZQvFJae7m2vBgwkD6Fo+ZyKH4P9d
 BgmceHmQDLzjJMC88JC6eb+y3cD+8SyIDFbohkO6SQiQGT86I4rpOTN+UcIMhwryOOcwUkpxMhw
 vxwRiflFR4UPUe2YH19fUWZhfczOWlXQp/O9/GZ1lSKCvsr+yXUpWZbFip3bzh5aY1CEyOAor4L
 K5VaQelRDrJYZPB5LtU2dOa9ImeL+D9b2OusADPZx2XDfBl4LZzYp8h9mCJyPb2Gq2w42MmLusj
 Vu6bsUqm85Y/6TUjwkWVtI0/iR5foa5iLITcULoVoXEZ1lM2XaLMONzF72WQVnJScY6/tU5sPU=
X-Received: by 2002:a05:6402:1d4a:b0:6ae:fc0f:e19 with SMTP id
 4fb4d7f45d1cf-6b49cc2815bmr4308857a12.42.1793288916968; 
 Thu, 29 Oct 2026 08:48:36 -0700 (PDT)
X-Received: by 2002:a05:6402:1d4a:b0:6ae:fc0f:e19 with SMTP id
 4fb4d7f45d1cf-6b49cc2815bmr4308840a12.42.1793288916372; 
 Thu, 29 Oct 2026 08:48:36 -0700 (PDT)
Received: from [10.50.0.157] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4994c23b6sm2487977a12.8.2026.10.29.08.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 08:48:34 -0700 (PDT)
Message-ID: <92444640-e79d-400c-9eaf-b63ba799c783@redhat.com>
Date: Thu, 29 Oct 2026 16:48:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] examples/vhost: fix hang on exit
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Yu Jiang <yux.jiang@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <20261029144727.119072-1-stephen@networkplumber.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20261029144727.119072-1-stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gLXdqH4kwO9I6mSuRYvjmu0WM1BcWXMe9cXPuhm9cjg_1793288917
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/26 3:47 PM, Stephen Hemminger wrote:
> destroy_device() waits for the worker lcore to ack device removal.
> Since the signal handler rework, the workers exit before the vhost
> drivers are unregistered, so the destroy callback spins forever.
>
> Unregister the drivers while the workers are still polling, then
> stop and join them.
>
> Bugzilla ID: 2071
> Fixes: 5ffa8fafcbd3 ("examples/vhost: make signal handler safe")
> Cc: stable@dpdk.org
>
> Reported-by: Yu Jiang <yux.jiang@intel.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   examples/vhost/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/examples/vhost/main.c b/examples/vhost/main.c
> index 523195f5c4..16c9387f8f 100644
> --- a/examples/vhost/main.c
> +++ b/examples/vhost/main.c
> @@ -69,6 +69,8 @@ static uint32_t enabled_port_mask = 0;
>   /* Set by the SIGINT handler to stop the worker loops. */
>   static volatile sig_atomic_t quit;
>   
> +static RTE_ATOMIC(bool) stop_workers;
> +
>   /* Promiscuous mode */
>   static uint32_t promiscuous;
>   
> @@ -1242,7 +1244,7 @@ switch_worker(void *arg)
>   		}
>   	}
>   
> -	while (!quit) {
> +	while (!rte_atomic_load_explicit(&stop_workers, rte_memory_order_relaxed)) {
>   		drain_mbuf_table(tx_q);
>   		drain_vhost_table();
>   		/*

Are you sure you committed all the changes? I don't see a store of true 
to stop_workers.

