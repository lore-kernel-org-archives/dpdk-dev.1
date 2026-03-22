Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D26BFC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 14:02:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AF7C4042C;
	Sun, 22 Mar 2026 15:02:41 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id E2DCF402EE
 for <dev@dpdk.org>; Sun, 22 Mar 2026 15:02:39 +0100 (CET)
Received: from L30177.local (unknown [78.240.46.143])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id C464C78034E;
 Sun, 22 Mar 2026 15:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1774188159;
 bh=QNsLh3MtXH1pSGmFtMfo9d7+THf3A/wVOjCGi0qVBvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pvl53vmEFvDaTNw7NNZUr2LzwsRsNfTFx6WqwB6MJMg/x1WFD8daW/hNHZARWI45f
 WJxJqFjFhyTz0BlA4VvixLU5hUIUT7bIXVaYCFSYPGnsFxwn1Uv3cj1N9AVdlPOb0i
 kBdtNXaDCPGYSnsURRLclXNHm5N5StMFjZM3Qs/vR2hPfe+AzDQOmMslVZPPhWF0/4
 3x+ka5tf3ia6+N6X6tQdH+uKXES3UTWw1jKjPJVIcho6tE6F/pZxbiOBEhkoOiXbQK
 wSBSy3TQ0C086H43fY8VnUfBOQYS34uPjgiiHJUrLeaOqzFQ9CyngXv+0W9EhtDFxr
 BnvFf3cjnEe7w==
Date: Sun, 22 Mar 2026 15:02:25 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Slava Ovsiienko <viacheslavo@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: Re: [PATCH v3 07/9] net/mlx5: add testpmd command to query per-queue
 rate limit
Message-ID: <ab_2cStqWrfdNJAH@L30177.local>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
 <20260312220120.3256755-8-vjardin@free.fr>
 <DM4PR12MB608781EBBE46068C2163646BDF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB608781EBBE46068C2163646BDF4CA@DM4PR12MB6087.namprd12.prod.outlook.com>
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

Hi Slava,

Le 20/03/26 15:38, Slava Ovsiienko a écrit :
> BTW, we have mlx5_tx_burst_mode_get(), all information about tx rate limit could be shown there.
> (I do not insist on, JFYI).

Thank you for the suggestion. But I think keeping both makes sense for different use cases:

- mlx5_tx_burst_mode_get(), it returns a human-readable string describing
  the burst mode. Embedding rate limit info there would mix concerns
  and the information would only be available as unstructured text.

- rte_pmd_mlx5_txq_rate_limit_query() returns some structured data
  (rate_mbps, pp_index, fw_pp_index) that the applications and scripts
  can consume programmatically. The readback via mlx5_devx_cmd_query_sq() is also
  useful for verifying that the firmware actually applied the PP index to the SQ.

Best regards,
  Vincent
