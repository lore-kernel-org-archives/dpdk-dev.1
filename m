Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F4F4613F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 23:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA669402D6;
	Tue, 24 Mar 2026 00:33:09 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id F149B4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 00:33:08 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso7899491c88.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774308788;
 x=1774913588; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwq3nC4rxd9dHsX6N5NdnkiEdr2rP4vTLKceyU3ZuKc=;
 b=vJz6m+PUYaBbdmHoWlaQdQElnn/woViZac8YePHLQJjDAab58ZtnLbJNCNg3JA069Z
 gDqQUZRhs5y2+cXZ+l8ws6Kb3cLo6b/N3rqiBN80Wjhrn+TyWIgJluscJ/78eggYxlJi
 oV9DQgGEE4RWzUcxKb284GCyWur5sehEAiQv+YPRJVypWpj/gRVSzvmGzqlbgWefAUb/
 8udm6Y3aWcg1x+hnFfYbodOUHZj5vCFP3jM5nFsaHKYlg5dEIkFn2MYF4jQOe5UumzOJ
 a91zkrTR6MP9yk7t/IGMwXbzeSZ24DCi2qaMTrORr85ftk/0XJ+THVyNUHYuIPFz0/+r
 zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774308788; x=1774913588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qwq3nC4rxd9dHsX6N5NdnkiEdr2rP4vTLKceyU3ZuKc=;
 b=njAqsmv0Rzd+dBInYExgL2JJD8fexmX1T3mRD+Yhp3h/XydyDdx2ane66gB6eMAJ0M
 mqxAheOxpc/28xcn7D39W2OQLpQvnPvStvHIOwsNj8PTwyNxc3LCQu5C5uVYA6ibLpo9
 KCyVvLZgC1SZ83etq6dslG/KcpjIqDeP13u1IP6JBKmTignfGlA5wJE1/nj29DciJ8Ve
 U04UiDHAsPBavRLg8v2OhAKZDUU/76T/r0Mav7/rvk+5CUImRhCIgU5RLpDCMXeHRpkm
 y+qZmNT71N/MM1dvov/MrP2TQ4PY8EYrO5EqxlhVrpiXBuSn092PG1BS4l7dyLCkhdgq
 kWvQ==
X-Gm-Message-State: AOJu0Yzxw3yRjQzC15pqSBTwTeWYX/jncPR2rvZfEQDFwGpTbkeEfWDs
 HnZsRvNBJrFm/3dP4expq/uNcSFE9QYREe2Rl2aMZu6coj2vNcaIb3AanZBfEG+Ue4Q=
X-Gm-Gg: ATEYQzxEkBxxJa+BgA6uf4k+s8G4eAZVllVzHPduPt5zQHg+1KjmQlC8HHnmLWbNK7w
 TWi1i9Npw5PHlh02StC1ALem+J69pk9T+mBMlnwgIbc+3MfYX/LLnhcsvarfSNwR3khwF8aNp6N
 viIN4QAh/bVRackj0RpDUiMOJyz1Z+nNpUKmtkzMWb7ngS9oqGccXDUgCwNrmiEr+6J+AI6YBUK
 JSCdWEabiN+iA33o2R/QlPue3NBf/r36RBI2J35viGVoZ/qBDK2+Nft9fcn3iBPhqf6/FI57p05
 055MUrRa924b2M8nml/oOe9NTF9Bwhj88nEvrQlVc0G45/YJ6DMToo4Uoz9u6iKl+Xswk3G3RoW
 W6x90z/qAR50ajmSITVBqzFTSVn1165L5Cn27cqUt4TaWG2uDrPjWcdEnUlQFNrS7UizSFtQfdQ
 OoZtmbl7GSL3lHsuvwX0MsyEPT8516T4FgT5U=
X-Received: by 2002:a05:7022:68a3:b0:128:cf5c:5357 with SMTP id
 a92af1059eb24-12a7266cdbbmr6365726c88.2.1774308787885; 
 Mon, 23 Mar 2026 16:33:07 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29d28csm16750062eec.19.2026.03.23.16.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 16:33:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:33:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <jgrajcia@cisco.com>, <stable@dpdk.org>, <bly454@gmail.com>
Subject: Re: [PATCH] net/memif: fix multi-segment RX data corruption and
 truncation
Message-ID: <20260323163304.71a6a785@phoenix.local>
In-Reply-To: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
References: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
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

On Mon, 16 Mar 2026 16:59:18 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> Fix dst_off being reset per-descriptor instead of per-packet in the RX
> slow path. When processing chained descriptors (MEMIF_DESC_FLAG_NEXT),
> goto next_slot2 reset dst_off to 0, overwriting the beginning of the
> current mbuf with data from subsequent descriptors. Move dst_off
> initialization before the next_slot2 label so it is only reset once
> per packet.
>=20
> Add boundary check in both RX paths before processing next segment.
> If MEMIF_DESC_FLAG_NEXT is set but n_slots is 0, free the incomplete
> mbuf chain and exit gracefully to prevent reading beyond available
> descriptors.
>=20
> Bugzilla ID: 1609
> Fixes: aa17df860891 ("net/memif: add a Rx fast path")
> Cc: stable@dpdk.org
>=20
> Reported-by: Mike Bly <bly454@gmail.com>
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

It looked good to me, but AI review spotted an issue.


---

OK, so my error finding stands but with refined reasoning. Here's the corre=
cted summary:

**Error: Double free of `mbuf_head` in the fast-path truncation error path.=
**

In the new truncation check added to the fast path:
```c
if (unlikely(n_slots =3D=3D 0)) {
    MIF_LOG(ERR, "Truncated packet: ...");
    rte_pktmbuf_free(mbuf_head);
    rte_pktmbuf_free_bulk(mbufs + rx_pkts,
            MAX_PKT_BURST - rx_pkts);
    goto no_free_bufs;
}
```

`mbuf_head` is `mbufs[rx_pkts]` (assigned at line 359). `rte_pktmbuf_free(m=
buf_head)` frees the head and its entire chain. Then `rte_pktmbuf_free_bulk=
(mbufs + rx_pkts, ...)` processes the same array starting at `mbufs[rx_pkts=
]`, which still holds the now-freed pointer. Since `rte_pktmbuf_free_bulk` =
walks `m->next` chains (confirmed in `lib/mbuf/rte_mbuf.c:574`), this frees=
 `mbuf_head` a second time.

The existing error paths at lines 383-386 and 391-394 do NOT have this bug =
=E2=80=94 they don't call `rte_pktmbuf_free(mbuf_head)` first; they let `rt=
e_pktmbuf_free_bulk` handle the entire chain. The fix is to remove the sepa=
rate `rte_pktmbuf_free(mbuf_head)` and just do:
```c
rte_pktmbuf_free_bulk(mbufs + rx_pkts,
        MAX_PKT_BURST - rx_pkts);
```

This works because `rte_pktmbuf_free_bulk` already walks the chain on `mbuf=
s[rx_pkts]`, freeing `mbuf_head` and all segments chained onto it, plus the=
 remaining unused mbufs.

No other issues found. The `dst_off` fix and the slow-path bounds check are=
 both correct.
