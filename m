Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5AC021B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 03:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D616402BC;
	Mon, 24 Feb 2025 04:54:49 +0100 (CET)
Received: from lf-1-18.ptr.blmpb.com (lf-1-18.ptr.blmpb.com [103.149.242.18])
 by mails.dpdk.org (Postfix) with ESMTP id 03B7640299
 for <dev@dpdk.org>; Mon, 24 Feb 2025 04:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740369281; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JJT2hJ0f8fJ0Cx16SR0LKgGXk9b41SvZXy1rbJ26Ds8=;
 b=BDMKVr5byult6X/ve1//paxCaqBwu/R7G6uE3MoBopyrdALyhCKsjhBlwn1H9qbxoiZQ8j
 z/pjxaxU1R+CJKifNN1coT0erJOdrS2BM6nD+Ey4GlDfti9dZWq9bIYsuZ2qykONqzUA+6
 nGLnYF3Wp8di0CfmFdppGp93pBFgaI1wNkUgwa7yteJTlwikZzKuHHIL1BRUTsYhu2lWDM
 WR61twv1dYLqmgh/e/I9y2oR4+8SQlJ8B7IHz+tsfmkBK7Lj2HXVDwa3ZcWSX+3ofgB4GO
 DWWfHO/cOiKZJOwPOUKfNYJKkiZao0AeBtQaGt5YSA29W9v548HCwJhmfOeLPA==
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
 <20250222093016.4b4d615b@hermes.local>
Subject: Re: [PATCH 00/12] net/xsc: Resolve issues from PVS and Coverity Scan
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
In-Reply-To: <20250222093016.4b4d615b@hermes.local>
Message-Id: <25b5abb1-334d-4fe6-8713-7e36d4952c57@yunsilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS;
 Mon, 24 Feb 2025 11:54:38 +0800
From: "Renyong Wan" <wanry@yunsilicon.com>
Date: Mon, 24 Feb 2025 11:54:38 +0800
User-Agent: Mozilla Thunderbird
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <qianr@yunsilicon.com>, 
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, <zhenghy@yunsilicon.com>
X-Lms-Return-Path: <lba+267bbed7f+c3130c+dpdk.org+wanry@yunsilicon.com>
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

Hello Stephen,

Thank you for your review.=C2=A0 I appreciate the detailed analysis and the=
=20
suggestions for improvements.
Please find my feedback bellow.

On 2025/2/23 1:30, Stephen Hemminger wrote:
> On Sat, 22 Feb 2025 11:57:59 +0800
> "Renyong Wan" <wanry@yunsilicon.com> wrote:
>
>> This patch series resolves several issues reported by PVS and Coverity S=
can,
>> which were earlier forwarded to us by Stephen Hemminger.
>>
>> ---
>> Renyong Wan (12):
>>    net/xsc: avoid integer overflow
>>    net/xsc: remove useless call
>>    net/xsc: address incorrect format warnings
>>    net/xsc: remove always-true if expressions
>>    net/xsc: avoid variable is assigned but not used
>>    net/xsc: check possible null pointer dereference
>>    net/xsc: avoid potential null pointer before used
>>    net/xsc: remove always-true part of if expression
>>    net/xsc: avoid assign the same value to a variable
>>    net/xsc: avoid initialize by same function
>>    net/xsc: optimize memcmp returns not 0 check
>>    net/xsc: avoid pointer cast to unrelated class
>>
>>   drivers/net/xsc/xsc_dev.c       |  2 +-
>>   drivers/net/xsc/xsc_ethdev.c    | 35 ++++++++----
>>   drivers/net/xsc/xsc_np.c        | 17 +++---
>>   drivers/net/xsc/xsc_rx.c        | 31 ++++++-----
>>   drivers/net/xsc/xsc_tx.c        |  7 +--
>>   drivers/net/xsc/xsc_vfio.c      | 97 ++++++++++++++++++++-------------
>>   drivers/net/xsc/xsc_vfio_mbox.c |  2 +-
>>   7 files changed, 111 insertions(+), 80 deletions(-)
>>
> Applied to next-net Great to see the Coverity issues fixed.
> Ran PVS Studio on it, and there are three potential things that could be =
fixed later.
>
> 1. xsc_ethdev.c (838)
> V1027	Pointer to an object of the 'rte_device' class is cast to unrelated=
 'rte_pci_device' class.
>
> This is a generic issue in bus_pci_driver.h that can be suppressed there.
Got it. Thank you.
>
> 2. xsc_rx.c (351)
> V522	There might be dereferencing of a potential null pointer 'rxq_data'.
>
> Looking at the code, there are two loops over the rxq's the first one jus=
t
> dereferences, and the second pass uses a helper function that could retur=
n NULL.
> Why not just use do direct index in second one:
The first one doesn't seem like a best solution. It should have used the=20
helper function xsc_rxq_get() and checked if returned null. I will=20
optimize it next time.
The second one seems to have been overlooked and not addressed. It=20
should check the reutrn value of xsc_rxq_get().
>
> -- a/drivers/net/xsc/xsc_rx.c
> +++ b/drivers/net/xsc/xsc_rx.c
> @@ -347,7 +347,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int p=
ort_id)
>          rqn_base =3D rte_be_to_cpu_32(out->qpn_base) & 0xffffff;
>
>          for (i =3D 0; i < priv->num_rq; i++) {
> -               rxq_data =3D xsc_rxq_get(priv, i);
> +               rxq_data =3D (*priv->rxqs)[i];
>                  rxq_data->wqes =3D rxq_data->rq_pas->addr;
>                  if (!xsc_dev_is_vf(xdev))
>                          rxq_data->rq_db =3D (uint32_t *)((uint8_t *)xdev=
->bar_addr +
>
>
> 3. xsc_vfio_mbox.c (575)
> V1048	The 'size' variable was assigned the same value.
>
> This one is harmless, since both commands have same size, the tool
> is just being annoying. Can suppress via comment
>
> --- a/drivers/net/xsc/xsc_vfio_mbox.c
> +++ b/drivers/net/xsc/xsc_vfio_mbox.c
> @@ -572,7 +572,7 @@ xsc_vfio_mbox_init(struct xsc_dev *xdev)
>          cmdq->req_lay =3D cmdq->req_mz->addr;
>
>          snprintf(name, RTE_MEMZONE_NAMESIZE, "%s_cmd_cq", xdev->pci_dev-=
>device.name);
> -       size =3D (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_l=
ayout);
> +       size =3D (1 << XSC_CMDQ_DEPTH_LOG) * sizeof(struct xsc_cmdq_rsp_l=
ayout); // -V1048
OK, I understand.=C2=A0 Since the "// -V1048" comment style will trigger an=
=20
error in checkpatch, I will use the "/*-V1048*/" instead.
>          cmdq->rsp_mz =3D rte_memzone_reserve_aligned(name,
>                                                     size, SOCKET_ID_ANY,
>                                                     RTE_MEMZONE_IOVA_CONT=
IG,

--=20
Best regards,
Renyong Wan
