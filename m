Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB438C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C85E040269;
	Tue, 22 Jul 2025 18:52:16 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id A231940269
 for <dev@dpdk.org>; Tue, 22 Jul 2025 18:52:15 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-704c5464aecso52011376d6.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753203135;
 x=1753807935; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/xRDYJitDqzmSfqAEzl/KyeqeTycg/RsGKSCjW/dyps=;
 b=1Kw1Te9RhDnDbqFAAG0fYwcZbQ3QtdTABx/H8hZtZCSYOVC6EL1TBcWdEieb/CuXUF
 lSOhB0XP3KQWn7oTrkwk+Q0sJOnMQNi0adGQIsyYD8E1uiJhRlOs0fY6bGs3W2qIP3U1
 +M1CW821ymJg9A5AUQOx1QDsImDi9pcM0IZBl/PFq5pLaqC3OatILOc7aah98uaawwR8
 c/IADOPLx8a4m2mX581KPezoA8YJYqq9WRJaLAO33g7Z5ck6C8yoUCRDdJ5ORR355zgX
 pmsqard/QMp4UD1ZL/JojI4ZH5L2HT0f2U0Ceg1Jr6TXnJE7cCJjdZb37TuK7zAVTqBM
 C+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753203135; x=1753807935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xRDYJitDqzmSfqAEzl/KyeqeTycg/RsGKSCjW/dyps=;
 b=usQIyGldUSIl+4tLCxeAW89pYt9QxslzUhEmH9eU9Qp43nwUynhFzrflXonVWdGa3I
 BOSDbE0/R9TjpbVNehj7agdqRMA7e1RsMvr/55lPeGs8bE0gcBSD0SoTOBKmrb/qIpCK
 0HuyQJ7XgH6m55Mr6MtS36k9QwMMzHqeRH0+FgAG/PH7FKq8ppUxn84cZVCvVzxHCt7u
 /qqq8678wXbhNDwCEs9jlbGeFhnzrd6xj2KwDaAbsGi4UEfrkDdaADvIOiYGgM9yRRlM
 dOTCTbpjeJm2LQLlLEKpfGJg09fF5oK0VMIHxacrhnkIQwEbksxt5TNj7+8inFh2Vgto
 /m8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH4G6EVlwfDHWcgtsl0341KOu8s69Kx1tCt1inTMRae8roB0m641/I+xKnUy65u6zoMWA=@dpdk.org
X-Gm-Message-State: AOJu0Yw38j59bAIFqQSl1PLonyYHPvqvKqkzk+MUYjOV0ShusizMXgi9
 KmhrOji8W1kQff3kUO1Y7828y4E3E8nVSaj+dimmJgWfLHlhk5DefSKzMQgFJ9oaQdhyZL+yYXj
 pwMzs8fUGCrK5NqMKldN3NmylYh5Jh8BvAWbMqDEOLA==
X-Gm-Gg: ASbGncsOTnvx0N+WoJcItDw1wr0W4szQhGCF95d3tSoeBrbjmHUxIeiqq8yELL/dO9B
 HNObLIFDlqrLunO8yH7E65Sr6czoILpgAeOmZMA6+bYV+Kq+o9U7KgoDuqfexQPZGvDZLzi1u2e
 vo6MCRzLFURxwwT0gEfpN0ohvDmt+A7iZgVc61bCXNkc44Yqt2iu8i3FLqiHrEhWmutlwbZBCsk
 jeKMZs=
X-Google-Smtp-Source: AGHT+IGGGb5H+rvqkERvCf1i29+6h8xikDBRXVcDLW9yrxScCFK4KT1UwFEhKQMnrKQgwuRL/kK0KypQ+GlyM3gDRwo=
X-Received: by 2002:ad4:5bcc:0:b0:704:8ae6:1087 with SMTP id
 6a1803df08f44-704f6a16840mr445326086d6.10.1753203134547; Tue, 22 Jul 2025
 09:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
 <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
 <3358342.oiGErgHkdL@thomas>
 <20250721140127.r6orvsqsox7ytlhb@ds-vm-debian.local>
 <6d86669d-b277-584d-047f-c5cd1f5d0e55@arknetworks.am>
In-Reply-To: <6d86669d-b277-584d-047f-c5cd1f5d0e55@arknetworks.am>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 22 Jul 2025 21:52:02 +0500
X-Gm-Features: Ac12FXxxwp-QwQv4YgD4-8fR4q_B80bRMn44RLUBPU9AxC0zZuTM4ioq9v-U8qw
Message-ID: <CA++2-x6y07X3-9O7Ek=Uz83EWfQy+6mFaiXfUurt8m7fD_zwKw@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info after
 primary exits
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org,
 rasland@nvidia.com, 
 stable@dpdk.org, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Content-Type: multipart/alternative; boundary="0000000000000e03b5063a876a3c"
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

