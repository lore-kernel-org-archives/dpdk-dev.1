Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A3FCD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E4D4042C;
	Thu,  4 Jun 2026 11:56:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3B45402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 11:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780566980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YCy38uubZqMWdUkJRV8p4coTNaiQezBg37MncrwZGdc=;
 b=Su2phqjyHwxeSdIO1e0Z11CF4uaDpXedDHsJr7mNrVOBbSZvFvYqXEtuGcnkdVzDZWDhjG
 vkDwW0HL46jeMPuVviHI0K0EV8LpQgpZa2B+5xi6gU5V4PbQI5ij2HL7/Su5/7B/nTSy16
 0LOraOv4wYOpVov/ZtiIU6lcqYcRWxM=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-4wlL526lPNmd67oXfCRTiQ-1; Thu, 04 Jun 2026 05:56:16 -0400
X-MC-Unique: 4wlL526lPNmd67oXfCRTiQ-1
X-Mimecast-MFC-AGG-ID: 4wlL526lPNmd67oXfCRTiQ_1780566976
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137ea73393cso2401089c88.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 02:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566975; x=1781171775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCy38uubZqMWdUkJRV8p4coTNaiQezBg37MncrwZGdc=;
 b=Vh5L2JNHy6k9YOy8LNtdU+OPb17GVbA40dPIl5zN3SeCByasUi74N3znHDcapMV0HI
 Yh7SDje1KilJls1KnUmaKOTnaY50eUOjQQnvmBBPtgPNkNzNadp6wsfKpIFFZtUJWTH5
 +pdZhxL5bpu5vb/AGpcqVgwHNo+M7hoOHfpN7FAj1TI+7KqAfvTOrYPuqGOcU+xNUDub
 0T3huynbuYWwYdl3VZ1XybmiRMsc3EHMJDGCWwDLGfq7gEsN1NjKq81heFihG5GqUeUs
 w2mJU9GBgwiV0RFBB170nk7uZRf2zd/dqHL2c5raNQnsxW0XYSBFGRNXVUSXDgBvWZxC
 CEgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QzG0gofuo7/y35qMiBEwvNSBbB6VlUblpAm5gqRRMk/BTXulBkYqKCNYFClVh9zcu+aU=@dpdk.org
X-Gm-Message-State: AOJu0Yw7a9jiNLVDRciaeHpkmTVKXbtetuG4AklFg90Sjt/HV4EGpRHP
 Tg1CYm5n0dZFj0aze2jBsFdcQL7UZrBn2F840i8MlvGxVyflj099cNelLMVp8OdS6oLoOqxqux8
 T8vgnNtmhDqZlzguA4+lMaed9LExMe2gk4JVQcKqpZ8kr1AA9MFTN+dj2BqBiM4Cdd70K/UR+P2
 7RAZq/b4mGPSXeNq5Tsmo=
X-Gm-Gg: Acq92OF9vIVPnKgbYTyBvEpz+DLt1RrQM+XEBEAjcVBjEEQc8u/IYGMr7JwjXDDro7l
 kaEsiNuiAIcMjNxM5cdNDDWTezp7+PHwo49xCYYWL34xYrgwxqmM++0mIQiEMbUMykYm1JgmXQ8
 LG+IEXSjgmdEKgdoa1PfnRkGVuD8J162sS/3QvunuwmAkura0HJ+Z07j96PtGXz+RMpgKyWRowy
 K/Ms/Vx8yoUAz3TMQUs1wq4xelz5cqiozDAN9i1eV1RBdhjXy2j7NpUby2oKOttX5yE78XhCT3Q
X-Received: by 2002:a05:7022:689b:b0:130:6c8f:5a87 with SMTP id
 a92af1059eb24-137f6a4b1fdmr3473317c88.13.1780566975487; 
 Thu, 04 Jun 2026 02:56:15 -0700 (PDT)
X-Received: by 2002:a05:7022:689b:b0:130:6c8f:5a87 with SMTP id
 a92af1059eb24-137f6a4b1fdmr3473310c88.13.1780566974956; Thu, 04 Jun 2026
 02:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
 <20260514224627.2014566-2-pravin.bathija@dell.com>
 <b4e44ed7-7902-4369-a4e4-509ed3addf91@huawei.com>
 <DM6PR19MB356483DFA0304202FA06F344F5012@DM6PR19MB3564.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB356483DFA0304202FA06F344F5012@DM6PR19MB3564.namprd19.prod.outlook.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 4 Jun 2026 11:56:03 +0200
