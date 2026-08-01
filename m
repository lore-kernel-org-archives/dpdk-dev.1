Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E7EC55173
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 15:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27B6A402BB;
	Sat,  1 Aug 2026 17:22:26 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id A18D140299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 17:22:24 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso22351885ad.3
 for <dev@dpdk.org>; Sat, 01 Aug 2026 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785597743;
 x=1786202543; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2lJ/9/yZ/wT6hPddLsHPkgO8yWasEwREUGv91Degv9M=;
 b=m9yfD5Tuq6OvysdyqUORdwi/2Qc0EqGZvpucrIXnxmnvmNKwBBo7fm+pEUMPCPbuxn
 ZRhcrvjDGblOKSiDATBq7/Ct87jG7GsP91+7hhq4f0G0+qMigtoaLWacDmFKxtYz7igj
 u0TdV9D4FQAjHI6fDlDr5aO0HnDnti+J6Ir0Q21ZSFN2+BjU7gTdSb+RipGnVmObh1nq
 z1iG8XQrKz63I3P1ZVXu2iIrQYFevy/x7qeWtfdq2t8WKGGzgCZk3twrk11WwWWqFMmz
 JMVMsZvn2SGjAnrlWGCnnMfoTlbIfTlLObzhlMy+OuFT1fJ1Q0xOMTVvqcUauAOurzb+
 Ogdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785597743; x=1786202543;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2lJ/9/yZ/wT6hPddLsHPkgO8yWasEwREUGv91Degv9M=;
 b=QjAruR/gjM1GEWyb6pIHTXOLbN88H/aERH/RHg3jCAGJJ1SgHWisYv1/8S183VFZYd
 urF9JO0gvWJGAt3pZAwOGxN9alLfMhxk3pzVydJ3KxyS0cVvMxogtHvy9ISdbFF+oMik
 sOwroMyQcG2YBEm0bVFx0lxQxjb71bLMBb0sc6mb/UPEF/rb4JtqSekKa0QyMSVFagQ4
 2wtec+K2CRQXmiDiRs53MEPI6pigFitgwcnbC5tqcXb9HjED8oKUAL5ZlpXccSxp9JHD
 s1ZKE5BejaTPFS0wEpI8EX+mlHJL9/7QL6GLqvxcDoEUiKKo8V1VGu9XbLSmQRncwTXz
 JAkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4GYB6C3YoqSAbZS++fNOTZm7doGJLsN4O8adr2+r0wKibh2LmehN3jmu2bAIOLs4Hfcs=@dpdk.org
X-Gm-Message-State: AOJu0YyiVW2zCv4cwl9NPd9lD7E2PlmakiMVHc9qQdazLT0NppIHqV0t
 kP8JxfZA0lp4LJane9hbPcluPO2vkyIv96E8rvqDSomn2HQT0b5LadHNviLT2JJ239M=
X-Gm-Gg: AR+sD10SNqOcyZALc4Wkx+50qeMI3h9lWXjxxbEwGDnrf2iFfrXrK6XhNDWgBkQKy/S
 W88fG1XjvnM38NwbPuaeOr9l9y3hfMbwE1zBjk57JySkNd5ROkoag0dldwof1sEgF4PnMAVOfpt
 vB/VKIAfcoNDzbIlbMusWXAZEk1NuVdrjOgwj12Q/jfF4gF1r5bj1DtMzi68BF00+QUG/FLj/+6
 pMT8siZX0B0RghSkkjviB/gkHuOEJY7lJpC+0wTBfADiu4SDpVG019XxTO6QjMJdlhcSr3cVoFw
 AaHqnCqfUlUzJY5AlCBtAFgj7EK6MGRlpaUHfCZ9P1/JbVDgQcSSUxN6HoQzot132Kt4en1JQa2
 s7aYOXI4+ETsDUUPWMR1vYqPpJh1mo9nMveuXLjG4/Jb21L8UGCrVERHUZGtPRrRDTJVFeFpjRt
 L7hFQVaEm2DEFH474gFXs8QWggrgUBwwHXNvwBdaTYSlyTmgeVSPFcuhGMu33NteY3464AMjP/F
 FX++kJd9EQadOAjQ2CCMIIILuaS4w==
X-Received: by 2002:a17:903:3883:b0:2c9:b396:1a55 with SMTP id
 d9443c01a7336-2d0522023b7mr37304265ad.12.1785597743603; 
 Sat, 01 Aug 2026 08:22:23 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e18e70esm32771220eec.29.2026.08.01.08.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:22:23 -0700 (PDT)
Date: Sat, 1 Aug 2026 08:22:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <bruce.richardson@intel.com>, "Anatoly Burakov"
 <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: ice driver compiler warning
Message-ID: <20260801082220.314a39fb@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
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

On Sat, 1 Aug 2026 11:00:38 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> ice driver maintainers,
>=20
> Is the ice base driver still defining structure fields with [0], or has i=
t been updated to use []?
> Maybe the workaround in meson.build is not required anymore:
>=20
> # Bugzilla ID: 678
> if (toolchain =3D=3D 'gcc' and cc.version().version_compare('>=3D11.0.0'))
>     error_cflags +=3D ['-Wno-array-bounds']
> endif
>=20
> Ref:
> https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/ice/base/meson.b=
uild#L49
>=20
>=20
> Venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20
>=20

Looks like it could be dropped. I see no errors with Gcc 18
