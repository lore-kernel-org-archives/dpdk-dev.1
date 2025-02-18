Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9B8C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 17:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC2C1402CF;
	Tue, 18 Feb 2025 18:03:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E650340264
 for <dev@dpdk.org>; Tue, 18 Feb 2025 18:03:01 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 090D520376E5; Tue, 18 Feb 2025 09:03:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 090D520376E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739898181;
 bh=UeC+MXZDktX09tw8kCIP35IXOUWjMINQLTAlJKHOVeA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YN7gOW0OU5jj7wF6D4AUEXMOiTeyhmMmHDDxSu4KzTiwEcb8zx307gdpHkWT6lXQO
 2R7v1pJWysXJy8n2GMJGzjpv3jcqrG7EgPSIlQ+BboM2EMCft4P6QRt3TpX2LY1D4w
 p4+Ak0ibti8rwt9xKUmhvF8MYYfiGnsVa+tMbcBg=
Date: Tue, 18 Feb 2025 09:03:01 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 03/10] test-pmd: fix printf format string mismatch
Message-ID: <20250218170300.GA6575@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-4-git-send-email-andremue@linux.microsoft.com>
 <Z7S5gGEGpNqwoctj@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7S5gGEGpNqwoctj@bricha3-mobl1.ger.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Tue, Feb 18, 2025 at 04:46:56PM +0000, Bruce Richardson wrote:
> On Tue, Feb 18, 2025 at 08:32:02AM -0800, Andre Muezerie wrote:
> > Compiling with MSVC results in warnings like the one below:
> > 
> > app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
> >     '%d' requires an argument of type 'int',
> >     but variadic argument 1 has type 'uint64_t'
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
> >  app/test-pmd/csumonly.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> > index d77a140641..8de5ad6ad9 100644
> > --- a/app/test-pmd/csumonly.c
> > +++ b/app/test-pmd/csumonly.c
> > @@ -1070,7 +1070,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
> >  				info.l2_len, rte_be_to_cpu_16(info.ethertype),
> >  				info.l3_len, info.l4_proto, info.l4_len, buf);
> >  			if (rx_ol_flags & RTE_MBUF_F_RX_LRO)
> > -				printf("rx: m->lro_segsz=%u\n", m->tso_segsz);
> > +				printf("rx: m->lro_segsz=%" PRIu64 "\n", (uint64_t)m->tso_segsz);
> 
> tso_segsz is already uint64_t, so no need for the cast.

The compilers differ in behavior here. tso_segsz only uses 16 bits of the uint64_t,
and gcc tries to be smart about it and implicitly converts tso_segsz into an int
(since it fits into an int). Msvc does not do that, and keeps the type for tso_segsz
as uint64_t. To support both compilers it seems there's no way to avoid the cast.

> 
> >  			if (info.is_tunnel == 1)
> >  				printf("rx: outer_l2_len=%d outer_ethertype=%x "
> >  					"outer_l3_len=%d\n", info.outer_l2_len,
> > @@ -1082,28 +1082,29 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
> >  					    RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
> >  					    RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)) ||
> >  				info.tso_segsz != 0)
> > -				printf("tx: m->l2_len=%d m->l3_len=%d "
> > -					"m->l4_len=%d\n",
> > -					m->l2_len, m->l3_len, m->l4_len);
> > +				printf("tx: m->l2_len=%" PRIu64 " m->l3_len=%" PRIu64
> > +					" m->l4_len=%" PRIu64 "\n",
> > +					(uint64_t)m->l2_len, (uint64_t)m->l3_len,
> > +					(uint64_t)m->l4_len);
> 
> Same here, using casts and a changed print format seems wrong in the patch.
> Either we change the format string to match the variable type, or we cast
> the variables to match the format string. We should not do both, IMHO.

I also normally prefer to not see unnecessary casts in the code, but it looks like
it is needed in this case, as explained above.

> 
> >  			if (info.is_tunnel == 1) {
> >  				if ((tx_offloads &
> >  				    RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM) ||
> >  				    (tx_offloads &
> >  				    RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM) ||
> >  				    (tx_ol_flags & RTE_MBUF_F_TX_OUTER_IPV6))
> > -					printf("tx: m->outer_l2_len=%d "
> > -						"m->outer_l3_len=%d\n",
> > -						m->outer_l2_len,
> > -						m->outer_l3_len);
> > +					printf("tx: m->outer_l2_len=%" PRIu64
> > +						" m->outer_l3_len=%" PRIu64 "\n",
> > +						(uint64_t)m->outer_l2_len,
> > +						(uint64_t)m->outer_l3_len);
> >  				if (info.tunnel_tso_segsz != 0 &&
> >  						(m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> >  							RTE_MBUF_F_TX_UDP_SEG)))
> > -					printf("tx: m->tso_segsz=%d\n",
> > -						m->tso_segsz);
> > +					printf("tx: m->tso_segsz=%" PRIu64 "\n",
> > +						(uint64_t)m->tso_segsz);
> >  			} else if (info.tso_segsz != 0 &&
> >  					(m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> >  						RTE_MBUF_F_TX_UDP_SEG)))
> > -				printf("tx: m->tso_segsz=%d\n", m->tso_segsz);
> > +				printf("tx: m->tso_segsz=%" PRIu64 "\n", (uint64_t)m->tso_segsz);
> >  			rte_get_tx_ol_flag_list(m->ol_flags, buf, sizeof(buf));
> >  			printf("tx: flags=%s", buf);
> >  			printf("\n");
> > -- 
> > 2.48.1.vfs.0.0
> > 
