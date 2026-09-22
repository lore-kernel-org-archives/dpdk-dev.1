Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA8C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F56C410FD;
	Tue, 22 Sep 2026 20:14:12 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 4C43540609
 for <dev@dpdk.org>; Tue, 22 Sep 2026 20:14:11 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so115940a12.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790100850;
 x=1790705650; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BA+uX4d8xI008+862nblDXv5sMBJqODODZqA1od5oJY=;
 b=L3GH87CSc5NoOlchyHAdkpU9OYqa3FQ153VEyT6v6t6ppv8DdnCkboasFXUW1ReuTH
 S2owoM7857I/BijZOL9HNMamNcHLFkTl5laiEX2eEiSx2Q4gIyrBZWsX393z0aM2NaWC
 6PGT1a0kz7RDnTFwr+1HcRqVV335LH/s8Ko7rWK8NbK142cHq+heOIVn1/gdpLCwR+jJ
 I0G7kJIrrLJlYIRWeQspNRjc0jYnNhs1FDZhO2IBD0TlvgM0nvb/j1/hvDLspaq5UCiN
 Tq75SJBny/1pJ+i+ayiAmmKYQU7DiMmTArpe1+M28hFHtH91/7lc2nWwzp0iJ5s8bvfN
 Kocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790100850; x=1790705650;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BA+uX4d8xI008+862nblDXv5sMBJqODODZqA1od5oJY=;
 b=yCCjW2Mz4qY5IZdqldKrL1pz9cwQdMvBvVAcFl36lWQ9TectSEdm7KJClLf6BQEBWG
 0jthOKJYoc5AlUo4avYREuAZhySWFxFlQg1QxQ/ZVKxmnWiLXqUNCHJp9VOD+Uq0m+v/
 StkNUlyxzOsPbK0qQV2coou2q0LrJO2aT+7tmARXgJusJqkP1SKPywObrqjLnJuMf+GC
 t1xJrmvno1fL7V5oTESTgFiMbz2NV3q7J06EckdSWh8l+B58bBaajs/iyk7TPCozza0j
 T3bY1S4OAnThphRa4i9IPSIdUFINXQ9jzfZISLbQ6kv0jC9ki1tKRVHwrbUfS/8qv/aN
 HQTA==
X-Gm-Message-State: AFuF++lj6P8VTU5kbiW32aIw6ghZWhaRUxp5yOl5oI/5zPVRmCUdWDWV
 IMC5hsMrfF/EmSC1SR713kxiKNnGzV34AkE2YsLKgYQficH/YK41bayrMKf5Y/bSWJYxqFrxe1m
 lOqT/
X-Gm-Gg: AYBFou0FOK5IdNi3zrrSQQgtlnL+/PGuH9zms+U6h4SMcPKU80vxBd0YHn2fXM2YLQ7
 1CrMJdabekIfUNSuZqM3YtUVGIlASuWNEUW9eqcrbndgnBNKPUALPajrPt4Np/r+8/iF3o3uF1E
 gPhax28mN9OCKEgSjVahOE4TOukQwQ9J0x0DlNEdI+4Cyei0xDSudf5X1jcn1qaUeAWE3Yq5fyo
 3POdt5QDLDj6KBphPMVIvQFhBqu5zBJGVIsEXscWbtZUT2J5KTShyFhPMza2Shqeln2LL4h9FQh
 a6iDbGtgJ02VGgvLcsabJatD/7rV491mIfOUjFhjADX4OHkAb5cpVlY+Sjpk4QNH4aAsWMJfEl3
 Wz4h/T/IH96aqeyiDJfuJLx4i5RCSvuN9L0LoifLd9Mop/AbhrGg/cxk6olv3hMOSLAKcyCXNYQ
 42TojXLW7x/ZvyZYqezviTkGI5Rqk0lZ/XGxiCqR07m2foQd28aZ2AoapndT838wj4SwqxYwU5i
 rvWKps0t2p3d2OWtoEQvB+ZQgXy1UP3TMGbdbcd
X-Received: by 2002:a17:902:ce08:b0:2dd:ad73:c982 with SMTP id
 d9443c01a7336-2df69d583b9mr1993405ad.26.1790100850133; 
 Tue, 22 Sep 2026 11:14:10 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a516410sm27415ad.12.2026.09.22.11.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 11:14:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:14:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org, Maxime Leroy <maxime@leroys.fr>
Subject: Re: [PATCH] net: revert add IPv6 traffic class and flow label fields
Message-ID: <20260922111408.3b2c7bcf@phoenix.local>
In-Reply-To: <20260922163640.1144749-1-mb@smartsharesystems.com>
References: <20260922163640.1144749-1-mb@smartsharesystems.com>
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

