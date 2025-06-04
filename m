Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D64C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:19:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7055E42E24;
	Wed,  4 Jun 2025 17:19:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id F2C9B402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:18:58 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 312B420BCAD3; Wed,  4 Jun 2025 08:18:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 312B420BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749050338;
 bh=tj7qyaq+uqOTxXLpW52xtF96pNdbrOEIt+9oStjjM2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vm8ilnBr8vU7aVjcY08hzzJASoM1VWyHfoDaXlbNzKV7bhm1v73swye6quNSN+uzI
 hZ4Ru+bZ0NPYtTEjSyWBJrPcGh1YjkyzkuapjNbEr0LjhtPSg5gaYdsUyDrJWacc1v
 EPxDbL2O8qT6QdIpd6bBAWd05KcV6J6hfG6+ozR4=
Date: Wed, 4 Jun 2025 08:18:58 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Patrick Robb <probb@iol.unh.edu>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org
Subject: Re: [PATCH] common/mlx5: avoid warning about operation mixing
 different enum types
Message-ID: <20250604151858.GC9366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
 <20250603164124.u7rrxwgwe2h5py2n@ds-vm-debian.local>
 <20250604074231.fc75n7ooaup75st6@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604074231.fc75n7ooaup75st6@ds-vm-debian.local>
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

On Wed, Jun 04, 2025 at 09:42:31AM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Tue, Jun 03, 2025 at 06:41:24PM +0200, Dariusz Sosnowski wrote:
> > Hi,
> > 
> > On Tue, May 27, 2025 at 04:41:25PM -0700, Andre Muezerie wrote:
> > > When compiling with MSVC, warnings like the one below pop up:
> > > 
> > > ../drivers/common/mlx5/mlx5_devx_cmds.c(554): warning C5287: operands
> > >     are different enum types
> > >     '<unnamed-enum-MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE>' and
> > >     '<unnamed-enum-MLX5_HCA_CAP_OPMOD_GET_MAX>'; use an explicit cast
> > >     to silence this warning
> > > 
> > > The values in both enums indicate that this sort of mixed bit
> > > manipulation is intentional, so this patch just uses an explicit
> > > cast to avoid the warning.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > 
> > Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> > 
> > Best regards,
> > Dariusz Sosnowski
> 
> @Patrick Could you please take a look at CI failures for this patch?
> Here is the test report log: https://mails.dpdk.org/archives/test-report/2025-May/882321.html
> There is a Fedora 41 compilation failure in "dpdk_compile_spdk".
> It seems on the related to the patch, because it fails in SPDK code.
> 
> @Andre Could you please take a look at CI failure on Windows?
> There is a unit tests failure on Windows Server 2022.
> 

Hi Dariusz,

I looked at the failed test. It should be unrelated to this patch. I ran
the same lcores_autotest on my machine compiling with MSVC and Clang
and it passed (with the changes in the patch).

For completeness, here is the output from CI:

44/92 DPDK:fast-tests / lcore_var_autotest             OK               0.35s
meson : ERROR: The process "4692" not found.
At C:\Users\builder\jenkins\workspace\Generic-VM-Unit-Test-DPDK@tmp\durable-3a3a8aa3\powershellScript.ps1:3 char:45
+ ...                      meson test --suite fast-tests -t 60 2>&1 | tee - ...
+                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (ERROR: The process "4692" not found.:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 
45/92 DPDK:fast-tests / lcores_autotest                TIMEOUT        629.35s
>>> DPDK_TEST=lcores_autotest MALLOC_PERTURB_=25 C:\Users\builder\jenkins\workspace\Generic-VM-Unit-Test-DPDK\dpdk\build\app\dpdk-test.exe --no-huge -m 2048

46/92 DPDK:fast-tests / logs_autotest                  OK               0.16s

Thanks,
Andre Muezerie

> Best regards,
> Dariusz Sosnowski
