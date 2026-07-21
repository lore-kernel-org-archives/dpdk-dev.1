Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E08C4452D
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 20:45:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E3EC40294;
	Tue, 21 Jul 2026 22:45:51 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 33E6140289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 10:32:31 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c197f968b3cso257294966b.2
 for <dev@dpdk.org>; Tue, 21 Jul 2026 01:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784622751; cv=none;
 d=google.com; s=arc-20260327;
 b=qoxDtXQiUKQWUlZ3pHJuzHg9xgV12A6M3cgc2DHwtZEoyu871eJXRdm9l/4jQ5UqSj
 smo0+MTgw8OnFTodaoy8P2Yka6pVK1122Je1doYCqfn4RHQ4iYm9TcXhCZrCO88WyJ1W
 obnKaiJuP3oi8mx+r5scNDjOayZVot0koFDh4qVnhyKGWHBZQer+oIcuvQFJvgUMg/Gs
 mTAYPy79/EuxhjLd7SdYF9dz+MR+S+ZoHpHuQACFGo3w0OX0cSAhEigKrimyDfMdsYT6
 wT6oKOmmXbyfZypSlX93MNe7o18S6QW5VbP95KEangTqL7Uc6JoYIDYhIXO0Gv3aPMKB
 +S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ohgben2FvlNyE7kGMQX50zU9Qa9uyEOaFLNXTSD9K8I=;
 fh=qtx+rTXMu0jT4NwnisPY8YqyFA3IRvAKA50FaVvbcNg=;
 b=W0/zCFRFWgF2Ct99ZQyz1uk3muJsFFjNbD6sRAl7SEcVYKUcDNnMvJwQrvl34GTWW+
 qyng8+A6TRGZxRLI6DagbFKqYYpi1NbPlLI6FNnbGSIjmHWendBIOcAg5Dz/59xwwsan
 xOOoSL5o0O2aVpb0CE5egcRyb96isD+4XUSxe/Gjsyx/5peJ0mOtTtTT0foHYZf5gG6Y
 zM1+B2QD7MMUhtutGPtbaUtpg13lyyCYKwlwCqMqBzQeIm9aeSsCIy06x+qrAbYkuO81
 HVs3BDWnAU9kgoIkEffGQ4P09kMNWDSAmGOTj5V+jtrUlE0E5IBtVCT+v/uev+hY3g+2
 uMwg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784622751; x=1785227551; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ohgben2FvlNyE7kGMQX50zU9Qa9uyEOaFLNXTSD9K8I=;
 b=Vu3eOUWRxIlVPEHPGJc56/93hH8q+2LY6rvYXCcefE3PnSzUZbKxxgBQxalfOlNSnC
 Uk8uWu2Kj7be4PAxmPgoGpGNsiIUrfdFvm1Kcx3H8wFXSD74CAzeoFnJepqebNgzIoxT
 WAsYsaiop5TXfxbULdQkrCaHObdPFIBZjW+kTiUTfTuN+TQaL0Nb/+6wHbgV6A92KHxY
 b301whd73rpVDBqfVA5da6jv77C9B1aUrNqIEHgkG+KErGZZRG64l9R3kmXuzvGgQxMg
 d+vuESljq2yQ7J8bJBJ3MaVUidx04HB+Yk/haq1dq2FV9s4NvJlhGLNU/Jn5xN0Gf74m
 wGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622751; x=1785227551;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ohgben2FvlNyE7kGMQX50zU9Qa9uyEOaFLNXTSD9K8I=;
 b=UJjUNDc/gliLvEKcietUnbBgkJApUcs9F/F42G4/uqfFLFQkm4jpM6nDCzsti73zpg
 r2a6SPxjuOUk+P1uIn7PO7ID0bS0xHvHovvnSwlQlsLs4irE+Iyi2+FiEUIksUMv+7AX
 ZrkCEaokA71MKl4yE8MmofFTAQaBaAKSMJebHz7Q6B4pw1hUtmv2iQHHZwq8tv8USlc9
 ezrpssPuRMmfkuJbap/npIQLT3NKGXwYt3M19GGjcuiE16dzVzxcauCKkBvBI5s9aFFI
 Pj7Ja6HKyO1yDVLl9jyTdKEw9A3QGgoXo1jm+mbvEHJc2QGfMkWKNv0Do6uQJkwbpZJ7
 DNIQ==
X-Gm-Message-State: AOJu0YyMuTctEVYBZlNzSqemAJIVNhyRPIWejEOks2Trd7UzR2dfoOel
 3EmfdtuVcwfz7RGga2JimeuzufjPRCh1QD50gXfsQ87gBnLMtVeYhnFixcdiVqzRcvNXFU0UThj
 mMF5NypRuHUgeKAccLjMaixdT4RwZjkY=
