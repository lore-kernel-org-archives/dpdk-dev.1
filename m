Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F87D277F3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 16:59:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D19414028E;
	Sat, 10 Jan 2026 17:59:38 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 9C7F140144
 for <dev@dpdk.org>; Sat, 10 Jan 2026 17:59:36 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so2011150f8f.3
 for <dev@dpdk.org>; Sat, 10 Jan 2026 08:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768064376;
 x=1768669176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmdYpN2KupftkK1SANx1dTTR1SYgv8I1Xs537VUqaeI=;
 b=UuRzZdYtSTljgi6Hsr5y8yw8S6fYHKZLIiM1BOOzlrcuurV8xkoPiVzu+EZ5xT72Da
 h/XCNirU1iVxv+M6921tJhAIgAspslI0hxpTrdJV3rd6SQKi/AL2TN5+64rCyjYhVFCh
 oHPuyWCt+Qcwh7tOKMp91U4oZjbiJxKHlYWNtdHlRRURvvkiofv5cmT7Z0gx+r7eMD9f
 9kYuMtdcmFs9HvbwMYSd11kA4GO0q3SeLquccdkSPI59NOPUnbG8ELLcPj2lH8iz20F1
 +EUgXDZKR6JK9A5K4GA0fQ9kRb8yHhYxzB0Y2VqXcug4piXYYUiG3A9a9UDxDGL5flXn
 Vg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768064376; x=1768669176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmdYpN2KupftkK1SANx1dTTR1SYgv8I1Xs537VUqaeI=;
 b=nbdOvI5M3SvhS+An129ArvJRHKc8OV5m3+9wFWi8fo1oFTxIWapRGmTNhXScICotQd
 w24vSHElNqeJ9k2i3tfz+OCouvqI/XrcK6Aws6k9uOMNFOuWyWoOEvG4T2MqPjT2vSKa
 bjPc5V61tYO+It2FuI/XkI6goGX/6iesB//SVMpsa/WyIZoInd4L30/1coao7BBLAqN1
 m0kiDenmuC7nYXml88BmvDe8k0dbCA0eLoOLwmRqZaoLNrUXO7U087i2dBtWyaUdkRH9
 OoLB1yIYKDPS1Zr1N6K3G3kRClOHJpIXTzsofd/hhP9JQqnlaz5dRE14PKVrUr8hNSlw
 /B3g==
X-Gm-Message-State: AOJu0YwHAC8XiopLJ90sMz/pnrtWJWNz/A5Jw9li89d5xiPFDFn3iZIK
 weegx/Xy1n5wq6T7SoYlqmMr0SNKTvGIKjbrMPDovTqo4w1NH79QuH4h0b0sfkgAcYU=
X-Gm-Gg: AY/fxX6ISs64qxFiOnON7PfoF1yv1w3ujZ308dX/mYKzleljvz8UgtpoS4LzlpwMb9v
 IGJIaZ5VEcAcfxoMKsCl8aOsREn2wX+BV0FzS45TZ2uk7cZcFiVwMLkQo8bWoPzqQR5HvD1AIrR
 ajzP1dyjAhiZbwEI8UEu4fvzpSpanF2E08MudRp4oeqt9fwmjuunCYjccHTvfhajwbVL1V42XyW
 xqqLxTdOP/IknrdVY8Nbo88jnuTrolY1MJvqAbQDGzw2rCgFYsO7mCWiLKyPKUNyolpEWToK8Vc
 1ZVrda6yGNXC7pjHzf6bRVKtOW3kTO68l6KeaQU+FwSXIAsvtzvzhhpsTalWiQOxv39mXXlu1j8
 XWECw/f3FwQUMt+aHTKxo52betXCjf4saJq4O8UZvesJ15yIEhqY+BAJCspOymEtCtE0mEChT/v
 OcufM4yE+zrj0yHx+DSoFAPVmtmjrIJUjDE0HL6S7tacNqCSjoPIyFg78ZgcvMqbQ=
X-Google-Smtp-Source: AGHT+IFY1L7NNURDPeZ+TNVY4tdSt5esEqM2XPmBalass5RfE/VcmsgYzyQcg4kd5YXADf0UTIj/xg==
X-Received: by 2002:a05:6000:1449:b0:430:feb3:f5ae with SMTP id
 ffacd0b85a97d-432c37a721dmr13261011f8f.55.1768064375091; 
 Sat, 10 Jan 2026 08:59:35 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dd78f5a8sm8607691f8f.27.2026.01.10.08.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 08:59:34 -0800 (PST)
Date: Sat, 10 Jan 2026 08:59:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v12 0/3] net: optimize raw checksum computation
Message-ID: <20260110085929.712a0a87@phoenix.local>
In-Reply-To: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
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

