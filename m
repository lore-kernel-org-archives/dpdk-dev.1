Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2519EDA68D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D675F40E8A;
	Tue,  3 Mar 2026 16:42:16 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id EAE8840ED3
 for <dev@dpdk.org>; Tue,  3 Mar 2026 16:42:15 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-89a1347051aso5302496d6.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 07:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772552535;
 x=1773157335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw6DEqNyRGOrbtxWu5EjQrYbFTRM2xVc1rf01P+xFhg=;
 b=pGUJKYlp6Yuz1CmGnGyFuQQfktpuC0MaJLunlIAgpEdN6V7/kSzWvluRykwp7M0dsM
 osBEeXQUhgMOkXBwlZAR+AAy0cu52Zb0zOPjTDV85ihj7pkv5NVrB7fVNO3HTeGM8bH0
 gHgaQVmz+uSPoJ86LzTKrsmUc/LTDr/U/1pEuNN0zSbkQe/yyqQN8lpWbQfOzRoM78bL
 CoNUj1YDAFp1iaGloeOx8d9PX+G4VL3XrPQIkEVnQ+uFiEUt/NrktsQI3wJgcg6EIICg
 zczQIBFY4XCeo0i9ah8vjPpVVOsLLu3rQ7yiVduRP/NX3iZA7J+ZYj36woUT0qYIqIEj
 xPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772552535; x=1773157335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yw6DEqNyRGOrbtxWu5EjQrYbFTRM2xVc1rf01P+xFhg=;
 b=c7np/WVlP+ptA5mmDoMtpiWvOWryF6lMJBGMWZCEJtSYFDErbKvx/I6qCOMFSvjtgp
 VzvjvyhMHQdx1NkfOIF3AaP0jNLIrWL115/85pPurlrkVVjtt3yG+KulygRWaZQCA45m
 3855wUOI8lEUpUiFBFgGyZOkFs45a+mCD5X2Mzqa09sI9RDyK2LVDhPYvCd0K2u29/ay
 e431J5HGnURkaw3oHpnCMOgvDHRXw/nzrpXzaof8UwjTeocL/E/EjK9i5O1R8Z+dH/W0
 3x+cefOGiKcBCPw6vdPnm78fsNk7GLZMkGvsombJeO5ML12fFerVg0NhtErWinb4z34k
 nemA==
X-Gm-Message-State: AOJu0YxueYABJ+PApgYz+OtV+2VSsfdwhKgaNBYa3Mm3EI/+QXQMnU/B
 ym7KeYSi6lYQgqPy2pxMC/W1S25gnNwFWeyUpqrn6VPEKY1KeZ9ae3NTtgJdjZb4rgOoMjQ9WqG
 638AQ
X-Gm-Gg: ATEYQzwFML29zHZL6AUEFqtY76wkt9FRkRpdqfAiLI9StxI812Yg+DScRiFtkS95qzd
 M89BhMnw0MR67cEOMvus3Ws2CXaxFqhXyJUeBi6H4pi/T5vB7lWdIBOuRUNpa6RjdlKfHUjZzt7
 QItMgYRW4tAwDTfy5+CZDhXPbkuCRaRAkutSBhd1PdWjfd6X8kaWhCcAalL35uur20g7lgEd3si
 KVFpgtJyf8ub7UrWmj3q6DCsQhha7xEG4NTfmzWMZZOEtTFaiyOSmvxTpY4zX1PZKpiu6fBcyGL
 e1EKkNcSFsSo3K44I4OGz/DSUZ+tAWxd5APZNj3zlAmze/RyB+3MDaUcWBvtqCshzGGhtcu5vaY
 YhhhcwwScsk9t79qaZvBIXdvNXf1TjlkJs+/Pe7nRQVCOS74/QcC8RJ2xQidqkl6vruoNZddJy6
 2pdVqWIpyciZnsyHbNL02iNMpil2cV/+PjIU3Zjvhu/yICYhpCjMHF2FhVG0Sjpij/
X-Received: by 2002:a05:6214:528e:b0:88f:d4b1:4c2d with SMTP id
 6a1803df08f44-899d1e93553mr243493616d6.60.1772552535081; 
 Tue, 03 Mar 2026 07:42:15 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899ffdd4a41sm40833506d6.26.2026.03.03.07.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:42:14 -0800 (PST)
Date: Tue, 3 Mar 2026 07:42:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v18 00/13] net/sxe: added Linkdata sxe ethernet driver
Message-ID: <20260303074210.24a54a15@phoenix.local>
In-Reply-To: <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
References: <20260209012458.506200-13-liujie5@linkdatatechnology.com>
 <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
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

On Tue,  3 Mar 2026 17:10:44 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
>=20
> This patch set implements core functionality for the SXE PMD,
> including basic driver framework, data path setup, and advanced
> offload features (VLAN, RSS, DCB, PTP etc.).
>=20
> v18:
>  - Addressed AI comments

