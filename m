Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028F3C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 13:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18CDD40279;
	Thu, 20 Aug 2026 15:53:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 19AC940150
 for <dev@dpdk.org>; Thu, 20 Aug 2026 15:53:33 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB95153B;
 Thu, 20 Aug 2026 06:53:28 -0700 (PDT)
Received: from [10.1.36.55] (JR4XG4HTQC.cambridge.arm.com [10.1.36.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 409AC3F763;
 Thu, 20 Aug 2026 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787234012; bh=TL7cSaEQN6F8kp05cZYgBYrBiX414HKsuxHqDl7k+7g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BCgaq5B/KMbW4GueIB7kwPF1PV23lUP82JbHPIj4YoTfiCvqa2mMRcesa+O2emjkX
 D/Qg89kFHuuJ7XPJKacCHxXi2SjPU5/XR21BWQClzUn6+ySXLaVRC49Vp0KtglqYpe
 OKfbxTGKrmeCEH8ccvPGKtl5r0gV5LOH4Ptf1F7U=
Message-ID: <367ea6e0-1e4b-4abb-aa8e-9b4b8766200c@arm.com>
Date: Thu, 20 Aug 2026 14:53:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] dts: move testbed model from framework to API
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260807161642.122310-1-abailey@iol.unh.edu>
 <20260807161642.122310-5-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260807161642.122310-5-abailey@iol.unh.edu>
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

This one is a lot less ideal. For example scapy and trex provide whole 
implementations. These shouldn't live in the API package. As mentioned 
before the API package is meant to be a reliable interface to the test 
writer, so in theory only abstract functions should live there. I 
understand most of the testbed model package is indeed definitions so 
it's just a few things that need taking care of.
