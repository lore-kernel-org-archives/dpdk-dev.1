Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B4C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 18:13:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A4FF40A70;
	Mon, 31 Mar 2025 20:13:56 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id A899C40A6C
 for <dev@dpdk.org>; Mon, 31 Mar 2025 20:13:55 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-227b650504fso95407955ad.0
 for <dev@dpdk.org>; Mon, 31 Mar 2025 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743444835; x=1744049635; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FJUoLWfHtAnc9PDIVPzD61X1iJ9i59+c3AIgOOCTx8A=;
 b=Xy2Xfeh9lcT6vRhqRNxnWLsWbam/fffy19kKcR0HFaDEzdg0xLPJq+49/Vcm2ahXIE
 d0yKUih63NfqUKUUQVuwBfJqEUBcOdC/+djofKlgYoJpOu8hjQCJBFcWr/DOLXF+SUQE
 N5WvdFJ86+xy+ENGdLs+2ZEpj+ZKpI4Hu2jF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743444835; x=1744049635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJUoLWfHtAnc9PDIVPzD61X1iJ9i59+c3AIgOOCTx8A=;
 b=o4FIYZQJ/qM7o+kgBvZ9aZCbaYu62z3SHwP5G9+SfraRvp3NbUAYNXt7xxMmT4zXv9
 TFp1kK3Qn1mx7OiKmlZZUOp4GVTl+W+g3zbcGm5uytML9viL/bDHf/WVKvCewJmxlwlt
 JoSPhOuUmFVg1yxhME5u3IyyVr2ntYpsUv5vm5Z2APuS3TT++nRzNc6I81DZ5r3KIaAx
 2sVCWPO24GkeWh+LV86y+7PE3t38IpYaFPxV8WwAoL+yUkX3SI8Knt6enyrnHvVfXUdJ
 XclNbcHqQAlvKtri2JA5abzuYS5EODNvIxh553Uef9nyyhM1UxCKxPgAuxX/1KJvuI7C
 Mfaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAfwSFlVw9Axq7Pda1UpooGk8EIWuNDguU5clsNV7R1F9+/hCNhc0rMjZQBAkDzCHuoVU=@dpdk.org
X-Gm-Message-State: AOJu0YxouWJOU40eZ11jaPJm+KZ80RmB9ELnE9nv4F7ZY40VXuA9HrFH
 lQEMYS/1J+bvfsQavjtU6wXQrrPrZey4t/CmMv0pq1sj8Rk3TDcsL1EeyfA818vLcVFVqJgJmXB
 9RovRTjp+AN7iDhFOjhQUBVG+TPHcGsBfbXKk/A==
X-Gm-Gg: ASbGncuiSttTYrJsVTjdaPKmDsXX2q5PDBNk0Cph9O5H2WTscpy631lyJg38987M3ra
 8T+cZZOTnZyu+4DewyNPrALXzEvF1J6dbZkTdgRQYxCAptjhIjg/XesVDXMzb4itBRoxjReiJR8
 imEGcCThO/cz4WkRUCdruqf2xCGFihUib4hXuOJ2mZQsmRHft9UqxSHFuc2500pRhhZtUTcA==
X-Google-Smtp-Source: AGHT+IHeaNEH28QyPHP20y4/2VTM2NFKMk/9qlCjuWoTJ3GVT11i7aw4Uj5pz/Lec5klBPfkgNTROQPqevgn8rzxs20=
X-Received: by 2002:a17:903:32cb:b0:224:c46:d14b with SMTP id
 d9443c01a7336-2292f9ff33dmr106102885ad.52.1743444834691; Mon, 31 Mar 2025
 11:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
 <20250321085259.095bd234@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB3B@smartserver.smartshare.dk>
 <CAMEVEZutf4sJ=EQFONw_bJW0tGTWqTbF_Tk_y38qzBLccco46Q@mail.gmail.com>
