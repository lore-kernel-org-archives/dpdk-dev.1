Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEACC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65CF04066A;
	Thu, 26 Jun 2025 23:50:44 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 39FA640650
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:50:41 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-23636167b30so15934105ad.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750974640;
 x=1751579440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTmi1s3LwkEGpb3flspyB/x39dVrCuNX5x0+XpIVqiY=;
 b=vENosct0GEmrJQob14LG/BAIxjQqHUCD5p/cLD0Ph6KtQYYelenH9Lho3w11B7Hs0y
 TdQQYm6eC5HHQ9J45BbSakq/QT7GHmqgamgPiU6gS4nBsAcFVB3gSImQf8tOuTNVc2fh
 idwfBvgw/nsGm0H27nu2+IM3PkMiKcX71vycqWd4uzywJRnVJSm355gZAkUjhY4breaL
 KCPHNuqlSL7o7d0hZKDG4dVG9I2ETOvhWTKgBnflEzLcQ/3bSTcMUPu1ZMqsF/41yPoy
 cNx/hq6vnpj7+5yorqsdgrmsRbclBApLvIplNxB0wakUXr2DdtHHoZNicq4SCI3UXMrV
 vB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750974640; x=1751579440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTmi1s3LwkEGpb3flspyB/x39dVrCuNX5x0+XpIVqiY=;
 b=mLvxyHLvZL+FQMT1GfbUMjNYln54P2krTmGAQXgBH6v+UTQdQasej/gST2mzIJNoNl
 jzg5ZEO4aj0g0QkDcoqekq1+TN3mD4B++qO83P6pF5s1+VbW0Z3sOgjJLuOxKjQ7DWST
 hfzuibKhkyoFXa7Z7ZxSC4yi7xr+5DTeM2B03vSHU2fnF5FJfEhE3q47HF5zYo5lEkCX
 nLftXifS9PqTCwwTBWEfwlQzl527cggEIh/AXcFNpalXpjrpZG/sFHeo2qG969LtBTgH
 rqXFyz6ISqXhvn2T2Zxut44pD3fZU/k0nAP/2SYiXnTKcECAFvr/MKBcWmcYUFk5G6Wv
 5I3A==
X-Gm-Message-State: AOJu0YyX32nfrweORo3o7/aQbp7ELhD3StZh1+LPtK3nZqjj2iPpt/Ro
 uKLie5e5SZjXfsiaHhbiBA/WE0VheTkXeT5GZq1zFFFViZ7XSYz/k8nVDKAno3eyPQc=
X-Gm-Gg: ASbGncuc5vcu6jsftQHsjO0aqubfd3dN+gGgMUEBjiPKaf1IMnPPNTc7bTQ1qcVIB6b
 XVIswalb/7HKiNCZu2Sa416gBiq4fgCwO+bMt+9KtXk29hdlvphYkp73xpe0STC58bPwgAjImnl
 +vKelqzz+fZsrJPGt504O0kmDji2JRFK/eIqci38HrpTNrBxhsrZaphQ7V1wloIcBrw51xsljyI
 84h36/wWcaihykcw5Jt3B+u9djDtFV9RWMHiiSRhjOsg67SfvZqFXMVsbLFcrvlrNr4PHz44hVl
 iKTASNEblTN0BiVOOp4S+xbHcyP7Bxra1HaLd5ZTF4gjSHFDuIab359huYPMuS5dabtn5kL13s/
 Qx9lEF52vqtTfNvbyPoWioicWG8kFQUtRqzo6AaI=
X-Google-Smtp-Source: AGHT+IFja5gtYvHZSUVi8x/INOUxVxGkaj5BV+p7r0QjmMZs3d1NM3XCBZO06+BOj7b7+/qW8r+Ueg==
X-Received: by 2002:a17:902:e74b:b0:237:c8de:f289 with SMTP id
 d9443c01a7336-23ac46342c8mr13130345ad.36.1750974640432; 
 Thu, 26 Jun 2025 14:50:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e25b9sm610335ad.2.2025.06.26.14.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 14:50:40 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:30:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: Re: [RFC 13/18] net/hinic3: add dev ops
Message-ID: <20250626143007.582d4d8a@hermes.local>
In-Reply-To: <20250418090621.9638-14-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-14-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:05:59 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +static int
> +hinic3_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
> +{
> +	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	char mgmt_ver[MGMT_VERSION_MAX_LEN] = {0};
> +	int err;
> +
> +	err = hinic3_get_mgmt_version(nic_dev->hwdev, mgmt_ver,
> +				      HINIC3_MGMT_VERSION_MAX_LEN);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Get fw version failed");
> +		return -EIO;
> +	}
> +
> +	if (fw_size < strlen((char *)mgmt_ver) + 1)
> +		return (strlen((char *)mgmt_ver) + 1);
> +
> +	(void)snprintf(fw_version, fw_size, "%s", mgmt_ver);

Good place to use strlcpy, in fact the cocci script may even find it.
