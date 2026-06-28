Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5682C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 22:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33A74021E;
	Mon, 29 Jun 2026 00:24:37 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id E8ED4400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 00:24:35 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30bf132969bso3873212eec.0
 for <dev@dpdk.org>; Sun, 28 Jun 2026 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782685475;
 x=1783290275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tBZwazAcYVhd6BvR7/EH7QZKBX7OHD6Cgr2zjqWC04=;
 b=mwoAP4CzmlNfHhh3xH1JyJu8/th4vSwvHtdi5Ve1bfuzkJUIoaMiqSXxUYnk6aTWwE
 4UjUNnPt8EUIccH8gIknkZcabpA2o3RtNbRlrXtgBmzsGMP/ovhViT9VUgz665tNa58Z
 RiqWm/TJVfzxkIW4EPqmx9V8VMn/Oif33w/AoyD5WYeM/bCmexDpyqQfxDDkk32h+Z0I
 0YE3gw5SCPaY/belH48iAKOUrsd3WXrEPhhTaoxnx4RVmZBmvzkktdMOFGMHAIFce/om
 Sqszb6m8J5RgV8IhzDBZQ9BBh+iMOrVcGhYM3TqFO9RDlIKh6wOgucNLCEQ+se0gxgb0
 Xr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782685475; x=1783290275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4tBZwazAcYVhd6BvR7/EH7QZKBX7OHD6Cgr2zjqWC04=;
 b=p2iwYCvqvkgqUoPRAyA8rEesjsx360EVJHbTyREPnBLNOmNuZCDV9ePd3UHMbrL0ky
 2OkdTZXHisu17drashpl4ggJZv+fk8HoBJzdJyOUpUdeYVfWB+OYdYA+on80etKcrXnK
 gdArVV2PRcm4WEuXe0F3KO+8pnf5nyj4IlsOuULQV6hfu9h5FHzk1jt+upSil1QuJuV+
 999hWQPBQaqwB4cp/kNVAc/PKv4ojjjQyW+fZ/NcO3awYnbo1DGaRQbexury4XB1fbTX
 i4o5z+4npvq5hbYuHEcNxs2dcXsoYl869TCITBX7WoADVLlitQ1hphl4tfLvOIHB+FBP
 tUpQ==
X-Gm-Message-State: AOJu0Yxtf1Zc8VmgBGIjP6m2Lox5B9e1/WFEAiD2HJ3T0pFiZMe5Tqkq
 trXVOo/1xRX3Zqhor/U1L9yt59zK6gj61nI36irB2zGGox8O0HCJVDLU7mZNi7mrdCw=
X-Gm-Gg: AfdE7cluBNeyoeAWqCGPaPv8LScgKaGjDDdH297woJ/wM4ecPYQUm323MPpQS6iX2Lr
 JHbPuWtrSaL3yv4ru4Y/nYass9vyS9gjw/Ccjzat/xxZbAWP1z/YsFiDGXsf12mUGw1RYsHHrCC
 MvxcVm/5+5ytd4OdbU7nbbrOoHLcrUmc4eceRxo+of2XM2W/75tKi4xKMRfaLUz5OCNaxIaW1XH
 aiA3V89bavXq+4PX72bmZpNSU3v7whm55vkdKl3K5uNoZMP7uLJyXIUwXLZVBInTzZlQOR7gBAU
 nL58mwHcx0s80XPkCHShF59e/4XoDjxaF5z98DkuosWrdJrnzAYsFvEWb+tjxgjn4fa70SdAjZW
 LHKl2lP8i7KYoKgmRHvhXMOm0sxeU4fD0ckd2/6wiaMSpZeh7Q1VrB05kaSb9qNymZBXk1gydBG
 SSSsgv/SNICAe1JNNCu+FiIRNWx9OfO70jX+d2Km7dHj2iAF6e5TkMEw==
X-Received: by 2002:a05:7300:d021:b0:30c:536e:3a8a with SMTP id
 5a478bee46e88-30c84b7208amr12685091eec.6.1782685474747; 
 Sun, 28 Jun 2026 15:24:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca438ddsm38046542eec.23.2026.06.28.15.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:24:34 -0700 (PDT)
Date: Sun, 28 Jun 2026 15:24:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v3 0/9] ENETC driver related changes series
Message-ID: <20260628152431.652c0856@phoenix.local>
In-Reply-To: <20260623060004.2187716-1-g.singh@nxp.com>
References: <20260622113517.1616028-1-g.singh@nxp.com>
 <20260623060004.2187716-1-g.singh@nxp.com>
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

