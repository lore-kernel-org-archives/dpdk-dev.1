Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E0C88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:12:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EEDE427BA;
	Wed, 16 Sep 2026 13:12:26 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id BD5454067D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:12:25 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9adea43b6so1161962a12.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 04:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789557145; cv=none;
 d=google.com; s=arc-20260327;
 b=If6k9MiP7uj3bj3H1s5nphNSU2qEVwhi8ixzO33RqiXX5fNG2GTn4oDnLXSqxLWB18
 +8y0tplwfcBPSxWZBqemMOPIRglT4s9HhzvuPfmzQifRxYEjEVoF/D4mPuTxDWf2Qqij
 n0NyaJj5x4TSf8DZ8IA47rVgk323HjrLDjwikvzzqXtVyH8b8TF1bwZf539qUJeWIkTJ
 jVYrr2KvUEepyL7bnVoTgVX9J1sX9bBu0uZToNfJe7UIut12ydMne1N3jrtzLwUSJOxj
 ovcP5kA7/2R2qZc0z4zetSP0zt32yEtrMZkGdxF4hCvy/13Kc4M+l33PdogFPdLVMO/K
 LNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zB0+Dd3pGFtqQpdpkvhqJxLFiHHUReJcE8AmYQBgP/E=;
 fh=8vj27bKjMY+e2v+97JSh+9UpXo7wtAHETM5ZqI75OK8=;
 b=g/G2RNMlUFE5lNaf//l2IUz9dawG77/QQ3ghkW8lYzYt9JpW0mx87a6SrRnn1sDvrT
 5+iiPeOLLjnSfUkCzZBwiISSdSPRlkt2P9J60N8pohvVrc8PgOGqhLva5kfUXYvxQaHU
 hO8QXh+s27ecy1QcgpF7AxqAxOYuFxotcMhLdc2EYK6BCnUzCS7EhIbV3KPzugZ22ZWX
 71KS6bGQGlir/JuoeU9/A83fPps+T5q0iJGyV7MdDGVNrEw12LnZfXKqw8Yq7BUnpiUH
 WagqoFhUywLT5LZj8Ndj/QWX+FWAwq0x5GLL6b7J63ClAErzxAK4Zx8Vgho48m9Sz5G+
 Oz3w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1789557145; x=1790161945; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zB0+Dd3pGFtqQpdpkvhqJxLFiHHUReJcE8AmYQBgP/E=;
 b=HqPcjn+p4a9KpMlLvDHorENDeoRvvz8+Bc5QJ4I17g7RrigMVHCxyjFdPfnwzcc6kx
 tte1g2eI/FQ/KfN4JmhQ9r4Lyx6SNLvC1u8jBVmjO+mU4nSGpuZ3SJCm7yhH/Frt81xJ
 zjiAGwXsQ/AQ6mVKEVGEQOLTWao5m2k1t/LYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789557145; x=1790161945;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zB0+Dd3pGFtqQpdpkvhqJxLFiHHUReJcE8AmYQBgP/E=;
 b=s+uCQ5WWq6y1WtqwiQbBxpd2qyRG066UY4ERQxGmZFZ55xDs1ONXbklXMOahGFoZIv
 91CLTlZvXvlerbAO5wov9SE1g5dTExY+WJgH5Gz7jDlzzmlPP12ACZp7qCTmABTt4IAM
 jx3Sz7+PkSkYCcI6DBDT20SeIq9DFwLNQIpE/5NSQpfYf3RF7sAC7BPn4cN9xlOTy6BF
 YJ5xIdDj5kWtSLbCOdqUF2dC4qV8WVjkxH6Zppt/gHQ6shm8HavO4EPafTvsBTHHhkGs
 8/KARG1myxOC8UP2mVpchrpb+AxX70gogGq7Bd1S3DrKwtDvpM4dP8O7C934SRIkRSUz
 0PlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ4GZ802L2E/0ueX2a6+kqd8G0xmYffxEj/cLk4F0qEuFuv54apV+wArWjadEokO40C+Y=@dpdk.org
X-Gm-Message-State: AFuF++mElr5KNuGqgcov6YVr5brh90vE754AfVWmg726tJC8cHRRo9hv
 Sz1/91t5JxbXZRRVQIfbeCVH7SgVSRkAvd1Y0UJ/HySNPclj0luwE03wSD/QUa/sC5nKw0gZqrv
 uld9FzL/6jw/0vpA2OsEsKBDEVLziTCVUYDleZihMnhVAHPrC/oYAJC3QDLO6Jp+7T3TdTpgpCd
 Q51X91fefxA/ylYdjY+oBmrM5DGFhk6sA26rgA18ACxtvs3viSi8XJns7F8kOx4UzuFbMXgjaRv
 +1zHw==
