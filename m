Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C4C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E28B40430;
	Mon, 23 Jun 2025 18:15:11 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id 369E9402E6
 for <dev@dpdk.org>; Mon, 23 Jun 2025 18:15:10 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-70e64b430daso42772707b3.3
 for <dev@dpdk.org>; Mon, 23 Jun 2025 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1750695309; x=1751300109; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GALKUNNyidPkRPrdjoYTb6Dku1NSodSJzVS+aLHhEXA=;
 b=g1a+3cpRxzWq4KvFqjDlkwnvwVKmTOALYJrpUI2YdDdlnNa+zmwMT9Agyu5Myv3mmZ
 OxWzRSKh52RRBKdV8pgG42FZy0XUWPTEBtz6gQ3exAnsgMHQ+BlCrW5TXlODq4ue1bVW
 OyMn9Rs+ei6Z8Y/3fmkMWFeUZXuh4Rifzdh3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750695309; x=1751300109;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GALKUNNyidPkRPrdjoYTb6Dku1NSodSJzVS+aLHhEXA=;
 b=dm/ugQVa+meNADq1ajVf1EwxrWeZbEellNFb0yjV5y2VLP3g4RNawv6wOaXJcBJj4V
 w4Kft+ICMgCZ6bnXkHWEI+GRa+liyl8fl6LoaEpIkBnNFoL3uUKkTqDM5PH0m0/0DlRi
 IBGupEfCu6+pU5PW/a68s+eVjTgmdvKM2Feg2yLDCcBFOAL20rE4iSKdkZXMJ6M0WwfF
 k7aODRsC/ZxsR5cKZE0EEQE1wFbiDL8hg43RkXOOvFfsQiM35quYpS3uYPKVqqkBHiCk
 Cvxg3v8uwE3wVD5fTNgZU9z1EpPQ/zOIWcjwKEss51RyT7fRsqdXMqvx9koLi78ihH5l
 XwiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK0UrWo4xo3yoppkXS+TiVUjiseLXkQLcgPzNvO+b86GpYSIJLlAywqMcDZuzDvTl5i5s=@dpdk.org
X-Gm-Message-State: AOJu0YyoGBpZoaoxJ8cZx9p0d4hP/QKSRjoJMvN/JwksHoUbumtcb7CN
 oxEvD8BpJaEbGkKwwCcWJHnwxXeRaEoe7D1N9WPQXwflkKGuJPMshfH+KkD+ORiP5MWec3BERyp
 KPXFNVuI1pZ5ilkZAFBVK+i4S5og+cuuln9NCcI8lLQ==
X-Gm-Gg: ASbGncvNa8FWGxh3N7KpdtHbSgKhu286bbZ44bRChfXV1CEZc1Og5YIq5twDbzf1xpM
 77MmeB2rhZe2+rxWDLdGlBvOcdu5Pw/REO8BfPAp5W41lLPuf8wsj0LL1Lx88srtqXwpsTnWWGM
 KHHPBzThNEhhIixWOSdjvdIPZywpO3hUT+qM0DUMEsaK0=
X-Google-Smtp-Source: AGHT+IEg0g6L1EDg2Z/zs2pDpi26G7KORBAB2eAAabJZGeI48RU4YJBortx8PmBLzkjZBP+Na+kMAOFzK4AsfOngO4c=
X-Received: by 2002:a05:690c:7082:b0:70e:73ae:766c with SMTP id
 00721157ae682-712c649aa49mr172488527b3.22.1750695309309; Mon, 23 Jun 2025
 09:15:09 -0700 (PDT)
MIME-Version: 1.0
From: Nathan Southern <nsouthern@linuxfoundation.org>
Date: Mon, 23 Jun 2025 11:14:58 -0500
X-Gm-Features: Ac12FXxkSmJPMXKp_RGCtoOm1wGPtHhbppcRHOX99dXSM-MzYKfwAq1r6leoJ9E
Message-ID: <CAKoDjhwfnV=CUPSnmHabk74TJnDUz=nVJyHQiX7oveyG8YRh2w@mail.gmail.com>
Subject: CFP Deadline Extended - DPDK Bay Area Summit - September 2025
To: announce@dpdk.org, dev@dpdk.org
Cc: govboard <govboard@dpdk.org>, dpdk-techboard <techboard@dpdk.org>, 
 "sylvia.vasquez@intel.com" <sylvia.vasquez@intel.com>
Content-Type: multipart/alternative; boundary="0000000000000589f506383f84a1"
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

--0000000000000589f506383f84a1
Content-Type: text/plain; charset="UTF-8"

Dear DPDK Community,

Our CFP deadline for the 2025 Bay Area Summit in Santa Clara, Sep. 17-18,
2025, has been formally extended by two weeks, through Sunday, July 6 at
11:59pm Pacific Time.

You can reach the CFP page here
<https://sessionize.com/dpdk-bay-area-summit-2025/>.

We look forward to receiving and reviewing your submissions. Thank you for
your interest and let us know if you have any questions.

With appreciation,

Nathan


Nathan C. Southern, Senior Program Coordinator

Data Plane Development Kit (DPDK)

The Linux Foundation

248.835.4812 (mobile)

nsouthern@linuxfoundation.org

--0000000000000589f506383f84a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Dear DPDK Community,</div><div><br></div><div>Our=
 CFP deadline for the 2025 Bay Area Summit in Santa Clara, Sep. 17-18, 2025=
, has been formally extended by two weeks, through Sunday, July 6 at 11:59p=
m Pacific Time.</div><div><br></div><div>You can reach the CFP page <a href=
=3D"https://sessionize.com/dpdk-bay-area-summit-2025/">here</a>.=C2=A0</div=
><div><br></div><div>We look forward to receiving and reviewing your submis=
sions. Thank you for your interest and let us know if you have any question=
s.</div><div><br></div><div>With appreciation,</div><div><br></div><div>Nat=
han</div><div><br></div><div><br></div><div><p style=3D"margin:0px;font-str=
etch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica N=
eue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-alternates:n=
ormal;font-variant-ligatures:normal;font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-feature-settings:normal">Nathan C. Southern, Senio=
r Program Coordinator</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Data Plane Development Kit (DPDK)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">The Linux Foundation</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">248.835.4812 (mobile)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal"><a href=3D"mailto:nsouthern@linuxfoundation.org">nsouthern@linuxfound=
ation.org</a></p></div></div>

--0000000000000589f506383f84a1--
