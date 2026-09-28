Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC5CCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 23:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD43740285;
	Tue, 29 Sep 2026 01:42:09 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id C448340276
 for <dev@dpdk.org>; Tue, 29 Sep 2026 01:42:08 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-883a16b758dso311430b3a.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790638928;
 x=1791243728; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C8YQFn31vszPfL6iH2gKtdUvitD8zIYqBZYJOhS+oP8=;
 b=ra0cSdhCL7ooJ6j5pasIdWSZkbR9FbX9e0C3l8Q76MPEdfWujroW/g2UNZiFBrlB8G
 O2yjUvDr+I0EPQW2JnuIdkCbr1J4UbALAUyUqZVMnhKQZ5BSWM2EK577ynVFsvZ+hcZF
 YWCtGRdj336PGZGJN7QBSDGe9NnF89qEOPLDxdUm7RoEMYSMiwfhG3oFyBRjVt4rhFS6
 makv8D/g+hrGW5b9n0iArqaflZsF/PCgm17Gaikq6MWsEINBKBfNx/pNXcHo6N0OLeZD
 1jmJHRhmRQq8bEZWDQAyBMpXiIyikyR5NZ8/BGgCsIAyP2He9+UCywXlB3ItVC0AceVe
 t8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790638928; x=1791243728;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C8YQFn31vszPfL6iH2gKtdUvitD8zIYqBZYJOhS+oP8=;
 b=QuusfOfdG4sZa09r0QgcIss1mVgQqDYYE2sf1SIELY0IDOrFiovUOUZJbLv4sj/XFI
 vt1FUMztan8dnDbg1B+xyFLCsWiTihtmXJIIhtK1lt2UnNlduIePcQe2geNLNh8oq7Um
 eCYUF/z6b/LGDKll2FmsErycn4FJFd9SjjhT5Ocb4kgxwGmjbgkKzHaYvA4vPYXxP/Ib
 Xvk5qLRiCWIqIpz9VzCoXpRy7MKiGuvJQnrG67oluJQhCkmqsoZXKADnzhtN4KLpkFtw
 tPO6AaT5NYvJmMOVcK4/8HAVma8QMg8RL17nMDkTk0N+aqbMfFA7ShEMeZa+ET09k6O6
 jgqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8B6UdF0hn08naIMCisd2eBI7XDA7NzM3BqSIyLM8Fp0VC7+krcRXZhOvLqasSKXFCufc=@dpdk.org
X-Gm-Message-State: AFuF++lM/Zw6+sbiYBYVWS7Q8aaHjcJI6jig9BNbEqHS9tXzc+1adrQa
 Cl0O4Iz5jFB0CytE72DDugLVVfYUeMlTzkn6Pjb61e2Kw3tRZ8FZ3DAmeEXEg6tmgZo=
X-Gm-Gg: AYBFou1Ay+LfRAmdlLQQSIHTTOUNIAorbKzVlZFpqRqVnHGn/ngZVf5q9oH4f5iYvp8
 tlbeW241gKD2ypeKF7FFuzxoPvO8o6UAdAxBM39i+w/fzFwjOxrg5G0YZ7PqROW+H/eEvG8h0LV
 o3VlBms5PMt1s8ZvUpLhC/6cyfnayZ+Ijx4a6dz+4/PfcKgEChdQEGd1SDV945ouz2GyxpXNNJa
 cozT+N24xZz39BimONw2fOgOqGVidK7r6eiL45wxHKEPs6+r4dFcZIR0EtnECxjbDSB+/XNB2fp
 EttqJidTUssUGjqvFdEtI1kN5JuQPsuY87AlJ8U0Vxum6ENiqys1R8p/dCI/VNNdymVN8KxVGyw
 tFi1E+Qwl0JfWZ8pNG4d33R0V8tqfVuvfGpKAQ3iRMoKNxPdVihd4IDU5dZlOWws/8FnwpgInhm
 EWzDoaExFmQ1emn67p+6zQ2zKxoae/JVkfkb7ljYMIXSUQAZWXiuGR0I02bhkptT5MNdBuIKhkX
 Tdqg6orQnpnalCMz4jD1fAL73Bz1RSFvIddQUgw
X-Received: by 2002:a05:6a00:1d86:b0:87d:df30:d918 with SMTP id
 d2e1a72fcca58-88560c4f467mr421249b3a.27.1790638927665; 
 Mon, 28 Sep 2026 16:42:07 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea888b10sm4782568b3a.29.2026.09.28.16.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 16:42:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:42:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org,
 mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, jasowangio@gmail.com,
 chenbox@nvidia.com, david.marchand@redhat.com
Subject: Re: [PATCH v2 01/11] build: define __counted_by as empty on
 unsupported compilers
Message-ID: <20260928164205.103049f3@phoenix.local>
In-Reply-To: <20260928132913.1376278-2-eperezma@redhat.com>
References: <20260928132913.1376278-1-eperezma@redhat.com>
 <20260928132913.1376278-2-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 28 Sep 2026 15:29:03 +0200
Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:

> __counted_by is a GCC 14 / Clang 18 extension used in imported kernel
> uapi headers. Older compilers reject it with an error. Define it as an
> empty function-like macro when the compiler does not support it.
>=20
> Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
> ---

NAK

Missing Signed-Of-By and the right way to handle counted_by is to
introduce and a new macro in rte_common.h (aka __rte_counted_by).
There are lots of places in DPDK that could use it.

If the problem is in vhost, then get it from stddef.h

