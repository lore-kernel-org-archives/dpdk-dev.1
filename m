Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C38FC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 15:39:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 843E040685;
	Thu, 10 Apr 2025 17:39:44 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 05861402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 17:39:43 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-ad51f427054so788561a12.1
 for <dev@dpdk.org>; Thu, 10 Apr 2025 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744299583;
 x=1744904383; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI/K2K3TkGRx959xGVexRSf8xdSgkv5GWYixZLZnLZk=;
 b=VnzoaeDhdOr436a32a70j3hpFyHA4g3e/n5N+8NXAX31d0WMDpiH1GpD1LfOI0qg0p
 kMGRB/CaJHIKua6Hvv54pA2M19YseB4t2+DJUjHTd+z/8qF3a5N0Qiz7H4zSHUiUJ1zx
 WxtOV08lM24TZyd7/1tPIiBYkeZnCjGSgMbAblda/tniUtgAl5FuuqlxJ6KSAoTWGArP
 Y8Ldj5zqusKr68SW2nVPbhyQwzIjIkpLldAC5NPV+zMmBmKvSCBkxHTCLvtJbv1ZHDpI
 Yu2Pzn5Yu9npw5RQxvnoeCCPJmBobjNPOmNq+vT2ffWTbK5hXEP/6p/D6zbsVgJrRj50
 pM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744299583; x=1744904383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bI/K2K3TkGRx959xGVexRSf8xdSgkv5GWYixZLZnLZk=;
 b=xQY87ZCLUV4MF922RNfMdgm/HwFI7h33DECrUwRiUICAfY9fPvWB4AsDd1tC9lLGsR
 RmM76OBY4mqU3GQZj2I+Gf3j5GWlnf/xid3mExUwG97Tw2jL7XNurXVJXuVhzC+i+mWJ
 JEvyE5t9AyDxGOqI3AheE0BC/4UpxMWkzT5IOsdrrWIBQ+pyV0Zc2b7iMG0qPjEyPzGG
 3XJeNZ6b0vUqEkpYReM4zGiB56oflfIG9xxfVBrTGDC/ll4rxfISU94HWgKNl22NeaSK
 nUGvBwMBDPQZo2pvaA+1KqZAWScB5zc+862HLpAHJy9p5JfH0gmjqq4QpwOU2U0mowLw
 XaHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEaaA1m0z1bsgKRmR/ksYH8+8KHiDbYeReriEicxDMBKImlWDPxgAEebQdMhnkJVIcW0o=@dpdk.org
X-Gm-Message-State: AOJu0YymbtvMOVpHZJ5lPGE9mJHz4pBzSgP6QZcv80ehNMQMOpE+GUs0
 hpKBN1OOzVAaGHwh3cygsbBw0APXcMBTBMa8TGouGl4730tsscXWOJMRZaqnOjA=
X-Gm-Gg: ASbGnctLPTHR4dQTMuBIqMZ4VU0nZmuD4eD6canT1OUH4oI71LL8sQAw4ptR2zX5n/z
 r+h1Fj/8TRX5CaOxrbrQ5+UVccaTkYlQWoDAS1/ylWerulRJi8gD0b++8QgTuJK6EreqvPe6yrK
 GCSdXRyztGmeJsmDp0Z77zP2U9tEIPnDikR6c7Y++ZbsO5ESUNcvxtVQeQONi3ofE+fIJSPRRr7
 7e4YejHrSGsiqxqxAvs3IhQoixcaPaqIRljBRCs+w2950J7wZiMJqem25Mg8VOQp5ltifROqqTb
 8JhjmaK9czDINKoqZQe6jPeNv7t/XC1o2UyG/obQP/jyjLEuM66ZZNdZIFXA26mrDG2+gC2vXIf
 G0WeANmwNfxJ9Tjbg
X-Google-Smtp-Source: AGHT+IHaB0H2FfZE6vDtqky+Dzk1SN55muj5YMuo0aRr25/l5ql0mGscNEj6GDJ7TEjYv3HCSjABeg==
X-Received: by 2002:a17:902:c948:b0:21f:68ae:56e3 with SMTP id
 d9443c01a7336-22b42c13241mr47455945ad.39.1744299582848; 
 Thu, 10 Apr 2025 08:39:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b8c60csm32154085ad.93.2025.04.10.08.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 08:39:42 -0700 (PDT)
Date: Thu, 10 Apr 2025 08:39:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [patch v5 0/6] Support VMBUS channels without monitoring enabled
Message-ID: <20250410083940.580f9d77@hermes.local>
In-Reply-To: <1744149236-30264-1-git-send-email-longli@linuxonhyperv.com>
References: <1744149236-30264-1-git-send-email-longli@linuxonhyperv.com>
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

