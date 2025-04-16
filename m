Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D4BC369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C9E402E7;
	Wed, 16 Apr 2025 18:38:37 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 18F1F4025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:38:35 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-af52a624283so965639a12.0
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744821515;
 x=1745426315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+m2hhiPGe93/4Li4rScZ3LtrI2SvdTzu6BlXyRUd3F4=;
 b=x1kCPG0mXAHvW98XXL4+3clAtYmf/1W/ZvX9lGh+fl7zSaO+WDfE5m9ECVUVPaSftP
 Ur0W1h9FRauUgAdc9XbG+aVPU1LTUWk20DMhnijoILPFc33sCGB/j1+P3GEhK/JFpceL
 FZkvpXvSb3NGNJnC92vxjIdVK0puGqhGwlFvhr+m6Gg3mkAtELCQWj68CeoJT9D38pE5
 pPpBM7M1KuSdN2+sm28qWWgdrA7i2IO2fFL7YDmVEdAwiZQ4YLpC50SoerAzhamlzoGl
 3vtYRh/xGaBkq2kwHDjndC0EM0dl5O7y1Op+JK8SqrEYQ0XjT76nof78hfIOTOZ0siTH
 dPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744821515; x=1745426315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m2hhiPGe93/4Li4rScZ3LtrI2SvdTzu6BlXyRUd3F4=;
 b=fH+RRoZFYpKR23xMM1rVKQK39zIZrxFqlcUy2Z3cHIufxlhbZauMrRVqNL1T/Z/F6/
 4uh47QUAhQC9LgrCn98yFIA+UHyIrYS35BK1pDt2sDqZtau3ZvDslsHUH60oqK/Rqj+8
 1OMN08r3QMRF5E4RCbfk8f4kpbEQz3wzjMs8OUVMq7+LjczGdXM7EkzgTNvsZl1FnReU
 wz7OZFxV/vRoTwxVNerTzCzTT+A58Qc8qmPTFEq1Sbyp9vW9HPo5soeTY6jl/u2wtH/1
 l8Wf7XpEQpDU+eM63Sl4Iik6w8CBwFUSBMYHSo8n8vL7p07w+oMziMfC/cRXG/piDuhw
 i5yA==
X-Gm-Message-State: AOJu0Yy0Qggs7LWwZzbWetQcXrV5/P9cGE/fQ+q0gOuJNuqVRtH2k3ph
 HbPgNBPvHcRGGa8qZb325XXWPtAwk5QRpuDbsG9Ca2qCZ6w1nbQXs+2/+9BXZzY=
X-Gm-Gg: ASbGncsM918MNS+eoHZgloS19ofQ1IJjQRiViSyZ1hW3nHCi7LJTPWNURS4ficIsTQ4
 yFDjBcLgTJK5ixUm25zkYfRfTCSu3hyF9bsdcA60+ZaGBIdELe9HG0nZNW4GBCFNcmSyj7NhAAR
 TM7xCpnLHWjjbkjm8spNUfhEkJ0+buqWyljlmrMReho2lvfVeoHNvQ3b7uKnf7SP887vbwqJOvL
 azIXIJ7gIhZLxIURr1Y/knSsUrK1mIhnatlsAQpuNdIIW/xsPpBmpmojv4E/wo/V8qacdTEhSaN
 6DCdb7FmTfY7iMTij4rtCmyWuvoXAFxi5R2J7VgyQ7UdYFbpQwwFvLWC0o0g0yRTZewkiSAFTLj
 KhHhnFFLQTGmx1gNN
X-Google-Smtp-Source: AGHT+IEBPNS3qCeYyw4Pr5+ll/IBpIyZNmKjNLW/l5mbJdOaqVTElD8tSecX+gtByICoC7IWoYeWew==
X-Received: by 2002:a17:90b:544e:b0:2fa:3b6b:3370 with SMTP id
 98e67ed59e1d1-3086dae7346mr238201a91.16.1744821514825; 
 Wed, 16 Apr 2025 09:38:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3086136510dsm1818315a91.43.2025.04.16.09.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:38:34 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:38:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 1/3] net/macb: add new poll mode driver
Message-ID: <20250416093832.43bef142@hermes.local>
In-Reply-To: <1744093201-313699-1-git-send-email-liwencheng@phytium.com.cn>
References: <1744007896-4806-1-git-send-email-liwencheng@phytium.com.cn>
 <1744093201-313699-1-git-send-email-liwencheng@phytium.com.cn>
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

On Tue,  8 Apr 2025 06:20:01 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> +
> +	dev_num = rte_kvargs_count(kvlist, MACB_DEVICE_NAME_ARG);
> +
> +	/* compatibility support */
> +	if (!strcmp(vdev_name, "net_macb")) {
> +		if (dev_num > MACB_MAX_PORT_NUM) {
> +			ret = -EINVAL;
> +			MACB_LOG(ERR, "number of devices exceeded. Maximum value: %d.",
> +				 MACB_MAX_PORT_NUM);
> +			goto out_free_kvlist;
> +		}
> +	} else {
> +		if (dev_num != 1) {
> +			ret = -EINVAL;
> +			MACB_LOG(ERR, "Error args: one vdev to one device.");
> +			goto out_free_kvlist;
> +		}
> +	}
> +

Since this is to first merged version of the driver, confused about what
compatibility means in this context?

Does the driver require devargs to work? Isn't it a hardware driver.
