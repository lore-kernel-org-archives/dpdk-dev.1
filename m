Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C2CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 13:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 727AB402A9;
	Tue,  2 Jun 2026 15:53:39 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 653B640150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 15:53:37 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3045c195251so11832985eec.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780408416;
 x=1781013216; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cF2qVhEcXOKBnWbB+r95qVClEELzptbN4lpRixZvbzE=;
 b=Af8qb/6gN6EDOjC5Fcq8KUvmrOne0oXTPozzc++Ol+6HmWZEyaCdnjSuFDMGiMgUSL
 fOBMkty1p8dRTR0lxQyC2MgIbw3+A8zJGADgCn0h9wCE8dHJslqEl3POv3mL9CtJeNYf
 BMGAuLwWF1FtaEBSns8nTB10cbQ1zRJjchCW3wSIts9E+4NwXHd7XUcOYminN1sgpJcG
 htrPLCcTLRKIyGhgSfRgJ3xINgJonchbTyJ71wFOX4tYFyaL3hp4qhUasTieJzszl4+C
 u6ZoF2pQ7EMe30gSBhPWEKyhkHauJjhYrvoRlbv8yFK+g3GjlO1WYcvfO0nWFy42xun2
 LccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780408416; x=1781013216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cF2qVhEcXOKBnWbB+r95qVClEELzptbN4lpRixZvbzE=;
 b=riOd43J3DY7yfZhoMcOTq9eOmlvCmbSNLkmEbYdfPDk3IPb/P+R0STBjFOenvheZdM
 ERLJz1QbVUdzsack3OhQyKoWL30aaoYkne8CqAe/zrHxVCgV5UoUT5u3pPzWg+sAHZCa
 CGlTeXbJRo+3xamPPy1IiZdtQjg5AxaB5TLH56Z44WKLPUpDvNPie3jr6aYdX3j5B4GT
 OeW8/PbFGvJ7vADJgjR3kmA7/fg/8U5+BzQjn9ap2rKPJEYk5TjPvHlh6LVU41vHQsXk
 /7vd8jVBIewq6UE9bdnYubbQTrNoZlDYtNmaclj/oK8Dbyhuhu+GJuVFMoqk/WkwiXFn
 nwbQ==
X-Gm-Message-State: AOJu0Yw7NDDrq2x1UnnKOH9sE4AHPb6BxwJhwHhuMGYCj6ThAKPNz70h
 y5Lf143tjtGD5L78e3waxRVjkgAuyC0B6iU7JQCP1ivk9dP35/fWG9W19QaODgHT1dU=
X-Gm-Gg: Acq92OE6T/VqXGYvfOGuZyzQQ/6F2kxLYNS4+6ZfCl3KpksDnotwIepk5IyZd4vRDKg
 uzxOlqltVolYEMucMgW77mBQR1luQbsR+N+gO1evC4b7n/2VleWLCgADJbycaIfxQE0IcF/A3jb
 I1IDCvc4lYg5g3a+91X2VRw5U66e+qfA8eGCCUwpJI1NQWUzoN1RIqjwqtYmqWPWWS6CjzFiZ+4
 PtsJVqkrUXMjvbr5dwNXQ8IA6eXho7iCAE2STreORVN91b8ksEJJYIoiMz01+bU1iIm4buxGr3E
 PeMx9XhChPoJ3KqtFPDv/qtqhq13SfdNTSi2caciv/ACOJON9II5Cf1NxesI3FV0ZnIpy8nVoWb
 czdhfTAQ7Q0J1pgSC0GHoq4GbjDikdoM6oCIMRdSz3cvajYsKJ0y/PR9J4aKP7NASlVBthrWX50
 Mq9Ge4U807rP5hkhaRbFpQonmWSlJ3Sm9v8L40Bz3VBLT4evvGT2/iUHSZxyJEgOmrncKLNVG70
 +4=
X-Received: by 2002:a05:7300:3b05:b0:2ed:b131:240e with SMTP id
 5a478bee46e88-304fa5ee9d7mr6750119eec.23.1780408416030; 
 Tue, 02 Jun 2026 06:53:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm16131971eec.21.2026.06.02.06.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 06:53:35 -0700 (PDT)
