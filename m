Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E4C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 611104027F;
	Tue, 11 Mar 2025 16:49:09 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2093F40263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:49:08 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-224100e9a5cso108148505ad.2
 for <dev@dpdk.org>; Tue, 11 Mar 2025 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741708147;
 x=1742312947; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyI/vsISlw2DYAMryUbC6z0MWlbIxopsPbkYixiq5Go=;
 b=amiERd3s7tSkHSFVMDLjG5KDp6pOzMOAfJXYdVzTVJYUJN0GXpuyZUXZPrcZoHqzCJ
 e9lW1SIjSiTcFnurC9kan97ttb8+lU95+yAEApU2E7DKAi4ZhwFIyLCh6loFrVuXhg3R
 hx/27mZfptq79D/MKzys5qtIvy8mRiLXkhcpIBBVymQcvhI5UjX9kSQGFZOvh7euZG1Q
 a3sCKAAkAEgW/mel2pgveAHAecHYte4UGmtqKFLnKPZBx+WFtQ+PMRjOXxZoC/J+UaXb
 jwqemLSWjFZo65eLjX1wxp2lc/nngJ4dECXAMCVKwhBSGWaGCXDdYvI3/zuErQYlRy8Y
 oNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708147; x=1742312947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyI/vsISlw2DYAMryUbC6z0MWlbIxopsPbkYixiq5Go=;
 b=G5B/ZY9wPHiIVNEJYCHqT8cXnYkL3DPkz3jVmOG2a+WUZnNJYtLvxnfKcS++Do2qnW
 ZUAkNsEaOtgpUD171tV4+8ivWgFB/b7eu7ZqEGo1T+Oe/j+GWKEptPA1PAqfh3cK1AcZ
 yrQHiRT88UqEYSZmvK3MMrF7wRpIgIQyHCj6D/W9FnYgkAX25preudH98YIh5y0NliZG
 1ClYgUyglmm91NCMJ/aIRU7Dv8r3mBvHo+ZgXRq2zqw6XIGvw45mzNHre14PxhNdyD4j
 qD2gkF+X7mfPg/5i1HxVbxUdomyTvfyZKanEmY+EbkwRjuBhxOC5wPt5vAX2Km0MTB6s
 Qapw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0SVx8NB34Z4WVDPHe3p1j3c6MJfoKq/nDartwjR7q9IFB1rY/zgGczIlx8sbPpTdDG/k=@dpdk.org
X-Gm-Message-State: AOJu0Yzh6apck1Vu5xkQTc4ylJZo+HdUpOr5PCm6q2HKka48GyZ/3CaQ
 SxAK8BctjvwnVZVf/ypn51dG7h6S9DwFKxqSxurE2wuCYqV2GseEhOf8MNrKfbY=
X-Gm-Gg: ASbGncuyVfkayha505YkUXzEbSIWyWM7VBU+fkSxYSzJTlxuw6c55gH7efAXYwjkGZU
 YMehJt4mVtubgQSYT1EqpdqkSbYDPs8NBFlDcie55LguHOd7Uou4+yj7kWI4HqSk4IercInstDy
 si/Sa0fQg+bTsmBcLyGJu6QU7U3uiB1XafuShxKVCRZaEP7dGwOAXGckdccv7VY1t+EhrXl1hcX
 rY/nPa5etiwnMlEoiVJKuSsqGju4zZQKq17M+SuF1HEjq7RBGrlc4RY5wrjbg33QXZ6cCTUIe4H
 BrDTGIRGqz8ffLChw0nRzOzJbuHg/7c6oXN0lhsTyU5mKTjT3bF/Gn2oW443vExVF3mHeM3T1zJ
 gnLVXuzNZRA2V88Z3puzHjw==
X-Google-Smtp-Source: AGHT+IHfK16sdYbtTm49Xs17q2eDDksWmovbR3RD2/P4B67Jj1jJ7QhUYIq5+Lguw5yVkTzZ+rJ4zQ==
X-Received: by 2002:a17:902:e745:b0:224:1eab:97b5 with SMTP id
 d9443c01a7336-224288866e8mr314398215ad.1.1741708147240; 
 Tue, 11 Mar 2025 08:49:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ab0133sm99029375ad.248.2025.03.11.08.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:49:07 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:49:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: Re: [PATCH v2 1/3] eal: add function rte_size_to_str
Message-ID: <20250311084905.478375c1@hermes.local>
In-Reply-To: <1741707195-26880-1-git-send-email-andremue@linux.microsoft.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741707195-26880-1-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 11 Mar 2025 08:33:13 -0700
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> It's common to use %' in the printf format specifier to make large numbers
> more easily readable by having the thousands grouped. However, this
> grouping does not work on Windows. Therefore, a function is needed to make
> uint64_t numbers more easily readable. There are at least two tests that
> can benefit from this new function.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
>  lib/eal/include/rte_common.h           | 21 ++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
> index 9ca2045b18..b658d68eac 100644
> --- a/lib/eal/common/eal_common_string_fns.c
> +++ b/lib/eal/common/eal_common_string_fns.c
> @@ -4,6 +4,7 @@
>  
>  #include <ctype.h>
>  #include <errno.h>
> +#include <inttypes.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  
> @@ -87,6 +88,12 @@ rte_str_to_size(const char *str)
>  		endptr++; /* allow 1 space gap */
>  
>  	switch (*endptr) {
> +	case 'E': case 'e':
> +		size *= 1024; /* fall-through */
> +	case 'P': case 'p':
> +		size *= 1024; /* fall-through */
> +	case 'T': case 't':
> +		size *= 1024; /* fall-through */
>  	case 'G': case 'g':
>  		size *= 1024; /* fall-through */
>  	case 'M': case 'm':
> @@ -98,3 +105,40 @@ rte_str_to_size(const char *str)
>  	}
>  	return size;
>  }
> +

Is this right? Looks like existing code is not using correct multiple
 
The standard for communication is K = 1000 and the standard for storage is K = 1024.
That is why iproute2 has the use_iec flag.

https://en.wikipedia.org/wiki/Data-rate_units

