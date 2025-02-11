Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD63C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 09:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 278FA40156;
	Tue, 11 Feb 2025 10:53:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D97E740150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739267635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aS066P6oP3KaEwkR6PiKx8qsMp+GokcqpH6K1fm4pg=;
 b=XQi6u73gndKS2cNQjvkYmOMaWLQGjMIJoqbP7W8oGwp9oNgEt0KNKfDK0eMhOBA+L9CUD+
 jDKOLAyjNQj9qq9Yts5aJ8W+5QRUj+rDEvSW+83K1lksU7THkur9UnCxXFEjIpMZTWAZco
 2fPEMmVmuta8Kvk+e4i+MHKHG99URNc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-65gPTLt3Nj2bBJUeNyJCcg-1; Tue, 11 Feb 2025 04:53:54 -0500
X-MC-Unique: 65gPTLt3Nj2bBJUeNyJCcg-1
X-Mimecast-MFC-AGG-ID: 65gPTLt3Nj2bBJUeNyJCcg
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-308fac358f2so2385301fa.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 01:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739267632; x=1739872432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6aS066P6oP3KaEwkR6PiKx8qsMp+GokcqpH6K1fm4pg=;
 b=HfrhaEL1J8LqfDVemwverzARcWllaZB++IYvz0czeU96PlfZOGVMNVVUCDQq6Y/01b
 pvBDWa/F5JKoUGgyy0F0fqPlgIYZy8DwalB/qymZuhjT2SFr/qk5EZSrkzY53yYcQkdI
 OlBJfpYJGgAksDOOiHJdF27T1JV+K3aAXkuGODUJuPkPQIceagus71S9aH2zp+zFJ8Q8
 oU4NV0668IbdQn9XA1IpOKG5PYvb7D2wzt3gBkoPuOvzkCWYWUve1z7vv7UYfuuutLAt
 +hwpjZL9ZiujrFa1AJY2BrRk5iIg5+bOhZ0TiOD7xdfYd7xOmdjqiGflstEqS3upSv9A
 67eg==
X-Gm-Message-State: AOJu0YwZvPXefzCLOZI6qQXi73bwAidwpyohSo2Rdy7V1nleKib1EvI2
 NxyT0fEfGWeIuBzvbegzelN8rvcl9r4MDXrv5ndrSyqmd6ErvwQKaKySAAaARSezHYRFEJqNJZY
 4KBIm5n8DahZ6uwShW8uMW8ldDZvMDbXPq2xDJDTVZB8FrVAOXOyKPpnT/vo7iJfcyzIgZhQvqA
 46+x6TMNIP9yLHC0I=
X-Gm-Gg: ASbGncuNma998TnBoWFvqddr/od9ovyRoPy2JddPbX+zcyN8f02kmGBbhxSJ8z/Zhir
 rgbC33cY1Ttpn3Xgt9Ctr9OcJrCy/s+z/+ZDu4JslziluAHPZzyKoYCXxNNIHlHKy
X-Received: by 2002:a05:651c:50b:b0:308:f479:569a with SMTP id
 38308e7fff4ca-308f4795a53mr15834301fa.29.1739267632404; 
 Tue, 11 Feb 2025 01:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECIFYB8zl/3caYS3pGPrBQ61dGWjv5Uicm1pcTFjcTfhzXHRs/9ewTokp+h2I0XH7ZmCCcERuyZpg4sFZ++Ak=
X-Received: by 2002:a05:651c:50b:b0:308:f479:569a with SMTP id
 38308e7fff4ca-308f4795a53mr15834141fa.29.1739267632017; Tue, 11 Feb 2025
 01:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-3-david.marchand@redhat.com>
 <CO6PR18MB3860449F9DE83AF498DF2788B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB3860449F9DE83AF498DF2788B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 10:53:39 +0100
X-Gm-Features: AWEUYZlWYdyzo30kdgqiQ09z7zZzNr3d0Z1pt9n_eIFZMp5Cp_uEWMf_kuy_zkM
Message-ID: <CAJFAV8xLJ_0v8S-OGoJGYPmxUR3yZ7SGEbok9SSOqv5g1t9o1w@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 2/6] trace: support dereferencing arguments
To: Sunil Kumar Kori <skori@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3jWFtzvxKltv3yVGRABOukmAW8V0Fynj-EHe0s4U_t0_1739267632
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

On Tue, Feb 11, 2025 at 9:44=E2=80=AFAM Sunil Kumar Kori <skori@marvell.com=
> wrote:
>
> > diff --git a/lib/eal/common/eal_common_trace_ctf.c
> > b/lib/eal/common/eal_common_trace_ctf.c
> > index 04c4f71462..3e4228ee7f 100644
> > --- a/lib/eal/common/eal_common_trace_ctf.c
> > +++ b/lib/eal/common/eal_common_trace_ctf.c
> > @@ -373,6 +373,11 @@ rte_trace_metadata_dump(FILE *f)
> >
> >  char *trace_metadata_fixup_field(const char *field)  {
> > +     static const char * const tokens[] =3D {
> > +             ".",
> > +             "->",
> > +             "*",
> > +     };
> As this patch is intended to support dereferencing operation but as a sid=
e effect it applies to multiplication operator too.

Support for multiplication helps with the next patch too, when passing
an array size as a blob length.

> Hence for A * B, field is generated like A___B (one extra underscore). So=
 IMO, multiplication string shouldn't be used.

I am not following the consequence.. why should it be prevented?


--=20
David Marchand

