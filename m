Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42861E68145
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 08:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3006D402A2;
	Tue, 17 Feb 2026 09:43:18 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id E6DFF400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 09:43:16 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso36876861cf.1
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771317796; cv=none;
 d=google.com; s=arc-20240605;
 b=Kt1rzhrW5eLBLR97arnzH5glymDewWAF7A/6gnufmW6jJCIoKNYZE29Ibg/1yOkLbB
 3KqCFf5PPWSI8YXmhBFNdhodOI2KxKwAr9sKetNS863jBEF+6q2FYjKZ+fANbhxdpAqd
 dVwGZjeN04ws5YmQwP0Ev/R7GzJ2USp1BXd9Iuwn/plHa92a60qGtm5HOn4dH2qhIKq/
 xU3pC4xPujVbPJRAF6fby0iTExw6QXIg9T3bKvYP8MmxH5WHMAK3Xv9+xWsuxNZg354k
 u+Mhg7v2RqMLOMz71du9FSTPagSHsJfOk6vl/90AwO1/eCu1aqJFLd0q31xB2sVzzK5w
 9aRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jwjRpsMkTZv5Ti9uNXasauOp7MCUwYRTcZvSphwWRkY=;
 fh=O5wRXulU1gZspCy0QvQ1Fy4M+9bXKropE93qtSrHDL0=;
 b=NP3fLrDH8ugs0iQ/bpxs5xqdW+8PfrVfEPbQCwqv5X+6eCDjk8KCar0FGWHn5oc2Jk
 4Iq+6Nxowh6C49607rzbJ3jrm/+FJLyG2fCLtlpwnhWc8Yf+Wa3gawQ0+8kFUBJktpvb
 I3IcAIfADPRxD8hiao/tN76zG5PS8wKGOEYjuPt70VqtNZrxXY4ORXBpjIrwT8GlcQYi
 E0B+3W3XUC10OkuaypPtphz0nUIOCOYtEnAiVSHKQEjDJ4UsFcmZr7IiQ9RCfc93btPB
 Trq8fgbE+mFrw2yIC24aD9T4RRvdQ0PpV0036KUtDB2q8gUEC+3E/AWg0MIamYvLePXF
 k/Pw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771317796; x=1771922596; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwjRpsMkTZv5Ti9uNXasauOp7MCUwYRTcZvSphwWRkY=;
 b=PZKQY/y0OoIAb25TeL50W8VIYietIwHbeD/It+PPnSwqb0rgfN0SnBSKDMPc4yUQiI
 9frfr2xenlxF8Q+PNMT7Yki9VOoaF8iFgWx0AVHrXSJsDp7ma7ZLDi5ykeejxdlHITyg
 DzEejmKt3aUYJmD3wOr5A+4fDIhLbAlvFaKINmBpoWo6oNRhU92D4oDHDiEDlbJfgHzg
 X7dhw7kq6Uhtk02X9PDHFxeTblH2Y94kPkpTm/nD6LWzK76o+dBmUzkj9vvGVWNSfD3h
 k4t1NiCQ67ez96yZPqVPY67pVEzZGspD8xn7uh3gDaCCm12hk+PI3DUQlv9tqCaDTyWd
 8LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771317796; x=1771922596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwjRpsMkTZv5Ti9uNXasauOp7MCUwYRTcZvSphwWRkY=;
 b=GIlxJ+DtCHKwIY9yLG1qDvFc8p2J1w+FLqOcEkcCdeBoj/k/Ry5wlrBfL0tiROoDCJ
 WEIyU1IuiC4lDu+G6Th7rgZfsF2yMbH4wkuZ1cG2L/XznoQxTbqUpbmWwmNyOESopiXr
 AisytFAND9cjJNWRaOoQxkyGHK/2l+03GJQtgPUy+bft3GA3V3LurgKtolqzaueqgZb6
 aqrGUG3N3dUUSlwZVra9tprIy1BZa+sVkI6C7JzHdrjEEAOH9Gz/+VqRPdsv8xho7oS0
 IJJLXUCdk16x9rvHQeNQEPiD1dzO/oeteQ29HpyHVKVSVNUhwpI7Q8m4+R8ul6PmLYis
 U5Ig==
