Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9DAD25031
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 00:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64FF24028F;
	Mon, 12 Jan 2026 01:56:07 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 7FACE4013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 01:56:06 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso34992215e9.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768179366;
 x=1768784166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=zfy062v9Grk07/gvGJvFtL5QiXDflTXcmTTfuenqZUU=;
 b=H3ESiv2ehR6PlajEzel44al3oAz98jjKhWDG2AlHS58wit5SoVBSKZ8pOT0Gm6cRS5
 oSo5mYVBzmh5XRkrFulTWhWJPaCWXhxPsH78MgIa+Ymusx3T6LOJtC9nmxhFZsIJVn80
 GFUIs2UVW2PD0HtLL5OafOO6rEV8QFPCiFyexhOAZRiYVywaT++LqU0DnQXk87kAlUXv
 TtYUbapu53JEYgxuU0T6zo+UkyciYsCViIfMIVWeWSAehj3ewKcYaG3082OaItp4jYv4
 SMT04xKqGjuJD9pAT6l0YYYk0Mc8vo7qo7AIiuUp0zD7r/72n+HBBzNmt8VWeZWodqQn
 tqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768179366; x=1768784166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zfy062v9Grk07/gvGJvFtL5QiXDflTXcmTTfuenqZUU=;
 b=M0blCcBWR3X+lIoGAewHVQFgwQx7KnXkfr6Wd3QPKHlvnU/pUue8oH8L2sPuBaT4xf
 r3Y29i6tKBz+o8CT19Arq9yRIB/yhXJzNjtgE0xrNLxKlzrYz5gIVJ3YTrJ8KciTY7kG
 47h+VxUsOp6R2e4lEKRpKqy6WAfWYT7h4hUSzQBruUvuQX+ut1HrLTEv16ry0IY/eVnM
 mjYdtbh0UkLoKdE1i6tx7XVmrF73eQZknwiW3IP0jBGnKEsS723u1zKPnfy91dZMtI74
 Rber1aYJjSk9S5AiFVcZfKClnp2c8jSFwYS3HkqCLoMAmI1tURjFe548OKyL3hFKISZ/
 nm2w==
X-Gm-Message-State: AOJu0Yxx7FagDmL16P3p6aYeq9H+z9u/XqmQksAlJnlN2MSYhzjMoKBa
 3lRcbo/H1brATiElY7/XAFuzE4TGSQk7+78bhPt1TQveY0JfO6opy0iU4/49HgAHa1fDEuuuX9l
 PXYHi
X-Gm-Gg: AY/fxX5tV1Y2Co/5DRY4LtIdTrhRnl3Y3NUgliL1NwDZES0QymyOqCCwtU2sEscghE8
 MfeHhhQ0IuUped+8ZnPqGCa4rRr4A78ngiVykzJBZhkug2/rHdD7rxdHfucONjSQrEuhiNg6UP5
 neU74kcotthzVbOtGPqInkHQaIjr1eFBUokWHe7bJzFMv/nwQScS27QF9yTZVuVvlVmyCywwYKY
 jLNwCai2cd0lgMP/+w7Y019kymfHmLdoxIYZ5jmg7YarDaNUXML6QekbHFmXLDc61dmBdYgiPkC
 I+Daj2IG3MbuHd+MSY2Zu2jguwiLzpyHftgUQUOn3f5Dj12NpBpHXnDS1kDc/MPBVSdK6ku6wIW
 dHUVtcveG55O6Du9wzGrQLN2aIzO5tBZGIsgY2y3RWw/xi1+MoteZz6jbnJuGpAH4ufE15B6bX+
 DDqX193TqRxVY3FBR30VmAwbHWgXFH0UApg8pA8R377AeYPnjhLzstLFInLFp3eEw=
X-Google-Smtp-Source: AGHT+IGxc+hHlwrwz1hWJ981Hw9pd9Q+piD/uuTy3o/ArlTCOsX5yS3DSkljAwNkAtRlMULC7iW6sA==
X-Received: by 2002:a05:600c:83c7:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-47d84b52e31mr182657495e9.36.1768179365535; 
 Sun, 11 Jan 2026 16:56:05 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm320280005e9.5.2026.01.11.16.56.04
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 16:56:05 -0800 (PST)
Date: Sun, 11 Jan 2026 16:56:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v4 0/3] null pmd minor cleanup and add test
Message-ID: <20260111165601.5b49a621@phoenix.local>
In-Reply-To: <20260110172336.9859-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260110172336.9859-1-stephen@networkplumber.org>
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

On Sat, 10 Jan 2026 09:22:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This series adds small optimization to net/null and
> adds a unit test for null PMD.
>=20
> v4 - change parameters to packet burst
>=20
> Stephen Hemminger (3):
>   net/null: cleanup info_get
>   test: generate larger packet bursts
>   test: add a test for null PMD
>=20
>  app/test/meson.build              |   1 +
>  app/test/packet_burst_generator.c |  38 +-
>  app/test/packet_burst_generator.h |   4 +-
>  app/test/test_pmd_null.c          | 968 ++++++++++++++++++++++++++++++
>  drivers/net/null/rte_eth_null.c   |   9 +-
>  5 files changed, 994 insertions(+), 26 deletions(-)
>  create mode 100644 app/test/test_pmd_null.c
>=20

AI code review feedback:

Now let me provide a comprehensive review of these three patches according =
to the DPDK guidelines.

---

## DPDK Patch Review: null PMD changes (v4 1-3/3)

### Patch 1/3: `net/null: cleanup info_get`

