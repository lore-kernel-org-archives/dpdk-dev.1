Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51284D25031
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 01:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3903B40684;
	Mon, 12 Jan 2026 02:03:58 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 2BD1B4028F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 02:03:57 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so8630271a12.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768179836;
 x=1768784636; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plBekXvekZGlBjolRQ+F4I427YZxK8vX5fSngHe6XwI=;
 b=yvXCW2JJYc+aGIFLkhNyKKs3TDsEqwy2swePJVOCc6FtqqEdT9lAPONS8E7QpSr5Tg
 TKWbW7btLirAaveHLWjHfk5lg10u/liulkyYs7qPA+PwIlnsJS0A6j6BGOIX8I7spFNr
 AOTG+n/j+v9TkeEKqlKKLD999RYzyedF/NhVfWzyvr47ehtWY+Bd1OM/RCggf7dBk41/
 A2HnG7iznOu3XnsuBBhQfConwmRKjDrDWzgWbnCrXIZ8FUxOsR2iPoBvWMcDyMUSEfKF
 /f/jcllkajS4NpJPwJ93JkduwNMHP5BDxp8YQM0tmW+dF1Ie2Djzuckc9PKJD+O6swNU
 o0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768179836; x=1768784636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plBekXvekZGlBjolRQ+F4I427YZxK8vX5fSngHe6XwI=;
 b=hMaHzoKicfMAbFRkCi4Ft9ypTVydVO3LJDfeqlghO74Ydj9c7wPdsUudpE8i+C6gtc
 dJQnyz35d7KD0QFAWD80MGvxstj3e0iTL5zHYkLpKzy8b2ZEJNoc7toTb0XwoLJdXOXp
 SF+UH7O5jMDaYRbvJ5RkuRYi0IOEGpUWIoJZlvSi71esZtJMw7QasFNl4kSobgY7wgfo
 l2sdqgQGbei+TNSn6tLB9Ilf3I9IYxsMVyz3zh3dkMNKzoESY7E1dnhACEA12U8svYC+
 zjiFdCyrQpp556DBzDOv/yqwaUHKZFMB0eIV6WKih/yZ76VlzXsfmaVa9l0fKEspf9F4
 Y4ww==
X-Gm-Message-State: AOJu0YxTGlJHb0hZSY0cG8zyr6V5rhstBwbKteUqZ/hN7kG5z13HZJsT
 6KOZG2lmDULxbwKCA+hxm4ESsygELRWBdg43oTS569H321Ttj3B060PReW42efJQkLU=
X-Gm-Gg: AY/fxX5OqN6hSBDTbTlLUlh5jlKmNM+eEkHIl0bY8Rmj1AeThKE838jPo35gl/KH7qE
 80jmhr34hkB+0J8kXbpxkUqgLptRJcqcwysvPr/W5dri0LyqWCy3nx/c425gignPBSDoejjnEzx
 +DVxxPxEjfko0FPAZAkL7MPIFNCnb6XAcbk3mYu6ZMPDSSFf8b1JYJM7Zk7nnjdLMMpD23Md+mF
 ODu6mqZRadjuY6R7f+YQ2pIShNqVcmrTLAFVPraXw4IsrJIk6HqEyOynQr5wN9T+EMa0HXr0tej
 08eCF3KZwtMvRhPz98gsieDvwmcalYCLdutwF0l+HUFsg2p8PqHMsG/D1xuJtkAHJF+enkke1uK
 97h6pNES61jWP/CHX8lyl3WJojEkDjDZFzy8osNchB3gIxR5IV/ig7TvK7b/swZl+4p7IfXJHzO
 qoMhOZIolkE1ykHQ9KWWcEaQydJ35hVRBx0pRgiOvDtfdDNEACrC2VDXpiona40Fc=
X-Google-Smtp-Source: AGHT+IG8CZe/l+kmzY4FfUGud0aj6HaaiOjkBuAfVT9z5H+eUIKkvBgEv410jt9DdGZ7CWZV/cC+bw==
X-Received: by 2002:a17:907:c06:b0:b87:2410:5957 with SMTP id
 a640c23a62f3a-b8724105b20mr48232566b.48.1768179836533; 
 Sun, 11 Jan 2026 17:03:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27c0casm1775021166b.19.2026.01.11.17.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 17:03:56 -0800 (PST)
Date: Sun, 11 Jan 2026 17:03:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>,
 Maryam Tahhan <mtahhan@redhat.com>, Xiaolong Ye <xiaolong.ye@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH] net/af_xdp: fix external mbuf transmit
Message-ID: <20260111170350.6fa88e03@phoenix.local>
In-Reply-To: <20260105125441.50447-1-david.marchand@redhat.com>
References: <20260105125441.50447-1-david.marchand@redhat.com>
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

On Mon,  5 Jan 2026 13:54:41 +0100
David Marchand <david.marchand@redhat.com> wrote:

