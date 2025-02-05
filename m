Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B06C02193
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 00:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7B08402E0;
	Wed,  5 Feb 2025 01:11:27 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 5F6A6400EF
 for <dev@dpdk.org>; Wed,  5 Feb 2025 01:11:26 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2f9c69aefdbso2085552a91.2
 for <dev@dpdk.org>; Tue, 04 Feb 2025 16:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738714285; x=1739319085; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xfZvOXthCrX/Cgj71DazQ1U5nrFvi6nJ12dd9wAOIGk=;
 b=aLIMUXWmLEtLjug1h1DXLBGlU7ZHgkCvxAqetcCY6J9J5Zxk4aGGlzW83d0nB2uEIY
 iXIGCD2kgIU+0FSVeGjkEh1diH6yFfXSWe5R+okGV+lDjhm7LU03Dz6HwrHM6i/VgWN1
 0iSbYKUwVuTUv3fkuUSQgzCVQUmvHzj53/iow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714285; x=1739319085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xfZvOXthCrX/Cgj71DazQ1U5nrFvi6nJ12dd9wAOIGk=;
 b=OT/HXjQEQmZIpTHwBvVjGODp6aF29izAUNd2K8b445750BrlLNWxwJMHfiiDVEy8nr
 EyEG2vf5AefnRlApZ4W7aiUFrki7YglnFddWXgT4iRNrsbMd9pxzrpEbLOV3j2iHNP0G
 JeKZsSOEOGyDdFR9jHxhCKlksseFRii2MOXeWFE5/BzsxRRXwVcX6F06Zk/1oDRb+s60
 g0NzvC7LRVGR3I0cadOWolU95TYETVDcHvI6G3XBum1+vSRCEX4f1dC5qB9IN/nRJzok
 t+3jNOdN4tVXyEj/QsZcqD7nScjm4Q1shyuoMOgwHIt2aXZGKuj0bq7CkOb3SiG8W2C8
 rQ6A==
X-Gm-Message-State: AOJu0YyyuNwU1iS6Kx8dMPfoqvwkZnfRgHFR0C40OdgEB3bTvwIpkXcg
 HYiu2ILU7jU4X9+n9619HWJtb74uo0ig2PJBX37bz1jnmtsPS7Lk6hpYGy9vjBMEXrwp70RxiMA
 nt7eUMClRP6p5zICtcp408qULC0zIzfGebbUAZQ==
X-Gm-Gg: ASbGnctguWPcvlM06tDZC/n11TnyGBggau9OpWngXD/qqLBRBnv2ntWYn68D4hFjoNK
 A42NPI9RBQ3sFOaMLPL63eYehQzlIoEG77C8Zdjn1MmWtAOKjlD/KFbZbdxo3BNideRd9EbU6/C
 JfeXCCLMkoXWDNhJhfQUedRn6XJd+XrQ==
X-Google-Smtp-Source: AGHT+IHLaEVY7FGmMx7cgprZk5QmFNM4eIGlEpHWxVFtrwSgoVacxkxvCRn0hgPUqIuSV4Cd2/wZO/B/FiG7Hk6HJg0=
X-Received: by 2002:a17:90b:224e:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-2f9e075e22bmr1222666a91.11.1738714285553; Tue, 04 Feb 2025
 16:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20250131191924.1936157-1-luca.vizzarro@arm.com>
 <20250131191924.1936157-3-luca.vizzarro@arm.com>
In-Reply-To: <20250131191924.1936157-3-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Feb 2025 19:08:18 -0500
X-Gm-Features: AWEUYZnqEvDRvVCKTP1n1GrwO88YWUkKT_vR8g-_qFNLJThiGu41JYHQuEr_M1o
Message-ID: <CAJvnSUBM04xRA-Hj3CiRiHbNc3vhTvVzo_K64uUVmsSNO23Few@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: stop using partial in enums
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000005b584e062d59f723"
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

--0000000000005b584e062d59f723
Content-Type: text/plain; charset="UTF-8"

Tested from a Fedora41/python3.13 container.

Tested-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applying to next-dts, thanks for the patch Luca.

--0000000000005b584e062d59f723
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested from a Fedora41/python3.13 container.<div><br></div=
><div>Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">prob=
b@iol.unh.edu</a>&gt;</div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"ma=
ilto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div><div><br></div=
><div>Applying to next-dts, thanks for the patch Luca.</div></div>

--0000000000005b584e062d59f723--
