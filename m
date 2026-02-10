Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684EE94626
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58DD2402DC;
	Tue, 10 Feb 2026 01:33:24 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 05ABC400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:33:22 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so37637595e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770683602;
 x=1771288402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKh42sq/MJpgu3TgNX4J3gHJJum/YoYqW6PFcf7yfN4=;
 b=GVWzZY89K3G8t9WPzp6EaNuA4FIU8cr03jwoTcflsgpF1G/dji39rWZphBq9lDPWjT
 KQfyCEPd2GzEbD/8lKQ6I0qVwjYHVVeHBwq9Ggpz9/dcq2h9LOizkcrLrvjEiJyAKxdP
 +3IIamX0+pfBMkzEhnRYKXuniWoKbx/6vSJN/mfpcEXxNgfq6nceS676uuAeWs7rbHp+
 7LjdVkNJKow8rv33M4JkHkyZ59R9BBoouKZFjHfANfTCn6ecOO1y8uUW83PlzM2HhzG8
 2MxOa3s+CAkpQ37iAyQoKZxtrukTAF35se4s3vnMwdYRmlaoskSUrelVwxuRJHIJemUr
 essw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770683602; x=1771288402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sKh42sq/MJpgu3TgNX4J3gHJJum/YoYqW6PFcf7yfN4=;
 b=MEo0p7cXhrbFG7jqUkl7H0P3ZsJGJCvEOeRevih4d+kivmsiMKlEjEf2kW+gg5cha6
 g7atLD2Av7z4RX/lwoTcKWQ6tGEyKF4EQDpMqP6CjMuI8TFW1HwHu+UK8LafZUqxgfMX
 /gXPpyR1oGonU13GWJwAm1tjwz1vcKNRoO+Cr82ws4v1w1VHhtYExIut28hPbFKr8XTu
 mmcXMZKZ6J7ExX4wK3cCv8AP4VOhe3WbPC3ZGEq6J4k0pcXFyAa0OSkbuz091q48sx7M
 VhncmT6vrl4i9OnEdu8WXlxprAa2tv9D8vLQmwhVTDfiCb+f+ByZgotzvMkQrDVXyFeb
 F6Pg==
X-Gm-Message-State: AOJu0YykqOrvATA9bipSKREydrQMRvNghem84BSuZqoF2GRsZT7ihNF0
 LjyXE+WCauQ1esAbYvHmYNIJjpDOTymGe1fZ2Y9e6sjH1NlrsCqXLB+w0AlW143Z2xY=
X-Gm-Gg: AZuq6aJ6+NEVV3n69aiBzaTkXodiaZre60kU8Mz4Nq+75C1zWxX2EhFy9DB9xD7mBob
 57VGfpI00MkP8YNA5kcr1HVzMKJEaqf3sXDug0d7T0JLYYpfoZcgmJSI8KK7t+qdXafGrOu534h
 BOzDf4nmeNoadFRQRhBLtvp+IYxElZ4t3hXavrDshKHEXbCzxdB/T1eZZ0IvnTL3XAK0fGZ+ce4
 SszsqatcbSOgzwn/IuDND5a6rygU1jVHxwy7mWlb2zWoqStyCiapnEIt3gC9V5Yv4NGL2jEHCJI
 jXze7SDRMszgEQ+AlSudTL6M7FdLPRzwiqFpnRNYn9Y1Limu1fR+t/kjsgF8dtfYUGRX3KCtCUf
 ew/VZ107FYYkbvF3iLceni3npmIYMl7a969yteLO34KcpchgBwXy19MWFknKE/KirBnUqe0S3/G
 34hcVuDlTBlBBXw3TMq4E7Y7XACcyAtk9ICUd7n8kB11ALyd/drC85dHquz+S+Gd9Z
X-Received: by 2002:a05:600c:820c:b0:47d:333d:99c with SMTP id
 5b1f17b1804b1-4835054f3f4mr6911945e9.18.1770683602323; 
 Mon, 09 Feb 2026 16:33:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209eeef0sm99232255e9.20.2026.02.09.16.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:33:22 -0800 (PST)
Date: Mon, 9 Feb 2026 16:33:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/7] net/nfb: ethernet enhancements
Message-ID: <20260209163316.0588af71@phoenix.local>
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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

