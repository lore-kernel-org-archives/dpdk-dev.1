Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFFACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 11:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A71A1402EB;
	Tue, 23 Sep 2025 13:27:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D8AD0402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 13:27:25 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B591497;
 Tue, 23 Sep 2025 04:27:17 -0700 (PDT)
Received: from arm.com (unknown [10.57.63.189])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 433E03F66E;
 Tue, 23 Sep 2025 04:27:24 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:27:20 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Subject: Re: [PATCH v1 1/2] dts: add start Tx first method to testpmd shell
Message-ID: <175862682201.36883.6474870956841986110.luca.vizzarro@arm.com>
References: <20250916200458.259376-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916200458.259376-1-dmarx@iol.unh.edu>
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

Looks good to me.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
