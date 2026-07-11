Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52226C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 06:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36E55402AB;
	Sat, 11 Jul 2026 08:40:18 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA164027F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 08:40:16 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0130CEC00CD;
 Sat, 11 Jul 2026 02:40:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 02:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783752015;
 x=1783838415; bh=SjIMdxpULsE8WFZ4KfBL86uD4+P785mAxUbE7Z+x4iM=; b=
 CbcQnNIAG1jbPWYLhOIYYzLVYRdXr/FRNtN4M0Qz+tMdaVp+xCshFJQLLz0lraA6
 x7HHYBoDUrCe8yS6U9toMJNHBCIUvLm/Ifvi+QOfXD5TE0LLKdMhuujnldj3H9RY
 /0FSucsbLJXvn5o8PbJd1zzZQDyp93I8CiL6ROxaxrS2x9tDzgHP1LMoq3TsmE3R
 encdB65x7M6qRM9EgTQW8xcLPs6HH6gZ4+PBEZiPPDxn6lI8ah/ZqXbwA63hqFkk
 bVkBkUM4tmgEDlvQEszfMn4xHxWPMe/AUxuJwboelMUOkdwpcMkF4hFlhaVJG6q+
 lwX6Vsy1RcoJTMtBN3Xu4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783752015; x=
 1783838415; bh=SjIMdxpULsE8WFZ4KfBL86uD4+P785mAxUbE7Z+x4iM=; b=J
 yb1Ng3vWCqiOny4FjP1csu0VExmVRvE5A8OdBRuEHWR+vC/keBjCJ/dtx27LOvDX
 9mcnlpPHsHdai4oXoQO0b/gCHfI9uwnRABP7d4yc/uvcoIehEc2Bu9q9YrvxK1vM
 qwkAZUzYTG14ifqG4d1/UGtGFkUJX0h7tqlMJLJcG0zNeLzaIPrlV9qQlk59nyrz
 Q5o9+SFSEwtbk3jW3QD6vbkGugTF47EiJsjscsrPjaOFZUX0rL6ubLsQq5mMtD6L
 uJ9tadnDg9jGhs3eVDqrL+LZzDuybxw9nfH/d4tVVdOh53cFoYfwS6SQ/DqecLsC
 ITMP4XV3jNumwueMvETKQ==
X-ME-Sender: <xms:T-VRams-sMz-qqe7zBmGkBqHKAlM9Kdi9wtZJ6xjUAK271IYcHuwhA>
 <xme:T-VRam4DWSKCk3wdrtXoRC6kZyb_HgzWr9wydlKqskiYqX1_-mR1C4EVpTxjUgjDG
 3SKLeWHOei-ySfIOJk4jCaanE2Bw2_pOdB5EzStlYB-f0_mAQowLQg>
X-ME-Received: <xmr:T-VRalRdTq5c7znO4UBfJ4f_j-40bgafTtZ4liwBAzSir6iAZrMu0eY6MSRPeFUACsTekWqu_gGyhJi5j-ZponzsDQ>
X-ME-Proxy-Cause: dmFkZTFJ7l9cKBI3vHzTTrrd24i8PK8GHY3E1d0uB6sarYCFSb35oiflG0IB3lU5vhCfSg
 VOwxOrP6JH15N0GWkkGCL/FAI9V5CaGTgxzT4GvBP2C9rFcW8ekA9XwYp/mjLhfJr8StIy
 aYh7Sbp5Hs3dAVp59YoqcUpuj0AnGDiKMQuW1z7cnpqGU7HYEijuk1zXfj5cW2vnFR6OkU
 y9EY6QXRn43271KvH0J4KCZT4nYAnOWkEjVtKTn4qJxPEZVhkQOiHCNKkeCiA6i9BX60om
 u8WpLMppgB7CvPAZUCYs1SzZnYcf28YEd/vYmuqlP3q5/CzuOVuVBHe6nWyAJIXxPCS/Ga
 P3OlHSCGbdhx9A4dqsH1SoG6MmvicSZbYgMJtofrZA+xHj0xW4XcHA09TSkBajCnth0dZG
 N6oBM1f8qJ7cBu6g5MJqW/AMeVh+TEA5yXz0IdRoGdZMyezRlQi4G/Wc7f452+t0TG+YBa
 ZXxpmkAfYrnFgwkjmN1C0pRGFgQD64ItpJozWP6LoFF3Br9vRkGVaF4US8vCxmeXEaCxRV
 BX/FqhytJe3XQlq/PgAPILUAgYUbqypWuTRGkdp5GaXo2wc51x9M2xU/K1lqjkJIBs7kIO
 IDZjYdZLCRecBmmMvWKjf+XE/l6oOjZJR1Umhzm4L5Srf2Tu83nG+A0ljTKw
X-ME-Proxy: <xmx:T-VRalob1Jviy7vBK3ukdnxrAtbR-rvzXl9OXqH_oNIcersbNpTVyw>
 <xmx:T-VRajIU7c-ZWb0Q4A0AioBLaFDNphJuWIlnTU7HUd-Ga1wiQWLEXA>
 <xmx:T-VRaoqvzwf-knSdB-9tXxcrv3xjU1yrDVcJX-cZs1WBlSND7E8gDg>
 <xmx:T-VRarx2cZ9GqXC6RTffyvu-Q1KQLNCrib0IsD8nJ7BLnTvX6Mq8kQ>
 <xmx:T-VRanNN2naunCZRneBO82FU_M-mT6auwJzd9-t67ODipXCZbDU0izxq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 02:40:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jun Yang <jun.yang@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: stephen@networkplumber.org, david.marchand@redhat.com, dev@dpdk.org
Subject: Re: [PATCH v7 05/16] bus/dpaa: shutdown DPAA FQ by fq descriptor
Date: Sat, 11 Jul 2026 08:40:12 +0200
Message-ID: <jPFKzjxBR_Kp3NkAADUufA@monjalon.net>
In-Reply-To: <20260703124950.1895871-6-hemant.agrawal@nxp.com>
References: <20260702053359.3243907-1-hemant.agrawal@nxp.com>
 <20260703124950.1895871-1-hemant.agrawal@nxp.com>
 <20260703124950.1895871-6-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

03/07/2026 14:49, Hemant Agrawal:
> From: Jun Yang <jun.yang@nxp.com>
> 
> Pass the full FQ descriptor to qman_shutdown_fq() instead of
> just the fqid, so that channel-affine portals can be correctly
> accessed when shutting down push-mode Rx queues.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> ---
>  drivers/bus/dpaa/base/qbman/qman.c  |  9 +++++----
>  drivers/bus/dpaa/include/fsl_qman.h | 11 ++++++++++-
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> --- a/drivers/bus/dpaa/base/qbman/qman.c
> +++ b/drivers/bus/dpaa/base/qbman/qman.c
> @@ -2781,18 +2781,19 @@ qm_mc_result_timeout(struct qm_portal *portal,
>  
>  RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq)
>  int
> -qman_shutdown_fq(u32 fqid)
> +qman_shutdown_fq(struct qman_fq *fq)

You did not change the call:

drivers/net/dpaa/dpaa_ethdev.c:1124:29: error:
passing argument 1 of 'qman_shutdown_fq' makes pointer from integer without a cast [-Wint-conversion]
 1124 |         qman_shutdown_fq(rxq->fqid);



