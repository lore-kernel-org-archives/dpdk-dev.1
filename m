Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F1CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 18:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 477E040E3B;
	Wed, 15 Oct 2025 20:01:20 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id E74B040E31
 for <dev@dpdk.org>; Wed, 15 Oct 2025 20:01:18 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-856222505eeso921831085a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760551278;
 x=1761156078; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2RlYoyI0b75BZ1jbhS/b9SFGTYkH1Tzw1ahawiQiG4=;
 b=mKJu6bvDNXz69aKV3mdFxAdxeOOswpvHVKCvxBfUMcOpV1x99i6XsFcj/Vxn+QuasR
 ymSHM29uj+tK2PxXZB6w490N0TBAbhdLdWp9kqLt0ooJOJSwGcYqNxcMKnRoWhs7fWex
 0HKAEyfH2AQsM6fDU03DZbOx2PqEYR89LWiq9VzBTCXHvvCF9J6gQo8pluaQ+zU6Hzbb
 IbpQUBrGzKmN63MXmLPoBEYeKiB9I8EzzSXEhBy03FdDPewxeqeMYRxHxZRiiXoSpJZm
 Jk6/it7lbe3VRJD9ugcXYXgSGtIY5bRFbd0MUHej/vPjma7U00o9UZuivE3r5FU3W+WL
 JPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551278; x=1761156078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2RlYoyI0b75BZ1jbhS/b9SFGTYkH1Tzw1ahawiQiG4=;
 b=NBdMgs5dG/aypzZMJudcXNf9jLlEKmw/0h5ZBGWu4intzkoEiFpvkkIhqepaDVTyXB
 ObJ7c/uowC03E7/0yNlZ4tBDyZHvalY7EAepBBgIt3P6LtIm6xga4qzRvYj3Fv6nS8u3
 wIfBul2FqOtsH+RAJXOotIy9Y0UwxvQxlagaAWv2TRV9j9Vt2hvV5vFnW2/5XnpPherH
 AinptzGzouWJortIODeC7qM8lXo/X8eynREDc6S9Dgn/AdtJ48Y1+LS4xf9u8G0qA+KA
 QXdomX/yCHl4f1G395sdThYLHqCwfXAB2LAvaO4zUMFXRuE4vEosnDGEYNw9CiuFD769
 O1gg==
X-Gm-Message-State: AOJu0YzIBxxwaFSxmfWM5zxrP/0Yp/+nuhio/X8ejOHJzUPkEMrfbDqY
 gJHVwgP+ZyvXNlZ7roLF4fukZSIjoXYooFgdBCiClOtReSTen/RP/YOfl7uUzop6SEE=
X-Gm-Gg: ASbGncuSc/lYXs2UhKfR5Ej7Z6VqLhmjkY2pEyjtgDxI2CQlpzJ1YONFr//VKQh/Dcm
 eMyqyPLdUP4fD7LK/fOSzUyzLcsgGYs4Z90tojnA4Lm/HNI0PS0WVKqgS9mHMGI695gQfqSK5AW
 CMzHAbSYucHX6SSRfsnugAXtKjt5M6CNU/OcU1lcDjQR/Ca3gf5GLqXAMSrEO+F6Eg8t+TN0yCY
 66PbEeDqQYrtG529guPIH/zC9/WlhXruSVqrLH52aVhVTmunh5NKyeMPMHrRSA3gGd5h9W/Cydn
 bXCvays5h57Tyy3uXlJlPkMZpyyDJhpJzLGKohD+Ykh55IaSlwXcFKu6iFViD6cwsz+bkkV4dsa
 Xv+KmrKPtxPQffBVEBE1KgGeZ4ZFzp4OKFK/okBeLXYK1Xpz0C2ByRpzTxhJG4UPAINV79R+C2r
 FCpaDOJPQj8AD8xf6CgmlMFjIF0/fr
X-Google-Smtp-Source: AGHT+IFuEN9TsjLBlovz33cBBZTf/qfvQwhfaxXeg7v2zkN/kEsQ7oDCPAZKx4+fnDX8X3uclJblzQ==
X-Received: by 2002:ac8:58cd:0:b0:4df:6b24:ebee with SMTP id
 d75a77b69052e-4e6ead62ec0mr406974961cf.58.1760551277880; 
 Wed, 15 Oct 2025 11:01:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e88c640298sm10758011cf.9.2025.10.15.11.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:01:17 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:27:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>,
 <kevin.laatz@intel.com>, <jerinj@marvell.com>
Subject: Re: [PATCH v3 1/1] lib/dma: introduce inter-process and inter-OS DMA
Message-ID: <20251015102746.41daeb3b@hermes.local>
In-Reply-To: <20251013042136.1727540-1-vattunuru@marvell.com>
References: <--in-reply-to=20251010144631.713063-1-vattunuru@marvell.com>
 <20251013042136.1727540-1-vattunuru@marvell.com>
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

On Mon, 13 Oct 2025 09:51:36 +0530
Vamsi Krishna <vattunuru@marvell.com> wrote:

> +	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
> +	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
> +		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
> +		return -EINVAL;
> +	}
> +	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
> +		return -EINVAL;
> +	}
> +	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
> +		return -EINVAL;
> +	}

Why is dev_id of type int16_t, seems like a limiting and poor choice.
Would expect it to be unsigned and 32 bits?
