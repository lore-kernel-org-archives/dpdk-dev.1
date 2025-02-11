Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09BDC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 09:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8CD8402CF;
	Tue, 11 Feb 2025 10:54:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6FF4340150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:54:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739267673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUhhPXtv/6NbxqIXs0OFPil2zS/kRgpr1pgCL1o6cP0=;
 b=govB+R4cZIi49jhbeGFLaDx8fOD8zyHdqB1xXJqYcg4BpQs5jqEhcsUhSDUVUXmCDVqw4E
 jdOp0fpPf9rfUGXWZnTyLKX8P6C6VdU8nCz5yBMGHwq3Oo03GQEUZ21BT9q7ishUFX90QU
 ihAFRTRA/Btp1MFsBJ6kWs0j2VeG02Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-xKbl3jjXO7KwpCQD8k1Okg-1; Tue, 11 Feb 2025 04:54:31 -0500
X-MC-Unique: xKbl3jjXO7KwpCQD8k1Okg-1
X-Mimecast-MFC-AGG-ID: xKbl3jjXO7KwpCQD8k1Okg
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-308fac358f2so2387041fa.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 01:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739267670; x=1739872470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUhhPXtv/6NbxqIXs0OFPil2zS/kRgpr1pgCL1o6cP0=;
 b=tcu8tA9cuQ+kQSQYz0KlKvl39+/hZIYL0fHegje/nU+oGOGqzO0E5jj5mjJbCdHIJd
 c/VAUDzJYa0HlpYkHcmltQtPwaeRVLdxS0TpgY7rtffFXI0q7OM9kdV3kkuI/x9g3K4l
 Vtnu70Kb/s4U9jqMqFQyzrjeVaQy6RN+yVAdeV2X9nW6tFEwCg+1FNDqCm4gPx6T+gPQ
 Ro9aylY6bW0wZ+d5PRKcjLZ46OBBDC5y1HPqEqJb4J1MARteAn6F1ocM7FUIh/lEMd+2
 szyWNirHn6K5Aaf+gY9xw0PPKVwRun0aush5TFpAT8zNU5Ssf04X/hvrzajZnDrIjAkd
 HGLQ==
X-Gm-Message-State: AOJu0YxA46JMZlHZyZWpcOTM+yq6lexBpZ2EGww2uaBoKZoC2jCB2F/o
 Cp7DR1uv3qYUKzUOFVCtZmfpEDmP2R3dLc7zpjCFz44YjyvXxJXihTefkzI625S5jNaskwIULiF
 Lq5+vkRSpEejsdPXPn8K9bCAdGBVartDtuuiGA+faXs+36SziyYNsejKyw2qOQKPCawrwxCZtM9
 bpY3tHFI4HYvxSy6o=
X-Gm-Gg: ASbGncuHxbo6pb01G+PP9ahjnc6Sgh/M63Fqv4fD7JRMfmP1isgPMhr1zBO9lTItBhF
 x2SoAHitkQ4+LLRQ17bVVqCq1TZyJ5l3XYlETbS3rN7nVj4VkM15HcXKNwBU4IeTn
X-Received: by 2002:a05:6512:3089:b0:545:f70:8aa0 with SMTP id
 2adb3069b0e04-5450f708d63mr1790332e87.33.1739267670159; 
 Tue, 11 Feb 2025 01:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQIDksm2vtCTk0eb71p2Oj9YndKlr2WG3Y+LaKOribu9yGBh5JabqqAqNvcqwBDnOkFjOXZ7j7Hf7PYd2qjEQ=
X-Received: by 2002:a05:6512:3089:b0:545:f70:8aa0 with SMTP id
 2adb3069b0e04-5450f708d63mr1790322e87.33.1739267669769; Tue, 11 Feb 2025
 01:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-5-david.marchand@redhat.com>
 <CO6PR18MB38608A210D1A7ED6477A0700B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB38608A210D1A7ED6477A0700B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 10:54:18 +0100
X-Gm-Features: AWEUYZkzgUXDEcaHj0NTqcIsFzQX19fu3r_zIpZlKp41eT7sOQKHFmLH4KauDZ4
Message-ID: <CAJFAV8zKFXFG9_HXzOToPvh1feVi8h5F2BBHDkHEN2_BuQwDVQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
To: Sunil Kumar Kori <skori@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, 
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ZA2_Xzfg83qPo1ugiri1HIL2kDRGOws7AFHdZ8bO_g_1739267670
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

On Tue, Feb 11, 2025 at 9:53=E2=80=AFAM Sunil Kumar Kori <skori@marvell.com=
> wrote:
>
> > diff --git a/lib/eal/common/eal_common_trace_ctf.c
> > b/lib/eal/common/eal_common_trace_ctf.c
> > index 6bc8bb9036..d9b307e076 100644
> > --- a/lib/eal/common/eal_common_trace_ctf.c
> > +++ b/lib/eal/common/eal_common_trace_ctf.c
> > @@ -378,6 +378,9 @@ char *trace_metadata_fixup_field(const char *field)
> >               "->",
> >               "*",
> >               " ",
> > +             "&",
> > +             "(",
> > +             ")",
> Adding brackets makes token names a bit complex. Same name is used in met=
adata
> file to dump the traces to the user. With this complex name, user might n=
ot
> understand the purpose of that information.
>
> For example, _conf_src_port_pcie_sizeof_uint64_t_ is created in metafile =
and same will be dumped. But with this
> User might not get that which information is provided.

In practice, as there is no other documentation for a trace point
arguments, a user needs to read the trace point definitions.
So it seems trivial to me to link a variable name in the trace point
emitter, and the metadata in the trace files.

>
> This is the reason; we followed the existing naming convention which is u=
ser friendly.

User friendly? I don't see how this is different with '.' and '->'.
What is missing is documentation, as nothing describes this
sanitisation in the first place (even before this series).


--=20
David Marchand

