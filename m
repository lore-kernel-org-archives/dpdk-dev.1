Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A0C531D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 14:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6443640679;
	Thu, 23 Jul 2026 16:50:50 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8B9E240663
 for <dev@dpdk.org>; Thu, 23 Jul 2026 16:50:49 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-81eb41c1f1aso6297277b3.2
 for <dev@dpdk.org>; Thu, 23 Jul 2026 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784818249;
 x=1785423049; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hJcy+APx9bY1TJ3dwU5x1Pr88/q1vfcNB+/aPV2XDZA=;
 b=v9F7FquViezYn0Pff1NGcRTBN8l3IXI7iscE6nlw1Yr+QKYCGEdQ1vYR3wNlh8iZRu
 ep1K0x1kDhhU5vCiiTcQkZdScjH9xQDi6CjcXB8zSz8dFYrHq0Ny4Cu+RVpWmxT/WgT5
 vY3KL6levhyV/Lmvn4j/Ps48uvaiymfJ5NK8JTOvVNMvC8wLIihsn4iHRm3UmqJXSTOM
 zaaUyU7AG2jaX9jpjIKhXI4CsNDzH/avn6HENjQbsnJkdia2pq7Kd5dsBQ0uafd1oR+P
 EJvcD3dDUawsRLzmj0AmtyH/XmRlhVFdcz+R1i36ZAZP5xwMwo0+t+QV9J4iFf9RXb9X
 DH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818249; x=1785423049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hJcy+APx9bY1TJ3dwU5x1Pr88/q1vfcNB+/aPV2XDZA=;
 b=Nj3U9ilwPGcuRbRWzqEfA/y5K4n0ga29AyAJQ5HTsZeojBEyUyhbqh2u96fjln/Pup
 2EtTBxa1LmFXitM+42qUFTXRtg7wwfMAaRnOKjmDQpQEGTabFFdyLAMC8LG8SlDY6JWe
 PCMtNs3pWrbUnxl4DHxxuvx7FFLRF+bmftbbSmxzc+OoLcXMIjH9uFa+lkwNhOdw+mMN
 2CXnVdl4COKUp21OHgs/VA2QmVFwkWpAYwI136BBI27alYdqjTj9ueK5AQiPFygtBCSX
 mfYsLiG3bPD2WvGv8K2VRAxYbr0nq8VB0L3cNGIH7x7Nw1k1wNAkS8zK75RuCTLN/8l8
 jR/g==
X-Gm-Message-State: AOJu0Yy4sWJo+KS5sweXqdAwQFt+jq6DfGkI4I5RKm7kYIjoRYSIsNph
 AMXm80fwViQ6hmVYJtYtxCUiK9WLN9NxPbtdUJPeBZMOZn79XpXuLV7Ly7l0zbrA3Ak=
X-Gm-Gg: AR+sD10PGfb1W7J851HFek57yZWVTMjMkt5Ix9RmSmebltlSF89k2m1SHpbMF4LXS96
 yWF8XXTcNGDuNZ0WuD6a4P8hQ4gIlZvxI1dmwQ4g/MSRdbI01zdP3tgpSKiJ+eZbtHcyFck/75g
 sNmbLfaczIiDhYCBpH+s9fJlytW9HCgLsNES4uOzfBGbX50Pil0ULiRj4hMYdjiqEK0qzRuFh7l
 AZPlZigxVzYHcrEfv7MiCsxfY1/3sLDSGnustY8jUZ4XT7XTGw9LGv++lKWr/ebS0ZNdI4pd/5n
 RFu2Ugp7eJr6x6AqvCPTsMA3EgvgwSSoOudr90WdBAhHprv2gQ77UTB2nTJnjhXA2rMcFrRO0Kt
 JXP704ZOs1UbmFc8A2QGV39VVj+YejLiu6Unav5zZwv8JZXxRnLWNMAiGP8O44yD/RENva2fv2K
 me/UI8Yfv71o3nJPA0xHgAjuqrowjpKQInczBIo7Rk044=
X-Received: by 2002:a05:690c:260c:b0:7fe:4069:d3fe with SMTP id
 00721157ae682-81f4c1b2e6fmr10563087b3.30.1784818248722; 
 Thu, 23 Jul 2026 07:50:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33bf45bdsm29417967b3.2.2026.07.23.07.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:50:48 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:50:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org, aman.deep.singh@intel.com, bruce.richardson@intel.com
Subject: Re: [RFC PATCH v3] ethdev: update read time API in PMD to enable
 crosstimestamp
