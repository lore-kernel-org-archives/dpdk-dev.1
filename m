Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C294CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 17:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F1E04042C;
	Mon,  1 Jun 2026 19:16:44 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id BDD24402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 19:16:42 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-68d234218bcso3133703a12.2
 for <dev@dpdk.org>; Mon, 01 Jun 2026 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780334202; cv=none;
 d=google.com; s=arc-20240605;
 b=Mw+3IJLUciCsr07ZEtJTo5+nOfVKSvDfdA/BOrRB0tHw4ZLnntgbsBdi6xlb3+Fwnb
 3V1eWkwXAwdtChreOGZrTAKDHoemN2E2v47iv7TqifWiZZjTJtclv27UN8YR0yxdQu3l
 9VYR8F6B+Aa6Pk1b+NU3hSkecNcxu1tzyen/d3qacHGtYUfvenXGb+cMFrfRlSTDl52q
 u7+rb34ApRKnS9lvVkThvS445oxn47ArsST75vSNgHVdzAJ8s/Jz3PJ2MWnZeh8GSfMV
 gktwEhQTGsYPme8keHjFWofIa3yrBk+d650TMlFIfDMnsW9aFBIPdETBfOJyUFeza9bG
 RhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eJa8IpruYwUY54AedLFNRIFltfdhYghei6JdOBBGpuA=;
 fh=aqYtrYzRB5cCirfn+bt1oV8me0GZbk/ndAQae5wOO5k=;
 b=Z0GLoDXtR2aPMAfTZsAd9Tt0pWeoXvfHdJDglAEkTG48dfPikDdgGT5ShTJfkozNQL
 FsWTyycbzm2W3eOz/5qFjoSWXOyQenCVEiMyxDRaMuQKL9a7lQ0hZlfkW8P10Aw9K6UN
 QXxyMwY+LY2TmIyh9UjUDUOEeevuQJrWbV2NXCUTGN6sBZmPaTlDqgXu29dbFeXKHVD+
 fW0d5H/ceVLG5mCfEJCvKDKhvR2mh+4q2qY/QBwvMGhoSeqezO0X9K//MyE14n92ZfB1
 eE3/Dwz61KaMdyvtwHT79EToIHseSmqNXmIqqpd0AuRbi83bM/felVyuIujo1WntKq22
 lvTQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1780334202; x=1780939002; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eJa8IpruYwUY54AedLFNRIFltfdhYghei6JdOBBGpuA=;
 b=S5V7YNeDPCjgigaYUyC0vdivSCKH5iYbRNondX6D6MRtInIyfehS2L2e4klVhLlqW2
 hfo15Iv0eUo/ovkMan5mHLaJ6bDQ6tEuaKOOUOIm4Y693bYy9VHWvjpQRcBOaVBIR+cR
 DHfH3lu597WQs9D0+K+ybHj3nfUI4Gkm1SWkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780334202; x=1780939002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJa8IpruYwUY54AedLFNRIFltfdhYghei6JdOBBGpuA=;
 b=PduwmkxJUzCSzWOJwmeTO1bcMGWHSbqn4RnzE6l9EGfS335z3YpTJBhCs64yAeH66Z
 +iEQpWDO4TC3lstyuf4hnt79JF3OlPdVpfGiTvQ6DqlOUNrCI1EL1R3JM5jikYjaiS/Y
 3a2ykMZVy1UE0klyvR6Msb18fn2qlCE+xBU0Id7S7EEYwVXEgiQqGnW6jduZwwL7hUfz
 lFREQXPppLw1BOP27FJECyewTrn6duJDhm4jbUAlA45nsQiXFEo35gGv/YVc94E+svwa
 7oIvmEKFgkWbXyoNUVO/xVY6UhB46p4V6T7DDpKz2HJmR8rylcDsHSAoJfi+dFQINTGx
 Skug==