On Tue, 22 Sep 2026 16:36:40 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> IPv6 header when the field crosses a byte border.
>=20
> Let's consider a simplified struct for illustration:
>=20
> struct example {
> 	union {
> 		rte_be32_t vtc_flow;
> 		struct {
> 			uint32_t version:4;
> 			uint32_t ds:6;
> 			uint32_t after:22;
> 			uint32_t after:22;
> 			uint32_t ds:6;
> 			uint32_t version:4;
> 		};
> 	};
> };
>=20
> struct example e;
> e.vtc_flow =3D 0x00000000;
> e.ds =3D 0x3F; // binary: 111111
>=20
> With big endian:
> Value of e: 0000 111111 0000000000000000000000 =3D 0F C0 00 00
> Memory at e's location: 0F C0 00 00
> As expected!
>=20
> With little endian:
> Memory at e's location: 00 00 C0 0F
> The reason being that the bytes are filled with bits starting with the
> LSB, so when crossing a byte border, the "ds" field doesn't continue at
> the following bits, i.e. the MSB of the next byte, but at the four LSB
> of the next byte.
>=20
> This wrapping cannot even be fixed by having separate, dedicated structs
> for each field (with each their own "before" and "after" filler fields)
> in the vtc_flow union.
>=20
> There is a GCC attribute to fix this, but nothing similar is offered by
> Clang or MSVC:
> __attribute__((scalar_storage_order("big-endian")))
>=20
> Bugzilla ID: 1679
> Fixes: cba27998dc81 ("net: add IPv6 traffic class and flow label fields")
> Cc: stable@dpdk.org
>=20
> Reported-by: Maxime Leroy <maxime@leroys.fr>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

Long form AI review. This may need addressing before merge.

The revert is correct and complete. cba27998dc81 only touched
rte_ip6.h, there are no in-tree users of the removed fields, and the
struct layout is unchanged so there is no ABI impact.

Keeping Cc: stable is right. The fields shipped in 24.11 and 25.11
but access the wrong bits on every little endian target, so any
direct user is already broken and a build failure is the better
outcome. Please add a note for the stable release notes pointing to
vtc_flow and the RTE_IPV6_HDR_*_MASK macros. Code that byte swaps
vtc_flow in place before using the fields does work on little endian
today and will stop compiling.

The commit message needs rework before this goes in.

The example struct does not compile: after, ds and version are each
declared twice with no #if between the two orderings. Since it is
the justification for the revert, either fix it or drop it and show
the actual result.

The root cause is understated. It is not only ds crossing a byte
boundary; every field is wrong on little endian, including version.
A uint32_t bitfield is allocated against the host order value of
the word, while vtc_flow holds network order. The little endian
layout is only correct after byte swapping vtc_flow.

On x86_64 with the removed layout:

  header bytes 6b 91 23 45 (ver 6, DSCP EF, ECT(1), fl 0x12345)
    -> version=3D4 ds=3D0x14 ecn=3D2 flow_label=3D0x3916b
  version =3D 6  -> bytes 00 00 00 60
  ds =3D 0x3f    -> bytes 00 00 c0 0f

Suggested wording:

  On little endian, a 32-bit bitfield is allocated from the least
  significant bit of the host order word, but vtc_flow is stored in
  network order. All four fields therefore read and write the wrong
  bits. For example, setting version to 6 writes 0x60 into the last
  byte of the word.

  ds and flow_label are not contiguous in memory on little endian,
  so no reordering of bitfields can express them.

For reference, neither Linux nor FreeBSD tries this. Linux uses a u8
bitfield only for version and the upper nibble of traffic class,
then flow_lbl[3], with big endian masks (IPV6_FLOWINFO_MASK,
IPV6_FLOWLABEL_MASK) for the rest. FreeBSD has no bitfields: a raw
ip6_flow word, the ip6_vfc byte for version, and per byte order
masks. DPDK already has the equivalent in rte_ipv6_check_version()
and RTE_IPV6_HDR_*_MASK, so nothing is lost.

Release note: "defect bitfields" reads oddly and gives no migration
path. Suggest:

  * net: Removed ``version``, ``ds``, ``ecn`` and ``flow_label``
    bitfields from ``struct rte_ipv6_hdr``. They accessed the wrong
    bits on little endian. Use ``vtc_flow`` with the
    ``RTE_IPV6_HDR_*_MASK`` and ``RTE_IPV6_HDR_*_SHIFT`` macros.

Minor: "Reverted the patch introducing them." should be imperative,
"Revert the patch that introduced them."
