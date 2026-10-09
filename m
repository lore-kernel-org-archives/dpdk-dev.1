Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDBCA6015
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 16:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5222040274;
	Fri,  9 Oct 2026 18:06:49 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id D91974026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 18:06:47 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso2346589b3a.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791562007;
 x=1792166807; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ByfYptQoq2EfpV823eW11a/lOy6A87ty8sm2+PUTzk4=;
 b=Sxe3kKrGojvRpGL8ZO3cGVbed+pz27E404XK97rCiCRow4T3wF8pWZd+PG9nZMsvLy
 rHse8uz7Y5iPuu8ZiUgIcC70wGy0qGHQRA4NV6fB5EfkMKS5XSH0nj8hpeSzcd1/p7Lx
 nYXv1/IFi9dJ8zlkV+zeElScOslUAivPTk1tZvUxAEHqqsb9nwjLuRDW3VW7HtfX4q4P
 n86zMk5Na+cUT8ILY7Ppxc594q7W9wOFpo8SJCbd+lXG/v6ZU9Te+zc6Cz1IrHzGKHJf
 xVg2g/dv5nWeRcslh/5dAgL9Y4b/bR6r4u9t0d+clT0ghtTpXn+j2oQfttdIZ4ThCgCF
 Deuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562007; x=1792166807;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ByfYptQoq2EfpV823eW11a/lOy6A87ty8sm2+PUTzk4=;
 b=TNI9MZcBBKrQwyhyUWUkXkhbh7XCaqat0jRKZYxymrw1shL+KDDn/G9DkkrN5M/0lg
 yzPjp0CRBEJhXcU7VQGZO5uul+U9yfBmBXglJH1hBbClLVBjBpdlgZUfi1/Cdgqa3yKs
 xpIsTQBdLCSQFdVQ6e67fRMdCEYsVgTbTYDXtG5sBc1+AhyVmZt1pkNUqMJkY9s8Nic5
 u0nqKB3U7XQxYh/lO6HFn0ipGlO6bIuzjtDp60mYF2Pb2lxd/Ub5Ae4kB3LyVHftlpgZ
 tHxR1kHqpMCA562x/xYMKCMgkWLpCBG2iQb2/xVrQriPk3I/wUS1/2kuf//eS4tA5pxo
 SLVw==
X-Gm-Message-State: AFuF++kWNsOG4b9fAtK2Ms8yyHUoQX0sfRz2G+4PG6O5LM4yGYAE5IcP
 vLpdk2i90cij1ndpHcI8Vq16bBygL6hj+LfTyx6i5XOo4PStr+yw4h91r3yhpqxerMs=
X-Gm-Gg: AYBFou0sW+unNHRLK0UgGkPRfX9/89t5Mrd5YcoVEaPFw7dAI3OnHAzMRXWUZNVrets
 90KwEGdca1lNWDwM5ImyDCHrqECRF2rUxRgdWKaYXXKPI9RGQoEXrRc6JNEDV58JmNnglt74esp
 RxG+8ib5c0GqrAXQ6NJ0WOPmZs0qlRIfp41GAsAglpCDfFANvxu5q2NHRAB/qOwLkjR0xBnfbJg
 RzmDt6ZE5Na5ly2TLpXnONVhutAXrgL3P30vYIigA0b9qExqbp1E2Nv8ojomj7ot+O0Stq+oE99
 HWJTYHybOkx7pjlqA9xi9b3zgIX+iVdKBRQpHvF77ICJpYo/Q9vK8B+tu+H28KMVOXcxDtYAEyl
 G5+jtsbOnbk4om66WK1a9tWjh6QBjtLsoXKxIDtwfQX3jgLQXByEptpuKNvEssKLyH195wK/bn1
 bZKk/Pf9MoXR9itOlhxWF0BkDTyL3jt8KOoxwJJWPoYx/LH8iAzdtCIPok+SUnQEIOettcrZ+yy
 /g0x1sWpsNZ0VAQjDEHNYiSoLhjJ7ztEnYVFSjk
X-Received: by 2002:a05:6a20:2d14:b0:3e0:c57c:200b with SMTP id
 adf61e73a8af0-3e16be5098amr1927570637.40.1791562006692; 
 Fri, 09 Oct 2026 09:06:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da04d46asm1279972a12.30.2026.10.09.09.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:06:46 -0700 (PDT)
Date: Fri, 9 Oct 2026 08:48:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>, Marat
 Khalili <qm2k21@gmail.com>
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
Message-ID: <20261009084744.046a7200@phoenix.local>
In-Reply-To: <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
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

On Fri, 9 Oct 2026 01:05:56 -0500
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

> >   /*
> >    * Marks given callback as used by datapath.
> >    */
> >   static __rte_always_inline void
> >   bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
> >   {
> > -	cbi->use++;
> > -	/* make sure no store/load reordering could happen */
> > -	rte_smp_mb();
> > +	rte_atomic_store_explicit(&cbi->use,
> > +		rte_atomic_load_explicit(&cbi->use, rte_memory_order_relaxed) + 1,
> > +		rte_memory_order_relaxed);
> > +
> > +	/* full barrier: count must be visible before cb is read */
> > +	rte_atomic_thread_fence(rte_memory_order_seq_cst);  
> 
> This is correct but why use a barrier when the above store itself could 
> be SEQ_CST that
> synchronizes with load in bpf_eth_cbi_wait?

There are two different things be covered for safety here.
The counter and the callback pointer. The counter uses atomic
operations and the callback pointer is referenced without atomic.

AI explains it as:

A seq_cst store on the counter is not enough. This is a store/load
pattern across two objects:

  datapath: store use, load cb
  unload:   store cb,  load use

At least one side has to see the other's store. Making the store
of use seq_cst does not order the datapath's later load of cb,
which is a plain load. On arm64 that compiles to stlr followed by
ldr, and the ldr can be satisfied before the stlr is visible.
Only stlr/ldar pairs are kept in order.

It can be done without fences by making cb atomic and using
seq_cst for all four accesses (stlr + ldar on arm64). That touches
every callback and is a bigger change than replacing the barriers,
so I would rather do it as a follow-up if at all.

There is no cost difference on x86. A seq_cst store is xchg and
the fence is lock addl, one locked instruction per burst either
way.
