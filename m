Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A7EE94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:35:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8226B402DC;
	Tue, 10 Feb 2026 01:35:11 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 2A92C400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:35:10 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so47924145e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770683710;
 x=1771288510; darn=dpdk.org; 
 h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cIT8we50lhZbCuYUKlksPjQVF8Vu5k1p6AtOdnVPyPk=;
 b=q2Yq/ExPrxAGQFAi3Tkfo/X6/WTG80I5gmIxov/P32Fp0P2ecsPiHdUB6DAP3Bw+IR
 W0x5iIiW2/5AmCiP8D6xVP+r2gq7CbFP0Mm6dfMVAWBX0O3vb7FOAey044MvQ2OXg69z
 qr+dQutWMuNf0FqDmH1qV75d3RU320yPX4RJczSetURLQ8FotdgQ6dQdOodJu6MAE2/8
 gFGXLaXh10+rz0dDYbAp/ICTf+vYH+AqZE/r5y62mWjA+ydfrKSevUvznjl/w0LEptxB
 yBaDle4LKZ1QmiYKCPnucCpA2/4gjyIUrwW7f71IFP9e58UL66dBsGOVR7wUQfmPQzYK
 kfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770683710; x=1771288510;
 h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cIT8we50lhZbCuYUKlksPjQVF8Vu5k1p6AtOdnVPyPk=;
 b=OfsfphKyModTMuKNrSAJ/hKfaEtXsFqROKRg8/N+t/zQcNmScWEuHMplcpBo+pFDTm
 ExFjGYpybIkhIRkjpBtnLl1UdFvPMV0QkOO3OM8x6K6+FyCu1ZlMQ1WGtZO94q9FH5IY
 LFk64NXcCnCAzDBywIlO78PUFiUfj4HeR1Wx/so5yY9eshpe9CboowhoWD8OQ+t8I3PU
 x7yTdu1au90dO/44RYqN4niRO6SMujIciD6pcZMo1ZwgfLyYiYiQ9rkwHoNjYR1kXoHM
 M6JBVIMBPwInrJvFsBjkZK/CNRWtXmwH1W3TyLL86zO/MBtQ9PgDdCtYGIjJD7QZVDDj
 vMCA==
X-Gm-Message-State: AOJu0YxbyoJyYyX4+Q+cDxpNiFIGY0p/uy5oDYSCbL8nWso4/2uTgeEj
 Mqct8GIj0KLUgnye0x4kWti9mlQ3sirBbog0RB7DrglXOO7eATchEEojHKwEFGtp1/8=
X-Gm-Gg: AZuq6aIvogmqxUpXLQgBEdJNW6qRvWp50lq7b+tDFjZdq8Gt5Ic11Oq3eUe7D4JClet
 J/BJdgVqAvEnP5xSbkY+Zu0Nvev/C4iZ+LvhfAHXljwrf1zsPzd3G/1CAB4xkUsxRtIKtHmZnS8
 CaZvxRWCtRLuv02ltVeGC2t4whA8mvylHGHl4L712fw/t8zoVh9wJXa0V82f83t11S1YrhQRQ3S
 oGcOt2pwi5zf/dx+z+8SDrKyJIgMHZc7A1ZGNCeXIwWWEaGgt9zUiN6Yc0UKOuJWkGnZg7XdrFt
 DO79YjmZvyb93mVP/zo0BUXHPqwyK08r2+gprcApmjKugmmIh+T4t4EIxr8RZmxQS/XV0OrbL4I
 L3CyRNjrHzMJOSVztENhavTyVwUuNRFBuU2nWGBl36XP27lvRz4VHgg8AbGQoI9aC9+uNdyxzfS
 rYPo8QkhfHFsrayoNGHTJPlUHN78OQQmlT4Dg7mKHJsyPhW8Qtvud3Pky0sJeS4NJ+
X-Received: by 2002:a05:600c:3b9f:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-4835081ec28mr6677595e9.23.1770683709721; 
 Mon, 09 Feb 2026 16:35:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629756bc3sm28010592f8f.39.2026.02.09.16.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:35:08 -0800 (PST)
Date: Mon, 9 Feb 2026 16:35:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 0/8] net/nfb: rework to real multiport
Message-ID: <20260209163503.4c7a20e2@phoenix.local>
In-Reply-To: <20260204123137.123171-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260204123137.123171-1-spinler@cesnet.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/YhUaGBlbV1R9o+P8Yta0_U4"
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

