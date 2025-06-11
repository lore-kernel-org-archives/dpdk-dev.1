Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E905C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5796440698;
	Wed, 11 Jun 2025 15:27:22 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4518C402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 15:27:20 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1D1FB203B878; Wed, 11 Jun 2025 06:27:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D1FB203B878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749648439;
 bh=U+tEusv1ytfkbyeM4PQ++d7uCIojqGVbdcrcHsgLkhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cc0FCHbmHFaQgVP27xAxbnx8sOCtnSSjG0kNhNPkLGGmxkDWqxp8xJndxfMgHGjLz
 gpT7RkJxDYGTVQqTQMxat1MBHZNEp04mbIzgmoenHVBiVpsRNnvQwEP9dPNE8yflYN
 shSh4vI9FYwUbj1xEzpRviE+2ZCWWk3HwP89OK+M=
Date: Wed, 11 Jun 2025 06:27:19 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 3/5] dev: export driver information with MSVC
Message-ID: <20250611132719.GC31263@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
 <20250611094532.1242167-4-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611094532.1242167-4-david.marchand@redhat.com>
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

On Wed, Jun 11, 2025 at 11:45:30AM +0200, David Marchand wrote:
> From: Andre Muezerie <andremue@linux.microsoft.com>
> 
> DPDK uses GCC attribute "used" through macro __rte_used to indicate
> that a variable not referenced in the code should be assumed being
> used and therefore not be optimized away. This technique is used to embed
> information in the binaries, by having crafted information stored in
> them.
> 
> MSVC offers similar functionality, but it differs significantly: MSVC
> requires a pragma to be used to send a command to the linker telling it
> explicitly the name of the symbol that should be included (even if not
> referenced). As a side-effect, variables called out to be included cannot
> be static, otherwise their symbols are not "seen" by the linker. This
> restriction requires some DPDK code to be refactored.
> 
> To assimilate these requirements/restrictions, a new macro
> RTE_PMD_EXPORT_SYMBOL is added in this patch to ensure these special
> variables make it to the final binaries.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
