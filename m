Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F29CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62BE140649;
	Mon, 18 May 2026 01:56:24 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 9FFE140653
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:23 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so1424258eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062183;
 x=1779666983; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dX+ITs0xNtHImKy77xzkdfQtIqVwKFZg032XqWOmLF8=;
 b=pyACDf3iKO1rplUxYBIm6f8dPd7T6FLMA2BIqrWmcWv0zkA/htUayzW/0onIO2pTyj
 7pTm6cKYdk+leZ+WGf/FoTq5p8c8J+m/Rp1o69pDiG38W+qS0QXaV/NEkTKY2L7VccVq
 jK5pGMQeioaoMjZbcKO9WwxoI8JXVcoiGesNqzLsP3eK97ensGWWpAjLTZ3yV5TAm+/I
 +jB+zjPEqCdRxIDx9HTZfXu7gyaN6RgAL9MSdGIYBvXjz+uESYuRQXiS/l/jenyOoUKB
 Hk9y8BzHSKyQOTD5gUl4wyVElhYt1S7gEvZ+FQ8kjex9stJxqp8AeittSXlejdUrSjGi
 cZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062183; x=1779666983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dX+ITs0xNtHImKy77xzkdfQtIqVwKFZg032XqWOmLF8=;
 b=lbfGGHgVuCfBLA5wk6aYmHqsX+/Q592WWXVG2cJArBW0nmTojT0fC66+qFVPB9VoYp
 v1EzTozOh6MXNID5+9kifLI+jzLsf2Vo8V5rC+gtOBFxLaz5BgXzqCU/Ob+hNVrvG2Pu
 sPjpwgOK55o+EXxtxNYSaXyAwB1Lq3+tvSOZ0hNr6o6Qjtkq7MXglMAoyiYtNXZ84sq5
 iqx+3TuWkrxLWBf0afvwLYNC2eb41QJvqf6stmBUSe1P/GRN7E0HktJ9r9lT8tyqGbHO
 PS1uSQv17yIMUqGHC8drlfbrJ6sfC2wLwfUm4gaWDKcNJwBMfJh8xNgU76cKIxLQMb0P
 szFg==
X-Gm-Message-State: AOJu0YwDohQ1vVP4oLI77pARZfyAe/FJTEVe6qyJScxo0X5I5NsXE7Ja
 06UFV5NrBdiMXmqp86qeFeFhj9S6eWPtLUNxqGFofjGLrzSu1fc35IwryAIM54OieYU=
X-Gm-Gg: Acq92OHJ/w/JqdzcqZ9vK5k7/SGzhqXzQCH+/bx5mpo//wU1Tb6IO4ML36KXDaDBVjA
 LlatZ1ZQFQu+1LOyIrj3A6K33AwSj4pd74EwUTpsLgLXo7OHvCU/KDxcO+2Mh8roQhNsF1Bdhop
 aldV5S7+28lmiACPaKUNAjzV6wwlMOdV1pluIIc5EaPqBQhmPwC56/FlGkMnFbye82T1qHb4q26
 WxqJy1eFk0awWhxnQLNWXboOarjdd5B1u4qF7ftwSXjB0rQANJ9hclW5tCgFZpTRuGUqib+uoiR
 WzQrvMYpBi2Vv9j2E+KDImMusGvDwCvdvWX2koLTqEQjPJ/ynp9S24NHe5K6M1R/wiPm6bytMj5
 eTA1uVr6iNEDO1YODuGfiCcxgSacEFqBs22Ln3qQMgVJyEofWBWvVENJ2xp3GT7BZNWtukb7vT+
 kVwFDvlN4n/7kL5vM5p43ErGcUUKaEu57pN517yVBhgxHhMQ==
X-Received: by 2002:a05:7301:1187:b0:303:e36d:b68e with SMTP id
 5a478bee46e88-303e36db6cdmr377436eec.23.1779062182602; 
 Sun, 17 May 2026 16:56:22 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:22 -0700 (PDT)
Date: Sun, 17 May 2026 16:50:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 14/20] net/txgbe: fix link stability for Amber-Lite
 backplane mode
