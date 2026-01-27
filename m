Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733B2C88E41
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 08:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52F0A40E21;
	Tue, 27 Jan 2026 09:16:09 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 1324840B9F
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:16:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769501767;
 bh=caxnvELbIcNwqvZTuF5zZPV41S/gARJGmVqZZRVWLqE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=RFNy2u8E75h+DoTfdb6KC7R+8Lv0g86QilHtvaOhwTj+vc5JZYHtOXcKMFnbyZe2W
 ueo1HYrsQ/0U1oysi6+/pG2keKxQfsis0MfZrEw+j4FrSuhwSooMXRqnT//ILad6eN
 ZE/ThKE3ajkdIqVUc2ayQb6cXTWYgAw3btzFJw0tVfFdpJN9SGSysW8wYh1qDoCstP
 B7bK6eS+MqVrWFBvS5+xY+ArbxSBVr65hMoP6ZO0S0MGapujGAje69HHf6QwFh5OHs
 vrh09rv16P8T/lplfr0Vf3EXnIYiHlBCaPvFj7+YjaNGTLGiz8t9Fti8anaszbYG1w
 Hv3JjJ1DI7yHg==
Received: from [IPv6:2001:718:812:27::107] (gtx107.cesnet.cz
 [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id D00AF118007E;
 Tue, 27 Jan 2026 09:16:07 +0100 (CET)
Message-ID: <9b4303e6a92aa8ca545a127f7e62ca9379d29b67.camel@cesnet.cz>
Subject: Re: [PATCH v4 3/6] net/nfb: update timestamp calculation to
 meaningful value
From: Martin Spinler <spinler@cesnet.cz>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Date: Tue, 27 Jan 2026 09:16:07 +0100
In-Reply-To: <20260126163427.19050072@phoenix.local>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
 <20260121170120.268553-4-spinler@cesnet.cz>
 <20260126163427.19050072@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
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

On Mon, 2026-01-26 at 16:34 -0800, Stephen Hemminger wrote:
> On Wed, 21 Jan 2026 18:01:17 +0100
> spinler@cesnet.cz wrote:
>=20
> > From: Martin Spinler <spinler@cesnet.cz>
> >=20
> > The resulting timestamp wasn't monotonically increasing value.
> >=20
> > Now the timestamp is value in nanoseconds (Unix epoch).
> >=20
> > Unfortunately there's currently no safe mechanism in nfb-framework
> > to get ticks from hardware to implement read_clock function.
> >=20
> > Signed-off-by: Martin Spinler <spinler@cesnet.cz>
>=20

Together with the comment in another email thread

> 5. **Patch 8**: Release notes mention timestamp changes not present in th=
is series
> Good to address.

it seems, that the "[v4,3/6] net/nfb: update timestamp calculation to
meaningful value" from "net/nfb: code cleanup" series was my rash act,
as it resolves just one of many issues.
Would it be possible to revert back this series to "Change Requested"
state? I would remove just this one patch from series and resubmit. Or
can you suggest a better solution?


> While review this code, noticed some things that are related.
>=20
> 1. Why is nfb_eth_ndp_rx in a header file, it is only called one place.
>    C code should be in the .c file.

1. I completely agree, I usually don't touch code that I don't need to
modify (except comprehensive cleaning), but I will address this issue
in one of the next series (concerning queues), which I already have
semi-prepared; there is some cleaning up anyway.

> 2. It is marked as always inline, but since it is called by an indirect
>    function pointer, dev->rx_burst it is never going to be inlined anyway=
.

2. I see, perhaps the original author hoped, that always inline would
be faster=C2=A0this way? :)

> 3. This could be simplified.
>=20
> 	/* returns either all or nothing */
> 	i =3D rte_pktmbuf_alloc_bulk(ndp->mb_pool, mbufs, nb_pkts);
> 	if (unlikely(i !=3D 0))
> 		return 0;
>=20
> 	/* returns either all or nothing */
> 	if (unlikely(rte_pktmbuf_alloc_bulk(ndp->mb_pool, mbufs, nb_pkts) !=3D 0=
))
> 		return 0;
> 4. You are fighting against line length here:
> 			if (nfb_timestamp_dynfield_offset >=3D 0) {
> 				rte_mbuf_timestamp_t timestamp;
>=20
> 				/* seconds */
> 				timestamp =3D
> 					rte_le_to_cpu_32(*((uint32_t *)
> 					(packets[i].header + 8)));
> 				timestamp *=3D NSEC_PER_SEC;
> 				/* nanoseconds */
> 				timestamp +=3D
> 					rte_le_to_cpu_32(*((uint32_t *)
> 					(packets[i].header + 4)));
> 				*nfb_timestamp_dynfield(mbuf) =3D timestamp;
> 				mbuf->ol_flags |=3D nfb_timestamp_rx_dynflag;
> 			}
>    Either add a helper function expand since current DPDK max line length=
 is 100.

4. Agree, I needed/have a shared function in my next series (offloads
and new/alternative queue driver) already.

>    It looks like you are using pointer math rather than a structure.
>    Also does the driver just use timespec? I.e is it safe in 2038 with a =
64 bit seconds?

Unfortunately the firmware is not prepared to Y2038: needs more thought
in our team to find the solution.


> Something like?
>=20
> struct nfb_meta {
>        rte_le32_t rx_hisecs;
>        rte_le32_t rx_losecs;
>        rte_le32_t rx_nsecs;
> };

Makes more sense.

>=20
> static inline void
> nfb_set_timestamp(struct rte_mbuf *mbuf, const void *header)
> {
> 	const struct nfb_meta *hdr =3D header;
> 	rte_mbuf_timestamp_t timestamp;
>=20
> 	timestamp =3D (((uint64_t) rte_le_to_cpu_32(hdr->rx_hisecs) << 32)=20
> 		    + (uint64_t) rte_le_to_cpu_32(hdr->rx_losec)) * NS_PER_SEC;
> 	timestamp +=3D rte_le_to_cpu_32(hdr->rx_nsecs);
> =09
> 	*nfb_timestamp_dynfield(mbuf) =3D timestamp;
> 	mbuf->ol_flags |=3D nfb_timestamp_rx_dynflag;
> }
>=20
> 5. Using volatile for statistics is unnecessary and slows down
>    code. Since only one thread can update them there is no need.
>    It seems that lots of drivers cut-paste this off old code.
>    The one exception would be if the driver supported TX lockfree
>    but in that case it would need real atomics.
> 6. Driver should consider getting rid of variable length arrays.
>    VLA's are a bug trap and a GNU extension. It is perfectly reasonable
>    to have an upper bound on burst size of something like 64 bytes.
>=20
> 7. Driver could use rte_pktmbuf_free_bulk instead of loops in partial rx =
case.
>=20
> 8. offload flags should already be set correctly when mbufs are allocated=
.
>    doing mbuf->ol_flags =3D 0 is not needed (but harmless).
>=20
> 9. You might consider using rte_pktmbuf_append() which would standardize
>    update to mbuf and avoid the current situation where if packet receive=
d
>    is bigger than space in the mbuf pool, the driver will corrupt the mbu=
f.
>=20
> 10. The driver probably haven't been tested with multiple ports.
>     But the expected behavior is that timestamp is configure per-port.
>     Most drivers have a flag and only add timestamp if it has been
>     configured per-port.

10. you are right. I'm addressing that in other series.

>=20
> Since driver is using time since 1/1/1970, you can just use UTC time
> for read_clock. Except if there is no time sync between CPU and NIC.
> Maybe just compute offset once on first packet received?

UTC time is good hint for read_clock. I think it should work quite
well. But I need to think it through/test more.
(There is separate NFB tool/daemon, which configures/synchronises the
Timestamp Unit inside Firmware and also selects between external PPS
and CPU time. The usage varies for different applications, but the
values are still in nsecs.)

>=20
> Transmit has seem inline madness.
> =09

Thank you very much for all the other comments (3, 5, 6, 7 ,8, 9), they
are all relevant and I will try to incorporate them.
