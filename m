Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2F7C3601A
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 06:02:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0540D40156;
	Mon,  7 Apr 2025 08:02:07 +0200 (CEST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43]) by mails.dpdk.org (Postfix) with ESMTP id C751F40150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 08:02:05 +0200 (CEST)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-86d2fba8647so3821946241.0
 for <dev@dpdk.org>; Sun, 06 Apr 2025 23:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744005725; x=1744610525; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1djF7z2UUS0lxOQnvp0sFfmigHhkg+2QsoXVD0pjuVs=;
 b=UHorqLKeDtgGBYzUHXEQK8HDtiTLtProGobMSkhVmBS3flXL4Lt/xrFhfSdOPccLie
 By2Vz//rFmYtkNJ/wit6PBpLDtyV3Qo90iri0pWriEmABQkCqCBMaPW3kt5q3kk50G8j
 6AqmTIvYxi1+uI8eoYWPwxcXgjzyW3APylvnD2aU/HOzT9beG7vpIH2iIAVSmJ1URPjm
 0WS9VEK00Vn8UKwk10S+JEWPntcJDsbjiFBbzXcDUZ3B40HY1bH9oRY/eQ3O2IMbJbOR
 tKCT4R0p7G7C353B8wecmnJzTIVE8g1nzlNwXs6Pcj0qaQc5KRuXJiQ3cGdpYStPtrGh
 c5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744005725; x=1744610525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1djF7z2UUS0lxOQnvp0sFfmigHhkg+2QsoXVD0pjuVs=;
 b=sNn9EwJQ5D9A1bCmB6RU19C+xDxcwDflC3Y2WyckyToKVOR0LutVSwXJf0WysNAgX2
 IO32yIDCl/om2JuulevBq6rkP14lBRcbQYjAnIREs9Sd4Ym4r+Icxo0vsQ0hbAy+d5za
 TRrY7kPfgYbIKLs6UojfBTBN7mw8YNBEbn8uyCM2BULtrzextgrcKPWJYTqqPiolmoom
 XSyXRTzFXkOoEPckHPb4VD5dF+3kuT2warFB0YnreogwYHmhVh55JzrqDvYKDtTTwbtv
 L1O5sxgBAyVmYGySxAyc6vFCyjiVPctzGHZgC9olLcHuWHA+6TarICmsgyQ5EHjA0bZK
 XsEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8D87ocf/Jm2z5vy7C3M0aV9PkGSU/Wjq/TL75737rlWNbkMts+2Bb2fF4/c3bH4ODCdQ=@dpdk.org
X-Gm-Message-State: AOJu0YwKU758GdxPYBVsmnMBT0tNo6KRwLcyjg638hlecEOSx4g7ly4i
 ZM+LAzwwdrdq/ieTH2Yys6KZEPjBfCIELohNyXNNF8wD/kq47iTbZQstEKixM1AjUiUhAWSWefU
 mE8y6xQNbAN4KkBLyYLti8aYQvvo=
X-Gm-Gg: ASbGncv5szVn0EhpC1SlXmdDVzdL8zRzC8ujIZ1qWyuMTHuSWCoaR6ywaLLnMibQMs9
 GJky+wzRLmqfYSOj60/PHeece37+JwN5QQkOvl1N5ZaBixvR7Wm++ZzUxSvTQde39dwFFP3/mqB
 YqDzCrfW8fIZ++Zxywx07WrOoM
X-Google-Smtp-Source: AGHT+IFRHKaGXpCqKHZVrbiTHYAjFwLfACWmE1nXX6KLzo0e0ldzkMkq1QcI6SBWdnTKo8pb0OCk1Th9s1vExdVJiDE=
X-Received: by 2002:a05:6102:3e8a:b0:4c3:64bc:7d00 with SMTP id
 ada2fe7eead31-4c8637ae1dbmr5080468137.24.1744005725028; Sun, 06 Apr 2025
 23:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250401042053.3518757-2-nsaxena@marvell.com>
 <20250401071522.67cf34eb@hermes.local>
 <CAG6-93zdmJ0V=zFzj-r3GZtjEiygLpHbhE_8SW6odoocz5S-5A@mail.gmail.com>
 <PH0PR18MB40861D73C3869C46BCCB4410DEA92@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20250404082138.11549962@hermes.local>
In-Reply-To: <20250404082138.11549962@hermes.local>
From: Nitin Saxena <nsaxena16@gmail.com>
Date: Mon, 7 Apr 2025 11:31:53 +0530
X-Gm-Features: ATxdqUE8-Sz5RKYplexKB5nsuA7zdvipnH9CUPmA09NOx9iIPyYCmFY9-aiFH0A
Message-ID: <CAG6-93xN69Lzehnq3q=DpMxU11+qn-1a+q_ohhArQa+E=X8aow@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] node: add global node mbuf dynfield
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>,
 Nitin Saxena <nsaxena@marvell.com>, 
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Robin Jarry <rjarry@redhat.com>, 
 Christophe Fontaine <cfontain@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Jerin Jacob <jerinj@marvell.com>
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

Hi Stephen,

Thanks,
Nitin

On Fri, Apr 4, 2025 at 8:51=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 4 Apr 2025 08:11:07 +0000
> Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com> wrote:
>
> > > Hi Stephen,
> > >
> > > Thanks for commenting. See response inline.
> > >
> > > Regards,
> > > Nitin
> > >
> > > On Tue, Apr 1, 2025 at 7:45=E2=80=AFPM Stephen Hemminger
> > > <stephen@networkplumber.org> wrote:
> > > >
> > > > On Tue, 1 Apr 2025 09:50:46 +0530
> > > > Nitin Saxena <nsaxena@marvell.com> wrote:
> > > >
> > > > > +int rte_node_mbuf_dynfield_register(void)
> > > > > +{
> > > > > +     struct node_mbuf_dynfield_mz *f =3D NULL;
> > > > > +     const struct rte_memzone *mz =3D NULL;
> > > > > +     int dyn_offset;
> > > > > +
> > > > > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) <
> > > RTE_NODE_MBUF_DYNFIELD_SIZE);
> > > > > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> > > > > +                      RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> > > > > +
> > > > > +     mz =3D
> > > rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);
> > > >
> > > > Seems wasteful to have a whole memzone for this, the data is small.
> > > > Is there a reason it could not just be a global variable like times=
tamp.
> > > >
> > > Replaced usage of memzone with global variable in v2
> >
> > We need to use memzone to share the offset between primary and secondar=
y
> > processes I don=E2=80=99t see any other way.
>
>
> Normally secondary just uses dynamic field lookup to find the offset.

rte_node_mbuf_dynfield_register() is doing both: register_offset() +
lookup_offset()
Very first call to rte_node_mbuf_dynfield_register() actually
registers dynamic offset for the buffer. All subsequent calls returns
offset based on what was registered earlier

Since secondary process support is required, should I bring back
memzone based implementation? since global variable would not work
