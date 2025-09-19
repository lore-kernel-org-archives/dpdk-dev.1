Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4441CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 17:48:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7EEF4042F;
	Fri, 19 Sep 2025 19:48:23 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0FB5B4028E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 19:48:22 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 89E11EC00BD;
 Fri, 19 Sep 2025 13:48:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 19 Sep 2025 13:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758304101;
 x=1758390501; bh=Tg0xxt2njLOWVTbmhY7TX+MS0HFGRXe0reKN7Xn7MWQ=; b=
 gUEvg6VHQR25/rXnrFwIDbnFzv8iY052DYaWyROmLytAd9ysDW18HFNUuAeo2C4U
 LqRQyU9R/0njOyBWLLOiWeBBKhLYeuQnvxuriI8IbjT7q0m178ae2paJIGqRzmT4
 3uTfy5sxOdDovUFZvEm1/+hSjPLj71N0gkNJ97jkvKPZI2CRuxNBevzMxeenZcB+
 MAr6rR6EDFRKIAjliq4L5mn4Bv47RZ3JEjoMRy0WVps5PmBb0jOWC2bQfz8CckrL
 AZ81yMdWxE6Q1U7pmJYzsaytDbKch2N/xcoL6/sa+btZceO5UG8PxWHH223TbRHw
 u7AGk8IK9ULpwM1HnnU74g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758304101; x=
 1758390501; bh=Tg0xxt2njLOWVTbmhY7TX+MS0HFGRXe0reKN7Xn7MWQ=; b=o
 IIcuv0tr+qH/i2AW9j2cNETSKAqrsGnDgEI/cFcUD2Nd+RIwoluqHTzexpsKWzhW
 davML2jaJkeGFZciM/CaWTeIw5VaRPrhEhW7IBXkCEIMLoVjImkwSiyOdo3iQOot
 wm1rQ0c/QT3Doj8qQOzARnCziW8207tsOuLhE0Whq3x4l47DlsPDjDa2248eAtGP
 9OwFApKta6a2yKtXzfBA7dEiqBDFm3tXYCJ+94VAdHzxC5OhJF6KuQlkx/RBs3Jk
 wUXKvCB2bixDiKAE8Tj9bBMNwB/Py24kNWnecvcjMUzitKe/0l9BiHkFCr56MkYv
 jpwjX7XeBcE6Uzlm7YQ5A==
X-ME-Sender: <xms:ZJfNaLXaimr_qjQRt8P2n4kqJZTSAWbGu_PCZN_pDLhoULesGzK9TQ>
 <xme:ZJfNaPFPjFUQrwodceXxKr3I0XfFitbpIlIJEsLmFvMxpdDj_fKpZthXc7wNpWRDz
 dnaePY6szc2fhcdGA>
X-ME-Received: <xmr:ZJfNaN25XbIIUn-TGJXpfJotVY0fsbCfR0j3CAPOzkDiJW7E1fSAnYnp8CtlogSyfNZBJfjmkeTXZf6n9w7LJNot8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleekhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihuhgvtghhihesihhstggrshdrrg
 gtrdgtnhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehvlhgr
 ughimhhirhdrmhgvughvvggukhhinhesihhnthgvlhdrtghomhdprhgtphhtthhopehsth
 grnhhishhlrgifrdhkrghruggrtghhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhk
 jegssehfohigmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZJfNaBNutlkiconkLpeRgpMW-cu9an76yRvGtc4JIWq7rLOxAelnAw>
 <xmx:ZJfNaM5JEhGmQeTAIKGaAA2UkylCzCPv5iedJE9prqmJ8tBwXCOJFg>
 <xmx:ZJfNaL3IObfuB8lpN4WjGLMmxbTlJOkEekidDvXjA9sSDh_ybTG6eg>
 <xmx:ZJfNaNyHodmIjuYN19YWDwtH7qo4rTU1YJAeHWEhRDAj2G9pfMJYOA>
 <xmx:ZZfNaORm7IRMRvAoRyDRbOEdw1pLfQnLvG6mV6S1L8ISz0UMN67zO-WR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 13:48:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>, uk7b@foxmail.com
Subject: Re: [PATCH v3 3/4] lib/fib: R-V V rte_fib_lookup_bulk
Date: Fri, 19 Sep 2025 19:48:18 +0200
Message-ID: <4567272.LM0AJKV5NW@thomas>
In-Reply-To: <tencent_DCD86DAE038B30CC8DA74E95C5C27708B605@qq.com>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
 <tencent_DCD86DAE038B30CC8DA74E95C5C27708B605@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

19/09/2025 18:33, uk7b@foxmail.com:
> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
> +#ifndef _DIR248_RVV_H_
> +#define _DIR248_RVV_H_
> +
> +#include "rte_cpuflags.h"

It should be
	#include <rte_cpuflags.h>
and it should be only where really needed (.c probably).

Don't bother doing another version, I'm working on it,
and will merge with coding style improvements.



