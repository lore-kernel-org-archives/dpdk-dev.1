Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C960C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 06:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9B1B402A7;
	Tue, 21 Jul 2026 08:35:05 +0200 (CEST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8677F40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 08:35:04 +0200 (CEST)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5c11f9015d8so1749795e0c.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 23:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784615703; cv=none;
 d=google.com; s=arc-20260327;
 b=h6M3eTqoDSHN16pKrhq8ylBOQRy1gs+QyPONc24M9w4gIc3ACAgFBuopSw1t7CnBIv
 c/SXOgL7P7heCVwGxwRBCqvH/Msx+957M5qLiASSAevJO5DPn9MteVfxLrItkO75jnx3
 IoqeD0GphcvJtFRmU68c5ga/Rt9/Rp4UHjwk16362M0+U41QAN27epJ2E9+oIi3/L3Hj
 zAUeMD1jGxhJajU6BetKlvOOvJc7i6v3I45HU/Y0izx3kd+q5oZ5YYyhFk+kZGYzVmVA
 vH7XHgcQthG7DjRMyEvk4dmefa8QhiGyFGEwxGoVJKABIMrvi9bwNMew73qxskacXABV
 Z62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=14UHars5Cdy3L/tkBQHKVoQL9zax29IRct2o9pHwPEE=;
 fh=Z679KIfzAnw+Kzd6GORG5bAC5aUB3LrUe8zF9QWH7cU=;
 b=A62ij2T6sfe8X5uDuE3CYalAraCiT3KgGktrxJtxSKN+e0czz2v/ubSwnLJFsIARiX
 xsjX25idN/tFT8AFLfjq7D4l/T1w4yub2y/vod7DxluKWXXLq1kfSCGfZVdu9fshurF2
 6U/F+W/e0jnW2g3+WYNvGTwIRsc4lgx1SSRjsSVLKzjW+Vwt+PVAz8pvO4m6jom6izp/
 3WtbGe2G39vdYEIVO0kAASwWD7laLDK9PMJ9xP3yX507wLxSgQZMZPGYD5wYkhEoQxVu
 Gje88M4k0TRQdZti0/C060WcwBoOy1K+mJpIsFTbr8Fdt2X7DsXLsHGZuWU1T1/4xWIb
 FuNQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784615703;
 x=1785220503; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=14UHars5Cdy3L/tkBQHKVoQL9zax29IRct2o9pHwPEE=;
 b=a6k+WesJt97EPYFgbjvQY+EvFlT9ILTMFvwtREK0Rmk3lIvN5nM7MPP7Lw6wPl1Hgo
 yuFnUyxWCOulDtlmAMK4aEkuX/G05diDy2c9J+4sNRSHTcSkEG4o3dvq5pbbSaEdI8Ol
 HDBpXpMQ0gkJXm93WYue7eGCBZ2xGlnVusf9SaPHECKT6ui9urQwpIWJRuLP3mqHD0kW
 5JZ4TOJXpT8dWsuYOWyljY0in8ZzeWC2G2RDHZ4UHUIUWYtEWMGR+AzLTC+5Tq2IVA8K
 hfbjJJuM8qW24kk7usU0J2yWJnqnt03QCC8zOpyW3Rz8tqnyzUuxHtYQEw0pYN+XmJGH
 olZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784615703; x=1785220503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=14UHars5Cdy3L/tkBQHKVoQL9zax29IRct2o9pHwPEE=;
 b=dXZzKneIqJoEsw1tn42UxYPi70N33qPWFnenfs4dMHS62vrYgeCFhx2Uq6jICAaGA0
 Gt5yGDWqn4wjvKCGeYt+AiTJzDpDJcNejXxVVTA/wfd3DWiq4Cv90oL2JQkou6aMjDba
 CavEmNINMOBm0SzKepmeoDZIFZt5Vq2dQGDWLNL8nJBQ2uegrM7OA9OjzAl6pLz/6h2I
 B2ONEAIg/40vNHIovEm7KN34zQ/x1b1S0bX3Pti6KuC9JvsODjgPi/BIvRG9k9Rmu4S4
 mG5ECF5mf4IpyhLSiHBAUMeMDr2DttmIcpUz5OSDDxkAnt1xdOCpmHkoUaraSrybjaju
 MlKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVVPXV/yv8mVYKM0z5CAXzGt5MFtcK6wk6lwQ5WfMiEfp1lCHx8si7EvEckdsXINfKi7Y=@dpdk.org
X-Gm-Message-State: AOJu0YwFowwxujtUtkM2VUhcOnhUbWXIJbZASQmH/Gr1E8YJOUQjcxev
 /0dkzMxiqjyMPmfypYzBmBzeqvrLA0h0pNTob3vQ1q6Fw0VEr/lUY63J1jLnMfgWbZcG90J795C
 BHosno/W61+CRCDH3uStC3wCQEN7FCJjIs2Zo3qTdPw==
X-Gm-Gg: AR+sD12bEBDeXwwyuirrZz1rqhfyDO6DdO4md35KpBbaGFkjv+un7zmkTqM10KwRia7
 x+7f9JHQmt8hAYUsnGdR1UGdYCyIgJhCh8hNy99z2d4IfPkQk3471gZn1bRA1esQllJR3mScXyb
 6lLHDtKHmYE3PfJ44u65Vdi03rKl+w2lDjf63jPiR1Pt7n15XS7XK0YLGT1d6homrPIsxQJaOyu
 /REz84u4vSo9gu7/NMkYV1lWG7O36v/FGcNaV2xCKJwaznhNNx4fwUKLqgZFyjpk29k/V/5ASqH
 WmGMI40KyUCmYsJkd5zRmQeNepw=
X-Received: by 2002:a05:6102:6442:b0:740:2d5f:e37b with SMTP id
 ada2fe7eead31-747537a07b2mr4632129137.29.1784615703593; Mon, 20 Jul 2026
 23:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
 <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 21 Jul 2026 08:34:52 +0200
X-Gm-Features: AUfX_mwS_Bov_WM3TjOc-EzZFrBKaU-85W3KJXBva96G_IagbN7DRj0N3zWQdQg
Message-ID: <CAOaVG17Ay+b1Hio90Mgq0jrYwFegxOmQ-+2ezXF_cSrk1Zi90g@mail.gmail.com>
Subject: Re: mempool cache change
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 fengchengwen <fengchengwen@huawei.com>, 
 Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>,
 Wisam Jaddo <wisamm@nvidia.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Type: multipart/alternative; boundary="00000000000012d12a06571939e7"
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

--00000000000012d12a06571939e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can't help thinking that there needs to be a more dynamic heuristic.
Keep existing upper limit but only cache as much as gets used.

There are two main usage models.
One is fast direct recycling which run to completion generates. The other
is when pipeline is used and arrival and departure is on different cores.

On Mon, Jul 20, 2026, 10:13 Bruce Richardson <bruce.richardson@intel.com>
wrote:

> On Sat, Jul 18, 2026 at 04:07:05PM +0200, Morten Br=C3=B8rup wrote:
> > > From: Kishore Padmanabha [mailto:kishore.padmanabha@broadcom.com]
> > > Sent: Friday, 17 July 2026 19.10
> > >
> > > Hi Bruce,
> > >
> > > The below patch works fine for us. We tested all the different packet
> > > sizes.
> > > Thanks for the patch. Do you want to push this patch since it is not
> > > changing the ABI/API?
> >
> > Too late in the release process.
> >
> > Let's postpone the discussion for DPDK 26.11, where API/ABI breakage is
> allowed.
>
> Agreed. Let's not unnecessarily rush this.
>
> >
> > I'm not strongly opposed to Bruce's algorithm, targeting a fill level o=
f
> 25 % from the edges and flushing/refilling up to 75 % of the cache when
> necessary. It does have its advantages for some mempool access patterns
> (which are not exotic).
> > I just prefer the current algorithm, targeting a fill level of 50 % and
> only flushing/refilling up to 50 % of the cache when necessary. It perfor=
ms
> better at random get/put access patterns, and the backend transactions ar=
e
> smaller.
> >
> > For DPDK 26.11, where we can break the API/ABI, we can simply double
> RTE_MEMPOOL_CACHE_MAX_SIZE to 1024, to compensate for reducing the
> effective cache size from 150 % to 100 %.
> > The mempool cache objs array will no longer be
> [RTE_MEMPOOL_CACHE_MAX_SIZE * 2], but only [RTE_MEMPOOL_CACHE_MAX_SIZE], =
so
> doubling RTE_MEMPOOL_CACHE_MAX_SIZE will not increase the memory footprin=
t,
> but allow using a cache size up to 1024.
>
> My concern with this approach is that it won't automatically fix the
> problem if we have users who experience a performance regression due to t=
he
> mempool changes. While testpmd allows the mbcache size to be provided via
> parameter, end applications are likely to have it hardcoded. That means
> that if an app does experience a regression, the author/user has to be
> either aware of the mempool changes, or has to debug it down to the mempo=
ol
> and then know to increase the mempool cache size in the app.
>
> It's not an insurmountable problem, but one that needs to be very clearly
> called out in our documentation, what the change is, how it may affect
> things and how to fix it.
>
> On the other hand, in realworld, i.e. not just testpmd/l3fwd cases doing
> little packet processesing, I would be fairly hopeful that regressions ar=
e
> going to be few and very small.
>
> >
> > Please also note that the current implementation is carefully designed
> to keep the transfers to/from the mempool backend CPU cache aligned
> (assuming cache->size is 2^N and large enough).
> > Refer to the parameters passed to rte_mempool_ops_enqueue/dequeue_bulk(=
).
> > E.g. with mempool cache size 256, backend transfers are 128 objects, 16
> full cache lines.
> > Using CPU cache aligned transfers has a few advantages:
> > - There are no cache line ownership issues across different CPU cores
> repeatedly accessing the backend.
> > - The mempool backend drivers can be performance optimized for
> transferring full CPU cache lines. (Both source and destination addresses=
,
> and number of objects copied, are CPU cache aligned. Assuming all transfe=
rs
> go via the mempool cache.)
> >
> > These details should be fine tuned in the implementation, if we do
> proceed with Bruce's algorithm.
> >
> Yep, good points.
>
> /Bruce
>

--00000000000012d12a06571939e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I can&#39;t help thinking that there needs to be a more d=
ynamic heuristic.<div dir=3D"auto">Keep existing upper limit but only cache=
 as much as gets used.</div><div dir=3D"auto"><br></div><div dir=3D"auto">T=
here are two main usage models.</div><div dir=3D"auto">One is fast direct r=
ecycling which run to completion generates. The other is when pipeline is u=
sed and arrival and departure is on different cores.</div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Mon, Jul 20, 2026, 10:13 Bruce Richardson &lt;<a href=3D"mailto:bru=
ce.richardson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Sat, Jul 18, 2026 at 04:07:05PM +0200, M=
orten Br=C3=B8rup wrote:<br>
&gt; &gt; From: Kishore Padmanabha [mailto:<a href=3D"mailto:kishore.padman=
abha@broadcom.com" target=3D"_blank" rel=3D"noreferrer">kishore.padmanabha@=
broadcom.com</a>]<br>
&gt; &gt; Sent: Friday, 17 July 2026 19.10<br>
&gt; &gt; <br>
&gt; &gt; Hi Bruce,<br>
&gt; &gt; <br>
&gt; &gt; The below patch works fine for us. We tested all the different pa=
cket<br>
&gt; &gt; sizes.<br>
&gt; &gt; Thanks for the patch. Do you want to push this patch since it is =
not<br>
&gt; &gt; changing the ABI/API?<br>
&gt; <br>
&gt; Too late in the release process.<br>
&gt; <br>
&gt; Let&#39;s postpone the discussion for DPDK 26.11, where API/ABI breaka=
ge is allowed.<br>
<br>
Agreed. Let&#39;s not unnecessarily rush this.<br>
<br>
&gt; <br>
&gt; I&#39;m not strongly opposed to Bruce&#39;s algorithm, targeting a fil=
l level of 25 % from the edges and flushing/refilling up to 75 % of the cac=
he when necessary. It does have its advantages for some mempool access patt=
erns (which are not exotic).<br>
&gt; I just prefer the current algorithm, targeting a fill level of 50 % an=
d only flushing/refilling up to 50 % of the cache when necessary. It perfor=
ms better at random get/put access patterns, and the backend transactions a=
re smaller.<br>
&gt; <br>
&gt; For DPDK 26.11, where we can break the API/ABI, we can simply double R=
TE_MEMPOOL_CACHE_MAX_SIZE to 1024, to compensate for reducing the effective=
 cache size from 150 % to 100 %.<br>
&gt; The mempool cache objs array will no longer be [RTE_MEMPOOL_CACHE_MAX_=
SIZE * 2], but only [RTE_MEMPOOL_CACHE_MAX_SIZE], so doubling RTE_MEMPOOL_C=
ACHE_MAX_SIZE will not increase the memory footprint, but allow using a cac=
he size up to 1024.<br>
<br>
My concern with this approach is that it won&#39;t automatically fix the<br=
>
problem if we have users who experience a performance regression due to the=
<br>
mempool changes. While testpmd allows the mbcache size to be provided via<b=
r>
parameter, end applications are likely to have it hardcoded. That means<br>
that if an app does experience a regression, the author/user has to be<br>
either aware of the mempool changes, or has to debug it down to the mempool=
<br>
and then know to increase the mempool cache size in the app.<br>
<br>
It&#39;s not an insurmountable problem, but one that needs to be very clear=
ly<br>
called out in our documentation, what the change is, how it may affect<br>
things and how to fix it.<br>
<br>
On the other hand, in realworld, i.e. not just testpmd/l3fwd cases doing<br=
>
little packet processesing, I would be fairly hopeful that regressions are<=
br>
going to be few and very small.<br>
<br>
&gt; <br>
&gt; Please also note that the current implementation is carefully designed=
 to keep the transfers to/from the mempool backend CPU cache aligned (assum=
ing cache-&gt;size is 2^N and large enough).<br>
&gt; Refer to the parameters passed to rte_mempool_ops_enqueue/dequeue_bulk=
().<br>
&gt; E.g. with mempool cache size 256, backend transfers are 128 objects, 1=
6 full cache lines.<br>
&gt; Using CPU cache aligned transfers has a few advantages:<br>
&gt; - There are no cache line ownership issues across different CPU cores =
repeatedly accessing the backend.<br>
&gt; - The mempool backend drivers can be performance optimized for transfe=
rring full CPU cache lines. (Both source and destination addresses, and num=
ber of objects copied, are CPU cache aligned. Assuming all transfers go via=
 the mempool cache.)<br>
&gt; <br>
&gt; These details should be fine tuned in the implementation, if we do pro=
ceed with Bruce&#39;s algorithm.<br>
&gt; <br>
Yep, good points.<br>
<br>
/Bruce<br>
</blockquote></div>

--00000000000012d12a06571939e7--
