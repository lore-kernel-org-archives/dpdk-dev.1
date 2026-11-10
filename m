Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0460A5BC7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=OEX7tLHe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63CB44069D;
	Tue, 10 Nov 2026 08:12:00 +0100 (CET)
Received: from lf-1-33.ptr.blmpb.com (lf-1-33.ptr.blmpb.com [103.149.242.33])
 by mails.dpdk.org (Postfix) with ESMTPS id 351F4402B3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:11:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794294708; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UdkEB5abNhXEr9widbwkHZMJyd7f4cYM5WeBg9Me7SI=;
 b=OEX7tLHe9htv9c1IMZ4Gam8Wnm/C3QWclzEWoGxqF/Sqb6fuvcQikwqxCOKv0Li+7wlO05
 hoMQCYCoTikjGiyNVH3HUEGw/JRa3payUA9yftqY7NQxzI2htBQmGbqPKDg60etjU+imZs
 0r2vHV8El+Xu6t8Cp5Bc2qrALkwOlsheTyu4bQJep1QIS+Fv1E6ED0Ja+iMJBQ6FDc+qoM
 D2H5AEGHXtPWZdeqPpkiAfhn8ZxjasHo5UX9EPli3g87Qg7Qu7PWPBTAr/bJybI9bE5evA
 t7ZtsXlR3qXFxs09TrASuYShPez5s44K4qYyXpg0Kgxod+MFjQXUaOJj88B2WA==
Cc: <stable@dpdk.org>, "Na Na" <nana@yunsilicon.com>, 
 "Rong Qian" <qianr@yunsilicon.com>, 
 "Xiaoxiong Zhang" <zhangxx@yunsilicon.com>, 
 "Dongwei Xu" <xudw@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <48dac41b-9dc2-49b0-8052-6e349618c664@yunsilicon.com>
X-Lms-Return-Path: <lba+26af2c3b2+76eacb+dpdk.org+wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
In-Reply-To: <20261110021801.766315-1-stephen@networkplumber.org>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH] net/xsc: fix uninitialized return value in QP modify
Date: Tue, 10 Nov 2026 15:11:45 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Received: from [127.0.0.1] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Tue, 10 Nov 2026 15:11:45 +0800
User-Agent: Mozilla Thunderbird
References: <20261110021801.766315-1-stephen@networkplumber.org>
Content-Transfer-Encoding: 7bit
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

On 11/10/2026 10:18 AM, Stephen Hemminger wrote:
> If xsc_vfio_modify_qp_status() is called with num <= 0 the loop
> is skipped and an uninitialized value is returned.
> All current callers pass num = 1, but gcc 15 at -O1 cannot see
> that through the dev_ops indirection and reports:
> 
>    xsc_vfio.c:491:16: error: 'ret' may be used uninitialized
> 
> Initialize ret to 0.
> 
> Bugzilla ID: 2099
> Fixes: 31e84e37c0b9 ("net/xsc: support VFIO")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/net/xsc/xsc_vfio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
> index 0a1e507f7d..bae891cfba 100644
> --- a/drivers/net/xsc/xsc_vfio.c
> +++ b/drivers/net/xsc/xsc_vfio.c
> @@ -449,7 +449,7 @@ xsc_vfio_link_get(struct xsc_dev *xdev, struct rte_eth_link *link)
>   static int
>   xsc_vfio_modify_qp_status(struct xsc_dev *xdev, uint32_t qpn, int num, int opcode)
>   {
> -	int i, ret;
> +	int i, ret = 0;
>   	int in_len, out_len, cmd_len;
>   	struct xsc_cmd_modify_qp_mbox_in *in;
>   	struct xsc_cmd_modify_qp_mbox_out *out;

Thanks for the fix, Stephen.

Acked-by: Renyong Wan <wanry@yunsilicon.com>
