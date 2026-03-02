Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882ECEB362C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 19:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2CD940A76;
	Mon,  2 Mar 2026 20:38:50 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 043774028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 20:38:49 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1277d379936so5872527c88.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 11:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772480328;
 x=1773085128; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE/6wB4UnwV47FN7GV4rcGWSbSfaEii+MaE+tCyO1qk=;
 b=XNPx3qax4sW+y4dlMVmDW3p3wN85V43EFcWdDhf7QBnNkAFGFP1cdmdIvcHh84am88
 SA4ruiHL+oWz9cjsXwU1nZQk0jWh5pJSjWpQECarrJi3sVuXgnRD6aFzjhA3+hLUL5Wf
 0Wx0mJ2EbyphFbGXTsD9TfUy9KXLDmXEZ0gzc1m6s2R2ZOZq7o/Ffe/N1oIpwF013Y+C
 dP52pNVz12OTX6tpfp6d3BPlgcBU2ESypWOTB+EWpi8Nwh6e0MXAxwKDyRw0ndAOXKGt
 PETHVwCccqc/gjyG6cchSDQYUTB34mp8q9S4DYvunJAxP5iAnZLXYjRCy2Ms6V7+UcUz
 z9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772480328; x=1773085128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KE/6wB4UnwV47FN7GV4rcGWSbSfaEii+MaE+tCyO1qk=;
 b=I557tp/cn+5RF5VMcnhBlpyeF6MHh0TgdiUB0TmW4ppzi6bWO5tpLpIJKTbUph3D2Z
 h+w1SlA1cuS+7keauwKQ2Z4MIN2C2pLKFMo2AarqL5UsuCGVONbh7RY4sCMMT68sfTON
 2StgRuQatKVju72GgAYqY5MeZrxILqzs79dTFG/iQy6R1DkYNGvVn5E9TpXfwnxuHl8A
 YbapWeEStZgsmjL+ZkekHCVYnVU7QH6VGF9L0J2W1j/RR9Vnj8EFQzBPZZvdBsg9niQs
 mfCCUCe/lWjVUnin2MQ5pxt/ZW2EW+3dq1rsN6LvzMb8pVPbPuZ0pneWH1MvarQavWvZ
 ysGw==
X-Gm-Message-State: AOJu0YwUftg6otuJ52ysYhR73m+mRMreJmMGowcnheo0jmO+rXY2G47j
 DWcSpHiw9b1mQI/tBYyAQym6Du4KrWpG80u/lrR2z9NLkDqeVmZqfWIz5hJYCxQtcGQ=
X-Gm-Gg: ATEYQzyaOFiSV0WoCPPmWNirOr4cwCWQwqF+1GwhFG5k/AMOCSYyumhbp85Isb+++0Y
 fYzvXAgOFanddfpkZ+uPenPJJPgruHvVXaYOpCkrAq+JXedKOeM9Bv04EwE+uU3o1C83ndhfFT1
 D+yL+zeXNl5sx5EFq72hro85kQfYxxY6TP7SHDqKcH48yJ36l9iegYi2dT9VnlLY1bHJTv1Uvm4
 VAQNCvCzYg4MnzVzMgKY5z3RLni54gQxbRArody2VZzxET2Yz7yK/QbFfU3lAdrxLeULAWEvOOH
 Kkir4IF/fsiK6EwZtUSyzfitBI6XgxhTf5lIsA7g+AuabGY4DXyrMSRND5Bjx+MRArI6G4SfADi
 R6W7c91knMteUyJi6y1rAA7TcN2DbAhv/PhQnhD/X6hv97WpK/U5sbTgBi0giPxVPBZ3XUYhLc1
 HAMW51VQXhw85ppAX/MQhmJGlzeb4HL1qwonl1QwmX2tVyx8Es5YXMCAsTx5d4KFPv
X-Received: by 2002:a05:7022:1e11:b0:127:5cfe:1ee0 with SMTP id
 a92af1059eb24-1278fc1fad8mr6462690c88.21.1772480327836; 
 Mon, 02 Mar 2026 11:38:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1279cbd1993sm6021161c88.2.2026.03.02.11.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 11:38:47 -0800 (PST)
Date: Mon, 2 Mar 2026 11:38:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH v2 0/2] net/netvsc: runtime queue reconfiguration and fixes
Message-ID: <20260302113845.1dc61524@phoenix.local>
In-Reply-To: <20260226042414.965994-1-longli@microsoft.com>
References: <20260226042414.965994-1-longli@microsoft.com>
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

On Wed, 25 Feb 2026 20:24:12 -0800
Long Li <longli@microsoft.com> wrote:

> This series adds support for runtime queue count reconfiguration in the
> netvsc PMD, along with a prerequisite bug fix.
>=20
> Patch 1 fixes a pre-existing subchannel resource leak in
> eth_hn_dev_uninit() where subchannels are never closed before the
> primary channel.
>=20
> Patch 2 adds runtime queue count reconfiguration via port
> stop/configure/start, with full NVS/RNDIS session teardown and reinit
> when the queue count changes.
>=20
> v2:
> - Split subchannel leak fix into separate patch with Fixes tag (patch 1)
> - Fix reinit_failed recovery: re-map device before chan_open when device
>   is unmapped to prevent undefined behavior on unmapped ring buffers
> - Move hn_rndis_conf_offload() to after reinit block so offload config
>   targets the final RNDIS session instead of being lost on teardown
> - Use write lock in hn_vf_tx/rx_queue_release() to prevent race with
>   concurrent fast-path readers holding read lock
> - Reset RSS indirection table to queue 0 in subchan_cleanup error path
> - Fix multi-line comment style to follow DPDK convention
>=20
> Long Li (2):
>   net/netvsc: fix subchannel leak on device removal
>   net/netvsc: support runtime queue count reconfiguration
>=20
>  drivers/net/netvsc/hn_ethdev.c | 181 +++++++++++++++++++++++++++++++--
>  drivers/net/netvsc/hn_vf.c     |  16 +--
>  2 files changed, 181 insertions(+), 16 deletions(-)
>=20

