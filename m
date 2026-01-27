Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8FED2FEE0
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 20:37:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A84FF40F1A;
	Tue, 27 Jan 2026 21:37:51 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 2120640E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 21:37:49 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so7796359a12.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 12:37:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769546269; cv=none;
 d=google.com; s=arc-20240605;
 b=BfGnHzFSUGhl99mwHdX9IErOZS5VeWE0NNcomLxPC/lk9L4RNCrcSxwAojgVHsdTtM
 lelKC68vC+lv2oRJ3t06B1ckLZiMbfgsd6yryeJNna2TrcY/mTAL1DJCg1qHmppAgGhm
 qFb2Ogo4TH0qcDzZrycqhFLGmDGBCOx0qE3KN74uMkOh6DSkyysuOfI3MlSLlL+V9QWR
 SPUJR8qSrBfo3epjcik/Voi2+vztdoQoFZeh2yWJtA+8FBADq15RvfGYLLJtfcfoQbGd
 YTFlzZD3WQbgjd9FqUEyMaiuCKupPt3GaOErz4XR4jW3Qm2vfVMsm8mWtCDxZ76ymFZr
 MPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ni9PCKmAwqXupSSodWVPRbM37JImszU3LwjOvl9SWOc=;
 fh=o0+cb97Tr4blSBI0WK5uaLUecqRqaP7ngByp48W1ZlM=;
 b=Hs+IlWIxVdalgW8HrQCe8lzgQyrFG8ikd+134iUGhTE8H4AV0Y7GM6mBwO6UxLk6cN
 sF6wZSurewNFbKKzq5xqId30ka2QoToLWrl45obuDDEjWFOAuftPmJ/0VsFRGy52GVwu
 bUf3BVEsckhh3FeFBaHwqWc7rGm7YqYi0vBRq47iRZ20CS94oxNgKOqbFmgFHCxbCgKy
 kDelAZbrwSqIeYqUXRDWhZMzq4ZrgA5rLr0g8f6Vj03NnesV1cPuGotKzQDG6fE6gKD8
 /YQcOpOZalmWhjNM4mJCGi1z3QgJDxI0jurL8ORxPAoLGEEuzUlr+DjrCcsD0nlbMilB
 I6og==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769546269; x=1770151069; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ni9PCKmAwqXupSSodWVPRbM37JImszU3LwjOvl9SWOc=;
 b=K4BN7W65AKA071vtFlPWK8TIJMbXJSIj7VkjFl585fgedtl2yJpkzTHEuQ82eSbiuO
 fsTHQIwfC8MhmO8ERPaExacRdEDHb6/7ljMbS9wZHpjj/8ulAfrAce2qenRH9bpNRwAP
 ssK5lH1AmcPPQYw704ir+oRjwwJDIWK73AbN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769546269; x=1770151069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ni9PCKmAwqXupSSodWVPRbM37JImszU3LwjOvl9SWOc=;
 b=s2UwVytGgWE5n6yOQepZg5bpLlzr+OqgWGx2+EoSIMVTigUH2qjxtzlcBTcjhSAZsv
 rdcsdMrGsYMxj8n8N3zJ2Jr4y+4WZqRupQwf3dqtFXygL3YYXAfM1bYBm74qilzvoLgu
 0YbHaA/PakVxkdYSOTx4AOSqDB5Ed0IZK2L7RFmBREIcwqguToS6A3Tb8OWP6LwHf00e
 cEvHaZPWobM3uW22GR7kRUO3Orqi2KhfJ3VF/SXMDFlWpXPTY40zr6QRBy/PUcl1YhoB
 7bNf9LFaZWvnDa1FnathIVpxhULKrBNENKZ1RJ+Lg/prITHxHlolb5eenfV+T8Najm+U
 6KyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDFK4aeyb6Nm5S7XPp9SC21+osPrWVu8hLIy8kLf7xj5cbQvrAri+rcACtJr0R4/qFLjQ=@dpdk.org
X-Gm-Message-State: AOJu0YyjIQpJC8Nc0p3TMP+wHigIOkebXI/NiIUGTj7SeXr8rSO0Sj/j
 0x3XexicJZIdZh2ZjNLumRkdA+dcLIG+rSXiZwvp7ZqOA1N30cIsGHdxp8E4BhztMHXJhvghPmM
 lpeB/zrXSvOrUFqUYXdRQoNh8DjyX/v/+mgcr37+5JA==