X-Gm-Gg: AYBFou0coVvca8jJwifOtr582tVJTUdSYhkvi8U7M8VTvezakcctUv+s9ZpFw/RlxjC
 Oldf5a9PNX6gd6ErJb6ZQtJsD3FQcDWdHGXed0Slqpig52rdJy3dhi9uytB1hyQVZwySnkkU1+3
 d068Bs+GE2UV6EFsSGlQf04oIySiTKkjQpTPlOOhBk40B5GiXj/J0X6TpFHUovDLWCrjzhNDGW8
 nABEht/n/ZE1R0K+p8h5KNrr9d89gVWIG9hC0cvNpuEO+NtoXlAqjNBpX8JTZNuCrR/XcFNi0rq
 4EZ5l8zrN7ZJPeMSymB+A58unFBlWyYU0jlf8azVDl+1Q9gzRtLpMTkalQ==
X-Received: by 2002:a05:6402:44c5:b0:6a9:d137:85e2 with SMTP id
 4fb4d7f45d1cf-6aa223fe40amr1306160a12.20.1789557145124; Wed, 16 Sep 2026
 04:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260914105809.919580-1-rita.ruvinsky@weka.io>
 <20260914091419.22e3ef6e@phoenix.local>
 <SI3P153MB18385AC2FAA3AFA6DE465B5DBBBB2@SI3P153MB1838.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SI3P153MB18385AC2FAA3AFA6DE465B5DBBBB2@SI3P153MB1838.APCP153.PROD.OUTLOOK.COM>
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
Date: Wed, 16 Sep 2026 14:12:12 +0300
X-Gm-Features: AcwNN1WmuOU_Nlb-je40FiBs_GnFzd75mi_2eD9XwB8zlOcZCCq7zibPdOuxGGQ
Message-ID: <CAJEiD5gTKwKf0pZuAB4hRUwa0JbkTtD-rQeeuKjkZeEyoJfr8g@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue
 free-space unit mismatch
To: Wei Hu <weh@microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 "longli@microsoft.com" <longli@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000f129f5065b97bdd4"
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

--000000000000f129f5065b97bdd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,
I am happy to send these as a follow-up if you've already committed v1 or
create a v2 patch.

Thanks,
Rita

On Mon, Sep 14, 2026 at 7:25=E2=80=AFPM Wei Hu <weh@microsoft.com> wrote:

