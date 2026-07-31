Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EACC54F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E56C64067D;
	Fri, 31 Jul 2026 09:28:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D542740288
 for <dev@dpdk.org>; Fri, 31 Jul 2026 09:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785482919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zk8+CyPW3k+x6jtykvL42mgXfgG6IxX7QO2Di1ZnlpM=;
 b=bHgUwgYhQVijxYKmUvbHXj38ep38MZ0YCTfW0ZLoosvz1/dn9PaApPfTz16T5xqqiigiUK
 OYuWybIpgULWdN4+bZlqvsD02HoRCIOuHzNSR1acLQu+O5v/favazFu1aJO/mR4juRCq7m
 x7acnQz+Se05tAMmPOdQURLkVSQhjUA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-uZ8pKWCEMoaMtCOK2TpTqQ-1; Fri, 31 Jul 2026 03:28:37 -0400
X-MC-Unique: uZ8pKWCEMoaMtCOK2TpTqQ-1
X-Mimecast-MFC-AGG-ID: uZ8pKWCEMoaMtCOK2TpTqQ_1785482916
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b2a24ae6deso394520e87.0
 for <dev@dpdk.org>; Fri, 31 Jul 2026 00:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482916; x=1786087716;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zk8+CyPW3k+x6jtykvL42mgXfgG6IxX7QO2Di1ZnlpM=;
 b=EuBC311VlpskFuW9B0Bk7fML3MVzkc3uvsl8gma+hBchkBUCNoxKwjz/RjEHRq2JxX
 jVkPaoJWMQ9JxLHCQBuJbFMY9SD5MD2qVh2dHklAIo06Ob7vmkzLOe3Tqaw7q4poDv20
 r5ZZEkRG3WOPN2Hn5rXhnY+Yk+Q+zdOKTXzORlMdpD+71XcuDrpViwhwV6SqVIxHr0ds
 FKaXiXXqpy+Pj3p0gmCnAwHmH/5gz/qdmKzRGZsF7IlcS4HKxU5nSgwxaiAkV182mVf1
 1DXc452wcBEhWBChMDv2dpTuN8enZu77bxn9btsi5FySJ+OfZygp3m8WEAWh/WEaD7Ug
 IKEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/QhH69vUmE2+SGHtFuLKN8BxFAmiooGeXRa7eOa6MSSUZ+BVvIGxGlYbnuT9wj/H6a+U=@dpdk.org
X-Gm-Message-State: AOJu0Yz5XT8voOTJg897lFD4Uw+SUP9+HUWlV7uT7+ce3mgmdxMhqfVi
 7Oqgzk0y5e8vNupPplxDK1qVjcxLY1WMtmoeAkmvVxpGy7q9KNKZZns4XkXJrsTbz90uy06FFtd
 H0HvN3PO2Rr8ynSD2s4bYyhXDEdBW6BOs42+elqmvHO7TOjW7Nt6HJP5gPYsjOQ8PD85l3GdOES
 yHVT5ccAgiwK3UYVr+AKU=
X-Gm-Gg: AR+sD12SeDfLhPGcyyNN8TPZgiZBiQV7b94Fw6SYjTppv519qJIuF1kOOEE6XNQ3fPE
 5c9uLvvz2yGQhcjjvAGBMOTsxa5f2m6dkpzBV90rvc2J+xNJ31Tg1B44KycG8pd2kWlPsFGOMJY
 Y1wnqbJGoui6KuxrMAqe2WUcbOV3K2GF6uaMVDOD23ZB5PJ0AYcVea7jqNfdOnSELCliT8bfeMd
 BCRUCvUXz0mwmevzeOx78TUM6de3fDClPX2TO95TxBaQpcv
X-Received: by 2002:a05:6512:a93:b0:5ae:c3c1:822a with SMTP id
 2adb3069b0e04-5b2e1fff9c2mr275764e87.58.1785482915956; 
 Fri, 31 Jul 2026 00:28:35 -0700 (PDT)
