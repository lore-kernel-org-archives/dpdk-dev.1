Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2BDCA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 16:42:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D377C40649;
	Wed, 10 Sep 2025 18:42:23 +0200 (CEST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 2AEB9402CB
 for <dev@dpdk.org>; Wed, 10 Sep 2025 18:42:22 +0200 (CEST)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b0787fa12e2so169812566b.2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757522541;
 x=1758127341; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01dpx01kzA7bBiNrjzKfmxZBEvXShrJizGeqluXA3sM=;
 b=hM6lY2/teWJfQO9sksYZCPYemUHRnWvQLategdypIP2svaebjE+Py5G+w/zhBHy0Z8
 /xNwkNb+D10mdb5scnWtRY8ZAH7zsIul03a8xE/U3sMdmeMdDxGMrDka76RQBxBimPBO
 wb74ann9GiH8jSczF352bWx31esLRdpV9+IoNYpOnYy9uUwEWTNaBmON8RPTU6SXhf5q
 r7dJhllRKBCYzkhykITJCH8Z8evvvpIjUKxhTW37yb8dz9L3tCCGJ9IeSlqoc+yGS0mM
 ZUbfqErKQHAkj3e+2Wre5Yw6vHeRPLcxkW0gwi8dJBpct00C5cnhJmWJTX5jpXUEr8ZV
 9ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757522541; x=1758127341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01dpx01kzA7bBiNrjzKfmxZBEvXShrJizGeqluXA3sM=;
 b=vSKusKBo+vycBCLLy9Gq6ZlOn62Mnx/fQ1QQH0yOTQYeE5aGglGrd0XaI6Uk1hJ9Uh
 Fag0lH7iL7OrSk95z4/vcS76vMe/B9BtwxLklAHvFJYP2DzIqey/iOzbXJ6CcMXWvnQx
 svzKnbEJ+dCrU3guho2gjHFJyTdbDgsyol/WyMsSJyIvBfCxz2+6AUtg+eX6rCT3HbYO
 lWjX7xjDalwc4DoVtkFbXQg4UWZkuuubiW16cVmL/t2oi3ImSBwfKv/pDT+q9m1YoDTU
 VR0S9jjR5hIADbzcL4ooXrxk5s8tHEDKyIgmr+7KuTUN8sYQq8dwkauH4w2WdWTXiC7I
 eRSw==
X-Gm-Message-State: AOJu0Yz5itnOpyVL4vB1tPSBVVZeJbV+/llEFzrVT5/aCV53HdBjaOa/
 WMRQcg/ggSHjkBuCKdaw7UXxaRK9PRGC1qTU9J0RIjqLxDTPHcz0+/ilZjnVYd70upQ=
X-Gm-Gg: ASbGncvRihmeJdRquEcFfIjZN+OgKKk1e4vDFEB+q0bBvJT4uSp1hK/BHtYbKOiaH4I
 f1061C1VqUscNVAPTEHxyvvZWzT2+O295NzL9XaWe5+1A376I58aTO6xUqrbBZz6vAlh1Ze4xT/
 8nC4w2+n+UiNmTDWnfFO62nCravNBREjD9NOAUnmVoluZZ6Prd/C6ToxwCAgtVlKh1ViPgvetpU
 na/by2yC2N+M3NpDcsuwV7z8EASWj59006W4lw9EmBbEJ3KoFyFQveJW2ymrlufX7IliMpX/rla
 TNZ4F9PGzP+QhRCslZfzJMOD3Vdxd2QFZ5+0xhbDj8V3XamRGk5xJYy7jEmUacmUj7LbWcD6Rts
 8fkgg2IUBNLbAPx8rFCN/QXlGaBuJuq4mCQ5/wKhVYeDqCKG8RD62bl3HDnGBg2rpEILc/ARtZ5
 Y=
X-Google-Smtp-Source: AGHT+IHqFBqMKaQKYIgAw8EROA/WNczLw3AguEiAnsJppBguS7TluK3PEW47x6nLLxXT5JENIJY7AA==
X-Received: by 2002:a17:907:6090:b0:b04:1457:99 with SMTP id
 a640c23a62f3a-b04b1451f8amr1570601466b.14.1757522541398; 
 Wed, 10 Sep 2025 09:42:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07833ffc38sm188938666b.92.2025.09.10.09.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:42:21 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:09:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Devendra Singh
 Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Olivier Matz <olivier.matz@6wind.com>, Edwin
 Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: Re: [V3] net/qede: reduce the optimization level for gcc > 11
Message-ID: <20250910090926.204ff85d@hermes.local>
In-Reply-To: <151c401a-87dc-423c-8bae-89d325dc8c90@6wind.com>
References: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
 <20250909054023.3263401-1-thierry.herbelot@6wind.com>
 <20250909091724.2ea0615e@hermes.local>
 <151c401a-87dc-423c-8bae-89d325dc8c90@6wind.com>
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

On Wed, 10 Sep 2025 08:49:38 +0200
Thierry Herbelot <thierry.herbelot@6wind.com> wrote:

> Hello Stephen,
> 
> On 9/9/25 18:17, Stephen Hemminger wrote:
> > On Tue,  9 Sep 2025 07:40:23 +0200
> > Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> >   
> >> The qede PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> >> compiled with -O3 (default level for all DPDK code). A bug is opened
> >> for this issue (see Link). The same issue is also seen with gcc-12
> >> and gcc-14. The issue is not seen with clang-20.
> >>
> >> A first workaround is to just disable all optimizations (-O0), which
> >> restores packet Rx with Qlogic NICs. However, the performance impact
> >> is not acceptable (around 50% drop).
> >>
> >> A better compromise is to use -O1 for the qede PMD:
> >> - there is some perf impact,
> >> - but the PMD is working as expected (packets are correctly received).
> >>
> >> When compiling with both -O2 and -O3 and gcc > 11, there is no packet
> >> reception when using the qede PMD. The root cause could be missing
> >> 'volatile' keywords or missing memory barriers in the qede PMD code.
> >>
> >> Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
> >> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>  
> > 
> > Which rx_burst gets used on that hardware?
> > 
> > Is there any indication of errors (like rx_mbuf_alloc_failed) in the stats.
> > 
> > The driver does not appear to have any write barrier after updating the consumed packets.
> > 
> > Would this help?
> > diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
> > index 25e28fd9f6..1b5109d966 100644
> > --- a/drivers/net/qede/qede_rxtx.c
> > +++ b/drivers/net/qede/qede_rxtx.c
> > @@ -1295,6 +1295,8 @@ static inline void qede_rx_bd_ring_consume(struct qede_rx_queue *rxq)
> >   {
> >          ecore_chain_consume(&rxq->rx_bd_ring);
> >          rxq->sw_rx_cons++;
> > +
> > +       rte_wmb();
> >   }
> >     
> I just checked with this patch, but the error is still present:
> 
> testpmd> show fwd stats all  
> 
>    ---------------------- Forward statistics for port 0 
> ----------------------
>    RX-packets: 0              RX-dropped: 10            RX-total: 10
>    RX-error: 0
>    RX-nombufs: 10
>    TX-packets: 0              TX-dropped: 0             TX-total: 0
>   
> ----------------------------------------------------------------------------
> 
> The error chain is:
> 
> RX-nombufs
>   => (testpmd) stats.rx_nombuf
>    => (qede) p_stats->common.no_buff_discards
>     => (qede/base) HILO_64_REGPAIR(mstats.no_buff_discard)  
>           (internal to the NIC)
> 

Thanks, lets root cause this (rather than paper it over) because
other drivers may have same issue. Since no mbufs are present
looks like rx discriptor never made it to NIC

