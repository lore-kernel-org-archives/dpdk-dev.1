Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D25FD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:41:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E1B240279;
	Wed, 25 Feb 2026 23:41:42 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 949E0400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:41:40 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-899c3441177so4703156d6.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772059300;
 x=1772664100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kyeFOqNEFAMjxvfMrYG9XsTN2MpjGgsYcOocvjuRLQ=;
 b=VabP14WkCn/5UfyK4gvvTyvxU0jFYflmxOHhtlxOaPO+2ZWJhEOoAvEGYGRvxvSdHf
 ++R459rJn8+Lhl4fP+hMUQT4WfVmtyVU9HvF/hZn/hYKcUzI7B9xEqyq8rLznnYBBMvT
 MUGKaLCE27SHtMaPYx42jwyKhLVE4De7tiKRSp8UajEMvbwXfHkM8bmCN8g9i3hVO/sT
 BloQGJsU0npA7Tg3KrxlTYIbgjVQVdn7uNvSPTPhVf/lPk8U5zARfz9pgDdK859RWP9h
 Gn5xXeUOnYh2JZd6bqvS3KCURjNb35U8MdAXbTum14oCQ/0zOUQGaHBw4vHUAho3cOC6
 7BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059300; x=1772664100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6kyeFOqNEFAMjxvfMrYG9XsTN2MpjGgsYcOocvjuRLQ=;
 b=syODme51lO+1Tph0ybla2PhOA77x9dMCjwE9+tvVz5UJnR8Sh1uqM6mq031vQL+f5M
 xtvrS9gt7YPqxW9d5Idxi+oFGveiXQt07LyRajjQSQu147dLt3BAjtD5IhlQDTlQac7t
 6idqzlfs9PcKHDXQhqOA4R4zrvOCJabewHlLDco0lTqGk+VSXz+29lgDCqN94C1npVqC
 fLpkXewvA6PRNKyPmOg3WwFSUFxzhVyqEKJ1LxslbwOREVfOvyDjZB84Pfss4IQHY7Ox
 1y3NdHxbhSuKc5Z513++hW3H/WXpvcnEZEBzIm3SAkI2gYvaq3cm4ro9zkrAhj+GR7Df
 jTkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoigjkYNFUkf+7xF2wWw1I7VsCbSzy7F6NcGz4E4aGo9AqirBDN5pMOodd4YpOReVvJ6k=@dpdk.org
X-Gm-Message-State: AOJu0Yw6xjfcCBzKVIQs4pLfF9KgHjBPLlZFzYXTEY/Fj0YZLDtun8aA
 yMi/XJAZfJGU7g3ARfk72Xl9K/wULsLOdCYqXNBp7uKMSR/pBpCWc5jfNImBJxzHujI=
X-Gm-Gg: ATEYQzxrTUIyq99AHjlk52oIARGMQwRrHdwFd7xpMh/s+aVQXi7W5ZJomBBVA+6YYui
 VhoglQXPnA1Uvvt3uAgyOfzYc2rr1eO9UvHgziFqkBI4fE9zJfpdSeiSiUAsIVxOMgaMSec8rBc
 TWiDLfKtOvUVw+GiPZKLoIgFJF6Dapbu+vi9L1YevzSOVeheqFJzp1xKmO3blcorQX3sxAe9uez
 VirOmTY9Gd8x6szvUpFNIooI8/3i8jMExdu6IrjlfP1oC33OZrrQv0NsG6270qRjlCtTPgtcT+v
 duS5B8kosRBUp3nNrmG08i9L/aGK6ody3OMdIyaqJ/qwNNHAbBfoeIK4V4qBetJB0RwXssweYeZ
 PyGR6VzoGNS8atsk7k5ZiI0QerSu15Y7T1lRloDOTAJAHpS1B8i6tlLB4JHojuKbAUkQrgJhgns
 hW3fGT1R79veTM3cSFQLyi1A8laDKYcpHT2smcWhNlM+gw4xxQcEygqdACTUfkHhe3vA7YE+F6g
 LU=
X-Received: by 2002:a05:6214:518a:b0:899:ad54:423c with SMTP id
 6a1803df08f44-899c13c97d3mr31358706d6.16.1772059299716; 
 Wed, 25 Feb 2026 14:41:39 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5074498f6c7sm4077181cf.11.2026.02.25.14.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:41:39 -0800 (PST)
Date: Wed, 25 Feb 2026 14:41:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] net/netvsc: support runtime queue count reconfiguration
Message-ID: <20260225144136.1cdd7d17@phoenix.local>
In-Reply-To: <20260225195040.945067-1-longli@microsoft.com>
References: <20260225195040.945067-1-longli@microsoft.com>
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

