Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01759EEA845
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 18:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08D594025F;
	Thu, 12 Feb 2026 19:52:36 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 0B54240041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 19:52:34 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so1464895e9.0
 for <dev@dpdk.org>; Thu, 12 Feb 2026 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770922354;
 x=1771527154; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsHeQYJK8jlQkDQbEefitQke4cYT9/gk8kkv1uzTkEE=;
 b=xhMIN1BNzG82vagvU2fjK7G5IqIujI+koaaSDg9DCk/qzha2FwbYvRavXftIIIJFYb
 ZoIxlKu0SjFjSbT56rASaEA69stiQ2xUhbPlspU9Hek+yLlJvk15TEHrrvoGAWO+O2EU
 +VTW7qhCrW1FgSc9HqQDReSBGZadu6yZQBSfQ6vgGDIDpiRKeL3E2F9Tu9pULy4XBv1U
 wrAa/C+LAdOQhwpGtDlby0RE++LK2rFqYQ4dIVTVPfQ/oNfBoZliVhoFqWMLmvsTn3ZT
 12YW54xLd2+/CFm5ZaVn6NISU0NgrpKavg2cYMzkjbeZQpG0tIFQpwB5OSGVnqRxpcuZ
 LKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770922354; x=1771527154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jsHeQYJK8jlQkDQbEefitQke4cYT9/gk8kkv1uzTkEE=;
 b=Uvl7Rxwc/JFJwGHfRRZuM5rbhnphNfIlTpw4REmpxieJL8r6FT/7rYo3sGyhiqIHpv
 yh32G/aJDgutzch6weoBDchoM1lmQkDS96kmba0LTfkl1zXMSkvu7xo6pSS7RPmFFIOn
 twJRhIxPXhJ0J78M52NYH2hBXoGinEeHtCFX7cuAOB9VhfBu65VfAI2aF8AcLUXGAl1s
 wdAsMn7yTdaJeV5dLLWk2x+oEm5JnG7PBYdu1DkM4aqMza4K/bMmfpKG816HCNFcpmq1
 +76LTovgxZyRov+BXPMNBSzC1P8imRN3YyWZf2FgrPbjFXaytOh4mBM5cmkvuiTgdbKn
 dAmQ==
X-Gm-Message-State: AOJu0YxebJQU8ONWxCVSWD7EVcN8KqlGUiVu20MLW2rGl49LghjZP+um
 YI00cCt7PSfUOs3BmT6L4p/hO9qiquQhv2xSLC1ZalkS+Vhjvct3gLYM5mH2vGPvAj4=
X-Gm-Gg: AZuq6aLvu3eyeBT89QPTCRxBPlS1FsCIC6pMdL5Y8ptIewV8OJQo+ZZwEPvGlLy2N0l
 9vM8bJxvpSdZ/iru6qKZwBy2PGd7hE0WJDsYEJJnZ6RmHnbQ21QqqUcNALPfzq0rbJdHUrAUx7j
 4+NgOyyKB54A+hbuYw7NSNoUy2BPJ9Tmf9LTd0nrRDEjAL9TnjtR4bOoAEcxlM3+teM6LVdv/+V
 yPU6smfUXiFQ0cjYFee6S8H36Lc4431AYDF8BMw1ZsAam0QafSe8B3bmQ6bEIAD1Nit1tXQVXuY
 uqKKubs6vykiA6RI222TGP9v8iMGFtnzKeAgtMbW723PnF1A9yE3q1AzPnjDWXP1UPCsTEDSrqi
 TpBg7KnjZK01UlprX83jK4mIrjcENVW0CbDXvT5yLq9I1fWcGyvb4ZIO6v53Jd9pRVBpBodDYES
 9MvEcxmXfdV1wl/ZR95ZUWAltv/d2Z3jimznEIBJ1QgzSoOx7EmquuKDnCUwhqXMpi
X-Received: by 2002:a05:600c:4f94:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-483710562demr1425705e9.34.1770922354268; 
 Thu, 12 Feb 2026 10:52:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a4df01sm1783595e9.6.2026.02.12.10.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 10:52:33 -0800 (PST)
Date: Thu, 12 Feb 2026 10:52:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/7] net/nfb: ethernet enhancements
Message-ID: <20260212105229.39ad3388@phoenix.local>
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

Less issues in this but AI did find some errors around checking values.
AI is pickier than is fully required, just figured you might want
to look at these. Since this patch depends on multiport
will defer this until that is updated.

The highest priority item is the unchecked MDIO read in
nfb_mdio_cl45_pma_get_speed_capa() =E2=80=94 a failed read gets silently
interpreted as a capability bitmask, which could advertise nonsensical
speeds to applications.

# Review: NFB PMD Enhancement Series (7 Patches)

**Series**: `[PATCH 1/7]` through `[PATCH 7/7]`
**Author**: Martin Spinler `<spinler@cesnet.cz>`
**Delegate**: Stephen Hemminger

This series adds hardware feature support to the NFB PMD, building on the m=
ulti-port architecture from the preceding series. It covers: card-assigned =
MAC addresses, MDIO-based link speed, PMA link up/down control, RS-FEC conf=
iguration, RX MTU setting, and MAC-counter-based statistics.

---

### Patch 2/7: `net/nfb: get correct link speed`

Introduces MDIO infrastructure (`nfb_mdio.c` / `nfb_mdio.h`), `eth_node` ar=
ray in `pmd_internals`, and PMA register-based speed capability and link sp=
eed reporting.