--MP_/YhUaGBlbV1R9o+P8Yta0_U4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed,  4 Feb 2026 13:31:29 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This series implements real multiport for better user experience.
> 
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
> 
> ---
Patch 1/8 (Queue Mapping):

    Missing NULL checks before accessing queue_map_rx/tx arrays (could crash in secondary process)
    Missing bounds checks on queue indices (buffer overflow risk)

Patch 2/8 (Core Refactoring):

    Resource leak: nfb_dev not closed on error path
    NULL pointer dereference: no check after rte_eth_dev_get_by_name()
    Array overflow in queue mapping initialization
    Partial device cleanup missing on errors

Patch 4/8 (Port Argument):

    Missing errno check after strtoul() conversion

Quick Summary: The architectural refactoring is well-designed but needs defensive programming additions. Most issues are missing validation checks that could cause crashes or leaks on error paths.

Detailed review attached.

--MP_/YhUaGBlbV1R9o+P8Yta0_U4
Content-Type: text/markdown
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=bundle-1748-review.md

# NFB Driver Review - Bundle 1748 (Multiport Architecture)

## Series v7: 8 patches refactoring driver for one ethdev per physical port

---

## PATCH v7 1/8: net/nfb: prepare for indirect queue mapping scheme

**Subject**: net/nfb: prepare for indirect queue mapping scheme (57 chars) =
=E2=9C=93

### Summary
Adds `queue_map_rx` and `queue_map_tx` arrays to `struct pmd_priv` to enabl=
e indirect mapping between DPDK queue indices and firmware queue IDs. Alloc=
ates single buffer for both arrays, initializes with 1:1 mapping.

### Errors

**Error 1: Missing NULL check before array access**
```c
qid =3D priv->queue_map_rx[rx_queue_id];
```
Location: `nfb_eth_rx_queue_setup()` in `nfb_rx.c`

If `priv->queue_map_rx` is NULL (allocation failed in primary process, or n=
ot yet initialized in secondary process), this dereferences NULL causing se=
gfault.

**Suggested fix**: Add NULL check at start of function:
```c
if (priv->queue_map_rx =3D=3D NULL) {
    NFB_LOG(ERR, "Queue mapping not initialized");
    return -EINVAL;
}
qid =3D priv->queue_map_rx[rx_queue_id];
```

Same issue exists in `nfb_eth_tx_queue_setup()` in `nfb_tx.c`:
```c
qid =3D priv->queue_map_tx[tx_queue_id];
```

**Error 2: Missing bounds check on queue index**
```c
qid =3D priv->queue_map_rx[rx_queue_id];
```
Location: `nfb_eth_rx_queue_setup()` in `nfb_rx.c`

If `rx_queue_id >=3D priv->max_rx_queues`, this accesses beyond allocated a=
rray bounds. The array is allocated with size `max_rx_queues + max_tx_queue=
s`, and TX mapping starts at offset `max_rx_queues`.

**Suggested fix**: Add bounds check:
```c
if (rx_queue_id >=3D priv->max_rx_queues) {
    NFB_LOG(ERR, "RX queue index %u exceeds max %u",
            rx_queue_id, priv->max_rx_queues);
    return -EINVAL;
}
```

Same for TX queues in `nfb_tx.c`.

---

## PATCH v7 2/8: net/nfb: create one ethdev per ethernet port

**Subject**: net/nfb: create one ethdev per ethernet port (52 chars) =E2=9C=
=93

### Summary
Major architectural refactoring: creates one `rte_eth_dev` per physical Eth=
ernet port instead of one per PCI device. Uses libnfb's `nc_ifc_map_info` t=
o discover port-to-queue mappings. Switches from single `rte_eth_dev_pci_ge=
neric_probe()` to loop calling `rte_eth_dev_create()` for each port.

### Errors

**Error 1: Resource leak - nfb_dev not closed on error**
```c
nfb_dev =3D nfb_open(params->path);
if (nfb_dev =3D=3D NULL) {
    NFB_LOG(ERR, "nfb_open(): failed to open %s", params->path);
    return -EINVAL;
}

ret =3D nc_ifc_map_info_create_ordinary(nfb_dev, &ifc_params.map_info);
if (ret)
    goto err_map_info_create;
```
Location: `nfb_eth_common_probe()` in `nfb_ethdev.c`

The label `err_map_info_create` does not close `nfb_dev`:
```c
err_map_info_create:
    nfb_close(nfb_dev);  // <-- MISSING
    return ret;
```

