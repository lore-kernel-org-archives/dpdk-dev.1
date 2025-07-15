Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB19C83F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 11:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 777E0402D3;
	Tue, 15 Jul 2025 13:57:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B42C44028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 13:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752580663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcK/mgZtID6CAfrmSyCEJJwclrJdkC/OmPjWs8KbwWs=;
 b=i/+R7S4TzWdmk9/z+GpDLW5TfRO6AtG32stvsy8TGQ+413hpkKokp2UMLODfVElmp8WzTI
 Xuv5JR1aLXQn4moQ7noiwG+ESF2pDa5v44nb1W9LMgojlxXcoEXCbnm0kbRvxXWxK8gkXT
 sFtqBGDYNd44oQE737roGrN6W6QQEtA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-RsHN3hDjN1eIQ3jhV35o2g-1; Tue, 15 Jul 2025 07:57:41 -0400
X-MC-Unique: RsHN3hDjN1eIQ3jhV35o2g-1
X-Mimecast-MFC-AGG-ID: RsHN3hDjN1eIQ3jhV35o2g_1752580660
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b78b5a8fcso22774751fa.1
 for <dev@dpdk.org>; Tue, 15 Jul 2025 04:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752580660; x=1753185460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcK/mgZtID6CAfrmSyCEJJwclrJdkC/OmPjWs8KbwWs=;
 b=UpYbCLD12kFEHxhbpJvRWKb3eiA8oRhcQjrha2IHaQSDI9IZa3ttN1K9zdFEsejm5c
 ckOfOweHer5eMcv2C/MXuT3x2hlDJSoUGaE/57KGlFCqYzQklSPt0fPhCm1RyCQJvAi1
 7f6pOM/7nw287UhDKdmposNunEDPf84uFZQvj7zoOarXr4UYa8AZg6/x2w93CxSbxCQ3
 i0VkOftsTVWteCaH3JJOBPs5wdt2IE15XDS2MHf2v5VeJj+H8skYRmMWJ/dq04BMkajY
 STTCySuWFjbIZuTHGymqsmONcwwIz4a1b6sA05v8a/z8AdQ0NjtJIZfu1XOPtcJ5/Jrq
 LqOA==
X-Gm-Message-State: AOJu0YzmTfbWhRxPexI5djbQK6mQVtD+jcaDf9siYpenkAgqaDP3rWqh
 L2EWuF8AB1fwXT3+8p5ffo7ypDDGoNx+EXQalexH3WUEMHI1STmn1CTCGzG27sv/sSSu0cYFVnp
 R+RqbcNiKTu7R8I3V+OUwETqT+YDRoIhqzSisubTk/Exaxx6f2/2/nfmJwZDT4x3vr3WT0uFT8H
 MAFNpl8ViFLpHHduADD6c=
X-Gm-Gg: ASbGncu2sMqkqCz+0t9VUAa5gM8yF2ZqJeO+TPWahASsMGgEl6g/O/tIKgpm7AINti+
 4Y6Vxlk353umLReArnfTq9qSkc2XyyMGvO1k4ZQtjn9GMjkHfD0Y9SSPfQOTNaRuvvCSiJ4AJfI
 Nwsjup4MfA+br+jdqgKEhIzCM=
X-Received: by 2002:a05:651c:111b:b0:32a:6b23:d3cc with SMTP id
 38308e7fff4ca-3305341163emr53823791fa.25.1752580659954; 
 Tue, 15 Jul 2025 04:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvCfoDtZ3+cCMd9yF0ifL10ggMZ9lg0A1wwT8pZwWauIr0sjQDnQiTvwLga0S10joicvLHKg+92bhkzCV/gBQ=
X-Received: by 2002:a05:651c:111b:b0:32a:6b23:d3cc with SMTP id
 38308e7fff4ca-3305341163emr53823701fa.25.1752580659525; Tue, 15 Jul 2025
 04:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
 <70c7ba78c4324495bfd317e38e926958@huawei.com>
 <CAJFAV8zAz27vKfA_zry8h6oJYA-kKTpOyzTpt-_PCMTvKmL_WA@mail.gmail.com>
 <ab72d9487cfa40ce94e27f6f067278c6@huawei.com>
In-Reply-To: <ab72d9487cfa40ce94e27f6f067278c6@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Jul 2025 13:57:28 +0200
X-Gm-Features: Ac12FXzmxcgHNE4eHQYotW579qIEuQd0up0PNJQiMQtUEzN4WaRukDw_6Yfo-Dg
Message-ID: <CAJFAV8xGBHUHD7MEymHJ4yovZUwiTGeZAoGPrZEJNtCvJ=h=Sg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 John McNamara <john.mcnamara@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JBECX2xqnmqD636XqLBnHU11SDWVWK-pWYX8vfW-QLM_1752580660
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

On Tue, Jul 8, 2025 at 7:58=E2=80=AFPM Konstantin Ananyev
<konstantin.ananyev@huawei.com> wrote:
> > > Just wonder do you guys consider it as a real one?
> > > AFAIK, all architectures that we care about do support unaligned load=
 for 32-bit integers.
> >
> > Well this is undefined behavior, regardless of what the architecture su=
pport.
> > And the compiler may end up generating wrong code.
>
> Probably, though AFAIK, we do have a lot of code that load 32-bit values =
from possibly
> non-aligned addresses (nearly all packet parsing does that).
> I wonder why it only complained only about that one?

Probably because unit tests coverage is (too) small.


> BTW, would our 'unaligned_uint32_t' type help here?

Since most DPDK code rely on aligned types, using an unaligned type
can work if we have a function that serves as a conversion from
unaligned to aligned types.
In this code, since the next operation is a byte swap operation on
32bits, I don't think we have many option but to memcpy().


--=20
David Marchand