>
>
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday, September 15, 2026 12:14 AM
> > To: Rita Ruvinsky <rita.ruvinsky@weka.io>
> > Cc: dev@dpdk.org; longli@microsoft.com; Wei Hu <weh@microsoft.com>;
> > stable@dpdk.org
> > Subject: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue
> free-
> > space unit mismatch
> >
> > On Mon, 14 Sep 2026 13:58:08 +0300
> > Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:
> >
> > > gdma_post_work_request() subtracted a unit count from an entry count:
> > >
> > >   queue_free_units =3D queue->count - (queue->head - queue->tail);
> > >
> > > queue->count is in entries, while head and tail are in WQE alignment
> > > units. On a 512-entry, 128KB send queue the check saw 512 units of
> > > capacity instead of queue->size / GDMA_WQE_ALIGNMENT_UNIT_SIZE =3D
> > 4096,
> > > and returned -EBUSY with the queue one eighth full. A workload that
> > > fills that window faster than it drains makes rte_eth_tx_burst()
> > > return
> > > 0 for long enough to look like a dead port.
> > >
> > > Derive the capacity from queue->size, which is also what the ring wra=
p
> > > in gdma_get_wqe_pointer() uses. Rx is unaffected: its WQEs occupy
> > > exactly one unit, so entries and units coincide.
> > >
> > > Fixes: 56dd45c0ce7b ("net/mana: implement hardware layer operations")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
> > > ---
> >
> > Applied to next-net
> >
> > The long form AI review had some observations worth including:
> >
> > On Mon, 14 Sep 2026 13:58:08 +0300
> > Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:
> >
> > > gdma_post_work_request() subtracted a unit count from an entry count:
> >
> > The unit analysis is right.  head/tail are advanced in alignment units
> (queue-
> > >head +=3D wqe_size / GDMA_WQE_ALIGNMENT_UNIT_SIZE, and
> > gdma_get_wqe_pointer() multiplies head by the same constant), while
> > sq_count comes from rdma-core as attr->cap.max_send_wr and sq_size as
> > align_hw_size(max_send_wr * get_wqe_size(max_send_sge)).  Deriving the
> > capacity from size is the only self-consistent choice, and it is what
> > mana_gd_wq_avail_space() in the kernel driver does.
> >
> > Info:
> >
> > 1. The debug line in the -EBUSY path still reports queue->count:
> >
> >       DP_LOG(DEBUG, "WQE size %u queue count %u head %u tail %u",
> >              wqe_size, queue->count, queue->head, queue->tail);
> >
> > After this patch count no longer takes part in the decision for the sen=
d
> or
> > receive queue; only gdma_poll_completion_queue() still uses it, for the
> CQ.
> > The one line printed when a post is rejected no longer shows what it wa=
s
> > rejected against.  Suggest:
> >
> >       DP_LOG(DEBUG, "WQE size %u queue size %u free %u head %u
> > tail %u",
> >              wqe_size, queue->size, queue_free_units,
> >              queue->head, queue->tail);
> >
> > 2. The comment describes the old bug rather than the invariant:
> >
> >       /* head/tail count WQE alignment units, so the capacity they are
> >        * compared against must too: queue->count is in entries and
> >        * undercounts the queue, stalling Tx well below capacity.
> >        */
> >
> > The stall belongs in the commit message, where it already is.  In the
> source the
> > invariant is enough:
> >
> >       /* head and tail are in WQE alignment units, so the capacity must
> >        * come from the queue size in bytes, not the entry count.
> >        */
> >
> > 3. Worth a sentence in the commit message that the kernel mana driver
> > computes the same limit in mana_gd_wq_avail_space(), in bytes:
> >
> >       u32 used_space =3D (wq->head - wq->tail) * GDMA_WQE_BU_SIZE;
> >       return wq->queue_size - used_space;
> >
> > It is independent confirmation of the unit convention and tells anyone
> > backporting this that the two drivers now agree.
>
> I was about to say the same. The change in DP_LOG and code comments
> all make a lot of sense. Thanks for fixing this.
>
> Wei
>

--000000000000f129f5065b97bdd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Stephen,<div>I am happy to send these as a follow-=
up if you&#39;ve already committed v1 or create a v2 patch.</div><div><br><=
/div><div>Thanks,</div><div>Rita</div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14,=
 2026 at 7:25=E2=80=AFPM Wei Hu &lt;<a href=3D"mailto:weh@microsoft.com">we=
h@microsoft.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.o=
rg" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
&gt; Sent: Tuesday, September 15, 2026 12:14 AM<br>
&gt; To: Rita Ruvinsky &lt;<a href=3D"mailto:rita.ruvinsky@weka.io" target=
=3D"_blank">rita.ruvinsky@weka.io</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpdk.org</a>=
; <a href=3D"mailto:longli@microsoft.com" target=3D"_blank">longli@microsof=
t.com</a>; Wei Hu &lt;<a href=3D"mailto:weh@microsoft.com" target=3D"_blank=
">weh@microsoft.com</a>&gt;;<br>
&gt; <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</=
a><br>
&gt; Subject: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue=
 free-<br>
&gt; space unit mismatch<br>
&gt; <br>
&gt; On Mon, 14 Sep 2026 13:58:08 +0300<br>
&gt; Rita Ruvinsky &lt;<a href=3D"mailto:rita.ruvinsky@weka.io" target=3D"_=
blank">rita.ruvinsky@weka.io</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; gdma_post_work_request() subtracted a unit count from an entry co=
unt:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0queue_free_units =3D queue-&gt;count - (queue-&gt;hea=
d - queue-&gt;tail);<br>
&gt; &gt;<br>
&gt; &gt; queue-&gt;count is in entries, while head and tail are in WQE ali=
gnment<br>
&gt; &gt; units. On a 512-entry, 128KB send queue the check saw 512 units o=
f<br>
&gt; &gt; capacity instead of queue-&gt;size / GDMA_WQE_ALIGNMENT_UNIT_SIZE=
 =3D<br>