X-Gm-Features: AVHnY4KzMOchC0ilfs2fAniYpS26JTRNARkZFuInC-cfBe-lfgT_4FrasjVqaQQ
Message-ID: <CAO55cswLh4S2irWROEUAp5m=tvJSbZo4Y=8YMNU5P1Foi7ZUsg@mail.gmail.com>
Subject: Re: [PATCH v13 1/5] vhost: add user to mailmap and define to vhost hdr
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>
Cc: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LSxTrqZcPNrKHnSBGHjxvH8wXj-7jrbgywMxjqxyeMk_1780566976
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000000a9dd706536a8e7e"
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

--0000000000000a9dd706536a8e7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:21=E2=80=AFAM Bathija, Pravin <Pravin.Bathija@del=
l.com>
wrote:

>
>
>
> Internal Use - Confidential
> > -----Original Message-----
> > From: fengchengwen <fengchengwen@huawei.com>
> > Sent: Thursday, May 14, 2026 5:21 PM
> > To: Bathija, Pravin <Pravin.Bathija@dell.com>; dev@dpdk.org;
> > stephen@networkplumber.org; maxime.coquelin@redhat.com
> > Cc: thomas@monjalon.net
> > Subject: Re: [PATCH v13 1/5] vhost: add user to mailmap and define to
> vhost
> > hdr
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On 5/15/2026 6:46 AM, pravin.bathija@dell.com wrote:
> > > From: Pravin M Bathija <pravin.bathija@dell.com>
> > >
> > > - add user to mailmap file.
> > > - define a bit-field called
> > VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> > >   that depicts if the feature/capability to add/remove memory regions
> > >   is supported. This is a part of the overall support for add/remove
> > >   memory region feature in this patchset.
> > >
> > > Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> >
> > Please attach reviewed/acked-by of this commit in new version
>
> done
>

I haven't added Acked-by or Reviewed-by tags to all the patches, so why did
you add them in my name on every patch?
I haven't checked whether this was the case for the other people.

>
> >
>
>

--0000000000000a9dd706536a8e7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20,=
 2026 at 4:21=E2=80=AFAM Bathija, Pravin &lt;<a href=3D"mailto:Pravin.Bathi=
ja@dell.com">Pravin.Bathija@dell.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br>
<br>
<br>
Internal Use - Confidential<br>
&gt; -----Original Message-----<br>
&gt; From: fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" targ=
et=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
&gt; Sent: Thursday, May 14, 2026 5:21 PM<br>
&gt; To: Bathija, Pravin &lt;<a href=3D"mailto:Pravin.Bathija@dell.com" tar=
get=3D"_blank">Pravin.Bathija@dell.com</a>&gt;; <a href=3D"mailto:dev@dpdk.=
org" target=3D"_blank">dev@dpdk.org</a>;<br>
&gt; <a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephe=
n@networkplumber.org</a>; <a href=3D"mailto:maxime.coquelin@redhat.com" tar=
get=3D"_blank">maxime.coquelin@redhat.com</a><br>
&gt; Cc: <a href=3D"mailto:thomas@monjalon.net" target=3D"_blank">thomas@mo=
njalon.net</a><br>
&gt; Subject: Re: [PATCH v13 1/5] vhost: add user to mailmap and define to =
vhost<br>
&gt; hdr<br>
&gt;<br>
&gt;<br>
&gt; [EXTERNAL EMAIL]<br>
&gt;<br>
&gt; On 5/15/2026 6:46 AM, <a href=3D"mailto:pravin.bathija@dell.com" targe=
t=3D"_blank">pravin.bathija@dell.com</a> wrote:<br>
&gt; &gt; From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.=
com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; - add user to mailmap file.<br>
&gt; &gt; - define a bit-field called<br>
&gt; VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS<br>
&gt; &gt;=C2=A0 =C2=A0that depicts if the feature/capability to add/remove =
memory regions<br>
&gt; &gt;=C2=A0 =C2=A0is supported. This is a part of the overall support f=
or add/remove<br>
&gt; &gt;=C2=A0 =C2=A0memory region feature in this patchset.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bath=
ija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
&gt;<br>
&gt; Please attach reviewed/acked-by of this commit in new version<br>
<br>
done<br></blockquote><div><br></div><div>I haven&#39;t added Acked-by or Re=
viewed-by tags to all the patches, so why did you add them in my name on ev=
ery patch?</div><div>I haven&#39;t checked whether this was the case for th=
e other people.=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--0000000000000a9dd706536a8e7e--

