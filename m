Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED7FC72C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 23:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86F17402D6;
	Tue, 24 Mar 2026 00:42:12 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id CA84F4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 00:42:09 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c0c482e069so2650569eec.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774309329;
 x=1774914129; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVQhL9Av4qKrwD5xJcbG3gYYfZsKUct3+0Q83+7u7gM=;
 b=k3oougwwolW5IPn/bzisYVuxaidz1dvIJUvV2oAWXW04YZUGuuxfIKIrbp0lJaB0QY
 atw1bSMPe4eBV7gLX4sj0zSiBywJhxtU3m5pVS4A0wXX0/f9wA3ocYfR0egNiGimEC/V
 zMAsuMUfLRg0fuLwOzxzubej/GXPHgvjz/dUHZQnCmYTPg3CTT9Gf3eJW9f/W9TTEzj/
 6ngJV8rz0QMsggf94StJ34kYWMmGf/Iz2JjW/AuSHvkN9EbFoEP6QoWemilMLMRWmGrE
 37s/cRPSS2nDs+xsRjEYW3sxA6xwrxatVynWyxZRZK6S7yghGst2kFPl7Nk/7txmCV3Z
 X1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774309329; x=1774914129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jVQhL9Av4qKrwD5xJcbG3gYYfZsKUct3+0Q83+7u7gM=;
 b=f66zrocChaonz1zCpgCGKxUXiV9j/DurYPBNA8AptdHx/SUq5nUGO1uPs2rANg9a81
 qceukTogrzHrqAZnTghmGWL1agR3jiMOxrGOePdFMvRfBZ5wbXpoteSK40WXKUltwJYN
 gnomXotYEytrkjyzG3dsofCzba4y8D7LG752LOaYhvl2HNEc61JR7kutTWg/OU1KSQK1
 /NBq9ifN39cDUcreghJpkN9YmsLiMWOe20A8HiqNDnqVm/trbhWYNyeLlCUDBxElL4vq
 CGizW2cKgD5alQ7ixhADUqlsLYQ97UwZfz3J81LgEoJT4CmUKK0V+YxLumpF5HzmtNDW
 3ydg==
X-Gm-Message-State: AOJu0YyUYUMD3mjk2ZjcDTsjF+iq43Isby5S+KrliMLj5X1XdKtcprcU
 osD1kj4QtScumiyZ4WGhZo7oJXBgJa+w6VQUtHAXDjgjRrntzGqABT2FrEHIzfqczCE=
X-Gm-Gg: ATEYQzxI0FnqYd1Do135yHDjFC2mwcOoYhaanMH5vgGilU8ubd9BIq3Ir0xvMrCZHmq
 NXEqYKrDkmm+GB4EiA0WFZk9wKvIgpE6O/P/oVOZr4/kQxVpvUhKGQnk2OnYYoIgT8Geh7iHmSe
 uQ4FKU/SgO+oEDbkPwn9DIPjIbQAMudHODJy6GaBzbOtOq+Xc02GUPRqIgRjtD8jegCFrm8J7C9
 izLA9Eexj8NiG+zX4QZoAWMNfEwH8EqNq7apZ3e1u1WnbTj0Us72LpLP2U+Si4Jd430xjmj9Kto
 Womb/sDvHlco9ltPixPCQBxe4bkRn6tz1jY3YtVX0yVyJtaXGq9PwgjQZL9wdalgfCVx99FGwYU
 30m2JyY6XvcaVGEn+9rxZznSSikwL0JDNhzKfrK6AaT0fYSvgwYka4/dWfIbee6Ti3n0/NsASxh
 A+NvzNHl/shgBB5iyD0zLiN8uJFiZb8/xmyFINOVwkREiiTA==
X-Received: by 2002:a05:7301:2f8a:b0:2c0:c152:ecc7 with SMTP id
 5a478bee46e88-2c1096d57e7mr7316756eec.16.1774309328595; 
 Mon, 23 Mar 2026 16:42:08 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b17b90dsm17375443eec.10.2026.03.23.16.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 16:42:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:42:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <xavier.guillaume@ovhcloud.com>, <robin.l.lin@ericsson.com>
Subject: Re: [PATCH v5] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Message-ID: <20260323164205.0509775e@phoenix.local>
In-Reply-To: <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
References: <20260313091053.787521-1-sriram.yagnaraman@ericsson.com>
 <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
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

