Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E697E109C046
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24A95402CE;
	Wed, 25 Mar 2026 17:50:57 +0100 (CET)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 411DC4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:50:56 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c76682712b5so49550a12.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774457455;
 x=1775062255; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biS2k1l/MZTPjVnQoczV1xJiAF1pi14G5VZM7G1g5kM=;
 b=DY/aOZgso9uevQmkUyaOYCXOqSu1vBPcMNlbg467F61SVFnG0uCaATeHuR8nVC6LxH
 ZK6jRn6FFCQT0Q93bSTNXgU+z8lJ4QKrBtoBM3YZas0ZD6/PcD4xolinLETdJ6h/WgPr
 HSPIgtPWN33PyiJL9t8HkQ+Q6LW/N5dnpkl5v2AQo7Gg6SVb5X/9u6uNyBpGEA+9lUry
 coXFMC2Lwt+QQdJ4iwYAirnPv0V0HCmrSluHre3IIAbOncyfwrZbaBXtkpZiKOW5f3ik
 z37ekbNOH/tJfBcMxAfi2Yg6kOIWo6Zd35387DELtVMljUIrOc2LaQPZYCE4SOGXSnsn
 kDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457455; x=1775062255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=biS2k1l/MZTPjVnQoczV1xJiAF1pi14G5VZM7G1g5kM=;
 b=BOeJds30/EMNgGyVRmwrMoEsdO4TJHfRewwRRyDUi9yAjvZdUkPxRadWxsjk5WGiqS
 0dw2HSUb6ckWA/AwsPHhpTLJ4hKwQrdOiCX3tvrMWe2Z8HkPZzMbuac1r49egcSlt5iO
 87RjxWcNdJ6NiwdaQAi6J29WcDgKE6S0gKEKDkDWUFffTn9o+RaYtVrRem/zeCErPFtW
 HIqG6PxQB3q+u0TGtlbUl5ENo5F4Cre1tgL4thyaypI5C2cwHOiJtoGZTfVfR7aLIvCy
 rADuVH+KJBWrb+hxlRsBvmifT5bZ0qP0DhF7CS7ja5ckul6JLewwb4l81tYsMIY+xi74
 qyjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+yXy7gF6ePCI2pqGbwgILCxZR/8dl/WsTpolajXA8GTFNlTT15GJiSLA4LvIL65qSgkA=@dpdk.org
X-Gm-Message-State: AOJu0Yws8E4EOPbKOVWUw8jky9vxISqhI0FzXMiHzJHfsQsQQ4DCl3a2
 C3D69QHN/2ErvNMsyI/r5knu1M31+WuT6jhEGG1B632XUKtPNI+s+i08qFDBMdvV0NE=
X-Gm-Gg: ATEYQzw6G+RkKr1AFuwgoPgfaw9db1uPKpbVKOF2tjSjj0qDoQgIZmBKeFE5oypVWvG
 KCLQ3uEXNKLPKpOaq8Ebq17HXEo+w5a3o+bYsbSWtQhSGb9AtdJNw7H5tdLtj6AYpCvq+2RmBcm
 s6H/YIo6xKrntuokAL/2HMSUB3qaQ3mVWyw+MuJffC7zgz0zSb3JNUaP21w/1XXFTqvw+jTljKv
 iDRb4Nc1+5gD8renqQ1H1b2AnvrcDiTLI/MqlwoBEdbE3xtRSXLJ91uzEeh1IILIJhoSqFNS9gc
 BaVsUSvkWmm7DF009OFiFR+V7IiJMg3es8W5BEDvWAEkdFEsV6we883eIDSE1Nl8GlvRyIHS9G1
 DuVEAXwwzeoUmRrWtwLGROV2cDUJOomigIfuLQWM5nRUe6XCF8I6v1OBAnju26t4ZSJwRai3BGk
 IhIFJVFrD0Euz7jiuJqUVCsszoOK6HnribRdM=
X-Received: by 2002:a17:903:2391:b0:2ae:4800:141a with SMTP id
 d9443c01a7336-2b0b0a87423mr49775085ad.32.1774457455270; 
 Wed, 25 Mar 2026 09:50:55 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87ebf1sm3493955ad.44.2026.03.25.09.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:50:55 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:45:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH 1/2] app/testpmd: assign share group dynamically
Message-ID: <20260325094520.2298139e@phoenix.local>
In-Reply-To: <20260324123709.3471-2-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324123709.3471-2-dsosnowski@nvidia.com>
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

On Tue, 24 Mar 2026 13:37:08 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> +static uint16_t
> +assign_share_group(struct rte_eth_dev_info *dev_info)
> +{
> +	unsigned int first_free = RTE_DIM(share_group_slots);
> +	bool found = false;
> +	unsigned int i;
> +
> +	for (i = 0; i < RTE_DIM(share_group_slots); i++) {
> +		if (share_group_slots[i].share_group > 0) {
> +			if (dev_info->switch_info.domain_id == share_group_slots[i].domain_id &&
> +			    dev_info->switch_info.rx_domain == share_group_slots[i].rx_domain) {
> +				found = true;
> +				break;
> +			}
> +		} else if (first_free == RTE_DIM(share_group_slots)) {
> +			first_free = i;
> +		}
> +	}
> +
> +	if (found)
> +		return share_group_slots[i].share_group;

Please use a short circuit return, that would be simpler and code would be shorter.
Same thing below, avoid unnecessary bools.

	
	for (i = 0; i < RTE_DIM(share_group_slots); i++) {
		if (share_group_slots[i].share_group > 0) {
			if (dev_info->switch_info.domain_id == share_group_slots[i].domain_id &&
			    dev_info->switch_info.rx_domain == share_group_slots[i].rx_domain)
			    		return share_group_slots[i].share_group;
		} else  if (first_free == RTE_DIM(share_group_slots)) {
			first_free = i;
		}
	}

