Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7C9CA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 15:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23BCA4066E;
	Fri, 12 Sep 2025 17:25:21 +0200 (CEST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id 205214065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 17:25:19 +0200 (CEST)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b07c38680b3so159169766b.1
 for <dev@dpdk.org>; Fri, 12 Sep 2025 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757690719;
 x=1758295519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVH/RZ1Ch7DNSqF5lv6KhB26PEE3WP5cm18MD6HAGHo=;
 b=lv1a7OgZvmhhoZCu8ohCCvCg/N5L9IGpQXf4vvBKYryd2I3xNi4EVWsFvbhDnFhz8H
 Te6vIg77Xu+aICdt8FV3Nj8oXxmxS9XRP/N8+J14agLMCQiRSH155I4+jeTwZrFUsswu
 Vvg27XKATM4QiCVHKfjKJc4MFqqcFQLsMTW4MJaUnnEnjJ0+DSAWT/1JAdnUWpNXSZEr
 mVwg8MDnKyw8/1p38t5lc1tt9CVHgaRphvCRSLg3l3+P7A4K+4xBvcYz/wgvNOZuP11q
 YqCaPMTtXgl1NfejLi0NGqOZjxj28LHrtaCYJ6LeX20ihZzJqUB/9iMTid/jQ2j71RcJ
 f9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757690719; x=1758295519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVH/RZ1Ch7DNSqF5lv6KhB26PEE3WP5cm18MD6HAGHo=;
 b=Hybs9SgpUvOySqsyNaF/MUdEZkSi8TyX0KrPc642Bwu/IGbI0BNgm4pMJvhPS9HPBN
 Uk8KfS+zOU19MvcApaVGLXAKg1fcCzOyE+gFKCITKd9/3gyYSmVVPA8cgOvjDewYw0IT
 ejHtT7iApVA6wh5n7/M5iI/kck4xhL/LmLQQhb1BDNTq3EBVcEjpuV+FnitnbiOl+nl4
 rLKUQ8IaiIZ6ZPpFzKztnbJkxBliOjM07S1Ff0yN/l+TlQPG6gMHb+XIcZs2xbEFPAB3
 8pts9pNypFbngHPwIDViw8dHDJYzh6L5nBopuZI6f8O65pjsozb8F+4Kw0OjB6ksoshw
 6niA==
X-Gm-Message-State: AOJu0Yz2trMZq9SJnLqSC0wbymPFNwbC0rSED+pxWcBPg16mC0crYcwE
 wExavV4rpRq3IGYmMCtcKxz+yLMG4GQK7bGRjdfJkJtpjGFvgh7nrMBJV1mqklKq+z7yZu9HkEt
 IS3mQ
X-Gm-Gg: ASbGncuVd0Gdal5fXo37QXIk9cUJK6hYWCmZleDjhrCklhZqjarEMLwPNRQ4/lAfWWa
 9YWLX0I4aU01jT/J4xQzGcuGzEmI4sVeXIDOkHMemWU1pouKXoTuP5gQ4/QDsvirQRR206g4MtG
 vNiJKxk66hipILHcPWeBjopjcSkBU8lCIjM3kZ++2/1TcASMq9Irt+1zp1CgrRVIgrYob7TfXTi
 h5hVy59g3NZ7EV/RXnrWr7QmKd+nxcGHlaEkraOrS1szu59taXJEFeViKsXyLdg4IXRTwJ4U7e/
 Us5xM/k/H3UcdNSfumk5X+mAjM0ttPu017QO9c/OmPF3Vtyz2cC/R5nmwx4gy7YP/2nd05Wyane
 Z+T7ehe0l1EkUIrzKsUHhBZoJnKsn3M+D8yiTCIQ0KYmNKaqtVjMNr35oj3nHdUh6IpWbsKWSRk
 RNqvcaORKsbA==
X-Google-Smtp-Source: AGHT+IF7E9shVRfZySLkCQrMZNkGs2q0yd3H5xMzA9f4zyR0ZD0mGNyG/DS6fSFO6b4ovRql+ygbtw==
X-Received: by 2002:a17:907:960b:b0:b07:c1e0:8f6 with SMTP id
 a640c23a62f3a-b07c38205bdmr349315566b.42.1757690718434; 
 Fri, 12 Sep 2025 08:25:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b334eb58sm378047566b.100.2025.09.12.08.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:25:18 -0700 (PDT)
Date: Fri, 12 Sep 2025 08:25:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v8 17/17] net/nbl: add nbl device set MTU and promisc
Message-ID: <20250912082512.0d652143@hermes.local>
In-Reply-To: <20250912061752.2091320-18-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250912061752.2091320-1-dimon.zhao@nebula-matrix.com>
 <20250912061752.2091320-18-dimon.zhao@nebula-matrix.com>
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

On Thu, 11 Sep 2025 23:17:52 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
> +{
> +	struct rte_eth_dev_data *dev_data = eth_dev->data;
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	uint32_t frame_size = mtu + NBL_ETH_OVERHEAD;
> +	int ret;
> +
> +	/* check if mtu is within the allowed range */
> +	if (mtu < RTE_ETHER_MIN_MTU || frame_size > NBL_FRAME_SIZE_MAX)
> +		return -EINVAL;
> +

Those checks are unnecessary. The code for set_mtu in ethdev already
calls info_get and does the same validation.