On Wed, 18 Mar 2026 10:47:26 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Enable jumbo frame reception with default mbuf data room size by
> chaining multiple mbufs when packet exceeds single mbuf tailroom.
>=20
> Scatter Rx is only enabled when RTE_ETH_RX_OFFLOAD_SCATTER is
> requested. Packets are dropped if they exceed single mbuf size
> and scatter is not enabled, or if mbuf allocation fails during
> chaining. Error counter rx_dropped_pkts tracks all drops.
>=20
> This allows receiving 9KB jumbo frames using standard 2KB mbufs,
> chaining ~5 segments per jumbo packet.
>=20
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

In general looks good, but AI review found some things.

Summary:

Thanks for the v5, Sriram. A few comments below.

1) pkt_len is uint16_t but tp_snaplen is __u32

The scatter helper also takes uint16_t data_len, so anything above 64KB sil=
ently truncates. For jumbo frames this is fine in practice, but the type mi=
smatch is a latent bug. Consider uint32_t for both, or at least a comment e=
xplaining why uint16_t is sufficient.

2) Scatter alloc failure should bump rx_nombuf, not just rx_dropped_pkts

When rte_pktmbuf_alloc() fails for a chained segment inside eth_af_packet_r=
x_scatter(), only rx_dropped_pkts is incremented. The head mbuf alloc failu=
re correctly bumps rx_nombuf. The scatter case is also a no-mbuf condition =
and should be reported as such, otherwise operators can't distinguish memor=
y pressure from oversized-packet drops in the stats.

3) Reclaiming headroom in chained segments

The prepend/zero-data_len/zero-pkt_len sequence works but is roundabout. Se=
tting m->data_off =3D 0 directly would be cleaner and avoid the intermediat=
e state where data_len is non-zero then immediately overwritten.

4) bufs[num_rx] fix looks correct

The change from bufs[i] to bufs[num_rx] fixes a pre-existing gap in the out=
put array when packets are dropped via continue. Good catch.

Overall the structure looks solid =E2=80=94 the scatter helper extraction i=
s clean, the goto-based frame release avoids the earlier use-after-free ris=
k, and the queue setup validation is correct.


Full detail:

## Review: [PATCH v5] net/af_packet: add multi-segment mbuf support for jum=
bo frames

### Error: `eth_af_packet_rx_scatter()` leaks chained mbufs on allocation f=
ailure

When `rte_pktmbuf_alloc()` fails inside the `while` loop, the function retu=
rns `-1`. The caller then calls `rte_pktmbuf_free(mbuf)` on the head mbuf. =
However, before the failure, previous iterations of the loop have already l=
inked allocated segments via `m->next`. The question is whether `rte_pktmbu=
f_free()` walks the chain =E2=80=94 it does, so segments linked before the =
failure *will* be freed. But there's a subtlety: `mbuf->nb_segs` is increme=
nted for each successfully chained segment, and `rte_pktmbuf_free()` uses `=
nb_segs` to walk the chain. Since `nb_segs` and the `->next` linkage are ke=
pt in sync, this is actually correct.

On closer inspection: **no leak here.** Disregard =E2=80=94 the caller's `r=
te_pktmbuf_free(mbuf)` correctly frees the entire chain. (Keeping this anal=
ysis transparent so you can verify the reasoning.)

### Error: `pkt_len` declared as `uint16_t` but `tp_snaplen` is `uint32_t` =
=E2=80=94 silent truncation

`ppd->tp_snaplen` is `__u32` in the kernel's `tpacket2_hdr`. The patch decl=
ares `pkt_len` as `uint16_t`:

```c
uint16_t pkt_len;
...
pkt_len =3D ppd->tp_snaplen;
```

For jumbo frames up to 9KB this works, but `tp_snaplen` can be up to 65535 =
(or larger with cooked sockets). If `tp_snaplen > 65535` this silently trun=
cates, and even values in the 32768=E2=80=9365535 range could cause issues =
if `pkt_len` is used in signed comparisons. More practically, the scatter h=
elper also takes `uint16_t data_len`, capping the maximum receivable packet=
 at 64KB.

Since this patch specifically targets jumbo frames (9KB), the practical ris=
k is low, but the type should match the source. Consider using `uint32_t` f=
or `pkt_len` and the `data_len` parameter of `eth_af_packet_rx_scatter()`, =
or at minimum add a bounds check / comment explaining why `uint16_t` is suf=
ficient.

### Error: `rte_pktmbuf_pkt_len(mbuf)` not set in the single-mbuf fast path=
 before VLAN reinsertion

In the patched code, the single-mbuf path sets `data_len` but defers settin=
g `pkt_len` until after the VLAN/timestamp block:

```c
if (pkt_len <=3D rte_pktmbuf_tailroom(mbuf)) {
    memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, pkt_len);
    rte_pktmbuf_data_len(mbuf) =3D pkt_len;
} else if (...) { ... }

