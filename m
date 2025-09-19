Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDFCAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 17:11:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E58C4042F;
	Fri, 19 Sep 2025 19:11:31 +0200 (CEST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by mails.dpdk.org (Postfix) with ESMTP id 6E71D402D0
 for <dev@dpdk.org>; Fri, 19 Sep 2025 19:11:30 +0200 (CEST)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-363f137bbf8so12056771fa.2
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758301890; x=1758906690; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVihiuh2m2JENnnYbYqoYWpd6/ANQLAT0dlvYulevMU=;
 b=jku7rFqfDnssnlnmMdnNpASbK9+/6FXVW7nLTxLLogSUKj1K6UyYLUNc3dbqHoscw0
 kQ4rdDwFAR0bV0rLDMMeehrvyuLfO66tv117hh5lYKguWuZi4hldXSdxefuOM13Y+YSc
 RzPKVs1r/dY+rK4UbrTwAP/IsjAp4flUlzlvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758301890; x=1758906690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVihiuh2m2JENnnYbYqoYWpd6/ANQLAT0dlvYulevMU=;
 b=na+80UDWMKXwRkm/WfAs9crBF4lt+ef9mcVyO0FkQ5KFE3uuOV456JS/6CjXzBUBAI
 cNX0sj6PCT56k0LjlNv/g2KEbv/QPwawP5ylI3NZdLlAdL6ndcmhj/IvVp2s/FV89joF
 s+U1jX5fVp4aRK4riJcIMFBIichknDLz5uHxuDnz3ctMue6L7wWDySEa5z/Eut5Ov1UL
 t17OgAQIqBfYC3gQDocYzdKh9wclgRpdDkwGshkQMKdVdHkJVmsAr04fdu3l+ZMePYMc
 WxA/BLOqEpIgg1uNLyXziIxi4PELXmQS7r6EkaMrysHGNpSbMA2UsmN4EbeHeC/HS32R
 F/4g==
X-Gm-Message-State: AOJu0YzTcKbPCX6IWNhx3fMaTIlcoJjx5btYxPV46rlY/4EcT0sQTM2F
 41+GrEOMuM462RuY13c+sGYDQrETo4T88TdRqNbY6QmgG4oJ3t5X2H9ox89E3wg8I60pBy8STYG
 A69sn2ieJJAZnFoliUvmZCdVHW6X8EKUM6nVmbqTiqQ==
X-Gm-Gg: ASbGncuhUjFdBxmCukuk8LvW6MnD3aNeWOMqKTqpuMBx8l8VWTpChP5e/SnE6hsRpS0
 E9vD4A05NfN+WrWN7sfiwX2PQd2bOyyTDlStsmjoOkCZlUICJNluZRFqLQm2PiB/I7dJgdyFo5S
 RHPScfhRIWZHAmG8IV3ZdQccyv7P47uswfWjjyDepViDCICxA5w3azuFL8YPyvc78IFNK06nK2s
 pqm9XigMpoHl66Ijx0v+Q==
X-Google-Smtp-Source: AGHT+IGRUg6cqn+nch8tw8P/rqqIlaoKiVBrtzpVQBQCqOpPhPpGWxpPI6hPnSjBI35L/O/gxSbQ++cZFVQU742CjIo=
X-Received: by 2002:a05:651c:201d:b0:351:786c:e533 with SMTP id
 38308e7fff4ca-364147be89dmr8764331fa.15.1758301889756; Fri, 19 Sep 2025
 10:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250910194259.1027220-1-paul.szczepanek@arm.com>
 <20250910194259.1027220-2-paul.szczepanek@arm.com>
In-Reply-To: <20250910194259.1027220-2-paul.szczepanek@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 19 Sep 2025 13:11:16 -0400
X-Gm-Features: AS18NWDYV09ihto4PilpU4b-wLcdr5iolc2YBrPaEXvmtFI4_yff1pUbcqwMAEg
Message-ID: <CABD7UXPXsa1Psrg4cSLk4u4befxJ4_T7or16KnG1+pcMiGkOuQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] dts: update testsuite docs
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Thomas Wilks <thomas.wilks@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>

On Wed, Sep 10, 2025 at 3:43=E2=80=AFPM Paul Szczepanek <paul.szczepanek@ar=
m.com> wrote:
>
> From: Thomas Wilks <thomas.wilks@arm.com>
>
> Updated and corrected test case doc strings inside of test suites.
>
> Changed helper functions inside of testsuites into private functions
> and removed doc strings where redundant.
>
> Depends-on: series-36111 ("Split DTS framework and public API")
>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
> Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
