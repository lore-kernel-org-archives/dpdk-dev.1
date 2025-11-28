Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1CDCFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 08:39:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ED8D4013F;
	Fri, 28 Nov 2025 09:39:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D3B2400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 09:39:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764319159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XE990rsjuL8hsDh069AYsJ45NvPemXOMpw3J27u2Woo=;
 b=KtLP8TpzrCmvSjRh1pFipUNae6QoxqgX0TJwJh4gD53Edi+SnVZVyB11UVZEBBXOFSxlJw
 64OGsNG4/iaDFaDW+hGyTPtyCTpTiKU+6IDqpWvoPB6wVszEKHm8TjlM5oRlk944UuqYEa
 NkDdyGehLGpC+jhSYFCJD3vweepowi0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-LUiWFEqzOeuCKU1f4xibeA-1; Fri, 28 Nov 2025 03:39:17 -0500
X-MC-Unique: LUiWFEqzOeuCKU1f4xibeA-1
X-Mimecast-MFC-AGG-ID: LUiWFEqzOeuCKU1f4xibeA_1764319156
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5943838a6a3so1078988e87.1
 for <dev@dpdk.org>; Fri, 28 Nov 2025 00:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764319156; x=1764923956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XE990rsjuL8hsDh069AYsJ45NvPemXOMpw3J27u2Woo=;
 b=ecaG9xFMYEHNXI+LLruayG9HPb9w5GyZVrwI3Hds1AAGEAOGlrU2sKCt5CjiUwELCt
 aZ2n7qyiZX0zSU5vDQyIr6SFrF+DgGbeFb4Z5Zl65dGM1xgOpSTvMbYOctmMfRXzIgk3
 1W6pmc4lgdDw5IZ3FmEFRMN9HWJrlBo1V6Nrr8fcUbDxxUl6rMZBxbiinp3a/769VLp4
 WJgQsPMDXpSNfrHDv27djkrTDV08nTyCtKMEyRGM2v7qBti2vj9hQQTTJdQQoA33cUxJ
 D3pp3MqrOdD4aShrfexBCDOC7p8bD4VevVmt+ikBq3JB9KdHDAblQY64pLALk5BHGd9b
 MzXw==
X-Gm-Message-State: AOJu0YwjB6+9GCiJCxqjGVK3tn4jCwCxjQUzB+uZY6kIqtTpnUl97BSO
 7ey1EYyfpuZPC4I1Y6g5eYOcYYchVE1JNwAkbBedpY+A0NR3fdrEpcw1BR8u0FYoL9nnzMaIDJO
 n1uEn2tdZN1i5OeOFSPK8V+ANJu1N9l30MzQVtXngmpUUa44+yejBsPMAGPzIE9b4m0etUQC84b
 VAaZmbQeJMTsxWAvEhcuI=
X-Gm-Gg: ASbGncugpocjkIb7UainC3LAAaDsA0BfDFKtbIU85V7qGG3pbgp2ZaS8d/jTjTL9E8Y
 4jEYEPQPcdkcCbIljo783KIx5lTpOaYg3494OO2iZ7EewVrAb/z0HMYZWpauBzgLYLvxLst7KZ4
 vOco57BZerXOZDCphPpegNdd/WfjCTVWfYjxJ3TznMkfo26RRAOooyrzQ6raOcPK98naTg
X-Received: by 2002:a05:6512:12cd:b0:595:90f9:b9c2 with SMTP id
 2adb3069b0e04-596a3e983bemr8543773e87.4.1764319156104; 
 Fri, 28 Nov 2025 00:39:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAJs+bBFMIvyzJVn51zsYtvXn1la+TLNQaklRPcoTqXoPjTMsprbtvgvRjAxiuFd9EoCCRNTWA7hi4KQY76J0=
X-Received: by 2002:a05:6512:12cd:b0:595:90f9:b9c2 with SMTP id
 2adb3069b0e04-596a3e983bemr8543761e87.4.1764319155688; Fri, 28 Nov 2025
 00:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20251125144610.37661-1-stephen@networkplumber.org>
In-Reply-To: <20251125144610.37661-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 28 Nov 2025 09:39:03 +0100
X-Gm-Features: AWmQ_bkTVP_ctGUxjkHMVu1ovYljQaGCT3zmsStm1E_aoDVe68H3AsRbaUJLkVs
Message-ID: <CAJFAV8zuQVd_z5mKOC3x0VmE9QFGXG2REgaeBH4eVm=wxcFHMA@mail.gmail.com>
Subject: Re: [PATCH] bus/fslmc: fix warning in device scan
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Shreyansh Jain <shreyansh.jain@nxp.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m--NA5vKxQzJry32lY2a-CxAEsU_rNzrZ0wmVYdmHhE_1764319156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 25 Nov 2025 at 15:46, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> With latest glibc (Fedora Rawhide):
> ../drivers/bus/fslmc/fslmc_bus.c: In function =E2=80=98rte_fslmc_parse=E2=
=80=99:
> ../drivers/bus/fslmc/fslmc_bus.c:298:15: error: assignment discards =E2=
=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarde=
d-qualifiers]
>    298 |         t_ptr =3D strchr(sep, '.');
>        |               ^
> Fixes: e67a61614d0b ("bus/fslmc: support device iteration")
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

This build warning can be seen in OBS builds.

Acked-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

