Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF5CC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 14:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1D5E402AE;
	Thu, 10 Jul 2025 16:37:49 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 28661400D6
 for <dev@dpdk.org>; Thu, 10 Jul 2025 16:37:48 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4AA11211426E; Thu, 10 Jul 2025 07:37:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AA11211426E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1752158267;
 bh=PNrmDwQTaQrFPBE1FdUeMkk43cj7ExMeCdfLku6HI2w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UVpdlUn+21csE+1sWMy/AxD3qc0Tf9+s0q4MNdSj2UdrabS0tyVkLSYHYD8J80ywh
 yuvzCyUrYoH8LuHmMq7GfzhGH6bjIwQSgxxa3HFHOfQL/UecYMvGuFGahHIouKql14
 bgCGpPdxNmYA/hlRAmHf2yOR9Tsy+Ae6R5KhGneI=
Date: Thu, 10 Jul 2025 07:37:47 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH] rcu: add deprecation notice about limit on defer queue
 element size
Message-ID: <20250710143747.GA24344@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1747957021-2581-1-git-send-email-andremue@linux.microsoft.com>
 <4620749.daG60p0z9X@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4620749.daG60p0z9X@thomas>
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

On Tue, Jul 01, 2025 at 04:17:20PM +0200, Thomas Monjalon wrote:
> 23/05/2025 01:37, Andre Muezerie:
> > The functions rte_rcu_qsbr_dq_create and rte_rcu_qsbr_dq_reclaim establish
> > no limit on the size of each element in the defer queue.
> 
> Very good, we need more unlimited API in DPDK.
> 
> > With DPDK 25.11 a hard limit will be set (``RTE_QSBR_ESIZE_MAX``).
> 
> I think it is a step in the wrong direction.
> I prefer having no limit.
> 
> > This will allow fixed C arrays to be used in the functions' implementations,
> > avoiding VLAs and use of alloca().
> 
> I don't understand this justification.
> Why trying to remove the 2 alloca() in the lib RCU?
> 

Only because other developer expressed concerns that using alloca() allows
ill-intended callers to cause a stack overflow.
I personally also prefer to have no hardcoded limits.
