Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E26C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA9554065F;
	Thu,  6 Mar 2025 14:47:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 81F5B40430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:47:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741268839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xj7CVG/Rrx8i/mCH8ruFQjjjKg1TLMJJUVMG1SbAmhU=;
 b=d7nTQIg90YzkeH0D6yIhh+0OQDGm6X9Gz0F5wlNMIsg/kXVp1/3P6PeJfDh+FQACNyqon+
 Po9rMf3oJGZ6DQAhUl/iOUmYhcGRzvbMn/B8uBAczQsXzNCxepGQsSgwPSFytgfsGy76FX
 8NNZolCGACstFQtI0D49PXuin1U1Uzk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-V_hNfxwaPzi8N-tOoNzrKA-1; Thu, 06 Mar 2025 08:47:18 -0500
X-MC-Unique: V_hNfxwaPzi8N-tOoNzrKA-1
X-Mimecast-MFC-AGG-ID: V_hNfxwaPzi8N-tOoNzrKA_1741268837
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30baac7c992so4617301fa.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741268837; x=1741873637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xj7CVG/Rrx8i/mCH8ruFQjjjKg1TLMJJUVMG1SbAmhU=;
 b=AtR8RvH32vm2sfjPyTQKGtk0eQKL1vVi1HvItT5p63cLd+FJXl+jQOYDGDuOPgd4il
 VZy4m78wzsRpGHd8fjPDwp9HaD5314QOXa3gjbY9V0DDSzOjK2fJB8vlB+Kk9L9KIe9V
 1V4FH/IlpRPRobBJU7/62v9YAU7R6zCEhk6WwI5YRlB2H+OJpBtp4bWBoJRRu/th2ULJ
 7TewC/QLcduskuzxd32OBisahYbZZYfQPMIuI/t07H3yP4nmnL5SFJ9nhsvOQXJJk58o
 oyDArKFU7matdbe9GYc9xKVPec6nQDwWe8qIxL4kpgMNQPDmTkU/5j5Tf7HRx9Oz7fJ5
 9Qkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCRPewquNBaQXWweMVqy40ZMEZN82enuriKKYu2kduXIRsvwjdhAozXpxzUHIfdHKOfkw=@dpdk.org
X-Gm-Message-State: AOJu0Yz1KYPDZOQaQxAS8cLSDVGJxLeI8mJA3dF3RrZd7cl2OAPSv8sw
 lKxnZMtt5djWjAGoyQ0vJG7b0hZwtG7HE5EKpQPpZ6boQA36YtCCtJY3xWqBkU1Im0+N87inB0v
 uOdblLwR2yenLQcGBCeNR8d/48UUarGNgHbIc+B1nPGvwZXKRBfH2CRuR/UeOnR+HUrWmQ6eCZP
 F4KUdTjjWca/Noq4Y=
X-Gm-Gg: ASbGncvM39Z1zJOPnd22injxmUKAUFBgeI65VLZjgw9Wj75zTR5qq7+uVGPMLLfejbM
 ARhhDnTKiZ8mHevntxQsNXkWdvEd5wPwSS2SFAsaS05bPS9MaIHWiA3zUfcVl0SEZtf4ZEMXD4f
 Y=
X-Received: by 2002:a2e:9d8f:0:b0:30b:aaca:9b2e with SMTP id
 38308e7fff4ca-30be3261a4emr12651861fa.0.1741268837246; 
 Thu, 06 Mar 2025 05:47:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXONssIxcsETXZgt8LVWi3WhsXcl9JUuBiMm0lT98wAUr2O3uyR5/2FCaNVxhUtQDJdursMN+9enEMUZcO+Ko=
X-Received: by 2002:a2e:9d8f:0:b0:30b:aaca:9b2e with SMTP id
 38308e7fff4ca-30be3261a4emr12651771fa.0.1741268836891; Thu, 06 Mar 2025
 05:47:16 -0800 (PST)
MIME-Version: 1.0
References: <1740757940-10253-1-git-send-email-andremue@linux.microsoft.com>
 <1740780187-5272-1-git-send-email-andremue@linux.microsoft.com>
 <1740780187-5272-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740780187-5272-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:47:04 +0100
X-Gm-Features: AQ5f1JqAgpr5GwNyBbBhbEwXqftWasIvFA2khfthL-09YnBDOHogYHfxhuXZsAU
Message-ID: <CAJFAV8xBHxmDaQGc3NG4F-23LCuBCUoYjCPFjEu9JZ09MUxDfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] config: move existing code that is common to the
 top
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, konstantin.v.ananyev@yandex.ru
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pyg3U8GHLz6BO_aS586Phx78x1IhH5XDaelmJEDRa34_1741268837
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

On Fri, Feb 28, 2025 at 11:03=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> In preparation to add better MSVC support, existing common code was
> moved up.
>
> A split was added which in future will call an MSVC specific meson.build
> file:
>
> if is_ms_compiler
>     subdir_done()
> endif
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

In addition to my previous remark, I dropped the change adding
AVX512CD, so it comes with the change associated to the ACL library.
Applied, thanks.


--=20
David Marchand