On Fri,  9 Jan 2026 20:56:48 -0500
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> This series optimizes __rte_raw_cksum() by replacing memcpy-based access
> with unaligned_uint16_t pointer access, enabling vectorization in both
> GCC and Clang. The series is split into three patches to clearly separate
> the core optimization from compiler-specific workarounds.
>=20
> Performance improvement from cksum_perf_autotest on Intel Xeon
> (Cascade Lake, AVX-512) with Clang 18.1 (TSC cycles/byte):
>=20
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>=20
> Changes in v12:
> - Split into 3-patch series per reviewer feedback
> - Patch 1/3: Core optimization and test additions
> - Patch 2/3: UBSAN alignment workaround (separate from GCC bug)
> - Patch 3/3: GCC optimization bug workaround
> - Reverted len & 1 to len % 2 and restored unlikely() per feedback
> - Renamed RTE_SUPPRESS_UNINITIALIZED_WARNING to RTE_FORCE_INIT_BARRIER
> - Applied minimal changes (no refactoring) to existing code
> - Deferred hinic driver refactoring to future series
>=20
> Note: Patch 1/3 will trigger compiler warnings/failures on GCC versions
> with the optimization bug (GCC 11.5.0 and others seen on DPDK CI). These
> are resolved by patches 2/3 and 3/3.
>=20
> Scott Mitchell (3):
>   net: optimize __rte_raw_cksum and add tests
>   eal: add workaround for UBSAN alignment false positive
>   eal/net: add workaround for GCC optimization bug
>=20
>  app/test/meson.build             |   1 +
>  app/test/test_cksum_fuzz.c       | 240 +++++++++++++++++++++++++++++++
>  app/test/test_cksum_perf.c       |   2 +-
>  drivers/net/hinic/hinic_pmd_tx.c |   2 +
>  drivers/net/mlx5/mlx5_flow_dv.c  |   2 +
>  lib/eal/include/rte_common.h     |  23 +++
>  lib/net/rte_cksum.h              |  15 +-
>  lib/net/rte_ip4.h                |   1 +
>  lib/net/rte_ip6.h                |   1 +
>  9 files changed, 277 insertions(+), 10 deletions(-)
>  create mode 100644 app/test/test_cksum_fuzz.c
>=20
> --
> 2.39.5 (Apple Git-154)
>=20

Do not like to see so much compiler hacking, and not sure if it is worth
having to do so much special case code for a few cycles.

Feeling lazy, asked AI to compare the FreeBSD and Linux checksum and its
answer was enlightening.

The optimium solution would in my opinion would be:
   - specific IP and IPv6 only routines using assembly on a platform basis.
     Add with carry will be faster than all this compiler flags.
   - non-inline function for the general case with data.

This should eliminate the need for compiler flags.


Compare the algorithm used to compute standard IP checksum in FreeBSD and L=
inux

Great question! Both implement the same RFC 1071 one's complement checksum,=
 but their optimization strategies differ in interesting ways.

## Core Algorithm

Both compute a 16-bit one's complement sum: accumulate 16-bit words, fold c=
arries back in, and complement the result. The differences are in the imple=
mentation details.

## Linux Approach

Linux uses a layered architecture with generic C fallbacks and arch-specifi=
c optimizations:

**Generic path** (`lib/checksum.c`, `include/net/checksum.h`):
- `do_csum()` uses a 64-bit accumulator, processing 32 bytes per loop itera=
tion (heavily unrolled)
- Defers folding until the end to minimize carry handling
- `csum_fold()` does the final 32=E2=86=9216 bit fold with a clever trick:
  ```c
  sum =3D (sum & 0xffff) + (sum >> 16);
  sum =3D (sum & 0xffff) + (sum >> 16);
  return ~sum;
  ```

**IP header fast path** (`ip_fast_csum()`):
- Specialized for the common 20-byte header case
- On x86-64, uses ADC (add-with-carry) chains to exploit hardware carry pro=
pagation
- ARM64 uses similar ADCS instruction chains

## FreeBSD Approach

FreeBSD's `in_cksum()` (`sys/netinet/in_cksum.c`) takes a different approac=
h:

**mbuf-oriented design**:
- Walks mbuf chains directly, handling the common case of headers split acr=
oss mbufs
- Tracks byte-swapping state when data crosses 16-bit boundaries between mb=
ufs

**Accumulation strategy**:
- Uses `int` (32-bit) accumulator in the generic version
- Processes in 16-byte chunks with explicit unrolling
- Folds more frequently (after each mbuf) rather than deferring everything

**Architecture-specific versions**:
- x86 versions historically used inline assembly with ADC chains
- More recent versions lean on compiler intrinsics

## Key Differences

| Aspect | Linux | FreeBSD |
|--------|-------|---------|
| Accumulator | 64-bit, fold once at end | 32-bit, fold per mbuf |
| Loop unroll | 32 bytes/iteration | 16 bytes/iteration |
| Data structure | Works on flat buffers via `skb_checksum()` | Direct mbuf=
 chain walking |
| Alignment | Handles via initial byte adjustment | Similar, but tracks "od=
d byte" state across mbufs |
| IP header | Dedicated `ip_fast_csum()` | Often uses general `in_cksum()` |

## Performance Implications

Linux's approach tends to be faster for large contiguous buffers due to lar=
ger unrolling and deferred folding. FreeBSD's mbuf-aware design is arguably=
 cleaner for scattered data but may do more fold operations.

On modern CPUs with good branch prediction and out-of-order execution, the =
differences are often marginal=E2=80=94the ADC chain optimizations matter m=
ore than the high-level strategy. Both have moved toward letting the compil=
er handle more optimization rather than hand-tuned assembly, though Linux s=
till maintains more arch-specific variants.

Given your DPDK work, you've probably noticed DPDK's `rte_raw_cksum()` take=
s yet another approach=E2=80=94often vectorized with SIMD when available, w=
hich can significantly outperform both kernel implementations for large pay=
loads.
