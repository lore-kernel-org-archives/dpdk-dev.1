Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF8D2502E
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 00:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D184028F;
	Mon, 12 Jan 2026 01:32:17 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 0CE9C4013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 01:32:15 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-64b560e425eso8202268a12.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768177935;
 x=1768782735; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gs8ENZdqoVsQJVQfxEndsPqyCcgf8Am1xa5NW/w1Ahs=;
 b=vSe+mkZ39XDxZa2yuHoTPZZX0ulNwSKwxDrqNoiyQiYRKzA/qSBKi6SfhTOpm5auPC
 uqSfsHwfZXoYGrnNfOZWCOEXHKgD4/6PNsCujI2ieHM5tB7ZchzGi3IRZe2zAPsBjmh3
 PaaDNB8nKAxSSOkKBoCusheRG4QyCinqmhW1568lHuc8kvmE33w+23QkvDO8FA2exUkh
 V4yXDFM3njQ8Oyz7u/PPj63p2OGjnm95qIlnvY1Jo/jHjsNlLUPdpN1pmWiHIXux74YI
 D+2C1orGdacjZBsnbrBRzbDaYueaJK873dQGdA+rmRoIebX8QXeFhAvd81AolPWRFWq+
 KBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768177935; x=1768782735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gs8ENZdqoVsQJVQfxEndsPqyCcgf8Am1xa5NW/w1Ahs=;
 b=fIu0HM9IcSNxrMQU4RWLEy9DqKOSJo16Aig2G1wm3KLNe2xgAytRRk71ZoMGAdrUgO
 XCz0uzYOfYTBJMgDKxsA6xrxERx88ocyL6TbB2rhm4JNLWkUVBo2cxWm/MUTU9BJ15F+
 fLCRmJK1XhWzfhV1cH9m7LnipYiqRQ3gy5yT5EzXI5hhhsl4+vulsxJB5OtwgPpdzF1B
 nJ6QXl1Kc8DMg3gHzxKfye/SZ/ZESywJJsIWj3uaXbjFRPONxURHbZCdnN5trTZMnoKK
 s8/FYDn4qw8xR3/gOdDRba/2mMTrmu7G1llWip+Yto1wpdKCIoMBuQDHDxgndkMS6j/4
 Wa5w==
X-Gm-Message-State: AOJu0Yw4yXP5W87dMoGSglhO3uAqZTjVypAaPYyTetDNK14qNNkmrbnO
 x5feyhKMGSGRtXaf6ro6u4eVXm4jlnNxwFVm4wud+k31/qxd72jZCIubn67NLhAwF6A=
X-Gm-Gg: AY/fxX6CPEe/5L6pLWimSKkDqrrPymvfZ5gzwwNEcCmq7are/dQsReHlLo+1yy3aQIt
 VDQwBy6SRNm6qL/Qifk9buaPOWf14GB72xtiXDPXfaADLuOs2azLEJD4ZkwD6gNLsdMyixZPL0V
 VhoGauMEgcyCtR66RahrHWRnm960vx5wlCzV+82RxcTHghRNFR6HvOTPFJYlngIJ7X1/OlOhn5x
 42PTFUaXlrnRoueNNeIwobGkNUqPQYgUbDM07qlbZ836PvoF0iUndlWq5n3bQ8iXqcJpFjdTDn5
 EV0pfX19tbKE0RapEhoFTlSV90uGuQRArdje0acaZSEPVanlW3NiptB5pbFI/5CvzxOX/rkt8CH
 eKZX1UbYUKFMSZJAaNTEkH9cLkHtO69oXPbqjxj7K/rNg65bvlKFmV0ohWXdha155Rt9wFzM0+g
 NlyDZiGajzQDq36qPKG2qGvjvVlPe5WzaGAstrxfFoqwRO0Ma+0VeHJA6CSbTmy2c=
