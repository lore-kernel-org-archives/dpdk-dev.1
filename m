Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9954C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 09:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 993444065C;
	Wed, 23 Jul 2025 11:07:22 +0200 (CEST)
Received: from out-dbl.mail.syseleven.net (out-dbl.mail.syseleven.net
 [195.192.142.195])
 by mails.dpdk.org (Postfix) with ESMTP id 9892740264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 11:07:21 +0200 (CEST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
 by out-dbl.mail.syseleven.net (Postfix) with ESMTPSA id CA2A31F8184;
 Wed, 23 Jul 2025 11:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=syseleven.de;
 s=2022n001; t=1753261640;
 bh=/3pP5opggMXx8/AYYaNXPirQTxxJkn94+ynwJWBbcTQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Qdpe99HBgFZ95vwWAjTVDrO0H4Bm/DbLsyJnzM4CwoLXV1KrmyadOm82knYq0I/nP
 L2O4/vOFdVGYvKJFnoqSvAQ4tYAsXllckSHgrIClM3SwAwrOxwRJDumPBCazCvZoxA
 TV46mbpsZLhReWnIOPHqrXK6CulqH0zGfbpMU787E3lU6ahxJ7MDCUtE6wKsGU4XOU
 DnPc3RkuKTIu9OCgWU2wc+0otURz4/jAI2Bz3fxkJpWnBxI/XL+BRWsVdzQeh2llyn
 dorx6NDXywtpybIs1tjkd3E70KYVyvsAmUiUz6oqa18AmAtB1j01UiHUcFXCFX1Yku
 lHktMkbf6BvbA==
Message-ID: <871879d3-b34c-4cea-9ae0-4715fb1c45fe@syseleven.de>
Date: Wed, 23 Jul 2025 11:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: deprecate representor matching devarg
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Michael Rossberg <michael.rossberg@tu-ilmenau.de>,
 Michael Pfeiffer <m.pfeiffer@syseleven.de>
References: <20250716093846.1117794-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Organization: SysEleven GmbH
In-Reply-To: <20250716093846.1117794-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

On 16.07.25 11:38, Dariusz Sosnowski wrote:

> Mark repr_matching_en device argument exposed by mlx5 PMD
> as deprecated and schedule its removal in 25.11 release.
>
> [...]
>
> A new unified representor model, described in
> https://fast.dpdk.org/events/slides/DPDK-2024-07-unified_representor.pdf
> should be developed.

The unified representor model seems to only address aggregation of 
traffic of all ports to a single representor (the e-switch manager port).
In our use case with BlueField DPUs, however, traffic is always 
intercepted by the DPU and handled differently depending on whether the 
traffic came from one of the host representors (i.e. the host system or 
a VM) or one of the physical port representors (i.e. the the network 
fabric).
These two traffic groups are usually processed by disjoint sets of CPUs 
processing disjoint sets of DPDK ports.
With repr_matching_en=0, we can flexibly steer traffic from many 
represented ports to different representors (e.g. dummy SF representors) 
to aggregate traffic by port group on the receive path.
To do this, we create flow rules that tag packets received from the 
represented ports accordingly and match traffic by this tag in ingress 
flow rules for the aggregation representors. This is only possible with 
repr_matching_en=0, since only then traffic coming from arbitrary ports 
can be matched.

Hence my question: Can such a flexible mapping still be achieved without 
repr_matching_en=0? Otherwise, removal of this devarg would break our 
use case.

Best regards
Adrian

-- 

Adrian Schollmeyer

SysEleven GmbH
Boxhagener Straße 80
10245 Berlin

T +49 30 / 23 32 012-0
F +49 30 / 61 67 55 5-0

https:// www.syseleven.de <https://www.syseleven.de>
https://www.linkedin.com/company/ syseleven-gmbh 
<https://www.linkedin.com/company/syseleven-gmbh>

Current system status always at:
https://www.syseleven-status.net/

Company headquarters: Berlin
Registered court: AG Berlin Charlottenburg, HRB 108571 Berlin
Managing directors: Andreas Hermann, Jens Ihlenfeld, Jens Plogsties, 
Andreas Rückriegel

       

