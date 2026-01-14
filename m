Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD3BD3900B
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 19:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D476F40DF6;
	Wed, 14 Jan 2026 20:33:37 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 6BE5240DCA
 for <dev@dpdk.org>; Wed, 14 Jan 2026 20:33:36 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so1258915e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768419216;
 x=1769024016; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULgLWmk2Gjd7O0gx2DYOV8iLvcXyq+/jT5CQ9nmzLDA=;
 b=H4kfq+19j6aj6iVGBWai5NFYtYo5FRbZoUzM+bTWBSlZn09qxmhj975sQgQmE7BNfH
 Rfgk3HE6WjitOIhG/22cbHEEAfTaFOMHIMlZBW3maG8/Xz0ThY+KtqlVYEYC+btYPEtX
 cT7xOJ4DLC7JH8mJ2LOxleNVU8e7ZhZT2zrONCWaUW1gQmmpzMwRCZih0ibzgQevox+J
 UIoKFPYykvL3xEljl1J/4/yVoW/qd1UOmYhB57N5kUz0so+Lm3PCCSZcpHK34hoHpvFQ
 yTa5JrJYxg0PT06oAtQnn5XrI2Y9yl8+fiiTYZWB7MI4NoJX4ZJb7HA473gUq0+eiTbE
 Lnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768419216; x=1769024016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ULgLWmk2Gjd7O0gx2DYOV8iLvcXyq+/jT5CQ9nmzLDA=;
 b=GrdEXmkrVVw+1ZeDyiDlkFOHPhVXUHLiCa5ggnKowEq/T/WG26fX+u04KJzDWlO+ua
 +VUHzkp71gljJRY1PBL23oxGagoA4NWWLf0wXUNopvV3E6lGbI+hpbFoXdSHDeKsm1Gt
 fO9jz/Ht2c4806JNfOQnmL6VA02Qa6raHVvCcbHLy7zyc+Ej4spuW3kSltiJticPbYJr
 AiZYkz9Hiki5YxwXA7yRSz5/Rh8uVpSFZVAnmeHdVmPaLt1YixXvG/RFb0WZs82BHUm9
 mNGkRp5nY0f2NRZ2afj9YTkVGCOzXlxHfxMWygc7lCTqsNaWEw+Tsp0TyNpPKGN+aKji
 j/dQ==
X-Gm-Message-State: AOJu0YxL1BZ82PDjlxElThMokP7/CWgpdkWc5/KbFvh4XabH+v9WjC5l
 vXrw3G/z41HVFP5BQtJgS7LxtpihpcrKN5qzTXCwkfBeMm8ClR4f0IncFbEA6Vc7/F4=
X-Gm-Gg: AY/fxX4bd4y4pzLDmsdO7E/5M7wkBeX3fv2Ig2aMyHmSJfYtQSyOhK6cqlB8cvAIa7h
 ikPeTSN9kSEsFWmRW8oLZ+xQexDHnILUQEjMBAlCtK/RzRiws3ywjX1QwZcouRkcx74he7qi7jD
 yvmGkNtT6Ecpq3er0WkF6n9fe03nD5sNpnGNz8/jWiQDTf+CncGP8U37v60jPUgodtueNqhg2M+
 7zxK0qjMgJpkNM/mUtM9Ok5dZxjkWZQuuRPF1BM2pwsqPWJ2AocQI/l+RXSekf0aPKMJk0hW8Kw
 CWae2vCYIW8/BDGXsahVr9btAQck+gPeEtu0azq2CD+2l3BafOgZciH7tylq9m0e9jnynU4Fp7N
 l8BHZItWCst14yWv7fFOv48PSWobwVEGwweITiqPHmDnK6KjduYFTHGGFC/DStUpKXBzp2gbpjd
 KDJAYm/3Cth9m2FuR1CViZCgH2C6QiZTM5jkO4aLYxt/8Xh+E2KV7N
X-Received: by 2002:a05:600c:154a:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-47f8c057a33mr2681185e9.28.1768419215891; 
 Wed, 14 Jan 2026 11:33:35 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653560sm1164222f8f.10.2026.01.14.11.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:33:35 -0800 (PST)
Date: Wed, 14 Jan 2026 11:33:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>, Didier Pallard <didier.pallard@6wind.com>
Subject: Re: [PATCH] net: fix parsing of frames with arbitrary VLAN stacks
Message-ID: <20260114113327.3618b433@phoenix.local>
In-Reply-To: <20251103154128.297748-1-getelson@nvidia.com>
References: <20251103154128.297748-1-getelson@nvidia.com>
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

