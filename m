Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F38DC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 18:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EF2940279;
	Wed,  1 Jul 2026 20:50:22 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id E817440264
 for <dev@dpdk.org>; Wed,  1 Jul 2026 20:50:20 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38005a36edbso552460a91.1
 for <dev@dpdk.org>; Wed, 01 Jul 2026 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782931820;
 x=1783536620; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8Hx550mH5AVqZkRf95mMcoyzg2Bp/sYcHb2st080Bk=;
 b=lzRwnUnXtS0KlJ2x4wwzyA/YyD+aNc1zKBPIH1Kf+C0RUac+uLheQ53L2TlI8GpE1+
 avERR/NVxrki9PuosvUSITeT56W44bPiAmyMOJnqYxQEkRP5TIDalBLd30GiyCKdgOhQ
 TQh8r0JQ9DgYE+0uNd7XYh3tWfoY+PLQdRfwb4T0ClC7Zz6xmHMuB86kkhgIlzMxRQzc
 eywAO1NYp9B++ow2j31jTVb13FNlyP4oN6PnIcqI+6sQZsMdzr6H59oYDdlP4fRx8sfh
 OM4k/PnzkXkM5sXBz146X3VYcraNKmQGsNZiZHv6jBdnx+xdKRDyAQTc547L36j8Amr2
 a3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782931820; x=1783536620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8Hx550mH5AVqZkRf95mMcoyzg2Bp/sYcHb2st080Bk=;
 b=V4DHlMBvKUzv1z+ss1CXlqxr3RikYhbHXuzKr1O8WK2uoT3jeZtJgcJvagi1E5XQnp
 0ajYn3gx+NeP+kAUuct9+sHHuDk7m4D8AkoOCHIadOIwVU67Als5ftqG9A8ATuo1X3hr
 fUp/roo4DP7MXnsga+2VLl+m1W3WoZMTUhyTaMswBqTvEa5qhpgwoNbWj6SytDVVh655
 2Ml6Ic7BlJpAbLH/o7kjpiepHDbE10E5ofn7Yk74UTGLOm/DOK4wlzTEt7oH/Cq4y4Ee
 nQbcdapwV8E2FXXkuVzaRVCW2dAXAql9bwUxYbrl3pmDWrNu2zt50iVc7RzN3Snz9ljl
 NCjg==
X-Gm-Message-State: AOJu0Yzq6ndVeT9VR9iYJ71ZDcKoqd6ztqnKq2ZZaCXrWpUJDQJx0oIX
 HH7bPKIt+uhq56Q14HAInucXgqqMdc6NBoSlzH8tk7okgj3zbTyOsM6htSTGHAo5YvM=
X-Gm-Gg: AfdE7ckC4X435tvnLZMqmeYhJRLSpLw67/KE/nxdaaX8kR9eGIHVuA16+JMaWf0sS6Q
 AJCCKutuvU+72g7VinpFw5p/Eo2WOrhGJJMbdEm2uLIggMjdLEixEbRRbl48beZKkFg5yn5G8n1
 cW+UXPp/KREV6mnkJFKDP29rdPxOliGH1/F7FxMb0iL1vA/Gzd3Fey2rvEa0+NbRdJM9LSJeLw2
 oeC5lZSEEQ02236YjV+ytntdmwCmT8Ct5v5Qhv73fv/bR8oui4zvZoAfo7QSwIGxdmPAi5lblSZ
 yWmGS5C2NWNLYV9LorAvM+3f14V11dU4Of7OSMTXLlD3LvsSTOjn8TQkqEFujxqwmO+vyh6EPU1
 c40+ljD1v7AT7HlXspEHhfPh7vXOELBglaBGgdcMEHUKtvB9JyxkNTtmNPaYmBMxYSsc9wiVL8A
 CYkRszypRlYjweMXyLehHMpf9dkOfAZOJ+TN9O6UuQMV52OE/i32C5Sg==
X-Received: by 2002:a17:90a:d408:b0:37f:9ce2:348a with SMTP id
 98e67ed59e1d1-380aa2075bemr3197503a91.27.1782931819790; 
 Wed, 01 Jul 2026 11:50:19 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b85de12sm478339eec.12.2026.07.01.11.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:50:19 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:50:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/9] Stability fixes for GVE