X-Gm-Message-State: AOJu0YyrcxfNm6LAyuD98AayQVLdEQv649t53BQSDnfaSf8rT1MnTbpI
 ZxLjVVh1VoTFTawaLLmAO1H2ygGYdqo+TSEICZghqfLj4vfYwlteVtnjB+AJN8hBRD/FtrRfTvy
 aqGIUvxfvJbehtZ7ak8Kce6mYYFc7AZXZ+045hth/ew==
X-Gm-Gg: Acq92OHTdVIdF5/OCldPefwddQoPAOF6JeaEWS//sRV9p15QALu/s3iSHbYjdfXufuF
 JfBSR/F5d4R7fyLP7fZysB0zfnI/r/+B/4tPwHK14lHaKBJXUBrvZ+Op8EbNjViOLkdefJ0V7OR
 7L3B/KCg4pMfEhaqLb3ewPQX9LejE84BWMO5/VdcYuu/IW942KaxM24uChc3I42zDuDkOX2SFMG
 SYWYknbjVHdytreDnt3j+T4ZhD4vyNDSZpzxa3mgiIm6B5WNT6foU19e2UYpLjDXGm4jN7xOYOn
 X9Aej11BfIWuz4+2HDbaIIQdUeliork+vdLcevXbAw6U4YqrrpWS
X-Received: by 2002:aa7:d849:0:b0:66e:6ac4:2c01 with SMTP id
 4fb4d7f45d1cf-68c8893631dmr4117656a12.2.1780334202333; Mon, 01 Jun 2026
 10:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260224163200.39360-1-abailey@iol.unh.edu>
 <20260530203757.22139-1-patrickrobb1997@gmail.com>
In-Reply-To: <20260530203757.22139-1-patrickrobb1997@gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 1 Jun 2026 13:16:30 -0400
X-Gm-Features: AVHnY4Lo7R4iXFitz789l1N6wb7L2EgrCm8dVuHeTL-k88fLihMboMcK1ioD-gM
Message-ID: <CABJ3N2UVNvqK2y6776bVE0zufpcSERjiroNxpXkf26q_pgajzg@mail.gmail.com>
Subject: Re: [v2] dts: add support for no link topology
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com, probb@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000b63f460653345b26"
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

--000000000000b63f460653345b26
Content-Type: text/plain; charset="UTF-8"

Hi Patrick, Thanks for the review


> I don't understand the change above. Surely we do want to set the custom
> meson args for ICE DUTs when there is a sut_port_ingress, not when there
> isn't a sut_port_ingress, right?
>
> Yes, this was something I overlooked and will be updated in the next patch.


> Also, does the topology type affect whether we want to use these custom
> args, if the SUT driver is ice? I guess in a weird case we could have an
> ethdev test using an ice DUT which does not need a TG?
>
> My understanding is that if the link topology is no link, there will be no
ingress and the ports on the NIC would not be used for traffic. I do not
believe this argument will still be required if no traffic is being
handled. Please let me know if you disagree with this approach or if I am
missing something.

--000000000000b63f460653345b26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div>Hi P=
atrick, Thanks for the review<br>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">I don&#39;t understand the change above. Surely we do w=
ant to set the custom meson args for ICE DUTs when there is a sut_port_ingr=
ess, not when there isn&#39;t a sut_port_ingress, right?<br>
<br></blockquote><div>Yes, this was something I overlooked and will be upda=
ted in the next patch.<br>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
Also, does the topology type affect whether we want to use these custom arg=
s, if the SUT driver is ice? I guess in a weird case we could have an ethde=
v test using an ice DUT which does not need a TG?<br>
<br></blockquote><div>My understanding is that if the link topology is no l=
ink, there will be no ingress and the ports on the NIC would not be used fo=
r traffic. I do not believe this argument will still be required if no traf=
fic is being handled. Please let me know if you disagree with this approach=
 or if I am missing something.=C2=A0 =C2=A0=C2=A0</div></div></div>

--000000000000b63f460653345b26--
