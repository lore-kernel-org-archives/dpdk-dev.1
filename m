Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FAC02193
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 00:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C53FD4021E;
	Wed,  5 Feb 2025 01:11:11 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 303D9400EF
 for <dev@dpdk.org>; Wed,  5 Feb 2025 01:11:11 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-21f08b44937so15476505ad.1
 for <dev@dpdk.org>; Tue, 04 Feb 2025 16:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738714270; x=1739319070; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LRYAHfU9scQCMIalaI36Mlmtx5btEYBKO4tNAlfiTGs=;
 b=OSDFlv+GEw4tbz8Wdo6Nb7YEZA/+l/uvIGrvlB+urW2BoiozSJJQnHdrwOU3lsPSZD
 WAS56kTEIWIeYKROUn5itRMpnwa2Be23HN98ELM9kmTZx6JDc4D1YZAhAtrgbg9D0RjD
 nt6eH8+Y+GUKmuyDMgaAcQXjkZfmzdOYvd7wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714270; x=1739319070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRYAHfU9scQCMIalaI36Mlmtx5btEYBKO4tNAlfiTGs=;
 b=ZWJnn58SoBBygGVokIRyJTix0wEwkRESnWysNRTblBU5OJ4kee3uJr5Sc0wM5hne3W
 quX7mbbD00f8qUo7ODEXTqtWMk8sQQG7rdNZaxajn1+Rkj2NJD3xB8lPBw4SLJOg/aOd
 JSa94op3sq49V++e8Hn3+PfqpyB7Nnn+Fejzw/hmOvj0KabaxACko2HrZI2+x10UxHUk
 rEkXG9nyGHpcCRn7t6mf2vfjNyie8o0zEm8vqWgeoqatkw0GJXRIKDTAM+2ZzSm2AnFS
 C6OJxEkwQxA7GrKO6NbNSLMoV2jDtJLkV3ubNIk0+YTqhSV9ymL5dkyJ5jgUbnutyy0h
 X9MQ==
X-Gm-Message-State: AOJu0Ywkm9upFJTkKa4EM99TE9iL4yqduQnWDiwgt6OAPyaryc+psWik
 Xh09eD7s3PZ7hnQ/qAG68yqiYulAklBvYc0osSMBcN82fI3+lTEHDJEdJOa35aSmO6DEoVMrtb6
 8MusnPhIZ4r+I1wmB2Q9IDA2leiiwET1p5RflEg==
X-Gm-Gg: ASbGnctZnA1t1ls9qLhCKhWCCuf7vRkLc+C8yIyTMPtE1xC5tatcu/r6xkFqnrRzeZr
 DSDztRdbe7TVWujL74Y52VFSktstPCE4eDHSKWLVaAu6KSswsGT37Bc4ZhRo+vJ63VxfqMZ/PpA
 wSimquLzLlMreLCVx/UXXDaRN+Xy00PQ==
X-Google-Smtp-Source: AGHT+IEU0Q6FRmKEemTPOhBdErDTMbOerBqVGc/h1XPCqwTEMp3rzBYm1Fi1/0iT6fz6/QWv4G4fo6e4NDYdoAWkdIo=
X-Received: by 2002:a17:902:eb11:b0:216:69ca:7707 with SMTP id
 d9443c01a7336-21f17e7150fmr9511845ad.30.1738714270142; Tue, 04 Feb 2025
 16:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20250131191924.1936157-1-luca.vizzarro@arm.com>
 <20250131191924.1936157-2-luca.vizzarro@arm.com>
In-Reply-To: <20250131191924.1936157-2-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Feb 2025 19:08:02 -0500
X-Gm-Features: AWEUYZkTb_i_79gD14XjV-hlXGbxs53q2zEsHU5vc_Upm5MU-Ms-VIgzgtVoWqQ
Message-ID: <CAJvnSUBHCGFwazixtzA7pDe4F5nbzshepvVZRazaNYQf4OA4Rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: remove use of field validators
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000703199062d59f614"
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

--000000000000703199062d59f614
Content-Type: text/plain; charset="UTF-8"

Tested from a Fedora41/python3.13 container.

Tested-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applying to next-dts, thanks for the patch Luca.

--000000000000703199062d59f614
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested from a Fedora41/python3.13 container.<div><br></div=
><div>Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">prob=
b@iol.unh.edu</a>&gt;</div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"ma=
ilto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div><div><br></div=
><div>Applying to next-dts, thanks for the patch Luca.</div></div>

--000000000000703199062d59f614--
