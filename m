Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F23C0219E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 06:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4146402A7;
	Wed, 12 Feb 2025 07:46:30 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id BC3E040269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 07:46:28 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-21f2f386cbeso118345735ad.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 22:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739342788;
 x=1739947588; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBiE2MskbvJkGIa0SL+LYFLdQASHde4aebvKQqYarqI=;
 b=SrE7YPwm+RR1KMVyt0CL0IQ2M/O1xFWpX87+82vIemoaIBpjZh9oJqcQyWuksxgwTI
 MJZEF3lFaKQKHPZqgEoofLyEtFEz27hiKuLXHUyoj0+nEtjrLVrXUAhJiJZVDY3Befmw
 E+DF/9wC228XviEMmK2n5vpNlzUfAm1eswv2bL+Uvt23Y3pYNEDCynPWEgaLybxgwbW+
 GjVflIGxkpk3tKV19aF9pCvBJ5dZhP7vQEa1dT4EUY0/h0LP0qw/xzsW8CLpxuqTVGDK
 fGNq58R8fyOee+nuZM5rxJlGWwo4od3JwsTTZmt565iALIgWom1eCuO1BXE5vRDHRCOT
 QsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739342788; x=1739947588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBiE2MskbvJkGIa0SL+LYFLdQASHde4aebvKQqYarqI=;
 b=Idf0HdNi+IAbGfw8Mp7dMs/Mrn0thJNDC9sZtWRUYkfivOYgLO8qt90cNEeIM38kc8
 H5wSlFYhJts8lfKezRPJlKofE4DWJay54R82GnYO33XURpH6jQkRgwvauT0Y6myw5Juz
 EddHnUYGo+4RXgRO+P2vcOBpUvVCP7FRP9vJL9M7rmno936JA2LzDDxYzM2K54bbkXAR
 lRnytBV80VckFtzX2Qp8xe6kSf4VMQEeLMXCFCRGeM16mjxkd5yUFDHvoS8LzE55KNKd
 YIJhRoueDd5rEb6Vapryxia48r6+zuFvMjkE2v8jV3nkyuzCrg1hPLQCKZx9yxTait5q
 bLDg==
X-Gm-Message-State: AOJu0YxcVOTSb8YMGeOabcfk5AY9G30hNShCdozABcZ7NXXLIbb+DW8I
 sDFDwA2Sjgt9JewOQPnnKtzLmUMUlXNCuChL4lKqCt0KX2UFQFaKUpvfpEX6zIs=
X-Gm-Gg: ASbGncujnY4qh4iBQ8n5AI15uramSX0Tbj/Ir003dm5mKAkQIuaOtVsF7SYO6/Djcd8
 Nx6EewInu5+qpqH6qI5Nb45QO/q/aAyc180J5f1lAVERJ3l6Ur6iaI4hfwNs23q0+lNwop8mQKl
 6gFTOIYJ4BZQNViwxKry1PmsOQ5YAsG62z58vrkGMIKY/JVBkU/VocwXQk95uO1jJYkymBXROZe
 nw8QLlcyN+Y1UtCZahfnplU9m7qKunY5oAhMC7ORgB5QvjUbsm7ne3YTjn7ACMu4QlerwgNg6RY
 F7GsIt7COSgdXBZqFvLUa1g+y5MUsLO+VYwuxQILKZC6c9qIEkYFocDEcxCfLcZj6CV2
X-Google-Smtp-Source: AGHT+IHX2quyM3uXMuvsaRx+pmeQmeIUELR7aWZgotOWJm4pVDs/PHKTVPxIvG40KnEwQwGeCS099w==
X-Received: by 2002:a05:6a21:482:b0:1ee:668f:4230 with SMTP id
 adf61e73a8af0-1ee668f42e9mr223577637.33.1739342787779; 
 Tue, 11 Feb 2025 22:46:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7308d7b6251sm4881540b3a.22.2025.02.11.22.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 22:46:27 -0800 (PST)
Date: Tue, 11 Feb 2025 22:46:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, Tyler
 Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v5 02/11] eal: add new secure free function
Message-ID: <20250211224625.4ed4f058@hermes.local>
In-Reply-To: <49539947-48de-415e-b968-776eab0f3797@huawei.com>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
 <20250211173720.1188517-3-stephen@networkplumber.org>
 <49539947-48de-415e-b968-776eab0f3797@huawei.com>
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

On Wed, 12 Feb 2025 10:01:13 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 2025/2/12 1:35, Stephen Hemminger wrote:
> > Although internally rte_free does poison the buffer in most
> > cases, it is useful to have function that explicitly does
> > this to avoid any security issues.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/eal/common/rte_malloc.c  | 30 ++++++++++++++++++++++++------
> >  lib/eal/include/rte_malloc.h | 18 ++++++++++++++++++
> >  lib/eal/version.map          |  3 +++
> >  3 files changed, 45 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
> > index 3eed4d4be6..c9e0f4724f 100644
> > --- a/lib/eal/common/rte_malloc.c
> > +++ b/lib/eal/common/rte_malloc.c
> > @@ -15,6 +15,7 @@
> >  #include <rte_eal_memconfig.h>
> >  #include <rte_common.h>
> >  #include <rte_spinlock.h>
> > +#include <rte_string_fns.h>
> >  
> >  #include <eal_trace_internal.h>
> >  
> > @@ -27,27 +28,44 @@
> >  
> >  
> >  /* Free the memory space back to heap */
> > -static void
> > -mem_free(void *addr, const bool trace_ena)
> > +static inline void
> > +mem_free(void *addr, const bool trace_ena, bool zero)
> >  {
> > +	struct malloc_elem *elem;
> > +
> >  	if (trace_ena)
> >  		rte_eal_trace_mem_free(addr);
> >  
> > -	if (addr == NULL) return;
> > -	if (malloc_heap_free(malloc_elem_from_data(addr)) < 0)
> > +	if (addr == NULL)
> > +		return;
> > +
> > +	elem = malloc_elem_from_data(addr);
> > +	if (zero) {
> > +		size_t data_len = elem->size - MALLOC_ELEM_OVERHEAD;  
> 
> this will make rte_malloc know the layout of malloc-elem.
> Prefer to add extra paramter, e.g. malloc_heap_free(elem, bool zero)

Don't understand, these are functions inside the rte_malloc implementation file.
The layout of malloc_elem is already known here and nothing visible in API or ABI is changing.
>   
> > +
> > +/**
> > + * Frees the memory space pointed to by the provided pointer
> > + * and guarantees it will be zero'd before reuse.
> > + *
> > + * This pointer must have been returned by a previous call to
> > + * rte_malloc(), rte_zmalloc(), rte_calloc() or rte_realloc(). The behaviour of
> > + * rte_free() is undefined if the pointer does not match this requirement.  
> 
> Suggest add notice: The value may be cleared twice, which affects the performance.

That could easily change with a little work, this is only for crypto keys
so performance doesn't matter.

> > + *
> > + * If the pointer is NULL, the function does nothing.
> > + *
> > + * @param ptr
> > + *   The pointer to memory to be freed.
> > + */
> > +__rte_experimental
> > +void
> > +rte_free_sensitive(void *ptr);  
> 
> one line is OK.
> void rte_free_sensitive(void *ptr);

Yes it could be on one line, and more compact is my preferred style.
But other functions in this file and DPDK style guide say it should be on its own line.




