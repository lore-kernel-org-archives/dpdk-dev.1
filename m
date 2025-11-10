Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB00CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 20:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3C484026D;
	Mon, 10 Nov 2025 21:25:27 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 65BD340264
 for <dev@dpdk.org>; Mon, 10 Nov 2025 21:25:26 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 295047A01AC;
 Mon, 10 Nov 2025 15:25:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 15:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762806325;
 x=1762892725; bh=y6ESMuR1DEFSYqQT5hxoLe/ntEf4815O8Jn5fwf5mJs=; b=
 tMa3Zx7MGklGFaFHiq5rVGWyVZAo/GFHDGY44OCLbBgkMULPNWFwLRzVVpcqW8Zi
 DpdJuwVoQ5mUnSBn8Ac9vZotXDABv2u2Mnv8h2ykCFMVCfmCu1gz0C9mbZbd48q3
 L/3Me/qj7iipRlldxRGyGQldEixxRw2ocqTHDQ5QZdiSqa6hpbrACtMcjlCnrpdA
 OIMRCJ6kN+/KzLx9zaiLLNvbzltFKlhZ3bY8llOl4LG3ynSCkLU+tNamWbds55Rp
 WXff2sa6rUn/Mo5hp6lA55l5J850MaC5hu+aASRsO9tdqx25pIKxCBDTY0DS4t25
 Pk/NUaOHOXU1k+DSl4LzVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762806325; x=
 1762892725; bh=y6ESMuR1DEFSYqQT5hxoLe/ntEf4815O8Jn5fwf5mJs=; b=b
 03ftU56VoJpr7cspaiEWMDa/qvbOGeyO/mm/cvMJaLA1K864F6eo0wTcAecFvDln
 32TOW10HXk+EyxjwPScpX/wJTpmXzEt0KrfNw1LnVRlaPK3Ctp2ePn1LDdX/OvOF
 YBo5y6VDDw2WNXKiqH/26HbY/MwoYXnTxlTVZidjbL3bkIJrxF5G9TBxODCk4e5I
 CeYuNSBI1U5kPv45dXCfJGWSd5mveOLcyQ6C3WSFYYIBr8JobnNGlI1kRk62Ys0o
 OyeyryVNUbJnnsKgRVQYQTIPVmNkM+OA398WmbSZ64as/o5FOJgeyFdfVOpJDQ7d
 hzEPQR5mMt+MA2OdHVrDg==
X-ME-Sender: <xms:NEoSaYBFf9fLGJ-sS1MOTwVChqwB38QfTuUEeyMPO8Y1QxrnCZrazQ>
 <xme:NEoSaUn37n3njnFtBo3JyN8yQOBphv-3M26Hm9t5XcXp-FO_NBaPyBZ6lUjmYDmHW
 _vso5HQR7qSTqu2adwENwf8gma0WjxAsuJbEoxxv3Wnli1EVCY6>
X-ME-Received: <xmr:NEoSabc7EQpUs_toJEZv-wl6s3IBTleVpUlKBMJ_korucgKCDOlAU0DNvQRLCY_mZttaIKvnbSG5y86B505BbN9cVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelvdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrjhhithdrkhhhrghprghruggvsegsrh
 horggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehjrgihrdguihhnghessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepshhhuh
 grnhhglhhinhdrfigrnhhgsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehpvght
 vghrrdhsphhrvggruggsohhrohhughhhsegsrhhorggutghomhdrtghomhdprhgtphhtth
 hopehmrghnihhshhdrkhhurhhuphessghrohgruggtohhmrdgtohhmpdhrtghpthhtohep
 shhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepug
 grvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:NEoSaQTSGRJKS_CJfjRw3BjCoEsWT-J-_DC3Lg26o5dIjkMNtpRaig>
 <xmx:NEoSaavB6o5i5oAJKHVVogWeosnmNLKZS3_6utw_bk1jFz91O8ki0g>
 <xmx:NEoSaZc1gQxHlGXS8AaSggKqPHBrMN6g7Lqxspv8QEEP_nwtYtcriA>
 <xmx:NEoSacYJnOpRvUPOa_lrZyHL82-oKV40Kr351Acpu8sXgJtrgATq5g>
 <xmx:NUoSaWbiFSUZMyUNEgMYnNVzSAAGwa5q0CSs0cwGhsq5ebzHx0Itcrs2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 15:25:22 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: ajit.khaparde@broadcom.com
Cc: dev@dpdk.org, Jay Ding <jay.ding@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Manish Kurup <manish.kurup@broadcom.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v5 17/57] next/bnxt/tf_ulp: meter and mac_addr cache
 cleanup
Date: Mon, 10 Nov 2025 21:25:19 +0100
Message-ID: <2559753.Hs2Xf39FnO@thomas>
In-Reply-To: <20251029160712.58519-18-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
 <20251029160712.58519-18-manish.kurup@broadcom.com>
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

I take this patch as a simple and short example of what is done
at Broadcom for upstreaming the driver updates once a year.

- One patch includes multiple unrelated changes.
- A change described in the commit log (increase from 512)
  does not appear in the code.

We could say a lot more about this series.
In general, bnxt management looks like a mess.
Why not updating more regularly with more attention to quality?
Is it because some files are generated?
Can we improve by upstreaming the real sources of generated files?


29/10/2025 17:06, Manish Kurup:
> From: Jay Ding <jay.ding@broadcom.com>
> 
> 1. Thor doesn't support meter stats. Add null pointer check on
>    ulp_mapper_mtr_stats_hndl_del.
> 2. Increased the number of mac_addr_cache from 512 to 2048.
>    Changed the data type in an error message.
> 
> Signed-off-by: Jay Ding <jay.ding@broadcom.com>
> Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
> Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
> ---
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 10 ++++++++++
>  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c   |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> index bc48e35c00..7f6a84e699 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> @@ -598,6 +598,16 @@ bnxt_flow_mtr_destroy(struct rte_eth_dev *dev,
>  	if (ret)
>  		goto parse_error;
>  
> +	oper = ulp_mapper_data_oper_get(ulp_ctx);
> +	if (!oper)
> +		goto parse_error;
> +
> +	if (oper->ulp_mapper_mtr_stats_hndl_del) {
> +		ret = oper->ulp_mapper_mtr_stats_hndl_del(mtr_id);
> +		if (ret)
> +			goto parse_error;
> +	}
> +
>  	BNXT_DRV_DBG(DEBUG, "Bnxt flow meter %d is deleted\n", mtr_id);
>  
>  	return 0;
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
> index e8cb1a3784..74cdd5c1da 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
> @@ -33,7 +33,7 @@ int32_t ulp_bit_alloc_list_alloc(struct bit_alloc_list *blist,
>  		return 0;
>  	}
>  	jdx = (uint32_t)(bsize_64 * ULP_INDEX_BITMAP_SIZE);
> -	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%x\n", jdx);
> +	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%d\n", jdx);
>  	return -1;
>  }




