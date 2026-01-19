Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9869D2ECEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C64F94025E;
	Mon, 19 Jan 2026 23:48:29 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id D9A154025D
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:48:28 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso32315455e9.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862908;
 x=1769467708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKGAmk8v3ZcvAHmdQFVj+StOG33h0mJ184B7ZPbwMEw=;
 b=D/yEFCnUwdHWqhDBSWegdVetQZ8eVWM1L0luidUMDKUVdzo+W4EWtw0d1AL+QucpFh
 4X4PCtzvbLml8tanRcqrOCGEc+gYtMlbvg1NtY3GVOp/6G6x43ZaSI5L1AnbRny5CwoE
 UvPNhPqjVBSRZPzvulkSIrvSn/V0c/oWrSh29kErQZt51IDP5qjfB0hpcNtQSkTPlR8d
 meooq9QsbJka4QGjkhZgajnpMfdhFw2MH1ZpIXNli/Rx+uQ5evEU6tKuJwzK9CCJmM7q
 oP6DOacOCpPF+IJocQYLjXWaHLSZklYrKc31k2GhM7MmKqunwcmMzFz/5dIUKt9VtQd7
 LCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862908; x=1769467708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uKGAmk8v3ZcvAHmdQFVj+StOG33h0mJ184B7ZPbwMEw=;
 b=wfFHpVHQL8KIhWJWU1Wq+cs6sXLKkjjNfsnAA/VD5aSlWQ2JxcSzvf1/g8XKs34OvH
 N6PT1Osj16TzG3sa+NesvSuAyBKqkFhmpaNeYn8WrqvPQeK36BNzWisd6SUAT+wV0vRE
 9+rPlXJ42+isurLFA24KUoRzJlAEgR1TKTVsxxWgN3pTOj/Tte257eU3Zxk9r/K4PHbq
 /EeMv/Q8fQZBBfFMyHpF42ZK3yL7biaEM4mM/jU/vnxtR8O37TYGoG0ILj3GmKe7bL/u
 MK4RgBJLNqzvcMNuygLUP7cSjnrWX0DTJt69wGhCvhr/z03K1TjeRs+Kb4jaGZWofV9K
 zboA==
X-Gm-Message-State: AOJu0YzC4kkKfj4eG2AUael0YAKF2kI7gVj5fwiU72rc+cACQW25Hi7b
 2A9mRYY7Timq0oJI7D2vUSn2V6IoKVZGP54J30oZP6xXmFkuStCG8k4ei86M1XfrgI0=
X-Gm-Gg: AY/fxX6cBm6siDlJoJRchVbjVToFjORUNNwy2807OPlI5uXk6pZjRY0vLx9zeACQxKU
 2h+zlt0HupYKjyostmoxNycnYm8SombQrlNnAyHJRNoI+NYTRuZNnfq1QZLeKmj1AF/IZ2LhBu1
 nGEvDrZpqX0nIdnc0Y2Kft/UGs2ZjhznjTovlD70n4kr/0EXfnFr02R1e03Ys6ey3PHbY3nS2Tj
 hjfDMo3zmQmCQK+5Z4v+KekMqi7J2YFZd5dejuvGrZvAQqzc0YpyzeoGd1kauxOHChQrqzAkBNR
 RJu8kcBd28JGL3v/ktk5VGKj0557wHI5LkO9DnAFXiwEkp30xO08h+v8Df0DQYJQYuEewsGlp91
 ZQ6xEa0MAHbTqo9ueqUnBPnFsVeWSgk93oOmyV1KmnrdY35uFBgorQWDnrBSbhwQgGQFVqAtMMg
 PUOgoH22PHCl1CsLcOpmElrQxrykyLwZLYjtGOqGhigKH4qOavd4x9
X-Received: by 2002:a05:600c:46cd:b0:47e:e9bf:dd8a with SMTP id
 5b1f17b1804b1-4801eb182e1mr123973435e9.37.1768862908047; 
 Mon, 19 Jan 2026 14:48:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699980e5sm25720716f8f.41.2026.01.19.14.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:48:27 -0800 (PST)
Date: Mon, 19 Jan 2026 14:48:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Message-ID: <20260119144821.70e2ff35@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
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

On Fri, 16 Jan 2026 10:32:52 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 16 January 2026 07.46
> >=20
> > When building with LTO (Link Time Optimization), GCC performs
> > aggressive cross-compilation-unit inlining. This causes the compiler
> > to analyze all code paths in __rte_ring_do_dequeue_elems(), including
> > the 16-byte element path (__rte_ring_dequeue_elems_128), even when
> > the runtime element size is only 4 bytes.
> >=20
> > The static analyzer sees that the 16-byte path would copy
> > 32 elements * 16 bytes =3D 512 bytes into a 128-byte buffer
> > (uint32_t[32]),
> > triggering -Wstringop-overflow warnings.
> >=20
> > The existing #pragma GCC diagnostic suppression in rte_ring_elem_pvt.h
> > doesn't help because with LTO the warning context shifts to the test
> > file where the inlined code is instantiated.
> >=20
> > Fix by sizing all buffers passed to soring acquire/dequeue functions
> > for the worst-case element size (16 bytes =3D 4 * sizeof(uint32_t)).
> > This satisfies the static analyzer without changing runtime behavior. =
=20
>=20
> Using wildly oversized buffers doesn't seem like a recommendable solution.
> If the ring library is ever updated to support cache size elements (64 by=
te), the buffers would have to be oversize by factor 16.

The analysis (from AI) is that compiler is getting confused. Since there is=
 no good
way other than turning of LTO for the test to tell the compiler

>=20
> Maybe adding __rte_assume(sor->esize =3D=3D sizeof(uint32_t)); immediatel=
y before calling each of the affected soring functions would fix the proble=
m instead?
>=20
> It's only a test application, so oversized buffers as a workaround is acc=
eptable.
>=20
> But if it serves as guidance for real applications, a better solution/wor=
karound would be preferable.
