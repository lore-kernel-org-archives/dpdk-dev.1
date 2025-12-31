Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFABEEB56D
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 19:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F6194060B;
	Wed, 31 Dec 2025 20:28:13 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 200CA402D4
 for <dev@dpdk.org>; Wed, 31 Dec 2025 20:28:12 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so68241525e9.3
 for <dev@dpdk.org>; Wed, 31 Dec 2025 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767209292;
 x=1767814092; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrrQka4Sr1ZEGY/cM87KGmlfzjSavleQTquL7Ghi69A=;
 b=FYgv7Q+yffFnnANrZ4QtXnrp0YdPBaRoKxB2qnL0iktFVg7/tcm+1ToRFvDbaxBbud
 n8rdyQra5xhQuNSkhc8pRAMG793O7GYbW5lfKanaChaj5ipXUZdTyLcGN83Jk0viPaFg
 ymGSm+UoEmsL2enkIm9MzhuE0GqyIWuu7coS79wvKPAAiPkb6mIujjJSghz24TV0L0bs
 3wm2zpd4PN4A7zw+BiaBIdUBMzuYwBR58yLRJiMWR3TlgLB1WDXwPhBy5n33RHADARQe
 PyFz/ijFJJ0Gw0Fs8mDKaFK4zhuaznjggdcD9cBPvcvVfC+HqvaQh1OeCDWDcvwl2xlN
 GUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209292; x=1767814092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrrQka4Sr1ZEGY/cM87KGmlfzjSavleQTquL7Ghi69A=;
 b=X6Gp6lqLdPaoqKpZcvZIRkloM7EzhN6GPDN7ADwxqAxFtM7jPZ+NiCOdx2+JdZGu2m
 4jfGZMcWquslghxbyAP1af76Gi3A/ffqQgIEyyLuykDBRkegOnhpyAlQ7vveeYp+qVN6
 yH5HqXV08mbWWwYtYyyF9UoGGmRHL59918nP/+3GhyafKsoIPLlpkQHAf7Qxcm+WnNlI
 mLZEnP4aHeXq6xAfDldUKMan7qiL4c/SQzo4vprdXFuVpSf4hHDeAiAwPmjHY8be3a0u
 wusBR3tHvF2x2C97Nj50qkEeWEQFyZUb4RBrXlADgLqxrgHP1XjQoBWJKsD7s6jHVLzq
 NrMA==
X-Gm-Message-State: AOJu0Ywd6eI5WcWMWeNahyyBD/OM7nApus/8uB0L3Hsv5Tn/TXpLvt2m
 4T7ygYXGnBKRzqhPgTaSS4ypY7DkaCYhn3XWntwmtlWLAuzHSdmFtYLvQ+aJ6qc6luk=
X-Gm-Gg: AY/fxX4fu/dlwQtHu7welPcsSZlLGalzP9z5pVCIoA/TZ8L7pjh5PS2VghrEQakLHka
 12mN0bp3y+D49Fs86XpERQDEi5z2AL8Oqf3g50stwV+gI11AndtmUQWqLxZOv9Y9/mmcLG64FQi
 7RQ2RrX9gQH8997Hbh/tj+1SX8ArPC8pJAMcp1DoOMvEbBjgEjt64VboFiFI3JLjTOHMizKRCrA
 aJdH4CJWTq2AZEqWzxqAd0PwiGBGR2YG+FCRJAmS7MmAPZ9ZDbUe8c4xnpcmRmkzfCC67SQjuSh
 09vYpOvubBFnqRo8k4grVQpC/vMGVGIIAQcG9Fx2X5c1gLPeqkuiyWXDRPMTZTAGQo9cywHmFOO
 hEyx7ov9pTnDPg8AP90PO+Txv2WlUSSC7lB2cltKj/MKjD6K5bIEmi6eiqKMSCFEiahXzLpqa6K
 f5dkTBSiUyw4hpSSsgNTh3yIA6hOLSFpq1v4piMCSVSk1sGP0ebLU2
X-Google-Smtp-Source: AGHT+IH6tzeaNPJxfxRayLDTV/77KMi+IX9qYZPbljZd1C+AzJXTO/w9T+sedhltSyEFQTgLANA4uQ==
X-Received: by 2002:a05:600c:6299:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-47d1959ae49mr502145615e9.35.1767209291718; 
 Wed, 31 Dec 2025 11:28:11 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm728037815e9.8.2025.12.31.11.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:28:11 -0800 (PST)
Date: Wed, 31 Dec 2025 11:24:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/5] net/zxdh: add support set link speed get autoneg
 stats
Message-ID: <20251231112449.1da76d2b@phoenix.local>
In-Reply-To: <20251220061521.289722-4-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20251220061521.289722-4-wang.junlong1@zte.com.cn>
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

On Sat, 20 Dec 2025 14:15:19 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> +int32_t zxdh_link_speed_set(struct rte_eth_dev *dev)
> +{
> +	struct zxdh_hw *hw = dev->data->dev_private;
> +	struct zxdh_msg_info msg = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	uint32_t link_speed = 0;
> +	int32_t spm_speed_modes = 0;
> +	int32_t ret = 0;

Skip the excess initializations, you are setting spm_speed_mode almost immediately.

> +
> +	spm_speed_modes =
> +		zxdh_speed_mode_to_spm(dev->data->dev_conf.link_speeds & ~RTE_ETH_LINK_SPEED_FIXED);
> +	if (spm_speed_modes == -1 || spm_speed_modes == hw->speed_mode) {
> +		PMD_DRV_LOG(DEBUG, "not need update speed");
> +		return 0;
> +	}
> +	if ((spm_speed_modes & hw->support_speed_modes) == 0)  {
> +		PMD_DRV_LOG(ERR, "not support configure speed :%d ", link_speed);
> +		return 0;
> +	}
> +
