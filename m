Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A779109C059
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:51:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7512406BC;
	Wed, 25 Mar 2026 19:51:33 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 8CF1D402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:51:31 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso186646eec.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774464690;
 x=1775069490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBpqFts94aWLONQe2aaMD5ylbUFRPUoYYoJ4tsaIhDg=;
 b=yFGCABOQtWhezzkQWsvwXUERWDWI+ZE6vf4THvNWpBqyz4VNBURwfCDqqMJpkPLfjZ
 c68NLFortIDrwR87g3EswIMLjPQo6JJg6pjW36ds3Rpi3AqzWkjZw5qdM9T1G4eLL4/d
 KOYCCm4NbjIDdmdJOm50Y818mOWf3Qrdx5rLp724XWFRKsHErJ7YwRBMdiFSINgkZjFs
 h6QmAdjzI+IDlj3FPXbMnB2DNWo/Eyx5GlKuNExu57xi4RIRL6awaOeb75zFuWjQwbKj
 1+/JeBCmScRhclsfDIQa2rDpE6/IhU9uAI+YEfFZjelWD9u3oHkKkCeQtuWwhO2lHvRj
 68ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464690; x=1775069490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oBpqFts94aWLONQe2aaMD5ylbUFRPUoYYoJ4tsaIhDg=;
 b=D0QSjGNtI8KO2fKbeNKvt0QnFwW4TSrgmSAsqrjkZew2jNV2hgqL77Rf7OctI0qxQj
 NyGINWvWuZSl3UzeU65K+KjqWAWaqtyP7GJMg2VFP3oyI/VwsUw3X0i5YBl9OOaibLUl
 IrVcNK6qNe2LmmvCubFCpoDdkGklqcORY2GnSM5g8HcOcsalH+2tT5LWMcl5RTg+wwFB
 bHkFLrCX73wyWPuZmtEUPFuQGGQ31eF55uotrubpEoep6K3eHajaqSiijIacH4MMlARL
 E3pL4xYZrVMXvowN0DlObN6A3QO8G0bMYVdRktyt9/siFPTU6i8sZw5AxsSPRDOTNhN5
 txDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcvsKRBRH7tqm7LAXKti8x7Oy/sMCm4O/sJmoKyrVBI3mBNFKR07L188ni6IxDrn5l4qc=@dpdk.org
X-Gm-Message-State: AOJu0YzD27xP7z/DC0bmr4m5bHdY/6x0IVb75JA6fbP1ChqXDcKibQXK
 yI3XXp9KoD0WBoQZZsY/ytfUKqozCqaiUHlN9uwFcRbFmm1aPrCzyzqjSy2NWk1dl+g=
X-Gm-Gg: ATEYQzwVR9ahJw7CgAIQQb47sE5its/0QJ0WJ0RVQrV0S5NYX2ByOuwfVdV4ENM2/HT
 cH0ul8/YIIQSJD/33lcLxDaXGo4FewhFVHeGAlE8iq4iYZ9a81r4uLJ990AvGm3bDVO42a/q20w
 Z+z5Omv6qvQag6dX6qFpe7CKY+FhJeS5tanWOycEkowj6b3cqAwhUjombLw+f9YlxfRL0Z8Jh4F
 RQ8h7n9mxbV30MhiG9LnMr2gQL647uQbWgZ6OcTFGVSvdk55xPKJtkatlsTPguLkMrt6jBERzX5
 t3pyxjRrlAXU3h3vT1cM+5g19aWxTZz89j0TULw/QtR2hrHOVbO1Z8X0bvCZGliiYg94BM3ghQZ
 EyZkxYSDU8a1F4BlQlc14UQnS59yTCu52bzwBQJlZh5QYBNPdh4a8arDW0C0xeE1zzaRYJ91r7C
 5uuPQMhlaG2ymQIfzpSHquzjxSo0HxZB+WdG0=
X-Received: by 2002:a05:7300:e208:b0:2c1:16da:47e1 with SMTP id
 5a478bee46e88-2c15d385d01mr2341489eec.14.1774464690523; 
 Wed, 25 Mar 2026 11:51:30 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ee01373sm378309eec.26.2026.03.25.11.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:51:30 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:51:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH v3 1/2] app/testpmd: assign share group dynamically
Message-ID: <20260325115127.0326795f@phoenix.local>
In-Reply-To: <20260325180255.57489-2-dsosnowski@nvidia.com>
References: <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260325180255.57489-1-dsosnowski@nvidia.com>
 <20260325180255.57489-2-dsosnowski@nvidia.com>
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

On Wed, 25 Mar 2026 19:02:53 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> +static void
> +try_release_share_group(struct share_group_slot *slot)
> +{
> +	uint16_t pi;
> +	bool group_not_used = true;
> +
> +	/* Check if any port still uses this share group. */
> +	RTE_ETH_FOREACH_DEV(pi) {
> +		if (ports[pi].dev_info.switch_info.domain_id == slot->domain_id &&
> +		    ports[pi].dev_info.switch_info.rx_domain == slot->rx_domain) {
> +			group_not_used = false;
> +			break;
> +		}
> +	}
> +	if (group_not_used) {
> +		slot->share_group = 0;
> +		slot->domain_id = 0;
> +		slot->rx_domain = 0;
> +	}
> +}

Just add a return and skip the group_not_used boolean.