On Fri,  6 Feb 2026 18:04:28 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This set includes minor enhancements to the Ethernet
> configuration and overall usage.
>=20
> ---
> Depends-on: series-37261 ("net/nfb: rework to real multiport")
>=20
> Martin Spinler (7):
>   net/nfb: use MAC address assigned to card
>   net/nfb: get correct link speed
>   net/nfb: support real link-up/down config
>   net/nfb: support setting RS-FEC mode
>   net/nfb: support setting Rx MTU
>   net/nfb: read total stats from macs
>   doc/nfb: update release notes for nfb driver
>=20
>  doc/guides/rel_notes/release_26_03.rst |   3 +-
>  drivers/net/nfb/meson.build            |   1 +
>  drivers/net/nfb/nfb.h                  |   7 +
>  drivers/net/nfb/nfb_ethdev.c           | 228 +++++++++++++++++++++----
>  drivers/net/nfb/nfb_mdio.c             |  42 +++++
>  drivers/net/nfb/nfb_mdio.h             |  34 ++++
>  drivers/net/nfb/nfb_stats.c            |  40 +++--
>  7 files changed, 308 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/net/nfb/nfb_mdio.c
>  create mode 100644 drivers/net/nfb/nfb_mdio.h
>=20

The CI and I don't have hardware to do deep check so have to rely
on my and AI review.


Bundle 1747 (Feature Additions - 7 patches)

3 Critical Issues:

    Patch 2: MDIO resource leak on error path - opened handles not closed
    Patch 3: Missing NULL check before accessing eth_node[0]
    Patch 4: Same NULL check issue in FEC get/set functions

Quick Summary: The feature additions are mostly solid. The main issue is a =
consistent pattern of accessing eth_node[0] without verifying the pointer i=
s non-NULL. One resource leak needs cleanup code added.

Detailed output:

# NFB Driver Review - Bundle 1747 (Feature Additions)

## Series: 7 patches adding MAC, link speed, FEC, MTU, and stats features

---

## PATCH 1/7: net/nfb: use MAC address assigned to card

**Subject**: net/nfb: use MAC address assigned to card (47 chars) =E2=9C=93

### Summary
Retrieves MAC address from card firmware via `nc_ifc_get_default_mac()` ins=
tead of always generating random MAC with OUI prefix.

### Status: =E2=9C=93 No errors found

This patch is clean. Falls back gracefully to random MAC generation if firm=
ware MAC retrieval fails.

---

## PATCH 2/7: net/nfb: get correct link speed

**Subject**: net/nfb: get correct link speed (38 chars) =E2=9C=93

### Summary
Adds MDIO infrastructure to read accurate link speed from PHY PMA registers=
 instead of MAC status register. Introduces `struct eth_node` with MDIO int=
erface info.

### Errors

**Error 1: Resource leak on error path**
```c
intl->eth_node[eth].if_info.dev =3D nc_mdio_open(intl->nfb, node, node_cp);
if (intl->eth_node[eth].if_info.dev) {
    // ... set up interface info
    eth++;
}
```
Location: `nfb_nc_eth_init()`, loop at line ~126

If `nc_mdio_open()` succeeds for some iterations but then a later error occ=
urs (e.g., memory allocation for subsequent MACs fails), the function jumps=
 to error labels `err_alloc_ethnode`, `err_alloc_txmac`, or `err_alloc_rxma=
c`. None of these labels close the already-opened MDIO handles.

**Suggested fix**: Add cleanup loop before freeing eth_node:
```c
err_alloc_ethnode:
    for (i =3D 0; i < eth; i++)
        if (intl->eth_node[i].if_info.dev)
            nc_mdio_close(intl->eth_node[i].if_info.dev);
    free(intl->eth_node);
err_alloc_txmac:
    free(intl->txmac);
err_alloc_rxmac:
    free(intl->rxmac);
    return ret;
```

---

## PATCH 3/7: net/nfb: support real link-up/down config

**Subject**: net/nfb: support real link-up/down config (47 chars) =E2=9C=93

### Summary
Implements actual PHY link control via MDIO PMA reset register (`NFB_MDIO_P=
MA_CTRL`) instead of just enabling/disabling MAC layer.

### Errors

