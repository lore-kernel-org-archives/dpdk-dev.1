Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609BD1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 07:39:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4D474066C;
	Tue,  9 Dec 2025 08:39:30 +0100 (CET)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id 439CE40280
 for <dev@dpdk.org>; Sun,  7 Dec 2025 09:11:27 +0100 (CET)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-787e35ab178so27082127b3.2
 for <dev@dpdk.org>; Sun, 07 Dec 2025 00:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765095086; x=1765699886; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9o6pBZJqrMm/9i6eHWG0ea+U8i39DNFjBS2zNZLHqzU=;
 b=UFHlIVQNjHThg4/qDzLGKVHNs1sXseItbc4EcSyNj+JJT3+5+oVN7hpCvsUIlWbz0r
 kTj9/KTbG1TRPyNV2dKAzbxZygNwfVtIRg+WEUFS1c5wSrvPV2WI9wqXB461W0DfIxsS
 iJ2GgXcf7ufRbiWaMMYzZRiosBkITTML/HP5RyjrwWHDuM0haiHVvSr2wZY3nwpnR4AD
 R0viYKSVBMzk1eU4l7ZFkjidfTR+hYZyOBrpaksAUX1BB0iuxUj7Tj7twtlGd9dHMohQ
 DttzjluUbnTCcxlEVVH7kiIIAwoz0bRmXDECkuYM5dARp+aNREEnD4GKNzg19Q9ooCt9
 JwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765095086; x=1765699886;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9o6pBZJqrMm/9i6eHWG0ea+U8i39DNFjBS2zNZLHqzU=;
 b=bopovVqr028+Di04jjhxBT/lzsa2NB3pRMmAEc9pP+dNEEAb1JSKH05BLpObkIUKhP
 LWUfivPqgtawDUgBU7CUPlI1TfvAMQyIVhTcb9yyTEsble1aPMKYjLg+JvsZt8Ipqx2z
 gkJa80LfD6mjLdpUCSyeSEvybeb6QF9vYiFS7kcP1UDtVrvXddQty8fJD1XhXRrq7VoO
 NyzCm06oNWoISSjUeCJ5f0w8BUo5gFfuNIvKIDHYG2S9n02eFAbMA3cLoM33HClzbgJ6
 7ItA6aPzb2dnNtT3m+bezvsKzujk81MO6nJBBzGU09OkX6SPNQSigVsVnPsNoFDlMX2l
 9NyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+XtngVlck2kwfQ+ZnoPZ0re4b3nbaYN60cs/7YIYzCHvhEc3MRrm+QDa/d4+UPlOceno=@dpdk.org
X-Gm-Message-State: AOJu0YzkcBroCDMRhjNgEI6hWWKiEp2SYocELWhO9sl2gOaTgoiYJQky
 2GYUYhQnqIADMgv1TjHLR9mZ0GpH6x6ubii8nFv1GiGVoea10qi21yuV80UPOKXdbTBBoJOC8gh
 lc9+c32T7JK9U3oY1cfFK4HZJWNmIEhzBpw==
X-Gm-Gg: ASbGnctlbwxuzoma0bHEeRLd9//H30LdOofx/C2s8MKrUj+L39BT+FXJpNVo9ljeFdo
 A8Vw7ut7wuyDJek6skQpo31OOQIejH3huFjhyFn4myzqIWtA8DtEfJXsQzWzV43QPyPmJBkFMCW
 U/xjsx0bkz+9n5ZrH5/C1QimlkGgzz4l/3ROM1/wTR0OnW3rdw9s6T/23nW2Aoeh4X1qpqQcMP5
 n84HBIj3AQHO3+MM5gTwNKrQnk8gAcrQv6qXOl5WnVi+RKZF04YcYHSR8Jkpz1WFoGov2IS3Mwm
 3/tFkUFTUlEYK99pp05nWxp9jy8=
X-Google-Smtp-Source: AGHT+IH3WrHuKzM2gd0nUyIy5eac7RZy1MSzPhR6L37gcGpYMnwrWjqBHVlp3m6tFEU2vEK2iNDnikPY/JRj9vjaNfs=
X-Received: by 2002:a05:690c:4985:b0:787:f793:b573 with SMTP id
 00721157ae682-78c33b75270mr40556457b3.29.1765095086418; Sun, 07 Dec 2025
 00:11:26 -0800 (PST)
MIME-Version: 1.0
From: Matt Goralka <mgoralka4@gmail.com>
Date: Sun, 7 Dec 2025 02:11:15 -0600
X-Gm-Features: AQt7F2qey8DYX-MIxhYDqUP6_g1sIamYXHL7IA0rFUrL3pl2YZm60m6BI_GFyW8
Message-ID: <CAMf-ZCH+EuZxuUyvrJCJacC1JO15FccXNkg2+nuC4+nMGpJDSg@mail.gmail.com>
Subject: contributing to dpdk
To: users@dpdk.org, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009eed9d06455839af"
X-Mailman-Approved-At: Tue, 09 Dec 2025 08:39:29 +0100
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

--0000000000009eed9d06455839af
Content-Type: text/plain; charset="UTF-8"

Hi,

My name is Matt Goralka.  I'm interested in contributing to dpdk and am
wondering if you are taking people and have a few questions if someone can
help get me started.  I have a computer hardware engineering degree and
experience in web dev so not totally starting from scratch.

-How do you guys get newbies started?  Can you kind of get me going?
-I have a gaming laptop with a Ryzen 7 chip and NVIDIA GEFORCE RTX 5060
chip.  Would it be enough to virtualize linux?


Thanks guys, looking forward to hopefully working with you!

-Matt

--0000000000009eed9d06455839af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>My name is Matt Goralka.=C2=A0 I&#3=
9;m interested in contributing to dpdk and am wondering if you are taking p=
eople and have a few questions if someone can help get me started.=C2=A0 I =
have a computer hardware engineering degree and experience in web dev so no=
t totally starting from scratch.</div><div><br></div><div>-How do you guys =
get newbies started?=C2=A0 Can you kind of get me going?</div><div>-I have =
a gaming laptop with a Ryzen 7 chip and NVIDIA GEFORCE RTX 5060 chip.=C2=A0=
 Would it be enough to virtualize linux?</div><div><br></div><div><br></div=
><div>Thanks guys, looking forward to hopefully working with you!</div><div=
><br></div><div>-Matt=C2=A0</div></div>

--0000000000009eed9d06455839af--
