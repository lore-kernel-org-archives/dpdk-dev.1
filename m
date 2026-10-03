Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A2CA5FEC
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:29:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 077564028D;
	Sat,  3 Oct 2026 18:29:41 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2F0524028C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 18:29:39 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-88bc25fcd0eso556760b3a.2
 for <dev@dpdk.org>; Sat, 03 Oct 2026 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791044978;
 x=1791649778; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OWCR5doQlLyFMN+zGSB/DHSQwXzESTm9dQ4dk96SOP4=;
 b=lgP58Y/lsd/iwoqwgtJU5Dn/qU9HlzuHkMkmduXjozuG3NQpIwzDDrCAmBl3Ov5iVr
 iD/Gd+iGYI+IC4EokJVUxYl/pkUGZLADJcdXXDEdmCdwqmPh8TGFSQwHkPC89TJ5RFPz
 +eNmUhFGYl/qaL29XCAFSPcC5fjUjI++oxy88wgWeel0gN7xfJpZ8HpU3qJkXx0rcJbf
 Flq7y7TpyvKgLhSNuZ6nl4YM3ecI/i1YmdZE1NaCHj45sE9DWLSti9WDd3U98U0xnsVt
 Yd287G8Pm+sbJAD0DA9R8KbTrb2kCO1dD4PbENPDLG3vCA8dVTvBczoixpxyXD0gLnDI
 J9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791044978; x=1791649778;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OWCR5doQlLyFMN+zGSB/DHSQwXzESTm9dQ4dk96SOP4=;
 b=TqamM5aoYzTWtnsDtSX+non/eERZGzgat/PPkU3T1Tyl6TlKvxeDmxbNJJcydg3JtE
 0QkmEh7DfFDNzpzb1Gp3TtoQhAR6DP+YEY2BsgK6HvQBPIxzFTUhmcRw9AijsT5WnDi+
 /kQ2TWLDwyQKcTZ/s1arUmT49US6SQuwLP+FCJz5o+Qi7DEAM/ElYJ05/BtZqiobBQln
 7ABmz8XvlLiLGi4+rhn+5f/CUq7parIxVVc10PNYNQWsxg63DzLkZtEKFiodhhQBBLYm
 l1kD/XkWukcZRaoO8ZNVo7BWXt9nU/wXZwqRGY9AIPZBBLC7PVtqcAkjLiJTFXtlnpkf
 tcwg==
X-Gm-Message-State: AFq9FYJYmdAwAat7CKmRA31Kv0ctVS22gCNWJY94Ks97lAVE8ccvnCXM
 /hHM1rwQFSGGvAUAAnuDr++q8wRPQ2pONKVkXJT7yK3UFZrUDN4evlizCH8TNJHWaCU=
X-Gm-Gg: AYBFou3XicPN59oAipT3aGGMJGwRwV/8yYBfdOLpPrnPyNSTym2PKgvt2YPftX1I2X1
 HeIsFzrnREd6hr0637K2+Vfyp06jNr9pX8RxxKJLDWyeF3pwFYb0k0FtZPfupbMwmFj+wACEMh1
 48w2DhNq/riA75JgV/+7BfxCKRPzXxfcvr9VtiqmiyBIRqhpFxweP10olMvJEkJy7TjpN08qnsb
 p+OIcmzWH9jLL5TI49aOsL/+6K3gUpkGjj6TSUfRR/kgWMd/X4RhnKVjQR0v2yE+gTWUO8vQ62J
 lN7kF3Xm5EWHDgQ8TqB4ICj0DMH0UZwdXq7nH1UoCnAXts9tITWLu4V5Ro0C3kGqynL7dF8fwZm
 SDI/Xcazk837uY3PY/MCbsOn92UYvy/8qjVtqp2htnUmKgbK95VRERI4Z5HsGhHd7pvA/UhtWCw
 l9ibY6nAsQgoEklEpBPJjp4bCzgVKywPvsWttOZURZZWKsUbNcj6vQvFbpfUQuFlswLcnk1jTXO
 NiJD9EEy/u9UTiDgVWZiegsnTOVcYKsbJgDuKvlJr7CHb8lArM=
X-Received: by 2002:a05:6a00:9284:b0:869:84b4:4b36 with SMTP id
 d2e1a72fcca58-88c632ccd7emr2330524b3a.16.1791044978115; 
 Sat, 03 Oct 2026 09:29:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0b8f5b6esm2050461b3a.17.2026.10.03.09.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:29:37 -0700 (PDT)
Date: Sat, 3 Oct 2026 09:29:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/8] gve: precursor control plane changes before
 bare-metal support
Message-ID: <20261003092936.1c3f18d5@phoenix.local>
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
References: <20261003025142.1930363-1-joshwash@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri,  2 Oct 2026 19:51:32 -0700
Joshua Washington <joshwash@google.com> wrote:

> This patch series includes a number of precursor changes to the GVE
> ethdev driver layer in preparation for introducing support for a new
> GVE Mailbox control plane (an alternative to the existing AdminQ control
> plane).
>=20
> The most major change in this series is the introduction of a new
> control_ops struct that will be used by both AQ and Mailbox for various
> operations which may need to communicate with the device. There are also
> some changes to how RSS and timestamping are handled in ethdev due to
> slight feature differences between the control planes.

The error code ENODATA is not portable.

Target: x86_64-native-bsdapp-gcc
FAILED: [code=3D1] drivers/libtmp_rte_net_gve.a.p/net_gve_gve_ethdev.c.o=20
gcc -Idrivers/libtmp_rte_net_gve.a.p -Idrivers -I../drivers -Idrivers/net/g=
ve -I../drivers/net/gve -I../drivers/net/gve/base -Ilib/ethdev -I../lib/eth=
dev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ili=
b/eal/include -I../lib/eal/include -Ilib/eal/freebsd/include -I../lib/eal/f=
reebsd/include -Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal -I.=
./lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics=
 -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../li=
b/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I=
../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idriver=
s/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/bsd -Ilib/pci -I../lib/=
pci -Idrivers/bus/vdev -I../drivers/bus/vdev -fdiagnostics-color=3Dalways -=
D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 =
-include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonl=
iteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnest=
ed-externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare -=
Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-mis=
sing-field-initializers -D_GNU_SOURCE -D__BSD_VISIBLE -fPIC -march=3Dnative=
 -mno-avx512f -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-form=
at-truncation -Wno-address-of-packed-member -Wno-vla -DRTE_COMPONENT_CLASS=
=3Dpmd_net -DRTE_COMPONENT_NAME=3Dgve -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.g=
ve -MD -MQ drivers/libtmp_rte_net_gve.a.p/net_gve_gve_ethdev.c.o -MF driver=
s/libtmp_rte_net_gve.a.p/net_gve_gve_ethdev.c.o.d -o drivers/libtmp_rte_net=
_gve.a.p/net_gve_gve_ethdev.c.o -c ../drivers/net/gve/gve_ethdev.c
../drivers/net/gve/gve_ethdev.c: In function 'gve_rss_update_cache':
../drivers/net/gve/gve_ethdev.c:227:33: error: 'ENODATA' undeclared (first =
use in this function)
  227 |                         return -ENODATA;
      |                                 ^~~~~~~
