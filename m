Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50092CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 22:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E7640151;
	Sat, 25 Oct 2025 00:25:51 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 194494014F
 for <dev@dpdk.org>; Sat, 25 Oct 2025 00:25:49 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso2567232b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761344749;
 x=1761949549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA7qIi7tC1fTkzRPcRtIdZEdIASpY0GMZkacEqMRphM=;
 b=PrxItDeeBOPC3d0/Th4R3M7JlMGyXZt9/2FGKeHKiK/gZnrE+PEy9ptpR9TJATyMZ+
 PBRMomWOVF2iBToko4KAA9DSqaIuNEUO3qVdpdXlNVTgfL2ha2GW6mIn9eSLMPBf49Ut
 Ge184leuNAeYg0pmwzuEJSWEcF4jZgrVypCTX39Ev8MeyICiDnzDsdc/ms/M9R6dg0RJ
 LgonZB1dz0tgb/S3HzxP0bC2j4NEeiwfyrV3i+F2DRzNRs0M7hATzAF1v2y+9F/oNOVv
 LtvspfFrwI5rH2G0KJJtmQXGaB9KqzCmBtn8gJXDFJP4bCdW9qhS8yLwMeJUNDk1VRX4
 VLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761344749; x=1761949549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA7qIi7tC1fTkzRPcRtIdZEdIASpY0GMZkacEqMRphM=;
 b=YUKx/CmvIl5g6OWedspIx2T/gMJzqmREFmjQ+MAfNAWklLUEVhyKspULFjr1EQMK4l
 DTaRDTxWf2nTYzbHNBkQukBPftd1Z630RPQYLda5vHNolaDjuG02G5AkLoivZClQADWF
 UNVA/U1bPJ795tZdMmyjbdFGIXRqU5v8ZHQFwOmXdkAT1BRCB4APjMT91iTRLygJIQ0K
 fX0eyN11FPVp998UxdKqHr8XomTvKwgYTWKuYVdddUWUnlMmX7yWGG6qGtUEQUp5EJ5F
 v0Z58U1Ax+fq4YRUAj2+SWYmfwPyK+QfeLCWuTUlTgJqGcLUexpuFuIrQDqKHB4tmK7U
 8bNA==
X-Gm-Message-State: AOJu0YxksaBH3wF4OLyxqb9XPx0HVQ3RZWLcijUL4cskCd74B80JBChJ
 K9P/22qcNJ1Hb9w+oyNp1OHIEd/ezzyEPh+I76iTJdeVu+1TPBTclHG5EZJREldksHg=
X-Gm-Gg: ASbGnctblTb+28dJgECxipMiQc33+yZshSeKgatK7pRGmNs68kxH2+zmqhDXxH+uFxt
 IaDGihTAEGnGNcY7cjG+c+0jAkYrAw7RdZTCze4kn+M7AeJ2IT1Z6etiBxuK1lnwayKQYsKmpjm
 ANqOGw8+eMXoCLeVAIGg1NgqRuwlFX3B8UHlWGlJlAivqwNDwF/eBzwx8I0VRJrDCdnvp79QRae
 ZMp5FVBm57tK9u3TvKasVPxrIrCYTbgfop9AxgZihr5nION8M0GGQsfGLiiPmtFmQ6UjtQklfOE
 Ff6NIUMwDjKlOWv2XX4jk9Qm/gwU8jjZGkOPPUjMsrmk3xlMx4E5MYzmT7f0J0OhOALxw0XRC19
 uszRqTivfyH8kXx4Sj5ek0aJfxbRK90dLmAZCEBpIsUwdWvIZkp9ZpuznIpXk6QuIGY4Yfx7ipE
 fZBeawymTUewUUeoxvQgF2iLGd4zUwj/YGbKQ6IG2zJooO
X-Google-Smtp-Source: AGHT+IHOkakGoc9jEI9jjQYtiXdpbNwAag4o411AQ4eKwKgAHxR7qRJVjq213aur//HZfGG8q5fAkQ==
X-Received: by 2002:aa7:88d1:0:b0:7a2:8106:7a0f with SMTP id
 d2e1a72fcca58-7a281067c8emr6366973b3a.0.1761344749114; 
 Fri, 24 Oct 2025 15:25:49 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414011acdsm295646b3a.13.2025.10.24.15.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 15:25:48 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:25:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, shperetz@nvidia.com, viacheslavo@nvidia.com,
 bruce.richardson@intel.com, mb@smartsharesystems.com
Subject: Re: [PATCH v7 0/7] add mbuf debug capabilities
Message-ID: <20251024152546.5a568d6a@phoenix>
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
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

