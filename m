Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF997C5DF9F
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Feb 2026 05:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF2014025A;
	Sat, 21 Feb 2026 06:16:20 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id 953CC40150
 for <dev@dpdk.org>; Sat, 21 Feb 2026 06:16:19 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7d4c3896e32so1017370a34.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 21:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771650978;
 x=1772255778; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJQakq0VnzygcrGqVcqePAe6bFzhTR6vp8lFDTKDnnI=;
 b=uiqZTv/cABFQLxN0GXLXSBNY6415V4PKtPtvcledVJy3LuJJh2XZq61slf6ZaRHvSZ
 GhvkD8UASIVo+1iiJPX/7dUp/vOqu6HFtnPHfXAQYgL2m8YAr9CLjfyGX3hmVEuiSeFU
 Oa9IJw2GDer9+SUCiVwRsqHdPkdj8AO0yvrRr6SagjUWoNQHz1kZ4++jgKhGd7jZKSQg
 isKlD+wNRWBZocQnrw5Zve8H6CYDcNTpdHIsnj0ajKnlFkdJQCw2u7qbSC1Rwp9K5F13
 zpu8/7hD6/JXZWTV+le4weVvSkbsQy0F+Kf1+MTDuG79ReT7+YpYoB7cc5fe7aPdAHt4
 obcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771650978; x=1772255778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJQakq0VnzygcrGqVcqePAe6bFzhTR6vp8lFDTKDnnI=;
 b=ZURBx4Sk6KFJnfIUGIfajryqp+r9USkXPOqBSBwg+qODGvg/lpuB/17DKEnxlUbhPY
 pKv7uTmXrsbEYGc8zRZEzDkr49bbJwpcVTy9hscsuOalVJ89Q1LLo3HaumQaL+dmK7wb
 dFBVoR4PKD9Mh5fXq9w4AUx+V7+eEyFQAy+nGZRR5a+9nvvwLefeZoQ7a1Rarfl/nLVX
 G//ZEuE23JHdxjtbqE6TkPPbImHJl1JmDuLwu7/xb8iYQqjNHNOii/CUjrxfNupfVDWe
 LRYBLUVyGRDrKSRg2gjljyeFBZUzbjWR8Y8gRnTAWXXa5TMtjb64BWMwHlFGXKCZV0tL
 ADLg==
X-Gm-Message-State: AOJu0Yzz0ukCPkuOPoHCFbBCCw39zrknoMehABWqrLT7yov53AVOi6a4
 GSiAJfZ7GO91MeAa4LOFGhH5843xhKmAgePs4D3QDheVc31Mu/Fr6IakTmH/rAJFwzU=
X-Gm-Gg: AZuq6aIc0KiLV+QlwhCzWyZi1vjrnAWiABjAOom7nA1vOsXer8w1MSRCy+rXyPwPEwr
 HgG3Co94hyWHm4f8cKVSLQbYpOR+O2OhEqcVn+4fIGnny9DmL48agjEp+mcTvxuXM2a8zsFAaAR
 WL0lFrhjnGZodES2VBVmTnuKOU1zbRrX6ve19EWX7qdiahlhyhMSwnZs+j/U4i4FRLNEwlPCB3a
 0PgGP1+26wauPwyiHULbT7jrIyc2CfV8LUnEFx689O0R+VZ6oJTjEpGzuB+QHOoDg/A+xPCVL+8
 Vig2yGvHnrId7UH0+/45fjZ0Uy559bHqzYTOaDuAHR/S8xqCZWfdkulg46Q3R9KbJeme8psYroZ
 gz7HaD4Z+/yXyjyGIpArpWuFZ9IdYBpNJuhTChiVSL0J5TPN5UD42hjw2NSAWY7Fi5lLE7NFOcl
 LCN0ozwLZlLq83kg93eZ1sHN/9sDD0QGjI9Dzm+w9Wprw8LqILZH1NE3ajH45aqQDD
X-Received: by 2002:a05:6830:4ac1:b0:7cf:e4a1:8b56 with SMTP id
 46e09a7af769-7d52c2e9a74mr1465011a34.36.1771650978617; 
 Fri, 20 Feb 2026 21:16:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04c637sm1435173a34.19.2026.02.20.21.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 21:16:18 -0800 (PST)
Date: Fri, 20 Feb 2026 21:16:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2 1/8] net/netvsc: secondary ignore promiscuous
 enable/disable
Message-ID: <20260220211614.44f6b3df@phoenix.local>
In-Reply-To: <20260221024540.659098-1-longli@linux.microsoft.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
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

On Fri, 20 Feb 2026 18:45:20 -0800
longli@linux.microsoft.com wrote:

> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
> index 6584819f4f..5d7b410f1b 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -480,6 +480,9 @@ hn_dev_promiscuous_enable(struct rte_eth_dev *dev)
>  {
>  	struct hn_data *hv = dev->data->dev_private;
>  
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +		return 0;

You might want to return -ENOTSUP rather than silently allowing secondary
to think it worked.
