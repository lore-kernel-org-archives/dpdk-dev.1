Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAEFE7E0D0
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF9A34042C;
	Mon,  9 Feb 2026 20:07:37 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 20C2D402F2
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:07:36 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43767807da6so41288f8f.2
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770664056;
 x=1771268856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUIt8JKtHMlCK6k9yn+J43FQF/jfvW1ONA2goXxcJKM=;
 b=CUCpk1pz0H79+RoGWD4TR4LzIldpViEPkE3NEOzYCCXLZ8pbGEYHuCwsW5LgPHWmrE
 d//o2kZ+AqUCUBhMivO9EVqUImms7iNhKoq0QziqYwkx7NTV0xI2ua57Jd4JARBS6qo0
 DhrG9/iqQhprflZMNyiEzpp8fOO6coLrude4II2op9rRr1+D6PTZwkxhj5JLsxaqZ/EQ
 2Vri42fGicI47kLNPWTvQuj5MbY3LXsAUCJv1yyfUzqiy1CjCaj4yiuA45Z5M9FgxMDX
 jBeBmTgAcCawKf0CqqUFy2b4cm6o5VtIuvUFX2lJMthv4JxYuYDIUZmYKdrLEzsyhPXD
 MfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770664056; x=1771268856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SUIt8JKtHMlCK6k9yn+J43FQF/jfvW1ONA2goXxcJKM=;
 b=tlSELvqZDF112uHhEXofMc7rP/9Kt2pHNkZigQ9D2MW7+c8sfme48D0ml0ne40/DPq
 lVaMVU/pLESVtCmQQ3PvadZA4SS7oxcdYjknWrelsriv/cNhtR30vHdfN3Ud2qNshj3Z
 PHzXJjKaDt37cJNLhlLJJv/QDXRC09XvOvtOdbaMMPhpjtjsDlQsf0pw1E56s4mPkgGU
 gu2+b541Zt3fzzHnY/nXmPtD4dwxBTng1X7FgNHwIr8ZtCAOABqujWXXZ1yp8zEAyIE+
 A8VGqfhj+OTIt8CRj5yE7Ldh4LjgbTbNU8yHDrCA5EuAzEhEY03oZismuGi4j95WGC73
 uVPw==
X-Gm-Message-State: AOJu0Yz7pa3cbS7fcldj4JoRCpnRfp0+lV9kzLT31UgWU6QjjpVp7Cy4
 rimCOkep19TkYTn09Z8B2pPq1/OK5h+sgfisbwOV2spgHxr8Zkk7oo0EXunuxkbO7mFDzb6wfY6
 0Ovdi
X-Gm-Gg: AZuq6aLq0E7P3FtpCCLT/laSlC444/gVQ7BOfYuQ2nuVPMWA4QwiIKHgOlp0/0Rze6t
 5sGfvricZkOOn5m30Vp7+y2Ht9nxYUXmxz08SypE6HgLaLnlrRcDk9JdBzStp8NFnrBz91MMZKM
 KJo4wd2O29C7IC48qVNQDJfEG9GHdsxh6uH1A1tGhxa3nyc0L4vjnohE1GoxcFny8k7K5Yf4HbM
 +71Y6VBPurcrz8ChjuKk37bZg/vFkeNEYBXtHzqW1C8dpkVNR+bHrfltEc01zwlAL4yVkL39gvs
 Kqozi/BUHnPKt2CvfsGdstzkKFIaLU0zOcaT/Fo3xzudaCP/Vek/gDN3y7Bm+mAOnhndYUDHz9f
 71gotVUYRSooe6SP5g07EuMhEZ4ISUDbxkXuPjc5rQ+1UBuenJdMg6cobVaCTDZKm2k+6/abSK6
 O8/qOrfspbOi1LkdL/f1pByw0waWzb8BF8x8p1GcpqTZ0l3HsuKbnykOIxI6piLOM=
X-Received: by 2002:adf:f5d0:0:b0:436:3475:473e with SMTP id
 ffacd0b85a97d-43634754869mr9498083f8f.51.1770664055609; 
 Mon, 09 Feb 2026 11:07:35 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa41sm31541256f8f.23.2026.02.09.11.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:07:35 -0800 (PST)
