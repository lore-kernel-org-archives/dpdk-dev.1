Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98526C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 17:08:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC21740647;
	Wed, 19 Feb 2025 18:08:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CE4184028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:08:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 281882043DE3; Wed, 19 Feb 2025 09:08:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 281882043DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739984892;
 bh=T97JhCqfkf9kMnbaYq/TYHVcQFj41XoHUlCjk2v9I/E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eDw5oOL9T6Qi/rEHV4Pw0ObVeDSrNBgWGL3jRS+k9YOI2nGheGWgOyyfPWFZcNZnV
 2LukpNSYjOzEH5HOcX0OSdU6k8PrJjAAXsf9bA0CUxBNWHEJ630+mPLXyHm3hInd2d
 dbCYxbLXsgpbP+FfQy+boUPszfpIJ1EMg+QIB+sg=
Date: Wed, 19 Feb 2025 09:08:12 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 03/10] test-pmd: fix printf format string mismatch
Message-ID: <20250219170812.GA10716@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-4-git-send-email-andremue@linux.microsoft.com>
 <Z7S5gGEGpNqwoctj@bricha3-mobl1.ger.corp.intel.com>
 <20250218170300.GA6575@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z7S-N5qDe1RYlsci@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7S-N5qDe1RYlsci@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, Feb 18, 2025 at 05:07:03PM +0000, Bruce Richardson wrote:
> On Tue, Feb 18, 2025 at 09:03:01AM -0800, Andre Muezerie wrote:
> > On Tue, Feb 18, 2025 at 04:46:56PM +0000, Bruce Richardson wrote:
> > > On Tue, Feb 18, 2025 at 08:32:02AM -0800, Andre Muezerie wrote:
> > > > Compiling with MSVC results in warnings like the one below:
> > > > 
> > > > app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
> > > >     '%d' requires an argument of type 'int',
> > > >     but variadic argument 1 has type 'uint64_t'
> > > > 
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > > > ---
> > > >  app/test-pmd/csumonly.c | 23 ++++++++++++-----------
> > > >  1 file changed, 12 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> > > > index d77a140641..8de5ad6ad9 100644
> > > > --- a/app/test-pmd/csumonly.c
> > > > +++ b/app/test-pmd/csumonly.c
> > > > @@ -1070,7 +1070,7 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
> > > >  				info.l2_len, rte_be_to_cpu_16(info.ethertype),
> > > >  				info.l3_len, info.l4_proto, info.l4_len, buf);
> > > >  			if (rx_ol_flags & RTE_MBUF_F_RX_LRO)
> > > > -				printf("rx: m->lro_segsz=%u\n", m->tso_segsz);
> > > > +				printf("rx: m->lro_segsz=%" PRIu64 "\n", (uint64_t)m->tso_segsz);
> > > 
> > > tso_segsz is already uint64_t, so no need for the cast.
> > 
> > The compilers differ in behavior here. tso_segsz only uses 16 bits of the uint64_t,
> > and gcc tries to be smart about it and implicitly converts tso_segsz into an int
> > (since it fits into an int). Msvc does not do that, and keeps the type for tso_segsz
> > as uint64_t. To support both compilers it seems there's no way to avoid the cast.
> > 
> 
> Ok. Then can we just keep the %u and cast to either unsigned or uint16_t?
> No need to update the format char if we are casting, right?
> 
> /Bruce

Yes, I'll do that.
