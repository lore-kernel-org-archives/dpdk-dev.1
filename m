Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACA6FEEF49
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:09:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2127B4028F;
	Tue,  7 Apr 2026 16:09:57 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 146064025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 16:09:56 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12c0b72dac7so2601164c88.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775570995;
 x=1776175795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xi1ArdIP3YRdBL0mjsw6DRb8KNqEygrEIYg2WslWPIw=;
 b=ROBd/A8empYXBR7QFA1OgzBEN/PMNsZwl2ms2orCw1dK9cqPU/zHwki/J5UH6IpNqm
 pc+sM55Wn5Z9pXz1i5C75oIQ8tg0BllptHvcJ/+FDsTy4b536JB/cznQZTFhS2Pq8Kjz
 W6PFhq5rJUxZJKezqWhlhk1B6sYRKL2XIRR1i5Ks69QIrh7cl2QT7BTZ5xMpT/0NvodZ
 ZQzxSwHl9tqdLkwAKC6OVVkrjfy3gAx/VnOUQcr8RsIw3NhsrE6kJNAGOgSHAg2VEiuV
 DwUFdzRBbZ58WvWHxk8JbfUJbz4ZRIVcR2ex4VC/6gPu2R8ljvjPmc/a8Y6sj/doAeK9
 Ay3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775570995; x=1776175795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xi1ArdIP3YRdBL0mjsw6DRb8KNqEygrEIYg2WslWPIw=;
 b=kCr2FOq86u1wMwPBWmrbXV1hgfpQ2f/VNPow29tqmVdQMyBYdie4NwmMj2cspVDG7f
 AqqZdtH7Vt8wWwNZZ8uok/VREj8j5w3nNIZMa0Hcfrw7/r+b7cf09/qXi26p9ytcdgL9
 rJDKWVR9SisAC27fY65XHxW1WDcjgrvsp7WCN+kHesldKWcfF5aez1GuHhOMyPIPxa44
 EFWOvMl1/ecM3DiT0HHXvp+Yxe9c38eJJjlm3P4nC9mjOBqyqRD2P4smbxbIiQoU6rw6
 cfgMkSJzG6YlozQQKL5GAeCktuvjIDx8PQmaLik4GOjoXIvMM89ve9dQkRYeRYx3SjG5
 0hQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV+UZuYbuGGxDKUDPJM25pk5cDUw+5r/40GPl3KJje7IoKH24OIurQKZN2v5LWf5n7zbQ=@dpdk.org
X-Gm-Message-State: AOJu0YwKPalBpU937UpRWFK7P3p38MaJlKtl0aRbFiVBdfzXLLiRGGFh
 uTEYD72gmeCZmPc71nBilnemM70dbc1jeBWlDkalgYUKNI2VJlJnKgY7zBfPItaBn7I=
X-Gm-Gg: AeBDieu/gII0StIwIJEW+6xhwBkVb9ib5KDT2VbD4ZSOqgg99qHn4Y6JYgqAFI3Ll5I
 hwT/MxQgtiZor5rY1z6p8pPdMfq6TYcaWZVAdOIWJ9FKQbxlgmmdKikoy9Ld8JsXRKUYLFN+LD0
 gBcc82f0Lfw5g21I5oJcP83ZQ+dF6iqUavGhh2ruSWgLAN3Jjs6A767VwjHZYBDRDnLcLwUSGt6
 iI99x7GahlTM3qLA4HinhXUo1dyBq7Ggep63AvqiqDu7YShSKyiPLgaBbe/v8CQOYwaVNeGsXmN
 t5GcKj8qR2XH1lXGsRmhEJK59AwGq0MmWXT0mJOcSQaA3ckghv42K95zcQFHEsYLKXo1H4Pazaw
 gWb7kkneceEaQEloyFbJJz1YD5+ZDlEJoMZLb1Ow9T39t6DBGHvhwjdwB7XZa+NJnZAj92aBjNQ
 yyzSne4HHQGb6CSyAu3XPYJl9uUKbwx9zP/Dc=
X-Received: by 2002:a05:7022:62aa:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-12bfb70eae1mr7916853c88.15.1775570994867; 
 Tue, 07 Apr 2026 07:09:54 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bf90973b6sm16265938c88.9.2026.04.07.07.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:09:54 -0700 (PDT)
Date: Tue, 7 Apr 2026 07:09:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>, dev@dpdk.org, Weijun
 Pan <wpan36@wisc.edu>, stable@dpdk.org
Subject: Re: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Message-ID: <20260407070940.225de771@phoenix.local>
In-Reply-To: <20260404171912.48947-1-wpan36@wisc.edu>
References: <20260404171912.48947-1-wpan36@wisc.edu>
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

On Sat,  4 Apr 2026 12:19:11 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
> index e625a5c035..bbeccd8fc3 100644
> --- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
> +++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
> @@ -204,33 +204,33 @@ struct swp_active_dqs {
>  
>  #define dpaa2_queue_storage_alloc(q, num) \
>  ({ \
> -	int ret = 0, i; \
> +	int qs_ret = 0, qs_idx; \
>  	\
> -	for (i = 0; i < (num); i++) { \
> -		(q)->q_storage[i] = rte_zmalloc(NULL, \
> +	for (qs_idx = 0; qs_idx < (num); qs_idx++) { \
> +		(q)->q_storage[qs_idx] = rte_zmalloc(NULL, \
>  			sizeof(struct queue_storage_info_t), \
>  			RTE_CACHE_LINE_SIZE); \
> -		if (!(q)->q_storage[i]) { \
> -			ret = -ENOBUFS; \
> +		if (!(q)->q_storage[qs_idx]) { \
> +			qs_ret = -ENOBUFS; \
>  			break; \
>  		} \
> -		ret = dpaa2_alloc_dq_storage((q)->q_storage[i]); \
> -		if (ret) \
> +		qs_ret = dpaa2_alloc_dq_storage((q)->q_storage[qs_idx]); \
> +		if (qs_ret) \
>  			break; \
>  	} \
> -	ret; \
> +	qs_ret; \
>  })
>  
>  #define dpaa2_queue_storage_free(q, num) \
>  ({ \
>  	if (q) { \
> -		int i; \
> +		int qs_idx; \
>  		\
> -		for (i = 0; i < (num); i++) { \
> -			if ((q)->q_storage[i]) { \
> -				dpaa2_free_dq_storage((q)->q_storage[i]); \
> -				rte_free((q)->q_storage[i]); \
> -				(q)->q_storage[i] = NULL; \
> +		for (qs_idx = 0; qs_idx < (num); qs_idx++) { \
> +			if ((q)->q_storage[qs_idx]) { \
> +				dpaa2_free_dq_storage((q)->q_storage[qs_idx]); \
> +				rte_free((q)->q_storage[qs_idx]); \
> +				(q)->q_storage[qs_idx] = NULL; \
>  			} \
>  		} \
>  	} \


Why are these not inline functions.
Macros with lower case names are likely place fore confusion like this?