X-Google-Smtp-Source: AGHT+IHh3+DtMDmnj4gEVwOCMI+JQIW6sqilBGBKT0UijcvowK71I3n5z9bdNzjxzBrA/pVfo0+12A==
X-Received: by 2002:a17:907:25c4:b0:b83:15cb:d491 with SMTP id
 a640c23a62f3a-b844541e387mr1570908166b.53.1768177934797; 
 Sun, 11 Jan 2026 16:32:14 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56962esm1794515366b.66.2026.01.11.16.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 16:32:14 -0800 (PST)
Date: Sun, 11 Jan 2026 16:32:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/5] net/zxdh: add support some new features
Message-ID: <20260111163209.29cd944f@phoenix.local>
In-Reply-To: <20260105071643.1119116-1-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20260105071643.1119116-1-wang.junlong1@zte.com.cn>
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

On Mon,  5 Jan 2026 15:16:38 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> V2:
>   - add updated release note and the documentation.
>   - remove unnecessary initialization.
>   - using the compiler builtins(__rte_clz32).
>   - remove C++ style comments.
>=20
> V1:
>   - support modifying queue depth.
>   - optimeze alloc queue resources.
>   - support set link speed.
>   - support primary/secondary process.
>   - support GENEVE TSO/chksum,and tunnel packets outer udp chksum.
>=20
> Junlong Wang (5):
>   net/zxdh: add support for modifying queue depth
>   net/zxdh: optimize alloc queue resources
>   net/zxdh: add support set link speed get autoneg stats
>   net/zxdh: add support primary/secondary process
>   net/zxdh: add support GENEVE TSO and Rx outer chksum
>=20
>  doc/guides/rel_notes/release_26_03.rst |   7 +
>  drivers/net/zxdh/zxdh_common.c         |  75 ++------
>  drivers/net/zxdh/zxdh_common.h         |   2 +-
>  drivers/net/zxdh/zxdh_ethdev.c         | 239 +++++++++++++++++--------
>  drivers/net/zxdh/zxdh_ethdev.h         |  23 ++-
>  drivers/net/zxdh/zxdh_ethdev_ops.c     | 165 +++++++++++++----
>  drivers/net/zxdh/zxdh_ethdev_ops.h     |  15 ++
>  drivers/net/zxdh/zxdh_msg.c            |  52 ++++++
>  drivers/net/zxdh/zxdh_msg.h            |  24 ++-
>  drivers/net/zxdh/zxdh_pci.h            |   2 +
>  drivers/net/zxdh/zxdh_queue.c          | 134 +++++++++++---
>  drivers/net/zxdh/zxdh_queue.h          |  12 +-
>  drivers/net/zxdh/zxdh_rxtx.c           | 116 +++++++++---
>  drivers/net/zxdh/zxdh_tables.h         |  12 +-
>  14 files changed, 651 insertions(+), 227 deletions(-)
>=20

I did not do detailed manual review yet, but did use this as a test subject
patch for using Claude Opus 4.5 to review. This is using the recently
posted AGENTS.md as guidelines.

Do not get too worried. We are not going to switch to automated only
patch review. And everything it reported is something that is a big issue.
For example, the AGENTS.md file needs update to inform AI review that
C11 is allowed (even preferred) in DPDK.

https://claude.ai/public/artifacts/a9bc2f1d-46bf-4bb2-8f8c-886ed8fc9730

The result was:

# DPDK Patch Review: bundle-1621-zxdh-v2

**Series:** net/zxdh improvements v2 =20
**Author:** Junlong Wang <wang.junlong1@zte.com.cn> =20
**Patches:** 5 =20
**Date:** Mon, 5 Jan 2026 =20

---

## Summary

| Patch | Subject | Verdict |
|-------|---------|---------|
| 1/5 | add support for modifying queue depth | =E2=9A=A0=EF=B8=8F Minor is=
sues |
| 2/5 | optimize alloc queue resources | =E2=9A=A0=EF=B8=8F Minor issues |
| 3/5 | add support set link speed get autoneg stats | =E2=9D=8C Subject gr=
ammar issue |
| 4/5 | add support primary/secondary process | =E2=9A=A0=EF=B8=8F Minor is=
sues |
| 5/5 | add support GENEVE TSO and Rx outer chksum | =E2=9A=A0=EF=B8=8F Min=
or issues |

