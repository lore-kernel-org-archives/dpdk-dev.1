Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C0EEF99D3
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA429402D8;
	Fri, 13 Feb 2026 20:39:54 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id EC0C7402C0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:39:52 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso11771375e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771011592;
 x=1771616392; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Du/svMIy+54ElK4iKfxe2a5AVzC850z3eEE4f6WA5Nc=;
 b=xv8OUP/D6BCwt2MVf8EpQUNHkgWIo5uFRfK4KDnJM1eHf44o+eropukNrfWuSW1Dge
 c99P2Po/MVuywNAJjFB9+Xdenkx/bqx7E4DgujmD+kTth1AJ+eW5elET2UgStiNdCUpf
 R2u4XH1f7FaaxHz70ftsjHcemDrVnJt7fMN34OQefEScDs5smmSdkVWfI8bog5yfDptZ
 L6u0vB0OnJD3kQmshNlVRc58EB1SeDgkjKWQMxfjhRO5Y6fOtaahx5Z2Uk/bC4LTp/rr
 UAvZ3HGhQXpVxlCxiS3c8bTSG+zcx9B1qu7ogxa8r3QaZO7mWQoMGN2JNIJckaoHd62r
 Ovgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011592; x=1771616392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Du/svMIy+54ElK4iKfxe2a5AVzC850z3eEE4f6WA5Nc=;
 b=X/8/jDkeAVf8lFEsr0JhEdBHXMWMARNij9xdA3T69XNTDvulUBMdDaWeRvWTIiDDQV
 V5VMXo2APwKgV0vgKVWOO7IMzsk4o3sNYlQZB4NVKWz4S2DbuFlAwUCbCyxW3+3YZ8A1
 e17i5gjsIafriWdWLvrWCsFqA4hZ1mcLjOmwgihXnwDn8mBqIkp1a5GDLcJC5EdQZuaP
 ciqT9gInCNKICbjk882woSNV334k4/X3bgdUdWr6KbMhse4zHQA+bf0HArAe7DEj6jwf
 eSC4tUKiGMjabwCj0u1UdlFpe+RrJQPzfgFH8o14dDh80dezbgeJiEDEgyWkuYc/XGMy
 AAwQ==
X-Gm-Message-State: AOJu0YwClU0YG93ALqz9a/63ZHVMroTpUoexIXXkBzbqP8o5XIaBr+ZA
 ZLi3vlgOf0OEuvdaUqsx47q7WragKcC593oCiqJ+Cu5aWZaiDpPF/EOkX/uN9ZLF13k=
X-Gm-Gg: AZuq6aIJ9bvI1WLFgqjJzfa5fJ8jquMzOcgBGJjdn1WxtfJBff2OCxMWH0oFiWm85Sk
 VINdws4CYmNgWAW28O9ZIpie8u4YZ6d5j6EAC5sZ+Wfc46Zdo+YSm089yXAvSqviP1+3kvOxSgz
 DPC8I3R8sJLjSrPXeZ0s/YWoAjAMtFcNDXqRDW5UW62FwElgWN8rx0DjPktvstmNbw8/xgZsyQ1
 7lWo9ZBZODItlwqx6Iqz+uSicby1GZ46f8NPTKDCEN0boN3l0Ys/iemhw/pxeTYBgJC0P2ytLvE
 0xNZltV+zs6gyckX5JfHP537ldswiNcu4A8GRROTUVnE55vm9j4nAU7pXQKlMHK3ZkTCmeezmYK
 jAEdvh88jN3ugYFC8adE0HyFFSuWABZIZnQk68vIgqPgqY3lphCRsDNF1Xer5Froui1hEid6P2g
 WCcHERU8K3yKhDk49gv7li4a7UC1AHp3stBM/NVCVit+omzxVv8qndvdAPMV9MwJOc
X-Received: by 2002:a05:600c:348c:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-48373a5ba0dmr42278285e9.19.1771011592072; 
 Fri, 13 Feb 2026 11:39:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371998777sm97355215e9.1.2026.02.13.11.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:39:51 -0800 (PST)
Date: Fri, 13 Feb 2026 11:39:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 0/8] net/nfb: rework to real multiport
Message-ID: <20260213113947.4cb4aa30@phoenix.local>
In-Reply-To: <20260213185317.1893353-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260213185317.1893353-1-spinler@cesnet.cz>
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

On Fri, 13 Feb 2026 19:53:09 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This series implements real multiport for better user experience.
>=20
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
>=20
> ---

There is one copy-paste bug (found by AI review).
I can fix that during merge.

Summary of Findings
Patch	Severity	Issue
2/8	Error	TX queue map bounds check uses max_rx_queues instead of max_tx_qu=
eues =E2=80=94 copy-paste bug
2/8	Warning	__rte_internal / RTE_EXPORT_INTERNAL_SYMBOL misuse for driver-i=
nternal functions
5/8	Warning	err_map_inconsistent error path leaks already-opened MAC handles


Full report

# Deep Dive Review: net/nfb multiport patch series (v8, 8 patches)