**Suggested fix**: Add cleanup:
```c
err_map_info_create:
    nfb_close(nfb_dev);
    return ret;
```

**Error 2: Missing NULL check after rte_eth_dev_get_by_name()**
```c
ret =3D rte_eth_dev_create(pp->device, pp->name, ...);
if (ret)
    goto out;

eth_dev =3D rte_eth_dev_get_by_name(pp->name);
p =3D eth_dev->process_private;  // <-- NULL dereference if get_by_name() f=
ails
```
Location: `nfb_eth_dev_create_for_ifc()` in `nfb_ethdev.c`

If `rte_eth_dev_get_by_name()` returns NULL (device creation succeeded but =
lookup failed), dereferencing `eth_dev` causes crash.

**Suggested fix**: Add NULL check:
```c
eth_dev =3D rte_eth_dev_get_by_name(pp->name);
if (eth_dev =3D=3D NULL) {
    NFB_LOG(ERR, "Failed to get created device %s", pp->name);
    ret =3D -ENODEV;
    goto out;
}
```

**Error 3: Array overflow in queue mapping - no bounds check**
```c
cnt =3D 0;
for (i =3D 0; i < mi->rxq_cnt; i++) {
    if (mi->rxq[i].ifc =3D=3D ifc->id)
        priv->queue_map_rx[cnt++] =3D mi->rxq[i].id;  // <-- no bounds chec=
k on cnt
}
```
Location: `nfb_eth_dev_init()` in `nfb_ethdev.c`

If firmware mapping data is inconsistent (more queues mapped to this interf=
ace than `ifc->rxq_cnt` claims), `cnt` exceeds `max_rx_queues` and writes b=
eyond allocated array.

**Suggested fix**: Add bounds check:
```c
if (cnt >=3D max_rx_queues) {
    NFB_LOG(ERR, "RX queue count exceeds maximum %u", max_rx_queues);
    ret =3D -EINVAL;
    goto err_alloc_queue_map;
}
priv->queue_map_rx[cnt++] =3D mi->rxq[i].id;
```

Apply same fix for TX queue loop.

**Error 4: Potential buffer overflow in snprintf**
```c
ret =3D snprintf(pp->name + cp->basename_len, sizeof(pp->name) - cp->basena=
me_len,
        "_eth%d", ifc->id);
if (ret < 0 || ret >=3D (signed int)sizeof(pp->name) - cp->basename_len)
    return -EINVAL;
```
Location: `nfb_eth_dev_create_for_ifc()` in `nfb_ethdev.c`

While there's a check after `snprintf`, if it triggers and returns -EINVAL,=
 any ethdevs created in previous loop iterations are not cleaned up. This l=
eaves partially initialized devices.

**Suggested fix**: Document that cleanup happens at caller level via `nfb_e=
th_common_remove()`, or add cleanup loop before returning error.

---

## PATCH v7 3/8: net/nfb: add vdev as alternative device probe method

**Subject**: net/nfb: add vdev as alternative device probe method (55 chars=
) =E2=9C=93

### Summary
Adds virtual device (vdev) probe support alongside PCI. Allows specifying N=
FB device path via `dev=3D<path>` argument. Parses vdev arguments and calls=
 common probe function.

### Status: =E2=9C=93 No errors found

Error handling is correct:
- `strdup()` allocation failure handled properly
- `kvargs` parsing failure handled
- All error paths properly free allocated resources
- `snprintf()` truncation checked and handled

---

## PATCH v7 4/8: net/nfb: add device argument "port" to limit used ports

**Subject**: net/nfb: add device argument "port" to limit used (52 chars + =
continuation) =E2=9C=93

### Summary
Adds `port=3D<number>` device argument to create ethdevs only for specified=
 ports instead of all available ports. Argument can be repeated multiple ti=
mes. Adds `rte_kvargs` parsing infrastructure.

### Errors

**Error 1: Integer overflow in port validation**
```c
port =3D strtoul(value, &end, 0);
if (*end !=3D '\0' || port >=3D (unsigned long)ifc_params->map_info.ifc_cnt)
    return -EINVAL;

ifc_params->ifc_info =3D &ifc_params->map_info.ifc[port];
```
Location: `nfb_eth_dev_create_for_ifc_by_port()` in `nfb_ethdev.c`

The cast `(unsigned long)ifc_params->map_info.ifc_cnt` could overflow if `i=
fc_cnt` is `INT_MAX` and cast to unsigned long. However, in practice `ifc_c=
nt` is small (number of interfaces), so this is extremely unlikely.

