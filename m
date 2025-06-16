Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3BC71157
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 02:57:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B797840292;
	Mon, 16 Jun 2025 04:57:02 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id C96024027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 04:57:00 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-32b5226e6beso11964541fa.2
 for <dev@dpdk.org>; Sun, 15 Jun 2025 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750042620; x=1750647420; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1pn+wG+OYqYMZ0vE0AKc37Gtm70QIFqhj1hA9rQa8qE=;
 b=tdgw8Ni+KDLxoHrrBfu5CZaU2QnAYow1b4+Sx7/smnS5I+lN1EIe53jN4prbwbIi1s
 pZZtBI0+rs/upp893QlsNyO7ejsiBbhpo+jU110hiMo6CC2FTE3VPPocI0EG4y3RXbd1
 nV0HL97mH8NimZZ7m7QW/PLZQDJZw6ohZl4e/gglhb6mIhvI9NjTNcNApGEhKq+1gOIf
 s1z4l1WLY6L9KpZb1ltX+22G2dah+GIzCDT6dywjN8OEf5p6AU4x1dkFdg5HUVSd5nkW
 +af575oiO/oJQh1THGXchPRI4/SVpD4rPA3HeL79Yu3+Nysx98qVhnz0iDULpbuQdtsz
 3cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750042620; x=1750647420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pn+wG+OYqYMZ0vE0AKc37Gtm70QIFqhj1hA9rQa8qE=;
 b=nk8hMvSxMzdjNAV3lfvMktYgAtCvwonI5RjTnytZn52AjtmklbhPMgr5mQz73ydVIM
 54EaTYk+eLKuxiANXTr5y4ClqWIgf091Ox92isqH/wHkWBrsomqTtBUeiUuJ6ycx8qJc
 34ZSqDKzeLh9gCMmnTqURMs4bUXmeGf6qY1WyCoV8o4tDLYkhDVO1oiKbcOl+P8rq4p9
 VerSPH0S6RF1FkAHOsRoo/zlTXWTqwaZg795TFMK7++zZmjVq7ZrmT0LmoTyjGvQaMjk
 ixJSOgv1K4bJCqMtGjDPPilleSr97f9QSpRQ73c5ODprwgvN/l7VJRCbZVuivQXb0xhj
 AU5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaCJQZRY4RcBBE3bVb19GDneyFqmDA5kAFaTPK4GdUBGwt4UOqmj4Kc4Wy86xSMNLT8MA=@dpdk.org
X-Gm-Message-State: AOJu0YxCSdn0jkEhMci9JnK6e0zGUU7/mvhkMGfP0rA8DsR5UnW0VfEp
 pVxa3+FrgJVblowyXH7sMvaLvxR1t0hI1jp/SLKil/kmIIY8TEpOdXGfLoUJTbzMbghw+5lKqlj
 Lie/fM3MxVW9AvXAz4vKAigX8mmUvTu+OH6HYhD+scw==
X-Gm-Gg: ASbGncubZ0ScFr3aCt7EdHIMbwMISO2pyOsdQpuoZPHMrsXpxQfrnXrGf1m/IJgjPNj
 tuSJlqK4zYvLwBSH7ovBzI27j2XtlfnIEuzPBJfyyxguPph0K2+58Cc8aHsYHroeQuRU7iP6myP
 bKbp1jJBn1jayQpPtvKO2bjM4hxgHQm/ILf3gnRojMFwoI+cIq
X-Google-Smtp-Source: AGHT+IGDL5QnIyzYizRjBUzT/XsnLZUGkerINnWXqjH7bvJYIRicAYhtqtRd6axMmOq9MqWB93HO9Jmz6JNf0OtdPw0=
X-Received: by 2002:a2e:bc1a:0:b0:32a:7122:58c9 with SMTP id
 38308e7fff4ca-32b4a2c301amr17360351fa.5.1750042620068; Sun, 15 Jun 2025
 19:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484068E26F01A086742F2F4D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9E0Kh115U4YbkVPOCR-65cbFb__V-+pRGFdRGoqLVYMtg@mail.gmail.com>
 <CO6PR18MB448446151350E98857F883FFD899A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HYQo7FNPggY1-m4-SMga4Sf5G3RV1AU-izZunNJzgqcQ@mail.gmail.com>
 <CO6PR18MB44849D14A16B1B5729F69746D865A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9HxKgiMgo4s9r1-PfA8+2Bp8ENduJEP+h6zOgaPKNPozA@mail.gmail.com>
 <CO6PR18MB4484BB354A2EE063C647F89CD86CA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484BB354A2EE063C647F89CD86CA@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 16 Jun 2025 10:56:48 +0800
X-Gm-Features: AX0GCFuUkMmixZovZuAErVi_IDyiXZ4BPFsbamE0nUOq0xc8n6rJhq6X09iIseU
Message-ID: <CABQgh9EXg94dopaqD-ReF51V699GZyiO7f3PzFbvK0AVsB3aQQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: "Marchand, David" <david.marchand@redhat.com>,
 Aaron Conole <aconole@redhat.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 4 Jun 2025 at 23:29, Akhil Goyal <gakhil@marvell.com> wrote:
>
>
> > On Mon, 26 May 2025 at 14:15, Akhil Goyal <gakhil@marvell.com> wrote:
> >
> > >
> > > DPDK deprecation notice need not include API changes in external libraries.
> > > We just need to notify the users about the version of ZSDA external lib is going
> > to change in next release or so.
> > > And then we can change the code.
> > >
> > > You can refer to intel-ipsec-mb. It manages compatible external library version
> > in dpdk docs.

Thanks Akhil

I just sent v2, which depends on UADK 2.9 release.
I am waiting for the 2.9 release for two weeks, but it may still need
one more week.
I am afraid it may have issues for dpdk 07 release, so send the v2 for
review first.

Thanks

> > >
> >
> > Thanks Akhil
> >
> > Will add this.
> > I am waiting for the 2.9 release, which may happen this weekend.
> >
> > diff --git a/doc/guides/rel_notes/release_25_07.rst
> > b/doc/guides/rel_notes/release_25_07.rst
> > index 0c9ec76355..138bfecd61 100644
> > --- a/doc/guides/rel_notes/release_25_07.rst
> > +++ b/doc/guides/rel_notes/release_25_07.rst
> > @@ -72,6 +72,11 @@ New Features
> >
> >    * Support matching on IPv6 frag extension header with async flow
> > template API.
> >
> > +* **Updated UADK crypto & compress driver.**
> > +
> > +  * Update to init2 interface which requires v2.9 of the UADK library.
> > +  * Update to asynchronous mode for better performance.
> > +
> >  * **Updated virtio driver.**
> >
> > Is this suitable to squash into the last patch together?
> >
> Yes, but you need to update your driver documentation also.
> You may maintain a table to specify which dpdk version is compatible with which uadk lib
>
> Check doc/guides/cryptodevs/aesni_mb.rst for reference.