In-Reply-To: <CAMEVEZutf4sJ=EQFONw_bJW0tGTWqTbF_Tk_y38qzBLccco46Q@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 31 Mar 2025 14:09:55 -0400
X-Gm-Features: AQ5f1Jq2nkH_wTwcAyze3VDEOw435jpvtjgaeP1pbkDdSIJmvJxwx8yWn87luE4
Message-ID: <CAJvnSUBTZw6DyojHQneApZ+e1xMRuxNYFcC6_mqQvTiovCsLRg@mail.gmail.com>
Subject: Re: Clarification on Minimum Supported Kernel Version for DPDK
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kevin Traynor <ktraynor@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, techboard@dpdk.org, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Thomas Monjalon <thomas@monjalon.net>, 
 David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 Ali Alnubani <alialnu@nvidia.com>, 
 galco@nvidia.com, Cody Cheng <ccheng@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000000ecb6b0631a762fe"
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

--0000000000000ecb6b0631a762fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, Cody has setup the new VM which will be version locked to the minimum
kernel version. We will try to monitor the mailing list like always for
changes to this, but it will be helpful if the CI mailing list can be CC'd
on any patches going forward which bump the minimum kernel version. Thanks.

On Wed, Mar 26, 2025 at 10:47=E2=80=AFAM Cody Cheng <ccheng@iol.unh.edu> wr=
ote:

> I=E2=80=99ll set up the CI testing environment on kernel 4.19 as per the
> current minimum requirement then.
>
> Thanks,
> Cody Cheng
>
>
> On Sat, Mar 22, 2025 at 9:02=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshare=
systems.com>
> wrote:
> >
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Friday, 21 March 2025 16.53
> > >
> > > On Fri, 21 Mar 2025 07:28:45 +0100
> > > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> > >
> > > > @Kevin, @Stephen, @Bruce,
> > > >
> > > > I cannot reliably answer Cody's question, and it may need further
> > > discussion.
> > > >
> > > > What is your opinion on minimum Linux kernel version requirements?
> > > >
> > > > @Thomas: In the future, the DPDK release notes should mention the
> > > minimum Linux kernel requirements.
> > > >
> > > > > From: Cody Cheng [mailto:ccheng@iol.unh.edu]
> > > > > Sent: Thursday, 20 March 2025 21.28
> > > > >
> > > > > Hi Morten,
> > > > >
> > > > > I am in the process of setting up a test environment at the UNH
> > > DPDK
> > > > > Community Test Lab that follows the minimum supported kernel
> > > version
> > > > > for DPDK. According to the DPDK documentation, the minimum
> > > supported
> > > > > kernel version is 4.19. However, the oldest long term stable kern=
el
> > > > > version listed on kernel.org is 5.4.291.
> > > > >
> > > > > Should the test environment be set up on kernel version 4.19 or
> > > > > 5.4.291?
> > > >
> > > > The kernel 4.19 support stems from still supporting RHEL/CentOS 7.
> > > > I wonder if this exception mentioned in the documentation [1] is
> > > still valid, or if we should bump it to RHEL/CentOS 8, which ships wi=
th
> > > kernel 4.18 [1].
> > > >
> > > > RHEL/CentOS 7 support was discussed at by tech board long ago [2],
> > > but I cannot find a conclusion about the kernel version; the discussi=
on
> > > was mostly about compiler support.
> > > >
> > > > [1]: https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#system-
> > > software
> > > > [2]:
> > >
> https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/htm
> > > l-single/8.0_release_notes/index#overview
> > > > [3]: https://mails.dpdk.org/archives/dev/2023-February/263516.html
> > >
> > > My opinion has always been that DPDK only offers certain guarantees
> > > about testing:
> > >   - oldest current LTS
> > >   - oldest supported version of Redhat/Ubuntu/SUSE enterprise kernels
> > >
> > > after that in the embedded space, the user is likely to be ok but any
> > > kernel
> > > related issues are their problem not the communities to deal with.
> >
> > Generally, if some new DPDK feature requires a new kernel (or new kerne=
l
> feature), the details should be mentioned in the release notes.
> > And preferably, that feature should degrade gracefully when the feature
> is not present.
> >
> > For the embedded space, we could support the oldest current version
> available as Super LTS [4], which is 4.4. And for now, we could stick wit=
h
> the second oldest, 4.19, which is what we currently have.
> >
> > [4]:
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel=
_maintainership
> >
> > Some old kernel version might not be officially supported by the Kernel
> community, but an embedded vendor might have tested the relevant features
> extensively and thus trust it more than some new and officially supported
> version.
> > So let's not require a newer version than we absolutely must, on
> technical grounds.
> > It seems that kernel 4.19 is the current minimum requirement, so let's
> stick with that, until there are valid technical reasons for requiring a
> newer version.
> >
> > Anyway, it seems we need to clarify the policy for kernel version
> requirements.
> > It's easy regarding the distros; DPDK running on those require their
> shipped kernel version, at minimum.
> > It's for everything else clarification is needed.
> >
> > And it's not just embedded. Virtual appliances can be tricky too... wit=
h
> our SmartShare VM we had to add support for running as a guest under an
> ancient QEMU host version, because that is the hypervisor used by one of
> the big system providers in our most important target market.
> >
> > In non-cloud market segments, a lot of really old stuff is still being
> used in production, working perfectly fine.
> >
> > >
> > > The two parts most likely to cause issues are vfio-pci and vhost
> > > related stuff.
> > > There is also small chance of issues with the memory handling in EAL.
> > And maybe handling of many CPU cores, and most likely something related
> to the new cache steering feature.
> >
>