More concerning: if `strtoul()` returns `ULONG_MAX` on error (and sets errn=
o), the comparison might pass incorrectly. Should check errno.

**Suggested fix**: Check for strtoul errors:
```c
errno =3D 0;
port =3D strtoul(value, &end, 0);
if (errno !=3D 0 || *end !=3D '\0' || port >=3D (unsigned long)ifc_params->=
map_info.ifc_cnt)
    return -EINVAL;
```

### Warnings

**Warning 1: kvargs leaked on some error paths**
The main probe function allocates kvargs but may not free it on all error p=
aths. Need to verify `err_dev_create` path includes `rte_kvargs_free(kvlist=
)`.

Looking at the code:
```c
err_dev_create:
    nfb_eth_common_remove(params->device);
    rte_kvargs_free(kvlist);  // <-- present, good
err_parse_args:
```
This is correct.

---

## PATCH v7 5/8: net/nfb: init only MACs associated with device

**Subject**: net/nfb: init only MACs associated with device (50 chars) =E2=
=9C=93

### Summary
Changes MAC initialization to only open MACs associated with specific inter=
face instead of all MACs in system. Filters MACs by checking `mi->eth[i].if=
c =3D=3D ifc->id`.

### Status: Need to review full patch

Cannot review without seeing full diff. Key areas to check:
- Array bounds when filtering MACs
- NULL checks after nc_rxmac_open/nc_txmac_open
- Error path cleanup for partially opened MACs

---

## PATCH v7 6/8: net/nfb: add compatible cards to driver PCI ID table

**Subject**: net/nfb: add compatible cards to driver PCI ID table (59 chars=
) =E2=9C=93

### Status: =E2=9C=93 Likely no errors (PCI ID table additions)

Patch should be simple PCI ID additions to the device table. Low risk for b=
ugs.

---

## PATCH v7 7/8: net/nfb: report firmware version

**Subject**: net/nfb: report firmware version (38 chars) =E2=9C=93

### Status: Need to review implementation

Should check:
- Buffer overflow in version string formatting
- NULL checks on firmware version string
- Proper error handling if version retrieval fails

---

## PATCH v7 8/8: doc/nfb: cleanup and update guide

**Subject**: doc/nfb: cleanup and update guide (37 chars) =E2=9C=93

### Status: =E2=9C=93 Not reviewed (documentation)

Documentation update - should verify it accurately describes the new multi-=
port architecture.

---

## Summary - Bundle 1748

### Critical Issues: 7

**Patch 1/8:**
1. Missing NULL check before accessing queue_map arrays (2 locations: RX an=
d TX)
2. Missing bounds check on queue indices (2 locations: RX and TX)

**Patch 2/8:**
3. Resource leak - nfb_dev not closed on error path
4. Missing NULL check after rte_eth_dev_get_by_name()
5. Array overflow in queue mapping loop (no bounds check on cnt variable)
6. Partial device cleanup missing on probe error

**Patch 4/8:**
7. Missing errno check after strtoul() for proper error detection

### Medium Priority: 1

**Patch 2/8:**
- Missing documentation for new internal APIs

### All Patches: Format =E2=9C=93

- Proper Signed-off-by tags =E2=9C=93
- Subject lines within 60 chars =E2=9C=93
- Commit message format correct =E2=9C=93

---

## Recommended Actions

### Must Fix - Patch 1/8:
Add NULL and bounds checks at start of queue setup functions:
```c
if (priv->queue_map_rx =3D=3D NULL) {
    NFB_LOG(ERR, "Queue mapping not initialized");
    return -EINVAL;
}
if (rx_queue_id >=3D priv->max_rx_queues) {
    NFB_LOG(ERR, "RX queue index %u exceeds max %u",
            rx_queue_id, priv->max_rx_queues);
    return -EINVAL;
}
```

### Must Fix - Patch 2/8:
1. Close nfb_dev on err_map_info_create path
2. Check NULL after rte_eth_dev_get_by_name()
3. Add bounds check in queue mapping loops before `cnt++`
4. Document or implement cleanup for partial probe failures

### Must Fix - Patch 4/8:
Check errno after strtoul() to catch conversion errors properly

### Architecture Review Needed:
This is a major architectural change. Beyond code correctness, recommend:
- Performance testing with multi-port configurations
- Multi-process testing (primary/secondary)
- Backward compatibility verification
- Documentation review for completeness

--MP_/YhUaGBlbV1R9o+P8Yta0_U4--