rte_pktmbuf_pkt_len(mbuf) =3D pkt_len;

/* check for vlan info */
if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
    ...
    if (!pkt_q->vlan_strip && rte_vlan_insert(&mbuf))
```

`rte_vlan_insert()` reads `mbuf->pkt_len` to determine packet length. At th=
at point `pkt_len` has been assigned to `rte_pktmbuf_pkt_len(mbuf)` =E2=80=
=94 wait, looking again, `pkt_len` assignment is on the line *before* the V=
LAN block. Let me re-read the patch flow:

```
        } else { ... goto release_frame; }

        rte_pktmbuf_pkt_len(mbuf) =3D pkt_len;   // <-- this line

        /* check for vlan info */
```

Yes, `pkt_len` is set before the VLAN check. This is correct. Disregard.

### Warning: `rx_nombuf` not incremented on scatter allocation failure

In the original code, `rx_nombuf` is incremented when `rte_pktmbuf_alloc()`=
 fails for the head mbuf. In the scatter path, when `rte_pktmbuf_alloc()` f=
ails for a *chained* segment, only `rx_dropped_pkts` is incremented. This i=
s arguably a no-mbuf condition and should also increment `rx_nombuf` so tha=
t `rte_eth_stats.rx_nombuf` accurately reflects memory pressure. The curren=
t code makes it impossible to distinguish "dropped because too large and no=
 scatter" from "dropped because mbuf pool exhausted during scatter."

Suggested fix: increment `pkt_q->rx_nombuf` instead of (or in addition to) =
`rx_dropped_pkts` when scatter allocation fails.

### Warning: `rte_pktmbuf_prepend()` return value unchecked

In `eth_af_packet_rx_scatter()`:

```c
rte_pktmbuf_prepend(m, rte_pktmbuf_headroom(m));
m->pkt_len =3D 0;
m->data_len =3D 0;
```

`rte_pktmbuf_prepend()` can return `NULL` if the headroom requested exceeds=
 available headroom (shouldn't happen for a freshly allocated mbuf, but it'=
s defensive). More importantly, after `rte_pktmbuf_prepend()`, `data_len` i=
s increased by the headroom amount, but then immediately overwritten to `0`=
. The `pkt_len` is similarly set to `0`. This sequence works but is fragile=
 =E2=80=94 a cleaner approach would be to directly manipulate `m->data_off =
=3D 0` to reclaim the headroom, which is what this is effectively doing. Co=
nsider:

```c
m->data_off =3D 0;
```

This is simpler, less error-prone, and avoids the intermediate state where =
`data_len` contains a non-zero value that is immediately discarded.

### Warning: `scatter_enabled` read from `rxmode.offloads` in `rx_queue_set=
up`

Per AGENTS.md guidance, reading from `dev->data->dev_conf.rxmode` after con=
figure can become stale. In this case, `rx_queue_setup` is called between `=
dev_configure` and `dev_start`, so the value should be consistent. However,=
 the canonical pattern in DPDK is to check `dev->data->scattered_rx` or the=
 offloads via `dev->data->dev_conf.rxmode.offloads` (which is acceptable in=
 queue setup since it runs in the configure-to-start window). This is borde=
rline acceptable but worth noting =E2=80=94 if `mtu_set` is called after qu=
eue setup, the scatter state won't be re-evaluated. The AF_PACKET PMD's `mt=
u_set` doesn't re-select Rx functions or re-evaluate scatter, which is a pr=
e-existing gap not introduced by this patch.

### Info: `bufs[i]` changed to `bufs[num_rx]` =E2=80=94 correct fix for exi=
sting bug

The original code used `bufs[i]` which would leave gaps in the output array=
 when packets are dropped (via `continue`). The change to `bufs[num_rx]` is=
 correct and actually fixes a pre-existing bug in the drop path. Good catch=
 in this patch.

### Info: Consider adding `rx_nombuf` tracking for the scatter failure case

As noted above, distinguishing "no mbuf" from "oversized drop" in statistic=
s would be valuable for debugging. Minor suggestion for a follow-up.
