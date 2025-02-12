Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E6C021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 02:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A455F402BB;
	Wed, 12 Feb 2025 03:54:36 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 74EF040269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 03:54:32 +0100 (CET)
X-QQ-mid: bizesmtp81t1739328862tn331s1n
X-QQ-Originating-IP: OVfZQzPupXbe3u1ugtSnnGr2UeX0zcKAsE+v+EawqSU=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Feb 2025 10:54:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8445441583197461171
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>	<1739263818-59770-5-git-send-email-caowenbo@mucse.com>
 <20250211072406.59f15101@hermes.local>
In-Reply-To: <20250211072406.59f15101@hermes.local>
Subject: RE: [PATCH v9 04/28] net/rnp: support mailbox basic operate
Date: Wed, 12 Feb 2025 10:54:20 +0800
Message-ID: <87250201494D281A+001701db7cf9$6b2242f0$4166c8d0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLqICmjQftEF0oQ/zI69QXbQqbszQH1sGLdAXpbO+CxCix3gA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NOMiShYPNB/9aRXUYPzvlf23FtpNYqjEIb3naFqlGkcbD7GBK76Lr9oU
 AqXkrozvtyFvcuVtFgqWEKZ6vToiJ6fQgg8jo3ibaHN2ydZJvL/JgVgaz4WtTsuAV5YhAqx
 iP3GZeUZg9651c0sX8CKtGeB/eSelSOdHKkgJqFiRgjZySoK56tapF14/NqTmax0w9JY6fl
 NkJoB/GEJ6QjvSMktRAYW+zwJc6RoXEibvCbV1q/ljxltPGNdOkyjk8Cazd8OGe01USob7l
 bxflDGrLxaVHGdKP7pUNttnY7OLFf36x4NERuUPkOzXtCEdE2qUuK+ALfx5aUwe3v/SwRqK
 1ok0nYIk08T/B6uw/Js1VvUPAi4kw7xxqiuaJQJsRWxcTOXezO817p0Rciv0x/flfUQySAe
 5Gh2TtEL9kqr+MXKhHoSZGzSbv16wHswnGtoLJWYYwIa5FlB1jdPhlu8tjFZZunEwSmtASX
 MP8m+pq9bLRvL73i/mrC+f9XhDuRETe8GmqEoYIGDhZNqqGpLJZ+RWpyedGrjVYI3iaqWLP
 7x18w91taezg9pAyFMR8PSLfcq2iWeAiu2D9Ak8+1UMU5hirQHmUgxePsK/F5g9fULKlKaE
 HKlydtLzI9KIY5rM9re2W08CaT6k+9DKrr2t8Eu9s3HQ+hwC64IQm/B9kDs6YkpoA8ZBUgR
 8cI9BULQynjNbGES8Qcp+mS9RpfYRdWXx8qIp0FNN4JueybntVQeqlGACSoB/SLsXaRr3f6
 dJEZmC3u1usWtQqfnda/9/PhVgMgWSTaUOeLE8hbeIdZGl3Fslcpv8CcEtm29+/W5mMAh7S
 LV2Du4/33vs6eI8FMaQXxF7rWaNkAVqvPnjaTIRPJp0L7wHT4mtuDOvgv8dYlHGJb5BG2dc
 8YRef2LJJ5hTxx+Ld6bmAalTbPh9L0KO6/mVuu6OHvTGfsRFszuqDA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

Hi Stephen,

This flag add will ignore some warning error ?
> +error_cflags =3D ['-Wno-unused-value',
> +        '-Wno-unused-but-set-variable',
> +        '-Wno-unused-parameter',
> +        ]

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA2=D4=C211=C8=D5 23:24
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v9 04/28] net/rnp: support mailbox basic operate
>=20
> On Tue, 11 Feb 2025 16:49:54 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > diff --git a/drivers/net/rnp/base/meson.build
> > b/drivers/net/rnp/base/meson.build
> > new file mode 100644
> > index 0000000000..9ea88c3bff
> > --- /dev/null
> > +++ b/drivers/net/rnp/base/meson.build
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: BSD-3-Clause # Copyright(C) 2023 Mucse =
IC
> > +Design Ltd.
> > +
> > +sources =3D [
> > +        'rnp_mbx.c',
> > +]
> > +
> > +error_cflags =3D ['-Wno-unused-value',
> > +        '-Wno-unused-but-set-variable',
> > +        '-Wno-unused-parameter',
> > +        ]
>=20
> Put the first item on new line, meson is like python and similar style
applies.
> It is disappointing that base code is so messy that you have to =
disable
warnings.
>=20
> > +c_args =3D cflags
> > +foreach flag: error_cflags
> > +    if cc.has_argument(flag)
> > +        c_args +=3D flag
> > +    endif
> > +endforeach


