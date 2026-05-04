Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D6CD3427
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 17:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25E02402B2;
	Mon,  4 May 2026 19:56:28 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 71633400EF
 for <dev@dpdk.org>; Mon,  4 May 2026 19:56:25 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso4661236eec.0
 for <dev@dpdk.org>; Mon, 04 May 2026 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777917384;
 x=1778522184; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOKdKucaUi6j5U/QLlTfdzIlokY6qDl0MOtd7ZSBUJU=;
 b=A9TnXZ++EUSrx2pP0yzSzl+mwu+VM2AszwjXFYzOxELBjlr47/pGloljTpBhTFamCb
 Pkz9LMlYRBiI23F/uGh8yB25RoCkfFjdyfkP0awjtYiHXXqMVIH2msLocR4t3O3r6gV6
 s3k2+8icvLttdv37xLqJDl0XpjsVDYHA37f4Gz/E3/ZcuyXIMYP7gcVqSoQDEEtBJPVo
 jTBFVrj5uN0texQQgmAz5WRX2gOIZN4qBYWUZOtSO2pByW2XzkJSoHOvwFTrHGJ7S7M0
 W3t1TQEl6BZjpgiec19hjnzi8iczHVoVwv+DVRy2J9W7FxhFeHOB62DCRPrpGapTLxxQ
 rggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777917384; x=1778522184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOKdKucaUi6j5U/QLlTfdzIlokY6qDl0MOtd7ZSBUJU=;
 b=sYAtYTXZmGe9FyJR7GMrsHE63rdlFoBwznl03VqSdI+YSeAV4YXFMqOcREaOEYemGX
 hsSktXOFrT+jeSoxiDa6a7RLU098b/cKcjTryUbjhxTU5k2MBjfDzMSXTuhHNgUmy+Ac
 FBMNXG5G5VDbntfxprTuHMeI/LicaLUq5dfmyjwUMF5mcDa1GonJPIZhgGM/uW9QXB64
 eYUb/8lEa9BIPmLJ4zjyqD5KD4j5omlJ/9Dj/JK/DiORuvfju+pkodRODXGC2HRWXsDF
 hgjXhbnXCxAw1VFhEPvvfRKQwImkdjIYt6BBgnx3mEGyR2bYn8lU1VHBHWwiDiEQClyD
 08QQ==
X-Gm-Message-State: AOJu0Yyu4E3VkwhN2dmul76QcJFd++oIoHmZG9ajzYvm3YrTK457kfPi
 UtdiaX1b5mB8GjHsNUqG5cCso4gVXvwFQsz3JzD3gTzKlLYEXBf8LW/NfPCHfsWGkCg=
X-Gm-Gg: AeBDieumUb+ccUxmWFOD4N8VcvAQhWtfd7oqcQO3Ay12CiP4Wd0tz00Jgw08lw+TGyg
 AkUaYz47O1dAhbw2s+GlIeBrgwptHpFqleII2M3peVbtUZyp7KSozsuEjOmZnQ5rk3ghuor1aFR
 j33ZhvkAL4A48Jz5t8pPJKu/7SPG2j44Llio8othyqIvl0J3DeMtZkcaH84wu0cjAE9VLtx494t
 c1AgMpFhzdqE3WzTmH1GOTHebafLV4M+e85g4W1hXKJvnLkkSEKKyJBVz9KKi/BbkVOHZhKRW6k
 Ov/5t9elNdr5NIOmkK5I+wxs/xx+SJ7anPlAs0t1P6OCNwWtZNMMZi/HHHvSddDiIPfNdqr50xY
 wvaQRTohVVm+6nTqUQ5oe+XiI7FFWZRTCJfURKQz0j8exX5UdTL2/jHtdB6zu0i6CotQw9JjXK/
 VaovRnCUyKV61BETkYdGdOI+j9B697pnPF3RG16XiuMmn4hw==
X-Received: by 2002:a05:7301:2c88:b0:2d9:cfa6:3d34 with SMTP id
 5a478bee46e88-2efba28a5fbmr4645323eec.23.1777917383841; 
 Mon, 04 May 2026 10:56:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3b7815d4sm16138213eec.20.2026.05.04.10.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:56:23 -0700 (PDT)
Date: Mon, 4 May 2026 10:56:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [RFC v3 0/6] introduce PTP protocol library and software relay
Message-ID: <20260504105621.0eb6dbab@phoenix.local>
In-Reply-To: <20260504091728.1406661-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260504091728.1406661-1-rajesh3.kumar@intel.com>
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

