Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E9C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 280874066F;
	Wed, 11 Jun 2025 15:26:12 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C1CD1402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 15:26:10 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id BB93E211518E; Wed, 11 Jun 2025 06:26:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB93E211518E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749648369;
 bh=Ue9q5lRNJVEtTSqHxog/fQ+Xb5FXbZuHIbrKXH1R7Vg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f4//z6IMPGqafTOpugtVoW7eE+MuMAlv2Hz8fEvh/QcwdiGOhWtKeaIQOElHibJHG
 zOqnCn3ZvPN9TvvOxvePurtY7U5gMpo5dtUyV5TtZByi9Hk8L3EACv3nD319bpkfOc
 L1oDeJpKWIabLd1larAYOLlC5beBlKUSqX5+I8+U=
Date: Wed, 11 Jun 2025 06:26:09 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@altera.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 2/5] dev: rename pmdinfo internal symbols
Message-ID: <20250611132609.GB31263@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
 <20250611094532.1242167-3-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611094532.1242167-3-david.marchand@redhat.com>
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

On Wed, Jun 11, 2025 at 11:45:29AM +0200, David Marchand wrote:
> __COUNTER__ is not supported by MSVC.
> Plus the this_pmd_name* symbols will become global (again for MSVC) in a
> next commit.
> Prefer the driver name to generate a unique symbol.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
