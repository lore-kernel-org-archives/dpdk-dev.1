Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCED2ECE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:34:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D56040E3A;
	Tue, 20 Jan 2026 15:34:20 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 9935640E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:34:19 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4801d21c411so19228515e9.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 06:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768919659;
 x=1769524459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHFMoYA+CeikPITF78/xRrt2kQD/GuPDFs7tly+zFSM=;
 b=hEpoyoblf/5R7BTfGIntWXZbGKi6DJd1icLRJcXBgF667ETazGQosw1UhtUnmjAhjj
 P30QZt1K+TiAJsrl4Jp2zFBIngAQ65UDiyHHBTPumJ+/cekDjkK1nC8qGjpTyJxgESCz
 8nY7n35NP53A/CJei4Z09R4KyI9YzuqMoKvFGhepivI1+E2lGxMd7Ak9HY7Lw2GA5Xse
 MgEHtqyfDjmSjzo8W8rFYYRHsd9SoPKm7tDaLyctwBALEuOIApBhGh3FyJbTI6iFBjqh
 8cOHweRV0ZjJoaSobWRVzbZR+TeaaOKFkh1aSpd/x620k1N9WkJEsBEQYJuA5+aNLxJp
 4ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919659; x=1769524459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bHFMoYA+CeikPITF78/xRrt2kQD/GuPDFs7tly+zFSM=;
 b=LqsuVDnn5JbF9AffMlP59NDGji2zpeoyR8BKBq+b77/mIwvMlBFWIA2uNPLw0Vv89Q
 4N7UpKAUIHiXIvM3q0EtmnolXwAWy81HKTOKLO4att3W6RajB/zaKZVEMV+bHO4pz3Pd
 f9Cnbn701T4vXlSoiHywsvwFt27yo5NzkFS6kjS4WfPsHhsPtH0USJZfN9IH/cJSY+2B
 2SF7KQ0BI9sIaIYxxMf8k2963Ap8m5z38xFfULIw5InnRWK9Y+hvmPwJTXtEevRtBCaB
 jZYU+zRr2kwLL8yn5ewYuFc1bL1/uESIAnUddnBRqdwlkM+xjHy35OW+xTaGVUN0KXeY
 2FGw==
X-Gm-Message-State: AOJu0YwsUV7E0MuK0phZlhR0cAu6navG6GpF0UaN2niKN/WXp2niMK+t
 zfTEku3tOWWXeti5tvshoGm4u/vDBCG0hmjL2RMFYfcCcEMpHfn5dyUmW/qqjxDMIaVHfbK3DDl
 8ru59
X-Gm-Gg: AY/fxX439ubVCGGYsCpNvE1ln0wWZFy3YxgPSx/93HpmYPCFghFXTCLpiKR2ksCFzCQ
 sOVONIfyOEYkQwryYsH+/znRcQjGxS2PbFpUnThdNgXd0hSqr6t+JvIdwsfwDo4yhWckQ1JpleC
 xBATQGCVeAD//3SpfTdBIU0Wlfk2/i564bF9CDsPjjbZCumNbtFYNJbl7y77KzcMTS19AFr563W
 AobNvHoB2ZwyqaexaS8hpXQJ1eJFRF9eiapL1K4OBNUbP5TqRe+rPkjKp/0cKXnQT2nd9Rh1D3Y
 robGzRg1y5qrHXqpWGg4FkSSsI17uAWp/0Q3lwEodJfQQvWNCXCI50sGDK+JbnoE9oZbs3JJmty
 H9FH+mXmB8QWtlNUv3LVNDGFCwn/7oCeI/aSDT7vRQwzo1RByFr1luow7mNOSCaZmowC0UHLTcf
 PZ5LhKjv8uvQfShcgRJ1S5Xeea8wQl9iAPUXsGnFgVVYzzBQtyLWuS
X-Received: by 2002:a05:600c:4eca:b0:47e:e2b0:15b8 with SMTP id
 5b1f17b1804b1-48025ded313mr152052535e9.4.1768919658873; 
 Tue, 20 Jan 2026 06:34:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2c1c6sm106262475e9.9.2026.01.20.06.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:34:18 -0800 (PST)
Date: Tue, 20 Jan 2026 06:34:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Message-ID: <20260120063413.72e0d725@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
 <20260119144821.70e2ff35@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
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

On Tue, 20 Jan 2026 09:49:44 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Monday, 19 January 2026 23.48
> >=20
> > On Fri, 16 Jan 2026 10:32:52 +0100
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > Sent: Friday, 16 January 2026 07.46
> > > >
> > > > When building with LTO (Link Time Optimization), GCC performs
> > > > aggressive cross-compilation-unit inlining. This causes the =20
> > compiler =20
> > > > to analyze all code paths in __rte_ring_do_dequeue_elems(), =20
> > including =20
> > > > the 16-byte element path (__rte_ring_dequeue_elems_128), even when
> > > > the runtime element size is only 4 bytes.
> > > >
> > > > The static analyzer sees that the 16-byte path would copy
> > > > 32 elements * 16 bytes =3D 512 bytes into a 128-byte buffer
> > > > (uint32_t[32]),
> > > > triggering -Wstringop-overflow warnings. =20
>=20
> The element size is not an inline function parameter, but fetched from th=
e "esize" field in the rte_soring structure, so the compiler cannot see tha=
t the element size is 4 bytes. And thus it needs to consider all possible e=
lement sizes.
>=20
> > > >
> > > > The existing #pragma GCC diagnostic suppression in =20
> > rte_ring_elem_pvt.h =20
> > > > doesn't help because with LTO the warning context shifts to the =20
> > test =20
> > > > file where the inlined code is instantiated.
> > > >
> > > > Fix by sizing all buffers passed to soring acquire/dequeue =20
> > functions =20
> > > > for the worst-case element size (16 bytes =3D 4 * sizeof(uint32_t)).
> > > > This satisfies the static analyzer without changing runtime =20
> > behavior. =20
> > >
> > > Using wildly oversized buffers doesn't seem like a recommendable =20
> > solution. =20
> > > If the ring library is ever updated to support cache size elements =20
> > (64 byte), the buffers would have to be oversize by factor 16.
> >=20
> > The analysis (from AI) is that compiler is getting confused. =20
>=20
> That would be my analysis too.
>=20
> > Since there is no good
> > way other than turning of LTO for the test to tell the compiler =20
>=20
> There is another way to tell the compiler: __rte_assume()

Tried that but it doesn't work because doesn't get propagated deep enough t=
o impact here.