Date: Mon, 9 Feb 2026 11:07:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v17 01/13] net/sxe: add base driver directory and doc
Message-ID: <20260209110731.02dc494b@phoenix.local>
In-Reply-To: <20260209012458.506200-1-liujie5@linkdatatechnology.com>
References: <20260208115626.146863-13-liujie5@linkdatatechnology.com>
 <20260209012458.506200-1-liujie5@linkdatatechnology.com>
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

On Mon,  9 Feb 2026 09:24:46 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
>=20
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Next time please add a cover letter to large patch sets.

The AI review identified a long list of this that need changing.

# Review: [PATCH v17 01-13/13] net/sxe: Linkdata SXE NIC driver

## Errors

### 1. Patch 02 =E2=80=94 `sxe_dev_configure()`: uninitialized return value

`sxe_ethdev.c` declares `s32 ret;` and immediately falls through to `l_end:=
 return ret;` without ever assigning `ret`. This returns an indeterminate v=
alue to the caller.

```c
static s32 sxe_dev_configure(struct rte_eth_dev *dev)
{
    s32 ret;
    /* ... */
    PMD_INIT_FUNC_TRACE();

l_end:
    return ret;  /* ret never assigned */
}
```

**Fix:** Initialize `ret =3D 0` or assign it from a meaningful operation.

---

### 2. Patch 02 =E2=80=94 `sxe_hdc_cmd_process()`: all error codes silently=
 overwritten

At label `l_ret:`, the line `ret =3D pthread_sigmask(SIG_SETMASK, &old_mask=
, NULL);` unconditionally overwrites `ret`. Every error path in this functi=
on (sem_wait failure, retry loop exhaustion, packet trans errors) reaches `=
l_ret` and has its error code replaced with the return value of `pthread_si=
gmask` (typically 0). The subsequent check `if (ret =3D=3D -SXE_HDC_RETRY_E=
RR)` is then dead code.

This means the HDC command channel silently swallows all errors and reports=
 success to callers.

```c
l_up:
    sem_post(sxe_hdc_sema_get());
l_ret:
    ret =3D pthread_sigmask(SIG_SETMASK, &old_mask, NULL);  /* overwrites e=
rror */
    if (ret)
        LOG_ERROR_BDF("...");

    if (ret =3D=3D -SXE_HDC_RETRY_ERR)  /* dead code */
        ret =3D -EFAULT;

    return ret;
```

**Fix:** Save the original `ret` before restoring the signal mask and retur=
n it:
```c
l_up:
    sem_post(sxe_hdc_sema_get());
l_ret:
    if (pthread_sigmask(SIG_SETMASK, &old_mask, NULL) !=3D 0)
        LOG_ERROR_BDF("...");

    if (ret =3D=3D -SXE_HDC_RETRY_ERR)
        ret =3D -EFAULT;

    return ret;
```

---

### 3. Patch 13 =E2=80=94 `sxevf_dev_stop()`: stop flag set to wrong value

The function sets `adapter->stop =3D false` when the device is being stoppe=
d. This should be `true`. The guard at the top `if (adapter->stop)` will th=
erefore never trigger, and the device is never marked as stopped.

```c
static s32 sxevf_dev_stop(struct rte_eth_dev *dev)
{
    ...
    if (adapter->stop) {
        LOG_INFO_BDF("eth dev has been stopped.");
        goto l_out;
    }

    adapter->stop =3D false;  /* BUG: should be true */
```

**Fix:** `adapter->stop =3D true;`

---

### 4. Patch 04 =E2=80=94 `sxe_dev_start()`: unsupported loopback mode leak=
s resources

After `sxe_rx_configure()`, `sxe_irq_configure()`, and `sxe_txrx_start()` h=
ave all run, an unsupported `lpbk_mode` value causes a `goto l_end` that sk=
ips the `l_error` cleanup path. This leaks IRQ vectors and queue resources.

```c
    sxe_txrx_start(dev);
    ...
    } else {
        ret =3D -ENOTSUP;
        PMD_LOG_ERR(INIT, "unsupported loopback mode:%u.",
                dev->data->dev_conf.lpbk_mode);
        goto l_end;  /* should be goto l_error */
    }
```

