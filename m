Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14266C61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 15:38:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FEB940283;
	Fri,  6 Jun 2025 17:38:11 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 6203D40263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 17:38:09 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6fae04a3795so24698006d6.3
 for <dev@dpdk.org>; Fri, 06 Jun 2025 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749224289;
 x=1749829089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89YvNbjWvHZy2ODYcm+uvh4JK6w/HMTMQ7BOWP6bMHo=;
 b=kIO/WqnhwYatYEFIevL07xxuNPLK6sny9+qnFtegARHwvZCEKZ1uaYJHJ5bPcvVtLe
 WYtqhQmCXKWo4G/IfsCgbI8pJH8n/dvpErkotCX0zihqeNBZC5TAiiJz3O3vt9BElPRm
 1IKzj953GhRGGvdDUvRBoRQx4ij2YuLbSZWv9Ts7OhYDFXGDBpP+tMu8GlYWHTGLNqnt
 D2r6xfsnW9o+kivUVcXvRbVKR9ctJQVHXVeNWRVzeYnKOQn6caJ6avg2CeMjJzEkchL1
 sNe2aUoj8E6p7GM+APd2T3CNPEisK/mvFYfdXg5s1icWuTM7utqL/o0N8BxpEhMXulaq
 iEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749224289; x=1749829089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89YvNbjWvHZy2ODYcm+uvh4JK6w/HMTMQ7BOWP6bMHo=;
 b=MpLivGt4NOLd62TCq+MlirKSmSGflAe4BascSbJYf7c20A4FAV/2GkGhmFIJrVjf7Q
 CIqYCooCxrMEkW8q4Dlw67Jqobed7H+kYkg/dJ0COHszvvAT7Pu67/FRlq9caQaFB3ch
 3xIzPwZIh04V19g5F7/A/QIyzlhYw9NILPlRSaUrpXv7zcniy2SUEYlbbVcc9MTy3vME
 9XI0HDA4DRHjaHV95lWVpYFauJX/jFLvvrNx8600UyHUNlP5Mv1Cyv+pvCMtGlglrQrS
 tylFLbDxpaf/MsdNMSYXBvPagEjnrnMLGOspIwRVQZyFPEtTR0ssOK14t43Bbr1JM7dX
 2hkQ==
X-Gm-Message-State: AOJu0YxbSHWsEd6Ag+4aQhg2/2iuN2fI0WbCQcsBwn2U3zKHiylpEYut
 26VZYgFrhROVF9Naokwqf6XJ24qKx1gvS2kNUvQ2lydlMghjQiocnGMsJ/1am35qDZfeKSnAJPt
 ybocW
X-Gm-Gg: ASbGncvKrT94Zil35cnIO376d4UCbM7kEk5CyCXGsFZaQwHze9BltyvMjLpfRvJ1XcB
 EchCS/u/+28QUI/G8V8vuZJaqMKclqlF7nSZYxfd/o3jmdqppq5NZk4ykauoyML96FLSzl9yNkv
 BZT01u30T79in+51R5wpDJOiwRB/tHO1Wig2SJhmPFwrvDadW8PDkYr09uy3/EA+jkIGf4IrA0f
 lzbF3lQnKDvOH9doXH5Cf9H1gudY26eBGgY28bEKSykRS+ZJMNu7x3w/1CIj1O8ukIZkDc6mWA0
 iiaX+gGARUm4c6M/KXo1Xxa4EGqg4vbu1+tJDcxScosJR9kfpXksBAZ3vPKcJ0WmZS0jFkJreGx
 H6R6RrCaYrvahFyhJbKcl6qyzRh6wZTAoC1zLAl8=
X-Google-Smtp-Source: AGHT+IErZtYeB0JoTZ/ct/6ATjoJNbJQIDyA3AR66mnjh/KDpCqCi6s3PGA60ug0qxgj5gJ4sI7YHQ==
X-Received: by 2002:ad4:5e8f:0:b0:6fa:fdb3:587b with SMTP id
 6a1803df08f44-6fb08f528b4mr56796506d6.1.1749224288529; 
 Fri, 06 Jun 2025 08:38:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab83aesm12766556d6.5.2025.06.06.08.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:38:08 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:38:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 1/3] net/macb: add new poll mode driver
Message-ID: <20250606083805.3523f1d5@hermes.local>
In-Reply-To: <1749200770-53411-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749020395-44053-1-git-send-email-liwencheng@phytium.com.cn>
 <1749200770-53411-1-git-send-email-liwencheng@phytium.com.cn>
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

On Fri,  6 Jun 2025 09:06:10 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> +static int macb_get_speed_info(struct rte_eth_dev *dev, char *speed_info)
> +{
> +	char filename[PATH_MAX];
> +	char *s;
> +	struct macb_priv *priv = dev->data->dev_private;
> +
> +	if (!speed_info) {
> +		MACB_LOG(ERR, "speed info is NULL.");
> +		return -ENOMEM;
> +	}
> +
> +	snprintf(filename, PATH_MAX, "%s/%s/speed_info", MACB_PDEV_PATH, priv->name);
> +	FILE *file = fopen(filename, "r");
> +	if (!file) {
> +		MACB_LOG(ERR, "There is no speed_info file!");
> +		return -ENFILE;
> +	}
> +
> +	s = fgets(speed_info, SPEED_INFO_LEN, file);
> +	if (!s) {
> +		fclose(file);
> +		MACB_LOG(ERR, "get speed info error!");
> +		return -EINVAL;
> +	}
> +
> +	fclose(file);
> +	return 0;
> +}

Looking at this API I see a potential review conflict.
Although sysfs is a text based API, and any string can be returned;
the convention used is one value per file.

Writing UIO drivers is hard, and getting it upstream you will find lots of issues;
ask Long about hyper-v uio. I wonder if there is a better way to do this.
