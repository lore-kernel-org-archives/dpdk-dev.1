Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EADC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 14:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C571402C4;
	Tue, 18 Feb 2025 15:28:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 08D0A402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 15:28:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739888903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02yLjW+nxJ9RciE4kxxSTnvTzXa81YrEz71k13TC1Fk=;
 b=EjK6o+3LREKaSSO6Gu89P44hfVZl0LVGZuPFHAhjNzEJWmj2LOLZ6hUxIURCcq2AL6x0Sv
 OUixKFqI4lScg3qqiYJOiForerQL1vYCCGMVatspfQOUcGIrkxDiNrvoO50rXdBUt8z1CJ
 6XnaF9LBfYqNsiMNYtYAU8/pLqeAGrQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-2Tw8_DtGPS2OkHs3fFxM9g-1; Tue, 18 Feb 2025 09:28:21 -0500
X-MC-Unique: 2Tw8_DtGPS2OkHs3fFxM9g-1
X-Mimecast-MFC-AGG-ID: 2Tw8_DtGPS2OkHs3fFxM9g_1739888900
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3091fb0f087so23267051fa.2
 for <dev@dpdk.org>; Tue, 18 Feb 2025 06:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739888900; x=1740493700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02yLjW+nxJ9RciE4kxxSTnvTzXa81YrEz71k13TC1Fk=;
 b=geHnB+4SZAR7+DYQW/Rk5ouhmXG2AdwQyPwt4yZgbFMAlbUoWhNGu2h5GArOfbidtn
 4KK4Gr6RPyrJiZuAWGaNkvBlv9Ss8nl4PWSqsK0Vv77LoZUAxD56CwAQbbmZL38IGSXD
 VX3LukQ+s5cHF1J0OIxNEH/sBs1kr5HgLsl2O+eqRMaqu+fRopyZO/cGZ2I8FY7AZ7L7
 O3ZuaLVe6aU2TmlpX0h4InDiDzF1nnrLVZSI4w1NaB3H54yIaLQWaQlBSPyIPhbHAFqZ
 iDDftwU9lUw5fZ8vE1hG8MudYFHZZ5O7v44WZBDFo8KdiN0AE0FGANharlzG45YLTDYE
 11MA==
X-Gm-Message-State: AOJu0YyOHoiOYntwum5LXTUUH3DVAo6liHCOj4681CNy4nGbFJ3sqRj0
 GUeLpnzkXVReMGwchkBHduAUM8NPubeUsK7ogJ+Sa0zaLroozTvyQVpGfqZ7tLgfNuBI/QMAgEA
 EJawP68UHsqGZ7oP7lrHkLO6/y161T5sFPOB7NIzQkIR7/JrtWV8RbjTXKPdLRwS72Mgbo5N7Sn
 XjHekk2rH0PZer2YQ=
X-Gm-Gg: ASbGnctyQqF60XTx26cGsDXHilJgscLhkmFegfKhTV/D+As5/rBsfohdlCSbgj2Ohhy
 7vFftZNh7SxDc403yabnbPBtvBdY6znV0PtmBPeFGDxyAQTnvjZDPUyxbV6rANlon
X-Received: by 2002:a05:6512:6ce:b0:540:3561:969d with SMTP id
 2adb3069b0e04-5452fe8f8b0mr5331067e87.49.1739888900354; 
 Tue, 18 Feb 2025 06:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbI9oaRiDXmKq/9fpijc9jK7moL8n1fKX9dMQHq/z0fDgT1Ube8WieMNtQmJxCQFhw2KpmdnJ9oXfBpNZIcfU=
X-Received: by 2002:a05:6512:6ce:b0:540:3561:969d with SMTP id
 2adb3069b0e04-5452fe8f8b0mr5331051e87.49.1739888899922; Tue, 18 Feb 2025
 06:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-5-david.marchand@redhat.com>
 <CO6PR18MB38608A210D1A7ED6477A0700B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CAJFAV8zKFXFG9_HXzOToPvh1feVi8h5F2BBHDkHEN2_BuQwDVQ@mail.gmail.com>
 <CO6PR18MB386067633D5066F40955C023B4FC2@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB386067633D5066F40955C023B4FC2@CO6PR18MB3860.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 18 Feb 2025 15:28:07 +0100
X-Gm-Features: AWEUYZm006tbbg4ICZ6BXrMBec6OvXU8qxXgkz4AS3c3Vx9Fslmc8sR5iw2KvoU
Message-ID: <CAJFAV8zLcY=XcyKHhrknedhbwUZ8Hs2_XzxpkmTmuVj-Z4XF4Q@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
To: Sunil Kumar Kori <skori@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AsvMQndhhg9q9T4wY7UjrGv7UCrgX3rRhYH8gN9Tj7E_1739888900
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

On Wed, Feb 12, 2025 at 6:14=E2=80=AFAM Sunil Kumar Kori <skori@marvell.com=
> wrote:
>
> > On Tue, Feb 11, 2025 at 9:53=E2=80=AFAM Sunil Kumar Kori <skori@marvell=
.com>
> > wrote:
> > >
> > > > diff --git a/lib/eal/common/eal_common_trace_ctf.c
> > > > b/lib/eal/common/eal_common_trace_ctf.c
> > > > index 6bc8bb9036..d9b307e076 100644
> > > > --- a/lib/eal/common/eal_common_trace_ctf.c
> > > > +++ b/lib/eal/common/eal_common_trace_ctf.c
> > > > @@ -378,6 +378,9 @@ char *trace_metadata_fixup_field(const char
> > *field)
> > > >               "->",
> > > >               "*",
> > > >               " ",
> > > > +             "&",
> > > > +             "(",
> > > > +             ")",
> > > Adding brackets makes token names a bit complex. Same name is used in
> > > metadata file to dump the traces to the user. With this complex name,
> > > user might not understand the purpose of that information.
> > >
> > > For example, _conf_src_port_pcie_sizeof_uint64_t_ is created in
> > > metafile and same will be dumped. But with this User might not get th=
at
> > which information is provided.
> >
> > In practice, as there is no other documentation for a trace point argum=
ents, a
> > user needs to read the trace point definitions.
> > So it seems trivial to me to link a variable name in the trace point em=
itter, and
> > the metadata in the trace files.
> >
> > >
> > > This is the reason; we followed the existing naming convention which =
is user
> > friendly.
> >
> > User friendly? I don't see how this is different with '.' and '->'.
> In general, structure fields are given a proper name to represent the pur=
pose.
> When we use it directly in trace point using '.' or '->' then it remains =
a meaningful name.
> Adding more tokens in name, is making them complex and deviating from the=
re meaning.
>
> I am not saying that the mentioned support should not be there. I am just=
 trying to convey
> that If it is possible to make meaningful names, then that will be more h=
elpful.

Hard to preserve such information given the limitations of the C
parser (which seems to apply to the CTF format).
I still think that interpretation of the metadata in the traces
require looking at the source code, which means that the "readability"
objection is weak.

Jerin, opinion please.


--=20
David Marchand