On Tue, 23 Jun 2026 11:29:55 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V3 changes:
>   - Added documentation for all devargs in enetc4.rst.
>   - Fixed kvlist memory leak issue.
>=20
> V2 changes:
>   - Fixed an un-used variable compilation issue reported on fedora:43-gcc=
-minsize
>   - Fixed various AI reported issues:
> 	- Release notes updated for all new devargs
> 	- enect4.ini features doc updated for scattered RX.
> 	- removed Not required RTE_PTYPE_UNKNOWN.
> 	- Fixed mid-frame mbuf leak in SG case.
> 	- Enabled SG for enetc4 PF also.
> 	- move to calloc from rte_zmalloc in parse_txq_prior().
> 	- added vaidation checks on strdup, strtoul.
> 	- added NC devargs to use cacheable ops conditionally.
> 	- removed dead code like bd_base_p etc.
> 	- Fixed rte_cpu_to_le_16() conversion on flags and combined
> 	  all flags related patches in one patch.
> 	- Fixed memory leak issue due to TXQ priority patch.
>    - There were some false positives, I have ignored them:
> 	Race condition on flags field:
> 		clean_tx_ring only touches HW-completed BDs (next_to_clean=E2=86=92hwci=
),
> 		never newly-submitted BDs; doorbell hasn't fired yet.
> 	Missing dcbf in clean_tx_ring:
> 		DPDK is single-threaded per queue; TX path always overwrites
> 		flags completely before dcbf.
> 	TX dcbf granularity with wrap:
> 		Safe (AI admits it).
> 	RX refill flush at wrap:
> 		In-loop dcbf at i & mask =3D=3D 0 already flushes aligned groups;
> 		trailing flush only needed for partial groups.
> 	RX reading before invalidate:
> 		dccivac precedes the read for every group in the loop
>=20
> Gagandeep Singh (7):
>   net/enetc: fix TX BD structure
>   net/enetc: fix queue initialization
>   net/enetc: support ESP packet type in packet parsing
>   net/enetc: update random MAC generation code
>   net/enetc: add option to disable VSI messaging
>   net/enetc: add devargs to control VSI-PSI timeout and delay
>   net/enetc4: add cacheable BD ring support with SW cache maintenance
>=20
> Vanshika Shukla (2):
>   net/enetc: support scatter-gather
>   net/enetc: set user configurable priority to TX rings
>=20
>  doc/guides/nics/enetc4.rst             |  62 +++-
>  doc/guides/nics/features/enetc4.ini    |   1 +
>  doc/guides/rel_notes/release_26_07.rst |  10 +
>  drivers/net/enetc/base/enetc_hw.h      |  13 +-
>  drivers/net/enetc/enetc.h              |  31 +-
>  drivers/net/enetc/enetc4_ethdev.c      | 172 ++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 206 ++++++++++--
>  drivers/net/enetc/enetc_ethdev.c       |  25 +-
>  drivers/net/enetc/enetc_rxtx.c         | 430 ++++++++++++++++++++++---
>  9 files changed, 831 insertions(+), 119 deletions(-)
>=20

I had merged this to net-next, but now removed it after running ./devtools/=
test-meson-builds.sh
This script runs a number of builds with different configs, and these drive=
r changes fail in one case.

DPDK 26.07.0-rc1

  User defined options
    buildtype             : minsize
    default_library       : static
    enable_deprecated_libs: *
    enable_stdatomic      : false
    examples              : l3fwd
    werror                : true

Found ninja-1.13.2 at /usr/bin/ninja
ninja: Entering directory `./build-gcc-static'
[2191/3862] Compiling C object drivers/libtmp_rte_net_enetc.a.p/net_enetc_e=
netc_rxtx.c.o
FAILED: [code=3D1] drivers/libtmp_rte_net_enetc.a.p/net_enetc_enetc_rxtx.c.=
o=20
/usr/bin/ccache gcc -Idrivers/libtmp_rte_net_enetc.a.p -Idrivers -I../drive=
rs -Idrivers/net/enetc -I../drivers/net/enetc -I../drivers/net/enetc/base -=
Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -=
Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/=
include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/i=
nclude -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvarg=
s -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I.=
./lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Il=
ib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ri=
ng -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../d=
rivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers=
/bus/vdev -Idrivers/common/dpaax -I../drivers/common/dpaax -I../drivers/com=
mon/dpaax/caamflib -I/usr/include/x86_64-linux-gnu -fdiagnostics-color=3Dal=
ways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc1=
1 -Os -g -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wfo=
rmat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototyp=
es -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-=
compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned=
 -Wno-missing-field-initializers -fzero-init-padding-bits=3Dall -D_GNU_SOUR=
CE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_AP=
I -Wno-format-truncation -Wno-address-of-packed-member -DRTE_COMPONENT_CLAS=
S=3Dpmd_net -DRTE_COMPONENT_NAME=3Denetc -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.ne=
t.enetc -MD -MQ drivers/libtmp_rte_net_enetc.a.p/net_enetc_enetc_rxtx.c.o -=
MF drivers/libtmp_rte_net_enetc.a.p/net_enetc_enetc_rxtx.c.o.d -o drivers/l=
ibtmp_rte_net_enetc.a.p/net_enetc_enetc_rxtx.c.o -c ../drivers/net/enetc/en=
etc_rxtx.c
../drivers/net/enetc/enetc_rxtx.c: In function =E2=80=98enetc_xmit_pkts_nc=
=E2=80=99:
../drivers/net/enetc/enetc_rxtx.c:213:20: error: =E2=80=98txbd=E2=80=99 may=
 be used uninitialized [-Werror=3Dmaybe-uninitialized]
  213 |                 if (likely(txbd))
      |                    ^
../drivers/net/enetc/enetc_rxtx.c:162:29: note: =E2=80=98txbd=E2=80=99 was =
declared here
  162 |         struct enetc_tx_bd *txbd;
      |                             ^~~~
../drivers/net/enetc/enetc_rxtx.c: In function =E2=80=98enetc_xmit_pkts_cac=
heable=E2=80=99:
../drivers/net/enetc/enetc_rxtx.c:715:20: error: =E2=80=98txbd=E2=80=99 may=
 be used uninitialized [-Werror=3Dmaybe-uninitialized]
  715 |                 if (likely(txbd))
      |                    ^
../drivers/net/enetc/enetc_rxtx.c:644:29: note: =E2=80=98txbd=E2=80=99 was =
declared here
  644 |         struct enetc_tx_bd *txbd;
      |                             ^~~~
cc1: all warnings being treated as errors
[2224/3862] Generating drivers/rte_common_cnxk.sym_chk with a custom comman=
d (wrapped by meson to capture output)
ninja: build stopped: subcommand failed.

