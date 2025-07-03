Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA3AC83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 14:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E40514064E;
	Thu,  3 Jul 2025 16:28:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 90E6340267
 for <dev@dpdk.org>; Thu,  3 Jul 2025 16:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751552889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnS7FHnB67+5iepYi/v//JGF4u49bm31aZEEkoIs0ww=;
 b=YPzjeQIXVETZ/AuPZRK+gr0K7M5hv+n+I+aHIwtuPIm8B6HKb/pj3r+HflvohZxIcCY9RQ
 5OuZxCb+p1uzWN6glLujgryZUn4II5dhDR7WA8lUzk9qj3Etd8k7BAxVvGwY56iAI7ZS0L
 wQ0r60CcHfbtIrcaElj6oc4a6G1Thzk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-recr3_WMNEGRYHM5_hQlkA-1; Thu, 03 Jul 2025 10:28:08 -0400
X-MC-Unique: recr3_WMNEGRYHM5_hQlkA-1
X-Mimecast-MFC-AGG-ID: recr3_WMNEGRYHM5_hQlkA_1751552887
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553b70a3592so3999326e87.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 07:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751552887; x=1752157687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnS7FHnB67+5iepYi/v//JGF4u49bm31aZEEkoIs0ww=;
 b=ewsy09WDh8/tWOuwe5sHwZOiCmQSzsLh83+vpyhzWx3QAoIqZiN8RQJSsZ1+yxGAic
 Cp72LK6jaSoTY8QAP3mMSfm16eYEkypG46PyVG1x9BWpmd7g620JUqpkEGfualOkaMQy
 mxygDjZs1j7hvyEpVDGkCriTHGRw9o5Ny0pUT+QnZQ/eXUOXalLwD5uiVTWqj9V4sw8o
 TRpF5mg+G+QTd+VftCMeedHE5/a2xtnm1pfd5R/SHqvEDJRnpR3wXWCmIeITBdNU72rv
 4qMTu75b9HgxM7TAKnMa2YheoIiEi/8H4u/pRzvuBuRAaxEvK0nsLb1x58TBPmrGk0Zf
 osAg==
X-Gm-Message-State: AOJu0Yya/FaurT3iDkXN9Ni2wjL6bX4vI8sRtQq9PnuhiJnzRgdk6Wrj
 x7jWio4QJGQyCajDnHGJWHxR6bK+Mp8DRX2VGkv19uRM3FQeqQ1O3TA6fyY7qFuUdDnt5RbvBz3
 eCXksgmpPWtpmBgu47OqeJMdT04bWAS1gL8w965Bnc5CaQSkkYN1LQzZERpwo1IBvfIHgzWTCm+
 Lbl/9eaOeduno9h3QxCYQ=
X-Gm-Gg: ASbGnct+51ou2cBDg126DtqnpHJU/Ir0owaLy9mMipbKxmQIlyyoFslLuZpfEZr6OzL
 S2LR9rmbl0K8y69ieiz95CfgcIJ+dwudLMtkC/xVLe/50LLPF3SzaKhXBhTNOuG3m//JyEUEe4D
 eVqmg1kQ==
X-Received: by 2002:a05:6512:3185:b0:553:aa2d:1af5 with SMTP id
 2adb3069b0e04-5562ee1feeamr1327472e87.8.1751552886994; 
 Thu, 03 Jul 2025 07:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvAmXdv14Cd01fUP/wjsOZTIkudS4aByRxkxZCrYuc07nrX7uPE6TEyNcCVomUUj14txKb+tErHuhp/s8/LtA=
X-Received: by 2002:a05:6512:3185:b0:553:aa2d:1af5 with SMTP id
 2adb3069b0e04-5562ee1feeamr1327464e87.8.1751552886482; Thu, 03 Jul 2025
 07:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-5-david.marchand@redhat.com>
 <dc88c2152e8e4cfbb55c91d99655661d@huawei.com>
In-Reply-To: <dc88c2152e8e4cfbb55c91d99655661d@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 16:27:53 +0200
X-Gm-Features: Ac12FXwc5HWwD5fWPGyLK6v16YIB4ypf3E-m9XhqYZKlpLFqvevcOb7mbjbB-hM
Message-ID: <CAJFAV8x296rJBOr+5YXjLPvZRRhiVsoUyCXhUHVSshvnAkNmHw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] eal: fix plugin dir walk
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Timothy Redaelli <tredaelli@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yOwWxB9s8VCbnmgZ1Fx4VlmJ1ollNgjBjepyUymOXl8_1751552887
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

On Wed, Jun 25, 2025 at 10:43=E2=80=AFAM Marat Khalili <marat.khalili@huawe=
i.com> wrote:
>
> Thank you for doing this.
>
> > +static bool
> > +ends_with(const char *str, size_t str_len, const char *tail)
>
> I too think we should have a general ends_with, I for one had to code one=
 just this week. However, I do not think it should support non-null-termina=
ted strings.
>
> > +{
> > +     size_t tail_len =3D strlen(tail);
> > +
> > +     return str_len >=3D tail_len && strncmp(&str[str_len - tail_len],=
 tail,
> > tail_len) =3D=3D 0;
> > +}
>
> Note that when str is not null-terminated and both str_len and tail_len a=
re zeroes &str[str_len - tail_len] will dereference one character after the=
 end before taking a reference to it again, which would be a UB. (Won't hap=
pen in your case of course since your tail is always non-empty, but may hap=
pen if this function is moved into a general-use library.)

As a generic helper, it would be worth to make it more robust.
Though here, as a fix, I would avoid adding a helper so the backport
can be done without adding a new API.


>
> > @@ -417,13 +425,12 @@ eal_plugindir_init(const char *path)
> >       }
> >
> >       while ((dent =3D readdir(d)) !=3D NULL) {
> > +             size_t nlen =3D strnlen(dent->d_name, sizeof(dent->d_name=
));
> >               struct stat sb;
> > -             int nlen =3D strnlen(dent->d_name, sizeof(dent->d_name));
> >
> >               /* check if name ends in .so or .so.ABI_VERSION */
> > -             if (strcmp(&dent->d_name[nlen - 3], ".so") !=3D 0 &&
> > -                 strcmp(&dent->d_name[nlen - 4 - strlen(ABI_VERSION)],
> > -                        ".so."ABI_VERSION) !=3D 0)
> > +             if (!ends_with(dent->d_name, nlen, ".so") &&
> > +                             !ends_with(dent->d_name, nlen, ".so."ABI_=
VERSION))
> >                       continue;
>
> I do not think we should try to handle the non-null-terminated dent->d_na=
me case here, I'd just delete nlen and everything related to it. To be supe=
r-defensive we could add a check that `memchr(dent->d_name, 0, sizeof(dent-=
>d_name)) !=3D NULL`, but I don't think it's needed.
>

Mm, good point.
I did not reevaluate this part of the code, but it is indeed odd
trying to protect against a non null terminated dent->d_name here.

https://pubs.opengroup.org/onlinepubs/007904875/basedefs/dirent.h.html
"""
The character array d_name is of unspecified size, but the number of
bytes preceding the terminating null byte shall not exceed {NAME_MAX}.
"""

I'll rework this local helper so it assumes null terminated strings.


--=20
David Marchand

