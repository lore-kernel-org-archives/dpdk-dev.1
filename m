Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29864C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 08:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45BD940261;
	Fri, 28 Mar 2025 09:21:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B7F84021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 09:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743150078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWKemjeImsh9bDmHYZjuBr41FX9z0+IFeB7L5kz1lck=;
 b=HB9VsryNYQblRkJ3arK2O6C2cnDiFnL1UZqU17NH3dQkIWkyXASWNk/30BqwlY+IgjlaZz
 /Q8IsN3GisCYKamVf+m+m+TBoSl6seQCMwGXU2BQDHvnaxFHbFdio4c9GUqmPcIiZF0Nte
 8wAhXTs9+tOpCEppfZyWdimrGHkRn7U=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Nv8f4QtZN3WjQWaZ0X7R5w-1; Fri, 28 Mar 2025 04:21:16 -0400
X-MC-Unique: Nv8f4QtZN3WjQWaZ0X7R5w-1
X-Mimecast-MFC-AGG-ID: Nv8f4QtZN3WjQWaZ0X7R5w_1743150075
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5499d4435caso763016e87.0
 for <dev@dpdk.org>; Fri, 28 Mar 2025 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743150075; x=1743754875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWKemjeImsh9bDmHYZjuBr41FX9z0+IFeB7L5kz1lck=;
 b=sUbAQAJv7CIsM4jwOz/cakY7Fs06cdAoYcL4YuhOzIGYWRaCh6mKSMmWEokxKThc+h
 Y2Z8uIp+llBP/pyw++uoA2MXwudxI1RghJEzswXUKE8tusfq5tnCAIpdK8CA6P+Nb/Kc
 5r6SXXWl5K+jfNk6v4P2q4O/dfv0Poyfr2msa0sdrfBy4PcJuM5S1Gw6X7mBnkHJnyP6
 2G/tDYuv+ABu2bJRpTtzkLmmTtj43lF1Jj8fiZAuEcytcYnNz6XgT9GbA3ohHGBeHpXr
 HcN4rapb6DCMzb/5WACxqEcqkGic/d6hqr7f2gTAx48FnNRops4LhCM9AEnrijDx4IzG
 kSCQ==
X-Gm-Message-State: AOJu0YwejVUDIYlH79/f5OzdIn/lY28Br24ZO0DzR2z37yJMJPz+3H2b
 AjOOOliW02wWX5JMDxYa2Bd/jexAukV1JW5n7u1RE3DPiR1kLqvzc+2nRwGBec0rkPRYxEqHtnW
 viiuZeVv0DYZEjoMLH5emo55iA+HBXvLMYPnJ1k9nMjV8QqL+wz4MT+/DMDGLD3xy4FYCyiCnzS
 S+E8ZGWqltIvSfr94=
X-Gm-Gg: ASbGnctWGSz8nkjucDmbiUjVj9KpPchCmdFJI0ETU8Blh79PcK4TW05QXQzM8L/Dq+L
 HenIiA5FGqJaU0icjkQtGyPZGbAxxbOtA2/PlR6oKu4dAu0IzhDE0Tybc8EGMQan1oVN0lHA5mM
 I=
X-Received: by 2002:a05:6512:6d6:b0:545:1d96:d6f7 with SMTP id
 2adb3069b0e04-54b0121de50mr2610956e87.32.1743150075303; 
 Fri, 28 Mar 2025 01:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIXRHoX+RH3TcPgHzgpMCvE97HqxcyyOskCXJViDc83loQ4U+CemIBhNpmN64Nl92GeqrsLgdvxGuUNl7D1/E=
X-Received: by 2002:a05:6512:6d6:b0:545:1d96:d6f7 with SMTP id
 2adb3069b0e04-54b0121de50mr2610949e87.32.1743150074882; Fri, 28 Mar 2025
 01:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 28 Mar 2025 09:21:03 +0100
