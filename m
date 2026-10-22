Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5D606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=T2/9KMXk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A84C402A2;
	Thu, 22 Oct 2026 08:17:59 +0200 (CEST)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 48BAE40299
 for <dev@dpdk.org>; Thu, 22 Oct 2026 08:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1792649871; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kO9cfSyzqRjbgCPWMnr7ajehI3amFKT5D48tuqcUDxc=;
 b=T2/9KMXks3LYkD70JNiTfKXztTiZL2zsspWsq6iCaX+AA8HUJnMgIiyo2+4C6+4Y18wwkp
 Lnm4juCRTx5/wyn/VvdXxdv9zVHW8Fh4EvuLJqSGaEqbGZpb4u3doDykNhlSgdRx6HrOnH
 Ikhr2/Rwsrl1f6E346W4BE8gtnYSR5QSHCrwSj2TL0Jur13fGQoWuxROZNtFnDrrl6Ax1m
 B6GVukaGxxTK+j9x5dLobxRoarY/JHhMLPHefFFR7AR8aT/1PhAyX6k7UQOZKNeFw6sEo2
 e3zU97/Rm6/V9MiBuCPKyA2GD13iMALd63/+DzJ9Z+v7c+QvkOxihK1UC/EAeQ==
In-Reply-To: <20261021103027.2050351-11-david.marchand@redhat.com>
Cc: <thomas@monjalon.net>, "Gaetan Rivet" <grive@u256.net>, 
 "Rosen Xu" <rosen.xu@altera.com>, 
 "Dimon Zhao" <dimon.zhao@nebula-matrix.com>, 
 "Leon Yu" <leon.yu@nebula-matrix.com>, 
 "Sam Chen" <sam.chen@nebula-matrix.com>, "Wei Hu" <weh@microsoft.com>, 
 "Praveen Shetty" <praveen.shetty@intel.com>, 
 "Jingjing Wu" <jingjing.wu@intel.com>, "Na Na" <nana@yunsilicon.com>, 
 "Rong Qian" <qianr@yunsilicon.com>, 
 "Xiaoxiong Zhang" <zhangxx@yunsilicon.com>, 
 "Dongwei Xu" <xudw@yunsilicon.com>, "Andy Pei" <andy.pei@intel.com>, 
 "Dan Wei" <dan.wei@intel.com>, "Junfeng Guo" <junfengg@nvidia.com>, 
 "Beilei Xing" <beilei.xing@intel.com>, 
 "Xiaoyun Li" <xiaoyun.li@intel.com>, "Mingxia Liu" <mingxia.liu@intel.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Thu, 22 Oct 2026 14:17:47 +0800
Message-Id: <79cd25f4-593a-4e66-b3ac-0a08ce258744@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 10/12] drivers/net: fix reported RSS capability
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ad9aa8d+5640bd+dpdk.org+wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-11-david.marchand@redhat.com>
User-Agent: Mozilla Thunderbird
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Received: from [127.0.0.1] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Thu, 22 Oct 2026 14:17:48 +0800
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 6:30 PM, David Marchand wrote:
> Some drivers (idpf, cpfl) report RSS support even if lacking HW support.
> On the other hand, some driver do have support but do not advertise it
> (either in dev_info, or in the documentation).
> 
> failsafe may support RSS, as it only passes the requests to the ports
> attached to it, hence mark it as partial support.
> 
> Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")
> Fixes: 70675bcc3a57 ("net/idpf: support RSS")
> Fixes: cfbc66551a14 ("net/cpfl: support RSS")
> Fixes: 5fb899f4b225 ("net/xsc: support RSS configuration")
> Fixes: 9f75cad1287f ("net/xsc: add PCT interfaces")
> Fixes: ff8db3711b29 ("net/nbl: support infos query")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - fixed ip3nke,
> - moved all RSS capabilities under check for idpf and cpfl,
> - adjusted xsc RSS capabilities,
> 
> ---
>   doc/guides/nics/features/failsafe.ini     | 1 +
>   doc/guides/nics/features/ipn3ke.ini       | 3 ---
>   doc/guides/nics/features/nbl.ini          | 1 +
>   doc/guides/nics/features/netvsc.ini       | 1 +
>   drivers/net/intel/cpfl/cpfl_ethdev.c      | 9 +++++----
>   drivers/net/intel/cpfl/cpfl_representor.c | 4 +++-
>   drivers/net/intel/idpf/idpf_ethdev.c      | 9 +++++----
>   drivers/net/xsc/xsc_ethdev.c              | 4 ++++
>   8 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
> index 5fbe68782e..20d6f58f68 100644
> --- a/drivers/net/xsc/xsc_ethdev.c
> +++ b/drivers/net/xsc/xsc_ethdev.c
> @@ -469,6 +469,10 @@ xsc_ethdev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>   	info->if_index = priv->ifindex;
>   	info->speed_capa = priv->xdev->link_speed_capa;
>   	info->hash_key_size = XSC_RSS_HASH_KEY_LEN;
> +	info->flow_type_rss_offloads = RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP |
> +		RTE_ETH_RSS_TCP | RTE_ETH_RSS_L3_SRC_ONLY |
> +		RTE_ETH_RSS_L3_DST_ONLY | RTE_ETH_RSS_L4_SRC_ONLY |
> +		RTE_ETH_RSS_L4_DST_ONLY | RTE_ETH_RSS_LEVEL_INNERMOST;
>   	info->tx_desc_lim.nb_seg_max = 8;
>   	info->tx_desc_lim.nb_mtu_seg_max = 8;
>   	info->switch_info.name = dev->data->name;

Looks good for net/xsc,

Reviewed-by: Renyong Wan <wanry@yunsilicon.com>

Thanks,
Renyong Wan
