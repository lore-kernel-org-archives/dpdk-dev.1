Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D1CC021A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98DDF42E36;
	Wed, 12 Feb 2025 17:47:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 664ED42DE9
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:47:48 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8A4A12FC;
 Wed, 12 Feb 2025 08:48:08 -0800 (PST)
Received: from [10.57.11.32] (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1FD3F5A1;
 Wed, 12 Feb 2025 08:47:47 -0800 (PST)
Message-ID: <72306136-d952-453b-a73a-ca2693589190@arm.com>
Date: Wed, 12 Feb 2025 16:47:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] dts: add port topology configuration
Content-Language: en-GB
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-2-luca.vizzarro@arm.com>
 <CAKXZ7egutoK9hCeV_gkjmFPJ8qn7we3_rJ3-LfUOvzrmdbpGfw@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAKXZ7egutoK9hCeV_gkjmFPJ8qn7we3_rJ3-LfUOvzrmdbpGfw@mail.gmail.com>
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

Great points! Thank you, will apply.
