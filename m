Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C3CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 00:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEA544026D;
	Fri, 17 Oct 2025 02:16:10 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id DF41140269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 02:16:08 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso1853295b3a.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760660168;
 x=1761264968; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tm3K7GKR0l9yBIsbxj8tRWBKLa3nJumW7MQuqBE/kEs=;
 b=Roz9e4cP15vBC8deWKYpJ5/3tYpe+9AIM3GOtimPUGV3IhWdxT16gaZLoNYtK+1kE0
 ZtG268nYE3F+1MsYAE+IG/BH5NFU3Gl01dxkHeqBKiXqdkwBGbSMAvlOV7/ZU6Qx1Puq
 sZiFDAcAQwhxUk7fPg9hSSQODjPIs4LBuFz6yTIo5NQ+fxTX5hVeg8GPqUXuua4vId3p
 JezVDCUs50v9ZnPDjvQHm7mbGNGcmaisougQ8u/ej7RdU75SkxRxtIs4FDZSreyAhgSo
 Ymb8Xzq8f/O5OGj91pQeyOpD+h96oHacMq2p14gY+/jNQ+QDChh+TuxHYEMmzAdIdGaw
 MfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760660168; x=1761264968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tm3K7GKR0l9yBIsbxj8tRWBKLa3nJumW7MQuqBE/kEs=;
 b=bC33lNEWQGpoxsMRDlaQWGkzJ47JPa3yIMe4vRjlDVn3JP7J3nFr/HeuXqFK9uxk8a
 4m0r2mTAq+LdAubdLNEjOgjJTIcOhtn7BtuRQLUyy9RNxEufX8I4iiUHEGXTd1mwOW+u
 i5uNCrPSxpBW9n/9IwDQvPZ26OORnJG0RAWsUS8sSFm7WS+snfgCQvOjPvst6pJEh6av
 ysgRZd4qnnlLCIi479Cq5AM7MH4DORLD0F/1FQRhfJbYnJpySWpu/xVyl7kj86MKKbKa
 ICdLDRCVJZFaQrCv6vzlkriueuewFH9rzAE3AQ/wgtsiPQh5uvQS430ShQo0rkPCAznE
 qyvg==
X-Gm-Message-State: AOJu0YyGNP/w0Jpboi00fZXPHHc2wcYxUcoFNvVS/ZDjTZZvzYxJv2CQ
 u7Xtp29DF5zdQAuzunotyyo0jRkAjb8VrB3AODZa2nU9jp5UTpRmz4IdatcWyylHzqo=
X-Gm-Gg: ASbGnctBUl4bsZ8Jtt4XOGnq6ROjEagrAROPgC6QHcrGq+nurBoddf+O1KlFk4jTMk1
 fHnPzwr4WhTlxGdEpXI6BxkEHXNzSeAh2tVRLmdH/t5FZiKAEH/Y0fy1TAYwuoAHQs5jZHKmiw4
 fezZxVXWgyB53PB4l8DwoW6Sw86dNwqIJ2hRjbnzV6ra5sEHTT+yNQZWbP38IJCN2a5WrTQlYRp
 bhYn6ylX5G4uV1w4p/A1ykzrlxzHMhgb5D3fvfvrX9U/hsoyQSgQaFqj/opM5d09BHIaRx1mNqu
 5loF93cIJ6m58aSBg+XxLctzzzpXl+0FWjTwON8K1onNDMiJTd05VVtYoXdgaoGEx7tY7CkZNBZ
 b2dDJq/hM3dj96z4cSL/j8a4odl6bHca2qxoDmLhnNA3oXVjOmSZp+B8aTrjX8Srf3czBo1eiXh
 zJevZ+MWR1cjxKb+Tq83Ib8xd5iP87/8QvXBrWgGYHPu1F8cs/BTQeXIwjOlQnR0Y=
X-Google-Smtp-Source: AGHT+IGn/9Ww3wTUXhUZckk9vKaWDl0lyFlHdRYsqZoD8H905TG79tbX/8vpduFz7/ewk/eO064vMA==
X-Received: by 2002:aa7:8886:0:b0:792:5db2:73ac with SMTP id
 d2e1a72fcca58-7a220a91974mr1864631b3a.7.1760660167839; 
 Thu, 16 Oct 2025 17:16:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d09f407sm23880632b3a.43.2025.10.16.17.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 17:16:07 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:16:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
Message-ID: <20251016171604.61cd9d11@hermes.local>
In-Reply-To: <20250723162013.2392-7-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
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

On Wed, 23 Jul 2025 17:20:04 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Create eal_option_list.h, containing all the possible EAL parameters,
> and basic info about them, such as type, whether they take a parameter
> or not. Each entry is defined using a macro, which will be then
> interpreted when the file is included.
>=20
> First time this header in included in the eal_common_options.c file, the
> macros are defined in such a way as to define field elements for an
> "eal_init_args" structure, where each value is either a string type, if
> it takes a parameter, or boolean type if it doesn't. For those elements
> that take multiple values, i.e. are passed multiple times, we put them
> in a TAILQ.
>=20
> The second time of inclusion, the macros are defined so as to define the
> arguments in an rte_argparse structure for EAL. For the basic string and
> boolean types, we just store the values in the appropriate field in the
> previous defined "eal_init_args" structure. For the list elements, we
> use the argparse callback to process those elements, adding them to the
> TAILQ as they are encountered.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

This patch introduces another case of shadowed arguments.

Suggest renaming the global args variable.

I do test builds with -Wshadow

[50/3660] Compiling C object lib/librte_eal.a.p/eal_common_eal_common_optio=
ns.c.o
../lib/eal/common/eal_common_options.c: In function =E2=80=98handle_eal_inf=
o_request=E2=80=99:
../lib/eal/common/eal_common_options.c:342:16: warning: declaration of =E2=
=80=98args=E2=80=99 shadows a global declaration [-Wshadow]
  342 |         char **args;
      |                ^~~~
../lib/eal/common/eal_common_options.c:87:22: note: shadowed declaration is=
 here
   87 | struct eal_init_args args =3D {
      |                      ^~~~
