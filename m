Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8748CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 05:24:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B16FF4027D;
	Wed, 12 Nov 2025 06:24:26 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id A364E4026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 06:24:25 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4ed83ad277fso3503241cf.0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 21:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762925065; x=1763529865; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/di/0JFmB/+WTR/rhsJTQ8NylPxOG5kqOrNqRAIa0IM=;
 b=ZJBn2lkrOl4fxmA5uXKiyvD5h7dfWiSSmYltaz7Hmc/hmXxDfnUl1pD4cX2cnKsLPZ
 +dMDVScJ1uo1bRJcW1bpi1SsuA1rajg3Jhx4D0/EenqYp1wDZmrnfcXAUv03BdjyIjUV
 RGoAFo/1GbHly16MKkGACEu52d2yYvdeRMYUFQiH0wAQxwCV15suei+maCzZj2zvC99O
 8A1ZJFUUNiPUykMYtS0fYgDK/twTwx6JQU8CE/49crj5LRMB4YMJgnd3FjNWRv2k8XJM
 oP2fi1oiX6ph0u9e0S0rOnW8xRZ60JK9kSaqphlolu4jF3OX+nnojJ1LOwp9uutOSEnd
 hSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762925065; x=1763529865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/di/0JFmB/+WTR/rhsJTQ8NylPxOG5kqOrNqRAIa0IM=;
 b=FxJ1/q8hgPEQqaxqZum7K3jMQvYhvpGJ8IS6E3Do/6omyfwNiORwMlZr/oNXv6TiPr
 Kqqr4WjAz5xcjr02QxY/OumY1jskorsQmbxmo7V9c2AgaleZmCvdBcwHHoH/IDxFE2Da
 8oL8emB40FrmgjJmCujjgjMW/ni1WZfZ0Xiut4XpBpVvQ0zJlOXYz+VbgqqazmGwbTdA
 oZFOYYqwDaWsizvb8ra1a6L1o5Z0Jw07TgUhF2peqSf5P+OHMa10kGTXGfJYTsi2nh4N
 LH7zdSjys4fAxr1YvD56MN3XSSIC99GAkWsNgOKCxjfK/xwQToMXqtuet1DKgpbPS49q
 dUTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnCzVVjFGECij3SLPOpyIE5HyGMtpZhGPJpyLNhKJAVLNFFrpi3hKy8lDlxi4gN1Obrek=@dpdk.org
X-Gm-Message-State: AOJu0YyrBxaL01VtoD1wqerHReI6Gr+ROrjnX6j58Yt9ShiVRezyuaho
 UyozObfHVgQ+7v8CX77fBvRujP6t4+N+90tSkKkmttGXjW4NO+Tr7HDlNBKYPm/95pzOwpLheph
 uJdochKWQuESipuQlCcXuzgJylZa6GjU=
X-Gm-Gg: ASbGncseP3N/7wKC/2SAM3S8PFklpOfbvrxcJeu1IqMFHVWKndqVqrYFTB+IBK0sFUZ
 DExJntxlF9XNV5UTapgdEl/aYBdJ0xIP04C4B5EdQuneeZNeAtFoR8gJwmxf7/wg2oypv1+5qIY
 O7oe57Mp5BIa7j0d6My5Rzh5kaNB/ekDj+EB9VWM0HEQ/NH5pmEbb0npKvNjnVBgXUs1ITapqgF
 HeR4lvIHKtzKdhyx7VGjgiN5gkv68xEA5eQSKOlSY8lozogsqfu1HZEMYjr
X-Google-Smtp-Source: AGHT+IHfbJHWCP64/AJ3W3pwHKc5Sa5JYAWJlmy9IS6s2QoIthj5lksLccAsVVRjHjMjLABE0cmyR8nkp00GfqIniP8=
X-Received: by 2002:a05:622a:104:b0:4ed:a6b0:5c21 with SMTP id
 d75a77b69052e-4eddbddbe76mr23115651cf.39.1762925064692; Tue, 11 Nov 2025
 21:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
 <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
 <e99e848a439e46c4bf9092c2c83de2a8@huawei.com>
 <CALBAE1OW-zbiJKQOgTOeEyE6R6CtGAfF__okaEypWMkt7hBENA@mail.gmail.com>
 <c1b06e0bf9084c93a52096ca5000290b@huawei.com>
In-Reply-To: <c1b06e0bf9084c93a52096ca5000290b@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 12 Nov 2025 10:53:57 +0530
X-Gm-Features: AWmQ_bmJhBgsQpdmHeCXiEsjDECYwwSNCm4TPIjmjSledwRQQPaLjvzFxS_N6VM
Message-ID: <CALBAE1MjtM+kVA31KEcge47F_J8qmUDH_q8eWzYjBZxqVppJiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org" <dev@dpdk.org>
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

On Tue, Nov 11, 2025 at 10:09=E2=80=AFPM Marat Khalili <marat.khalili@huawe=
i.com> wrote:
>
> > -----Original Message-----
> > From: Jerin Jacob <jerinjacobk@gmail.com>
> > Sent: Tuesday 11 November 2025 16:31
> > To: Marat Khalili <marat.khalili@huawei.com>
> > Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>; Stephen Hemming=
er <stephen@networkplumber.org>;
> > dev@dpdk.org
> > Subject: Re: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
> >
> > On Tue, Nov 11, 2025 at 3:40=E2=80=AFPM Marat Khalili <marat.khalili@hu=
awei.com> wrote:
> > >
> > > > On Mon, Nov 10, 2025 at 9:01=E2=80=AFPM Marat Khalili <marat.khalil=
i@huawei.com> wrote:
> > > > >
> > > > > Left shifts of integer literals and bool values overwriting the s=
ign bit
> > > > > were used multiple times in bpf_jit_arm64.c. E.g.:
> > > > >
> > > > >     insn =3D (!!is64) << 31;
> > > > >
> > > > > where is64 has type bool (double bang is a no-op here). The opera=
nd of
> > > > > left shift was promoted to type int, which when 32-bit wide canno=
t
> > > > > represent the result. Similarly literal integers have int type by
> > > > > default.  Sanitizer produced the following diagnostic during runt=
ime
> > > > > (for various lines):
> > > > >
> > > > >     lib/bpf/bpf_jit_arm64.c:241:18: runtime error: left shift of =
1 by 31
> > > > >     places cannot be represented in type 'int'
> > > >
> > > > Wonder why none of the tests in app/test/test_bpf.c able to catch
> > > > this? The generated ARM opcode looks OK (otherwise tests wont pass)=
.
> > > > Could you check what is missing in the app/test/test_bpf.c?
> > >
> > > That tests do trigger it.
> > >
> > > RTE>>bpf_autotest
> > > ../../src/lib/bpf/bpf_jit_arm64.c:320:18: runtime error: left shift o=
f 1 by 31 places cannot be
> > represented in type 'int'
> >
> > This is when ASAN is enabled. Right?
>
> More likely UBSAN, but yes.
>
> > Is it really generating BAD
> > opcode(i.e emiter generating bad OPcode) and test fails?
>
> If allowed to finish the test does not fail.

Does that mean, it is a false positive? Right?

Anyway, There is no harm in the new patch, Change the patch to use
SHIFT macros from EAL.


> However, I have not compared DPDK or JIT compiled code with and without c=
hanges.
