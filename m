Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA7C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 11:39:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8946540611;
	Wed,  9 Apr 2025 13:39:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BE54C402B7
 for <dev@dpdk.org>; Wed,  9 Apr 2025 13:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744198791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APV6H+w6adohXxg4Wn0WyCvS8jtUGPy9STyewrAmpwI=;
 b=BYtblUBAXVHhoBYU1mqMOYvWNUjl+etdKlfM9+W7/asHIon8c2dZLL7B7HbWTMaKIEWqx9
 UhZL0cL1aM8h/sp1bNoOfmSAiF4xmBFb0Ea4xsGdDSUt0nNIuLFVRUnrqrbN+b/mZjCjlx
 rJo7/yQKJnf7Zt22ESNt0tVfu1E73rw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-cCHbLzPwNB-9jrLG63dx2g-1; Wed, 09 Apr 2025 07:39:50 -0400
X-MC-Unique: cCHbLzPwNB-9jrLG63dx2g-1
X-Mimecast-MFC-AGG-ID: cCHbLzPwNB-9jrLG63dx2g_1744198789
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30c4fd96a7bso47650311fa.3
 for <dev@dpdk.org>; Wed, 09 Apr 2025 04:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744198788; x=1744803588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APV6H+w6adohXxg4Wn0WyCvS8jtUGPy9STyewrAmpwI=;
 b=hr1/6hJNZLnRcH74zduRmOXcYauqGy68+SqoEr7EqMKV6spts6naCYRGEGle5yETDQ
 7+3I47WvvXaRmsn0IGjgYPZiUasePsiAEt5kDrTEUgc3u7JzxQgYrWhHOPFnw7+IS5Ce
 sv89vBCYwSA3U/+icddwXistzqbx459mUTadVVhXEvshLbtKivIp2wRI9wSH10I5SI8l
 SqDa8UA9fzF2M86tpEsmGhma4k2u2ro0E+hNCZVRVuOwE3s0usseqdrNlByhQKClizsY
 bwE8tW7frmcrEf1R/KrZAXZJmCS/sl+9Qb74Hk/VK6Fo0gg5wKChEBp3lSXJMITQSvJ6
 Jo1Q==
X-Gm-Message-State: AOJu0YxWbGZyAcRn+cJwWjXGyaobfJRRUvN96SYhVJSSlOAQf816LgnR
 K5piXYMlVlOeY71/n1o+NThgSzMZgMxcwS2yhNP2yH4MdEajee0T2vUNsOunO93opDqjnlVW6DQ
 fNgJelGqGKhDiBiVdY4lNfgKp48t0vBIFeenYgNNAVzCpzt6aSP2uakSTFyYdZvFeBWkpN7VVNs
 tzZ9EP3Xq5vrF8tMg=
X-Gm-Gg: ASbGncuNXksCasnPCrmV11RD2RIk95vIrupNxsj7w2RlAsKaYC5QNsRucAhxvEAdmhl
 sLmwrFW/O61AZZ/CQBTC8I5jCGskEhPHPmAXNFA/dK7fEd43IFU6Fgz3LW5LM8sg4PET4li8=
X-Received: by 2002:a2e:be8a:0:b0:30d:e104:b594 with SMTP id
 38308e7fff4ca-30f450761bdmr5500931fa.40.1744198788664; 
 Wed, 09 Apr 2025 04:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn5a7lrjOGvO0yhFlzttdZmjGM1vHHw+5bYA/c9wsvJRkiQoBO+y549YK051r8DkLPLAIxBFnSjzmYF4PbIuo=
X-Received: by 2002:a2e:be8a:0:b0:30d:e104:b594 with SMTP id
 38308e7fff4ca-30f450761bdmr5500861fa.40.1744198788292; Wed, 09 Apr 2025
 04:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744147477-23715-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 9 Apr 2025 13:39:36 +0200
X-Gm-Features: ATxdqUHvEySI9UHEUI7DpLNDqsJkMfRSL-fPovTeYU0BBHvDOsTSINb5oQUGfdY
Message-ID: <CAJFAV8xCqwbMEsf83Um-m=Kn1n=SU9k1bpB2jtuhjPFDQiJs3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mbuf: enable to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xSuOmqOEUrWKEQnDisDw56L0HzPVJmxNvNG0glaQTVo_1744198789
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

On Tue, Apr 8, 2025 at 11:24=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> diff --git a/lib/net/meson.build b/lib/net/meson.build
> index 7a6c419f40..c528fcc9a2 100644
> --- a/lib/net/meson.build
> +++ b/lib/net/meson.build
> @@ -43,7 +43,12 @@ use_function_versioning =3D true
>
>  if dpdk_conf.has('RTE_ARCH_X86_64')
>      sources +=3D files('net_crc_sse.c')
> -    cflags +=3D ['-mpclmul', '-maes']
> +    cflags_options =3D ['-mpclmul', '-maes']
> +    foreach option:cflags_options
> +        if cc.has_argument(option)
> +            cflags +=3D option
> +        endif
> +    endforeach

What guarantee do we have that MSVC builds with those instructions?

>      # only build AVX-512 support if we also have PCLMULQDQ support
>      if cc.has_argument('-mvpclmulqdq')
>          sources_avx512 +=3D files('net_crc_avx512.c')


--=20
David Marchand

