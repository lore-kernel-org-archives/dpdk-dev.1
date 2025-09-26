Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99708CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 14:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CEA640667;
	Fri, 26 Sep 2025 16:15:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 494D540664
 for <dev@dpdk.org>; Fri, 26 Sep 2025 16:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758896122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WI1OLS8nv8Z/iiOKm7IpCz1Rc0mx0fRL++4/yUBxFe8=;
 b=OJOLTngA8oQwO3WF4c7iEPis1PvCqS10OYyPDoz2UMa/Q2YHmW24T6+mlFMcLwAEdQ80ER
 Py1tsSXAa3QoLjzsaJmNdre6RvRGRsTv643TObE2+textDAbc/91QeUCTrjuBcGmDnmB0x
 yqUFhW9KDaD5yyTKeCZLmRvuqmHK8sI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-710MAyC1NOuRv-YM5IO-iw-1; Fri, 26 Sep 2025 10:15:21 -0400
X-MC-Unique: 710MAyC1NOuRv-YM5IO-iw-1
X-Mimecast-MFC-AGG-ID: 710MAyC1NOuRv-YM5IO-iw_1758896120
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-333f8ddf072so10429211fa.0
 for <dev@dpdk.org>; Fri, 26 Sep 2025 07:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758896120; x=1759500920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WI1OLS8nv8Z/iiOKm7IpCz1Rc0mx0fRL++4/yUBxFe8=;
 b=qtNTh9b7uUhqUusEKTFHxDeRGM2NHA5qH4hfW16/36Ld1d9w6NK6hiS+59Ql89jPLn
 g2Gg9P0vYD++Mo9t7vzlyLZyv41Z7hoRNihdDcqb6vy89l+Qp7zXK7IZpfUtNve9yjNU
 nVZ8WJzkGFKw7w6WVwtTUueOD1nOm44mEWTwro8CafzEb0Xox6cKs3fyEpmuu/LVCT1F
 3QVVy6INnehuWJkuxbwczyinB4mJZ6UZfAE6dxALwu3T+mbBia+UQTPchzGmlNFqoRhu
 Dfr8eGf70u8A7NqS3hWXOnBgY4+P7Jet3gztU7EKESQlmIECsoCsMWuFeC6tVV4Rddxd
 XLKg==
X-Gm-Message-State: AOJu0YwuBMz/ECAMoWiVHa9vshynmmM5r5JT1cWZ+/d4NkIzKGaspLZS
 YjMWpP3zWTxzx+vgrkG+j+0kWqeZwOW4Hb5ijx0FA15w+ZuLFCyfzW1vit7cprJ3g94hmJN2hBa
 YF79lTLyDCYrhllIQaFO3Zqyy2SZ54ttcLDuPBCPaIA0DkRtsvN8CajlsF7KozXzgtevbUtBSqU
 6BsIvtuPS+H1c5iimvk70=
X-Gm-Gg: ASbGnctSXRuxLPxq47joIQLBOY4ZX8VEW9xiOsC4+Qlec0h5Ak3Yky8nZOk3q6Lscyr
 2vOFXnJ/Cp+y/G0a6xL/KrCA2hiQPKEMoIdaqnNjrEtBujnTqdY5+VDrpvqelYt7tDEHw3BTGHP
 B+uNz+I5hoLbeL5j6AVVsmXbo=
X-Received: by 2002:a2e:bcc8:0:b0:36a:8c41:643b with SMTP id
 38308e7fff4ca-36f806f3a23mr22014161fa.43.1758896119966; 
 Fri, 26 Sep 2025 07:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwooSh8gtQs0LQZ8O8U47vEft5EoWihockrkdvPW7e9PknrByBnND5AO9HWHXEk9LceG7qu28V6xjWUcNvU1s=
X-Received: by 2002:a2e:bcc8:0:b0:36a:8c41:643b with SMTP id
 38308e7fff4ca-36f806f3a23mr22014091fa.43.1758896119455; Fri, 26 Sep 2025
 07:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250919075733.221023-1-bruce.richardson@intel.com>
 <20250923144000.13570-1-bruce.richardson@intel.com>
 <CAJFAV8ySAMbErqh_9_gy-6FK+OP+8D4vvsn1iYYNniYGBPZT7w@mail.gmail.com>
 <aNQTUBumq7jnWqh0@bricha3-mobl1.ger.corp.intel.com>
 <aNUAX43vE-_0yW6R@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNUAX43vE-_0yW6R@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 26 Sep 2025 16:15:05 +0200
X-Gm-Features: AS18NWC0yTvLmTO8X0C4YWQqWm3T3lQZl7jpDtU0g1l17uwNFcC_ROTpcm7k5uo
Message-ID: <CAJFAV8weLARkxO91fbBtYYJtNFc2LASz-ir8L1C+c-X=YAkHWw@mail.gmail.com>
Subject: Re: [PATCH v3] build: remove deprecated kmods option
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fGrUBuqBC2Q6GcSbA9NST3K_sCycafyQaKP1zk08noE_1758896120
X-Mimecast-Originator: redhat.com
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

On Thu, 25 Sept 2025 at 10:42, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Sep 24, 2025 at 04:50:40PM +0100, Bruce Richardson wrote:
> > On Wed, Sep 24, 2025 at 05:45:38PM +0200, David Marchand wrote:
> > > On Tue, 23 Sept 2025 at 16:40, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > >
> > > > The "enable_kmods" meson option was deprecated back in 2023[1], so can
> > > > now be removed from DPDK.
> > > >
> > > > [1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > Acked-by: David Marchand <david.marchand@redhat.com>
> > >
> > > I see errors coming from Intel CI that requests enable_kmod option.
> > > It needs to be fixed on Intel side so we can merge this series.
> > >
> > Yes. I've sent off a couple of hours ago a request to have that fixed in
> > our CI. I'll let you know when I hear back.
> >
> > /Bruce
>
> This has now been done, I'm told.
>
> https://mails.dpdk.org/archives/test-report/2025-September/911620.html

Then here we go.


-- 
David Marchand

