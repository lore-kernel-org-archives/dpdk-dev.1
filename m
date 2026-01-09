Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E7D26D6F
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 17:23:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F004F4028E;
	Fri,  9 Jan 2026 18:23:31 +0100 (CET)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42]) by mails.dpdk.org (Postfix) with ESMTP id ABA9F400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 18:23:30 +0100 (CET)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-5eea75115ceso1050571137.1
 for <dev@dpdk.org>; Fri, 09 Jan 2026 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767979410; x=1768584210; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uC0/TO7OKUHiPRuAdNzKLyOHBwgCXdHu4eAKpR5lSwU=;
 b=OQAc3ROggRS0IQfEwslCYSqZ65obwwvTTMbf85hsJ3rTfAf4Fd0QZvSP8UEfBmhgEW
 CodyEAPAuPgUrX36p2cKoFcouqOxN1N0bCAwVIM5giZgyT+OGtUZWs4lXLfWSu3hkOmA
 Op//H2Ad97sIu/VxfgINgXQgupPuhzdYdW3/O79IlwdbtiQ/iytQZKNvKDaC7qk0k5x6
 NtBjXk1GkVqDVOFYlVl3QFfnCb8fBAN5G+Pm/bVOJ/EK3SVaTvPHTasdG4m0G4s+D5+K
 DTD5nDBapQJ01BHKNutKsGhEVHTCPkLpIREXQTj27vitZCFMNRr0NnvPzBs7QI5PtiVW
 QOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767979410; x=1768584210;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uC0/TO7OKUHiPRuAdNzKLyOHBwgCXdHu4eAKpR5lSwU=;
 b=N3sxQ+ox/uyioH4PWHcJ+wMLI+wLkkSXNoe1EtasVDE9z3tiXI0eiF+TMKCvro7ggy
 G/y06jga/f7FF7a7sKndm6g+nbjLxfCWKA4jAzGL8VRek0zC+OGiAHJEhotxflaSbQzg
 YRBlVFEfywO1JNCrY3p1ztQn4U556V5FdFh4hTnufGSv6nGGxp12f2RTWxaqC2QomKnp
 8V0nui9zrpn0WUe90oSNo86QztOdzP+tYpLQxAvq7KrEU/2L/ky4HOvM3Q17DhXEMYYb
 EYvh1UUcKislLho2Wmx2FhEiMvTjFnXbyNnjv4Lou5VBfLlntqanFzBym2KwiDpqHMz7
 kNfA==
X-Gm-Message-State: AOJu0YwfpaZjYsS3gJk5ILQm0r4KypijNpxpTC1T1QI8TgZSEofEvbnS
 H2mPXfuVSbvCDXeqK4cLMPX8/0FiRsxz9Txr1ISaK5uGdFoiom3Ltgy14oI5wDf4xqnGBedGRuB
 +XVrk7ceJcfvT5OBdU6/+pbTtWDBEiEnPdg==
X-Gm-Gg: AY/fxX4YJfavTXhLDPfXlMrhlxSFW6LiT3eMbN07X0Hb8ZvmZ/GrnmAA6YfMS5Qbspj
 Bz5qJDwm7DYAd12bPG42wRchQr/dHSwYbSO3OQNC1UJiDJ2kYDKqi2oyJ6Q+1H2kuQ6lUFdDj6C
 jTFbYCa7uqNZC06LbHN5TLmHhZaHpILj26RkfmmngH4gJ8Vh1TSqVt/U54+aQPq5j447qb8y75n
 xvA9HpW+Zccying5xAxSBJ7Nhs7IEYny+fdKfIgAjxhqJ7jAwXvfSwWeEYEhrBhzK/+XWUK4lro
 zH1C4VX2Uf6Okf8QeofyBdSIad0=
X-Google-Smtp-Source: AGHT+IGePvOvrTMN1j7Gdr+ZfDR2ItNR8fPbUb9eQQyivK66L0eJcHEA+wdDb+n8jlWeaZjOMu7T49Hbe0f8123N1Ks=
X-Received: by 2002:a05:6102:38d4:b0:5d6:a6c:2458 with SMTP id
 ada2fe7eead31-5ec8b9b39c0mr3999477137.9.1767979409860; Fri, 09 Jan 2026
 09:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65638@smartserver.smartshare.dk>
 <CAFn2buDULHpj-5m1TXEcp0xUfMpTA9dKqEuEC98UhDp4qW21og@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6563C@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6563C@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 12:23:19 -0500
