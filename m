Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07FC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 17:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 335CC4025D;
	Tue,  4 Feb 2025 18:45:13 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 157B0400EF
 for <dev@dpdk.org>; Tue,  4 Feb 2025 18:45:12 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2166f1e589cso44362495ad.3
 for <dev@dpdk.org>; Tue, 04 Feb 2025 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738691111; x=1739295911; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+5MGi+xMT408L8LW7gYnsNMgOJuYaDtVUlGn/PzAYJY=;
 b=RpZb/g99njgCI+aB4IT9+i74WB0DdLC5gwmpI+qwm5SFTExlBpBRo0h5rc1Y44YLUq
 hOBf/qe51PmzVXGpNFxrMTYHGLKLT2SSrOKgNbwwqWZCBDJEZQue1671v1Va3M5bWMX3
 al/qpmPjGM46NYcBF5+nLiIkjHcaf61j122aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691111; x=1739295911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5MGi+xMT408L8LW7gYnsNMgOJuYaDtVUlGn/PzAYJY=;
 b=onmRTepfwXh0Pt6qfkRPIyGS6tq/+PCBj9tvTOpbNfpPVzHOKGkW2ZTWey//VG93Ia
 oruIX0CS/KSKyKyaAmh5CpJ55GGqA8MRaKrR19lTb9qnGL13twTrU/0kgnQpteWz/X00
 aIQ4wFmT+wl2DEfTedLPKQIX5r9Ew36FGzC3JB9IojMQkxFNWVCYGVjshbGHwS5Rs/ul
 eS6Y+phmYCf/hxanMXPmtaJScYf4Ps+zA+Qb26rk9AjRd6uK37YS4RsjdrqGskvN5uYl
 8qfDqz4B59xm5Z8Z/14Ggwu4QeE2WPhUjJdkni1OA0dUWEiZfjFGD/0SGetaujslpwev
 8mwQ==
X-Gm-Message-State: AOJu0YyiJZwJA0EACdWG3gEyiPnnvZXdSrqD37j8aNnloe3hvYsLtmOM
 moy9gb83iciAzRuTKOe/SvcPQi69om6QFENActuUNq0rw6dsIkGJaVX/O74yLv2bhng8jchSBL8
 asQvK1aS9F3m1GTSRF8LT+oEYZ9cGAv3f4kWf1Q==
X-Gm-Gg: ASbGncsJKIv6Vq4ynMbBNKCjAwgJR3e9IO/ELHqQDjh/r2F5dlPYEVI231igBKIAfeb
 wMZSwmrvD5HYO2oaD84I6rDU1rx+xeS5zAVC1rBD7qKhGfuoL1vMzaIAxK7Z7J9f5TS8NFUicJ/
 zs4/9dGHIO1VY=
X-Google-Smtp-Source: AGHT+IH4F6jBGS7p9dptMfJ11RQcnLOFhlIS/SP8DQLF6W3Iu1JrdFgkcPKqw4i7GuAbGqbx0jh+4CJC1xbiewyQt6E=
X-Received: by 2002:a17:902:e94d:b0:21f:52e:939e with SMTP id
 d9443c01a7336-21f052e93f5mr47082765ad.28.1738691111222; Tue, 04 Feb 2025
 09:45:11 -0800 (PST)
MIME-Version: 1.0
References: <1733848355-19048-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-1-git-send-email-andremue@linux.microsoft.com>
 <1738634318-12876-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1738634318-12876-3-git-send-email-andremue@linux.microsoft.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Feb 2025 12:42:04 -0500
X-Gm-Features: AWEUYZkshCqAs-kI7TorIqeC2A3We_7Ug57Dp8ylr5B1Ukp2Izxv42wBcJXkFfw
Message-ID: <CAJvnSUCPs17GEFBpOuJEnSLLh3exj_iTUNxOxBTjNmMpfbdyuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] stack: enable build with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Content-Type: multipart/alternative; boundary="0000000000000f180b062d54926a"
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

--0000000000000f180b062d54926a
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Triggering a retest in CI for the failed performance result.

--0000000000000f180b062d54926a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(51,51,51);font-family:&quot;Helve=
tica Neue&quot;,Helvetica,Arial,sans-serif;font-size:14px">Recheck-request:=
 iol-intel-Performance</span><div><span style=3D"color:rgb(51,51,51);font-f=
amily:&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:14px"=
><br></span></div><div><font color=3D"#333333" face=3D"Helvetica Neue, Helv=
etica, Arial, sans-serif"><span style=3D"font-size:14px">Triggering a retes=
t in CI for the failed performance result.</span></font></div></div>

--0000000000000f180b062d54926a--
