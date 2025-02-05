Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E94EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:33:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A17340289;
	Wed,  5 Feb 2025 17:33:08 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id E7D0640270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:33:07 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-216728b1836so321995ad.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738773187;
 x=1739377987; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdHViYQDPmMOmyuFA7AzHNDjEtkLLedCui9Hh+s5r0o=;
 b=reMbh6Q7kE+HkuzNd+BNf2oKTFspvqWSSh+e2WsOye3OzFs2Nj6jjVYvx8IvYDpBCG
 QOpXamHjAoYHAajqO6mnxs2MSv/DjokOOSRnItt7W4dLGhD2Rh7+7mitIZA5/QlNJSIs
 osoK3OZpRCvKtG8H2r/YH8AaKV8vHILq6xYraoVzcV84h+FipHDcnr+VMpMa2cTSjZBM
 b4FXt5H2rLc2Kr7ilMJsUvKeB5vUVlQmRrxlAjtJfFl39+LhOwmuX4Yk5HAz+ti4KQOq
 ac7ZwLtPJIBydhxVGggUYbRsURnyiYSh9l1shZkz1QJV8zYeOf3+tpAi1eL+T+Y00TtW
 V6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738773187; x=1739377987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdHViYQDPmMOmyuFA7AzHNDjEtkLLedCui9Hh+s5r0o=;
 b=lsG4EB7OaZ1i1HY6F0oRKUBEX2XdBNiiMg6l00S9ZYaXklvu+HxhF0KIoC7uxYEisO
 7/aNLbnd1me1PxVZuN4MlC/uX2wYiUhCvfHnWvq1j2zmahlg2RRA7K8U/XCOYCX3oIrX
 n606zfeX3D7E3JY4pwRcLKrhrRr6LevQ24TRpryGEbXC4vUUvNYDex/CGnOHX+A5R9je
 2RJRAC3Cdzk6KOKZR6RDLuL8VK69QUJi7YVbEZKIbJXERCyL+GLuIP6nGhlhmHo78OHA
 ncy99PwqZUL9XrB3LBGSfseTTjLMGKMxeN2ewJZ6/bkyqfSYSnRYEDfE4m6B/3sCJYCn
 pcZQ==
X-Gm-Message-State: AOJu0Yy77DlY3dNd1jiYFFLqpHcg2+Pfy7RHca6McT7sAK1aNw41OsLK
 xJC7m7/ycMyWTy9tPjRSKS4DF2xAeV7m78DibyWsgQNeUrJnZxtvdj1QURGl/hU=
X-Gm-Gg: ASbGnctjfqvDZDUAxfuIyeacXx+Y/ynYZHbj/yRMTmR/+TV6LWivolU8C11d0WVAEzJ
 c4mBU0Q32Iwc1+AlUoslS4yFPLphDDkdjF91WKYPjU0QU1NbhC9/YxkbLcDZ9Px3UgBarVTQu8W
 o8b0Cr+BSyFyKHIRLcC8RR+tFDifwXUegXHfVpfNTHxfsXNbmKdAxv4Otm0ZMC4G5RptDoX4FvB
 i4R0p8+6DB+3KDwsEcqR61JGjawtnjYGaKGm79QaVsT3qMP4dcuJjdoDquJKbczX3gTuqkxjXYD
 3jC6/4zJxCodNQD87OUYFEXdX96oQzpGTO9NUWICz9pLb0u0jvGisTXUb+EX8MmGHYx1
X-Google-Smtp-Source: AGHT+IHhkVfBb0OIT+QeQQjDgDK9cQSxCjCy2BEol37WN5koXb3Brw1hydJJaMbKaEeb8kaqdBgyrA==
X-Received: by 2002:a17:902:f68c:b0:21b:d105:26b9 with SMTP id
 d9443c01a7336-21f17e45b7emr55226045ad.16.1738773186841; 
 Wed, 05 Feb 2025 08:33:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de3303cdbsm115876695ad.199.2025.02.05.08.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:33:06 -0800 (PST)
Date: Wed, 5 Feb 2025 08:33:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, vladimir.medvedkin@intel.com,
 ian.stokes@intel.com, john.mcnamara@intel.com
Subject: Re: [PATCH] build: remove support for icc compiler
Message-ID: <20250205083304.7934758e@hermes.local>
In-Reply-To: <20250205161823.2849595-1-bruce.richardson@intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
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

On Wed,  5 Feb 2025 16:18:19 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The Intel-produced compiler "icc" has been replaced by the newer
> clang-based "icx" compiler. DPDK compilation has also not been tested
> recently with the icc compiler, so let's remove doc and code references
> to icc, and any special macros or build support that was added for it.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Probably should add a release note for this. But overall looks like a great idea.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