--0000000000000e03b5063a876a3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ivan,
Thanks for the detailed explanation.

While primary termination is a known limitation, I believe the application
or PMD should handle edge cases proactively to ensure stability.


On Tue, Jul 22, 2025 at 9:26=E2=80=AFPM Ivan Malov <ivan.malov@arknetworks.=
am>
wrote:

> Hi Dariusz, Khadem,
>
> On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
>
> > On Mon, Jul 21, 2025 at 01:59:59PM +0200, Thomas Monjalon wrote:
> >> 21/07/2025 13:46, Ivan Malov:
> >>> On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
> >>>
> >>>> + mlx5 maintainers
> >>>>
> >>>> Thank you for the patch.
> >>>>
> >>>> Could you please include other PMD maintainers (or other maintainers=
,
> depending on changed code)
> >>>> in the future patches?
> >>>> There is a script which automatically adds maintainers while sending
> a patch.
> >>>> It is described in:
> https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
> >>>>
> >>>> On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
> >>>>> When the primary process exits, the shared mlx5 state becomes
> >>>>> unavailable to secondary processes. If a secondary process attempts
> >>>>> to query device information (e.g., via testpmd), a NULL dereference
> >>>>> may occur due to missing shared data.
> >>>>>
> >>>>> This patch adds a check for shared context availability and fails
> >>>>> gracefully while preventing a crash.
> >>>>>
> >>>>> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
> >>>>> Cc: stable@dpdk.org
> >>>>>
> >>>>> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> >>>>> ---
> >>>>>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
> >>>>>  1 file changed, 6 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/net/mlx5/mlx5_ethdev.c
> b/drivers/net/mlx5/mlx5_ethdev.c
> >>>>> index 68d1c1bfa7..1848f6536a 100644
> >>>>> --- a/drivers/net/mlx5/mlx5_ethdev.c
> >>>>> +++ b/drivers/net/mlx5/mlx5_ethdev.c
> >>>>> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev,
> struct rte_eth_dev_info *info)
> >>>>>    * Since we need one CQ per QP, the limit is the minimum number
> >>>>>    * between the two values.
> >>>>>    */
> >>>>> + if (priv =3D=3D NULL || priv->sh =3D=3D NULL) {
> >>>>> +         DRV_LOG(ERR,
> >>>>> +         "mlx5 shared data unavailable (primary process likely
> exited)");
> >>>>> +         rte_errno =3D ENODEV;
> >>>>> +         return -rte_errno;
> >>>>> + }
> >>>>
> >>>> I don't think it's an issue on PMD level, but rather on
> >>>> ethdev/multi-process handling level.
> >>>
> >>> I may be very wrong here, but can't the PMD use its internal 'shared'
> state to
> >>> somehow memorise the fact that a secondary process has attached, in
> order to not
> >>> let the primary process close in the first place (before the secondar=
y
> process
> >>> detaches)? Or is this going to violate some established convention?
> >>
> >> It looks to be a good idea.
> >
> > I agree with idea of adding these checks, but not entirely agree with
> > it being at driver level, since all drivers would have to duplicate thi=
s
> logic.
> >
> > Drivers already have to go through ethdev library when port is probed
> > on secondary process - rte_eth_dev_attach_secondary() must be
> > called to retrieve port data local to the process and device data share=
d
> > between processes.
> > Memorizing whether a secondary process is using given port can be added
> > to rte_eth_dev_attach_secondary(), and relevant check for primary
> > process can then be added to rte_eth_dev_close(), so that all drivers
> > benefit.
> >
> > What do you think?
>
> Yes, in general, the idea would be to have a "secondary reference counter=
"
> field
> in 'rte_eth_dev_data' and have it incremented/decremented/checked in some
> generic places. The issue is that, in addition to 'rte_eth_dev_close', a
> device
> can be "closed" via its respective bus 'remove' method. Yes, there are
> drivers
> that invoke 'rte_eth_dev_close' inside the 'remove' implementation, but
> not all
> of them, unfortunately. For example, take a look at 'af_packet' and
> similar.
>
> On the other hands, there are drivers that use 'rte_eth_dev_create' and i=
ts
> counterpart 'rte_eth_dev_destroy' in the implementations of bus
> 'probe/remove',
> but that is also not consistent across the 'drivers/net' tree.
>
> Given all these issues and the fact that ethdev is not the only possible
> device
> type, may be 'rte_device' can house the reference counter, with
> 'rte_dev_probe'
> and 'rte_dev_remove' augmented to do the inrement/decrement/validate thin=
g?
> And, since 'rte_eth_dev_close' invokes direct ethdev 'close' method, also
> add a
> check to over there (and may be to 'rte_eth_dev_reset', too)? May be I'm
> wrong.
>
> However, all of that might still make no sense, given the fact that the
> primary
> process can just die. So, may be I am indeed very wrong and, as Stephen h=
as
> suggested in [1], this issue it to be addressed by clarifying the
> documentation.
>
> [1] https://mails.dpdk.org/archives/dev/2025-July/321865.html
>
> Thank you.
>
> >
> >>
> >>>> When primary process closes the port, ethdev library zeroes and free=
s
> >>>> device data shared between processes.
> >>>> ethdev port data (rte_eth_dev) on secondary is not updated so it now
> points to
> >>>> invalid data. rte_eth_dev_info_get() is not the only API call
> affected.
> >>>>
> >>>> If the primary process closes the port before exiting
> >>>> (like testpmd does) and it exits before the secondary,
> >>>> the any driver call seems invalid because of that use-after-free
> behavior.
> >>>>
> >>>> @Thomas, @Andrew - Do you happen to know if doing anything on ethdev
> ports
> >>>> in secondary process after primary has gracefully exited is supporte=
d?
> >>
> >> No there is no statement about whether it is supported or not.
> >> I think we should at least return an error instead of crashing.
> >>
> >>
> >
>