On Mon, 3 Nov 2025 17:41:27 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> The rte_net_get_ptype() supported only 2 types of VLAN headers frames
> that are defined in the IEEE standards 802.1Q and 802.1ad:
>=20
> frames with a single 0x8100 VLAN header:
>   eth type VLAN / vlan / [IPv4 | IPv6 ]
>=20
> frames with 0x88A8 QinQ header followed by 0x8100 VLAN:
>  eth type QinQ / vlan type VLAN / vlan / [IPv4 | IPv6 ]
>=20
> The function did not parse frames where VLAN headers were stacked in
> different configurations.
> Such frames should also be allowed to provide HW vendor flexibility.
> As a result, ptype bitmask and header length returned from
> rte_net_get_ptype() for a custom VLAN frame were wrong.
>=20
> For example, the parser result for the frame
>   eth type QinQ / vlan type QinQ / vlan type VLAN / vlan / ipv4
> was:
> pkt_type:=3D0x120007
>    RTE_PTYPE_L2_ETHER_QINQ         0x00000007 OK
>    RTE_PTYPE_INNER_L2_ETHER_VLAN   0x00020000 wrong
>    RTE_PTYPE_INNER_L3_IPV4         0x00100000 wrong
>=20
> hdr_lens:=3D{
>   l2_len       =3D 22 wrong
>   inner_l2_len =3D  4 wrong
>   l3_len       =3D  0 wrong
>   inner_l3_len =3D 20 wrong
> }
>=20
> The patch changes:
> 1. Allow frames with an arbitrary number of VLAN headers.
>=20
> 2. Set each parsed VLAN type in the returned ptype bitmask.
>    Multiple VLAN headers are referenced by a single
>    RTE_PTYPE_L2_ETHER_VLAN bit.
>    Multiple QinQ headers are references by a single
>    RTE_PTYPE_L2_ETHER_QINQ bit.
>=20
> 3. Preserve RTE_PTYPE_L2_ETHER bit if VLAN or QinQ type was detected.
>=20
> Fixes: eb173c8def0a ("net: support VLAN in software packet type parser")
> Fixes: 218a163efd67 ("net: support QinQ in software packet type parser")
>=20
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

This patch seems to have been unreviewed for some time so forwarded
to AI for review. Agree in general but my take is that a stacking
depth limit should be enforced; too many network products have had
CVE's for malformed nasty packets.

Please address review comments and resubmit

# DPDK Patch Review: net: fix parsing of frames with arbitrary VLAN stacks

**Patch:** net-fix-parsing-of-frames-with-arbitrary-VLAN-stacks.patch =20
**Author:** Gregory Etelson <getelson@nvidia.com> =20
**Patchwork ID:** 158350 =20
**Reviewer:** Stephen Hemminger =20
**Date:** January 14, 2026

---

## Summary

This patch fixes `rte_net_get_ptype()` to handle arbitrary VLAN header stac=
ks instead of only the two standard configurations (single VLAN, QinQ+VLAN)=
. The fix is correct and well-motivated.

---

## Commit Message Checklist

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 50 characters |
| Lowercase after colon | =E2=9C=93 | |
| Correct prefix | =E2=9C=93 | `net:` correct for `lib/net/` |
| Imperative mood | =E2=9C=93 | "fix parsing" |
| No trailing period | =E2=9C=93 | |
| Body =E2=89=A475 chars | =E2=9C=93 | Lines within limit |
| Body doesn't start with "It" | =E2=9C=93 | Starts with "The" |
| Fixes: tags | =E2=9C=93 | Two fixes with 12-char SHA |
| Cc: stable@dpdk.org | =E2=9C=93 | Present |
| Signed-off-by | =E2=9C=93 | Real name and email |
| Tag order | =E2=9C=93 | Fixes =E2=86=92 Cc =E2=86=92 Signed-off-by |

**Commit message is well-written** =E2=80=94 good problem description with =
concrete examples showing incorrect vs expected behavior.

---

## Code Review

### Correctness: =E2=9C=93 Good

The refactoring is sound:

- Replaces fragile if/else with a `while` loop that iterates through any VL=
AN/QinQ stack
- Uses `|=3D` instead of `=3D` to accumulate ptype bits, preserving `RTE_PT=
YPE_L2_ETHER`
- Each header is read and validated individually via `rte_pktmbuf_read()`
- Loop terminates safely when packet data exhausted (NULL return) or non-VL=
AN ethertype encountered

### Old Behavior Flaw

The QinQ branch assumed exactly one inner VLAN and skipped 2 headers at onc=
e, reading only the second. This failed for stacks like QinQ/QinQ/VLAN.

### New Behavior

Processes each VLAN/QinQ header individually regardless of nesting depth.

---

## Suggestions

### Warning (should consider)

1. **Unbounded loop concern** =E2=80=94 While the NULL check provides safet=
y against buffer overrun, a malicious or malformed packet with many consecu=
tive VLAN tags could cause CPU spin. Consider adding a reasonable iteration=
 limit:

```c
#define RTE_NET_VLAN_MAX_DEPTH 8  /* or similar reasonable bound */
unsigned int vlan_depth =3D 0;

while ((proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
        proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) &&
       vlan_depth++ < RTE_NET_VLAN_MAX_DEPTH) {
```

This is probably overkill for typical use but would make the parser more de=
fensive.

### Info (minor style)

2. **Ternary formatting** =E2=80=94 The nested ternary inside the `|=3D` is=
 a bit dense. Consider:

```c
if (proto =3D=3D rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
    pkt_type |=3D RTE_PTYPE_L2_ETHER_VLAN;
else
    pkt_type |=3D RTE_PTYPE_L2_ETHER_QINQ;
```

This is clearer and costs nothing. The ternary version works fine though.

---

## Verdict

**Reviewed-by worthy** =E2=80=94 The patch correctly fixes a real parsing l=
imitation. The code change is minimal, correct, and well-explained.

The only substantive suggestion is considering a loop depth limit for defen=
sive programming, but this is optional given the existing NULL-check safety=
. The patch is good as-is.

---

## Suggested Reply

```
On Mon, 3 Nov 2025 17:41:27 +0200, Gregory Etelson wrote:
> The rte_net_get_ptype() supported only 2 types of VLAN headers frames
> that are defined in the IEEE standards 802.1Q and 802.1ad:

The fix looks correct. One minor suggestion: consider adding a loop
depth limit (e.g., 8) as a defensive measure against malformed packets
with excessive VLAN tags, though the existing NULL check does provide
buffer safety.

```

