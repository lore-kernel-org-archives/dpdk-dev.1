Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64FC02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 16:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A12F40280;
	Sat,  8 Feb 2025 17:11:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 20CD040279
 for <dev@dpdk.org>; Sat,  8 Feb 2025 17:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739031095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIsiNrB9ztmxCktv/ZRTY5RyCWevWIQU338RoGLZ8Os=;
 b=Wfx3UcAeYYuLTP4gF9Ue10hFNVQDpLmsZ/R6nk7l7b9OtNzBVlHpH96sFIJBRl8rYudjz2
 7XWxeWkl0Q4GbEYHI1fMVA8ldDO8O1a7sbC1Ut8oX8B8RUhAMuuUAcA1PRcNtgQ9DRgvv1
 7xva4kFPVCUyzFGSY0XBVcT7WdQM1So=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-4lbj7m_aNSimMKkVNO4o0Q-1; Sat, 08 Feb 2025 11:11:34 -0500
X-MC-Unique: 4lbj7m_aNSimMKkVNO4o0Q-1
X-Mimecast-MFC-AGG-ID: 4lbj7m_aNSimMKkVNO4o0Q
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-307ed4e39f9so8445441fa.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 08:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739031093; x=1739635893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIsiNrB9ztmxCktv/ZRTY5RyCWevWIQU338RoGLZ8Os=;
 b=cRLUSjNAbSIRHGxZeTUR+5avYO8hp2d3z62Kji/FbZnY5l/xLuG+mLxr/2tp7ZMoJt
 SlSo+UGCj154HdGR5bL6hdIRIG6FwCeXZvdsnv8rY6R+nrn86E6pQS+6QlPyBxg1ywbG
 duaGUguhOSN1abZ5SfGzaAJ20t8U/MffexMyMUR1utZNUbCD8LCsLD8xRBUy359K+Jy/
 poXCxCrMU5NZLNUIOLjrpfKPj2gYsYUd3vxt57T41Fbx8I9vxqqpuY3+ymxATi6jX6rO
 YAVGVy0VeyIR37T40kdPPsm7uG9g/h4ky3qCuGYIVhLypApxnRjRIbfnayA+IDwzLPjC
 vWig==
X-Gm-Message-State: AOJu0Yx8eTxVTcu1b5IJo3C0xnF9bwRF1mS38DtfZK/M1fQf31hmYsK1
 oIWappg6+ZIWvR/GRh4eyYFAi2JT1KK2FoY9nsSf7TrvFhgw49UH8vLu/qILY/ZV52+baw8QFrW
 tWkXobpeUCJ/XCcfi9pgrB8gZXF3lHFEDomZ3mboQk3cxkY+loCkmry/l0SplR0UDY7jnduBSeZ
 vkVGlRjH8BWSS4VLc=
X-Gm-Gg: ASbGncsKL5Qs/uheuMWCSvYfLFKNxWeJawBZzelxhuIdCvyHLj+IHikUgGlnH842RfZ
 +hKMsggYRWBcPDBwGC5C3FH3G39wP9BREVhgr5JF8KM5CdX6fzrQ0ear3CW0LseTF
X-Received: by 2002:a05:651c:104f:b0:308:e541:3df7 with SMTP id
 38308e7fff4ca-308e5414060mr4960081fa.12.1739031092642; 
 Sat, 08 Feb 2025 08:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcnCCnh+9+kf94xcUkttq40YFcvUp2xD5LNtHqxbgTu7jH31/0pl2Y82r4OkwqdYHmbF2ZTJ6Rg2O9/0DpKMk=
X-Received: by 2002:a05:651c:104f:b0:308:e541:3df7 with SMTP id
 38308e7fff4ca-308e5414060mr4960051fa.12.1739031092263; Sat, 08 Feb 2025
 08:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20250208092839.1238770-1-thomas@monjalon.net>
In-Reply-To: <20250208092839.1238770-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 8 Feb 2025 17:11:20 +0100
X-Gm-Features: AWEUYZm8vu_WKHq9gBcouVwx1bKLjM1BHKkmR_QXPgyJbTDy3bBKBmpB8HF_Xx0
Message-ID: <CAJFAV8z4t91m02poRr6CL6=jNoRWvyGMAChzcz3VHK7rxoqeNA@mail.gmail.com>
Subject: Re: [PATCH] drivers: allow build with VLAs
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Michael Shamis <michaelsh@marvell.com>,
 Liron Himi <lironh@marvell.com>, Martin Spinler <spinler@cesnet.cz>,
 Andre Muezerie <andremue@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8p74Kw1LM_63tPZMkGcT2nU7uxr7aNgFB7mrQXzM96I_1739031093
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

On Sat, Feb 8, 2025 at 10:29=E2=80=AFAM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> The drivers nfb, mvpp2 and mvsam use some variable length arrays
> in their code, so the warnings about VLA must be disabled for now,
> until removal for MSVC support, as in some other drivers.
>
> The warnings look like below:
>
> nfb_rx.h:156:16: error:
>         ISO C90 forbids variable length array 'packets' [-Werror=3Dvla]
>   156 |         struct ndp_packet packets[nb_pkts];
>
> mvpp2/mrvl_flow.c:108:9: error:
>      ISO C90 forbids variable length array 'zeros' [-Werror=3Dvla]
>   108 |         uint8_t zeros[size];
>
> mvsam/rte_mrvl_pmd.c:865:16: error:
>         ISO C90 forbids variable length array 'requests_crp' [-Werror=3Dv=
la]
>   865 |         struct sam_cio_op_params requests_crp[nb_ops];
>
> Fixes: 1bf86800f7da ("build: warn on uses of VLA")
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

