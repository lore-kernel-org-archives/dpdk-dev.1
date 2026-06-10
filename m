Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C7CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 665DD42ECF;
	Thu, 11 Jun 2026 09:25:17 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 701434026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 15:46:03 +0200 (CEST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so1030401266b.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 06:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781099163; cv=none;
 d=google.com; s=arc-20240605;
 b=S5txtg5T9QKN0PBsdnpOSU2bL7gwNVwDPxhg98HkqJiIUZ4hvWPEYNBTjNJDWrdyoW
 wNd9FXleoHM7KbpPaeQnfpxqwc/nwTJCD+LZBqAIrg7VvsqC9hVU/hPpA4ErurqCAjDW
 kjx/aZ8brjPQEy+TykhTvY3Wc+T5BuSPaD3RxD6iHbjU6IL7x4vqOkU+EvE5E1sXo6wh
 RGXZ+U1zLb9RGW61kHhEH0k40jsvUTeunrJI8qHcEVKastIitBS390nqNduQm5u9ZBES
 fu/ECGVmaAVmD8mI5yhEJK3K8IVGDKxDMMiJwxQUsY3+osOzo7DfvCEJ5dZDNxdAmLPq
 myzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7+KKcp6acVn1+HN+58eY+7odp2XJzUipPitV6k4LheA=;
 fh=qtx+rTXMu0jT4NwnisPY8YqyFA3IRvAKA50FaVvbcNg=;
 b=TX2P6AlAcu0YPUo3jGbXzSOdhxiYuaL/Ox09HS+mxQyGdefMSKKFchBCsBoZZTh40b
 QEusgN3gs641161mVYlk+y2g+D6ESjI7iTdwann3bt8NA4yPDSgkSDcR2GZFvstr9dWf
 kg+lmy6BjoSaBQoFstCybiDjVUWJswh7U/yi+N3uzcQEFaqYLPqKSI0IQqZt+jCVLxht
 E06YsgJK7R8IuxoOyIhsKZrLhZGw2ZTfrxWsuQOts/xAyWxHJKJTXdu2O4Va9RtoRhFG
 5OEyaI80wZ0YZV6/6qNdLc+YOFJloQuXv1vFSVbVt/UC1Hcz44Q2RoObWM5oRazz2dpQ
 6kWQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781099163; x=1781703963; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7+KKcp6acVn1+HN+58eY+7odp2XJzUipPitV6k4LheA=;
 b=hi8ACdqA16g9SC92faQS2MbiVeD10trw16/aGnBl3xWckJ0t4jZnsi+yl+MRbyW1vi
 Qas1NMK1R3WBVIZ4Vyqrcz7dbPXaBjQalpJman3pHpKFG26TwGotYO1oj2W/61/TbizH
 IA8356BSthyqfsiUWE9QJeSbthenpEDZxtKSdSMSiK3tlwzBAfiqtNWWIoLDMk0Rbga/
 3v4t6Ap2uwsBVkKMmZMKdf90EKO8gj1MBnLc+YhTVDpkHgkiEMLH3kKGNZAFMXIyAWhL
 hmowri+uENVMGVLL1AY2zNr/tG92SoVloLdV5eHludA2NaaTlUIcD/QF/xDaQBSsp2z0
 9TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781099163; x=1781703963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+KKcp6acVn1+HN+58eY+7odp2XJzUipPitV6k4LheA=;
 b=ph5f7U8ytKTTL301hwMEDwu5OAhfoaxW2pNKTxgFTu3h672RN6q+wY8+lUNbSs02fs
 VqNQ49aBryX+Mc10/sIvaj/9BAoKP0ZADn07BlPoI26ke+1+E/UfCRE/hVlWZdaHUQqY
 /EX0NQP0jajr0zN7j6c1FmTb76dSSDMP5YR2bKmxddXBRmheDzBszaI36RbrHB9Oe2R5
 pP92rNn+jemOfchnlwyxrkztZG6I84+C77kG9JNhzXQEiDPBbJJZNWqicNhJNVTxQ8uc
 EWHot1Low52lDwDfiyqqTPxk3mQ4d1U48C/xR5LGDL7DrZh/DWxbBK4oJbB1O3kVjo3b
 Btlw==
X-Gm-Message-State: AOJu0Yxj/Ub6jLrs5KoVFqwfchAlDpw540Z+aqNYWWCuJYb6suBsOQOt
 q/dS3CjrHNoZrJ8BMaagWsYD4M1sPiokxcvaEwI2AOZLroSdcNFW811bNfTgIrwrzvPWktC69EG
 ntb8MjEuiJAFWvIYYPIxtc0wqX4PEU7Y=
X-Gm-Gg: Acq92OE36gomERHPbj1KGKPVtUdbY6d1orcjfej14L4/+8NhS+Al0qdGni3qxS8bU/S
 ISPA6B0TkltkhF37yC68RxmH0drCywvoHmK2QG0t3nGIXNxTOS9+NyK5cr+ihA14apm3UB8Xj1/
 ZMvMQnaj+HQjxSIITKiR9CNuQlEvGevidyrDQ48fkasrcVRnVtrq7Glq5tR/iIXwt2E50sTsThh
 sr6NnLssrLso4G7ottD26iJuaQsuRVRIy6ceG0OaPnYiAdNoH2afsnOLNZ7yd3imAXF/kTyv2qK
 ntuEJkoyFtUlxGI/l9z7PuM9jhPmiIZBR54oeIHvXknRcTyIoeo=
X-Received: by 2002:a17:907:971b:b0:bee:b5f2:6385 with SMTP id
 a640c23a62f3a-bf37076fe79mr1226222466b.11.1781099162597; Wed, 10 Jun 2026
 06:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260422075414.2528455-1-maxime.peim@gmail.com>
 <CAJFAV8wn26hRUTzCG4ai+apT8+bWL7+cEE1N-gV1tJt8B9a4hQ@mail.gmail.com>
 <CAJFAV8zsDEW6vU69NHmZiqUyB4xz+qDPQsw-cBBeScGeuE_Fiw@mail.gmail.com>
In-Reply-To: <CAJFAV8zsDEW6vU69NHmZiqUyB4xz+qDPQsw-cBBeScGeuE_Fiw@mail.gmail.com>
From: Maxime Peim <maxime.peim@gmail.com>
Date: Wed, 10 Jun 2026 15:45:50 +0200
X-Gm-Features: AVVi8Cde0SE9zLysKLz-QdSAoLSOHSJEU9X3QwOhn70nbXRpYOfUB1teQcd26ys
Message-ID: <CACyZvzgxXHmfeXtCwV37VR7moci6d1p_chy5XVuLYZ1LufsdwA@mail.gmail.com>
Subject: Re: [PATCH] eal: fix core_index for non-EAL registered threads
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e57e9d0653e67641"
X-Mailman-Approved-At: Thu, 11 Jun 2026 09:25:15 +0200
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

--000000000000e57e9d0653e67641
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David

I am not sure it works either, if the lcore are manual set with a gap:
`--lcores=3D0,7` (from `eal_parse_lcores`):
- lcore 0 will get core_index =3D 0
- lcore 7 will get core_index =3D 1

When calling `rte_thread_register` we will hit lcore=3D1 as first
not-assigned lcore and set core_index=3D1 as well.

It seems like a solution should be to have a bitmap of the currently used
core_index stored in the global config.

Please let me know what you think about that.

Maxime Peim

On Mon, Jun 8, 2026 at 6:35=E2=80=AFPM David Marchand <david.marchand@redha=
t.com>
wrote:

> On Mon, 8 Jun 2026 at 18:10, David Marchand <david.marchand@redhat.com>
> wrote:
> >
> > On Wed, 22 Apr 2026 at 09:54, Maxime Peim <maxime.peim@gmail.com> wrote=
:
> > >
> > > Threads registered via rte_thread_register() are assigned a valid
> > > lcore_id by eal_lcore_non_eal_allocate(), but their core_index in
> > > lcore_config is left at -1. This value was set during
> rte_eal_cpu_init()
> > > for lcores with ROLE_OFF (undetected CPUs) and is never updated when
> the
> > > lcore is later allocated to a non-EAL thread.
> > >
> > > As a result, rte_lcore_index() returns -1 for registered non-EAL
> > > threads. Libraries that use rte_lcore_index() to select per-lcore
> > > caches fall back to a shared global path when it returns -1, causing
> > > severe contention under concurrent access from multiple registered
> > > threads.
> > >
> > > A concrete example is the mlx5 indexed memory pool (mlx5_ipool), whic=
h
> > > uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a
> per-core
> > > cache slot. When core_index is -1, all registered threads are funnele=
d
> > > into a single shared slot protected by a spinlock. In testing with VP=
P
> > > (which registers worker threads via rte_thread_register()), this caus=
ed
> > > async flow rule insertion throughput to drop from ~6.4M rules/sec to
> > > ~1.2M rules/sec with 4 workers -- a 5x regression attributable entire=
ly
> > > to spinlock contention in the ipool allocator.
> > >
> > > Fix by setting core_index to the next sequential index
> (cfg->lcore_count)
> > > in eal_lcore_non_eal_allocate() before incrementing the count. Also
> reset
> > > core_index back to -1 on the error rollback path and in
> > > eal_lcore_non_eal_release() for correctness.
> > >
> > > Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
> > Cc: stable@dpdk.org
> >
> > > Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> > Acked-by: David Marchand <david.marchand@redhat.com>
> >
>
> Hum, I did not push the change.
> Re-reading this code, we have an issue if some external thread
> unregisters in the middle.
>
> What do you think of the additional hunk:
>
> $ git diff
> diff --git a/lib/eal/common/eal_common_lcore.c
> b/lib/eal/common/eal_common_lcore.c
> index ae085d73e4..6f53f20d90 100644
> --- a/lib/eal/common/eal_common_lcore.c
> +++ b/lib/eal/common/eal_common_lcore.c
> @@ -372,13 +372,16 @@ eal_lcore_non_eal_allocate(void)
>         struct rte_config *cfg =3D rte_eal_get_configuration();
>         struct lcore_callback *callback;
>         struct lcore_callback *prev;
> +       unsigned int index =3D 0;
>         unsigned int lcore_id;
>
>         rte_rwlock_write_lock(&lcore_lock);
>         for (lcore_id =3D 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
> -               if (cfg->lcore_role[lcore_id] !=3D ROLE_OFF)
> +               if (cfg->lcore_role[lcore_id] !=3D ROLE_OFF) {
> +                       index++;
>                         continue;
> -               lcore_config[lcore_id].core_index =3D cfg->lcore_count;
> +               }
> +               lcore_config[lcore_id].core_index =3D index;
>                 cfg->lcore_role[lcore_id] =3D ROLE_NON_EAL;
>                 cfg->lcore_count++;
>                 break;
>
>
> --
> David Marchand
>
>

--000000000000e57e9d0653e67641
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David<div><br></div><div>I am not sure it works either,=
 if the lcore are manual set with a gap: `--lcores=3D0,7` (from `eal_parse_=
lcores`):</div><div>- lcore 0 will get core_index =3D 0</div><div>- lcore 7=
 will get core_index =3D 1</div><div><br></div><div>When calling `rte_threa=
d_register` we will hit lcore=3D1 as first not-assigned lcore and set core_=
index=3D1 as well.</div><div><br></div><div>It seems like a solution should=
 be to have a bitmap of the currently used core_index stored in the global =
config.</div><div><br></div><div>Please let me know what you think about th=
at.</div><div><br></div><div>Maxime Peim</div></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Jun 8, 2026 at 6:35=E2=80=AFPM David Marchand &lt;<a href=3D"mailto:david.=
marchand@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 8 Jun 2026 at 18:10, =
David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.com" target=3D"_=
blank">david.marchand@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, 22 Apr 2026 at 09:54, Maxime Peim &lt;<a href=3D"mailto:maxime=
.peim@gmail.com" target=3D"_blank">maxime.peim@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Threads registered via rte_thread_register() are assigned a valid=
<br>
&gt; &gt; lcore_id by eal_lcore_non_eal_allocate(), but their core_index in=
<br>
&gt; &gt; lcore_config is left at -1. This value was set during rte_eal_cpu=
_init()<br>
&gt; &gt; for lcores with ROLE_OFF (undetected CPUs) and is never updated w=
hen the<br>
&gt; &gt; lcore is later allocated to a non-EAL thread.<br>
&gt; &gt;<br>
&gt; &gt; As a result, rte_lcore_index() returns -1 for registered non-EAL<=
br>
&gt; &gt; threads. Libraries that use rte_lcore_index() to select per-lcore=
<br>
&gt; &gt; caches fall back to a shared global path when it returns -1, caus=
ing<br>
&gt; &gt; severe contention under concurrent access from multiple registere=
d<br>
&gt; &gt; threads.<br>
&gt; &gt;<br>
&gt; &gt; A concrete example is the mlx5 indexed memory pool (mlx5_ipool), =
which<br>
&gt; &gt; uses rte_lcore_index() in mlx5_ipool_malloc_cache() to select a p=
er-core<br>
&gt; &gt; cache slot. When core_index is -1, all registered threads are fun=
neled<br>
&gt; &gt; into a single shared slot protected by a spinlock. In testing wit=
h VPP<br>
&gt; &gt; (which registers worker threads via rte_thread_register()), this =
caused<br>
&gt; &gt; async flow rule insertion throughput to drop from ~6.4M rules/sec=
 to<br>
&gt; &gt; ~1.2M rules/sec with 4 workers -- a 5x regression attributable en=
tirely<br>
&gt; &gt; to spinlock contention in the ipool allocator.<br>
&gt; &gt;<br>
&gt; &gt; Fix by setting core_index to the next sequential index (cfg-&gt;l=
core_count)<br>
&gt; &gt; in eal_lcore_non_eal_allocate() before incrementing the count. Al=
so reset<br>
&gt; &gt; core_index back to -1 on the error rollback path and in<br>
&gt; &gt; eal_lcore_non_eal_release() for correctness.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 5c307ba2a5b1 (&quot;eal: register non-EAL threads as lcore=
s&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.o=
rg</a><br>
&gt;<br>
&gt; &gt; Signed-off-by: Maxime Peim &lt;<a href=3D"mailto:maxime.peim@gmai=
l.com" target=3D"_blank">maxime.peim@gmail.com</a>&gt;<br>
&gt; Acked-by: David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.c=
om" target=3D"_blank">david.marchand@redhat.com</a>&gt;<br>
&gt;<br>
<br>
Hum, I did not push the change.<br>
Re-reading this code, we have an issue if some external thread<br>
unregisters in the middle.<br>
<br>
What do you think of the additional hunk:<br>
<br>
$ git diff<br>
diff --git a/lib/eal/common/eal_common_lcore.c<br>
b/lib/eal/common/eal_common_lcore.c<br>
index ae085d73e4..6f53f20d90 100644<br>
--- a/lib/eal/common/eal_common_lcore.c<br>
+++ b/lib/eal/common/eal_common_lcore.c<br>
@@ -372,13 +372,16 @@ eal_lcore_non_eal_allocate(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_config *cfg =3D rte_eal_get_configur=
ation();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lcore_callback *callback;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lcore_callback *prev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int index =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int lcore_id;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_rwlock_write_lock(&amp;lcore_lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (lcore_id =3D 0; lcore_id &lt; RTE_MAX_LCOR=
E; lcore_id++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfg-&gt;lcore_r=
ole[lcore_id] !=3D ROLE_OFF)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfg-&gt;lcore_r=
ole[lcore_id] !=3D ROLE_OFF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0index++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lcore_config[lcore_=
id].core_index =3D cfg-&gt;lcore_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lcore_config[lcore_=
id].core_index =3D index;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg-&gt;lcore_role[=
lcore_id] =3D ROLE_NON_EAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg-&gt;lcore_count=
++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--000000000000e57e9d0653e67641--
