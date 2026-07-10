Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3006AC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 20:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7827840613;
	Fri, 10 Jul 2026 22:33:18 +0200 (CEST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by mails.dpdk.org (Postfix) with ESMTP id A987A400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 22:33:17 +0200 (CEST)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-39b22d0e488so13518711fa.3
 for <dev@dpdk.org>; Fri, 10 Jul 2026 13:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783715597; cv=none;
 d=google.com; s=arc-20260327;
 b=Virp8y+wmnL+H3RqmGJp/ET1FD9+VYIVQQGQ3v2ytghA22e/aGn4M9D4WVgv0nyimr
 B9JV3QafHDN3oSl85dMq3/X0B1DVMzT/F85yT8CkC1fjpg8ubdrymc0kAzfybwVUkLCn
 DehLs4p3N+8JsmeE6YEBiAW1V1Pist7vrOa89mIa2Wo2wlIDvCbxIRvqwx4FC5mwpliT
 YoeyXUyEYj8PO4h7qyNJlLLWnN135c/5R0m6vEHqy9WK4Dhz+2bFAGuVxBPTHdYkvpUV
 94zz/gu61vu7Lrem8rqpEPXslwxDrIOSmPSxocLBL8d9MBqeMW8WuFedkL/EhUhR2o73
 j0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5iMFDalDLuwdFCEXokQl7+cPvgCavNPFweyB+gydSdc=;
 fh=HZaH2ycltzw47yxXb7Ftlj89OhaaX/WAtsn+q7xXpJM=;
 b=WokAOcB2J9tRnka5qTrUPvKNtDHsknBINvbr++E8XDq79jePDcEhgm+R8iuM9MZUId
 ns5on9AayQoNIdCFgHgbinpJovyGS8JzFAaiBEu65/uqJ5hNpnxHtlQVjSnAC2E/FgVO
 YVKAMzX4eLTMACFuNuDWPQMy4+dGBYnJRvMbou1270Fity24RDhu/6P70eUpXsl3llIB
 uzzawzK2jHPtIAV5onxjpAnCrYYsYzUBpBS8yNqGBH1x76dtrwYBepsEC7qic2NaH5aG
 BK5v6D47lMJzHJBVE1d9eNc/pRC8b8pq4z4aYASmDiluZskp3yQd9ft3eMceyhoFYfem
 tEIw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783715597; x=1784320397; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5iMFDalDLuwdFCEXokQl7+cPvgCavNPFweyB+gydSdc=;
 b=na4AZtQyqeZ/Sq6gj1MhQsRc1ePMF1usaC0dmRe9WqfL0GrAUCpuIh+Za9u2dxNBDN
 x4egNE4KLDjnLt1PTyFRgeaTpYLiB8m2ZFYZpVO4eeQFZ3BV0NvKzHltjzSceO6b0rBD
 EPdW9+MIjfn0y2NCS8IP9pPy/umO3BGqGnBFrO5NkEVKiIGlz8mYcN+S5wFSW8fRYe31
 vC01YJikbQg9L/FC7U6KpHc+lbq6fdkU9p0p5SnGxbmxNp9UneTgj4vScNKei3Eq8xI0
 O1MKyQukyPtLCI7erQFkKIBvqMQR6GP3un5pP2UKKAacrJXoOjFYpT+CBgrDxFNYgm63
 tTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783715597; x=1784320397;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5iMFDalDLuwdFCEXokQl7+cPvgCavNPFweyB+gydSdc=;
 b=PamSFLln5SxGYzIQCh3OZd3O27NPASoUHqMF7Mo1w2jdyNZGO6Bi2OwwV7msJ8ySlu
 WdnsSwyq0BLAt8XtdgTjfFHv/mncQRMTUmLkwbkMrtK1bZIjiRfHeYEiIyaEj6hfj+iB
 ON6o72ZEzAf4/6vodVySRk+AIbfylPPr/uoAsDEuh8tZS9T+o8GcPStZQSVCZONMYL4x
 Y9GFTp1h8P+4QfH32nSTPYV+PkZ/12OFrrHqxQlkS35TKVLA/IYUDfjmfvWN7H5bik/5
 J1mwBpvvJ9OzL+5E3A/Z8sLtvF+SIqVwDhjeAsanCWuSrSoF4Pmv2sQwrBW8zlPxkN9z
 1b7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiPmvWXMiKwdZVKJNUPQwYtw6+yFu/nBZL8mwJLquxBJpIKznyW1vVxyRD9dIkwFRLLcs=@dpdk.org
X-Gm-Message-State: AOJu0YwGWUL0tx62npR3HNY24KtMBvur3npgnqaxZ9GqqABsbwiNQKGT
 0u11hM8lcqfrK6C5tkHAOXDuESTddhOpwtDm1JN0KBy7CT4gT1in7M20jalvQ5Lw8GzEEaAmQAa
 kENFGV/IL9tLelHea/4xxzsKfDwdb5SyPILMLVs/L
X-Gm-Gg: AfdE7cnbKj4PFrdLZu6lxAe0DK1VDrn2tmL5btQMhfNpgvaizEfe5fwMPAtTzRKyh79
 srCAX7brzsSDhuuUWGFBUCotFPqk+jpxUee0JIuAU6Xp1wRvU4gUmQjUWFAVMloTlHyIUvINgjy
 emBFSZhrboTdJhO+9pXD8Klo9NXiRkinPaq2Qz0n+01XA+6kIf5R0dBmKgo9hTe1SKIJoXXr4jY
 Mz5LmPCNtoqHvakvjtwpxVGXcKwr8HO3ErwFDPfFwmUJcm3QqUBD+2atK489DdxQVza/8Jc1JM=
X-Received: by 2002:a05:651c:154b:b0:39c:8124:93b3 with SMTP id
 38308e7fff4ca-39caa1026a9mr355611fa.9.1783715596454; Fri, 10 Jul 2026
 13:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260707164020.2936476-1-joshwash@google.com>
 <20260709040739.3184955-1-joshwash@google.com>
 <20260709040739.3184955-3-joshwash@google.com>
 <l7g2E_cUTtqIHhK0pfFLlQ@monjalon.net>
In-Reply-To: <l7g2E_cUTtqIHhK0pfFLlQ@monjalon.net>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 10 Jul 2026 16:33:03 -0400
X-Gm-Features: AVVi8CcZawa4c-o75s9h2LtnF_7MwM7Rasz2erQdBTpGgu651gZTRPF96sbysHM
Message-ID: <CALuQH+UAn1tk22RAjRukEOSkAnikv8sLUuBPVBq4MrJ_Rgw1Lg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] net/gve: delay adding mbuf head to software ring
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Jeroen de Borst <jeroendb@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 stable@dpdk.org, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jul 10, 2026 at 10:45=E2=80=AFAM Thomas Monjalon <thomas@monjalon.n=
et> wrote:
>
> 09/07/2026 06:07, Joshua Washington:
> > The GQ TX datapath was set up to write the mbuf head into the sw_ring
> > before writing the descriptors. This poses a problem because it's
> > possible for the packet to be dropped due to lacking the FIFO space to
> > do a proper TX. In such a case, the packet won't be sent, and will lead
> > to leaked mbufs in the subsequent segments.
> >
> > There is also no real reason that the head mbuf must be set in the
> > sw_ring separately from the others; the mbuf chain is not actually
> > walked as part of GQ TX.
> >
> > Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
> > Cc: stable@dpdk.org
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
>
> AI found this issue:
>
> **Error:** Resource leak on early return from `gve_tx_burst_qpl()`.
>
> The patch modifies the loop to store mbufs in `sw_ring` only after checki=
ng FIFO availability, but introduces a leak when `goto end_of_tx` is taken =
after the first segment has been processed. At line 306-307:
>
> ```c
> if (!is_fifo_avail(txq, hlen)) {
>     gve_tx_clean(txq);
>     if (!is_fifo_avail(txq, hlen))
>         goto end_of_tx;
> }
> ```
>
> If the second `is_fifo_avail()` check fails and we `goto end_of_tx`, the =
current `tx_pkt` (which is the mbuf chain head) has not been added to `sw_r=
ing` yet (that happens later in the modified loop at lines 346-351). The fu=
nction will return without freeing `tx_pkt`, and the mbuf chain is lost.
>
> **Suggested fix:** Free the current packet before `goto end_of_tx`:
>
> ```c
> if (!is_fifo_avail(txq, hlen)) {
>     gve_tx_clean(txq);
>     if (!is_fifo_avail(txq, hlen)) {
>         rte_pktmbuf_free(tx_pkt);
>         goto end_of_tx;
>     }
> }
> ```
>
> Similarly, for the TSO path at lines 314-316, if the FIFO space check fai=
ls, `tx_pkt` should be freed before the goto.

I believe this is a hallucination. The driver does not free the TX
packet in the case of a failed send because it does not count that
packet in the packets sent to the application. It ultimately did not
take ownership of the mbuf for the failing packet from the
application, so it should not free that mbuf. The tx_id pointer is not
incremented until after it is sure that the packet data can be copied
to the DMA area (FIFO buffer), so there is no unintended descriptor
write either, as far as I can tell.

-- Josh