X-Gm-Gg: AZuq6aKULt9o4T4fNmMwR0ODJhq/1wGRrhucpA0bNhjwMnkiKiTmROCMQ2sF0yGeHp0
 Nsy5Hu1KH6zTOcokxkxd3yIC50xcLHQFf9q2M1KTX+2VwXBBCD7BgBnJsRRwy1+L99FWVFqFWD5
 8MaagNiGVQhuN7LnZxeEkBej0/nN4gFisBti8T0qQpK0jPrClQRGofVhw6Bi2R0SgbHF3Rrx6Je
 kq/drcpmQ2PA9w+5DIMZddcNwwFTAOPDINkt61QBrLNMUTnDM+yPr/XMq2Mc3kHNflyEp+ydGLI
 bWW7GOKHGB9o1wdvUmpFrLPRRqAA
X-Received: by 2002:a17:907:6d19:b0:b87:2c3d:ef08 with SMTP id
 a640c23a62f3a-b8dab346cc6mr242325366b.33.1769546268621; Tue, 27 Jan 2026
 12:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
 <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
 <CABJ3N2W6QXQ1Aae4QWaZhSMrwMfmDa6oYjHby1YDQJdK2FknvA@mail.gmail.com>
 <CABJ3N2VTZc-73hP=0KG8EPbdrCexYZXToLzhJPAhkN+Eo77DWg@mail.gmail.com>
 <CO6PR18MB4484327639EC118ACFFF3810D881A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2Vf=guy5qJmmbTHY76Bnnn-5PTEkmB+FewahHqDzxJLiw@mail.gmail.com>
 <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Tue, 27 Jan 2026 15:37:36 -0500
X-Gm-Features: AZwV_QieX8Y0NSGU9N2sSflA3IHu4Jpo-jw4rxIDZrY-2W4C4A9jCNLr36Y35xQ
Message-ID: <CABJ3N2UzbranA3ZTjm42Vf2UU8ajYh8uNVvttzm_D7z+oqH5uQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Akhil Goyal <gakhil@marvell.com>
Cc: Kai Ji <kai.ji@intel.com>, Patrick Robb <probb@iol.unh.edu>, 
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "luca.vizzarro@arm.com" <luca.vizzarro@arm.com>, 
 "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000c149aa06496498f5"
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

--000000000000c149aa06496498f5
Content-Type: text/plain; charset="UTF-8"

Hello again Akhil,

I have a couple more questions regarding performance and functional testing
for crypto-devices using the DPDK crypto application.
The crypto application supports both cipher-only mode and cipher-then-auth
mode. I would like to clarify the following points for optimal test
coverage:

1. Test case reusability: If a cipher algorithm passes validation in
cipher-only mode, can we reuse that cipher algorithm across all
cipher-then-auth test runs while varying only the authentication algorithm?

2. Operations threshold: What is the recommended number of total operations
per test to generate statistically meaningful performance metrics? We are
starting with 30,000,000 total operations per run of the app.  since test
execution time is always a concern and we may run dpdk-crypto-perf many
times with a broad matrix of ciphers/algorithms based on your response to
question #1, we are curious if there are tests where the total-operations
argument can be reduced

>

--000000000000c149aa06496498f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello again Akhil,<br><br>I have a couple=
 more questions regarding performance and functional testing for crypto-dev=
ices using the DPDK crypto application.<br>The crypto application supports =
both cipher-only mode and cipher-then-auth mode. I would like to clarify th=
e following points for optimal test coverage:<br><br>1. Test case reusabili=
ty: If a cipher algorithm passes validation in cipher-only mode, can we reu=
se that cipher algorithm across all cipher-then-auth test runs while varyin=
g only the authentication algorithm?<br><br>2. Operations threshold: What i=
s the recommended number of total operations per test to generate statistic=
ally meaningful performance metrics? We are starting with 30,000,000 total =
operations per run of the app. =C2=A0since test execution time is always a =
concern and we may run dpdk-crypto-perf many times with a broad matrix of c=
iphers/algorithms based on your response to question #1, we are curious if =
there are tests where the total-operations argument can be reduced<br></div=
><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div class=3D"msg-5841279856823272795"><div lang=
=3D"EN-US" style=3D"overflow-wrap: break-word;"><div class=3D"m_-5841279856=
823272795WordSection1"><div style=3D"border-top:none;border-right:none;bord=
er-bottom:none;border-left:1.5pt solid blue;padding:0in 0in 0in 4pt"><div><=
blockquote style=3D"border-top:none;border-right:none;border-bottom:none;bo=
rder-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin-left:4.=
8pt;margin-right:0in"><div><div><div><div style=3D"border-top:none;border-r=
ight:none;border-bottom:none;border-left:1.5pt solid blue;padding:0in 0in 0=
in 4pt"><div><div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</div>

</div></blockquote></div></div>

--000000000000c149aa06496498f5--