**Commit Message:**
- =E2=9C=85 Subject line: 29 characters (=E2=89=A460 limit)
- =E2=9C=85 Format: `net/null: cleanup info_get` - correct prefix format
- =E2=9C=85 Lowercase after colon
- =E2=9C=85 No trailing period
- =E2=9C=85 `Signed-off-by:` present with real name and email
- =E2=9C=85 Body wrapped appropriately

**Code Review:**

| Severity | Issue |
|----------|-------|
| =E2=9C=85 Good | Removing redundant NULL checks - ethdev validates argume=
nts before calling driver callbacks |
| =E2=9C=85 Good | `UINT32_MAX` is cleaner than `(uint32_t)-1` |
| =E2=9C=85 Good | Removing `min_rx_bufsize =3D 0` since struct is zero-ini=
tialized |
| =E2=9C=85 Good | Combining declaration with initialization |

**Verdict: LGTM** - Clean, straightforward improvement.

---

### Patch 2/3: `test: generate larger packet bursts`

**Commit Message:**

| Severity | Issue |
|----------|-------|
| =E2=9A=A0=EF=B8=8F Warning | Subject prefix `test:` should be `app/test:`=
 per DPDK conventions |
| =E2=9C=85 Good | Subject =E2=89=A460 characters |
| =E2=9C=85 Good | Signed-off-by present |
| =E2=9C=85 Good | Body explains the rationale clearly |

**Code Review:**

| Severity | Issue |
|----------|-------|
| =E2=9A=A0=EF=B8=8F Warning | Line 245: `if (i !=3D (int)(nb_pkt_segs - 1)=
)` - awkward cast. Consider changing loop variable `i` to `uint16_t` to avo=
id mixed signed/unsigned comparison |
| =E2=84=B9=EF=B8=8F Info | The comment removal about `RTE_MAX_SEGS_PER_PKT=
` is good - the old comment was misleading (`nb_segs` is 16-bit, not 8-bit)=
 |

**Suggested fix for the cast:**
```c
// Either change loop variable:
for (uint16_t seg =3D 1; seg < nb_pkt_segs; seg++) {
    ...
    if (seg !=3D nb_pkt_segs - 1)

// Or keep int and compare differently:
if (i < nb_pkt_segs - 1)
```

---

### Patch 3/3: `test: add a test for null PMD`

**Commit Message:**

| Severity | Issue |
|----------|-------|
| =E2=9A=A0=EF=B8=8F Warning | Subject prefix `test:` should be `app/test:`=
 per DPDK conventions |
| =E2=9C=85 Good | Subject =E2=89=A460 characters |
| =E2=9C=85 Good | Signed-off-by present |

**Code Review:**

| Severity | Issue | Location |
|----------|-------|----------|
| =E2=9D=8C Error | **Wrong dependency in meson.build**: `'net_ring'` shoul=
d be `'net_null'` - the test uses null PMD, not ring PMD | `app/test/meson.=
build` |
| =E2=9D=8C Error | **Bug in `test_mbuf_setup_burst()`**: Setting `m->buf_l=
en =3D len` is incorrect. `buf_len` is the buffer size, not packet length. =
This corrupts the mbuf metadata and could cause memory corruption. Should o=
nly set `data_len` and `pkt_len`. | Lines 200-201 |
| =E2=9A=A0=EF=B8=8F Warning | Missing return value checks in `test_null_te=
ardown()` for `rte_eth_dev_stop()` and `rte_eth_dev_close()` | Lines 137-13=
8 |
| =E2=9A=A0=EF=B8=8F Warning | `test_null_mac_addr()` sets MAC but doesn't =
verify the change took effect | Lines 571-586 |
| =E2=84=B9=EF=B8=8F Info | Good use of `TEST_SKIPPED` for multi-threaded t=
est when insufficient lcores available |
| =E2=9C=85 Good | SPDX license identifier on first line |
| =E2=9C=85 Good | Copyright immediately follows SPDX |
| =E2=9C=85 Good | Proper include ordering (system =E2=86=92 DPDK =E2=86=92=
 local) |
| =E2=9C=85 Good | Comprehensive test coverage: basic RX/TX, stats, custom =
size, copy mode, no-rx mode, link status, RSS, RETA, MT |

**Critical fix needed in `test_mbuf_setup_burst()`:**
```c
static int
test_mbuf_setup_burst(struct rte_mbuf **bufs, unsigned int burst_size)
{
	unsigned int i;

	if (rte_pktmbuf_alloc_bulk(mp, bufs, burst_size) !=3D 0)
		return -1;

	for (i =3D 0; i < burst_size; i++) {
		struct rte_mbuf *m =3D bufs[i];
		uint16_t len;

		/* Choose random length between ether min and available space */
		len =3D rte_rand_max(rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN)
			+ RTE_ETHER_MIN_LEN;
		m->data_len =3D len;
-		m->buf_len =3D len;    /* ERROR: buf_len should not be modified! */
+		m->pkt_len =3D len;    /* Set total packet length */
	}
	return 0;
}
```

**Fix for meson.build:**
```python
-    'test_pmd_null.c': ['net_ring', 'ethdev', 'bus_vdev'],
+    'test_pmd_null.c': ['net_null', 'ethdev', 'bus_vdev'],
```

---

## Summary

| Patch | Status | Action Required |
|-------|--------|-----------------|
| 1/3 `net/null: cleanup info_get` | =E2=9C=85 Ready | None - LGTM |
| 2/3 `test: generate larger packet bursts` | =E2=9A=A0=EF=B8=8F Minor issu=
es | Consider prefix fix and cleaner loop variable |
| 3/3 `test: add a test for null PMD` | =E2=9D=8C Needs v5 | Fix `buf_len` =
bug, fix meson dependency |

The critical issues in patch 3/3 (the `buf_len` corruption bug and wrong me=
son dependency) should be fixed before merging.