Date: Tue, 2 Jun 2026 06:53:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v4 06/10] net/mlx5: support selective Rx
Message-ID: <20260602065332.1d9e82fb@phoenix.local>
In-Reply-To: <20260529133522.2646044-7-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
 <20260529133522.2646044-7-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 29 May 2026 15:34:00 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> From: Gregory Etelson <getelson@nvidia.com>
> 
> Selective Rx may save some PCI bandwidth.
> Implement selective Rx in the (quite slow) scalar SPRQ Rx path
> mlx5_rx_burst() where the performance impact
> of the added condition branches is acceptable.
> Other Rx functions do not support this feature.
> When using selective Rx, mlx5_rx_burst will be selected.
> 
> A null Memory Region (MR) is always allocated
> at shared device context initialization.
> The selective Rx capability is not advertised
> if this special MR allocation fails.
> 
> For each Rx segment configured with a NULL mempool,
> a "null mbuf" is created.
> It is a fake mbuf allocated outside any mempool,
> used as a placeholder in the Rx ring.
> The null MR lkey is used in the WQE for these segments
> so the NIC writes received data to a discard buffer.
> The mbuf data room size is resolved from the first segment having a pool.
> For null segments, the buffer length is from the last seen pool,
> so that the WQE stride size remains consistent.
> 
> In mlx5_rx_burst, discarded segments are not chained
> into the packet mbuf list, NB_SEGS is decremented accordingly,
> and no replacement buffer is allocated.
> A separate data_seg_len accumulator tracks the total length
> of delivered segments only.
> The packet length is adjusted to reflect only the data
> actually delivered to the application.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

AI review with Opus 4.8 and High setting found one issue:

Patch 6: net/mlx5: support selective Rx

Error: NULL pointer dereference when the first configured Rx segment is a
discard segment (mp == NULL).

In mlx5_rx_burst() the head mbuf and the chain tail are tracked like this:

if (pkt) {
    if (rep->pool)
        NEXT(tail) = rep;
    else
        --NB_SEGS(pkt);
}
...
if (seg->pool) {
    tail = seg;
    ...
}

tail is only ever assigned inside "if (seg->pool)", and pkt is set to the
first processed segment unconditionally (pkt = seg in the !pkt block, no
pool guard). So if the first segment of a packet is a discard segment:

    pkt becomes the null_mbuf (pool == NULL), tail stays NULL;
    on the next (real) segment, rep->pool is set, so NEXT(tail) = rep executes with tail == NULL -> write through NULL.

Even without the crash, returning the pool-less null_mbuf as the packet
head is wrong: the application later frees it back to a NULL pool.

This is reachable, not theoretical. testpmd (patch 3) inserts a leading
mp==NULL segment whenever the first offset is > 0 (seg_offset > next_offset
with next_offset starting at 0), ethdev check_split (patch 2) now permits a
leading NULL mp, and mlx5_rxq_new() accepts it (first_mp is just the first
non-NULL pool; there is no requirement that rxseg[0].mp != NULL). The DTS
cases selective_rx_payload_only (rxoffs=[34]) and selective_rx_two_segments
(rxoffs=[14,...]) in patch 10 configure exactly this layout, and
mlx5_selective_rx_enabled() forces the scalar mlx5_rx_burst path, so the
buggy path is the one that runs.

Trace for rxoffs=34 / rxpkts=payload (segments: discard[0,34) real[34,290)
discard[290,max)):

iter0 (discard head): pkt == NULL, seg->pool == NULL -> pkt = null_mbuf,
tail not set; len(290) > DATA_LEN(34) -> ++NB_SEGS, continue.
iter1 (real seg):      pkt set, rep->pool != NULL -> NEXT(tail==NULL)=rep.

Suggested fix: a discard segment must not become the packet head/tail.
Either reject rxseg[0].mp == NULL in mlx5_rxq_new() (cleanest, matches the
"deliver last N bytes" case being unsupported here), or make the data path
skip leading discard segments without assigning them to pkt and only set
pkt/tail on the first segment with a pool. If leading discard is intended
to be supported, the head selection and NEXT(tail) linking both need to
account for tail == NULL.

The same head/tail assumption also means a packet that falls entirely
within a leading discard segment would be returned with a NULL-pool head;
fixing the above covers that too.
