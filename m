Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C5C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:22:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C612C40273;
	Wed,  2 Apr 2025 16:22:39 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 942D640261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 16:22:37 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-224019ad9edso54143805ad.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743603756;
 x=1744208556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5CkbDn4fS/uqjo1GHSY9IzBgWpJ2HR6uKpt5PLy1dI=;
 b=ZgVH6ehaz27nI9nMepSX3/PTEm0Na8jxmHEcUam9RaDplUDe4wutWYIt9z15RAVvwU
 Yp7Ixpa20ZyL1zYxYWjOmJgDfwqUz6PmzNDpfFRYyoLrSwl2dnxmxGZ8rmcREZrlpha4
 qeWdh7Th9tLUqFztDkqG7ZxYQVsqoC41JiK19DBtMuSnZdOcMj1mCjcTmhAefQ+N/C16
 qbFMa+nk91pvww2+tWd44OjWFUWO9DdhYNlo3L2o5A6j382e7BuqPsPYSCj1rF4lOMGJ
 0FwtVLuVAFyNme/TehD9kyg5L14uh1FxYkz0FSzGCfBmXWVDoH8dUDmmpLQynFu1Ojq6
 rSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743603756; x=1744208556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5CkbDn4fS/uqjo1GHSY9IzBgWpJ2HR6uKpt5PLy1dI=;
 b=WLME6Xa8Bau6Q1yJ5tz5Rphtg+aSIsN5LA2qdOs1OnihugtzLXLaxJiRxpLMhLNRIz
 JIYPOKfF/jPI2nyTsqcc6Alzg64oMgNmTe8e2eyvIRvLDs1D9K+246OLIPVScG2ErazP
 OixGn8NZ8XmXSgF5TkBSNDJAfP3HjiArhgXkfc0IKIxSwmOFf+qSfSlADycqwd2yUK/P
 7nDS36lCKMGY8WokT7GyNc6Knh/seKCaE4ok5Pau2ueBNXA+s7JqAhCT+fKQmHxxdbCf
 eI1tswAcCejmQ3vtFVkRen2sgv32V7lD9ZMjT/tyIRo0T2yysgIEjm+sLe1xEgPVYl7D
 wrgg==
X-Gm-Message-State: AOJu0Yxovbq1cVurYXHVOFPpzbtxuiRrfIMmzQZTfqCxzAHGoEI4+tZh
 BtR+6wL2iVLN6oofUW9u3eZn1IDFrwzN/Ejx3D1BFh6ELIjrFOOgx4E7XO21rEA=
X-Gm-Gg: ASbGnctrStVOTrXE4CXDkg31JtO+5tNC98dhgHNo3ihXuasC8xu2SlN+FZh6QXce09O
 W4Qpme3MDCg4A60JMjsa6qnFdNCSiSgguY4Xf/xvjU7f1JpOdFU2yWoG1naQdxaDG8qOA1QsAeV
 CXPYddAVpsFpGPT4RIycHRlzcfQK3YhTWmOQMSAwR+7CFEE247/eaZjhMO70ygjyxKo5SI8IFOK
 ehKI95MCDQDS9Zba795fN5jSA/0JivkA3VgVEaAyghBD3L5u33J1of6tjWtRulnL8vgWZuI/fs+
 OPx1+YopFrJu3TxFremiVkv55jXWvj0PryQ4e/zJXer1iMhgBsV8ePS0Pd6WJQM8wK/k/bBqSlx
 72y1KLbWg9E2CyXhFgXSv
X-Google-Smtp-Source: AGHT+IGQgw366MUWcF0ohJtbE0YPQR04eQUkWh1pb2M+HTwpC2QNrGnIsaAcfhcZvapYF+Stx+9VIw==
X-Received: by 2002:a17:902:db05:b0:21f:1bd:efd4 with SMTP id
 d9443c01a7336-2296c65f460mr33384695ad.19.1743603756418; 
 Wed, 02 Apr 2025 07:22:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eeca0a7sm108983845ad.39.2025.04.02.07.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:22:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 07:22:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, "Tyler Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 3/4] app/test: add tests to find devices
Message-ID: <20250402072234.4226fbb5@hermes.local>
In-Reply-To: <20250212163836.178976-3-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-3-shperetz@nvidia.com>
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

On Wed, 12 Feb 2025 18:38:34 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> @@ -317,6 +431,12 @@ test_devargs(void)
>  	printf("== test devargs parsing invalid case ==\n");
>  	if (test_invalid_devargs_parsing() < 0)
>  		return -1;
> +	printf("== test find device valid case ==\n");
> +	if (test_valid_cmp_dev_name() < 0)
> +		return -1;
> +	printf("== test find device invalid case ==\n");
> +	if (test_invalid_cmp_dev_name() < 0)
> +		return -1;
>  

The tests should be converted to use unit_test_suit_runnner() API.
But that can be done as a follow on patch.