**Error 1: Missing NULL check before array access**
```c
static int
nfb_eth_dev_set_link(struct pmd_internals *intl, bool val)
{
    // ...
    if (!intl->max_eth)
        return 0;
   =20
    if_info =3D &intl->eth_node[0].if_info;  // <-- dereference without NUL=
L check
```
Location: `nfb_eth_dev_set_link()`

If `intl->eth_node` is NULL (allocation failed but not caught), this crashe=
s. While initialization should guarantee that `max_eth > 0` implies `eth_no=
de !=3D NULL`, defensive coding requires verification.

**Suggested fix**: Add NULL check:
```c
if (!intl->max_eth || !intl->eth_node)
    return 0;
   =20
if_info =3D &intl->eth_node[0].if_info;
```

---

## PATCH 4/7: net/nfb: support setting RS-FEC mode

**Subject**: net/nfb: support setting RS-FEC mode (44 chars) =E2=9C=93

### Summary
Implements FEC (Forward Error Correction) get/set operations via MDIO PMA R=
S-FEC control register. Supports RS-FEC enable/disable; rejects AUTO mode.

### Errors

**Error 1: Same NULL check issue as Patch 3**
```c
static int
nfb_eth_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa)
{
    // ...
    if (!intl->max_eth)
        return 0;
   =20
    if_info =3D &intl->eth_node[0].if_info;  // <-- dereference without NUL=
L check
```
Location: `nfb_eth_fec_get()` and `nfb_eth_fec_set()`

**Suggested fix**: Add NULL check in both functions:
```c
if (!intl->max_eth || !intl->eth_node)
    return 0;
```

---

## PATCH 5/7: net/nfb: support setting Rx MTU

**Subject**: net/nfb: support setting Rx MTU (38 chars) =E2=9C=93

### Summary
Implements MTU setting by querying maximum frame length capability from all=
 RX MACs, taking minimum, and configuring all MACs with requested MTU.

### Status: =E2=9C=93 No errors found

The logic correctly handles the case of no RX MACs (`if (!intl->max_rxmac) =
return 0`), queries capability limits, validates against minimum capability=
, and applies MTU to all MACs.

One minor observation: `status.frame_length_max_capable` is initialized to =
0, and the function checks `frame_length_max_capable !=3D 0` before rejecti=
ng MTU. This allows unlimited MTU if all MACs report 0 capability (meaning =
unlimited). This seems intentional.

---

## PATCH 6/7: net/nfb: read total stats from macs

**Subject**: net/nfb: read total stats from macs (41 chars) =E2=9C=93

### Summary
Aggregates statistics from all MAC instances instead of reading from queues=
. Changes `nfb_eth_stats_get()` to sum across all RX/TX MACs.

### Status: =E2=9C=93 No errors found

The aggregation logic is straightforward and correct. Iterates over all MAC=
s and accumulates statistics into the stats structure.

---

## PATCH 7/7: doc/nfb: update release notes for nfb driver

**Subject**: doc/nfb: update release notes for nfb driver (52 chars) =E2=9C=
=93

### Status: =E2=9C=93 Not reviewed (documentation)

Documentation patch - should verify that release notes accurately describe =
all changes in the series.

---

## Summary - Bundle 1747

### Critical Issues: 3

1. **Patch 2/7**: Resource leak - MDIO handles not closed on error path in =
`nfb_nc_eth_init()`
2. **Patch 3/7**: Missing NULL check before accessing `eth_node[0]` in `nfb=
_eth_dev_set_link()`
3. **Patch 4/7**: Missing NULL check before accessing `eth_node[0]` in `nfb=
_eth_fec_get()` and `nfb_eth_fec_set()`

### All Patches: Format =E2=9C=93

- Proper Signed-off-by tags =E2=9C=93
- Subject lines within 60 chars =E2=9C=93
- Commit message format correct =E2=9C=93

---

## Recommended Actions

### Must Fix:
1. **Patch 2**: Add MDIO handle cleanup loop on error paths
2. **Patches 3-4**: Add NULL check for `eth_node` before accessing array el=
ement

### Pattern to Apply:
For all functions accessing `intl->eth_node[0]`, use:
```c
if (!intl->max_eth || !intl->eth_node)
    return 0;  // or appropriate error code
```

This defensive pattern prevents crashes if initialization invariants are vi=
olated.
