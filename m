Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F219C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 09:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C23A340156;
	Tue, 11 Feb 2025 10:50:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F113F40150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739267438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvDTdZHE7+i6Kn1iU9G9oGcZLOj068x9S9/Y6hXjBTU=;
 b=CBwfksWAi7gQP6k7loXpArRnEhvqdxzcWSWmR/RA6QIl/GvFHkBkd6zMsVJmqYaWcHpxKR
 G+WHfJbt5UmNqqeRi7XKc+FIbN4hCt8vnuGuyL82gg9y+9g3EiA6MhgK8j1/5FNDNHvy6Q
 BiN461Hx4cCJfxdMDxjZirfGH5rzZX8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-meEBOAPpPgWKdb0s1026vQ-1; Tue, 11 Feb 2025 04:50:37 -0500
X-MC-Unique: meEBOAPpPgWKdb0s1026vQ-1
X-Mimecast-MFC-AGG-ID: meEBOAPpPgWKdb0s1026vQ_1739267436
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-308e84b5b43so11485071fa.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 01:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739267436; x=1739872236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvDTdZHE7+i6Kn1iU9G9oGcZLOj068x9S9/Y6hXjBTU=;
 b=GPqjW2Ce+BrXwm/Q1RClN54OjaY7ZQCphg0bjFeVUjVeRb2LILlE0XsKPWL6Lb/N6C
 e7X7DboprSSPMHEGCTmBBllngHnA2GBWITSJr+nTOW85zCTOBxwbJ/d6Fc8oAkVQjq3j
 Sq3WuyCOZG+FYSrXb7san+FOhqJeE/ghwp8Cxgwp1d1ZNiyFmxghjjN1HD3apsGdOz2P
 u5fJMgoVM/lQh7XXWk7hcawuarm2gM2NCirbvDpGKraPxEoLuyn2hUZvCcBtWhcYeBd1
 RDHxduBePTvhLiS7hn5Hr5qtUJFdUn6QX1r3nU8EiZL/pl7cuOlNtnac97jlC+7rxdXi
 L+wA==
X-Gm-Message-State: AOJu0YxsRhivkPgOjnkNhEE1O5wARCHI2hIAfZbBeASRwEwYcBpCFy9l
 SfIYFN70yfIb0h/8xKI5Zyu9Gyp2T4EZj3ngbiHW8xZEcq7rL11OMltKnV2ZveOrGv9SlqNxHL7
 r1PiuBlNGSrhoHDfh97cGlMRDuu7sRTi5rV+J3m5cYDt2sBPbi5zeu0BKBpg2sZDtcTqb5FE+xS
 pyufkEUkPc5NRzYR4=
X-Gm-Gg: ASbGncvkkDInVmcVGkcI8/8mFiYzxrMgtSs7z2wZ3+P1Ufi0IymV3rYTgBX0E29Mo1M
 KN95q9YfR1Ob9/tAibSdQougJx4rZDQNO8WM8+J2QEh/ZuTfBVf/kusUlqY3m8j8U
X-Received: by 2002:a05:651c:884:b0:304:9dd4:fea7 with SMTP id
 38308e7fff4ca-307e57eeab2mr49868411fa.16.1739267435880; 
 Tue, 11 Feb 2025 01:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEclqkRS3tmdL9KifMYUtNR+XgEWISGYLFbllIibl/27Tc3CqUyNfkqOEPLILpD0xPG/++6vaxgjlZQgy0qc+s=
X-Received: by 2002:a05:651c:884:b0:304:9dd4:fea7 with SMTP id
 38308e7fff4ca-307e57eeab2mr49868291fa.16.1739267435503; Tue, 11 Feb 2025
 01:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250210171845.1669874-1-bruce.richardson@intel.com>
In-Reply-To: <20250210171845.1669874-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 10:50:23 +0100
X-Gm-Features: AWEUYZkXQKPJep_7KtsKZXfKFO6TNFtueQK-M1AmrzzkA1x6E-7FUuA0dix6MdQ
Message-ID: <CAJFAV8xqY=XxNy-fN7VTX-MOdtTCAOVGGW5HGPayfARqMsrFFQ@mail.gmail.com>
Subject: Re: [PATCH v3] build: replace support for icc with icx
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Ian Stokes <ian.stokes@intel.com>, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <Paul.Szczepanek@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DfTH65ii2cNW-a5pFIIArafy1DAS7PYy_SYmZ-J3PEk_1739267436
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

On Mon, Feb 10, 2025 at 6:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework=
/testbed_model/posix_session.py
> index 981600e24c..eab08a90ce 100644
> --- a/dts/framework/testbed_model/posix_session.py
> +++ b/dts/framework/testbed_model/posix_session.py
> @@ -391,8 +391,6 @@ def get_compiler_version(self, compiler_name: str) ->=
 str:
>                  ).stdout.split("\n")[0]
>              case "msvc":
>                  return self.send_command("cl", SETTINGS.timeout).stdout
> -            case "icc":
> -                return self.send_command(f"{compiler_name} -V", SETTINGS=
.timeout).stdout
>              case _:
>                  raise ValueError(f"Unknown compiler {compiler_name}")
>

I think we can drop icc =3D auto() in dts/framework/config/test_run.py too.
Wdyt?

I can fix when applying.


--=20
David Marchand