On Mon,  4 May 2026 14:47:16 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> This series introduces a new DPDK library (lib/ptp) for IEEE 1588-2019
> PTP protocol packet processing and a companion example application
> (ptp_tap_relay_sw) that demonstrates its usage.
>=20
> Motivation
> ----------
> Several DPDK applications need to classify and manipulate PTP packets
> (e.g. ptpclient, ptp_tap_relay, custom Transparent Clocks). Today each
> application re-implements its own PTP header parsing and correctionField
> handling. A shared library avoids duplication and provides a tested,
> standards-compliant foundation.
>=20
> Library: lib/ptp
> ----------------
> The library provides:
>   - PTP header structures (IEEE 1588-2019 common header, timestamp,
>     port identity)
>   - Packet classification: rte_ptp_classify() detects PTP over L2
>     (EtherType 0x88F7), VLAN-tagged L2 (TPIDs 0x8100/0x88A8, single
>     or double), UDP/IPv4, UDP/IPv6 (ports 319/320), and VLAN-tagged
>     UDP variants
>   - Header access: rte_ptp_hdr_get() returns a pointer to the PTP
>     header inside an mbuf
>   - Inline helpers: correctionField manipulation (48.16 fixed-point),
>     message type extraction, two-step flag check, timestamp conversion
>   - Debug: rte_ptp_msg_type_str() for human-readable message names
>=20
> Example: ptp_tap_relay_sw
> -------------------------
> A minimal PTP Transparent Clock relay between a DPDK-bound physical NIC
> and a kernel TAP interface using software timestamps only. No patched
> kernel modules, custom TAP PMD, or hardware timestamp support is
> required.
>=20
> The relay:
>   1. Receives packets on the physical NIC via DPDK
>   2. Parses packets using rte_ptp_hdr_get()
>   3. For event messages, records software timestamps
>      (clock_gettime(CLOCK_MONOTONIC)) at ingress and egress
>   4. Adds residence time to correctionField via rte_ptp_add_correction()
>      (IEEE 1588-2019 10.2 Transparent Clock)
>   5. Forwards bidirectionally: PHY <-> TAP
>=20
> Unit Tests: app/test
> --------------------
> A comprehensive test suite (ptp_autotest) covers all library APIs,
> including VLAN/QinQ/IPv4/IPv6 transports, correctionField helpers,
> flags, and negative tests. This v3 also adds coverage for IPv4 options
> (IHL > 5).
>=20
> v3:
>   - Reused RTE_ETHER_TYPE_1588 via RTE_PTP_ETHERTYPE alias
>   - Updated version field comment to minorVersionPTP|versionPTP
>   - Fixed prog guide rte_ptp_hdr_get() signature (non-const mbuf)
>   - Added ALLOW_EXPERIMENTAL_API to ptp_tap_relay_sw Makefile
>   - Updated relay example to parse once (rte_ptp_hdr_get + msg_type)
>   - Updated relay sample app limitations wording to match capabilities
>   - Added hdr_get NULL checks in correction tests
>   - Added IPv4 options classification test (IHL > 5)
>   - Made correction counter update style consistent via pointer arg
>=20
> v2:
>   - Fixed flag bit positions for host-order representation after
>     rte_be_to_cpu_16(): TWO_STEP (1<<9), UNICAST (1<<10),
>     LI_61 (1<<0), LI_59 (1<<1)
>   - Fixed QinQ classification: outer 0x88A8 now enters VLAN parser
>   - Fixed signed left-shift UB in rte_ptp_add_correction()
>   - Fixed promiscuous enable failure handling in relay port_init()
>   - Replaced deprecated master/slave terminology with IEEE terms
>   - Added and documented IHL validation for IPv4 PTP-over-UDP
>   - Changed rte_ptp_is_event() parameter to int with negative guard
>   - Changed rte_ptp_hdr_get() parameter to non-const mbuf
>   - Added programmer's guide note about avoiding double-parse
>=20
> Rajesh Kumar (6):
>   ptp: introduce PTP protocol library
>   doc: add PTP library programmer's guide
>   examples/ptp_tap_relay_sw: add software PTP relay example
>   doc: add PTP software relay sample app guide
>   app/test: add PTP library unit tests
>   examples/ptpclient: use shared PTP library definitions
>=20
>  MAINTAINERS                                   |    8 +
>  app/test/meson.build                          |    1 +
>  app/test/test_ptp.c                           | 1106 +++++++++++++++++
>  doc/api/doxy-api-index.md                     |    1 +
>  doc/api/doxy-api.conf.in                      |    1 +
>  doc/guides/prog_guide/index.rst               |    1 +
>  doc/guides/prog_guide/ptp_lib.rst             |  205 +++
>  doc/guides/rel_notes/release_26_07.rst        |   13 +
>  doc/guides/sample_app_ug/index.rst            |    1 +
>  doc/guides/sample_app_ug/ptp_tap_relay_sw.rst |  212 ++++
>  examples/meson.build                          |    1 +
>  examples/ptp_tap_relay_sw/Makefile            |   43 +
>  examples/ptp_tap_relay_sw/meson.build         |   14 +
>  examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  |  433 +++++++
>  examples/ptpclient/meson.build                |    1 +
>  examples/ptpclient/ptpclient.c                |  188 ++-
>  lib/meson.build                               |    1 +
>  lib/ptp/meson.build                           |    6 +
>  lib/ptp/rte_ptp.c                             |  185 +++
>  lib/ptp/rte_ptp.h                             |  339 +++++
>  20 files changed, 2644 insertions(+), 116 deletions(-)
>  create mode 100644 app/test/test_ptp.c
>  create mode 100644 doc/guides/prog_guide/ptp_lib.rst
>  create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
>  create mode 100644 examples/ptp_tap_relay_sw/Makefile
>  create mode 100644 examples/ptp_tap_relay_sw/meson.build
>  create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
>  create mode 100644 lib/ptp/meson.build
>  create mode 100644 lib/ptp/rte_ptp.c
>  create mode 100644 lib/ptp/rte_ptp.h
>=20
>=20
> base-commit: 7baf81674a011ab8a2fe329566b6d43d7377244c