**Fix:** Change `goto l_end` to `goto l_error`.

---

### 5. Patch 02 =E2=80=94 `hdc_packet_send()` / `hdc_resp_data_rcv()`: unal=
igned 32-bit memory access

Both functions cast arbitrary byte-offset pointers to `u32 *` and dereferen=
ce them:

```c
pkg_data =3D *(u32 *)(data + offset);     /* hdc_packet_send */
*(u32 *)(out_data + offset) =3D pkt_data; /* hdc_resp_data_rcv */
```

If `data`/`out_data` is not 4-byte aligned, this causes undefined behavior =
and may fault on ARM (ARMv8 is listed as a supported architecture in `sxe.i=
ni`).

**Fix:** Use `memcpy` for these accesses, or use `rte_le_to_cpu_32`/`rte_cp=
u_to_le_32` with `memcpy`.

---

### 6. Patch 02 =E2=80=94 `sxe_fw_time_sync()`: error silently dropped

The return value from `sxe_fw_time_sync_process()` is stored in `ret_v` but=
 the function returns `ret` which remains 0 on this path, so the caller nev=
er sees the failure.

```c
    ret_v =3D sxe_fw_time_sync_process(hw);
    if (ret_v) {
        LOG_WARN_BDF("fw time sync failed, ret_v=3D%d", ret_v);
        goto l_ret;
    }

l_ret:
    return ret;  /* ret is still 0 */
```

**Fix:** Use `ret` instead of `ret_v`, or set `ret =3D ret_v` before the go=
to.

---

## Warnings

### 1. Patch 04 =E2=80=94 Subject line contains commas

"net/sxe: add link, flow ctrl, mac ops, mtu ops function" =E2=80=94 commas =
are forbidden punctuation in DPDK subject lines per `check-git-log.sh`. Con=
sider splitting this patch or rephrasing (e.g., "net/sxe: add link and mac =
layer operations").

---

### 2. Patch 02 =E2=80=94 Commit message body contains non-ASCII characters

"Add basic modules: logs=E3=80=81 hardware communication=E3=80=81common com=
ponents" =E2=80=94 the `=E3=80=81` characters are Chinese punctuation (U+30=
01). Use standard ASCII commas.

---

### 3. Patch 01 =E2=80=94 Release note says "Updated" for a new driver

The release note reads `**Updated Linkdata sxe ethernet driver.**` but this=
 is a new driver, not an update. It should use the `**Added**` or `**New**`=
 convention (e.g., `**Added Linkdata sxe ethernet driver.**`), matching the=
 `New Features` section it's placed in.

---

### 4. Patch 02 =E2=80=94 `rte_zmalloc()` used for control-path temporary b=
uffers

In `sxe_driver_cmd_trans()`, `rte_zmalloc()` allocates temporary HDC reques=
t/response buffers. These don't need hugepage memory (no DMA, no shared-mem=
ory requirement). Standard `calloc()` would be faster and not consume limit=
ed hugepage resources.

---

### 5. Patch 02 =E2=80=94 Global HDC semaphore shared across all PCI devices

`g_hdc_sem` is a single global semaphore. All SXE PFs serialize HDC firmwar=
e commands through it. If multiple SXE NICs are present, they will unnecess=
arily block each other. Consider a per-device semaphore.

---

### 6. Patch 02 =E2=80=94 `sxe_irq_vec_free()` directly accesses `handle->i=
ntr_vec`

The function directly accesses `handle->intr_vec` instead of using the DPDK=
 interrupt API (`rte_intr_vec_list_free()`). Direct field access may break =
with future DPDK versions where the interrupt handle is opaque.

---

## Info

- The series is at v17, indicating extensive prior review. The overall stru=
cture follows DPDK PMD conventions with proper SPDX headers, meson integrat=
ion, feature documentation, and release notes.
- The base `sxe_hw.c` at ~6200 lines is large for a single file. Consider s=
plitting register-group definitions from operational logic if practical.
- Several functions across the series have unused variables (e.g., `pci_dev=
` in `sxe_dev_infos_get` in patch 02, `link`/`num` declared early in `sxe_d=
ev_stop` in patch 02). These will generate compiler warnings with `-Wunused=
-variable` depending on `#ifdef` configurations.
