Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035A8CCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C27402E0;
	Wed,  5 Nov 2025 09:36:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5CBBA400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 09:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762331761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g90ChiIT+LhlyaGiPCAcYdJIBEjCvonfOGoRenNXr5U=;
 b=M/u/S/6R4F1PQmJZwrCSKQiycA+rKOsTQLOYM8zPHkDbrAi5rpaT61/0ddhp37qr5GtdXn
 iumSBmScI5I5aid/GPlenAkVvIeueDH4VViB/KBodyEpeMWMIZtxtjLu/Z35rQazjALu8I
 THYpLu6btPM7PEgmbyxsgDIOA9XuhY4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Y0OacNe5PcGG70SX86pazg-1; Wed, 05 Nov 2025 03:36:00 -0500
X-MC-Unique: Y0OacNe5PcGG70SX86pazg-1
X-Mimecast-MFC-AGG-ID: Y0OacNe5PcGG70SX86pazg_1762331759
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-37773b477c6so35077751fa.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 00:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762331759; x=1762936559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g90ChiIT+LhlyaGiPCAcYdJIBEjCvonfOGoRenNXr5U=;
 b=UnXeaoNVvqbxjEI+gTUeLM6FcNmebH1VjtXGU6Rv4zR8RRiwMnRIMnTKKnvLDY8E+1
 5tqL9dsHAYWxd94OAbZOyM92SnQjbmQ7YJ8zW+ZjP5R/+Xp5LCKKq1I0F7ttfgyKYIl5
 VxWLxpVq9TXPE91kWutlOX8HF1ythWrrGloL7gVGlXLTeU+BkC5drXoGtFmabeT1UJYg
 SWVIgIBeLmpLRyH9UK/faV2chSOWD+15Wgfrz6NcsqxuH89RajalDnwZpgwSexTvuxeK
 1Voo+x9xs4VjaPb5pV/y28q48DnAdmdXQL/pvwpLI08FcwHzDemXeaIbS3dSB9Sm4mAT
 GLSg==
X-Gm-Message-State: AOJu0Yzmh+/IThEs8KwpFgrvL7wP/5Fov3pORNx3AOVMCTS7Y4BqvsCK
 P7QqcJtIJcfWkKS/7L9u2RHpFUpaEjXSGhqyJsWZXTPpL4MmOay+mZ5x9UudNMtcTrk83C0u8tA
 XV7U1zKaNHJS/ZQH/IYJNkOiU+W8Nb2TGKijlujLulWvnF/YPsAgnIsXBng+JXSvKK8dTxZClXX
 3C4sjvIwc6oQz6k2ot1yM=
X-Gm-Gg: ASbGncsn5c81vPVXC1EGjwPbJkfROQu0y7LWeYPiJ5nqYzvX5KhRP5e6feBQBhDh1y1
 yT3EWmUVH+iHjbUP7Ekv4zlaaSjqWnZ68q3Y2RLSATRJH6ugU6F1D14nQXaUQWXLnIpkCIpL1LR
 MnKzKbzwkAl8cmYwyfj8R9RUrqM2SvvFLuq3ApkMj5GhYYh0HQaUboqrFy6w==
X-Received: by 2002:a05:6512:224d:b0:594:2ff7:9d29 with SMTP id
 2adb3069b0e04-5943d74edd9mr764082e87.13.1762331759028; 
 Wed, 05 Nov 2025 00:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTu0o3d4xQ0aLHxFgRpy4TObEuIgkoeat4wmK5kxoND83TTVtSMaVLnIe2X27ihLl/KgRc8LSmrgF80nk6VhM=
X-Received: by 2002:a05:6512:224d:b0:594:2ff7:9d29 with SMTP id
 2adb3069b0e04-5943d74edd9mr764076e87.13.1762331758608; Wed, 05 Nov 2025
 00:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20250904134531.2171206-1-david.marchand@redhat.com>
 <20251105074547.3760605-1-david.marchand@redhat.com>
In-Reply-To: <20251105074547.3760605-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 5 Nov 2025 09:35:47 +0100
X-Gm-Features: AWmQ_bmxhqwpsknoo4gNJjs7DsN30nfabtlPxzhTh9ewpt1x6cFM9irdA68w2EM
Message-ID: <CAJFAV8xf8A7jaB=3FhXOwB=VJ_PUEJRK7mCHuykR5FLWyo-JVg@mail.gmail.com>
Subject: Re: [PATCH v2] ci: switch testing to Fedora 43 in GHA
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Aaron Conole <aconole@redhat.com>, Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4K3gFim-NaXvpY0nPmu2z8MTKJZP_5sdjZSJi9V5Po_1762331759
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

On Wed, 5 Nov 2025 at 08:46, David Marchand <david.marchand@redhat.com> wrote:
>
> Fedora 39 is EOL for some time.
> Switch to Fedora 43 which will be maintained for a year
> (until December 2026).
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Aaron Conole <aconole@redhat.com>

clang 21 fixes are in, let's push this quickly before anyone breaks
compilation :-).

Applied, thanks.


-- 
David Marchand

