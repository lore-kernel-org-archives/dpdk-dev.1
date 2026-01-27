Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B7D2FEDF
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 20:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 077A0427AD;
	Tue, 27 Jan 2026 21:31:31 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id BFDDF40F1A
 for <dev@dpdk.org>; Tue, 27 Jan 2026 21:31:29 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so63913995e9.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769545889;
 x=1770150689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHN4iyG7isJLXdcHzeTo2jFMVAfUpyLinczQlNG2Rmk=;
 b=n8DtO+0qgYChXH/MI3kUTzS0OJyOCRGGKcefXqq9BQ/lHrioIuUg169jo8xeBaz9gC
 TGDR+viHFuhPOYsVmO9nLINu4zC4kuCuAUrBCWhPtU8U5GXGBuMN1jvQNJiF354kbGVH
 ttzJTnuAavFfF55j87YkLOinilURr/LWZBI2sMfA/krtrkS4DO/3E534xngQll53O3bC
 BM5ExIOJnembKOWyh87zmFQ5elgcOvimgCd9mn69mQ/LPIg1LH8MWoVO2H/DJ1hQN2WH
 XvV4rIOn5hpKEoysgVL9SDsoqdfAqQeFu68m3/uVLSHzWlkMNgmZ3SndovwG9P82TxdN
 BpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769545889; x=1770150689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hHN4iyG7isJLXdcHzeTo2jFMVAfUpyLinczQlNG2Rmk=;
 b=b2ntxI7xv1tp8b7E5BkF6vGDi2jt/jxfMb8GHqoC0I+lNDrXQQg7Gy9ZZU1mtvDUxs
 4N8InqsvfpiETSjV4wZA2LytjsZDI74VwAobcH5d0Ct+u1A1Yh9VMo9ZNsHpDDljYvLw
 lckQdxJdvqHRxlQQoXk5qX6GRF2uq7U1Hmfe7w8R5cy3MdzkExtSKH4EjSeMDODejqYG
 GMXSroHZlyBf0thilgEHfjCs48YqYtNPVPfnAoLnOGNfqlgIQGGOe2MyJ1qRRmBUoOyv
 PmlAyKLB4RhuQkBc827oZ1FmGjqxXQk9lEF2mVai/AJHNwIlgyyVpZODA1H3LeyMfc2e
 DikA==
X-Gm-Message-State: AOJu0YwwGRqxsIrjggSpv7Crmt6zxzw1e/zMdwoaVjXEA1KQ4xRp7L5D
 f4Nvlmt0h1mkgzwTPPSLC1EVyoX9ZrlUXaT9qPZtPBBY38qbw+FaliZgfIaG9KCNtAo=
X-Gm-Gg: AZuq6aKm4Htl5NHhflOo46MPQxwIk01UNZ9OQYJGPqt1WkX5S+nlDU/3JSLGxLJJfOq
 DbyNc9eVg4QuGaeZ6hlIExnn/1Ay/qBR3IDk7NaCvT2sPwly6xVJPhzGL3UgIfWyNZG6sMNAotL
 UvcuxnTcZnSAN6QoLirHDm8Qgp/KO2/YegZCsyTVZJik2U97YZokCKLGWQMXBmgTH8pdOviPbGQ
 c4/dyxBxhy6RlOiD1858dzLffVEWhoiMbuevAf4TOxlxEnGVmNNg0vBErezg7f8WvuaOLs+XzN5
 HzRiNSsVAAQZiA5bx3dc9aPs73EHVmFjmN0PB0fj9wowF/yHH766emDp3cuiA+Ve+TbByKDwpUV
 +wKjdf8Wl1mA2r1geDAsnqGxhsbZ3lYg/x+HHQeQUvHK9MMpcFo7W1JRSqlTDcJzD3uHZtfJlca
 VSu5lsncl8KAJFgGk6JURo/0SozIsB32h5OetSY+w/zXSCDIA/WEJ5
X-Received: by 2002:a05:600c:35d1:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-48069c5fe57mr45859725e9.25.1769545888955; 
 Tue, 27 Jan 2026 12:31:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm86369295e9.12.2026.01.27.12.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 12:31:28 -0800 (PST)
Date: Tue, 27 Jan 2026 12:31:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Phil Yang
 <phil.yang@arm.com>, Gavin Hu <gahu@nvidia.com>
Subject: Re: [PATCH v3 03/14] test/mcslock: scale test based on number of cores
Message-ID: <20260127123120.1d636ac9@phoenix.local>
In-Reply-To: <a2a269c7f13043d0b948fa67769d88d2@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-4-stephen@networkplumber.org>
 <a2a269c7f13043d0b948fa67769d88d2@huawei.com>
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

On Thu, 22 Jan 2026 10:41:04 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > This test uses loops to synchronize but has problems on systems
> > with high number of cores. Scale iterations to the number of
> > cores.
> > 
> > Fixes: 32dcb9fd2a22 ("test/mcslock: add MCS queued lock unit test")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/test_mcslock.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
> > index 245df99a5d..b182da72f1 100644
> > --- a/app/test/test_mcslock.c
> > +++ b/app/test/test_mcslock.c
> > @@ -42,6 +42,10 @@ RTE_ATOMIC(rte_mcslock_t *) p_ml_perf;
> > 
> >  static unsigned int count;
> > 
> > +#define MAX_LOOP_BASE  1000000u
> > +#define MAX_LOOP_MIN   10000u
> > +static unsigned int max_loop;
> > +
> >  static RTE_ATOMIC(uint32_t) synchro;
> > 
> >  static int
> > @@ -60,8 +64,6 @@ test_mcslock_per_core(__rte_unused void *arg)
> > 
> >  static uint64_t time_count[RTE_MAX_LCORE] = {0};
> > 
> > -#define MAX_LOOP 1000000
> > -
> >  static int
> >  load_loop_fn(void *func_param)
> >  {
> > @@ -78,7 +80,7 @@ load_loop_fn(void *func_param)
> >  	rte_wait_until_equal_32((uint32_t *)(uintptr_t)&synchro, 1,
> > rte_memory_order_relaxed);
> > 
> >  	begin = rte_get_timer_cycles();
> > -	while (lcount < MAX_LOOP) {
> > +	while (lcount < max_loop) {
> >  		if (use_lock)
> >  			rte_mcslock_lock(&p_ml_perf, &ml_perf_me);
> > 
> > @@ -175,6 +177,8 @@ test_mcslock(void)
> >  	rte_mcslock_t ml_me;
> >  	rte_mcslock_t ml_try_me;
> > 
> > +	max_loop = test_scale_iterations(MAX_LOOP_BASE, MAX_LOOP_MIN);
> > +  
> 
> Here, and in other similar cases, would it make sense to terminate by timeout
> (i.e. number of cycles passed since start of the test)?
>  

Thought about that but there are couple of issues:
 1. The act of reading the TSC value would change CPU behavior and reduce
    the amount of contention. Potentially hiding bugs.
 2. If the test suddenly had much worse performance, the number of iterations
    would be much less but if test was based on timeout it wouldn't see it.

Conclusion: keep original iteration based limits
