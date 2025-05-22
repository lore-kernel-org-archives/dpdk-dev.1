Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDDC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 12:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 045F2402E5;
	Thu, 22 May 2025 14:51:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 24B14402E0
 for <dev@dpdk.org>; Thu, 22 May 2025 14:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747918303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCsbvEGXi9imWhFOErJuCdcM1shFYckQDBF1JBL6i68=;
 b=dljRPql9qhtTZpOcByalVvjmdfTyfGcLlrpxCQZuGunfOa6zcVRFU4sm1P5SnwQpEwI7bS
 ZTCUKQP1GbbgI6/x1QAITt9gP5yjo89WtrIIn8ShoGhuP0J2L32gPMqRAtFWPKeVRE/XJJ
 t0PCKx6dNT6GeD8awUs60MrolFVa9+8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-FELj25zGN6yQRs0i05R_SA-1; Thu, 22 May 2025 08:51:42 -0400
X-MC-Unique: FELj25zGN6yQRs0i05R_SA-1
X-Mimecast-MFC-AGG-ID: FELj25zGN6yQRs0i05R_SA_1747918301
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-327fffcbf86so19058881fa.3
 for <dev@dpdk.org>; Thu, 22 May 2025 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747918301; x=1748523101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCsbvEGXi9imWhFOErJuCdcM1shFYckQDBF1JBL6i68=;
 b=FH4PfiXU9mKjwlf8Mx685H7kimDo6apaJvbUa24RUIwOVLZbGe+XfFiT1KUjEv11WL
 PpvItg0TqorPHCN3do+9UrwVJTQQZv+1T0+IHfq9UEqJVyqz0cVDLooXbTxMeRjFdq9n
 YE2GAKR0rv/QC2DFPzaZEMPm8SISaZMxOG7O+c152q5tGJeeh0hMP/9BIpQEoxhXxokO
 O5hgVoOExY03UAqstmGvsa2Pc6PZDa3QOhSwquJyJaDlj0jL+JlZU5C9VtqwGNczoJn3
 WTHwXjgArfAvgHQ58s11k2copaOXGGpaULj4ECrFWXlpQL54oBUSaZ7Oyews880NF4Cw
 /Q8A==
X-Gm-Message-State: AOJu0Yy8ahSglsPZJ2qEYLkB6Mm/9MfOKcI6kd4oMeWaauBA1ZhVAfVF
 U0/twuZiTWZuqvYMBxxEgBr1fuiApwCQwg9y6uHRxLRZu918tgMAWqgR8lwUYj8E2oVAr6b9buv
 3xpdoJgpNB7IMYuHjwg6xU5caTU430PpbvFSLY2D+rQzoHEMbxKB12xDCACDZ+3HGz+QnfCJhZ8
 IMU1XBvbUG5UZ1tD4co1c=
X-Gm-Gg: ASbGnctSH0IHMhne/5I8v0l3bhcteGy3BueSSMDU0w0I87Moxhh3+nwvGUheqimxaUz
 Gmp1eK02ZJ/GRyTeK5xHkhv/R3JYD71PGLtQTvV2mAFxXl8WjBs/vDgGgO8VN/8kGbp2prS0=
X-Received: by 2002:a2e:bcc1:0:b0:30b:9813:b010 with SMTP id
 38308e7fff4ca-3280977f143mr95287111fa.31.1747918300662; 
 Thu, 22 May 2025 05:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiis6KfflOP0C5bnZwNUFneJUCvA2UuH5mjOcvsHlUV3ak5KpGo/19Tm1xr6YiIufRVJFdpOqKIjHpZbiW5Y4=
X-Received: by 2002:a2e:bcc1:0:b0:30b:9813:b010 with SMTP id
 38308e7fff4ca-3280977f143mr95287011fa.31.1747918300267; Thu, 22 May 2025
 05:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240131174437.2494815-1-david.marchand@redhat.com>
In-Reply-To: <20240131174437.2494815-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 22 May 2025 14:51:27 +0200
X-Gm-Features: AX0GCFtc2_0LF7LA9LoWXRtVg3wzP3qro4MUOV2j5BwJjR_wdgX5xfxALdQQBgc
Message-ID: <CAJFAV8yAfPZ8XrerzCj1ihGSgBLrsdQNS5D1USCEfOu+jjcEjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ci: bump tested distributions in GHA
To: Luca Boccassi <bluca@debian.org>,
 "Xueming(Steven) Li" <xuemingl@nvidia.com>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>,
 Kevin Traynor <ktraynor@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BpZli0sS5GdrsM75tt0Po2ivNndSCwThV1OHfwJjhEs_1747918301
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

Hello Luca, Xueming,

On Wed, Jan 31, 2024 at 6:44=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> Fedora 37 has reached end of life in December 2023.
> Ubuntu 20.04 is getting quite old.
>
> Switch to more recent versions.
>
> With this move, some packages provided by those distributions are now
> recent enough to extend our build coverage.
> Install additional dependencies like ipsec-mb, isal and other
> libbpf/libxdp devel packages.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

The Ubuntu 20.04 image has been removed from GHA which means that GHA
testing in github is KO for 22.11 and 23.11 branches.
If you do care about GHA, I suggest backporting this current patch to
those LTS branches (+ fix ef2535d022b9 ("ci: fix ccache for Ubuntu
22.04")).
It should apply cleanly (or at least easily), but I can help otherwise.


--=20
David Marchand

