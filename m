Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F82CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A47402AB;
	Tue,  2 Jun 2026 23:37:55 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 3EE30402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:37:53 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2DE767A0023;
 Tue,  2 Jun 2026 17:37:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 17:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780436271;
 x=1780522671; bh=MuI2GMfiSzUQObFozXTPVGa1EAhGb5pNWCL4J2li8B0=; b=
 mp4dd58L7kbrp5V418a4/KAe2dCDO3ZdPybe2aaHbouIyCHGOykiLYPv2+zrhkHt
 fwvE3athRBgVdn7KROpl3XMW1jrQJT3fI/C24cvNl0GcwFPQ7kRw9sB07yNlMnXd
 WzNw2Yl+jEJv9TXIIJwznqb41/SdA09xSqktGXk7jmHO5DaFSFGMw6zDilN95uob
 JYdZlI7Y8LssHCoX0YUMkTaodJlocBMg5EIJv/Vn1XTZEnf7szeQ3kpIc3rLXYm/
 mWfou8kG5SzWLMnV/a9CmGeOYZb3xlOW12pasbIW9xU2zSacKC3jCWn+VJcgJFwi
 kfS13ZDswKR0wiYJQwmUmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780436271; x=
 1780522671; bh=MuI2GMfiSzUQObFozXTPVGa1EAhGb5pNWCL4J2li8B0=; b=I
 42DZDP0e3xjcGFNkfaK8aqlGJxQokArwwbXZZ1o2cw6UHVLvk0D6hZi9FAEdfDXL
 fIfFLLaKHDl8HL/ClCvfHrnFI+hjMEVdihO0rHMpftHL4BzbF4hGbzBe+z/YWsb/
 LN9qT7LYgFiNAvcQn8SV2g5VpxscV5sUJIrpMc8Veu/IV39kH3y8UglCKLY8eJni
 F9fyVFbGG0mOy+ggkARlB5CO/PGOAn/25bAIpU58Uy+XwYwihspGQquXm5PeWk6l
 sOnRfi4xjFdDRYHNlY3UtGEWbOtjSLt0V3vpLSCd9bplX39V4y0xjwTPo1CFmDmN
 Xy1BRmHmA6gqS5J9Wf/JA==
X-ME-Sender: <xms:L00famb0IK35c5WuhVu4_aDv94AVS272ZakfUeInEMSYV_5AZWt3Rg>
 <xme:L00fagIEZ5cpOwMfgosNm2PTB9_-jQSBLTR9FvFrdi28QTiH7TGlVT12dc0W5lJb0
 XBldwrPObuAK6OBS1L_hIGWE1rJa6iJkxFzRW1mrX-xxokm1KSLCAo>
X-ME-Received: <xmr:L00faithAqW67dvF0z0DIpz3EHS96zam9Lr_dJ71bFGMlgrqql4f4moqnHGPyhgZp8s8dYA6NPDFsNusXwtsSKCL3w>
X-ME-Proxy-Cause: dmFkZTGbgvCr1BDb+g9Y9IweuoOeArhYT95iQ2PPG/CLf0XVuSfj2B8hSm0ql/iKpOhY8S
 g8rbT3ipXplNz2vl4Jku/kBCZZzFYKnq4QpsLXuW44Bt4ffo/H02FxYRv7OyB6Vu6a19xv
 4373i80pEvvJXpPqWQxA+qVNC3rXNZZviRdviJ37E7vYYF6BzF5jo5hLmPL1j18hlPQ2vE
 9WtoXq6ugihHc82TS1X+A6YvET5v5BkFkftFZ5RXEkQEmgXMPd3r5P6SMK3aMNhaOHB2GX
 LoCC9kWQzvDLbFTegaYBG5QLZ/HVaWzFtusgQ0390WJ0wwK5cyyEup5PfYWgsfIbQo+SG1
 NI1JIExd0QP5kQuuL20RXQMAQJG+s/2tLf9k0S2+6u9UW8b8bHTKA8mfhF+KTwatEOsJ8b
 bIDFwB+gxd8q678BE4orYCnvFOhKbmeXGk3+6jLXzIROcEfvq1p6Ba+MMmCZbxOe4jDh8n
 T7KGE1DYK3Oucl4354S/4hOs7soqN5fjJqI9NG14IovD0+jcRlb5X4FBEv0ipceilk53tu
 B95Tk1d/kvqmnX89hbkf5I9/H+xTFu+UgRjTB65igrgWGKH/WCQX3j+krpB/wMqwM+TcyJ
 Q8WvP1MyX08ZIvrttUlQBjFwVx3B50gf/9b2Qx/LRcFNvcZVsiBizBZl4tlA
X-ME-Proxy: <xmx:L00fakXWEcol7w_0WVSOz0sAqumC8jeECPSblR53z6NnbbZ5mrtdwQ>
 <xmx:L00fatjuQnux6WbO1vY27u6AJH9IW2-qNLKSauDz_nstxQTDDpXo4w>
 <xmx:L00fasrxtZ4lSY7TKj9oVStgJ9VIhsZ43kyxPuVtowNgsE2cn8g7IA>
 <xmx:L00fajEljS6xgC3mGnyft1Z4LXUi5nYe8kB8gIVLnJazV2bXPkAP4w>
 <xmx:L00fas_CzH1OlGOJK2HG6DZV41WRL6SJL9CXarQZuAEJCv4jTF_tNvt9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:37:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v4 06/10] net/mlx5: support selective Rx