&gt; 4096,<br>
&gt; &gt; and returned -EBUSY with the queue one eighth full. A workload th=
at<br>
&gt; &gt; fills that window faster than it drains makes rte_eth_tx_burst()<=
br>
&gt; &gt; return<br>
&gt; &gt; 0 for long enough to look like a dead port.<br>
&gt; &gt;<br>
&gt; &gt; Derive the capacity from queue-&gt;size, which is also what the r=
ing wrap<br>
&gt; &gt; in gdma_get_wqe_pointer() uses. Rx is unaffected: its WQEs occupy=
<br>
&gt; &gt; exactly one unit, so entries and units coincide.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 56dd45c0ce7b (&quot;net/mana: implement hardware layer ope=
rations&quot;)<br>
&gt; &gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@d=
pdk.org</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Rita Ruvinsky &lt;<a href=3D"mailto:rita.ruvinsky@=
weka.io" target=3D"_blank">rita.ruvinsky@weka.io</a>&gt;<br>
&gt; &gt; ---<br>
&gt; <br>
&gt; Applied to next-net<br>
&gt; <br>
&gt; The long form AI review had some observations worth including:<br>
&gt; <br>
&gt; On Mon, 14 Sep 2026 13:58:08 +0300<br>
&gt; Rita Ruvinsky &lt;<a href=3D"mailto:rita.ruvinsky@weka.io" target=3D"_=
blank">rita.ruvinsky@weka.io</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; gdma_post_work_request() subtracted a unit count from an entry co=
unt:<br>
&gt; <br>
&gt; The unit analysis is right.=C2=A0 head/tail are advanced in alignment =
units (queue-<br>
&gt; &gt;head +=3D wqe_size / GDMA_WQE_ALIGNMENT_UNIT_SIZE, and<br>
&gt; gdma_get_wqe_pointer() multiplies head by the same constant), while<br=
>
&gt; sq_count comes from rdma-core as attr-&gt;cap.max_send_wr and sq_size =
as<br>
&gt; align_hw_size(max_send_wr * get_wqe_size(max_send_sge)).=C2=A0 Derivin=
g the<br>
&gt; capacity from size is the only self-consistent choice, and it is what<=
br>
&gt; mana_gd_wq_avail_space() in the kernel driver does.<br>
&gt; <br>
&gt; Info:<br>
&gt; <br>
&gt; 1. The debug line in the -EBUSY path still reports queue-&gt;count:<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DP_LOG(DEBUG, &quot;WQE size %u queue count =
%u head %u tail %u&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wqe_size, queue-&gt;co=
unt, queue-&gt;head, queue-&gt;tail);<br>
&gt; <br>
&gt; After this patch count no longer takes part in the decision for the se=
nd or<br>
&gt; receive queue; only gdma_poll_completion_queue() still uses it, for th=
e CQ.<br>
&gt; The one line printed when a post is rejected no longer shows what it w=
as<br>
&gt; rejected against.=C2=A0 Suggest:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DP_LOG(DEBUG, &quot;WQE size %u queue size %=
u free %u head %u<br>
&gt; tail %u&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wqe_size, queue-&gt;si=
ze, queue_free_units,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue-&gt;head, queue-=
&gt;tail);<br>
&gt; <br>
&gt; 2. The comment describes the old bug rather than the invariant:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* head/tail count WQE alignment units, so t=
he capacity they are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * compared against must too: queue-&gt;coun=
t is in entries and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * undercounts the queue, stalling Tx well b=
elow capacity.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; <br>
&gt; The stall belongs in the commit message, where it already is.=C2=A0 In=
 the source the<br>
&gt; invariant is enough:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* head and tail are in WQE alignment units,=
 so the capacity must<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * come from the queue size in bytes, not th=
e entry count.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; <br>
&gt; 3. Worth a sentence in the commit message that the kernel mana driver<=
br>
&gt; computes the same limit in mana_gd_wq_avail_space(), in bytes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 used_space =3D (wq-&gt;head - wq-&gt;tai=
l) * GDMA_WQE_BU_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return wq-&gt;queue_size - used_space;<br>
&gt; <br>
&gt; It is independent confirmation of the unit convention and tells anyone=
<br>
&gt; backporting this that the two drivers now agree.<br>
<br>
I was about to say the same. The change in DP_LOG and code comments<br>
all make a lot of sense. Thanks for fixing this. <br>
<br>
Wei<br>
</blockquote></div>

--000000000000f129f5065b97bdd4--