--0000000000000ecb6b0631a762fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Okay, Cody has setup the new VM which will be version lock=
ed to the minimum kernel version. We will try to monitor the mailing list l=
ike always for changes to this, but it will be helpful if the CI mailing li=
st can be CC&#39;d on any patches going forward which bump the minimum kern=
el version. Thanks.</div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 26, 2025 at 10:47=E2=
=80=AFAM Cody Cheng &lt;<a href=3D"mailto:ccheng@iol.unh.edu">ccheng@iol.un=
h.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">I=E2=80=99ll set up the CI testing environment on kernel 4.19 as per t=
he<br>
current minimum requirement then.<br>
<br>
Thanks,<br>
Cody Cheng<br>
<br>
<br>
On Sat, Mar 22, 2025 at 9:02=E2=80=AFAM Morten Br=C3=B8rup &lt;<a href=3D"m=
ailto:mb@smartsharesystems.com" target=3D"_blank">mb@smartsharesystems.com<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; From: Stephen Hemminger [mailto:<a href=3D"mailto:stephen@network=
plumber.org" target=3D"_blank">stephen@networkplumber.org</a>]<br>
&gt; &gt; Sent: Friday, 21 March 2025 16.53<br>
&gt; &gt;<br>
&gt; &gt; On Fri, 21 Mar 2025 07:28:45 +0100<br>
&gt; &gt; Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com=
" target=3D"_blank">mb@smartsharesystems.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; @Kevin, @Stephen, @Bruce,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I cannot reliably answer Cody&#39;s question, and it may nee=
d further<br>
&gt; &gt; discussion.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What is your opinion on minimum Linux kernel version require=
ments?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @Thomas: In the future, the DPDK release notes should mentio=
n the<br>
&gt; &gt; minimum Linux kernel requirements.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; From: Cody Cheng [mailto:<a href=3D"mailto:ccheng@iol.u=
nh.edu" target=3D"_blank">ccheng@iol.unh.edu</a>]<br>
&gt; &gt; &gt; &gt; Sent: Thursday, 20 March 2025 21.28<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hi Morten,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I am in the process of setting up a test environment at=
 the UNH<br>
&gt; &gt; DPDK<br>
&gt; &gt; &gt; &gt; Community Test Lab that follows the minimum supported k=
ernel<br>
&gt; &gt; version<br>
&gt; &gt; &gt; &gt; for DPDK. According to the DPDK documentation, the mini=
mum<br>
&gt; &gt; supported<br>
&gt; &gt; &gt; &gt; kernel version is 4.19. However, the oldest long term s=
table kernel<br>
&gt; &gt; &gt; &gt; version listed on <a href=3D"http://kernel.org" rel=3D"=
noreferrer" target=3D"_blank">kernel.org</a> is 5.4.291.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Should the test environment be set up on kernel version=
 4.19 or<br>
&gt; &gt; &gt; &gt; 5.4.291?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The kernel 4.19 support stems from still supporting RHEL/Cen=
tOS 7.<br>
&gt; &gt; &gt; I wonder if this exception mentioned in the documentation [1=
] is<br>
&gt; &gt; still valid, or if we should bump it to RHEL/CentOS 8, which ship=
s with<br>
&gt; &gt; kernel 4.18 [1].<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; RHEL/CentOS 7 support was discussed at by tech board long ag=
o [2],<br>
&gt; &gt; but I cannot find a conclusion about the kernel version; the disc=
ussion<br>
&gt; &gt; was mostly about compiler support.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [1]: <a href=3D"https://doc.dpdk.org/guides/linux_gsg/sys_re=
qs.html#system-" rel=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org/=
guides/linux_gsg/sys_reqs.html#system-</a><br>
&gt; &gt; software<br>
&gt; &gt; &gt; [2]:<br>
&gt; &gt; <a href=3D"https://docs.redhat.com/en/documentation/red_hat_enter=
prise_linux/8/htm" rel=3D"noreferrer" target=3D"_blank">https://docs.redhat=
.com/en/documentation/red_hat_enterprise_linux/8/htm</a><br>
&gt; &gt; l-single/8.0_release_notes/index#overview<br>
&gt; &gt; &gt; [3]: <a href=3D"https://mails.dpdk.org/archives/dev/2023-Feb=
ruary/263516.html" rel=3D"noreferrer" target=3D"_blank">https://mails.dpdk.=
org/archives/dev/2023-February/263516.html</a><br>
&gt; &gt;<br>
&gt; &gt; My opinion has always been that DPDK only offers certain guarante=
es<br>
&gt; &gt; about testing:<br>
&gt; &gt;=C2=A0 =C2=A0- oldest current LTS<br>
&gt; &gt;=C2=A0 =C2=A0- oldest supported version of Redhat/Ubuntu/SUSE ente=
rprise kernels<br>
&gt; &gt;<br>
&gt; &gt; after that in the embedded space, the user is likely to be ok but=
 any<br>
&gt; &gt; kernel<br>
&gt; &gt; related issues are their problem not the communities to deal with=
.<br>
&gt;<br>
&gt; Generally, if some new DPDK feature requires a new kernel (or new kern=
el feature), the details should be mentioned in the release notes.<br>
&gt; And preferably, that feature should degrade gracefully when the featur=
e is not present.<br>
&gt;<br>
&gt; For the embedded space, we could support the oldest current version av=
ailable as Super LTS [4], which is 4.4. And for now, we could stick with th=
e second oldest, 4.19, which is what we currently have.<br>
&gt;<br>
&gt; [4]: <a href=3D"https://wiki.linuxfoundation.org/civilinfrastructurepl=
atform/start#kernel_maintainership" rel=3D"noreferrer" target=3D"_blank">ht=
tps://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel_mai=
ntainership</a><br>
&gt;<br>
&gt; Some old kernel version might not be officially supported by the Kerne=
l community, but an embedded vendor might have tested the relevant features=
 extensively and thus trust it more than some new and officially supported =
version.<br>
&gt; So let&#39;s not require a newer version than we absolutely must, on t=
echnical grounds.<br>
&gt; It seems that kernel 4.19 is the current minimum requirement, so let&#=
39;s stick with that, until there are valid technical reasons for requiring=
 a newer version.<br>
&gt;<br>
&gt; Anyway, it seems we need to clarify the policy for kernel version requ=
irements.<br>
&gt; It&#39;s easy regarding the distros; DPDK running on those require the=
ir shipped kernel version, at minimum.<br>
&gt; It&#39;s for everything else clarification is needed.<br>
&gt;<br>
&gt; And it&#39;s not just embedded. Virtual appliances can be tricky too..=
. with our SmartShare VM we had to add support for running as a guest under=
 an ancient QEMU host version, because that is the hypervisor used by one o=
f the big system providers in our most important target market.<br>
&gt;<br>
&gt; In non-cloud market segments, a lot of really old stuff is still being=
 used in production, working perfectly fine.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; The two parts most likely to cause issues are vfio-pci and vhost<=
br>
&gt; &gt; related stuff.<br>
&gt; &gt; There is also small chance of issues with the memory handling in =
EAL.<br>
&gt; And maybe handling of many CPU cores, and most likely something relate=
d to the new cache steering feature.<br>
&gt;<br>
</blockquote></div>

--0000000000000ecb6b0631a762fe--
