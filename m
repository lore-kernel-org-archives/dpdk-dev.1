Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB77C88CB9
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31F824042E;
	Mon, 11 Aug 2025 13:27:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 61D614013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:27:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0skL3mc2z6L61p;
 Mon, 11 Aug 2025 19:25:14 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
 by mail.maildlp.com (Postfix) with ESMTPS id B5F2C1404FD;
 Mon, 11 Aug 2025 19:27:48 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 13:27:48 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Mon, 11 Aug 2025 13:27:48 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Thread-Topic: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Thread-Index: AQHcCHCxZwBeQq40yUCMVd+jdHwXXrRY6BYAgAAjP4CABEUVYA==
Date: Mon, 11 Aug 2025 11:27:48 +0000
Message-ID: <64fdb8dac7904b17bc4bba5b907b16aa@huawei.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-2-bruce.richardson@intel.com>
 <2b31ddbcc8174ff89b5c4a063e55003c@huawei.com>
 <aJZW_0ZJJ34q3LFs@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aJZW_0ZJJ34q3LFs@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Friday 8 August 2025 20:59
> To: Marat Khalili <marat.khalili@huawei.com>
> Cc: dev@dpdk.org
> Subject: Re: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailma=
p

> > > +def check_mailmap(mailmap_path, _):
> > > +    """Check that mailmap entries are correctly sorted and formatted=
."""
> >
> > As noted above, it will not fail if some entries are incorrectly format=
ted.
> >
> > Also, we could probably check for duplicates.
> >
> Yes, but I will leave this for future work, as I don't believe it's a
> problem we currently have with our mailmap file.

Completely agree that we don't have to solve all problems at once, especial=
ly those that don't exist :)

> > > +    # Check if entry already exists, checking email2 only if it's sp=
ecified
> > > +    if (
> > > +        not new_entry.email2
> > > +        and any(e.name =3D=3D new_entry.name and e.email1 =3D=3D new=
_entry.email1 for e in entries)
> > > +    ) or any(
> >
> > This will usually trigger even when `not new_entry.email2`.
> >
> Can you clarify this comment? Is there something I need to fix here?

When `not new_entry.email2` and there are no entries with `name` and `email=
1` matching new entry the interpreter will execute second `any` creating an=
other iterator and running through all entries again this time looking for =
entries with `name`, `email1` and `email2` matching new entry, and never fi=
nd anything since looser condition checking only `name` and `email1` failed=
 earlier. Nothing would fail or behave differently now, it's just unnecessa=
ry work.

It's more like code smell than actual problem, so not worth another iterati=
on unless you feel like it.

> > > +    parser.add_argument("entry", nargs=3D"?", help=3D'Entry to add. =
Format: "Name <email@domain.com>"')
> >
> > Secondary email is not mentioned. Actually, if I want to add a secondar=
y email when I already have primary,
> what do I do?
> >
> You hand-edit for now! :-)
> That is something that I think we should add in future, but I'm keeping i=
t
> simple for now. [For most of the patch application that I do to my tree,
> it's only adding completely new entries to mailmap, so getting that worki=
ng
> was my primary concern]

Yeah, I understand, no problem leaving this out for now.

