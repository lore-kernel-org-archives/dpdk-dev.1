Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D7CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 756D540DD0;
	Thu, 16 Oct 2025 13:44:48 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 444E740269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:44:47 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-28e7cd34047so6137695ad.2
 for <dev@dpdk.org>; Thu, 16 Oct 2025 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760615086; x=1761219886; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o52IIGNCw2s1aZRtUPfAkM2ssU3YaFF9f+yMdc7/EBg=;
 b=Oc93h6WDDtR4N5d1r/pO1jk5/BbXGFuTJftrWDyNd5EL8unpFzLwomrSMG0IBYGhGV
 fjRNAo0KePk4XWIcT61/NOJBSDEaKuf+hNyXMlWuLyiykLXjsmAKGYPRXco7qeGZyvYG
 0pZw5gopru+NIHkpF0j992dK5IYcmyqBjRhNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760615086; x=1761219886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o52IIGNCw2s1aZRtUPfAkM2ssU3YaFF9f+yMdc7/EBg=;
 b=L+6k0HKXSU9k8KZ5MKonzCkUwtLwbXI3EDkcEOAywxdXgIp+8X1L4oNh0QZzGZ2QLu
 KYryfe9whrsdwLs1tGYr+2Etvbwg42TWl7tXmpLHiewKpDY4XOHlbEhNFRIp5XHntpwh
 xRVTZ7odf5YYiTsB7PY8L3hVG4V6yC+ervOeedG7fJNrn+Dhf7zfZ6oeGAYaOklVIKv8
 UysCWPZfXD9A9lG/145O3sRhoO4n7xwd4a6MTLl0iBGziB9lAzjxmfrvHb/cV6RhLEHk
 kt36/xK1ZdWoTrsQQgKdoQTvlKnNVpl854BxOCqSpa+N96gcWHa2EVpkoYH+0XPSIjkU
 FY0Q==
X-Gm-Message-State: AOJu0Yx8gwIZTdjELE/5VvyX2l+TjQuygQINwh+NE8ylBzV9XTUA1Fes
 dkLCd5Gq+oJiYdlwmZI0xFbqRaiYcqtJnIiatC8IJCMy4LEQuj4E+bVwXfONR/9VlvWtCBYsmK2
 R0RnIqXNZ2fMJp0H70uX76mpIdXetfNlDPwmNt4bt2A==
X-Gm-Gg: ASbGnctZAgco3jCrfiIbXaDmjDbIPcHhVY2q8ZHCmoECubde9IQZSzwErZiQJdcGBCc
 qws/+hkwygMfTm4dFjp/RyBXJhzOWt7mbEsIKY7ziwfT15vu/rkVgN54kNrPdmfCFXrcm+nbZTI
 LwdWd9BpmI4XTsSt+lItnmU61+D7vEyqMG17Irc3NOsRfInR3NWY1qyxRydRqQo358lt2q7xPwm
 V5ZAE+G3Ve+mZPzHJV395evoKQE/8QJ2eopgFaVfd+x508OtIicWBpsRCiXt4qpXP2l2zqgu9KA
 TVFKF/Msj7hjKDTg
X-Google-Smtp-Source: AGHT+IE4Rldn0ST0e6MeAYROMQrFwucgHJVoO6ahuRbNE1NO970R5uLugDpkkz4RNz/k6EBHZzIyMXuRn28u9zKcoD8=
X-Received: by 2002:a17:903:94f:b0:27e:c27f:b834 with SMTP id
 d9443c01a7336-290272f7e6fmr419639365ad.56.1760615086402; Thu, 16 Oct 2025
 04:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250923103758.3192015-1-paul.szczepanek@arm.com>
 <20250923103758.3192015-3-paul.szczepanek@arm.com>
In-Reply-To: <20250923103758.3192015-3-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 16 Oct 2025 07:44:00 -0400
X-Gm-Features: AS18NWBanZ4EHixWJeABAIs2wdca8_orLoonRnSMpImWr2KjTkx1CAygO0UTqrg
Message-ID: <CAJvnSUDfnBBM153LTcoDfddde8dLOLQrqNUh3_6wsbYdFwMh=A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: adjust all tests to use the new API calls
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000cfc09f0641452432"
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

--000000000000cfc09f0641452432
Content-Type: text/plain; charset="UTF-8"

Looks good. My only concern is whether this will limit packet/test function
visibility by pushing people to explicitly import individual functions from
the API. I don't think this will happen because it will be very clear
developers should review the API files before writing a testsuite. And, if
they don't want to do an individual function import they can always do a
"import api.test as test" or similar and have autocomplete for all the
packet functions. So, I think there is not an issue and we are good to
proceed, but I figured I'd just mention my thoughts.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000cfc09f0641452432
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks good. My only concern is whether this will limit pac=
ket/test function visibility=C2=A0by pushing people to explicitly import in=
dividual functions from the API. I don&#39;t think this will happen because=
=C2=A0it will be very clear developers should review the API files before w=
riting a testsuite. And, if they don&#39;t want to do an individual functio=
n import they can always=C2=A0do a &quot;import api.test as test&quot; or s=
imilar and have autocomplete for all the packet functions. So, I think ther=
e is not an issue and we are good to proceed, but I figured I&#39;d just me=
ntion my thoughts.<div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--000000000000cfc09f0641452432--