Date: Tue, 02 Jun 2026 23:37:48 +0200
Message-ID: <AVUarte7RJuUn8IiFthsZQ@monjalon.net>
In-Reply-To: <20260602065332.1d9e82fb@phoenix.local>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-7-thomas@monjalon.net>
 <20260602065332.1d9e82fb@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

02/06/2026 15:53, Stephen Hemminger:
> On Fri, 29 May 2026 15:34:00 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > From: Gregory Etelson <getelson@nvidia.com>
> > 
> > Selective Rx may save some PCI bandwidth.
> > Implement selective Rx in the (quite slow) scalar SPRQ Rx path
> > mlx5_rx_burst() where the performance impact
> > of the added condition branches is acceptable.
> > Other Rx functions do not support this feature.
> > When using selective Rx, mlx5_rx_burst will be selected.
> > 
> > A null Memory Region (MR) is always allocated
> > at shared device context initialization.
> > The selective Rx capability is not advertised
> > if this special MR allocation fails.
> > 
> > For each Rx segment configured with a NULL mempool,
> > a "null mbuf" is created.
> > It is a fake mbuf allocated outside any mempool,
> > used as a placeholder in the Rx ring.
> > The null MR lkey is used in the WQE for these segments
> > so the NIC writes received data to a discard buffer.
> > The mbuf data room size is resolved from the first segment having a pool.
> > For null segments, the buffer length is from the last seen pool,
> > so that the WQE stride size remains consistent.
> > 
> > In mlx5_rx_burst, discarded segments are not chained
> > into the packet mbuf list, NB_SEGS is decremented accordingly,
> > and no replacement buffer is allocated.
> > A separate data_seg_len accumulator tracks the total length
> > of delivered segments only.
> > The packet length is adjusted to reflect only the data
> > actually delivered to the application.
> > 
> > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> 
> AI review with Opus 4.8 and High setting found one issue:
> 
> Patch 6: net/mlx5: support selective Rx
> 
> Error: NULL pointer dereference when the first configured Rx segment is a
> discard segment (mp == NULL).
> 
> In mlx5_rx_burst() the head mbuf and the chain tail are tracked like this:
> 
> if (pkt) {
>     if (rep->pool)
>         NEXT(tail) = rep;
>     else
>         --NB_SEGS(pkt);
> }
> ...
> if (seg->pool) {
>     tail = seg;
>     ...
> }
> 
> tail is only ever assigned inside "if (seg->pool)", and pkt is set to the
> first processed segment unconditionally (pkt = seg in the !pkt block, no
> pool guard). So if the first segment of a packet is a discard segment:
> 
>     pkt becomes the null_mbuf (pool == NULL), tail stays NULL;
>     on the next (real) segment, rep->pool is set, so NEXT(tail) = rep executes with tail == NULL -> write through NULL.
> 
> Even without the crash, returning the pool-less null_mbuf as the packet
> head is wrong: the application later frees it back to a NULL pool.
> 
> This is reachable, not theoretical. testpmd (patch 3) inserts a leading
> mp==NULL segment whenever the first offset is > 0 (seg_offset > next_offset
> with next_offset starting at 0), ethdev check_split (patch 2) now permits a
> leading NULL mp, and mlx5_rxq_new() accepts it (first_mp is just the first
> non-NULL pool; there is no requirement that rxseg[0].mp != NULL). The DTS
> cases selective_rx_payload_only (rxoffs=[34]) and selective_rx_two_segments
> (rxoffs=[14,...]) in patch 10 configure exactly this layout, and
> mlx5_selective_rx_enabled() forces the scalar mlx5_rx_burst path, so the
> buggy path is the one that runs.
> 
> Trace for rxoffs=34 / rxpkts=payload (segments: discard[0,34) real[34,290)
> discard[290,max)):
> 
> iter0 (discard head): pkt == NULL, seg->pool == NULL -> pkt = null_mbuf,
> tail not set; len(290) > DATA_LEN(34) -> ++NB_SEGS, continue.
> iter1 (real seg):      pkt set, rep->pool != NULL -> NEXT(tail==NULL)=rep.
> 
> Suggested fix: a discard segment must not become the packet head/tail.
> Either reject rxseg[0].mp == NULL in mlx5_rxq_new() (cleanest, matches the
> "deliver last N bytes" case being unsupported here), or make the data path
> skip leading discard segments without assigning them to pkt and only set
> pkt/tail on the first segment with a pool. If leading discard is intended
> to be supported, the head selection and NEXT(tail) linking both need to
> account for tail == NULL.
> 
> The same head/tail assumption also means a packet that falls entirely
> within a leading discard segment would be returned with a NULL-pool head;
> fixing the above covers that too.

Yes sorry for missing that.
I fix it by assigning packet after the first real segment.
I take this opportunity to add few comments on the branching conditions.


