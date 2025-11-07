Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F8BCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8201402D6;
	Fri,  7 Nov 2025 16:59:12 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 21C184021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:59:11 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2951a817541so10366795ad.2
 for <dev@dpdk.org>; Fri, 07 Nov 2025 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762531150;
 x=1763135950; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaGbhIx3yO12tywcsXsAB+uFnrD99Ymif8vQXLvCWcE=;
 b=dnfxkcmwSjbpwE1INH4rJQdw3JdsXsg5IWQzCPHxLmEkgyX7eJUAljd9y9bjbTAXbT
 N6dBo6zJHI3IgqS9VA5Fz73OaDoR2vkBkKdKhyEdn3puZcXIKJVEQUaQpcPgcEDsthIo
 Wv6Y+oVDyqQI9muaO+vihQKFyX8RygNx+u5HXD69VCrNkfNC2HisHNFwcfi4k15cUcq/
 adbsj8HnjwVDN7y6R6n5z/YtREkbJz4b4eOQg31/yR9Ntj5pSl941oSxAULu4YulArHm
 oX8j+9AOKYnMF+HOsyocuxX7jhrLfJO3rmtT1aaq8pK5S8TjTp7j4ZGpeRj/bRZMINbN
 Oswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531150; x=1763135950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qaGbhIx3yO12tywcsXsAB+uFnrD99Ymif8vQXLvCWcE=;
 b=CsLKA6muRZM70hdutu3Mm3gIyPVePs1MowHG4g5t2dg1Ew2J9GzrzvLGSrQO4UKRPQ
 S4/CRHnaW1nnZdxq1MCL1JwEbzu1KT8c55gLnkJVo6fWQoWY0cRuQ7qQMpauxdFYKf4k
 fj6ga6CGOfHtpgH8iApdTOSW64tzl+DFtQNYAykc1NlbyYCTE3m6tiqF6N5doHg1PB/O
 LzmQeCoOAP2+Kki/C+x+BjMSR7wEhoUWp1PutIRf2jT5UbVtJkJDap+DGJekga2GMKl6
 8I0cKjt/GxEjFUrrDO8idqNPQAWVQk8/3uL1E3FWGZxJNbtmnxNvCOQbhDaUHuuXPv0Q
 A5Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxsp/V4LNiPLppu6RpzJ5O4xpSdg4p7ijtbRw6K6DmJHPtKbXTy40eM2koaE7yqrOfD7g=@dpdk.org
X-Gm-Message-State: AOJu0YwgKLLETLXDvEviQfOIyA5a+iTsQ54XMehUKL/UURx4WUS0Rs3c
 nCZ35Fl86SL3LmqayOz875ipfEpyho64XmMLi1Cg3kytHuxQ7Lv+/3ws+q7kbjU3Nxw=
X-Gm-Gg: ASbGnctNO/DgaWYOeaaPd7/iMerDrcdrbRuawaSqtoxgvQah0oXUGVbkc7YLeppSPnm
 vss95Xz1tDEc11T9FodxahLMCZWzc15pbU5/YigkJcKF8i4qOOXvAUarcY3kMHFzW4srC0tqdtN
 GksxQon5G0VxTDsH/NpJs6oRgw036mwqOu+2QZRzV9qDSth34+YdE6S0MAnCJKS0BhrKgHNzgNs
 b1TMWSMlw+F/CksJ2cz8lmZEA+Gm8TWmjjmTZgRaYphRPU5gDIAcmPJvOzaYOqDIWV0HJ6K5BEC
 oMhZBBzqUI2o2tP6umP+85AheK1druw3FaWAiXNsgXU3PmcoMjnQKW18eAlqTJFa2TyYOfqI074
 0E2sHBEVE3qy0ZrnbkQFXYH75B4QfuT+oqva/WeOx+aPeLNz/GmV32Hm9ZPO7RMjpb0zEWGIzWc
 QNkKRzLRI0PynrXiovzLXfO6ZjlIWyitNXfw==
X-Google-Smtp-Source: AGHT+IEe7IdP5keh5u08VCKExfRktUW6/MVZa0FRVoW3STxpsJexFpJBo6oDL1cGB5sJAgNqTcH77A==
X-Received: by 2002:a17:903:234d:b0:295:2276:6704 with SMTP id
 d9443c01a7336-297c047bd88mr46393005ad.51.1762531150100; 
 Fri, 07 Nov 2025 07:59:10 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c93c8dsm65555485ad.80.2025.11.07.07.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:59:09 -0800 (PST)
Date: Fri, 7 Nov 2025 07:59:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH v8 6/6] net/cnxk: report link mode
Message-ID: <20251107075907.7381e6ab@phoenix>
In-Reply-To: <20251107070330.2155154-6-skori@marvell.com>
References: <20251104080901.1610706-6-skori@marvell.com>
 <20251107070330.2155154-1-skori@marvell.com>
 <20251107070330.2155154-6-skori@marvell.com>
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

On Fri, 7 Nov 2025 12:33:24 +0530
<skori@marvell.com> wrote:

> diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
> index c5ba335cfc..b7921f5b57 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -128,6 +128,14 @@ New Features
>  
>    Added ENETC4 PMD for multiple new generation SoCs.
>  
> +* **Updated CNXK ethernet driver.**
> +
> +  Added support to set/get link configuration as mentioned below:
> +
> +  * Get speed capability from firmware instead of hard coded values.
> +  * Report link type, mode and status.
> +  * Configure link mode.
> +

Is there a policy on release notes?
Looks Thomas tries to keep them in alphabetic order by vendor.
