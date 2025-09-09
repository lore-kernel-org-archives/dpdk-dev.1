Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27DFCA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 08:08:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08BB5402D3;
	Tue,  9 Sep 2025 10:08:27 +0200 (CEST)
Received: from lf-1-15.ptr.blmpb.com (lf-1-15.ptr.blmpb.com [103.149.242.15])
 by mails.dpdk.org (Postfix) with ESMTP id 28AD840281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 10:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1757405299; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=y6h8s/4rr8Qan9c0BlM2q1cdn6K0M+XV3ImfmWfOIpw=;
 b=arUvWk5bQG71PSyBF23mLDYP+GqKOpF06r3t1RZWXVe/KxbcFdkHYdXOoZS6qmuuGKiiuy
 o2ByZcFw+lNv+WqslkI4BiemfNYOzSKvQqp6bbj0jeUl4Ej40b/SUrXfKaYNZdQgHODK5x
 RTRt18zxQxfFt25TEokbMviqLGL+MRKCS81+OEvDeCx0qKA2BB0Pc4nMlKXabpnrjPy6eA
 5nj25zM75yebMinEYZqsukWrJ+isRRCFkTm05OUo3zUGJgdG2K4RS8TDEkjPLZ9InkLre4
 XbA5yRoE43QTskjfMb8hncrltPoTUYBR/NU9n2hPRqgB+ov1PwTeFtOosH4tDQ==
Message-Id: <f50263c8-895e-4878-962e-f888f599bd90@yunsilicon.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <20250909070427.2711048-1-david.marchand@redhat.com>
Received: from [127.0.0.1] ([58.34.192.114]) by smtp.feishu.cn with ESMTPS;
 Tue, 09 Sep 2025 16:08:15 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+268bfe071+5ed429+dpdk.org+wanry@yunsilicon.com>
Cc: <thomas@monjalon.net>, "Na Na" <nana@yunsilicon.com>, 
 "Rong Qian" <qianr@yunsilicon.com>, 
 "Xiaoxiong Zhang" <zhangxx@yunsilicon.com>, 
 "Dongwei Xu" <xudw@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: Re: [PATCH] net/xsc: fix use after free in some RXQ cleanup
Date: Tue, 9 Sep 2025 16:08:14 +0800
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
References: <20250909070427.2711048-1-david.marchand@redhat.com>
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

Thanks David for catching this issue.
We'll address it in the 25.11 release.

On 2025/9/9 15:04, David Marchand wrote:
> Debian 12 gcc complains about a use after free in this cleanup section.
>
> [7/11] Compiling C object drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_rx.c.o
> In function 'xsc_rss_qp_create',
>      inlined from 'xsc_rxq_rss_obj_new' at ../drivers/net/xsc/xsc_rx.c:565:8:
> ../drivers/net/xsc/xsc_rx.c:501:9: warning: pointer 'req' may be used after
> 	'free' [-Wuse-after-free]
>    501 |         free(req);
>        |         ^~~~~~~~~
> ../drivers/net/xsc/xsc_rx.c:501:9: note: call to 'free' here
>
> Indeed, req may be free'd twice, as an error in the cleanup loop may
> jump back to the set_qp_fail label.
>
> Instead, skip the erroneous rxq and don't touch errno since all the code
> jumping to set_qp_fail already sets it.
>
> Fixes: 3991c890fb4c ("net/xsc: optimize RSS queue creation")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>   drivers/net/xsc/xsc_rx.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
> index 5f8003a1f6..5ff3f818c2 100644
> --- a/drivers/net/xsc/xsc_rx.c
> +++ b/drivers/net/xsc/xsc_rx.c
> @@ -502,10 +502,8 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
>   	for (i = 0; i < set_last_no; i++) {
>   		xsc_unset_qp_info(xdev, rqn_base + i);
>   		rxq_data = xsc_rxq_get(priv, i);
> -		if (rxq_data == NULL) {
> -			rte_errno = EINVAL;
> -			goto set_qp_fail;
> -		}
> +		if (rxq_data == NULL)
> +			continue;
>   		rte_memzone_free(rxq_data->rq_pas);
>   		rxq_data->rq_pas = NULL;
>   	}


-- 
Best regards,
Renyong Wan
