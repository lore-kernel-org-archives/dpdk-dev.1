Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23719C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23679402F0;
	Thu, 26 Jun 2025 23:50:38 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9D057402A6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:50:37 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-236470b2dceso17171895ad.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750974637;
 x=1751579437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIrWZZuLE6aZ5f3FzZ9ONHOVk0v1m/Ouaa80VYBWyIk=;
 b=pWs/9FjtS+kM400Gd+V4WwdxnUhCMZ6O20CALwdUHRmqRZZClRxDuA7mUtucXGaR/X
 7raART52u2f9N+6FSuzZoycZLkkQLUlDAxn3/u+lVGzPnHsVUnW7J1qVnnURP6+CwCLg
 q+FCIJ0lZZ+5JUpga+5oXb00TBwKl24ObI4WXHI6YqQFb4Kz5TXeu25AnkgGDyqG/DB0
 wt/goXCCtfkJ8ELvFRzqTTeVKS3O3xawpntRXEa1G/lb3yOVpzs/WZtOMrTauWKehOYN
 TNY+FhLe4b5YQuj+DJyvPIQLkWwxxVrZMOTraUZllqfBqokeZ5etkZq7goQP9pszVFw/
 DNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750974637; x=1751579437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIrWZZuLE6aZ5f3FzZ9ONHOVk0v1m/Ouaa80VYBWyIk=;
 b=ingVg+/TOl1Hse1IoE7qWL6xK8EIi97YMni47NkQhAoIUnOGTYJ9VX4u5SwREfsmt5
 bhILZ19veyrSIuVHWdNEDB7UvOGQX5eirQ3VzOqFumKhH6DhOyZ6/qXolYTtUymLuGNq
 /F5Y29ljY34PCq0FKEaXzOjkYQyWV7Woagw9mgf3l9qV1CduUfGq8FKMVxWoEl4DeBfI
 0pYypqlg3clcz2/VzfPRDWMtsKnBtYEDM4SV2a0/eklu/etBrTQIZH+kNgFy0yTA0v3G
 5UJfcLfJxZDU7uwmgTP/70GQ6RyleIAP7pSUrxiQfC8HM/IHkvoST58PaNjnwa2rGxGL
 baaQ==
X-Gm-Message-State: AOJu0YwcHkauGQhd+zAgev1fK20hYVjV18UCTh2RQZMkQkcIJC5P6WYn
 OyVv0bSVbrjlQWOauL91C/bqShZPXAyzU9E8diz8yqC9fgWGnc4Fiw+cv5suNjF9rKA=
X-Gm-Gg: ASbGncvZnq9l367UDcyAhqmSAMXdfWQB8PFF6v+Y898QVPlPcx+cipfAE518j2yfjMw
 KCLJ7drH8J1giyKM8vjQpx02wFrYtm1Jec1ijl7LgBjYzhYfSeEHMo7YCjzfoZjSxyAlPkLDsUn
 FZpk4+R5mmAlmhCs09uqPhUuNw8u4wctOce/qpNxUeDsO40FYPX8vbj6xDJnRjE/jlSrfzpkgZ5
 aQabBbENujhPomsHYO+VfDLaKNtn4ng3tfS0i0XGu4JYkdXmACdGw5wa/YGDXB7VlMxjhVmctlo
 GKVmmEw4+8mHmBET9YLxnSNvv0EKICW0QaEJuRHBINHV58AfjCRuDuAOUaTh6HZmFCSnIXa0g/N
 f5qlK2lfpK57xPe4WfMPlLcqqYX0zYlmYKdNpUno=
X-Google-Smtp-Source: AGHT+IFtSwRccSn79hQeS5RG5E9Wrlt5xCCDqqayoz63VousOXGLTGwWXiwmRTE4wQ033itweNV3Nw==
X-Received: by 2002:a17:902:da8d:b0:234:e655:a618 with SMTP id
 d9443c01a7336-23ac45e217dmr11087895ad.25.1750974634947; 
 Thu, 26 Jun 2025 14:50:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e25b9sm610335ad.2.2025.06.26.14.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 14:50:34 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:29:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: Re: [RFC 13/18] net/hinic3: add dev ops
Message-ID: <20250626142912.4246aea4@hermes.local>
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

Why are you cast a string (char *) to char * here?
