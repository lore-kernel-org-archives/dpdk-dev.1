Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906BBC624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26A12402EE;
	Mon, 31 Aug 2026 17:46:55 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 8860440269
 for <dev@dpdk.org>; Mon, 31 Aug 2026 17:46:53 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-381b831d535so6298883a91.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788191212;
 x=1788796012; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MMFXpPxmeMlHkL6ZJxRhMzTxaS+JHKfCCFnR7UIw8cI=;
 b=PSeBzKcxaBbbE2DOLyvGBdk08LyILYPCWG/dmbrFNhKVB1u7Jk1V5fLPi92oRvr4lE
 Sgpcw3FhO1JQayJk7HvmdIpBVwWJh/8+tueUO5G1zbFSY46SUoE4aCDl4tlE/EU4rRrr
 Yv9BrVCdJkgrNYQSFhuv3xoqw8aAgLOJmyRsT1oQrYo9ywEGiDHrB8frCk1GGPXGOh5f
 6/jQi4oqyVB4vY/ul4YYR0dHR2avWguNGL90UtzZJDNP4yESIuGuIHnIyTrXISVLsVww
 Zn+E/9MOtC1UlT7MMkxNj2lUpBlNyV5T8lm89n7Ve2VbdwQIWBBQ5iLIOkImb/7PSpFn
 VSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788191212; x=1788796012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MMFXpPxmeMlHkL6ZJxRhMzTxaS+JHKfCCFnR7UIw8cI=;
 b=kJ1f8lP25qmrq+3CG1LvdUcyjQA5HUsf5giDqpX91pSGiOyf8AnXEKP3/bvzy1k/N3
 BjhqwK7kOaP9cTYUjos5qc60hF9W1ucMD+NI/hcbgwCRm0pvQ6lEEKfSvCiTrRUfnF7b
 TfCXiFU0X9BBq2INPGOCtlmLMW6qgJ2ucTZ2Uvt1r0UCWE8BeHfZbqbWauT8MW27SD7i
 cdlp5CnBVcZ2BwH/ppvBFNAiSi/5wqpD3yzCbKQ6oyo1tDTQBpescw0WpL+kz1sZ7QCw
 8J3Rfowt8GY3Kvp+F0IeoeG6SyScBFqzRgz+hoNI7KdzVg84Gyn+IZ9AySnH2/qMchbl
 kANA==
X-Gm-Message-State: AFuF++lnzZ2ch0/RMGj2jPBWDVkgk+c1WZQcj7/dbucZr3Oha70Uyr95
 VZr/NnQgOhkDnagrun2ITFcJxib1t9hS2rSkADuZUOJuW1e3EFSAtIG8B7M4rfTzw4w=
X-Gm-Gg: AYBFou1OQ/S0X+ONZz8dsjpFpsOt+NxBJPG/rFq8lGFszYtCpCXVRdwaT8AsA2O1cfE
 afPC45Q2g3jq3P44oNz2yuuck6SAofuVGY5GYMrWypV32pZ19yCqitrBLIvRvEA+wnl6pUiLklV
 VRub51Rx1wNJZz3QnRTEz4+WmOXc19cdkV17AkYXlq7BxL8XEKtVNiRkggKdex1el0NQQtSbzNd
 KSNtyBrNKBZRkaxRoqtouOQ769XQathOLu3lI7LhlIEZ++Iy0Aj62yLAiFxw43/ONZW2muo57FK
 IjoM4KidBRLxwSX0gUbKVsdvAahoDesUEiZMHYSlXKdApzDXoEiQAQNp/nEbe0M1+t6P942vdrY
 XLW8VpgnCu7RPnimyFGZURJ7CiHX1doFZHevf6xUEemVQXRVEv/F/+X12s3WzWpbCT26rbfMzp9
 uWUeU8+fApVUJ6Y/6DUOIMa8ZPOKgkUGcR1LQVevEPDwKK7VMi+7oya3zwgP6cGfjK4inCEv+jA
 XMVsqZHK00ZIIYy9B0gVx8heB1tWQ==
X-Received: by 2002:a17:90b:2ec7:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-396d0c0af4bmr45350843a91.0.1788191212297; 
 Mon, 31 Aug 2026 08:46:52 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990bd1dcfbsm90107a91.2.2026.08.31.08.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 08:46:52 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:46:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3] net/dpaa: fix Rx queue shutdown before init
Message-ID: <20260831084642.7de76c58@phoenix.local>
In-Reply-To: <20260831071825.3882423-1-prashant.gupta_3@nxp.com>
References: <20260831061159.3668135-1-prashant.gupta_3@nxp.com>
 <20260831071825.3882423-1-prashant.gupta_3@nxp.com>
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

On Mon, 31 Aug 2026 12:48:25 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> The frame queue shutdown in dpaa_eth_rx_queue_setup() is too late:
> the queue has already been created and initialized by dpaa_dev_init(),
> so the shutdown forces a live FQ out of service and the queue no
> longer receives frames.
> 
> Move the shutdown to dpaa_dev_init(), just before dpaa_rx_queue_init(),
> where it cleans up a frame queue left over from a previous run as
> intended.
> 
> Fixes: 0e3c389b9e4f ("bus/dpaa: do proper cleanup of frame queues on shutdown")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> ---

Applied to next-net
