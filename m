Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC66CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 20:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F3FF4028F;
	Fri, 19 Jun 2026 22:54:37 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id D135240289
 for <dev@dpdk.org>; Fri, 19 Jun 2026 22:54:36 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304f590dd91so2872120eec.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781902475;
 x=1782507275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maoNopCDuhKJ5atT235OHxhT5bNrcPQeej27SyU612k=;
 b=ENYY9H3UR6y1cCMuiHnryMHeO5TcsZyCNtYG2JLYbEzzg5wc1Ny2un3PEuFS/+fFhS
 TDyBJYBSb38L7MR2rN9ySOR9tfl+aVqoSZ25fDJp+L5Egr8lBWZzr7+N7umUpAzw9tLd
 mGLN4uDj1l3Qm2WKivn6kM3Ydz0cDQgKhxO0UWOZsvmCKqdtYDiMSW1KGzEOxz+vqFrp
 luVooIv4+MEr80v78JvU0m8IA8Nq+CDjATIEZxRrbFE05NeuTZrHQmv7y1brreBKUGRh
 pnTq7evJfG5C5HYQkXnOcC6njbO7vFR1eM3UyOJtK8XnU+mGWmo9+aDVTo3ILb5jqykn
 2l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781902475; x=1782507275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=maoNopCDuhKJ5atT235OHxhT5bNrcPQeej27SyU612k=;
 b=DnFfg9Ah5ZGZMIqwCPxC2wiRP6hN9vHheMDYoELC42KkWmueDIgKtuIMGpvsJbPe7E
 tsdJAuzot80I/xYbgjZLRw8G4MGOu/9i16Z5nPsJJxJ/EI+dTuTntdIqk4S7d3ptT1bg
 irNc5cMUOWJR6ZTqAIC4A3acR7gr1r3Hr5lfwMjn9peCu9m/YlgsP8qpMfhHg7kMKua8
 u2D0GkKWNfm49rPuRmjGnpjSSyiEiAH52doutU+xqYNDNeP/DFycpe4z+cVy+mor5mmz
 SPodcjlDgdn5h3fC67mydhwTus5h9wLhhTtPdbRjHdOfrQLa8S6AMAs1+43lJ/z8IEDr
 l/fw==
X-Gm-Message-State: AOJu0Ywu8+yjuhHiZRF59JZLEvzK1yCV9sg54fkLnNMVXqjRGAt3y9Nl
 cGHMcCPQ77QzWeMhpF3/aYuJhtuljVgvd9BEgqRwIVLJykKp0K8m6jZeatg1RkLuPU+INbpfuOs
 gXDXr
X-Gm-Gg: AfdE7cnFVAAXAppyhxFcvF/lIWxzzKMVh7wcuoL8UH9fFT+LzdKWjmR0krStYj09yGs
 G3gc6uh91vMF7++tSUkbRonsIPjjY+G/xuEjx/zqdSAfUmHjAnwwaWklWJTZFbN1HpmwjecR1BN
 qIQuR5DgJ6PZ7EFm/0yGaYrMv9aa8BUgaTeGsAmaFHfTPo9DaE+CbuTvnjyU+aM58MEWrseahES
 xwK3LV3iZm2PNRP1z9fQULBm4GC36eNoIiGv1m7SxSPLcf6ei7LbmZg/n0pmhvg4py3gcBNoxEi
 XyTUp7zMVHZbtdwL7EmJIodb2aqqYEPo7GxTY2LA6+1Kbb+5hAaXOHloHYyv60Zpau0mC5mJnBe
 QMS5Uik/25vi3cN7dVAcQxYsuWRn+EZgkNO8joDJblzDRmY4VLVocY4cfL/wybwtl4f5KMWl6pf
 ALi0OR+WLlMfuHvlBTd/qa6oWd5HUY3NKS2vfanLmOeT2DmKGNYlL13g==
X-Received: by 2002:a05:7300:6423:b0:2f5:3fb3:4a76 with SMTP id
 5a478bee46e88-30c06e33471mr3176922eec.10.1781902475177; 
 Fri, 19 Jun 2026 13:54:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1be7eeb7sm888733eec.30.2026.06.19.13.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 13:54:34 -0700 (PDT)
Date: Fri, 19 Jun 2026 13:54:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 09/23] net/sxe2: support IPsec inline protocol offload
Message-ID: <20260619135432.4357896e@phoenix.local>
In-Reply-To: <20260619080812.1543972-1-liujie5@linkdatatechnology.com>
References: <20260618082723.571054-21-liujie5@linkdatatechnology.com>
 <20260619080812.1543972-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 19 Jun 2026 16:08:12 +0800
liujie5@linkdatatechnology.com wrote:

> diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
> index 19323ffcc4..7711e8e57d 100644
> --- a/drivers/net/sxe2/sxe2_cmd_chnl.c
> +++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
> @@ -877,3 +877,200 @@ int32_t sxe2_drv_tm_commit(struct sxe2_adapter *adapter)
>  l_end:
...

> +int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
> +					   uint16_t sa_id)
> +{
> +	struct sxe2_drv_ipsec_txsa_del_req req = { 0 };
> +	struct sxe2_drv_cmd_params cmd             = { 0 };
> +	struct sxe2_common_device *cdev = adapter->cdev;
> +	int32_t ret                                 = -1;
> +
> +	req.sa_idx = rte_cpu_to_le_16(sa_id);
> +	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_IPSEC_TXSA_DEL,
> +				 &req, sizeof(req),
> +				 NULL, 0);
> +	ret = sxe2_drv_cmd_exec(cdev, &cmd);
> +	if (ret)
> +		PMD_DEV_LOG_ERR(adapter, DRV,
> +				"Failed to delete tx sa, sa id: %u, ret: %d.",
> +				sa_id, ret);
> +
> +	return ret;
> +}
> +

git merge doesn't like extra blank lines at end of file.
Applying: net/sxe2: support IPsec inline protocol offload
/home/shemminger/DPDK/main/.git/worktrees/sxe2/rebase-apply/patch:236: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