On Tue,  8 Apr 2025 14:53:50 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> Hyperv may expose VMBUS channels without monitoring enabled. In this case,
> it programs almost all the data traffic to VF.
>=20
> This patchset enabled vmbus/netvsc to use channels without monitoring
> enabled.
>=20
> This needs to change the APIs exposed by drivers/bus/vmbus. Because those
> APIs are used only by NetVSC PMD and not feasible for use by a DPDK
> application, all VMBUS APIs are set to deprecate in upcoming 25.11 releas=
e.
>=20
> The notice for deprecation is accepted in the following patch:
> https://patchwork.dpdk.org/project/dpdk/patch/1742242184-19600-1-git-send=
-email-longli@linuxonhyperv.com/
>=20
> Change log:
> v3: Add in the comment on the VMBUS API deprecation notice
>=20
> Long Li (6):
>   net/netvsc: introduce private data for storing vmbus device for
>     secondary process
>   net/netvsc: introduce get_vmbus_device to get the vmbus device
>   bus/vmbus: store UIO fd for secondary process
>   bus/vmbus: support channels without monitoring enabled
>   bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
>   bus/vmbus: set event for channel without monitoring support
>=20
>  drivers/bus/vmbus/linux/vmbus_bus.c  |  9 +++--
>  drivers/bus/vmbus/linux/vmbus_uio.c  |  6 +--
>  drivers/bus/vmbus/private.h          |  2 +-
>  drivers/bus/vmbus/rte_bus_vmbus.h    | 16 +++++---
>  drivers/bus/vmbus/vmbus_channel.c    | 57 ++++++++++++++++++++--------
>  drivers/bus/vmbus/vmbus_common_uio.c |  9 +++--
>  drivers/net/netvsc/hn_ethdev.c       | 44 ++++++++++++++++-----
>  drivers/net/netvsc/hn_nvs.c          | 33 +++++++++++-----
>  drivers/net/netvsc/hn_nvs.h          | 21 ++++++----
>  drivers/net/netvsc/hn_rndis.c        | 11 +++---
>  drivers/net/netvsc/hn_rxtx.c         | 16 ++++----
>  11 files changed, 155 insertions(+), 69 deletions(-)
>=20

Still see issues in clang build.
This happens because clang treats _Atomic() as a different type:


###########################################################################=
#########
#### [Begin job log] "ubuntu-22.04-gcc-stdatomic" at step Build and test
###########################################################################=
#########
[449/3553] Compiling C object lib/librte_port.a.p/port_rte_swx_port_ring.c.o
[450/3553] Generating rte_bus_ifpga.pmd.c with a custom command
[451/3553] Generating rte_bus_vdev.pmd.c with a custom command
[452/3553] Compiling C object drivers/libtmp_rte_common_ionic.a.p/common_io=
nic_ionic_common_uio.c.o
[453/3553] Compiling C object lib/librte_port.a.p/port_rte_swx_port_source_=
sink.c.o
[454/3553] Linking static target lib/librte_port.a
[455/3553] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vm=
bus_bufring.c.o
[456/3553] Linking static target drivers/librte_common_cnxk.a
[457/3553] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_li=
nux_vmbus_bus.c.o
[458/3553] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vm=
bus_common.c.o
[459/3553] Compiling C object drivers/libtmp_rte_bus_vmbus.a.p/bus_vmbus
ccache gcc -Idrivers/libtmp_rte_bus_vmbus.a.p -Idrivers -I../drivers -Idriv=
ers/bus/vmbus -I../drivers/bus/vmbus -I../drivers/bus/vmbus/linux -Ilib/eal=
/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include=
 -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -I=
lib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I=
../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metric=
s -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -fdiagnostics-color=
=3Dalways -pipe -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werro=
r -std=3Dc11 -O2 -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -W=
format -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissi=
ng-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsig=
n-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-align=
ed -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dcorei7 -mrt=
m -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno=
-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=3Dbus.vmbus -MD -MQ dri=
vers/libtmp_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -MF drivers/libtm=
p_rte_bus_vmbus.a.p/bus_vmbus_vmbus_channel.c.o.d -o drivers/libtmp_rte_bus=
_vmbus.a.p/bus_vmbus_vmbus_channel.c.o -c ../drivers/bus/vmbus/vmbus_channe=
l.c
../drivers/bus/vmbus/vmbus_channel.c: In function =E2=80=98vmbus_set_monito=
r=E2=80=99:
../drivers/bus/vmbus/vmbus_channel.c:51:22: error: assignment to =E2=80=98u=
int32_t *=E2=80=99 {aka =E2=80=98unsigned int *=E2=80=99} from incompatible=
 pointer type =E2=80=98_Atomic uint32_t *=E2=80=99 {aka =E2=80=98_Atomic un=
signed int *=E2=80=99} [-Werror=3Dincompatible-pointer-types]
   51 |         monitor_addr =3D &channel->monitor_page->trigs[trigger_inde=
x].pending;
      |                      ^
cc1: all warnings being treated as errors