---

## Patch 1/5: net/zxdh: add support for modifying queue depth

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject length =E2=89=A460 chars | =E2=9C=85 Pass | 47 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Proper prefix | =E2=9C=85 Pass | `net/zxdh:` |
| Imperative mood | =E2=9C=85 Pass | "add support" |
| Body wrapped at 75 chars | =E2=9C=85 Pass | |
| Signed-off-by present | =E2=9C=85 Pass | |

### Code Review

**Warning: Missing space before `{` in conditional**
```c
// Line in zxdh_queue.c
if (dev->data->nb_tx_queues !=3D hw->tx_qnum ||
    valid_nb_desc !=3D hw->queue_conf->conf[queue_idx].tx_nb_desc){  // Mis=
sing space before {
```
Should be:
```c
    valid_nb_desc !=3D hw->queue_conf->conf[queue_idx].tx_nb_desc) {
```

**Info: Double blank line detected**
```c
+	return nb_desc;
+}
+
+
+int32_t
```
Two consecutive blank lines between functions - DPDK style typically uses o=
ne blank line.

**Style: Variable declaration after code**
```c
+int32_t
+zxdh_rx_queue_config(struct rte_eth_dev *dev, uint16_t queue_idx)
+{
    // ... code ...
+	struct rte_eth_rxconf *rx_conf =3D &hw->queue_conf->conf[queue_idx].zxdh_=
rx_conf;
```
In C89/DPDK style, variable declarations should typically be at the start o=
f the block.

---

## Patch 2/5: net/zxdh: optimize alloc queue resources

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject length =E2=89=A460 chars | =E2=9C=85 Pass | 40 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Proper prefix | =E2=9C=85 Pass | |
| Body wrapped at 75 chars | =E2=9C=85 Pass | |
| Signed-off-by present | =E2=9C=85 Pass | |

### Code Review

**Warning: Magic number usage**
```c
+	if ((ph_chno) >=3D  ZXDH_QUEUES_PCIEID_SIZE) {
```
Good use of named constant.

**Info: Parentheses around `ph_chno` are unnecessary**
```c
if ((ph_chno) >=3D  ZXDH_QUEUES_PCIEID_SIZE)
```
Could simplify to:
```c
if (ph_chno >=3D ZXDH_QUEUES_PCIEID_SIZE)
```

**Info: Double space detected**
```c
if ((ph_chno) >=3D  ZXDH_QUEUES_PCIEID_SIZE)
              ^^
```

---

## Patch 3/5: net/zxdh: add support set link speed get autoneg stats

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject length =E2=89=A460 chars | =E2=9C=85 Pass | 54 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Proper prefix | =E2=9C=85 Pass | |
| **Grammar** | =E2=9D=8C Fail | Missing "for" and "and" |
| Signed-off-by present | =E2=9C=85 Pass | |

**Error: Subject line grammar issue**

Current:
```
net/zxdh: add support set link speed get autoneg stats
```

Should be:
```
net/zxdh: add support for setting link speed and getting autoneg stats
```
or shorter:
```
net/zxdh: add link speed set and autoneg get support
```

### Code Review

**Warning: Inconsistent return type initialization**
```c
-	int32_t ret =3D 0;
+	int32_t ret;
```
Changed from initialized to uninitialized in `zxdh_dev_link_update`. This i=
s fine but should be consistent across the codebase.

**Info: Switch without default case comment**
The switch in `zxdh_speed_mode_to_spm` has a default case, which is good.

---

## Patch 4/5: net/zxdh: add support primary/secondary process

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject length =E2=89=A460 chars | =E2=9C=85 Pass | 47 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Proper prefix | =E2=9C=85 Pass | |
| **Grammar** | =E2=9A=A0=EF=B8=8F Warning | Missing "for" |
| Signed-off-by present | =E2=9C=85 Pass | |

**Warning: Subject line grammar**

Current:
```
net/zxdh: add support primary/secondary process
```