Message-ID: <20260517165032.059933d3@phoenix.local>
In-Reply-To: <20260511103604.19724-15-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-15-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:56 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> The link was previously configured via firmware, but this approach
> resulted in unstable link behavior. To resolve the issue, re-add the
> PHY configuration flow directly into the driver.
>=20
> Fixes: ead3616f630d ("net/txgbe: support PHY configuration via SW-FW mail=
box")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

Lots of AI feedback here:


# Review of DPDK Patch: net/txgbe: fix link stability for 40G NIC

## Summary
This patch re-adds direct PHY configuration flow to the txgbe driver to fix=
 unstable link behavior on 40G NICs. The previous firmware-based configurat=
ion approach was causing link stability issues.

## ERRORS

### 1. Use-after-free risk in `txgbe_setup_phy_link_aml40`
**File:** `drivers/net/txgbe/base/txgbe_aml40.c:157-159`

```c
ret_status =3D txgbe_set_link_to_amlite(hw, speed);
rte_spinlock_unlock(&hw->phy_lock);

if (ret_status =3D=3D TXGBE_ERR_TIMEOUT)
    hw->link_valid =3D false;
```

The spinlock is unlocked before checking `ret_status`, but if another threa=
d modifies `hw->link_valid` between lines 158 and 160, the state becomes in=
consistent. The assignment to `hw->link_valid` should occur before unlockin=
g:

```c
ret_status =3D txgbe_set_link_to_amlite(hw, speed);
if (ret_status =3D=3D TXGBE_ERR_TIMEOUT)
    hw->link_valid =3D false;
rte_spinlock_unlock(&hw->phy_lock);
```

### 2. Missing error propagation in `txgbe_e56_rx_rd_second_code_40g`
**File:** `drivers/net/txgbe/base/txgbe_e56.c:1816`

The function declares `status =3D 0` and returns `status`, but never assign=
s a failure value even when qsort is called on potentially invalid data. If=
 the timeout in the preceding while loop is reached (line 1825), the SECOND=
_CODE array may contain incomplete data, but the function still returns suc=
cess.

### 3. Missing bounds check before array access
**File:** `drivers/net/txgbe/base/txgbe_e56.c:1831`

```c
median =3D ((N + 1) / 2) - 1;
*SECOND_CODE =3D RXS_BBCDR_SECOND_ORDER_ST[median];
```

If `N=3D5`, `median=3D2` which is valid. However, this code pattern is repe=
ated multiple times (lines 244, 1831, etc.) with `N` as a constant, so it's=
 safe. Nevertheless, adding `RTE_VERIFY(median < ARRAY_SIZE(RXS_BBCDR_SECON=
D_ORDER_ST))` would make intent explicit.

**Not flagging this as an error** since `N=3D5` is a fixed constant through=
out.

### 4. Timeout return without cleanup in `txgbe_e56_rxs_calib_adapt_seq_40G`
**File:** `drivers/net/txgbe/base/txgbe_e56.c:2475-2481`

```c
if (timer++ > PHYINIT_TIMEOUT) {
    rdata =3D 0;
    addr  =3D E56PHY_PMD_CFG_0_ADDR;
    rdata =3D rd32_ephy(hw, addr);
    set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
    wr32_ephy(hw, addr, rdata);
    return TXGBE_ERR_TIMEOUT;
}
```

The function has already configured many registers in the loop `for (i =3D =
0; i < 4; i++)` (starting line 2393). When a timeout occurs on lane 0-2, th=
e function returns immediately without restoring registers on the lanes tha=
t were successfully configured. This leaves the hardware in a partially con=
figured state. The cleanup should disable all lanes, not just the one that =
timed out.

## WARNINGS

### 1. Hardcoded timeout in multiple locations
**File:** `drivers/net/txgbe/base/txgbe_e56.c` (multiple locations)

The `PHYINIT_TIMEOUT` constant is used consistently, but the delays vary (1=
00=C2=B5s, 500=C2=B5s, 1000=C2=B5s, 10ms). For the 500=C2=B5s delay case (e=
.g., line 2478), `PHYINIT_TIMEOUT` iterations result in `PHYINIT_TIMEOUT * =
500=C2=B5s` total wait time. If `PHYINIT_TIMEOUT` is intended to be millise=
conds, the timeout duration becomes inconsistent across different polling l=
oops. Consider documenting what the timeout value represents (iterations? m=
illiseconds?) and using consistent delay granularity.

### 2. Potentially unreachable code after loop
**File:** `drivers/net/txgbe/base/txgbe_e56.c:2656`

```c
for (j =3D 0; j < 16; j++) {
    // ... ADC adaptation loop
}
/* g. Repeat #a to #f total 16 times */
```

The comment `/* g. Repeat #a to #f total 16 times */` appears *after* the l=
oop that already runs 16 times. This is documentation only, but could be co=
nfusing. The comment should be before the loop or removed.

### 3. Inconsistent use of `msleep` vs `usec_delay`
**File:** `drivers/net/txgbe/base/txgbe_e56.c`

The patch uses `msleep()` for delays >=3D 10ms (lines 181, 3029) and `usec_=
delay()` for shorter delays (line 1826). However, line 3029 uses `msleep(10=
)` for 10ms, while line 2707 uses no delay after setting a register. Consid=
er documenting the rationale for sleep vs busy-wait or using a consistent t=
hreshold.

### 4. Variable `bypass_ctle` hardcoded but declared as variable
**File:** `drivers/net/txgbe/base/txgbe_e56.c:2396`

```c
u32 bypass_ctle =3D true;
```

The variable `bypass_ctle` is declared as `u32` but assigned a boolean valu=
e, and it's never modified. Either:
- Change to `const bool bypass_ctle =3D true;` (preferred)
- Or document why it's a runtime variable despite being hardcoded

### 5. Missing validation of speed parameter in initialization functions
**File:** `drivers/net/txgbe/base/txgbe_e56.c:2206`

```c
if (speed =3D=3D TXGBE_LINK_SPEED_10GB_FULL || speed =3D=3D TXGBE_LINK_SPEE=
D_40GB_FULL) {
    CMVAR_SEC_LOW_TH =3D S10G_CMVAR_SEC_LOW_TH;
    // ...
} else if (speed =3D=3D TXGBE_LINK_SPEED_25GB_FULL) {
    // ...
} else {
    DEBUGOUT("Error Speed\n");
    return 0;  // Returns success despite error
}
```

The function returns 0 (success) when an invalid speed is passed, but logs =
"Error Speed". This should return an error code like `-EINVAL` or `TXGBE_ER=
R_PARAM`.

## INFORMATIONAL

### 1. Large function complexity
The function `txgbe_e56_rxs_calib_adapt_seq_40G` spans ~280 lines with deep=
ly nested loops (3-level nesting). Consider refactoring into smaller helper=
 functions for each calibration stage (ADC offset, ADC gain, interleaver ad=
aptation) to improve readability and maintainability.

### 2. Magic numbers without symbolic constants
**File:** `drivers/net/txgbe/base/txgbe_e56.c:2470`

```c
while (EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx0_st) !=3D 0x21 ||
```

The value `0x21` (POWERDN_ST) appears in multiple locations (lines 2470, 31=
45). This is already defined as `E56PHY_RX_POWERDN_ST` elsewhere. Use the s=
ymbolic constant consistently.

### 3. Duplicated initialization sequences
The 40G initialization in `txgbe_e56_cfg_40g` (lines 176-566) and the exist=
ing 10G/25G code share many similar register sequences. Consider extracting=
 common configuration patterns into helper functions to reduce code duplica=
tion and maintenance burden.

### 4. Temperature check frequency
**File:** `drivers/net/txgbe/base/txgbe_e56.c:2253-2256`

The temperature tracking sequence comment states "must be run before the te=
mperature drifts by >5degC" and recommends running every 100ms. However, th=
e patch doesn't add timer-based periodic execution=E2=80=94it only runs dur=
ing link setup. If temperature tracking is critical for stability, consider=
 documenting that the caller must invoke this periodically.

---

## Positive Observations
1. The patch correctly adds `hw->link_valid` checks in `txgbe_check_mac_lin=
k_aml40` to prevent reporting link up when PHY configuration fails (lines 5=
7-60, 80-81).
2. Error paths in timeout scenarios attempt cleanup by disabling RX (e.g., =
line 2477).
3. The use of median filtering for SECOND_CODE (lines 1829-1831) reduces no=
ise from asynchronous hardware updates=E2=80=94good defensive programming.
