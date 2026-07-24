Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE49C531FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 08:01:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD9940658;
	Fri, 24 Jul 2026 10:01:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B27E84029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 10:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784880074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xtS+BFVf3c6jp55dzja0dVfwRcATFPHG3zXrYeaoCA=;
 b=EXurPHq3lV+iP+Q9JczfjUlpaI3jFqbY2n9usBcfqZuwDOHkmlroagaaLIb3+x6dDLl+nS
 wfiddpzErVF6ymsL7EbvMf1jJ+5gHtz2ljSu2qSM3bu18SOVcX6Rq5D7SiEetN+1IyeRIu
 RLLuRgPTiTGPtK33Pz6iNp6vtIw567Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ZikMSaTCPVeS4tbODzMJ8A-1; Fri, 24 Jul 2026 04:01:10 -0400
X-MC-Unique: ZikMSaTCPVeS4tbODzMJ8A-1
X-Mimecast-MFC-AGG-ID: ZikMSaTCPVeS4tbODzMJ8A_1784880069
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aeb55ce6adso124283e87.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 01:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784880069; x=1785484869;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/xtS+BFVf3c6jp55dzja0dVfwRcATFPHG3zXrYeaoCA=;
 b=eSGcaMS9s3QdnYYLqq2H6H/CYepqYl9y8hDg4BKH8EPgND6Ll2jCwXnN9HBUifABHv
 QOciPBTi7HHk9evzrJnam2B8UkmItw+HajnbU9c8A0PSiVHha3M8UqlK7PgL3Zltv4Lb
 KO9D8puvI0l17+AkrCSA26TfiLDbFr6vfNwuZPNyIZMm/u90wL5wrT7pdLSEKMChMZRi
 rGhwOTwa9eDHczJawG8dQa1AxEsl2+NtJvN7T5fS/Fq79ZQaLNmr9x+MbC2VmSPy7v+a
 EIGF9hkx3UdrrdCD/IN07hklN8zIalXl64WyQCRehYnE0fle5Q7CawFVR6g/QvT8woBd
 yvVQ==
X-Gm-Message-State: AOJu0Yxi/KWIhw/NY+96YJNwuomGK1BraWDssHDqscHVnfM1pEdikl3U
 gSbP5sIFJSesqzXHeuJbRrQnDmROZdtSQKhdELwKcto8LIQxO+wDOleqrEu81wt1iRIfRR2qQ3z
 rTjSSpnl6/TCvW15v9/GuWbgzgVV8DU26PSbSXDXxkCGGFQ/Rim5bkJG5hVKsN4h0+qrBwMKAHa
 snx68eeset2vv/WkVYNtU=
X-Gm-Gg: AR+sD13uNrWdf6cj7tHxrlVHSJCpbfALA1dQBAgzK5SxANR9jbVZuPoN036R332vJut
 KYZ+ChwifE1v/OHZdp746t+U9YFMw9WYtQ876eIrTlSJ8DakFghKgjdOZzCAKCC3czcEyNBJfYk
 LMPXpEgDbm0oyASxuu/SbwuqLhGA9LLCM7Fmie2TZyYyYURbjNOkTbiPXmtEVHMcTSgLqbcUMTs
 wqEsjGtB4Dc1OOTDIqw8QVYTA0EZEHz5Rf5gi+HLUzw6K64
X-Received: by 2002:a05:6512:5c3:b0:5aa:8822:c945 with SMTP id
 2adb3069b0e04-5b2b2f71a66mr998509e87.47.1784880069113; 
 Fri, 24 Jul 2026 01:01:09 -0700 (PDT)
X-Received: by 2002:a05:6512:5c3:b0:5aa:8822:c945 with SMTP id
 2adb3069b0e04-5b2b2f71a66mr998495e87.47.1784880068585; Fri, 24 Jul 2026
 01:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230719151225.1658316-1-cristian.dumitrescu@intel.com>
 <CAJFAV8x54u5zCRZdfzRe=BtxQmryuU_pEK=6CU9RBMAGyVdxOA@mail.gmail.com>
In-Reply-To: <CAJFAV8x54u5zCRZdfzRe=BtxQmryuU_pEK=6CU9RBMAGyVdxOA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 10:00:56 +0200
X-Gm-Features: AUfX_mzPcWZRzhm7Q7DgvYrtQNHwGvX0n84ivjh1-oc0SGypRSob5XP1UhadANY
Message-ID: <CAJFAV8xrQtp4QGzWYkBDBD6YcVx3u8Zx6H3+jKSw103nCxcHyQ@mail.gmail.com>
Subject: Re: [PATCH] doc: postpone deprecation of pipeline legacy API
To: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, radu.nicolau@intel.com, 
 kamalakannan.r@intel.com, harshad.suresh.narayane@intel.com, 
 Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 dpdk-techboard <techboard@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g9kWeDfmw82vZRSIV4YjQk3BKANSXq0KCuO6VJa3bao_1784880069
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

On Fri, 11 Oct 2024 at 16:32, David Marchand <david.marchand@redhat.com> wr=
ote:
>
> On Wed, Jul 19, 2023 at 5:13=E2=80=AFPM Cristian Dumitrescu
> <cristian.dumitrescu@intel.com> wrote:
> >
> > Postpone the deprecation of the legacy pipeline, table and port
> > library API and gradual stabilization of the new API.
> >
> > Signed-off-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
> > ---
> >  doc/guides/rel_notes/deprecation.rst | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> >
> > diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_note=
s/deprecation.rst
> > index fb771a0305..56ef906cdb 100644
> > --- a/doc/guides/rel_notes/deprecation.rst
> > +++ b/doc/guides/rel_notes/deprecation.rst
> > @@ -145,19 +145,16 @@ Deprecation Notices
> >    In the absence of such interest, this library will be removed in DPD=
K 23.11.
> >
> >  * pipeline: The pipeline library legacy API (functions rte_pipeline_*)
> > -  will be deprecated in DPDK 23.07 release and removed in DPDK 23.11 r=
elease.
> > -  The new pipeline library API (functions rte_swx_pipeline_*)
> > -  will gradually transition from experimental to stable status
> > -  starting with DPDK 23.07 release.
> > +  will be deprecated and subsequently removed in DPDK 24.11 release.
> > +  Before this, the new pipeline library API (functions rte_swx_pipelin=
e_*)
> > +  will gradually transition from experimental to stable status.
> >
> >  * table: The table library legacy API (functions rte_table_*)
> > -  will be deprecated in DPDK 23.07 release and removed in DPDK 23.11 r=
elease.
> > -  The new table library API (functions rte_swx_table_*)
> > -  will gradually transition from experimental to stable status
> > -  starting with DPDK 23.07 release.
> > +  will be deprecated and subsequently removed in DPDK 24.11 release.
> > +  Before this, the new table library API (functions rte_swx_table_*)
> > +  will gradually transition from experimental to stable status.
> >
> >  * port: The port library legacy API (functions rte_port_*)
> > -  will be deprecated in DPDK 23.07 release and removed in DPDK 23.11 r=
elease.
> > -  The new port library API (functions rte_swx_port_*)
> > -  will gradually transition from experimental to stable status
> > -  starting with DPDK 23.07 release.
> > +  will be deprecated and subsequently removed in DPDK 24.11 release.
> > +  Before this, the new port library API (functions rte_swx_port_*)
> > +  will gradually transition from experimental to stable status.
>
> v24.11 dev is in progress.
> Time to drop deprecated API in those libraries?

No news from 2 years.
Please work on this cleanup for 26.11.

Thanks.

--=20
David Marchand