On Wed, 25 Feb 2026 11:50:40 -0800
Long Li <longli@microsoft.com> wrote:

> Add support for changing the number of RX/TX queues at runtime
> via port stop/configure/start. When the queue count changes,
> perform a full NVS/RNDIS teardown and reinit to allocate fresh
> VMBus subchannels matching the new queue count, then reconfigure
> RSS indirection table accordingly.
>=20
> Key changes:
> - hn_dev_configure: detect queue count changes and perform full
>   NVS session reinit with subchannel teardown/recreation
> - hn_dev_stop: drain pending TX completions (up to 1s) to prevent
>   stale completions from corrupting queue state after reconfig
> - eth_hn_dev_uninit: close subchannels before primary channel to
>   prevent resource leaks on device removal
> - hn_vf_tx/rx_queue_release: null VF queue pointers after release
>   to prevent use-after-free when the ethdev framework releases
>   excess queues during VF reconfiguration
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

Sorry for AI review overload here...

## Patch Review: `[PATCH] net/netvsc: support runtime queue count reconfigu=
ration`



### Errors

**(E1) `hn_dev_configure`: `rte_vmbus_unmap_device` after closing subchanne=
ls and primary channel =E2=80=94 subsequent `rte_vmbus_map_device` failure =
leaves device in unrecoverable state with no channel and no mapping**

The reinit sequence is:

```c
hn_detach(hv);
rte_vmbus_chan_close(hv->channels[0]);
rte_free(hv->channels[0]);
hv->channels[0] =3D NULL;

rte_vmbus_unmap_device(hv->vmbus);
err =3D rte_vmbus_map_device(hv->vmbus);
if (err) {
    PMD_DRV_LOG(ERR, "Could not re-map vmbus device!");
    goto reinit_failed;
}
```

If `rte_vmbus_map_device` fails, execution goes to `reinit_failed`, which a=
ttempts recovery by calling `rte_vmbus_chan_open`. But the device is unmapp=
ed at this point =E2=80=94 the MMIO regions are gone. `rte_vmbus_chan_open`=
 on an unmapped device is undefined behavior (it will try to access unmappe=
d ring buffers). The recovery path cannot work without a successful map. Th=
e recovery block should check whether the device is mapped before attemptin=
g channel open, or re-attempt the map first.

**(E2) `hn_dev_configure`: `rte_free(hv->channels[0])` frees memory not all=
ocated with `rte_malloc`**

After closing the primary channel:

```c
rte_vmbus_chan_close(hv->channels[0]);
rte_free(hv->channels[0]);
hv->channels[0] =3D NULL;
```

And similarly in the `hn_attach` failure recovery:

```c
rte_vmbus_chan_close(hv->channels[0]);
rte_free(hv->channels[0]);
hv->channels[0] =3D NULL;
```

`channels[0]` is allocated by `rte_vmbus_chan_open()`. Whether this is `rte=
_malloc`'d or regular `malloc`'d depends on the vmbus implementation. If `r=
te_vmbus_chan_open` uses `malloc` internally (which is common for control s=
tructures), then `rte_free` is a mismatch that may silently corrupt the hea=
p. Need to verify the allocation source matches =E2=80=94 or use the same f=
ree that `rte_vmbus_chan_close` would use. In `eth_hn_dev_uninit` (existing=
 code), the primary channel is freed via `rte_free(hv->primary)`, not `rte_=
free(hv->channels[0])`, suggesting these may be different pointers or the a=
llocation path uses `rte_malloc`. Worth verifying.

**(E3) `hn_dev_configure`: RNDIS offload configuration applied before queue=
 count change check, not re-applied after NVS teardown/reinit**

The sequence is:

```c
err =3D hn_rndis_conf_offload(hv, ...);  /* Configure RNDIS offload */
...
if (queue count unchanged)
    goto skip_reinit;