After a couple of cycles with Claude, reduced the issues to more concise su=
mmary.
Work is still needed.

---



## Patch 1: "fix subchannel leak on device removal"

Adds a loop in `eth_hn_dev_uninit` to close subchannels before closing the =
primary channel. This fixes a real resource leak I didn't explicitly call o=
ut (subchannels allocated in `hn_subchan_configure` were never closed on re=
moval).

## Patch 2: "support runtime queue count reconfiguration"

Major rework of `hn_dev_configure` to support changing queue counts at runt=
ime, plus TX drain in `hn_dev_stop`, plus write-lock fix in VF queue releas=
e.

---

## Re-evaluation of my original findings

### Finding #1: Double-free of `hv->primary` =E2=80=94 STILL PRESENT

Neither patch changes this. The flow is still:

1. `eth_hn_dev_uninit` =E2=86=92 `hn_dev_close` =E2=86=92 `hn_dev_free_queu=
es` which calls `hn_rx_queue_free(rxq, false)` =E2=80=94 this frees `hv->pr=
imary` via `hn_rx_queue_free_common`
2. `eth_hn_dev_uninit` then does `rte_free(hv->primary)` at line 1448 =E2=
=80=94 double-free

### Finding #2: Init error path leaks `hv->primary` and `channels[0]` =E2=
=80=94 STILL PRESENT

The `failed:` label in `eth_hn_dev_init` still only calls `hn_chim_uninit` =
and `hn_detach`. It never frees `hv->primary` or closes `hv->channels[0]`.

### Finding #3: `hv->primary` alloc failure leaks `channels[0]` =E2=80=94 S=
TILL PRESENT

Lines 1376-1380 are untouched.

### Finding #4: `max_chan <=3D 0` jumps to `failed` with `err` possibly zer=
o =E2=80=94 STILL PRESENT

Lines 1406-1407 are untouched. `err` is 0 from the successful `hn_rndis_get=
_eaddr` call, so the `failed:` path tears down the device and returns succe=
ss.

### Finding #5: `hn_dev_start` leaks event callback on rxfilter failure =E2=
=80=94 STILL PRESENT

Lines 1035-1047 are untouched.

---

## New issues introduced by Patch 2

### New Issue A: `hn_dev_configure` reinit path doesn't update `hv->primary=
->chan`

When the reinit path closes the primary channel and opens a new one (lines =
in the patch around `rte_vmbus_chan_close(hv->channels[0])` ... `rte_vmbus_=
chan_open(hv->vmbus, &hv->channels[0])`), the `hv->primary` rx queue struct=
 still holds a stale `chan` pointer from the old channel. `hv->primary->cha=
n` was set during `hn_rx_queue_alloc` at init time and is never updated her=
e. The next control operation using `hv->primary` (which uses `hn_primary_c=
han(hv)` indirectly through `hn_nvs_execute` =E2=86=92 `rxq->ring_lock`) wo=
uld operate on the new channel correctly because `hn_primary_chan()` reads =
from `hv->channels[0]`, but `hv->primary->chan` is stale. This matters if a=
nything uses `rxq->chan` directly for the primary queue.

### New Issue B: `hn_chim_uninit`/`hn_chim_init` not called during reinit

The reinit path in `hn_dev_configure` calls `hn_detach` (which calls `hn_nv=
s_detach` =E2=86=92 `hn_nvs_disconn_rxbuf` + `hn_nvs_disconn_chim`) and the=
n `hn_attach` (which calls `hn_nvs_attach` =E2=86=92 `hn_nvs_conn_chim`). A=
fter reinit, `hv->chim_cnt` and `hv->chim_szmax` get updated by `hn_nvs_con=
n_chim`, but the chimney bitmap (`hv->chim_bmap`) still reflects the old al=
location state. If `chim_cnt` changes across the reinit, the bitmap is the =
wrong size. This could lead to out-of-bounds bitmap access.

### New Issue C: `reinit_failed` recovery doesn't restore `hv->primary->rxb=
uf_info`

When `hn_attach` succeeds in the reinit path, `hn_nvs_conn_rxbuf` allocates=
 a *new* `rxbuf_info` for `hv->primary`. But `hn_detach` (called earlier) d=
oesn't free the old `rxbuf_info`. So the old one leaks, and the pointer is =
overwritten. In the recovery path, if `hn_attach` succeeds there too, anoth=
er `rxbuf_info` is allocated, leaking the previous one.

### New Issue D: VF queue release NULL-sets VF queues but VF setup doesn't =
re-set them

In `hn_vf_tx_queue_release`, the patch adds `vf_dev->data->tx_queues[queue_=
id] =3D NULL`. This is good for preventing use-after-free. However, the cor=
responding `hn_vf_tx_queue_setup` calls `rte_eth_tx_queue_setup` on the VF =
which internally sets the VF's queue pointer. So this should be fine on re-=
setup =E2=80=94 not a bug, just noting the asymmetry is intentional.

---

## Summary

All five original findings remain unfixed by these patches. The patches add=
ress different (legitimate) problems: subchannel leaks and runtime queue re=
config. The most critical outstanding issue is still the double-free of `hv=
->primary` (#1), and the new reinit path in Patch 2 introduces potential co=
ncerns around stale chimney bitmap state (#B) and leaked `rxbuf_info` (#C).
