Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C4C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:45:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4292140E40;
	Thu, 15 May 2025 13:45:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 84C40402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 13:45:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747309523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3m0gS3c7WrxaCQgI2ufRc+dnPxnI6zPoeEuRWlzGfk=;
 b=Y/9GCiqSiq/DmxnH7qFRQ7OjKTaiJ3fx/wXeRWGUSsksLD/M2+Y3tqRoxfhMj1uDy12ERS
 jHso17d9GEfkHz3WZ5EoGdAINGAeAjEYpcRHFHjy3CUEQNJK7sOMtQ2onvpRdXAl7VTFBf
 +EM50aD6T7Kx5GKJ8U9V732LMuOE/Iw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-m_J4ADMMO_mDbIy7gDZfgg-1; Thu, 15 May 2025 07:45:22 -0400
X-MC-Unique: m_J4ADMMO_mDbIy7gDZfgg-1
X-Mimecast-MFC-AGG-ID: m_J4ADMMO_mDbIy7gDZfgg_1747309521
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5428d385b93so621104e87.3
 for <dev@dpdk.org>; Thu, 15 May 2025 04:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747309521; x=1747914321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3m0gS3c7WrxaCQgI2ufRc+dnPxnI6zPoeEuRWlzGfk=;
 b=hAeoPGq/3UCeVp0te0h/w8L2h3AdDSBB3+LDHnomUrGH/KXUo2spHgJnjB8gSshFkD
 mlBVpdaS3kc0dsLazI9Oh0XAPvR9cyY89ypoIfgveE6BHNLfmKjjDIvF23EHA1CC5nvZ
 xtt4qY9iKmkXMU8TzL1FXsG2/opUMFeAkM9Qxi3NpHWrVhbA4ads4dh4S2x1zX+ypp0+
 e2AcRvZyUTFjXpVSdnmnSgu4KoEEK1qiScSH2aBSkOmWdIB2g1UzM0C5vyKkW8trZ9ti
 KapThNJfR7zFolH54PUmcmED/fAMpGQJB2/j2X8VaGGm4X1qxmEcTYBAQDR/BIc7wRTZ
 CbeA==
X-Gm-Message-State: AOJu0YzYR96s2L3LFgnFQluOItJp3dQkqE9/u4J0BRFv7R/+V9QAci1b
 EREmzGrW02CzbDJfOI3vdzBsrENyg+LKZLrIR6XS1BlCC8s76HOYsNEtpswFhDrK5UGGaVR8n9v
 Bv9JPYKU1frVLish82hD9/xJBwnwTny7VjL7RDll7NnexNmBTAu2evILBPCa0fZZ3J2UWZEXixf
 cRnQIf6MMZpe1YOME=
X-Gm-Gg: ASbGncttv5ppMpZD3z+bP4fIF9ZH1O3nhk8tr4w85FzssPnWIVCyHPL+CfECj43Qla1
 wz+OGiocJOBu9Na/YvH5k69diJa7Y2fgEaK5IeobTUbYUmsBdO8jx+eEfjdHLPEMvybvitYU=
X-Received: by 2002:a05:6512:1341:b0:550:e15a:be6d with SMTP id
 2adb3069b0e04-550e15ac241mr363886e87.30.1747309521012; 
 Thu, 15 May 2025 04:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpZb3ljDttp70Xkza515E9hXTY040kxJfLTvR5GHcWEgBE2Xvnk4wc7ny9sdguHiKYKyWnVKH1NXOSnSb7/QM=
X-Received: by 2002:a05:6512:1341:b0:550:e15a:be6d with SMTP id
 2adb3069b0e04-550e15ac241mr363877e87.30.1747309520635; Thu, 15 May 2025
 04:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
 <20250313083733.203d132c@hermes.local>
In-Reply-To: <20250313083733.203d132c@hermes.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 13:45:09 +0200
X-Gm-Features: AX0GCFuQyo1-4xBt15Jyo04kFjokw80BYMfFlDJemLXmpse_-3w-ZZ_vV0ZPSpU
Message-ID: <CAJFAV8wXApL0njja3oOgz6JTnXBGyX6FfqL_pThB7Hu8VBJ00A@mail.gmail.com>
Subject: Re: [PATCH v2] eal/linux: improve ASLR check
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 04InMqAY-Cg8r081JMgQE8_WQDHYS4CS9WRBlqQq-7c_1747309521
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

On Thu, Mar 13, 2025 at 4:37=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 13 Mar 2025 14:19:03 +0800
> Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
>
> > This change ensures that the current process is checked for
> > being run with 'setarch' before verifying the value of
> > '/proc/sys/kernel/randomize_va_space'. The '-R' or
> > '--addr-no-randomize' parameter of the 'setarch' command is used
> > to disable the randomization of the virtual address space.
> >
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


--=20
David Marchand

