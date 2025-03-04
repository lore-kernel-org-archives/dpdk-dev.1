Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD811C282D1
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 02:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A18FD40156;
	Tue,  4 Mar 2025 03:15:06 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D9DB440041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 03:15:04 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0EAAF210EAD4; Mon,  3 Mar 2025 18:15:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EAAF210EAD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741054504;
 bh=+fOvbgxprTHtQOI9TUNYHXpSOtukUQG00vGPaKu8WZk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VZcpICMIBgis+/39YvOkQVxuXiT8kUZTEKXStpZ9ZR4hQEBwGAZAm2+qa4vp6paRM
 EohSoylvLJXwCpZyLYFarhbim5IGyKWMImstt4vjvSsEqGGmDyD1+bccNGysjGCiy9
 3VbsN90ykzr4AOce+Kt+moNJNF/LEsy3Hv412058=
Date: Mon, 3 Mar 2025 18:15:04 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] drivers/common: avoid truncation of constant value
Message-ID: <20250304021504.GA10309@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1734537913-1159-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734537913-1159-1-git-send-email-andremue@linux.microsoft.com>
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

On Wed, Dec 18, 2024 at 08:05:12AM -0800, Andre Muezerie wrote:
> This issue was flagged by MSVC warning below:
> 
> drivers\common\idpf\base/virtchnl2.h(269): warning C4309:
>     'initializing': truncation of constant value
> 
> The problem is that 64-bit numbers are initialized in an enum.
> 
> The C11 standard states: The expression that defines the value of an
> enumeration constant shall be an integer constant expression that
> has a value representable as an int. [Section 6.7.2.2]
> 
> As a result compilers end up truncating these numbers. MSVC and Clang
> do that. Gcc has an extension that makes it use a 64-bit size for the
> enum to avoid the truncation.
> 
> At the moment this truncation is only a real problem for
> VIRTCHNL2_CAP_OEM, but clearly all these capability flags are
> intended to be 64 bits long and therefore should better not be defined
> in an enum.
> 
> The fix is to use "defines" for them, as the code was using about
> 7 months ago before enums were introduced here. In this patch the
> flag names and values are being preserved, only the enum is being
> removed.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  drivers/common/idpf/base/virtchnl2.h | 59 ++++++++++++++--------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/common/idpf/base/virtchnl2.h b/drivers/common/idpf/base/virtchnl2.h
> index 3285a2b674..b6e28ade97 100644
> --- a/drivers/common/idpf/base/virtchnl2.h
> +++ b/drivers/common/idpf/base/virtchnl2.h
> @@ -239,35 +239,36 @@ enum virtchnl2_cap_rsc {
>  	VIRTCHNL2_CAP_RSC_IPV6_SCTP		= BIT(3),
>  };
>  
> -/* Other capability flags */
> -enum virtchnl2_cap_other {
> -	VIRTCHNL2_CAP_RDMA			= BIT_ULL(0),
> -	VIRTCHNL2_CAP_SRIOV			= BIT_ULL(1),
> -	VIRTCHNL2_CAP_MACFILTER			= BIT_ULL(2),
> -	VIRTCHNL2_CAP_FLOW_DIRECTOR		= BIT_ULL(3),
> -	VIRTCHNL2_CAP_SPLITQ_QSCHED		= BIT_ULL(4),
> -	VIRTCHNL2_CAP_CRC			= BIT_ULL(5),
> -	VIRTCHNL2_CAP_FLOW_STEER		= BIT_ULL(6),
> -	VIRTCHNL2_CAP_WB_ON_ITR			= BIT_ULL(7),
> -	VIRTCHNL2_CAP_PROMISC			= BIT_ULL(8),
> -	VIRTCHNL2_CAP_LINK_SPEED		= BIT_ULL(9),
> -	VIRTCHNL2_CAP_INLINE_IPSEC		= BIT_ULL(10),
> -	VIRTCHNL2_CAP_LARGE_NUM_QUEUES		= BIT_ULL(11),
> -	/* Require additional info */
> -	VIRTCHNL2_CAP_VLAN			= BIT_ULL(12),
> -	VIRTCHNL2_CAP_PTP			= BIT_ULL(13),
> -	VIRTCHNL2_CAP_ADV_RSS			= BIT_ULL(15),
> -	VIRTCHNL2_CAP_FDIR			= BIT_ULL(16),
> -	VIRTCHNL2_CAP_RX_FLEX_DESC		= BIT_ULL(17),
> -	VIRTCHNL2_CAP_PTYPE			= BIT_ULL(18),
> -	VIRTCHNL2_CAP_LOOPBACK			= BIT_ULL(19),
> -	/* Enable miss completion types plus ability to detect a miss completion
> -	 * if a reserved bit is set in a standard completion's tag.
> -	 */
> -	VIRTCHNL2_CAP_MISS_COMPL_TAG		= BIT_ULL(20),
> -	/* This must be the last capability */
> -	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
> -};
> +/* Other capability flags.
> + * Note: Not using an enum for these flags because these are 64-bit numbers,
> + * which might not fit in an int the enum maps to.
> + */
> +#define VIRTCHNL2_CAP_RDMA			RTE_BIT64(0)
> +#define VIRTCHNL2_CAP_SRIOV			RTE_BIT64(1)
> +#define VIRTCHNL2_CAP_MACFILTER			RTE_BIT64(2)
> +#define VIRTCHNL2_CAP_FLOW_DIRECTOR		RTE_BIT64(3)
> +#define VIRTCHNL2_CAP_SPLITQ_QSCHED		RTE_BIT64(4)
> +#define VIRTCHNL2_CAP_CRC			RTE_BIT64(5)
> +#define VIRTCHNL2_CAP_FLOW_STEER		RTE_BIT64(6)
> +#define VIRTCHNL2_CAP_WB_ON_ITR			RTE_BIT64(7)
> +#define VIRTCHNL2_CAP_PROMISC			RTE_BIT64(8)
> +#define VIRTCHNL2_CAP_LINK_SPEED		RTE_BIT64(9)
> +#define VIRTCHNL2_CAP_INLINE_IPSEC		RTE_BIT64(10)
> +#define VIRTCHNL2_CAP_LARGE_NUM_QUEUES		RTE_BIT64(11)
> +/* Require additional info */
> +#define VIRTCHNL2_CAP_VLAN			RTE_BIT64(12)
> +#define VIRTCHNL2_CAP_PTP			RTE_BIT64(13)
> +#define VIRTCHNL2_CAP_ADV_RSS			RTE_BIT64(15)
> +#define VIRTCHNL2_CAP_FDIR			RTE_BIT64(16)
> +#define VIRTCHNL2_CAP_RX_FLEX_DESC		RTE_BIT64(17)
> +#define VIRTCHNL2_CAP_PTYPE			RTE_BIT64(18)
> +#define VIRTCHNL2_CAP_LOOPBACK			RTE_BIT64(19)
> +/* Enable miss completion types plus ability to detect a miss completion
> + * if a reserved bit is set in a standard completion's tag.
> + */
> +#define VIRTCHNL2_CAP_MISS_COMPL_TAG		RTE_BIT64(20)
> +/* This must be the last capability */
> +#define VIRTCHNL2_CAP_OEM			RTE_BIT64(63)
>  
>  /**
>   * enum virtchnl2_action_types - Available actions for sideband flow steering
> -- 
> 2.47.0.vfs.0.3

Hi,

Please review this patch when you get a chance.

Thanks,

Andre Muezerie