X-Gm-Message-State: AOJu0YyUNsofYzzgKjDdMkGjF5Wg+h3uJMCsyVohuvxYDD8R39aOVMOq
 iGnbGVF+dKabOMnWDj1IpWeNBPbm8hK8Wmn4l1wZ73M4U0SEoACZdzVexGNv29KaUMEO2GxS4zx
 zEzo+tO5ZvhUAqOmkezdRYi8CuruzU/Ql712O
X-Gm-Gg: AZuq6aL4Rb+2CLRAPCY2PiLo2wHOraSEaCw0abEsYVFzr8zlPOIF6viyjzCbnKbxsY/
 Mz5X12LpeqqTZj5tcwOXp1sdDJJzxDTlNcEyfpqagMex5tr7DtUX74DfvtddCoUPM7HLTnn0paR
 WSOKdY6R0iA+d0VGAuUNx0aNqyHNvSrjv0ugXujO/pf/SB9R3aKaScFKs63nllznHa2WnDRnbN4
 EA4TUC5OMZFmqGuXbc5+0NZCHhI8aOxU8Rd3g+C6tRxjK4UqmeQ2FjOhOHH2myfZ06G78ysZ1eM
 VkdACsDLBPC/Uvc1Ng==
X-Received: by 2002:ac8:5889:0:b0:506:9b96:6283 with SMTP id
 d75a77b69052e-506a834eafamr181103881cf.66.1771317796100; Tue, 17 Feb 2026
 00:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20251205055140.2395369-3-nkishor@marvell.com>
 <20260217053448.490168-1-nkishor@marvell.com>
In-Reply-To: <20260217053448.490168-1-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 17 Feb 2026 14:13:06 +0530
X-Gm-Features: AaiRm52UISy1-9lCUDGkeEVpMLuxHH33Bo_73Dlj0b43g0psdHXtltofQ_Nhwag
Message-ID: <CALBAE1O7kkpost0cRGg6ETwX1xw=c+Nofy-OUa6QWQzq_i-srA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add HALO support for CN20K mempool
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, asekhar@marvell.com
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

On Tue, Feb 17, 2026 at 11:14=E2=80=AFAM Nawal Kishor <nkishor@marvell.com>=
 wrote:
>
> This series of patches adds support for HALO in CNXK mempool driver.
>
> Changes in v3:
>  * Added documentation for HALO support in CNXK mempool driver.
>
> Nawal Kishor (2):
>   common/cnxk: add support for halos
>   mempool/cnxk: add halo support in mempool
>
>  doc/guides/mempool/cnxk.rst                   |  24 +-
>  drivers/common/cnxk/hw/npa.h                  |  81 ++++++
>  drivers/common/cnxk/roc_idev.c                |  25 ++
>  drivers/common/cnxk/roc_idev.h                |   3 +
>  drivers/common/cnxk/roc_idev_priv.h           |   1 +
>  drivers/common/cnxk/roc_mbox.h                |   6 +
>  drivers/common/cnxk/roc_nix.h                 |   1 +
>  drivers/common/cnxk/roc_nix_queue.c           |  46 ++-
>  drivers/common/cnxk/roc_npa.c                 | 268 ++++++++++++++++--
>  drivers/common/cnxk/roc_npa.h                 |  20 +-
>  drivers/common/cnxk/roc_npa_debug.c           | 201 ++++++++++++-
>  drivers/common/cnxk/roc_npa_priv.h            |   3 +
>  .../common/cnxk/roc_platform_base_symbols.c   |   2 +
>  drivers/common/cnxk/roc_sso.c                 |  35 ++-
>  drivers/common/cnxk/roc_sso.h                 |   1 +
>  drivers/mempool/cnxk/cn10k_mempool_ops.c      |  19 +-
>  drivers/mempool/cnxk/cn20k_mempool_ops.c      |  60 ++++
>  drivers/mempool/cnxk/cn9k_mempool_ops.c       |   2 +-
>  drivers/mempool/cnxk/cnxk_mempool.c           |  40 ++-
>  drivers/mempool/cnxk/cnxk_mempool.h           |  16 +-
>  drivers/mempool/cnxk/cnxk_mempool_ops.c       |  11 +-
>  drivers/mempool/cnxk/meson.build              |   1 +

Pleaesto add roc_feature_npa_has_halo() in
drivers/common/cnxk/roc_features.h. instead of relying on cn20k()
checks as applicable. Good to merge next version.




>  22 files changed, 771 insertions(+), 95 deletions(-)
>  create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c
>
> --
> 2.48.1
>
