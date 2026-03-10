Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2710FD2D9C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D4F402DC;
	Tue, 10 Mar 2026 15:02:57 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id 4E66E402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:02:57 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d744d9abdaso2113229a34.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773151376;
 x=1773756176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlJWtQajq9qfB23v92Nhn9hqIOT4iui8S/h4PxRze74=;
 b=e6lWm+CrqKObivjUzfO9O5OuZwCKa0Ug/mYUnW20LGmWPsIbDKbJTd+Ck49ugdHc/j
 1aOOgCt+2AmBOHJzjQ02e8W744Vdz4jvFPfioFv8AyMJ1bAfG1G8t7FP9Sa8wruwwTdJ
 TLL67APJbuJ2W9HAkvHoEl7P3ALQr7cxe53VWjtKzOKRZpIMF89e8CtmqoQOZ5FBWeTB
 NmStvqyKLU9i/9Y5zrjlQiOYL7NFkq3olW6FXRxTKHn2F9x4mJxQiwRwJh01CMxDEMw7
 V8moefuzmfeRRPjBJyTYgj3xDHFBtMqD3+qDzXWha6ucpJc7eg87G7NvREDADTwJJNnD
 UahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773151376; x=1773756176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QlJWtQajq9qfB23v92Nhn9hqIOT4iui8S/h4PxRze74=;
 b=nlkboai1qaOEbc7HacWvClqBO33jfpV/McCfAWRawDvp1u0g3hNIwpK7Ys37r7jYaL
 BqXtZHLH1XMjC1dN95jMgGQLixeHc3J1jp7sLa6lE0KUEGoHypiJ/rZ0JQje1PJZ+Xci
 ayn0XgQhGCluk60xxM9HYL9VE3ZMBgDMmitHqIcyrbJAp2iwAdXqNzne/PI3rmUCAw0C
 qBITYqcYy61OO5JEDJAF8NyWRqbNQnfin/8YKI0jgJU+oEIFZv9SWe/OhDlLKBRs/zrv
 k7iJVzcofoKbR1vWxbCNZ+1kk0K03dsm/RlldPba+UKONyMO8BCDcs27SJrRwYMogDUR
 xilA==
X-Gm-Message-State: AOJu0YznUTwCtlQCoA+bNqlg8A62sL2cqjv4hMlcUfzbuFzV5yBTPE5g
 BFwQEfJA5X66arkeLemjEutaFNbb7sj6ZxBgzjttAFmZLLy+a4cD8/h6aUd+A/HyBvM=
X-Gm-Gg: ATEYQzx67aQ9odiRMa7R6T7sy+bFKCOzxd4yHmSvG3AvTv2wzkeB/g4CbjrMqHl4/fZ
 3AhlzK9HOf7XScBYPsP/yB+q9uKukg8MUaJaLDA4f44I47ErrZg8yTyZ+BEUtuizIWgVEmf2GJR
 eWeHVT+IXPM33jwMQkl/OxojlagWQljGrbAaR+yPZLKuHkmSd2LBud8jtsQrpr36/QzXGXzY2R9
 qP6ofXapHV6M7h7fCjbmRFzwRIZTc2LaCv16JimZj6EOx68o4bPJTb1iK0riS5dfXSDtxBFcpN1
 o3qxpifWDFdGcW8hZhuIMwx6griRb3S4psO4YPhOlJJr/5DPr5Q3mmN6Gosj0g94WNmPZCm3FfR
 BkUuThi+EbVABu5iWgBlE96C6EqSSlobhEcKi5bv03cNYMJfb9eTp0DIRv0ZdlanO3rTa1rK9eG
 bjKSWUvx4jsGK70my2Dv+qZPauVPCK9bFAUpA=
X-Received: by 2002:a05:6808:1481:b0:467:697:7bb2 with SMTP id
 5614622812f47-4670697a32cmr4233527b6e.59.1773151376065; 
 Tue, 10 Mar 2026 07:02:56 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466df93e85fsm7593870b6e.2.2026.03.10.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:02:55 -0700 (PDT)
Date: Tue, 10 Mar 2026 07:02:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <xavier.guillaume@ovhcloud.com>
Subject: Re: [PATCH v2] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Message-ID: <20260310070251.17c934ea@phoenix.local>
In-Reply-To: <20260309210210.1665888-1-sriram.yagnaraman@ericsson.com>
References: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
 <20260309210210.1665888-1-sriram.yagnaraman@ericsson.com>
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

