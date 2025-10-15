Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7955ACCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7B5F41141;
	Thu, 16 Oct 2025 00:17:13 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7156F40EE6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:17:12 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b550eff972eso10908a12.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566631;
 x=1761171431; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+cIxV6ImJnav8QpJpDM76DDHrdQhi+mD/OFAGWNmu4=;
 b=fzuWL0gV1Ow+PQrp1cZa7r/b5zNJNLRoS5hfFIKUWBqYDF8fgL1Iquf+thcauoCmOZ
 bCubnUfx8cVms7y0foujw7QE3uQu7q3NPUkQ674yxO+NJsMw+6YG01IwVAsAfRk9GWus
 FenyX+KUqNR4DvuPNBhhQG5SMIhMcHg/N9T8vCVOeIz60e7o3HX1f+BecyysVqZWfxQS
 Ee/9PoeYrci5DNrhVvWypOlf+SaeWXoU4hedjjI69IfBGP+sR7zGNIYGwDNOYbyS3UW/
 kVbsvsuRdIfbaRgAIwA4nIY+Q08Xsa9aVObuf8OY+CvmUzGwmyfNm2v4gqpY93gbiGiG
 8Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566631; x=1761171431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+cIxV6ImJnav8QpJpDM76DDHrdQhi+mD/OFAGWNmu4=;
 b=Wf9esFlcC1fu5i7XmSpF2zY+sWwBfdyD8QfyBnkPL/oV5G/C2ouQSD441CFBCOXDAD
 eetlVazS1a8WgKiU/xkom3yzMeaZEY019j/jWtEllJohCI0yHGszbhCnpt7gaZdwCyv5
 alNtLuA4N9ZtuKV28OveuAZhOIP0/YwKM0pMuT5HhFZyE7mJrXBk8taU9NZWpId7SKsx
 6a3qA87P5hzq0RQAj13K8D5N4E4w+cAuvTyUQ2EZIMxmNFFr4Cfw8kDBEDqsQ1bGYVBE
 oj598Jhs5V8zvnE5+7Lsowp7fVaUlxrC4KXCh8l7R75ZBY1j6Bfdpo42eOPZbWo0Xsm/
 V+dA==
X-Gm-Message-State: AOJu0Yygq5uCuak9MNIrBrFnv0QJ2gnMbIR5YBbbVRuJmSXkez5IBuqC
 lwPtaJdV/us5Re5e2riIY4+enOXN5/ZqeJP0YzVO+FIw6PxVn+3jMxAhEnm03aYUkYL0VXktR/J
 QS/giOMk=
X-Gm-Gg: ASbGncs6COEUYkwN2iRCm8vhHC/3P5KASPq0+C6KHJ3FEiSN8oEHpF3NJitWX4M+Bue
 D8mir1BS3MWep+iYpiFiOUi2fARkJbNydwqg7/tfnGbgOEAHdDWVGYDFevrY1VFoR1BqFkZsdaB
 SN5g1RQ5hqV+Sl0GJRLE6ySS/9xCPJ1rLDPUoxDZBrDWDqRZM5r1DAADFYvh2yS/Z7t32TJvIbz
 DEP/317CI3BnJUSP8ZJ4tztxiBl4PymbbdYqsL3IcFVQ4o9FUJbgTcCDeoTQ3PHb1zdwCb/8TS1
 Rl0DJDASPRmXMeqZfc7oVopASDX91sp1jyOTyXNM0kQFQ3gxc+qN1o7vSLCrIxvyEIgo4ZfAYLB
 pxjB4MkldJCkWQmND2OdfY4y4l8eqCPzrfOpyQJo1n5WycHaOuixJQn91hSiZq+0SonM91GYmy5
 jMsZqHX79hEvU5ZCgYC608CoqFpILx9+nZbEvIk+L2ce8uRNfQRBYa8x4ryF3DKZg=
X-Google-Smtp-Source: AGHT+IFnwvPvqsQba2//Jj2GYdTYH5oYTGPtiDRpryJ3DowsGFA/Vk0rdzIxmMzFsPQFyb36Zt4czQ==
X-Received: by 2002:a17:902:dac5:b0:290:9934:fd04 with SMTP id
 d9443c01a7336-29099350457mr14173215ad.28.1760566631520; 
 Wed, 15 Oct 2025 15:17:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099afbdb5sm6674555ad.104.2025.10.15.15.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:17:11 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:16:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net
Subject: Re: [PATCH v3 7/7] ethdev: deprecate queue stats mapping functions
Message-ID: <20251015151622.27db28d1@hermes.local>
In-Reply-To: <20251003110201.1541183-8-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
 <20251003110201.1541183-8-bruce.richardson@intel.com>
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

On Fri,  3 Oct 2025 12:02:01 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index 4b9da99484..4df0e83de2 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -68,6 +68,12 @@ Deprecation Notices
>    and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
>    will be removed in DPDK 25.11.
>  
> +* ethdev: The queue stats mapping functions
> +  ``rte_eth_dev_set_tx_queue_stats_mapping`` and ``rte_eth_dev_set_rx_queue_stats_mapping``
> +  are deprecated and will be removed in a future release.
> +  Following the removal of queue statistics from the main ethdev statistics struture,

Spelling of structure needs to be fixed.

> +  these functions are no longer needed.
> +
