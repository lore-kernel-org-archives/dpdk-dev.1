Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2150DCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 16:26:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 523334064F;
	Mon, 18 May 2026 18:26:50 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 0D95E402DE
 for <dev@dpdk.org>; Mon, 18 May 2026 18:26:48 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2f7020a928eso3491461eec.1
 for <dev@dpdk.org>; Mon, 18 May 2026 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779121608;
 x=1779726408; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUejX98SVsa85D8bv8s0O3BC1ZcobvuSg557+Y99Zt0=;
 b=PrLYNQJDmFHZkR5y9yPkxdQfN04AufyZEy0Rg7MlLfSftcyIi2taTrYDZtbTV6RsnS
 nSk8vKeVrXC4wbs5I1mgEsllLMZi2NmgHjL/JACXKYY7gKaka47SLE/UgkhKjmSYPtnw
 2Brk27xz3je7ufXkXlaJYkXdEQ7jrzr/KvvIQMYiToWeJ6JQ1Vf71K/X3Kht28PAgaTF
 4TS1YqLuOEPHlT1b/3pHOnmFlLPZmDjOa7SY23jjkSffsldRaTJWL5fPgvbyoSxiEXzG
 weER6BYb6IqfOG85Vfm3dTxuUiDe1hn+E4AkycJ1X/hYuf5U8hQwoJGtCe2HoMgfuxds
 m07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779121608; x=1779726408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUejX98SVsa85D8bv8s0O3BC1ZcobvuSg557+Y99Zt0=;
 b=kOZ/Tf1Pt01cSS+Hwmi5hR136a74hvA3x5j4Wd/9mjNpRqNhgGiLLMG/OggToiD0xU
 YfclIQUr6H9MAPUHIKsY23FdzGZX0STrggjBuny1BIjwXbIY+tjzQO/9MVuAa9s0WIzO
 8TA6WCvJVUmnFoxojdJwmstdkOJLHdc30TBKL6FsNJRn4d2KAVrI9flb/uwPwMCRxLae
 rSb27bsEE0QlTbdIspJi1v7NbEpps+gwNWyzkIk4tEDmmsRWvC7bnCEa3nW+hqQEjHP5
 Wn61o4O1Fs04kUMhUwRzsOmqz+zgD/TT4s3cBdMn1hXAja+CExDXb/MAqHMTEYA6mdVt
 H2iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86olJpo9ESNS69d2ccyUHiNvsRG0Eo6Z/UG7KBWMuaYxbCESdr0Jok7MQRx0pDXIibz7c=@dpdk.org
X-Gm-Message-State: AOJu0YxxBNTlINptJDeHFNRQtWeY0T1mefyFX+FC/s8zTmZ89bknAlzd
 ywGHSLZLA2mzcMrRQiLYcQWs9RShZhBAABrMtRNiwXpS/ZqrBH9z09M6npY2qZV1Zd4=
X-Gm-Gg: Acq92OEo3tckU0aT2XORjte97FDFwfDDm9BWWFzGl4Dl/qWercGtvDbWK9YU3l3b1Oa
 kX+SINZGyLMd8/Vjm/NtxgRGojpSieUzHVzLb07hNBm3hYjg1q78+qowZT+fByGcBe1kcZ49ULL
 Ij8WA651yaDGizYHkZUSffSbQkIHqTGP0eXng4lnOMxyRD+/ZR/F8dCBB2qnQLIpsKWPLKlevHU
 K0iH9DGK2dSC/g+aUxjOXhcC90tv56U3RX1ard0x2CcQfZLVECZltTtKpxlq6GhoOcbgUOmDvRF
 jPsWDhLszQVoVbd9wUZR9Up4+zGgqQWEZ05wAedg+hKJ29IcYlYRADM74b8uw3Y9BZfMz92Eazv
 WanBsOUla0BBQHnQ/iJN43V4Xhp9drnUU2MGr3FIPXZbAlGTBrfwJfs6wBkbwjO0F+eCVf39Pp/
 C6yIECArxf4eW/yes/TrBoLD6fkA00fB9jrf8=
