Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED1C71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:15:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F139402BC;
	Mon, 16 Jun 2025 18:15:50 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DBD034021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:15:48 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C44B81515;
 Mon, 16 Jun 2025 09:15:26 -0700 (PDT)
Received: from [10.57.48.125] (unknown [10.57.48.125])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A66A3F673;
 Mon, 16 Jun 2025 09:15:46 -0700 (PDT)
Message-ID: <1e2a1edc-23af-4c42-91aa-2c75ed2cce53@arm.com>
Date: Mon, 16 Jun 2025 17:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: elaborate on per test suite configuration dts docs
To: Nicholas Pratte <npratte@iol.unh.edu>, thomas@monjalon.net,
 probb@iol.unh.edu, dmarx@iol.unh.edu, paul.szczepanek@arm.com,
 Honnappa.Nagarahalli@arm.com, thomas.wilks@arm.com,
 yoan.picchi@foss.arm.com, stephen@networkplumber.org
Cc: dev@dpdk.org
References: <20250516202600.632070-2-npratte@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250516202600.632070-2-npratte@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Agree with Dean's changes. Also the start marker is broken, but can 
easily be added.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