X-Gm-Features: AZwV_QjEPvhHGwzOHhYc5MS3Ho2DIxx02dv16OyO5nrn_Y9vCD90jrPpjojKivg
Message-ID: <CAFn2buBgTOGRg9wGjqvxVQTMXO=iddZqeZbwBrh-o9JHxbeQ7g@mail.gmail.com>
Subject: Re: [PATCH v11] net: optimize raw checksum computation
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
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

On Fri, Jan 9, 2026 at 10:58=E2=80=AFAM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> > From: Scott Mitchell [mailto:scott.k.mitch1@gmail.com]
> > Sent: Friday, 9 January 2026 16.27
> >
> > On Fri, Jan 9, 2026 at 4:26=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshar=
esystems.com>
> > wrote:
> > >
> > > > Changes in v8:
> > > > - __rte_raw_cksum: use native pointer arithmetic instead of
> > RTE_PTR_ADD
> > > >   to avoid incorrect results with -O3 for UDP checksums. Also
> > improves
> > > >   performance due to less assembly generated with Clang.
> > >
> > > Personally, I also have observed GCC's optimizer behave as if it
> > loses some contextual information when using RTE_PTR_ADD, and thus
> > emitting less optimal code.
> > > I didn't look further into it, and thus have no data or examples to
> > back up the claim. Which is why I haven't started a discussion about
> > discouraging the use of RTE_PTR_ADD.
> > > In other words: I support this change.
> >
> > Sounds good! I observed ~600 (dpdk ptr macros) vs ~500 (native c ptr
> > operations) TSC cycles/block in cksum_perf_autotest.
>
> That is a significant performance degradation caused by the RTE_PTR_ADD()=
 macros. We really should look into that - some day. ;-)
> Our application code base has RTE_CONST_PTR_ADD/SUB() for type consistenc=
y reasons (not for performance reasons). But I haven't gotten around to sub=
mitting them to the DPDK project yet.
> I wonder if the implicit stripping of "const" when using the RTE_PTR_ADD(=
) macros makes the difference, or if the difference stems from other optimi=
zer context getting lost.
>
> >
> > >
> > > >       /* if length is odd, keeping it byte order independent */
> > > > -     if (unlikely(len % 2)) {
> > > > +     if (len & 1) {
> > > >               uint16_t left =3D 0;
> > > > -
> > > >               memcpy(&left, end, 1);
> > > >               sum +=3D left;
> > > >       }
> > >
> > > Changing "len % 2" to "len & 1" made sense for consistency in
> > previous versions handling 32/16/8/4/2-byte chunks before this 1-byte
> > chunk; now it makes no difference, so consider not changing this part
> > at all.
> > > Under all circumstances, don't remove the unlikely() for handling odd
> > length in __rte_raw_cksum(). The vast majority of packets (and partial
> > packets, e.g. headers) being checksummed are even length.
> > >
> >
> > Sounds good. I will restore the original.
> >
> > The use case that motivated these changes was software interfaces
> > (veth)
> > with encapsulation requiring software checksum on inner IPv4 payloads,
> > where lengths may be odd/even.
>
> You might want to mention the use case in the cover letter or patch descr=
iption.
> Having a real use case often helps getting a patch accepted, especially f=
or optimization patches.
>

Will do. Big win for this patch is enabling vectorization on clang
which doesn't require the changes to the last byte.

> > However, I agree that header checksums
> > with even lengths are the more common case and unlikely() is
> > appropriate.
>
> In my experience (and based on statistics from our appliances deployed), =
internet traffic is dominated by "max size" (1500 byte or QUIC "safe max" s=
omewhat below 1500 byte) packets and empty TCP ACK packets, which are even =
size.
> So I also consider the unlikely()applicable to "real life" traffic on the=
 internet.
> Although it's not in the order of magnitude many people advocate should b=
e a requirement for unlikely().
>

1.5k internet common-case makes sense. We have use cases using jumbo frames
where non-full-frames aren't uncommon.
