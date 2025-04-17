Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D5C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 17:10:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03215400D6;
	Thu, 17 Apr 2025 19:10:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 11A5D400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 19:10:40 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D2BED21199E6; Thu, 17 Apr 2025 10:10:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2BED21199E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744909838;
 bh=I/ToKo+uV48Vd5m2bYWB2KdVil2kxjM6ePQ/cHIOb9U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pqDIO3rh45aOzxgoNM2C+5fcyu8RkP0SMrJ3D7AAT2d/Bj9DcxWqs0nZNR4DG1p/K
 u7IH6U9RfzcadIQadwseCSa2rKHolue4Fw58yKS7goXz/pXXBVYUq1ZxqBau27fjf3
 fe5tzbL/37d6z4XgCpuoLzJlkfm8RywgmVXyIxsU=
Date: Thu, 17 Apr 2025 10:10:38 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 4/4] drivers: use macro to embed information in binaries
Message-ID: <20250417171038.GA11942@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-5-git-send-email-andremue@linux.microsoft.com>
 <20250415170517.6a7b37b4@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415170517.6a7b37b4@hermes.local>
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

On Tue, Apr 15, 2025 at 05:05:17PM -0700, Stephen Hemminger wrote:
> On Mon, 14 Apr 2025 18:21:36 -0700
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
> > index b7f02f56e1..a4cbe6f42f 100644
> > --- a/drivers/baseband/acc/rte_acc100_pmd.c
> > +++ b/drivers/baseband/acc/rte_acc100_pmd.c
> > @@ -4082,9 +4082,9 @@ static struct rte_pci_driver acc100_pci_vf_driver = {
> >  		.drv_flags = RTE_PCI_DRV_NEED_MAPPING
> >  };
> >  
> > -RTE_PMD_REGISTER_PCI(ACC100PF_DRIVER_NAME, acc100_pci_pf_driver);
> > +RTE_PMD_REGISTER_PCI(ACC100PF_DRIVER_NAME, acc100_pci_pf_driver, __LINE__);
> 
> Rather than changing so many drivers, can't you just use __LINE__ in the macro?

Yes, that's possible, and would be better. I sent out a V4 with these changes.