Suggested:
```
net/zxdh: add support for primary/secondary process
```

### Code Review

**Good: Proper secondary process handling**
```c
+	if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY) {
+		eth_dev->dev_ops =3D &zxdh_eth_dev_secondary_ops;
+		ZXDH_VTPCI_OPS(hw) =3D &zxdh_dev_pci_ops;
+		return 0;
+	}
```
Correctly limits secondary process to read-only operations.

**Info: Removed extern declaration**
```c
-extern struct zxdh_net_hdr_dl g_net_hdr_dl[RTE_MAX_ETHPORTS];
```
Good cleanup by moving to per-device structure.

---

## Patch 5/5: net/zxdh: add support GENEVE TSO and Rx outer chksum

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject length =E2=89=A460 chars | =E2=9C=85 Pass | 52 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Proper prefix | =E2=9C=85 Pass | |
| **Grammar** | =E2=9A=A0=EF=B8=8F Warning | Missing "for" |
| Case-sensitive terms | =E2=9C=85 Pass | `Rx` is correct (per words-case.t=
xt) |
| Signed-off-by present | =E2=9C=85 Pass | |

**Warning: Subject line grammar**

Current:
```
net/zxdh: add support GENEVE TSO and Rx outer chksum
```

Suggested:
```
net/zxdh: add support for GENEVE TSO and Rx outer checksum
```

### Code Review

**Good: Release notes updated**
```c
+* **Updated ZTE zxdh ethernet driver.**
+
+  * Added support for modify queue depth.
+  * Optimized alloc queue resources.
+  * Added support for set link speed and get autoneg status.
+  * Added support for primary/secondary process.
+  * Added support for GENEVE-TSO and tunnel packet RX outer UDP chksum.
```
Documentation properly updated with new features.

**Warning: "RX" in release notes should be "Rx"**
```
+  * Added support for GENEVE-TSO and tunnel packet RX outer UDP chksum.
```
Per `words-case.txt`, should be `Rx` not `RX`.

**Info: Byte order handling**
Good use of `rte_be_to_cpu_16()` for network byte order conversion.

---

## Global Issues

### Missing Items

1. **No Cc: stable@dpdk.org** - If any of these patches fix bugs that shoul=
d be backported, they should include `Cc: stable@dpdk.org`

2. **No Fixes: tag** - If any patches fix regressions from previous commits=
, they need a `Fixes:` tag

### Code Style Issues Across Series

1. **Variable declarations mid-block** - Several patches declare variables =
after executable code, which can cause issues with older C standards

2. **Inconsistent spacing** - Some double spaces and missing spaces before =
braces

---

## Recommendations

### Must Fix (Errors)

1. **Patch 3/5**: Fix subject line grammar - "add support set link speed ge=
t autoneg stats" =E2=86=92 "add link speed and autoneg support"

### Should Fix (Warnings)

1. **Patch 1/5**: Add space before `{` in conditional statement
2. **Patch 4/5**: Subject grammar - add "for"=20
3. **Patch 5/5**:=20
   - Subject grammar - add "for"
   - Change "RX" to "Rx" in release notes

### Consider (Info)

1. Remove double blank lines between functions (Patch 1/5)
2. Remove unnecessary parentheses (Patch 2/5)
3. Fix double space typo (Patch 2/5)
4. Move variable declarations to block start for C89 compatibility

---

## Validation Commands

Before resubmitting, the author should run:

```bash
# Check commit messages
devtools/check-git-log.sh -n5

# Check patch format and forbidden tokens
devtools/checkpatches.sh *.patch

# Build validation
devtools/test-meson-builds.sh
```

---

## Verdict

**Series Status: Needs Minor Revision**

The patches are generally well-structured and follow DPDK conventions. The =
main issues are:
- Subject line grammar in patches 3, 4, and 5
- Minor code style issues (spacing, declarations)
- Case sensitivity in release notes ("RX" =E2=86=92 "Rx")

After addressing the grammar issues in the subject lines and the style issu=
es, this series should be ready for merge.