Thanks for the revision.  I still see some things which AI found
that are worth addressing.  Rather than bore you with the long
version here is the summary. Ask if you want more detail.


---

**Errors (must fix):**

1. **Bitwise vs logical AND** =E2=80=94 `sxe_hw.c`, `sxe_hw_uc_addr_pool_di=
sable()`: `if (!hi & !low)` should be `if (!hi && !low)`. Numerically equiv=
alent here but wrong operator.

2. **Off-by-one bounds check** =E2=80=94 `sxe_hw.c`, `sxe_hw_uc_addr_pool_e=
nable()`: uses `rar_idx > SXE_UC_ENTRY_NUM_MAX` but `sxe_hw_uc_addr_add()` =
correctly uses `>=3D`. One of them is wrong.

3. **Data race on global `sxe_trace_id`** =E2=80=94 `sxe_common.c`: `sxe_tr=
ace_id++` is called from `sxe_driver_cmd_trans()` before the HDC spinlock i=
s acquired. Multiple threads can race on this non-atomic increment.

4. **`#define false 0` / `#define true 1`** =E2=80=94 `sxe_compat_platform.=
h`: conflicts with `<stdbool.h>` which is included elsewhere. UB per C99 =
=C2=A77.1.3. Remove these and use `<stdbool.h>`.

5. **Spinlock held 2.5+ seconds** =E2=80=94 `sxe_pmd_hdc.c`, `sxe_hdc_cmd_p=
rocess()`: `rte_spinlock_t` (busy-wait) held across 250 retries =C3=97 10ms=
. Other lcores burn CPU spinning. Use a sleeping lock or release between re=
tries.

6. **Wrong length in multi-packet HDC response** =E2=80=94 `sxe_pmd_hdc.c`,=
 `hdc_resp_process()`: passes total `resp_len` to `hdc_resp_data_rcv()` for=
 every packet instead of `resp_len - offset`. The last-dword partial-copy (=
`out_len % 4`) logic is wrong for packets after the first.

7. **MAINTAINERS name/email mismatch** =E2=80=94 Lists "Jie Li <lijie@...>"=
 but all patches are from "Jie Liu <liujie5@...>". Different person and dif=
ferent address.

8. **Double hardware reset in `sxe_dev_close()`** =E2=80=94 Calls `sxe_hw_r=
eset()` directly, then calls `sxe_dev_stop()` which calls `sxe_hw_reset()` =
again. Second reset may fail since HDC channel state was already altered.

---

**Warnings (should fix):**

1. **`set_bit`/`clear_bit`/`test_and_clear_bit` are not atomic** =E2=80=94 =
`sxe_compat_platform.h`: plain read-modify-write on `int *`. If used from m=
ultiple threads, these are racy.

2. **Non-const lookup tables in hot path** =E2=80=94 `sxe_rx.h`: `error_to_=
pkt_flags_map`, `ip_rss_types_map` should be `static const`.

3. **Dead code in `sxe_dev_configure()`** =E2=80=94 Unused variables `adapt=
er`, `irq` and unreachable `l_end` label.

4. **Misleading macro name** =E2=80=94 `SXE_USEC_PER_MS` is 1000000 (nanose=
conds per millisecond). Should be `SXE_NSEC_PER_MS`.

5. **`strlcpy` off-by-one** =E2=80=94 `sxe_hw_base_init()`: `strlcpy(adapte=
r->name, ..., sizeof(adapter->name) - 1)` wastes one byte. `strlcpy` alread=
y null-terminates; pass `sizeof(adapter->name)`.

6. **`sxe_fw_version_get`** =E2=80=94 `resp.fw_version` from HDC `memcpy` m=
ay not be null-terminated. `snprintf` will read past the field.

7. **HDC channel lifecycle not multi-device safe** =E2=80=94 `sxe_hdc_chann=
el_init()` initializes a single global spinlock. `sxe_remove()` calls `sxe_=
hdc_channel_uninit()` =E2=80=94 if two SXE devices are probed, removing the=
 first destroys the channel while the second still uses it.

8. **Feature matrix overclaims** =E2=80=94 `sxe.ini` marks Traffic Manager,=
 Inline Crypto, MACsec, Rate Limitation as Y/P, but none of the 13 patches =
implement these features.

9. **`#ifdef __KERNEL__` dead code** =E2=80=94 `base/sxe_hw.c`, `base/sxevf=
_hw.c` contain thousands of lines of Linux kernel code paths. Strip before =
submission to DPDK.

10. **`sxe_vf_rss_rxq_num_validate` return value check is inverted** =E2=80=
=94 `sxe_queue.c`: `if ((rx_q_num <=3D ...) && sxe_vf_rss_rxq_num_validate(=
dev, rx_q_num))` =E2=80=94 the validate function returns 0 on success and n=
egative on error, but the `if` treats a truthy (error) return as the succes=
s path for entering the error log. The condition logic needs review.