On Mon, 9 Mar 2026 22:02:10 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Enable jumbo frame reception with default mbuf data room size by
> chaining multiple mbufs when packet exceeds single mbuf tailroom.
>=20
> The RX path now:
> - Copies first segment up to mbuf tailroom
> - Allocates and chains additional segments for remaining data
> - Properly maintains nb_segs, next pointers, and pkt_len
> - Silently drops packets on mbuf allocation failure
>=20
> This allows receiving 9KB jumbo frames using standard 2KB mbufs,
> chaining ~5 segments per jumbo packet. No need for custom mbuf
> pools with large data room.
>=20
> Advertises RTE_ETH_RX_OFFLOAD_SCATTER capability.
>=20
> Depends-on: series-34567 ("net/af_packet: fix MTU handling and add
> jumbo frame support")
>=20
> Note: Implementation generated with AI assistance.
>=20
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

Using AI patch review finds several issues.

I'll start by reading the patch and the relevant AGENTS.md section.Now let =
me check AGENTS.md for any `RTE_ETH_RX_OFFLOAD_SCATTER` guidance:No specifi=
c guidance on `RTE_ETH_RX_OFFLOAD_SCATTER` in AGENTS.md. Let me now look mo=
re closely at the original code to understand the loop structure better:The=
 `for` loop itself isn't in the diff context =E2=80=94 it's the existing `f=
or (i =3D 0; i < nb_pkts; i++)` loop. Let me check the existing code to und=
erstand the full picture:Now let me look at the current upstream code to un=
derstand the existing loop structure:GitHub rendered HTML, not useful. I ha=
ve enough context from the patch and the search results to do a thorough re=
view. Let me now analyze the patch carefully.

Here's my review of the v2 patch:

---

**Patch: net/af_packet: add multi-segment mbuf support for jumbo frames**

### Error

**1. Scatter capability unconditionally advertised but RX path does not che=
ck if the application enabled it.**

The patch adds `RTE_ETH_RX_OFFLOAD_SCATTER` to `rx_offload_capa` in `eth_de=
v_info()`, which correctly advertises the *capability*. However, the multi-=
segment chaining code in `eth_af_packet_rx()` executes unconditionally =E2=
=80=94 it will scatter into multiple mbufs even if the application did not =
request `RTE_ETH_RX_OFFLOAD_SCATTER` in its `rxmode.offloads`. When an appl=
ication has not enabled scatter, it expects single-segment mbufs only and m=
ay not walk `mbuf->next` chains. The driver should check whether scatter wa=
s actually requested (via the queue or port config) and fall back to the ol=
d behavior (drop packets that exceed single-mbuf tailroom) when scatter is =
not enabled.

Other PMDs (e.g., ixgbe, i40e, mlx5) guard their scatter path behind a chec=
k of the configured offloads. Without this, applications that haven't opted=
 into scatter will silently receive chained mbufs they don't expect, leadin=
g to data truncation or corruption at the application layer.

**2. `goto next_pkt` skips the loop increment =E2=80=94 `i` still increment=
s but `num_rx` does not, causing the outer `for` loop to consume ring frame=
s without delivering packets, potentially skipping valid frames.**

The outer loop is `for (i =3D 0; i < nb_pkts; i++)`. When the `goto next_pk=
t` path is taken (mbuf alloc failure in the scatter loop), the code correct=
ly releases the ring frame and advances `framenum`, then jumps to `next_pkt=
`. On the next iteration, `i` increments but the loop re-reads `ppd` from t=
he *new* `framenum` =E2=80=94 this part is fine.

However, the original code indexed `bufs[i]` and the patch changes it to `b=
ufs[num_rx]`, which is correct. But consider: the loop variable `i` counts =
iterations including failures, while the loop condition is `i < nb_pkts`. T=
his means the function will stop after `nb_pkts` ring-frame inspections reg=
ardless of how many were dropped. If several frames fail allocation, the fu=
nction returns fewer packets than it could have =E2=80=94 the ring may have=
 more ready frames that will be delayed until the next call. This is a beha=
vioral change from the original code (which also had `bufs[i]` so never had=
 drops mid-loop), but it's minor =E2=80=94 not a bug per se, just worth not=
ing.

### Warning

**3. No `err_pkts` counter increment on allocation failure.**

When `rte_pktmbuf_alloc()` fails for a scatter segment, the head mbuf is fr=
eed and the ring frame released, but `pkt_q->err_pkts` is not incremented. =
The original code (before this patch) also doesn't increment `err_pkts` on =
the initial alloc failure `break`, but that's an existing limitation. For t=
he new scatter path, a silent drop with no counter update makes diagnosis d=
ifficult. Consider:

```c
if (unlikely(seg =3D=3D NULL)) {
    rte_pktmbuf_free(mbuf);
    pkt_q->err_pkts++;
    ...
```

**4. No guard against zero tailroom causing an infinite loop.**

If `rte_pktmbuf_tailroom(seg)` returns 0 for a freshly allocated mbuf (theo=
retically possible if headroom equals the entire buffer), the `while (remai=
ning > 0)` loop would allocate mbufs endlessly with `data_len =3D 0`, never=
 decrementing `remaining`. In practice this shouldn't happen with normal me=
mpool configurations, but a defensive check would be prudent:

```c
data_len =3D RTE_MIN(remaining, rte_pktmbuf_tailroom(seg));
if (unlikely(data_len =3D=3D 0)) {
    rte_pktmbuf_free(seg);
    rte_pktmbuf_free(mbuf);
    /* handle error */
    goto next_pkt;
}
```

**5. Missing `Cc: stable@dpdk.org` if this targets an LTS branch, and missi=
ng `Fixes:` tag if it addresses a known limitation.**

The commit message doesn't indicate this is a bug fix (it's a new feature),=
 so this may be intentional. But the `Depends-on:` references a fix series =
=E2=80=94 if that series targets stable, this patch should clarify that it =
does not.

### Info

**6. The `bufs[num_rx]` fix is a good correctness improvement.** The origin=
al code used `bufs[i]` which only worked because the original loop never ha=
d a `continue`/`goto` path that could skip a slot. The new indexing with `n=
um_rx` is correct for the new drop path.

**7. Regarding `RTE_ETH_RX_OFFLOAD_SCATTER` and AGENTS.md** =E2=80=94 there=
's no specific guidance in AGENTS.md about scatter offload. This is a gap w=
orth considering: a pattern section could note that drivers advertising sca=
tter capability should conditionally enable the scatter code path based on =
whether the application actually requested it, since applications that don'=
t request scatter expect only single-segment mbufs.
