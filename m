Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F75C83F2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 08:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 579EC4021E;
	Wed, 16 Jul 2025 10:25:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DBCBE4013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 10:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752654353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DAv7Cwa2M5K4W7g85onwsd+ksTkHxVsqh+94X0pknw=;
 b=Rhn3ayVoCXkl5jxEEJ581koeVJ/MNC+QVVI1YOIqIVf/5XrlhiABZCUgELomrbTIGjhLmV
 ThvY75RaSx8v64WMBNXr39yyMspCvpwyAG1J/C19n3YEqEZQ6jMTRk7nwUtj5gg2qB50Yq
 vvVDPzHl+uW/ZtbXpA2s0yphWs8RFB0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-TxWHReB2NHGpxMjHFOreeQ-1; Wed, 16 Jul 2025 04:25:51 -0400
X-MC-Unique: TxWHReB2NHGpxMjHFOreeQ-1
X-Mimecast-MFC-AGG-ID: TxWHReB2NHGpxMjHFOreeQ_1752654350
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b3700af0fso29415501fa.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 01:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752654349; x=1753259149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DAv7Cwa2M5K4W7g85onwsd+ksTkHxVsqh+94X0pknw=;
 b=Cih5CwbvQ30Y3sgfyerwR4jQJKbjMKFq4aYiVuhVj2nGB63RAP6QHBU9dhTYcThiCH
 rDQtEBpY6VD7yxTP1ZMYqy5ObOll4YmILUDLUPxU/pnXLKp0S4XwDaKrj0mAghRggPvq
 Iad6xwkEenO9zmxYNXT/qaP/+uuJlt9hDq2mZBkKS7YS/B2rXh/ZoeT0JLtsDM1+7xcM
 dE9FVlBcUprnGP+JAuvLzVoHgZeipWrhUiTtkP4qfyc5sO4nrQ24ArUXv50g5q01bt1B
 KB8QVyrLgl66S7Al3NmS+3kkQQoQvbWcVBTPwBw8frDVKzaw2U8l/vk0W982RQbcUC3o
 hPSw==
X-Gm-Message-State: AOJu0YxZh0baUB2luZ7AMU/B7YTzxpwT80WVJnOjeNfk6+D5PDOCYVMI
 c4tFjvu4+5ay51rxgrsi6ZQDLOtN106e4Pdbgi9+aOdTPLZirDT6OwJNmqiRPgTZOINHyfLVwQT
 T6lhXZDSHbHoDA2hN2SJJFjUDMN47Ed87Vg2ZUOQCLgwhpXaKr3fNMMWvqjONNKmttQam3tB3Fe
 gSwh9yfSjHPU+Jg61Ez+I=
X-Gm-Gg: ASbGncufGpbqrJ0ZBVhOr7oQ4qNS3X/iTJE1oJ5ZgURNpZAGp62OI67M3+u4xuMbhJY
 HbMJjGfMPOmS6PKnUVWs80FulEF0bGgk5cpKbkuHaqy5vlWOH+VsD5aejRbmrV6x9dgJIAtGnhG
 6erJ+cu2HAi4ZVX1Oh3WlqsLA=
X-Received: by 2002:a2e:8a8d:0:b0:32b:3c94:992d with SMTP id
 38308e7fff4ca-3308f5e6936mr4543691fa.28.1752654349517; 
 Wed, 16 Jul 2025 01:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxoeLzdhYuVdYEpmf7iam8rpXWYB4dGpbZJyEnRuXLztF2mjSprPXbuHLPUlorvMNqcL/cD2nyBq4EV2tfydk=
X-Received: by 2002:a2e:8a8d:0:b0:32b:3c94:992d with SMTP id
 38308e7fff4ca-3308f5e6936mr4543531fa.28.1752654348965; Wed, 16 Jul 2025
 01:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-8-david.marchand@redhat.com>
 <609759a6e0cf4187a34d1a12bf9bcd59@huawei.com>
In-Reply-To: <609759a6e0cf4187a34d1a12bf9bcd59@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Jul 2025 10:25:37 +0200
X-Gm-Features: Ac12FXy64bQ0joyk_L8LX7NOGsPuBlFJYVsxQqaSIORgGAQywDH1vrn4ltYh4_E
Message-ID: <CAJFAV8x5w-tosdN4_SPR7JSLyejeuxVki-iGZCK3e8Cc60JPVw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] tailq: fix cast macro for null pointer
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Neil Horman <nhorman@tuxdriver.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ToFjcNY5K-H6-mrmHsLJVk-c7SzF3BEtDlO_7Fr5JfU_1752654350
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

On Mon, Jun 30, 2025 at 6:06=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> > -----Original Message-----
> > From: David Marchand <david.marchand@redhat.com>
> > Sent: Monday 23 June 2025 14:53
> > To: dev@dpdk.org
> > Cc: stable@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>; Tyl=
er
> > Retzlaff <roretzla@linux.microsoft.com>; Neil Horman
> > <nhorman@tuxdriver.com>
> > Subject: [PATCH v2 07/10] tailq: fix cast macro for null pointer
> >
> > Doing arithmetics with the NULL pointer is undefined.
> >
> > Caught by UBSan:
> >
> > ../app/test/test_tailq.c:111:9: runtime error:
> >       member access within null pointer of type 'struct rte_tailq_head'
> >
> > Fixes: f6b4f6c9c123 ("tailq: use a single cast macro")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  lib/eal/include/rte_tailq.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
> > index 89f7ef2134..c23df77d96 100644
> > --- a/lib/eal/include/rte_tailq.h
> > +++ b/lib/eal/include/rte_tailq.h
> > @@ -54,7 +54,7 @@ struct rte_tailq_elem {
> >   * Return the first tailq entry cast to the right struct.
> >   */
> >  #define RTE_TAILQ_CAST(tailq_entry, struct_name) \
> > -     (struct struct_name *)&(tailq_entry)->tailq_head
> > +     (tailq_entry =3D=3D NULL ? NULL : (struct struct_name *)&(tailq_e=
ntry)-
> > >tailq_head)
> >
> >  /**
> >   * Utility macro to make looking up a tailqueue for a particular struc=
t easier.
>
> First tailq_entry is missing parentheses. Also, it is worrying that we no=
w use macro argument twice. E.g. RTE_TAILQ_LOOKUP may become twice slower a=
s a result.
>
> Could we perhaps simplify the macro to `(struct struct_name *)(tailq_entr=
y)`. I tried to find or understand the reasons behind the original construc=
tion, but could not.

Thanks for the comment, it made me relookup at this code.

I realise this macro should be called with a correct object in the first pl=
ace.
Instead the lookup macro itself is the part that is undefined behavior
(wrt comment in case of an error).


--=20
David Marchand