**Author:** Martin Spinler <spinler@cesnet.cz>
**Series:** [PATCH v8 1/8] through [PATCH v8 8/8]
**Reviewer:** AI review per AGENTS.md guidelines

---

## Changes from v7

Several issues from the v7 review have been addressed:

- **Fixed:** The double `TAILQ_REMOVE` bug =E2=80=94 `nfb_eth_common_remove=
()` no longer removes from the list; only `nfb_eth_dev_uninit()` does.
- **Fixed:** Buffer overflow in queue map filling =E2=80=94 bounds checks a=
dded with `cnt >=3D max_rx_queues` guard and `goto err_queue_map`.
- **Fixed:** `strtoul` base changed from 0 to 10, preventing octal/hex port=
 numbers.
- **Fixed:** Bounds check added in `nfb_nc_eth_init()` for MAC mapping cons=
istency.
- **New:** Added `priv->ready` flag for secondary process safety in patch 1.
- **New:** Added bounds checks in `nfb_eth_rx_queue_setup` and `nfb_eth_tx_=
queue_setup` (`rx_queue_id >=3D priv->max_rx_queues`).
- **New:** Added NULL check on `rte_eth_dev_get_by_name()` return in `nfb_e=
th_dev_create_for_ifc`.
- **New:** Added `ifc_params.ret` field to pass back error codes from `rte_=
kvargs_process` callback.
- **New:** Added `errno =3D 0` before `strtoul` and `errno` check after.

---

## Patch 2/8: net/nfb: create one ethdev per ethernet port

### Error: TX queue map bounds check uses `max_rx_queues` instead of `max_t=
x_queues`

In the TX queue mapping loop:

```c
cnt =3D 0;
for (i =3D 0; i < mi->txq_cnt; i++) {
    if (mi->txq[i].ifc =3D=3D ifc->id) {
        if (cnt >=3D max_rx_queues) {          /* <--- BUG: should be max_t=
x_queues */
            NFB_LOG(ERR, "TX queue mapping inconsistent");
            ret =3D -EINVAL;
            goto err_queue_map;
        }
        priv->queue_map_tx[cnt++] =3D mi->txq[i].id;
    }
}
```

The bounds check compares `cnt` against `max_rx_queues` but this is filling=
 `queue_map_tx` which was allocated with `max_tx_queues` slots. If `max_tx_=
queues < max_rx_queues`, this allows writing past the end of the TX portion=
 of the buffer. If `max_tx_queues > max_rx_queues`, it rejects valid mappin=
gs prematurely.

**Suggested fix:** Change `max_rx_queues` to `max_tx_queues`:
```c
if (cnt >=3D max_tx_queues) {
```

### Warning: `__rte_internal` + `RTE_EXPORT_INTERNAL_SYMBOL` for driver-int=
ernal functions

`nfb.h` declares `nfb_eth_common_probe` and `nfb_eth_common_remove` with `_=
_rte_internal`, and the `.c` file uses `RTE_EXPORT_INTERNAL_SYMBOL`. These =
functions are shared between `nfb_ethdev.c` and `nfb_vdev.c` within the sam=
e driver =E2=80=94 they are not cross-library internal symbols. `__rte_inte=
rnal` is meant for functions exported between DPDK libraries/drivers via th=
e linker map, not for functions shared within a single PMD. Plain `extern` =
declarations would be more appropriate.

---

## Patch 5/8: net/nfb: init only MACs associated with device

### Warning: `err_map_inconsistent` path doesn't close already-opened MACs

In `nfb_nc_eth_init()`, if the bounds check triggers:

```c
if (rxm >=3D ifc->eth_cnt || txm >=3D ifc->eth_cnt) {
    NFB_LOG(ERR, "MAC mapping inconsistent");
    ret =3D -EINVAL;
    goto err_map_inconsistent;
}
```

The error path frees `intl->txmac` and `intl->rxmac` arrays but does not cl=
ose any MAC handles already opened via `nc_rxmac_open` / `nc_txmac_open` in=
 previous loop iterations. These handles would be leaked.

**Suggested fix:** Close all opened MACs before freeing the arrays:
```c
err_map_inconsistent:
    for (int j =3D 0; j < txm; j++)
        nc_txmac_close(intl->txmac[j]);
    for (int j =3D 0; j < rxm; j++)
        nc_rxmac_close(intl->rxmac[j]);
    free(intl->txmac);
err_alloc_txmac:
    free(intl->rxmac);
err_alloc_rxmac:
    return ret;
```

Alternatively, set `intl->max_rxmac =3D rxm; intl->max_txmac =3D txm;` befo=
re the goto and call `nfb_nc_eth_deinit(intl)` instead.

---

## Summary of Findings

| Patch | Severity | Issue |
|-------|----------|-------|
| 2/8 | **Error** | TX queue map bounds check uses `max_rx_queues` instead =
of `max_tx_queues` =E2=80=94 copy-paste bug |
| 2/8 | Warning | `__rte_internal` / `RTE_EXPORT_INTERNAL_SYMBOL` misuse fo=
r driver-internal functions |
| 5/8 | Warning | `err_map_inconsistent` error path leaks already-opened MA=
C handles |
