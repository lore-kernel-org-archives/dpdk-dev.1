Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE83C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 13:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B9540292;
	Fri, 16 May 2025 15:19:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0F9094028F
 for <dev@dpdk.org>; Fri, 16 May 2025 15:19:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747401552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uAvG8bw2V994ECg58CRol62Hz9PMS52SqgMnF6zKcZ0=;
 b=CTgIUB3TUAOahrzAlJXilk+D9YQCPnlk++jXz0uLXl9oJP8g9QU/d0RRk7+a/0O+HGmQtc
 MrKZwZkGSlZcwZ7ts42HIke3sTWykDPuCWGxlNrzpMUrHpIwbjAIUGY729zSt5GNgPjROj
 md4tbbem/Cibxozx3wNhJfqjXgZrhQo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-H-lK-EUCPKG0wt1KXDSSZA-1; Fri, 16 May 2025 09:19:10 -0400
X-MC-Unique: H-lK-EUCPKG0wt1KXDSSZA-1
X-Mimecast-MFC-AGG-ID: H-lK-EUCPKG0wt1KXDSSZA_1747401549
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-327fece80a0so7053101fa.0
 for <dev@dpdk.org>; Fri, 16 May 2025 06:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747401549; x=1748006349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAvG8bw2V994ECg58CRol62Hz9PMS52SqgMnF6zKcZ0=;
 b=U6ymW3ycPz9hkAc4DMJu1MsFrtXec783wEV6wnqh2t2AF22rluMHVqITrdZWvCkjNO
 NOmlCjzE+AU+LvPf3caXzGIR8K75XhioKbvpuLKwn1dOkCkmCzUg6lHBm3CJtDfcD3rz
 1mZux5VtYFn7A2XmtDeQRPvnAVSUY+oR2A7oy9orrl107eZF3A6UuySnGtPYvQnFCgEo
 uec93AQwQwrhPdSmCH3a1sIPvTrsrjrecmF/TTPebkp7IlyJjGrpBNeEJSltBNvdHRpZ
 XNo+fOqrnptHHMzmTKcP8eU+zyuFqqJIKxvCHDXHB1ZJqBvbT2NwnExDgKYVOGXcYxgM
 XCwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbxMHstdN8FmH7vUi2S/88avFa3+pqr2VwuidIJfdSKZEyIrTE4CcM0iBhYQ4ZpaB1Fnk=@dpdk.org
X-Gm-Message-State: AOJu0Yw/MYsnwl/FehB+LhMilL3PRhHoiu8P/3qDEd5peX10wNjzdwDS
 fglRBZeS5glmG3tzFUvyIQpNQIJCL4uO48XrOh6IvfOJaSJBAvsfTtMQ//FqzxXUmE+JaAQZFBP
 AwZFYeleJX+ZUM9e5oMQfXacWiwS2cv68nAMdyUURKuxIJ8P3XPojExoCMyz+s7kI3arclPjLRL
 B7iJpHaPXDQeiV2acotj4=
X-Gm-Gg: ASbGncux/7XfDwW2CYTWOwyiomYSicEsbXR7JkJpQxSWkNmt2qaytHI29ub2zcp0m/N
 zJMcagwmn8eihL/f8cdyv//DAB3vb94gTll1K7dT5jpSC1kpQBgbchje5fMkebjuC5prXmyE=
X-Received: by 2002:a05:651c:1544:b0:326:cb09:8220 with SMTP id
 38308e7fff4ca-327f84f686emr25910221fa.16.1747401548891; 
 Fri, 16 May 2025 06:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+x1/F+guHV6c3xMxp+kzXRNUmDDpKtV7a/O8PLk9KTed9IS//F0A6GeeYMTFHj1tFEATuuNi98LaAerqTN7k=
X-Received: by 2002:a05:651c:1544:b0:326:cb09:8220 with SMTP id
 38308e7fff4ca-327f84f686emr25910131fa.16.1747401548475; Fri, 16 May 2025
 06:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <1741313581-14300-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741313581-14300-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 May 2025 15:18:56 +0200
X-Gm-Features: AX0GCFs7SdBwcpzP4geoPSygPVVGGnojf9Bx4VCxzO5FaWIDSW89PO3V2b1SwDU
Message-ID: <CAJFAV8yT5tHs0dkOinG+D2TbF13Jaks2RJNDwoz+yBHt_nLu0Q@mail.gmail.com>
Subject: Re: [PATCH] test_ipfrag: remove array of size zero
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FoDI_8_jUJe5m-AGtmAZyr7QKay2pDgtcZFSIpkkoR0_1747401549
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

On Fri, Mar 7, 2025 at 3:13=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> When compiling with MSVC the error below pops up:
>
> ../app/test/test_ipfrag.c(39): error C2466:
>     cannot allocate an array of constant size 0
> ../app/test/test_ipfrag.c(157): warning C4034: sizeof returns 0
> ../app/test/test_ipfrag.c(160): warning C4034: sizeof returns 0
>
> The fix is to simplify the code and remove the zero-size array.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Applied, thanks.


--=20
David Marchand