/* Close subchannels, hn_detach(), chan_close, chan_open, hn_attach() */
```

`hn_detach()` tears down the RNDIS session. `hn_attach()` establishes a new=
 NVS/RNDIS session. But `hn_rndis_conf_offload()` was called *before* the t=
eardown and is not called again after `hn_attach()`. The offload configurat=
ion from the first call is lost when the RNDIS session is destroyed. The of=
fload configuration should be re-applied after `hn_attach()`, or moved to a=
fter the reinit block.

**(E4) `hn_vf_tx_queue_release` / `hn_vf_rx_queue_release`: setting queue p=
ointer to NULL under read lock while Tx/Rx paths read the same pointer unde=
r read lock**

```c
rte_rwlock_read_lock(&hv->vf_lock);
vf_dev =3D hn_get_vf_dev(hv);
if (vf_dev && vf_dev->dev_ops->tx_queue_release) {
    (*vf_dev->dev_ops->tx_queue_release)(vf_dev, queue_id);
    vf_dev->data->tx_queues[queue_id] =3D NULL;
}
rte_rwlock_read_unlock(&hv->vf_lock);
```

The fast path (`hn_xmit_pkts`) reads `vf_dev->data->tx_queues[queue_id]` un=
der the same read lock:

```c
void *sub_q =3D vf_dev->data->tx_queues[queue_id];
nb_tx =3D (*vf_dev->tx_pkt_burst)(sub_q, tx_pkts, nb_pkts);
```

Multiple readers can hold a rwlock simultaneously. This means a Tx thread c=
ould read the queue pointer, then the release thread NULLs it and frees the=
 underlying memory, and the Tx thread calls into freed memory. The NULL ass=
ignment after release prevents *subsequent* accesses, but doesn't protect a=
 concurrent reader that already loaded the pointer. This needs a write lock=
, not a read lock.

### Warnings

**(W1) `hn_dev_configure`: `subchan_cleanup` error path sets `hv->num_queue=
s =3D 1` but doesn't restore RSS indirection table**

The `subchan_cleanup` label closes subchannels and resets `num_queues` to 1=
, but the RSS indirection table (`hv->rss_ind[]`) was already updated to di=
stribute across the new (failed) queue count:

```c
for (i =3D 0; i < NDIS_HASH_INDCNT; i++)
    hv->rss_ind[i] =3D i % dev->data->nb_rx_queues;
```

If `nb_rx_queues` was e.g. 4 and subchannel allocation failed, the indirect=
ion table points to queues 0-3 but only queue 0 exists. The indirection tab=
le should be reset to all-zeros in the cleanup path.

**(W2) `hn_dev_stop`: TX drain loop accesses `dev->data->tx_queues[i]` up t=
o `hv->num_queues` without bounds check against configured queue count**

```c
for (i =3D 0; i < hv->num_queues; i++) {
    struct hn_tx_queue *txq =3D dev->data->tx_queues[i];
    if (txq =3D=3D NULL)
        continue;
    ...
```

`hv->num_queues` could be larger than the actual number of configured Tx qu=
eues (`dev->data->nb_tx_queues`) if configuration reduced the count but `nu=
m_queues` wasn't yet updated. The NULL check provides some protection, but =
iterating with `RTE_MIN(hv->num_queues, dev->data->nb_tx_queues)` would be =
safer.

**(W3) Missing `Cc: stable@dpdk.org` and `Fixes:` tag for the `eth_hn_dev_u=
ninit` subchannel leak fix**

The commit message states this change prevents resource leaks on device rem=
oval ("close subchannels before primary channel"). This is a bug fix for ex=
isting code, not just infrastructure for the new feature. It should have a =
`Fixes:` tag referencing the commit that added subchannel support, and `Cc:=
 stable@dpdk.org` for backport consideration. Alternatively, this could be =
split into a separate bug-fix patch.

**(W4) `hn_dev_configure`: recovery path uses deeply nested if/else with du=
plicated error logging**

The `reinit_failed` block has three levels of nesting with repeated "recove=
ry failed, device unusable" messages. Consider restructuring with early-ret=
urn or goto to reduce nesting and deduplicate the error messages.

**(W5) Comment style: multi-line comment at `reinit_failed` doesn't follow =
DPDK style**

```c
	/* Device is in a broken state after failed reinit.
	 * Try to re-establish minimal connectivity.
	 */
```

DPDK style requires the first line of a multi-line comment to contain only =
`/*`:

```c
	/*
	 * Device is in a broken state after failed reinit.
	 * Try to re-establish minimal connectivity.
	 */
```

---

### Summary

The most critical findings are E3 (lost RNDIS offload config after teardown=
/reinit =E2=80=94 the device will come back with default offload settings r=
ather than what was requested), E4 (read lock insufficient for queue pointe=
r NULLing =E2=80=94 concurrent Tx/Rx can use-after-free), and E1 (recovery =
path after failed remap operates on unmapped device). E2 needs verification=
 of the allocation source for `channels[0]`.

The overall approach of full NVS teardown/reinit for queue count changes is=
 sound, and the TX drain in `hn_dev_stop` and subchannel cleanup in `eth_hn=
_dev_uninit` are good improvements. The error handling is thorough for the =
most part =E2=80=94 the recovery attempt in `reinit_failed` is a nice touch=
 even if the unmapped-device issue needs fixing.