X-Gm-Gg: AfdE7cmliqYkQ/1zHNNSFA91C+NDSY76L9kT02qJPNJediJaaW6alHX/Fn1UAbdmWZe
 kzEPLSWk2ubLnntobFlP5Fsv9J51aZvqQ41zbhzMcLi4Hg4znvTl2G6YXpxMaZmrxq35zZspPGp
 0C2NAhkRvyP327BJsd2OMxoi+yUgWz8kTEFqJ6pjHbS3kd2glZBo/ClZHPNYlNVg1fhK1o0BqKT
 kfPL3tIbV289zvNWebBLw+up2NrmFOVGNF91jQvkCJHEhHLz93D9Dp2A74FkOeTZtMJADlXxeFQ
 cTjfFHalABhaIAbQ55beVFQNiUIzNXgaJraxUfFsxW07+yL837rROJKLVVISbw==
X-Received: by 2002:a17:907:1ca2:b0:c15:d0ef:a0c3 with SMTP id
 a640c23a62f3a-c16b4732daemr766466266b.32.1784622750608; Tue, 21 Jul 2026
 01:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260721081310.2542794-1-maxime.peim@gmail.com>
 <CAJFAV8yRBL1CTztvWsiYKZGZ_wW7xP6Q2uSd6q53BeKtUJb2TQ@mail.gmail.com>
In-Reply-To: <CAJFAV8yRBL1CTztvWsiYKZGZ_wW7xP6Q2uSd6q53BeKtUJb2TQ@mail.gmail.com>
From: Maxime Peim <maxime.peim@gmail.com>
Date: Tue, 21 Jul 2026 10:32:18 +0200
X-Gm-Features: AUfX_mxKWB_efWOsnw5JFRqzRVHlkarRyH4keN2RsEFUgOuteIPkDwkYa1ErUEw
Message-ID: <CACyZvzh016qKnksXZca+kxau6b5zv_42Pn_86-H3uArmS-AyxQ@mail.gmail.com>
Subject: Re: [PATCH v3] eal: fix core_index for non-EAL registered threads
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001bb2ba06571add03"
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:45:49 +0200
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

--0000000000001bb2ba06571add03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Oh sorry, I was contacted by Luca for backporting this patch to 24.11, but
I realized that there was a missing patch in the chain for the backport to
be valid.
I think I'll just drop the backporting then.

