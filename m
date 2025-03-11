Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A20AC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 13:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26DB14027F;
	Tue, 11 Mar 2025 14:43:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AEB4840263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 14:43:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741700627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxIN0y2cHtADAxH8//9n5qzMw/awDhvxmPXa/8WYGQs=;
 b=icWT3XChImLeRQf6CPzoOTROXPgs0t9dwKmyPSCmNmow5Y3j7dEZDcmB8ewFPFfPTDQBDG
 jzSCOAuAl6d++vI/cypxkE/x1xBVw/RYhWPBfX7CqXYCcP75qwjpunt7IdgvlScfEfSyev
 FZ0B/mnmsO6ghtlFVRSEjYAez7z9dm4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-YGZA6R3ZPrGCaGYEAgYz3g-1; Tue, 11 Mar 2025 09:43:44 -0400
X-MC-Unique: YGZA6R3ZPrGCaGYEAgYz3g-1
X-Mimecast-MFC-AGG-ID: YGZA6R3ZPrGCaGYEAgYz3g_1741700623
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5499c383444so1536860e87.2
 for <dev@dpdk.org>; Tue, 11 Mar 2025 06:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700623; x=1742305423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxIN0y2cHtADAxH8//9n5qzMw/awDhvxmPXa/8WYGQs=;
 b=a2+87muZl2lb/jJKIS3R1QCBNHm7KwAZoAaFT/lVE/OE0QhOLwZ5Jo/Flp2KhrTnuG
 PKyLSidVp1cAj3Erx0UKndwzKqnrbaRowqyrs9jFJ3trBPooFmUR4r/yhn9Hzh4grn9J
 Vfi0A29BzT4l3NI+xt3q/MdNOvDNnAJ6OMcWzAnAbMKzBQZquc2ZxryWejBJ2KX2Omv6
 qW8eyYHBb27TLKNAiav9kSetMUi5TiG5HnNrY+qrKn5s9Y4kLMp+i91IIvIRYidG5kDg
 WVSObLTMMnd1GsX9gKdunSWFlsKTawIsjwfvr55p+2xGdvPmNUl+b1oPmAwSYJjxlTfm
 4xXQ==
X-Gm-Message-State: AOJu0Yy7asEiPMbEDitab60KzVkQgA0SDyNSM+mdXJCwcSVJyNiViAuZ
 xDywYTQMgcgfLAcuS8tpJSzcppKEKB3JNwws3cvoSmAgxwQBoCCCacXTkjajfWGjAOHf8lBxX2Q
 zTgwaqrjBV0jEwoqyK9YtISTPiPDAAnnmq53A4TCLFVCK5kfzUO4THyPoRo47K5StE87GO7SbZG
 bJ1MhkjuSLC84TVqE=
X-Gm-Gg: ASbGncv0SUF7TsEtH1IYDGS84crw5enxx2qiVbPDAs+R2qie98bJULppXBZKk0fBw7Q
 aNuKRNTfnUmxBREhNrY9HMNYDr0YF6rJGJovB/bqwDCW5XYVwcwCGuYmscSrRh6ZA02/HmJvRNf
 M=
X-Received: by 2002:a05:6512:3da4:b0:545:d27:e375 with SMTP id
 2adb3069b0e04-54990ec180dmr5520917e87.42.1741700623325; 
 Tue, 11 Mar 2025 06:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxRGei5kmzc3rIqx5w8DENCkNhxF8xc0qCeEdJzENOSo+R1jITG68kVi6YWSG8Ij1qfu/IiWkkl5e7O3V/LQI=
X-Received: by 2002:a05:6512:3da4:b0:545:d27:e375 with SMTP id
 2adb3069b0e04-54990ec180dmr5520908e87.42.1741700622946; Tue, 11 Mar 2025
 06:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAE4@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FAE4@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Mar 2025 14:43:31 +0100
X-Gm-Features: AQ5f1JrRV8ft0aX3J_gFhG3RlkyqV5sRWFDYrVtHCK9u3_DEGyLXtWmBu7jfuIQ
Message-ID: <CAJFAV8zNjzL3LarMQ2g2t9j9yMEEBjFhO01_tn4P33kyacUyRA@mail.gmail.com>
Subject: Re: [RFC v3 0/8] Symbol versioning and export rework
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, 
 andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1px45nIXhS0p2XCPJTQzae4GjZXWU6-f8qg13-HWtxE_1741700623
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

On Tue, Mar 11, 2025 at 11:18=E2=80=AFAM Morten Br=C3=B8rup <mb@smartshares=
ystems.com> wrote:
>
> > From: David Marchand [mailto:david.marchand@redhat.com]
> > Sent: Tuesday, 11 March 2025 10.56
> >
> > So far, each DPDK library (or driver) exposing symbols in an ABI had to
> > maintain a version.map and use some macros for symbol versioning,
> > specially crafted with the GNU linker in mind.
> >
> > This series proposes to rework the whole principle, and instead rely on
> > marking the symbol exports in the source code itself, then let it to
> > the
> > build framework to produce a version script adapted to the linker in
> > use
> > (think GNU linker vs MSVC linker).
> >
> > This greatly simplifies versioning symbols: a developer does not need
> > to
> > know anything about version.map, or that a versioned symbol must be
> > renamed with _v26, annotated with __vsym, exported in a header etc...
> >
> > Checking symbol maps becomes unnecessary since generated by the build
> > framework.
> >
> > Updating to a new ABI is just a matter of bumping the value in
> > ABI_VERSION.
> >
> >
> > Comments please.
>
> Excellent. I'm all for automating this!
>
> Feature creep:
>
> Have you thought about how this (or related automation) can possibly also=
 benefit the CI, e.g. for ABI breakage testing?
>
> Or possible benefits to (automated) documentation of versioned functions?
> Or possible benefits to remembering all versioned ABIs when writing the r=
elease notes?

Not really, this series is already touching enough code and needs in
detail reviews.
A simple ack is pointless.

I prefer focusing on just making this part right.


--=20
David Marchand

