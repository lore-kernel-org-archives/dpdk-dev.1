Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB65108E1DC
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 10:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DD63402D4;
	Thu, 19 Mar 2026 11:34:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2800C402D1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 11:34:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773916466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kRZ5gt+PRxHfyhNUAkOyCz3HYu3OHfP/c3s3UlYTnkY=;
 b=dzejIMZf2VnQsuwu16vQA8ku2STHSApMbes9g3Y5tPua5xbA9kBwu0inkSG6y5OZeNe0O7
 fOqaDizG1T7yNbaR1TtFZ7GfKEe5ersWgUIjDy0rsSqJaFBySlLIWXuiBDj+ngfmCvC7ej
 F/4Q7wO8/8VNgEzWNxqXsIz5EwqDMNc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-je6v_J-9NrWRmWfKR1OGyg-1; Thu, 19 Mar 2026 06:34:23 -0400
X-MC-Unique: je6v_J-9NrWRmWfKR1OGyg-1
X-Mimecast-MFC-AGG-ID: je6v_J-9NrWRmWfKR1OGyg_1773916462
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b3da235dbso1032822f8f.1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 03:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773916462; x=1774521262;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRZ5gt+PRxHfyhNUAkOyCz3HYu3OHfP/c3s3UlYTnkY=;
 b=WJxwdoHICueqkrMOgz8S1tkkasxxrroH9A2ankHFWhknEZNgRTp/h5F2UFAH3+yRIL
 cGaLm6Q9DiKJv1KbltWDMR9ijW29oxECmM1dbAJmwI9s3dXWb6yKRlNC4Gm/WLG6jqe0
 a8Y3CG3FxvMR3cAnBf8RdjO5XYcUMaydCX5O1QsYuKuWrY7w0FeCzOfWg959IVjk1D9Q
 zHVgvJjPjhC7aZcwjfK3JnS+/nQOQLLv/jYdpQrVGWiKx2SszZgnKl6wwMI0Bh/a/+Bh
 i+jECv3v9lKnMnsboAl7shuR1il0XBYhP59typJoin57KKkRRE+692IEuYs+BzhGcy3n
 j4QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzCR9uyU8zyVwi98EOyhIqNunbr9NjA8VweiG7iGXRyUSFCb83vvX26yxGbLqAT+ptDbY=@dpdk.org
X-Gm-Message-State: AOJu0YxUxYOejdHT7+bEQQuNZaBY+LDUk5Me4Cg1s/vfHomnUhJrNx2t
 r9RCqH54diVcatE6kJMBXnCtNF6UAsQZpI56S44n/+zdpMMO80knRgYps8IBnlmxSlqYQQN2yLM
 /DfjCvep8WCEeuLF4e3CWiSEMUo+imhzvvMxIj+snhpwj
X-Gm-Gg: ATEYQzz/8pRLcIF0y5xPV4aiOi1Q1y5693HKgA4u08kZRM20/dPPb2X2a37RaC5bQyB
 qaVnPCiJNqHUlERecq1YS3Qzlitg5yCdrW525Bxhw9hVw7AT+oukGJXLEb6jfoaZDqYJ1FUNrcQ
 9GHUbWnrfuWJ9BdE1l0nv+HAdqvD+DSHVty8JzQg7AGJ9YkOQjY0xF3HTDJ3HMH17DAgwaRWWUu
 +uP1+m8C5BZjl7R4CxxFh5BfXlrGNMZkiICkrodj9mZzVD/Xn1fMMc2Xh5RnIoNRCu172Gtoe7o
 RSJVcQhWzRjSsz5RJqNwv/rghEuQV/1eBFLa1lixpD7bf8qJsjgIFZxKHJpZ43cM5mMZhQCMbFl
 MzTJQYlR06QN2H9DyP7PTvgqL
X-Received: by 2002:a05:600c:c8f:b0:485:2ce2:4c75 with SMTP id
 5b1f17b1804b1-486f442206emr121597595e9.1.1773916461986; 
 Thu, 19 Mar 2026 03:34:21 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:485:2ce2:4c75 with SMTP id
 5b1f17b1804b1-486f442206emr121597095e9.1.1773916461458; 
 Thu, 19 Mar 2026 03:34:21 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e48ad5sm173785145e9.1.2026.03.19.03.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 03:34:20 -0700 (PDT)
Message-ID: <28deabb2-361e-4379-9db2-42e94eb352c8@redhat.com>
Date: Thu, 19 Mar 2026 10:34:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] pcapng: handle packets copied before file open
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>,
 Shani Peretz <shperetz@nvidia.com>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
 <20260228175601.585102-5-stephen@networkplumber.org>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260228175601.585102-5-stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UFp5C3Jkpf9LMfq5yaePXwRdxJ-L9nfIps6tc76KUN0_1773916462
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 2/28/26 5:35 PM, Stephen Hemminger wrote:
> Either through misuse of the API, or races it might happen
> that rte_pcapng_copy() is called before rte_pcapng_fdopen().
> 
> Simplest solution to handle this is to modify the logic for
> TSC to nanosecond epoch conversion to handle the case where
> the difference is negative.
> 
> Bugzilla ID: 1291
> Fixes: 166591931b72 ("pcapng: modify timestamp calculation")
> Cc: stable@dpdk.org
> 

Hi Stephen,

Fixes tag goes back to 23.11 but the fix modifies a function added in
26.03 commit below, which doesn't apply cleanly either.

So will just drop from LTS. Otherwise we'll need custom backports and
there's quite a lot of churn.

thanks,
Kevin.

commit 4fc65615b274701070c67f8c424d93aef8bf7483
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Mon Feb 16 13:38:03 2026 -0800

    pcapng: improve performance of timestamping


> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/pcapng/rte_pcapng.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index b93af418aa..b5d1026891 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -157,11 +157,15 @@ tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
>  {
>  	uint64_t delta, ns;
>  
> +	if (unlikely(tsc < clk->tsc_base)) {
> +		delta = clk->tsc_base - tsc;
> +		ns = (delta >> clk->shift) * NSEC_PER_SEC;
> +		return clk->ns_base - rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
> +	}
> +
>  	delta = tsc - clk->tsc_base;
>  	ns = (delta >> clk->shift) * NSEC_PER_SEC;
> -	ns = rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
> -
> -	return clk->ns_base + ns;
> +	return clk->ns_base + rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
>  }
>  
>  /* length of option including padding */


