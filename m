Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7E1C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20FDD42686;
	Mon, 24 Feb 2025 17:22:38 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C35EB410D5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:22:36 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 17D5520376FE; Mon, 24 Feb 2025 08:22:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17D5520376FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740414156;
 bh=MRHoHTd5YZ6/H8GKOsQhTuKxM7qzK3sSs8HLm9NIh5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i6xu9lg9MGkwJUi/ZmviDrzpCkBhpL5suT+mIIJp29ZHO46pnY4rUwuZmdi1YIt6T
 9GetXR73OtWKvwMqJImrUkHXDtXWJw0N3UVO78EyfvfuQuteO16s+VtGB32Mes0KDS
 DolU6P/grjJ+K6BL4q6P88Gi/uIkfeh041RdeiOk=
Date: Mon, 24 Feb 2025 08:22:36 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Cc: konstantin.ananyev@huawei.com, dev@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v5 08/10] test-pmd: declare lcore_count atomic
Message-ID: <20250224162236.GA11523@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-9-git-send-email-andremue@linux.microsoft.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA65@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA65@smartserver.smartshare.dk>
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

On Fri, Feb 21, 2025 at 09:58:28PM +0100, Morten Brørup wrote:
> > From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> > Sent: Friday, 21 February 2025 20.53
> > 
> > Compiling with MSVC results in the error below:
> > 
> > app/test/test_ring_perf.c(197): error C7712: address argument to atomic
> >     operation must be a pointer to an atomic integer,
> >     'volatile unsigned int *' is not valid
> > 
> > The fix is to mark lcore_count as atomic.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
> >  app/test/test_ring_perf.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
> > index 57cd04a124..921aa902c5 100644
> > --- a/app/test/test_ring_perf.c
> > +++ b/app/test/test_ring_perf.c
> > @@ -34,7 +34,7 @@ struct lcore_pair {
> >  	unsigned c1, c2;
> >  };
> > 
> > -static volatile unsigned lcore_count = 0;
> > +static volatile RTE_ATOMIC(unsigned int) lcore_count;
> 
> Using rte_atomic_xxx to access the RTE_ATOMIC qualified lcore_count seems more clean than making it volatile and sometimes access it non-atomically.
> It is only accessed two more times, so not a big change.
> 
> Anyway, this could just be my personal preference. No change required if you disagree.

Makes sense. I'll send an updated series.