--=20
Engr. Khadem Ullah,
Software Engineer,
Dreambig Semiconductor Inc
https://dreambigsemi.com/

--0000000000000e03b5063a876a3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Ivan,=C2=A0<br><div>Thanks for the detailed explanation=
.=C2=A0</div><div><br></div><div>While primary termination is a known limit=
ation, I believe the application or PMD should handle edge cases proactivel=
y to ensure stability.<br><br></div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 22, 2=
025 at 9:26=E2=80=AFPM Ivan Malov &lt;<a href=3D"mailto:ivan.malov@arknetwo=
rks.am">ivan.malov@arknetworks.am</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Dariusz, Khadem,<br>
<br>
On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:<br>
<br>
&gt; On Mon, Jul 21, 2025 at 01:59:59PM +0200, Thomas Monjalon wrote:<br>
&gt;&gt; 21/07/2025 13:46, Ivan Malov:<br>
&gt;&gt;&gt; On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; + mlx5 maintainers<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thank you for the patch.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Could you please include other PMD maintainers (or other m=
aintainers, depending on changed code)<br>
&gt;&gt;&gt;&gt; in the future patches?<br>
&gt;&gt;&gt;&gt; There is a script which automatically adds maintainers whi=
le sending a patch.<br>
&gt;&gt;&gt;&gt; It is described in: <a href=3D"https://doc.dpdk.org/guides=
/contributing/patches.html#sending-patches" rel=3D"noreferrer" target=3D"_b=
lank">https://doc.dpdk.org/guides/contributing/patches.html#sending-patches=
</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wro=
te:<br>
&gt;&gt;&gt;&gt;&gt; When the primary process exits, the shared mlx5 state =
becomes<br>
&gt;&gt;&gt;&gt;&gt; unavailable to secondary processes. If a secondary pro=
cess attempts<br>
&gt;&gt;&gt;&gt;&gt; to query device information (e.g., via testpmd), a NUL=
L dereference<br>
&gt;&gt;&gt;&gt;&gt; may occur due to missing shared data.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This patch adds a check for shared context availabilit=
y and fails<br>
&gt;&gt;&gt;&gt;&gt; gracefully while preventing a crash.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Fixes: e60fbd5b24fc (&quot;mlx5: add device configure/=
start/stop&quot;)<br>
&gt;&gt;&gt;&gt;&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blan=
k">stable@dpdk.org</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Khadem Ullah &lt;<a href=3D"mailto:14pw=
cse1224@uetpeshawar.edu.pk" target=3D"_blank">14pwcse1224@uetpeshawar.edu.p=
k</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/=
net/mlx5/mlx5_ethdev.c<br>
&gt;&gt;&gt;&gt;&gt; index 68d1c1bfa7..1848f6536a 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/net/mlx5/mlx5_ethdev.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/drivers/net/mlx5/mlx5_ethdev.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth=
_dev *dev, struct rte_eth_dev_info *info)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 * Since we need one CQ per QP, the limit =
is the minimum number<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 * between the two values.<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 */<br>
&gt;&gt;&gt;&gt;&gt; + if (priv =3D=3D NULL || priv-&gt;sh =3D=3D NULL) {<b=
r>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRV_LOG(ERR,<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mlx5 shared d=
ata unavailable (primary process likely exited)&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_errno =3D ENODE=
V;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -rte_errno;<=
br>
&gt;&gt;&gt;&gt;&gt; + }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I don&#39;t think it&#39;s an issue on PMD level, but rath=
er on<br>
&gt;&gt;&gt;&gt; ethdev/multi-process handling level.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I may be very wrong here, but can&#39;t the PMD use its intern=
al &#39;shared&#39; state to<br>
&gt;&gt;&gt; somehow memorise the fact that a secondary process has attache=
d, in order to not<br>
&gt;&gt;&gt; let the primary process close in the first place (before the s=
econdary process<br>
&gt;&gt;&gt; detaches)? Or is this going to violate some established conven=
tion?<br>
&gt;&gt;<br>
&gt;&gt; It looks to be a good idea.<br>
&gt;<br>
&gt; I agree with idea of adding these checks, but not entirely agree with<=
br>
&gt; it being at driver level, since all drivers would have to duplicate th=
is logic.<br>
&gt;<br>
&gt; Drivers already have to go through ethdev library when port is probed<=
br>
&gt; on secondary process - rte_eth_dev_attach_secondary() must be<br>
&gt; called to retrieve port data local to the process and device data shar=
ed<br>
&gt; between processes.<br>
&gt; Memorizing whether a secondary process is using given port can be adde=
d<br>
&gt; to rte_eth_dev_attach_secondary(), and relevant check for primary<br>
&gt; process can then be added to rte_eth_dev_close(), so that all drivers<=
br>
&gt; benefit.<br>
&gt;<br>
&gt; What do you think?<br>
<br>
Yes, in general, the idea would be to have a &quot;secondary reference coun=
ter&quot; field<br>
in &#39;rte_eth_dev_data&#39; and have it incremented/decremented/checked i=
n some<br>
generic places. The issue is that, in addition to &#39;rte_eth_dev_close&#3=
9;, a device<br>
can be &quot;closed&quot; via its respective bus &#39;remove&#39; method. Y=
es, there are drivers<br>
that invoke &#39;rte_eth_dev_close&#39; inside the &#39;remove&#39; impleme=
ntation, but not all<br>
of them, unfortunately. For example, take a look at &#39;af_packet&#39; and=
 similar.<br>
<br>
On the other hands, there are drivers that use &#39;rte_eth_dev_create&#39;=
 and its<br>
counterpart &#39;rte_eth_dev_destroy&#39; in the implementations of bus &#3=
9;probe/remove&#39;,<br>
but that is also not consistent across the &#39;drivers/net&#39; tree.<br>
<br>
Given all these issues and the fact that ethdev is not the only possible de=
vice<br>
type, may be &#39;rte_device&#39; can house the reference counter, with &#3=
9;rte_dev_probe&#39;<br>
and &#39;rte_dev_remove&#39; augmented to do the inrement/decrement/validat=
e thing?<br>
And, since &#39;rte_eth_dev_close&#39; invokes direct ethdev &#39;close&#39=
; method, also add a<br>
check to over there (and may be to &#39;rte_eth_dev_reset&#39;, too)? May b=
e I&#39;m wrong.<br>
<br>
However, all of that might still make no sense, given the fact that the pri=
mary<br>
process can just die. So, may be I am indeed very wrong and, as Stephen has=
<br>
suggested in [1], this issue it to be addressed by clarifying the documenta=
tion.<br>
<br>
[1] <a href=3D"https://mails.dpdk.org/archives/dev/2025-July/321865.html" r=
el=3D"noreferrer" target=3D"_blank">https://mails.dpdk.org/archives/dev/202=
5-July/321865.html</a><br>
<br>
Thank you.<br>
<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; When primary process closes the port, ethdev library zeroe=
s and frees<br>
&gt;&gt;&gt;&gt; device data shared between processes.<br>
&gt;&gt;&gt;&gt; ethdev port data (rte_eth_dev) on secondary is not updated=
 so it now points to<br>
&gt;&gt;&gt;&gt; invalid data. rte_eth_dev_info_get() is not the only API c=
all affected.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If the primary process closes the port before exiting<br>
&gt;&gt;&gt;&gt; (like testpmd does) and it exits before the secondary,<br>
&gt;&gt;&gt;&gt; the any driver call seems invalid because of that use-afte=
r-free behavior.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @Thomas, @Andrew - Do you happen to know if doing anything=
 on ethdev ports<br>
&gt;&gt;&gt;&gt; in secondary process after primary has gracefully exited i=
s supported?<br>
&gt;&gt;<br>
&gt;&gt; No there is no statement about whether it is supported or not.<br>
&gt;&gt; I think we should at least return an error instead of crashing.<br=
>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><span style=3D"colo=
r:rgb(12,100,192)">Engr. Khadem Ullah, </span><br></div><div style=3D"font-=
family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">=
<span style=3D"color:rgb(12,100,192)">Software Engineer, </span><br></div><=
span style=3D"color:rgb(12,100,192)">Dreambig Semiconductor Inc <br></span>=
</div><div dir=3D"ltr"><span style=3D"color:rgb(12,100,192)"><a href=3D"htt=
ps://dreambigsemi.com/" target=3D"_blank">https://dreambigsemi.com/</a><br>=
</span></div></div></div></div>

--0000000000000e03b5063a876a3c--