(thanks I didn't notice!)

On Tue, Jul 21, 2026 at 10:28=E2=80=AFAM David Marchand <david.marchand@red=
hat.com>
wrote:

> Hello Maxime,
>
> On Tue, 21 Jul 2026 at 10:18, Maxime Peim <maxime.peim@gmail.com> wrote:
> >
> > Threads registered via rte_thread_register() are assigned a valid
> > lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
> > lcore_config is left at -1. This value was set during rte_eal_cpu_init(=
)
> > for lcores with ROLE_OFF (undetected CPUs) and is never updated when th=
e
> > lcore is later allocated to a non-EAL thread.
> >
> > As a result, rte_lcore_index() returns -1 for registered non-EAL
> > threads. Libraries that use rte_lcore_index() to select per-lcore
> > caches fall back to a shared global path when it returns -1, causing
> > severe contention under concurrent access from multiple registered
> > threads.
> >
> > A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which
> > uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-cor=
e
> > cache slot. When core_index is -1, all registered threads are funneled
> > into a single shared slot protected by a spinlock. In testing with VPP
> > (which registers worker threads via rte_thread_register()), this caused
> > async flow rule insertion throughput to drop from ~6.4M rules/sec to
> > ~1.2M rules/sec with 4 workers -- a 5x regression attributable entirely
> > to spinlock contention in the ipool allocator.
> >
> > Fix by setting core_index to the next sequential index (cfg->lcore_coun=
t)
> > in eal_lcore_non_eal_allocate() before incrementing the count. Also res=
et
> > core_index back to -1 on the error rollback path and in
> > eal_lcore_non_eal_release() for correctness.
> >
> > Fixes: 5c307ba2a5 ("eal: register non-EAL threads as lcores")
> > Fixes: 99c05ce5ef ("eal: parse coremask as cpuset")
> > Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> > ---
> > v2:
> >   - Track allocated core_index values with a bitset instead of deriving
> >     the next non-EAL index from lcore_count, avoiding duplicate indices
> >     after non-EAL lcore release.
> >   - Keep the bitset in sync when default EAL lcores are discovered, whe=
n
> >     EAL lcore options remap the active set, and when non-EAL lcore
> >     registration rolls back or releases an lcore.
> > v3:
> >   - Fix commit message to track also 99c05ce5ef
>
> The patch is already merged in main.
> And we can't really go back in time (for now ;-)), sorry.
> If you want to highlight one more Fixes:, you may contact LTS
> maintainers, but nothing more can be done in main.
>
> Note: I see you sent the patch with a Reply-to: field where you
> probably wanted to use In-Reply-To:.
> It was also the case with the v2 patch iirc.
>
>
> --
> David Marchand
>
>

--0000000000001bb2ba06571add03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<br><br><div>Oh sorry, I was contacted by Luca fo=
r backporting this patch to 24.11, but I realized that there was a missing =
patch in the chain for the backport to be valid.</div><div>I think I&#39;ll=
 just drop the backporting then.</div><div><br></div><div>(thanks I didn&#3=
9;t notice!)</div></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 21, 2026 at 10:28=E2=80=
=AFAM David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.com">david=
.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hello Maxime,<br>
<br>
On Tue, 21 Jul 2026 at 10:18, Maxime Peim &lt;<a href=3D"mailto:maxime.peim=
@gmail.com" target=3D"_blank">maxime.peim@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Threads registered via rte_thread_register() are assigned a valid<br>
&gt; lcore_id by eal_lcore_non_eal_allocate(), but their core_index in<br>
&gt; lcore_config is left at -1. This value was set during rte_eal_cpu_init=
()<br>
&gt; for lcores with ROLE_OFF (undetected CPUs) and is never updated when t=
he<br>
&gt; lcore is later allocated to a non-EAL thread.<br>
&gt;<br>
&gt; As a result, rte_lcore_index() returns -1 for registered non-EAL<br>
&gt; threads. Libraries that use rte_lcore_index() to select per-lcore<br>
&gt; caches fall back to a shared global path when it returns -1, causing<b=
r>
&gt; severe contention under concurrent access from multiple registered<br>
&gt; threads.<br>
&gt;<br>
&gt; A concrete example is the mlx5 indexed memory pool (mlx5_ipool), which=
<br>
&gt; uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a per-co=
re<br>
&gt; cache slot. When core_index is -1, all registered threads are funneled=
<br>
&gt; into a single shared slot protected by a spinlock. In testing with VPP=
<br>
&gt; (which registers worker threads via rte_thread_register()), this cause=
d<br>
&gt; async flow rule insertion throughput to drop from ~6.4M rules/sec to<b=
r>
&gt; ~1.2M rules/sec with 4 workers -- a 5x regression attributable entirel=
y<br>
&gt; to spinlock contention in the ipool allocator.<br>
&gt;<br>
&gt; Fix by setting core_index to the next sequential index (cfg-&gt;lcore_=
count)<br>
&gt; in eal_lcore_non_eal_allocate() before incrementing the count. Also re=
set<br>
&gt; core_index back to -1 on the error rollback path and in<br>
&gt; eal_lcore_non_eal_release() for correctness.<br>
&gt;<br>
&gt; Fixes: 5c307ba2a5 (&quot;eal: register non-EAL threads as lcores&quot;=
)<br>
&gt; Fixes: 99c05ce5ef (&quot;eal: parse coremask as cpuset&quot;)<br>
&gt; Signed-off-by: Maxime Peim &lt;<a href=3D"mailto:maxime.peim@gmail.com=
" target=3D"_blank">maxime.peim@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0- Track allocated core_index values with a bitset instead =
of deriving<br>
&gt;=C2=A0 =C2=A0 =C2=A0the next non-EAL index from lcore_count, avoiding d=
uplicate indices<br>
&gt;=C2=A0 =C2=A0 =C2=A0after non-EAL lcore release.<br>
&gt;=C2=A0 =C2=A0- Keep the bitset in sync when default EAL lcores are disc=
overed, when<br>
&gt;=C2=A0 =C2=A0 =C2=A0EAL lcore options remap the active set, and when no=
n-EAL lcore<br>
&gt;=C2=A0 =C2=A0 =C2=A0registration rolls back or releases an lcore.<br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0- Fix commit message to track also 99c05ce5ef<br>
<br>
The patch is already merged in main.<br>
And we can&#39;t really go back in time (for now ;-)), sorry.<br>
If you want to highlight one more Fixes:, you may contact LTS<br>
maintainers, but nothing more can be done in main.<br>
<br>
Note: I see you sent the patch with a Reply-to: field where you<br>
probably wanted to use In-Reply-To:.<br>
It was also the case with the v2 patch iirc.<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--0000000000001bb2ba06571add03--