Message-ID: <20260701115016.39c34f53@phoenix.local>
In-Reply-To: <20260701183528.2443032-1-joshwash@google.com>
References: <20260701183528.2443032-1-joshwash@google.com>
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

On Wed,  1 Jul 2026 11:35:18 -0700
Joshua Washington <joshwash@google.com> wrote:

> This patch series consists of mostly unrelated fixes in the GVE driver.
>=20
> Joshua Washington (9):
>   net/gve: clear out shared memory region for stats report
>   net/gve: delay adding mbuf head to software ring
>   net/gve: copy data to QPL buffer when mbuf read does not
>   net/gve: validate buf ID before processing Rx packet
>   net/gve: set mbuf to null in software ring after use
>   net/gve: free ctx mbuf if packet dropped after first segment
>   net/gve: increase range of DMA memzone ids to 64 bits
>   net/gve: don't reset ring size bounds to default on reset
>   net/gve: restrict max ring size in GQ QPL to 2K
>=20
>  drivers/net/gve/base/gve_adminq.c | 12 ++++++---
>  drivers/net/gve/base/gve_osdep.h  |  4 +--
>  drivers/net/gve/gve_ethdev.c      |  8 +++---
>  drivers/net/gve/gve_ethdev.h      |  1 +
>  drivers/net/gve/gve_rx.c          |  3 +++
>  drivers/net/gve/gve_rx_dqo.c      |  6 +++++
>  drivers/net/gve/gve_tx.c          | 42 +++++++++++++++++++------------
>  7 files changed, 52 insertions(+), 24 deletions(-)
>=20

*Build Failed #1:
OS: OpenAnolis8.10-64
Target: x86_64-native-linuxapp-gcc
FAILED: drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o=20
gcc -Idrivers/libtmp_rte_net_gve.a.p -Idrivers -I../drivers -Idrivers/net/g=
ve -I../drivers/net/gve -I../drivers/net/gve/base -Ilib/ethdev -I../lib/eth=
dev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ili=
b/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/lin=
ux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux=
 -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log=
 -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/ar=
gparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -I=
lib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/=
meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Il=
ib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -fdiagnostics-=
color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror=
 -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wform=
at -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-p=
rototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshadow =
-Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-=
aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dnative=
 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation=
 -Wno-vla -DRTE_COMPONENT_CLASS=3Dpmd_net -DRTE_COMPONENT_NAME=3Dgve -DRTE_=
LOG_DEFAULT_LOGTYPE=3Dpmd.net.gve -MD -MQ drivers/libtmp_rte_net_gve.a.p/ne=
t_gve_gve_tx.c.o -MF drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o.d -o=
 drivers/libtmp_rte_net_gve.a.p/net_gve_gve_tx.c.o -c ../drivers/net/gve/gv=
e_tx.c
../drivers/net/gve/gve_tx.c: In function =E2=80=98gve_tx_burst_qpl=E2=80=99:
../drivers/net/gve/gve_tx.c:258:21: error: variable =E2=80=98addr=E2=80=99 =
set but not used [-Werror=3Dunused-but-set-variable]
  uint64_t ol_flags, addr, fifo_addr;
                     ^~~~
cc1: all warnings being treated as errors
[1640/3750] Compiling C object drivers/libtmp_rte_net_gve.a.p/net_gve_gve_r=
x.c.o
[1641/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_b=
ase_hinic_pmd_cfg.c.o
[1642/3750] Compiling C object drivers/libtmp_rte_net_failsafe.a.p/net_fail=
safe_failsafe_ops.c.o
[1643/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_b=
ase_hinic_pmd_api_cmd.c.o
[1644/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_b=
ase_hinic_pmd_cmdq.c.o
[1645/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_h=
inic_pmd_rx.c.o
[1646/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_h=
inic_pmd_flow.c.o
[1647/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_h=
inic_pmd_ethdev.c.o
[1648/3750] Compiling C object drivers/libtmp_rte_net_hinic.a.p/net_hinic_h=
inic_pmd_tx.c.o
ninja: build stopped