On Thu, 16 Oct 2025 22:34:38 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> History is added to mbuf for debugging.
>=20
> This series set some marks in mbuf allocation/freeing and ethdev Rx/Tx.
> More marks could be added in other libraries.
> Drivers could benefit a finer debugging by marking alloc/free calls,
> in addition to marks already done in the mbuf library.
> Even better, the application could add its own marks.
>=20
> As part of this series, mbuf statistics can be dumped,
> and a Python script will help to parse mbuf history.
>=20
> ---
>=20
> v7 changes:
> - loop for sum of allocated mbufs
> - remove unused Python import
>=20
> v6 changes:
> - simplify testpmd commands
> - use enum op type
> - rename Tx ops
> - mark free before freeing
> - mark out of sanity check loop
>=20
> v5 change:
> - fix MSVC build in testpmd
>=20
> v4 changes:
> - fix/rewrite testpmd commands
> - fix python script
> - fix thread safety
> - fix checks
> - fix logs
> - change config (no Meson option)
> - add documentation
>=20
> v3 changes:
> - use atomic
> - fix prefix
> - add asserts
> - reformat dump
> - remove #ifdef clutter
> - remove mlx5 patch
>=20
> v2 changes:
> - move to mbuf in dynamic field
>=20
> v1:
> - mempool feature
>=20
> ---
>=20
> Shani Peretz (3):
>   mbuf: record mbuf operations history
>   ethdev: mark mbufs in burst functions
>   usertools/mbuf: parse mbuf history dump
>=20
> Thomas Monjalon (4):
>   doc: explain debug options in mbuf guide
>   mbuf: move header include for logs
>   app/testpmd: use space separator in dump commands
>   app/testpmd: add commands to dump mbuf history
>=20
>  app/test-pmd/cmdline.c                      | 309 ++++++++++++++------
>  config/rte_config.h                         |   1 +
>  doc/guides/howto/debug_troubleshoot.rst     |   7 +
>  doc/guides/prog_guide/mbuf_lib.rst          |  18 +-
>  doc/guides/rel_notes/release_25_11.rst      |   7 +
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  33 ++-
>  lib/ethdev/rte_ethdev.h                     |  11 +
>  lib/mbuf/mbuf_history.c                     | 223 ++++++++++++++
>  lib/mbuf/mbuf_log.h                         |   2 +
>  lib/mbuf/meson.build                        |   2 +
>  lib/mbuf/rte_mbuf.c                         |   5 +-
>  lib/mbuf/rte_mbuf.h                         |  15 +-
>  lib/mbuf/rte_mbuf_dyn.h                     |  18 ++
>  lib/mbuf/rte_mbuf_history.h                 | 207 +++++++++++++
>  usertools/dpdk-mbuf-history-parser.py       | 165 +++++++++++
>  15 files changed, 917 insertions(+), 106 deletions(-)
>  create mode 100644 lib/mbuf/mbuf_history.c
>  create mode 100644 lib/mbuf/rte_mbuf_history.h
>  create mode 100755 usertools/dpdk-mbuf-history-parser.py
>=20


If build is done with lots of debug enabled it now fails.
Looks like typo in history code.

FAILED: lib/librte_mbuf.a.p/mbuf_mbuf_history.c.o=20
cc -Ilib/librte_mbuf.a.p -Ilib -I../lib -Ilib/mbuf -I../lib/mbuf -Ilib/eal/=
common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include =
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Il=
ib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I.=
./lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics=
 -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../li=
b/argparse -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -fdiagno=
stics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -=
std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat=
 -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-pro=
totypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-comp=
are -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wn=
o-missing-field-initializers -fzero-init-padding-bits=3Dall -D_GNU_SOURCE -=
DRTE_ENABLE_ASSERT -DRTE_LIBRTE_ETHDEV_DEBUG=3D1 -DRTE_LIBRTE_IPFRAG_TBL_ST=
AT -DRTE_LIBRTE_MEMPOOL_STATS -DRTE_LIBRTE_MEMPOOL_DEBUG -DRTE_MBUF_HISTORY=
_DEBUG -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNA=
L_API -Wno-format-truncation -DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.mbuf -MD -MQ l=
ib/librte_mbuf.a.p/mbuf_mbuf_history.c.o -MF lib/librte_mbuf.a.p/mbuf_mbuf_=
history.c.o.d -o lib/librte_mbuf.a.p/mbuf_mbuf_history.c.o -c ../lib/mbuf/m=
buf_history.c
In file included from ../lib/eal/x86/include/rte_vect.h:14,
                 from ../lib/eal/x86/include/rte_memcpy.h:17,
                 from ../lib/mempool/rte_mempool.h:50,
                 from ../lib/mbuf/mbuf_history.c:8:
../lib/mbuf/mbuf_history.c: In function =E2=80=98rte_mbuf_history_init=E2=
=80=99:
../lib/log/rte_log.h:364:9: error: static assertion failed: "This log forma=
t string contains a \\n"
  364 |         static_assert(!__builtin_strchr(fmt, '\n'), \
      |         ^~~~~~~~~~~~~
../lib/log/rte_log.h:387:9: note: in expansion of macro =E2=80=98RTE_LOG_CH=
ECK_NO_NEWLINE=E2=80=99
  387 |         RTE_LOG_CHECK_NO_NEWLINE(RTE_FMT_HEAD(__VA_ARGS__ ,)); \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
../lib/mbuf/mbuf_log.h:8:9: note: in expansion of macro =E2=80=98RTE_LOG_LI=
NE=E2=80=99
    8 |         RTE_LOG_LINE(level, MBUF, "" __VA_ARGS__)
      |         ^~~~~~~~~~~~
../lib/mbuf/mbuf_history.c:219:17: note: in expansion of macro =E2=80=98MBU=
F_LOG=E2=80=99
  219 |                 MBUF_LOG(ERR, "Failed to register mbuf history dyna=
mic field: %s\n",
      |                 ^~~~~~~~