X-Received: by 2002:a05:6512:a93:b0:5ae:c3c1:822a with SMTP id
 2adb3069b0e04-5b2e1fff9c2mr275757e87.58.1785482915419; Fri, 31 Jul 2026
 00:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
 <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
In-Reply-To: <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 31 Jul 2026 09:28:23 +0200
X-Gm-Features: AUfX_mz5-g_sl6haDaZJnwz0RgSJguRqDuitZ4ad2m1eDJKCRY1AheAsN53qZd8
Message-ID: <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "stable@dpdk.org" <stable@dpdk.org>, 
 "thomas@monjalon.net" <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W28nOAaDiS4U1MVRuiFNgrr7U2pXsPE4rpMsSdoSNRg_1785482916
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 31 Jul 2026 at 09:08, Bathija, Pravin <Pravin.Bathija@dell.com> wro=
te:
> Internal Use - Confidential

It is not.

> > -----Original Message-----
> > From: David Marchand <david.marchand@redhat.com>
> > Sent: Thursday, July 30, 2026 11:22 PM
> > To: Bathija, Pravin <Pravin.Bathija@dell.com>; stephen@networkplumber.o=
rg
> > Cc: dev@dpdk.org; maxime.coquelin@redhat.com;
> > fengchengwen@huawei.com; stable@dpdk.org; thomas@monjalon.net
> > Subject: Re: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_=
REG
> > msg
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Fri, 31 Jul 2026 at 05:14, <pravin.bathija@dell.com> wrote:
> > >
> > > From: Pravin M Bathija <pravin.bathija@dell.com>
> > >
> > > The vhost-user specification (vhost-user.rst) states that no file
> > > descriptors SHOULD be passed with VHOST_USER_REM_MEM_REG.
> > However, it
> > > also says: "For compatibility with existing incorrect implementations=
,
> > > the back-end MAY accept messages with one file descriptor.  If a file
> > > descriptor is passed, the back-end MUST close it without using it
> > > otherwise."
> > >
> > > Some front-ends, notably libblkio, reuse the same message-building
> > > helper for both ADD_MEM_REG and REM_MEM_REG and unconditionally
> > attach
> > > the mapping fd.  The previous implementation rejected any REM_MEM_REG
> > > carrying a file descriptor with the error:
> > >
> > >         expect 0 FDs for request VHOST_USER_REM_MEM_REG, received 1
> > >
> > > This broke teardown and memory region hot-swap with these front-ends.
> > >
> > > To reproduce, run any libblkio (v1.5.0) application using the
> > > virtio-blk-vhost-user driver against a DPDK vhost back-end.  The
> > > connection is dropped during cleanup or whenever a memory region is
> > > unmapped and remapped.
> >
> > Is libblkio fixed now?
> >
> > I am not a fan of such compatibility fix, having to accept one buggy cl=
ient...
> >
>
> Yes, the libblkio fix is ready and will be submitted upstream within a da=
y or so.
> It stops sending the fd with REM_MEM_REG.
>
> That said, this DPDK fix stands on its own regardless of libblkio. The vh=
ost-user
> specification explicitly anticipates this situation and requires back-end=
s to handle it:
>
> "For compatibility with existing incorrect implementations, the back-end =
MAY accept messages
> with one file descriptor. If a file descriptor is passed, the back-end MU=
ST close it without
> using it otherwise."

Well, yes, I understand the specification was updated or written for a
buggy client :-)


> While the immediate motivation was libblkio, the spec's compatibility cla=
use was written for
> exactly this situation =E2=80=94 any front-end could make the same mistak=
e. QEMU's libvhost-user
> reference implementation already tolerates it (see vu_rem_mem_reg).

Which does not change that I dislike such compat.


> The fix is 2 lines with no downside: accept the message, close the fd. Re=
jecting it drops the
> connection entirely, which is a disproportionate response to a harmless e=
xtra fd.

Leaving behind a "harmless extra fd" causes exhaustion of a process FD.
At least, CVE-2019-14818 and CVE-2020-10726 come to mind.

So strictly speaking, rejecting is really not disproportionate.


For now, drop the wrong RN update.


--=20
David Marchand