Message-ID: <20260723075044.5dbb6ab6@phoenix.local>
In-Reply-To: <20251230085719.119058-1-soumyadeep.hore@intel.com>
References: <20251224073317.68784-1-soumyadeep.hore@intel.com>
 <20251230085719.119058-1-soumyadeep.hore@intel.com>
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

On Tue, 30 Dec 2025 08:57:19 +0000
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> - flags indicates cross timestamp is enabled or not
>=20
> For backward compatibility:
> - Existing rte_eth_read_clock() remains unchanged
> - Drivers may implement either or both APIs
>=20
> Capability Discovery
> -------------------
> Will  be enabled via traditional way of enabling PTP
>=20
> Driver Implementation
> ---------------------
> Drivers implementing timesync_read_time() API may:
> - Use hardware-assisted cross timestamping if available
> - Fall back to serialized software reads of PHC and system clock
>=20
> Drivers that do not support cross timestamping may:
> - Fill only device_time_ns
> - Return 0 to indicate a successful PHC read
>=20
> ABI / API Impact
> ----------------
> This change introduces:
> - A new flag
> - A change in existing API
> - A new device capability flag
>=20
> No existing APIs or structures are modified, preserving ABI
> compatibility.
>=20
> Alternatives Considered
> ----------------------
> A separate cross timestamp API was considered but rejected to avoid
> duplication and to keep PTP clock access consolidated under read_time.
>=20
> Another option was to extend rte_eth_read_clock() directly, but this
> would break ABI and existing applications.
>=20
> Performance and Risks
> ---------------------
> The extended read_time API is expected to be called infrequently and
> does not affect the packet data path.
>=20
> Accuracy depends on hardware support. Software-based cross timestamping
> may introduce jitter, which should be documented by drivers.
>=20
> Future Work
> -----------
> - Exposing estimated error bounds in flags or an extended structure
> - Alignment with Linux PHC cross timestamp semantics
> - Support for multiple system clock domains (TAI, REALTIME)
>=20
> Feedback Requested
> ------------------
> Feedback is requested on:
> - Whether extending read_time is preferred over a standalone API
> - Structure and flag naming
> - Expected semantics when system_time is unavailable

Having this as compile time choice is the wrong architecture.
Let me summarize my thoughts (with AI verbosity)...

The core problem is using RTE_LIBRTE_CROSSTIMESTAMP as a compile-time
switch for the behavior of an exported function. DPDK often ships as a
prebuilt shared library. A build flag can't change the meaning of an
exported symbol: with the flag set, rte_eth_timesync_read_time(port,
timestamp) treats timestamp as a two-element array; without it, one
element. Same prototype, two incompatible contracts, chosen at library
build time. An app built against one config and linked against another
overflows or reads garbage. So "no structures modified, ABI preserved"
isn't accurate =E2=80=94 the pointer's contract is silently redefined, whic=
h is
worse than an honest bump.

My preference for new API, in order:

    Do the right thing by default: a dedicated cross-timestamp call returns=
 the pair inherently =E2=80=94 no flag needed.
    Else make it a runtime option, never #ifdef =E2=80=94 one binary must s=
erve both callers.
    Else add a new, typed API =E2=80=94 don't overload struct timespec * to=
 mean timespec[2].

Concretely I'd drop the #ifdef and the bool, and add
rte_eth_timesync_read_cross_timestamp() returning a struct
(device_time, system_time, room for clock id / error bound), gated by a
capability bit in dev_info =E2=80=94 matching the Linux PTP_SYS_OFFSET_PREC=
ISE
model. That leaves timesync_read_time and its implementers alone.

Blocking issues as it stands:

* Build break: the typedef gains a third arg but only ice is updated.
  The other 13 implementers (txgbe, axgbe, dpaa, bnxt, i40e, idpf, igc,
  igb, ixgbe, ngbe, cnxk, hns3, dpaa2) keep the 2-arg signature =E2=80=94
  incompatible-pointer-type, which is -Werror in CI.

* Uninitialized read: ice doesn't support cross timestamping
  (it just warns and fills one timespec), yet the example reads sys_time =
=3D crosstimestamp[1],
  which is never written. The one path this enables produces a garbage delt=
a.

* Silent failure: a driver that can't do it still returns 0,
  so the caller can't tell the second timestamp wasn't filled.
  Should be -ENOTSUP or gated on an advertised capability.

Minor: the new build flag isn't wired into meson, so the path is dead code =
as submitted;=20
no capability flag is added despite the cover letter; and the typedef doc c=
omment isn't updated.