**Error: `nfb_mdio_cl45_pma_get_speed_capa()` does not check for MDIO read =
failure**

```c
reg =3D nfb_mdio_if_read_pma(info, NFB_MDIO_PMA_SPEED_ABILITY);

for (i =3D 0; i < NFB_MDIO_WIDTH; i++) {
    if (reg & NFB_MDIO_BIT(i))
        *capa |=3D speed_ability[i];
}
```

`mdio_read` can return negative values on error. A negative `reg` gets inte=
rpreted as a bitmask, producing garbage speed capability flags advertised t=
o the application.

**Fix**: Check `if (reg < 0) return;` before the loop.

**Confidence**: ~85%.

**Warning: `nfb_mdio.h` missing include guard**

The header has no `#ifndef _NFB_MDIO_H_` / `#define _NFB_MDIO_H_` guard. Mu=
ltiple or transitive inclusion could cause redefinition errors for the `sta=
tic inline` functions and macros.

**Confidence**: ~80%.

**Warning: `eth_node` population loop lacks bounds check**

```c
intl->eth_node =3D calloc(ifc->eth_cnt, sizeof(*intl->eth_node));
// ...
eth =3D 0;
for (i =3D 0; i < mi->eth_cnt; i++) {
    if (mi->eth[i].ifc !=3D ifc->id)
        continue;
    // ... populate intl->eth_node[eth] ...
    eth++;
}
```

Allocated with `ifc->eth_cnt` elements. If the firmware map has more matchi=
ng entries, `eth` overflows the allocation. Same pattern exists for `rxm`/`=
txm` in the base series, but this patch extends it to a third array.

**Confidence**: ~55%.

---

### Patch 3/7: `net/nfb: support real link-up/down config`

Adds PMA reset bit manipulation for link up/down.

**Warning: MACs left in inconsistent state on MDIO failure**

```c
for (i =3D 0; i < internals->max_rxmac; ++i)
    nc_rxmac_enable(internals->rxmac[i]);
for (i =3D 0; i < internals->max_txmac; ++i)
    nc_txmac_enable(internals->txmac[i]);
return nfb_eth_dev_set_link(internals, true);
```

If the MDIO PMA write fails, the function returns an error but the MACs hav=
e already been enabled. The caller sees failure while the hardware is in a =
half-configured state (MACs enabled, PMA still in reset). The symmetric pro=
blem exists in `set_link_down`.

**Confidence**: ~65%.

---

### Patch 4/7: `net/nfb: support setting RS-FEC mode`

**Error: `nfb_eth_fec_set()` ignores MDIO write return value**

```c
nfb_mdio_if_write_pma(if_info, NFB_MDIO_PMA_RSFEC_CR, reg);
ret =3D nfb_eth_fec_get(dev, &fec_capa2);
```

The write return value is discarded. If the write fails, the code proceeds =
to read back and compare =E2=80=94 which may coincidentally detect the fail=
ure, but the actual error code is lost and the user gets `-EINVAL` instead =
of `-EIO`.

**Fix**:
```c
ret =3D nfb_mdio_if_write_pma(if_info, NFB_MDIO_PMA_RSFEC_CR, reg);
if (ret < 0)
    return -EIO;
```

**Confidence**: ~75%.

---

### Patch 5/7: `net/nfb: support setting Rx MTU`

**Warning: `uint16_t` MTU addition can overflow**

```c
mtu +=3D RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
```

`mtu` is `uint16_t`. Adding 18 bytes wraps around near `UINT16_MAX`. The dr=
iver sets `max_rx_pktlen =3D (uint32_t)-1` in `dev_info`, so ethdev's valid=
ation won't reject unreasonably large MTU values.

**Fix**: Promote to `uint32_t` before the addition, or set a realistic `max=
_rx_pktlen` in `dev_info_get`.

**Confidence**: ~70%.

---

### Patch 6/7: `net/nfb: read total stats from macs`

**Warning: `ierrors` subtraction may underflow**

```c
stats->ierrors +=3D rx_cntrs.cnt_drop - rx_cntrs.cnt_overflowed;
```

If firmware counters are inconsistent and `cnt_overflowed > cnt_drop`, this=
 produces a large wrapped unsigned value. A guard would be safer:
```c
if (rx_cntrs.cnt_drop >=3D rx_cntrs.cnt_overflowed)
    stats->ierrors +=3D rx_cntrs.cnt_drop - rx_cntrs.cnt_overflowed;
```

**Confidence**: ~55%.

---

## Summary

| Severity | Patch | Finding |
|----------|-------|---------|
| **Error** | 2/7 | `nfb_mdio_cl45_pma_get_speed_capa()` doesn't check for =
negative MDIO read return =E2=80=94 garbage speed capabilities on error |
| **Error** | 4/7 | `nfb_eth_fec_set()` ignores MDIO write return value |
| **Warning** | 2/7 | `nfb_mdio.h` missing include guard |
| **Warning** | 2/7 | `eth_node` population loop lacks bounds check against=
 allocated size |
| **Warning** | 3/7 | `set_link_up`/`set_link_down` leaves MACs inconsisten=
t if MDIO fails |
| **Warning** | 5/7 | `uint16_t` MTU overflow; `max_rx_pktlen =3D (uint32_t=
)-1` lets it through |
| **Warning** | 6/7 | `ierrors` subtraction can underflow |

Patches 1/7 and 7/7 have no issues.


