Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A082C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B90642DA3;
	Wed, 21 Jan 2026 18:43:06 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 0D25F40261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:43:05 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-480142406b3so944065e9.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769017385;
 x=1769622185; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig/hmnc9Onvk8xMYmw5dW0JMtcg2oku+NC5OotlDQMg=;
 b=0VvDj6QmeQveDsEsr6knXZ9WHvh5Vhr7o6gb9tCz5Ef9Y6nYuo7N5XcnOwKouZcTx4
 U8F+SnDWVugzaoGi4anTiTImHU3ct2OINDS6RWEpxBQomWDaqFiidCnFy0bdN7RKKmek
 onN425FH7JQtASLuJjmUs3ZvbRc6X0v5KiF2Fqd4OnmOu2l3pYS6EDHOjk5PE5iz5h1g
 XqhmLVGUSlKpO1mzsquY8ROfOI52qE3NfFiZ8lZQDU4VDQBePJ3c/KTn/+D4WoJNoYyT
 2h8SPAd1vjLJXEPAeUou+n8BdrYmH11+6N+AEm+vE/d+iojCnLbqxVyN85McJyhl05C+
 77sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769017385; x=1769622185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ig/hmnc9Onvk8xMYmw5dW0JMtcg2oku+NC5OotlDQMg=;
 b=opfbmugDH+gOlQdUs61pl+asnMOv0kBDW/kFQnRIdPy+owYeLC70K+IXncSEfKqrgK
 IcPcCQc5/qfHh7D8OI47icOabxQxs/bULf0sgWyM4MCgw6iqVUyRZQNbjdgxgxyl15o4
 JZBX/pQw3QDUPbqnkT4Ca0EkOzcYiVLi0XqL3fGOyz1wnOsZk3U/Gm3x6DBI9nlWEkTF
 VOPiMiwGq+dbWjvc/i/n93D8vaRiwWYQbe4C5ZhBd+9BJtAyLwSJgfTDE6gP5XOgv2kg
 YA125bGh0XDu/cfrfa2WqNVqvBYIpGjoLDaF639goaEhZcQd+0gMCS1b4Hx5DE/GEpMO
 EDxg==
X-Gm-Message-State: AOJu0Yy6cDq8sbyXUStwIMCvU70VLXJlg5u5nC1I5LBRA3jTjfUC+7Mc
 0QiuNdPZi0DqPBMClwAC2oMWnUtgPuKVmoYyxxrggqK2YMuVT9/z7y9Qqm8HLxERrCA=
X-Gm-Gg: AZuq6aKMtewk+H/SEsChAd/4R9JxRHSvMKR/ki96IUA6ugz2lLQEIeDPQX75UmD6a7l
 li6KV4SfPX2vxYSNjzt+4sbAAp2XzCnjWQ/Q6G6LVkbDYu5GI7UZooWn8TUC5uyGyFKecvCJDc0
 +c9Cp0//PbL/N2AbghHlzmc7p4NKI9h57qIEIyK1+fD76y5w41HTbz79JVR3D8Gi9LRhmifJDcW
 +HDco8TBHWqCxO6B41zjoiuKvlKt/GEhNP2Ic5RWg85LCEL9rxZQJGT08dUkVsmlGOs/sHs2V2M
 A5W9ooVdumcz6NEfoKCfbkcdq1NwoUXHB2NLt6ugc7fFbb7cL9CWdeRi9MJdfUhCNymDT7wrRKT
 zgvcxV5b4gyGK1q/yDJDzbJ+2yHDGboT3WcRDViQgKFOimnwKwAan9+nrlmAaB/lSSVLcpgnP5q
 1zZZ0K6W4TVbh141Fx0yr/zFhoCtVvzXJGX0IXOBl1w/6HsSQ3KecK
X-Received: by 2002:a05:600c:8816:b0:480:1e8f:d15f with SMTP id
 5b1f17b1804b1-4801e8fd2e5mr161515275e9.2.1769017384318; 
 Wed, 21 Jan 2026 09:43:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c38063sm26051465e9.12.2026.01.21.09.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:43:03 -0800 (PST)
Date: Wed, 21 Jan 2026 09:42:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/8] net/nfb: rework to real multiport
Message-ID: <20260121094259.362e7369@phoenix.local>
In-Reply-To: <20260121170333.272985-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260121170333.272985-1-spinler@cesnet.cz>
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

On Wed, 21 Jan 2026 18:03:25 +0100
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

TLDR; Fix the use of sprintf() in patch 3 and resubmit

Wordy AI review output...


## NFB Multiport Patch Series v3 Review

### Series Overview

This is a significant feature series that transforms the NFB driver from si=
ngle-port-per-PCI to multi-port-per-PCI architecture, with vdev support and=
 new card additions.

---

### Patch 1/8: `net/nfb: prepare for indirect queue mapping scheme`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 54 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- Adds `queue_map_rx` and `queue_map_tx` arrays to `pmd_priv`
- Allocates both in a single `rte_calloc()` call with `queue_map_tx =3D que=
ue_map_rx + max_rx_queues` - efficient
- Proper error handling with goto cleanup
- Removes unused `rx_queue_id` / `tx_queue_id` from queue structures
- Changes `nfb_eth_rx_queue_init()` and `nfb_eth_tx_queue_init()` signature=
s from `uint16_t rx_queue_id` to `int qid`

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 2/8: `net/nfb: create ethdev for every eth port/channel`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 52 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- Major architectural change: replaces `rte_eth_dev_pci_generic_probe()` wi=
th multiple `rte_eth_dev_create()` calls
- Uses TAILQ for tracking eth_dev instances for cleanup
- Adds `nfb_eth_common_probe()` and `nfb_eth_common_remove()` as internal s=
ymbols
- Properly uses `nc_ifc_map_info_create_ordinary()` for port/queue mapping =
info
- `<netcope/info.h>` added for new API