X-Gm-Features: AQ5f1Jq1rxkYYSUEYgF3uq7N0g4IdiJ9placMDbD0owWRkKySn3HjAxS93ROXvs
Message-ID: <CAJFAV8y8eqnTDmsku8=HrF1fQdDuBNYyaKfzWCg9J1Z5P8iYVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] net/intel: clean up base code build
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9AKLnwogbYi2ATYOkMhpDbpedsLUNdFCsCUZ-OqYftc_1743150075
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

On Thu, Mar 27, 2025 at 3:52=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Simplify the build of the various intel base code directories, by
> clearing compiler warnings so the files can be compiled directly along
> with the regular driver files.
>
> v3: add fix for lock checker issues on FreeBSD
> v2: added missing patch for fm10k
>
> Bruce Richardson (9):
>   net/fm10k/base: fix compilation warnings
>   net/iavf/base: remove unused meson.build file
>   net/ixgbe/base: correct definition of macro
>   net/ixgbe/base: fix compilation warnings
>   net/ixgbe/base: fix lock checker errors
>   net/i40e/base: fix unused value warnings
>   net/i40e/base: fix compiler warnings
>   net/ice/base: reduce warnings for unused variables
>   net/intel: simplify base code builds
>
>  drivers/net/intel/e1000/base/meson.build    |  9 ++-----
>  drivers/net/intel/e1000/meson.build         |  4 +--
>  drivers/net/intel/fm10k/base/fm10k_mbx.c    |  2 +-
>  drivers/net/intel/fm10k/base/fm10k_osdep.h  |  2 +-
>  drivers/net/intel/fm10k/base/fm10k_pf.c     |  8 +++---
>  drivers/net/intel/fm10k/base/fm10k_type.h   |  6 ++---
>  drivers/net/intel/fm10k/base/meson.build    | 21 ++-------------
>  drivers/net/intel/fm10k/meson.build         |  4 +--
>  drivers/net/intel/i40e/base/i40e_diag.c     |  2 +-
>  drivers/net/intel/i40e/base/i40e_nvm.c      |  2 +-
>  drivers/net/intel/i40e/base/i40e_osdep.h    |  4 +--
>  drivers/net/intel/i40e/base/i40e_type.h     | 14 ++++++----
>  drivers/net/intel/i40e/base/meson.build     | 23 ++--------------
>  drivers/net/intel/i40e/i40e_ethdev.c        |  1 +
>  drivers/net/intel/i40e/meson.build          |  4 +--
>  drivers/net/intel/iavf/base/meson.build     | 10 -------
>  drivers/net/intel/ice/base/ice_osdep.h      |  6 ++---
>  drivers/net/intel/ice/base/ice_switch.c     |  2 --
>  drivers/net/intel/ice/base/ice_type.h       |  2 +-
>  drivers/net/intel/ice/base/meson.build      |  1 -
>  drivers/net/intel/ice/ice_fdir_filter.c     |  2 +-
>  drivers/net/intel/idpf/base/meson.build     |  2 +-
>  drivers/net/intel/idpf/meson.build          |  7 ++---
>  drivers/net/intel/ixgbe/base/ixgbe_common.c |  4 +--
>  drivers/net/intel/ixgbe/base/ixgbe_e610.c   |  2 ++
>  drivers/net/intel/ixgbe/base/ixgbe_osdep.c  | 20 --------------
>  drivers/net/intel/ixgbe/base/ixgbe_osdep.h  | 29 ++++++++++++---------
>  drivers/net/intel/ixgbe/base/meson.build    | 20 ++------------
>  drivers/net/intel/ixgbe/meson.build         |  4 +--
>  29 files changed, 69 insertions(+), 148 deletions(-)
>  delete mode 100644 drivers/net/intel/iavf/base/meson.build

I see that you kept the base/meson.build in most drivers, though those
only provides a list of base sources.
Is this because you expect having to restore this special handling in
the future?

--=20
David Marchand