Lots of build failures in CI.
Looks like alot around c++ build of header etc.
g++ -Ibuildtools/chkincs/chkincs-cpp-exp.p -Ibuildtools/chkincs -I../buildt=
ools/chkincs -I. -I.. -Iconfig -I../config -Ibuildtools/chkincs/staging -I.=
./buildtools/chkincs/staging -fdiagnostics-color=3Dalways -pipe -D_FILE_OFF=
SET_BITS=3D64 -Wall -Winvalid-pch -Wnon-virtual-dtor -Wextra -Werror -g -in=
clude rte_config.h -march=3Dcorei7 -mrtm -Wno-missing-field-initializers -W=
no-vla -DALLOW_EXPERIMENTAL_API -MD -MQ buildtools/chkincs/chkincs-cpp-exp.=
p/meson-generated_rte_ptp.cpp.o -MF buildtools/chkincs/chkincs-cpp-exp.p/me=
son-generated_rte_ptp.cpp.o.d -o buildtools/chkincs/chkincs-cpp-exp.p/meson=
-generated_rte_ptp.cpp.o -c buildtools/chkincs/chkincs-cpp-exp.p/rte_ptp.cpp
In file included from buildtools/chkincs/staging/rte_memory.h:18,
                 from buildtools/chkincs/staging/rte_ring_core.h:29,
                 from buildtools/chkincs/staging/rte_ring.h:38,
                 from buildtools/chkincs/staging/rte_mempool.h:49,
                 from buildtools/chkincs/staging/rte_mbuf.h:39,
                 from buildtools/chkincs/staging/rte_ether.h:20,
                 from /home/runner/work/dpdk/dpdk/lib/ptp/rte_ptp.h:32,
                 from buildtools/chkincs/chkincs-cpp-exp.p/rte_ptp.cpp:1:
buildtools/chkincs/staging/rte_bitops.h:1468:1: error: conflicting declarat=
ion of C function =E2=80=98bool rte_bit_test(const volatile uint32_t*, unsi=
gned int)=E2=80=99
 1468 | rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, arg1_=
type arg1_name) \
      | ^~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1475:9: note: in expansion of macro=
 =E2=80=98__RTE_BIT_OVERLOAD_V_2R=E2=80=99
 1475 |         __RTE_BIT_OVERLOAD_V_2R(family, v_, fun, qualifier volatile=
, size, ret_type, arg1_type, \
      |         ^~~~~~~~~~~~~~~~~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1479:9: note: in expansion of macro=
 =E2=80=98__RTE_BIT_OVERLOAD_SZ_2R=E2=80=99
 1479 |         __RTE_BIT_OVERLOAD_SZ_2R(family, fun, qualifier, 32, ret_ty=
pe, arg1_type, arg1_name) \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1575:1: note: in expansion of macro=
 =E2=80=98__RTE_BIT_OVERLOAD_2R=E2=80=99
 1575 | __RTE_BIT_OVERLOAD_2R(, test, const, bool, unsigned int, nr)
      | ^~~~~~~~~~~~~~~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1468:1: note: previous declaration =
=E2=80=98bool rte_bit_test(const uint32_t*, unsigned int)=E2=80=99
 1468 | rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, arg1_=
type arg1_name) \
      | ^~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1474:9: note: in expansion of macro=
 =E2=80=98__RTE_BIT_OVERLOAD_V_2R=E2=80=99
 1474 |         __RTE_BIT_OVERLOAD_V_2R(family,, fun, qualifier, size, ret_=
type, arg1_type, arg1_name) \
      |         ^~~~~~~~~~~~~~~~~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1479:9: note: in expansion of macro=
 =E2=80=98__RTE_BIT_OVERLOAD_SZ_2R=E2=80=99
 1479 |         __RTE_BIT_OVERLOAD_SZ_2R(family, fun, qualifier, 32, ret_ty=
pe, arg1_type, arg1_name) \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
buildtools/chkincs/staging/rte_bitops.h:1575:1: note: in expansion of macro=
 =E2=80=98__RTE_BIT_OVERLOAD_2R=E2=80=99
 1575 | __RTE_BIT_OVERLOAD_2R(, test, const, bool, unsigned int, nr)