> A mbuf may be pointing at external buffer like when forwarding a TSO
> packet coming from a vhost-user port in OVS (see
> RTE_VHOST_USER_EXTBUF_SUPPORT).
>=20
> Checking the mbuf mempool to trigger the zero copy optimisation is
> broken: the driver will (at best) read 0s or (at worse) crash when
> reading more data than what the direct buffer can contain.
>=20
> Fixes: d8a210774e1d ("net/af_xdp: support unaligned umem chunks")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Looks good to me and Claude ;-) but he has more to say.
Queued to next-net

## DPDK Patch Review: net/af_xdp: fix external mbuf transmit

### Summary

This patch fixes a bug in the AF_XDP driver's zero-copy transmit path where=
 mbufs pointing to external buffers (e.g., from vhost-user with `RTE_VHOST_=
USER_EXTBUF_SUPPORT`) could cause data corruption or crashes. The fix adds =
an `RTE_MBUF_DIRECT()` check before using the zero-copy optimization.

---

### Commit Message Review

| Criterion | Status | Details |
|-----------|--------|---------|
| Subject length | =E2=9C=93 Pass | 38 characters (limit: 60) |
| Subject format | =E2=9C=93 Pass | `net/af_xdp:` prefix is correct for dri=
ver |
| Subject case | =E2=9C=93 Pass | Lowercase after colon |
| Imperative mood | =E2=9C=93 Pass | "fix" not "fixes" or "fixed" |
| No trailing period | =E2=9C=93 Pass | |
| Body line wrap | =E2=9C=93 Pass | All lines under 75 characters |
| Body doesn't start with "It" | =E2=9C=93 Pass | Starts with "A mbuf" |
| `Fixes:` tag | =E2=9C=93 Pass | 12-char SHA: `d8a210774e1d` |
| `Cc: stable@dpdk.org` | =E2=9C=93 Pass | Present for bug fix |
| `Signed-off-by:` | =E2=9C=93 Pass | Present with real name and email |
| Tag order | =E2=9C=93 Pass | Fixes =E2=86=92 Cc =E2=86=92 blank line =E2=
=86=92 Signed-off-by |

---

### Code Review

**Change location:** `drivers/net/af_xdp/rte_eth_af_xdp.c`, line 608 (in `a=
f_xdp_tx_zc()`)

```c
// Before:
if (mbuf->pool =3D=3D umem->mb_pool) {

// After:
if (RTE_MBUF_DIRECT(mbuf) && mbuf->pool =3D=3D umem->mb_pool) {
```

| Criterion | Status | Details |
|-----------|--------|---------|
| Line length | =E2=9C=93 Pass | Well under 100 characters |
| Macro naming | =E2=9C=93 Pass | `RTE_MBUF_DIRECT` uses correct `RTE_` pre=
fix |
| Technical correctness | =E2=9C=93 Pass | Properly gates zero-copy path |
| Minimal change | =E2=9C=93 Pass | Single-line fix, targeted |

#### Warning (Minor)

**Implicit boolean comparison:** The `RTE_MBUF_DIRECT(mbuf)` macro returns =
an integer-like value (0 or non-zero). Per DPDK guidelines, explicit compar=
ison with zero is preferred for integers:

```c
// Suggested (strict interpretation):
if (RTE_MBUF_DIRECT(mbuf) !=3D 0 && mbuf->pool =3D=3D umem->mb_pool) {
```

However, this macro is semantically boolean and is commonly used in direct =
form throughout DPDK. This is a stylistic preference, not a blocking issue.

---

### Technical Analysis

The fix is correct. Looking at the `af_xdp_tx_zc()` function in the provide=
d source:

1. **The bug:** Line 624 in the original code only checks `mbuf->pool =3D=
=3D umem->mb_pool` to decide if zero-copy can be used. This fails for indir=
ect/external mbufs where `mbuf->buf_addr` points to external memory, not th=
e pool's memory region.

2. **The consequence:** When zero-copy is incorrectly triggered, `reserve_a=
nd_fill()` computes addresses relative to `umem->buffer`, which produces in=
valid addresses for external buffer data.

3. **The fix:** Adding `RTE_MBUF_DIRECT(mbuf)` ensures the mbuf data reside=
s in its own attached buffer, making the pool check meaningful.

4. **Fallback path:** When the check fails, the code correctly falls throug=
h to the else branch (lines 633-647) which allocates a local mbuf and perfo=
rms a copy.

---

### Verdict

| Severity | Count | Items |
|----------|-------|-------|
| **Error** | 0 | =E2=80=94 |
| **Warning** | 1 | Implicit boolean check on `RTE_MBUF_DIRECT()` |
| **Info** | 0 | =E2=80=94 |

**Recommendation:** **Accept** =E2=80=94 This is a well-crafted bug fix. Th=
e commit message is clear, properly attributed, and follows DPDK convention=
s. The code change is minimal, correct, and addresses a real crash/corrupti=
on scenario. The warning about implicit boolean comparison is minor and mat=
ches existing DPDK patterns.