X-Received: by 2002:a05:7300:d021:b0:2d9:6f2f:9f6f with SMTP id
 5a478bee46e88-30398697cddmr6024678eec.24.1779121607760; 
 Mon, 18 May 2026 09:26:47 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm13998399eec.22.2026.05.18.09.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:26:47 -0700 (PDT)
Date: Mon, 18 May 2026 09:26:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Robin Jarry" <rjarry@redhat.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>, "Konstantin
 Ananyev" <konstantin.ananyev@huawei.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Message-ID: <20260518092644.0c207992@phoenix.local>
In-Reply-To: <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260518150819.3332628-1-thomas@monjalon.net>
 <DILWG1XCA7NV.33OR3FAYCVVI0@redhat.com>
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

On Mon, 18 May 2026 17:14:54 +0200
"Robin Jarry" <rjarry@redhat.com> wrote:

> Hey Thomas,
> 
> Thomas Monjalon, May 18, 2026 at 17:07:
> > When compiling with C++20 standard requirement (default in GCC 16),
> > the increment and decrement of volatile variables are rejected:
> >
> > rte_spinlock.h:241:14: error:
> > 	'++' expression of 'volatile'-qualified type is deprecated
> > rte_spinlock.h:252:21: error:
> > 	'--' expression of 'volatile'-qualified type is deprecated
> > rte_spinlock.h:278:14: error:
> > 	'++' expression of 'volatile'-qualified type is deprecated
> >
> > The count field of rte_spinlock_recursive_t
> > does not need the volatile qualifier
> > because it is only accessed by the thread holding the lock,
> > which already provides the necessary memory ordering.
> >
> > The user field can be accessed outside of the lock,
> > so it must handled as a C11 atomic variable.
> >
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> > v1: drop volatile keyword
> > v2: make user an atomic variable
> > ---
> >  lib/eal/include/generic/rte_spinlock.h | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
> > index c907d4e45c..5d810b682a 100644
> > --- a/lib/eal/include/generic/rte_spinlock.h
> > +++ b/lib/eal/include/generic/rte_spinlock.h
> > @@ -197,8 +197,8 @@ rte_spinlock_trylock_tm(rte_spinlock_t *sl)
> >   */
> >  typedef struct {
> >  	rte_spinlock_t sl; /**< the actual spinlock */
> > -	volatile int user; /**< core id using lock, -1 for unused */
> > -	volatile int count; /**< count of time this lock has been called */
> > +	RTE_ATOMIC(int) user; /**< core id using lock, -1 for unused */
> > +	int count; /**< count of time this lock has been called */
> >  } rte_spinlock_recursive_t;
> >  
> >  /**
> > @@ -215,7 +215,7 @@ typedef struct {
> >  static inline void rte_spinlock_recursive_init(rte_spinlock_recursive_t *slr)
> >  {
> >  	rte_spinlock_init(&slr->sl);
> > -	slr->user = -1;
> > +	rte_atomic_store_explicit(&slr->user, -1, rte_memory_order_relaxed);
> >  	slr->count = 0;
> >  }
> >  
> > @@ -230,9 +230,9 @@ static inline void rte_spinlock_recursive_lock(rte_spinlock_recursive_t *slr)
> >  {
> >  	int id = rte_gettid();
> >  
> > -	if (slr->user != id) {
> > +	if (rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) != id) {  
> 
> This needs to be rte_memory_order_acquire

No it does not. There is no dependency here.
The acquire is inside the spinlock.

> 
> >  		rte_spinlock_lock(&slr->sl);
> > -		slr->user = id;
> > +		rte_atomic_store_explicit(&slr->user, id, rte_memory_order_relaxed);  
> 
> And rte_memory_order_release

Ditto.

> 
> >  	}
> >  	slr->count++;
> >  }
> > @@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
> >  	__rte_no_thread_safety_analysis
> >  {
> >  	if (--(slr->count) == 0) {  
> 
> This code is completely broken. Any thread can unlock without any check.

I would make an RTE_ASSERT() that id matched current thread id.
Since caller holds lock, no atomic required for that.
