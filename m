Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E974BC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 18:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A841040677;
	Mon, 16 Jun 2025 20:05:42 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 708DC40670
 for <dev@dpdk.org>; Mon, 16 Jun 2025 20:05:41 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-235ef62066eso73455425ad.3
 for <dev@dpdk.org>; Mon, 16 Jun 2025 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750097140;
 x=1750701940; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riX4D0rP+9LkJrJvaLLaavXWQZC2eKlgu/4EbWyRI4o=;
 b=CPnuBTRDIpCgAX1FApZ55fpX9lyEp+PoFBvfTz+9PXtIl5JDN4MooMkYVqjBUvRJJe
 bWGdOrk4pPUhwBytP1pvf5BTUGfWfyRkVWnFRNtBtapw95/aQY3B2SRQxETpsySMTTZ8
 OYHbWMQ4SQSkjoS0TakCRV9KtubSYtatruFTzP54o9BR6U24iEo7h9wrpJDtR2ZNQpzx
 imJXzDXunibn5a1DiTIH3O3+NqHqoyU7U0xuh1rb3c6fF3AjF4XZS4r6M/eWUfLsO1/W
 DeuLo2YdGHQwSURSGKyKl1ihs+XnD1qFgAwz5mE6XqsT79p8diVlKyqn5yOw10emoxbs
 eO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750097140; x=1750701940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riX4D0rP+9LkJrJvaLLaavXWQZC2eKlgu/4EbWyRI4o=;
 b=N+1IlnPFHWh63NN+aI1nBWrnoV+tgYaJ6C3QeI6QygkcaImh+Y6zWfxA0ZOSv0NURe
 m+sgJWJpNmSTIpLdgYw83K0XTd14oNSD25DglANVDQwWnBF5b0I/5YVtbgtLBcae7Fxa
 dUfWOIegSvDeEz56BReKGpKVuVSn/RRIC8rRBTwvmZzwSrjRj3lDhldcb06vRk3cUfvx
 sTQpwIokMBON4fZ/Ub5qQnbli6AptAJc0t70ajw/iENDMQd9zQa31o8jAWmGPEmozhIY
 xWBGB7Tp5vTW50T+z6rYtGmI1YfJvV80kNiTSUoY2tRkRM+DAoTq4XsrsqgMGfc97RbU
 P0Ew==
X-Gm-Message-State: AOJu0YzPt0ktNqjzXa9q87+Ffw3qEjyfUTm619WhrfXELqIBcvvWS8Jw
 QDikhJuYD5ZuEE9oEsXGH9uZOrAqNjbYjRjsJ92ACc800ADwkPFw+EJxNhWOlgmoSws=
X-Gm-Gg: ASbGncvROp91lPWjApIImYN15HqpmGv07IQU/oe2aCNv1X3Z9fcEDLfcdrMscSwolUJ
 vqvbEDEg+e4lj3v5VjQUOo9teP9udD+9lQ7YzxCcn3Gmdr4eudApFISfERiARMrXcVq2EKEYlUt
 9N/KJmTKY5aduIRWdu7/GkrTZd/YiKjbbCS2sj2DQO5gVkozW1WuIvCF4VMMnmnqBCeyYEcNocv
 zeGsX5UR3GTYMNgW3Q6xsn0s3li6Ns5Cbhp7yKoZTTy9fskbjVwghj+4qhuSIrE13X+p0H18ujZ
 oHKdngUYT/VmfbSdHZlNOtjcoqsbirZ3N2ZweAyulW6p+kIrr0qM/At4cVyc2UohDsW3G1vuaAL
 wyi3IMDEegpzPodMwIVIpAOGbYHCWkgIeuZJu1yo=
X-Google-Smtp-Source: AGHT+IGMzaLQ3ATrBwXTBq9uu7h7FNYDlOPlv3R2mHgFpwqyszqupyIP/Jtt5kg3mKsjlD9pFVAjew==
X-Received: by 2002:a17:902:f711:b0:234:8eeb:d824 with SMTP id
 d9443c01a7336-2366b40b69bmr133978545ad.48.1750097137982; 
 Mon, 16 Jun 2025 11:05:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365deb887csm64337985ad.192.2025.06.16.11.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 11:05:37 -0700 (PDT)
Date: Mon, 16 Jun 2025 11:05:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250616110528.4cf6775d@hermes.local>
In-Reply-To: <20250609211937.345620-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250609211937.345620-1-schneide@qti.qualcomm.com>
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

On Mon,  9 Jun 2025 15:19:37 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
> 
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
> 
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
> 
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
> ---

Recheck-request: aws-unit-testing