**Issue - `__rte_internal` placement:**
```c
__rte_internal
int nfb_eth_common_probe(struct rte_device *device,
```
Per AGENTS.md: "`__rte_internal` alone on line, only in headers". This is c=
orrect =E2=9C=85

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 3/8: `net/nfb: add vdev as alternative device probe method`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 55 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- New file `nfb_vdev.c` with proper SPDX header
- Uses `rte_kvargs` for argument parsing
- Registers both `net_vdev_nfb` and alias `eth_vdev_nfb`
- Proper error handling with goto-style cleanup
- Uses `nfb_default_dev_path()` for default device

**Minor style note:** The `sprintf()` call at line 897-899 uses `dev_params=
_mod` both as target and in format string. This is technically undefined be=
havior in C, though it works in practice. Consider using a separate buffer =
or `snprintf()` with proper handling.

**Verdict: =E2=9A=A0=EF=B8=8F Minor concern** - The `sprintf(dev_params_mod=
, "%s%s=3D%s", dev_params_mod =3D=3D dev_params ? "" : ",", ...)` pattern i=
s risky. Consider refactoring.

---

### Patch 4/8: `net/nfb: add device argument "port" to limit used ports`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 53 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- Adds `port=3DN` argument support, can be used multiple times
- Uses bitmask for port selection (up to 64 ports via `uint64_t`)
- Proper validation with `fill_port_mask()` callback
- `RTE_PMD_REGISTER_PARAM_STRING` updated for both PCI and vdev drivers

**Code quality:**
```c
if (port >=3D ULONG_WIDTH)
    return -1;
```
Good bounds checking for the bitmask.

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 5/8: `net/nfb: init only MACs associated with device`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 49 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- Converts fixed-size arrays `rxmac[RTE_MAX_NC_RXMAC]` to dynamically alloc=
ated arrays
- Removes `RTE_MAX_NC_RXMAC` and `RTE_MAX_NC_TXMAC` defines (no longer need=
ed)
- `nfb_nc_rxmac_init()` / `nfb_nc_txmac_init()` now take `priv` and `params=
` and return error codes
- Proper cleanup in `nfb_nc_rxmac_deinit()` / `nfb_nc_txmac_deinit()` with =
`rte_free()`
- Error path properly unwinds: `err_txmac_init` =E2=86=92 `nfb_nc_rxmac_dei=
nit()` =E2=86=92 `err_rxmac_init`

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 6/8: `net/nfb: add compatible cards to driver PCI ID table`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 56 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- Adds new PCI IDs:
  - `PCI_VENDOR_ID_CESNET` (0x18ec)
  - `PCI_DEVICE_ID_NFB_200G2QL_E1` (secondary endpoint)
  - `PCI_DEVICE_ID_FB2CGHH`
  - `PCI_DEVICE_ID_COMBO400G1`
  - `PCI_DEVICE_ID_CESNET_NDK_COMMON`
- Straightforward addition to PCI table

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 7/8: `net/nfb: report firmware version`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 34 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |

**Code Review:**
- Implements `fw_version_get` dev_op
- Returns "project_name;project_version" format
- Handles NULL returns from `nc_info_get_fw_project_*()` gracefully
- Returns required buffer size when truncated (per API contract)

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 8/8: `doc/nfb: cleanup and update guide`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 33 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| `Signed-off-by:` | =E2=9C=85 PASS | |
| Body starts with lowercase | =E2=9A=A0=EF=B8=8F WARNING | Body starts wit=
h "changes:" which is unconventional |

**Code Review:**
- Updates `doc/guides/nics/nfb.rst` comprehensively
- Updates `doc/guides/nics/features/nfb.ini` with new features:
  - `Unicast MAC filter =3D Y`
  - `Timestamp offload =3D P`
  - `FW version =3D Y`
  - `Multiprocess aware =3D Y`
- Adds release notes entry in `doc/guides/rel_notes/release_26_03.rst`

**Documentation quality:** Much improved with clearer card list, links to G=
itHub and DYNANIC, and better architecture explanation.

**Minor issue:** The commit body format is unusual:
```
changes:
- overall cleanup
- added list of up-to-date cards...
```
Convention is to use prose in imperative mood. Suggest rewording to somethi=
ng like:
```
Clean up documentation and update the guide with:
- Current card list with firmware download links
- Updated port argument description
```

**Verdict: =E2=9A=A0=EF=B8=8F Minor style issue** in commit body, but conte=
nt is good

---

## Summary

| Patch | Status | Action Required |
|-------|--------|-----------------|
| 1/8 | =E2=9C=85 Ready | None |
| 2/8 | =E2=9C=85 Ready | None |
| 3/8 | =E2=9A=A0=EF=B8=8F Warning | Consider fixing `sprintf()` self-refer=
encing pattern |
| 4/8 | =E2=9C=85 Ready | None |
| 5/8 | =E2=9C=85 Ready | None |
| 6/8 | =E2=9C=85 Ready | None |
| 7/8 | =E2=9C=85 Ready | None |
| 8/8 | =E2=9A=A0=EF=B8=8F Minor | Consider rewording commit body to use im=
perative prose |

### Overall Assessment

This is a well-structured series that makes a significant architectural imp=
rovement to the NFB driver. The code quality is good, error handling is tho=
rough, and the documentation updates are comprehensive. The series properly=
 includes release notes as required.

**Recommendation:** The series can be merged with the minor fixes noted abo=
ve, or accepted as-is given the issues are relatively minor.
