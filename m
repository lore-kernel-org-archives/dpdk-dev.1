Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D2CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:04:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EAA8402BA;
	Wed,  3 Jun 2026 23:04:39 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 5E32E402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:04:38 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2F9987A0109;
 Wed,  3 Jun 2026 17:04:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 17:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780520676;
 x=1780607076; bh=keiKQKjL9m4w95FLP0BB+ij1MalV59JNxvDLHBXO32A=; b=
 th0t9SuxlCfI1dSEBdiWRQ2KaMszsPq4rytVrurqPUaYp7kTgR3Whd1ovjuObTpN
 EO/t7OyXNFZdEKb638KXrT5652bV/qiDXDFpC/BIUckllo/02cr7BvpQjilSiGD0
 wplQHw8zY/Rh21NwzSs9lzmsI482JcjLm5ptkhTCgatEr5VVndvEdup0y9J5bEc2
 C8iH99kXQBdMrFlYPO6RiacMsjuqNOKKgc3ry6V1qWOR1bfUx66gTh+//UBWeN8X
 U2RjJD8+BLNUI2s5hUE8+LfSNeoSeDXxmFi3E4LC6l723wso64ikBgQtNTD+GruP
 evuAujutVuVMEvgfn5JZfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780520676; x=
 1780607076; bh=keiKQKjL9m4w95FLP0BB+ij1MalV59JNxvDLHBXO32A=; b=g
 ZVZoyt7TDF1dusg0ox07GA9mR4Bw1Q9wJ33JR96w0bbxcmF+wXlV8aZ3baw8nYWH
 xU/YPPLPHcJXEjCz6PSkXW5hP1UzcDUukBaq8O4tZcVKEYF9fak9FoCmTyS5I7jp
 TVJaMZlbzz6AJQc1RfLzZiE3DPIU9CI0C+oOCAQtfg0qm86l/m4yNqP8EMNLFO0C
 Wcd9LqiBXwwswn+1/tQu4SgfwgRoKAyuJu+s33dllPqGb1dyBBxlE7aFf+DQ86ay
 cJY9FG4tbgL33Pju9Xt8SAwer9+FZhXXRVWqg7EHza11qgkPmHE5WWHyx9WTVq4E
 zzvmxaVOr07EkLom85WMw==
X-ME-Sender: <xms:5JYgapZkuVwJoymlJ-OXNel2YE69_gznv0nXypLE5v72P_qgF4kfyQ>
 <xme:5JYgar3lLCjNee4xRcv8O-4l68ecYzRq27phaxypFSNoSXEVQN8NerftBuivKkZW-
 n8wAzve2ZUjH89M9i7folQ4OmkU1QabobhsADP7ubNoFQFtNPQnzg>
X-ME-Received: <xmr:5JYgaveyrKmyc9S6J3SPaMdsKW3XXl0AZsMhs8EItQyuX92LMJybPsDPDhccnQqS2AcSt58D0BdQ50S7zmqSz2FSYQ>
X-ME-Proxy-Cause: dmFkZTENStpMDbyfblU45E3ZIJw3ubkpWn1Jz4eSbOoOU5bjXgBlZub0BRnxejqmm+03fR
 YZFJe/+b5j8IXs0BsKXyIaShfTSgswSvZkW5NeiO8i8PfGnNdK797gRBZhsE6z48/RQ5aF
 QvNYqzN6qgbYzcJ4x47nrsxOw2eujVPn0+IfbCLY8nINpYEFq8Wfb8faFxQx65RG1MXCG4
 9GzYDExGp5M5bAu+/D6XGUQKynnLHF2Vm6Oe4Y0L7oKDqVW5hsYYD6iMY3ETJrpcOgBR4U
 k1cyve/RkTjXP8ObBPzlZmCiJBtqSVw+UAwAarlMa34FCaoEK38HyiKuBSLO90u8dvSYZc
 I/ADLcJ8duE59EhHmcRe8+98R7x2GVU9hFUzlHdrmMH6ZmpRcM4xJnSbRFHJwrQd4/vbX1
 AXlYe6Z23UHcGiB6RDsQwgqszdJGhCpfachs76CTX6EFHRwtuytsNP32XxPxSxMI2UA1/x
 xNoxLB1TO32R7SfZXI4GdhTyBb/AH7dp8VROQb7kWT5pq/0E8OiTP5mt+7QSUPDOc5P0c/
 tfUr2XYvkKHNRPrqhpg8gaZaMjyXlMCE4kWGkNB/djd+ITnZtXF41zSdq0f9+Fxw+Y/5EG
 MxvKOQV6q1Rzyq+4FifDyGWO3C4bQ0gF+jeZl+uTnBOemx+SjuY9pD1a0ujQ
X-ME-Proxy: <xmx:5JYgasEDM7CL4nIMVlrT1fFMBFCayW9qC02uYmVqy9ipNemnl5hqpA>
 <xmx:5JYgag2SFlLjtgVTaxF6AwsS9znWrhAbYn_Ex1ipG-IAWs5jPlPOrg>
 <xmx:5JYgaskHcaqgdSxc7JNkFmnNLyve_PbXVIhEOxRaMWLN8_W8yTm0FQ>
 <xmx:5JYgao-jgM-cHZBfblR7xJKPRGd2In3WoJOcU0zf19Xs1KFN-xsIug>
 <xmx:5JYgakgXdJ6sLKpWgT-hr6Njh43gMtdadJBoX6BtGx3ZJ0lyLccH9lcA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 17:04:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2 1/2] config: add mbuf burst size configuration
Date: Wed, 03 Jun 2026 23:04:33 +0200
Message-ID: <KdOygM96Qb6d6ADK1-AcnA@monjalon.net>
In-Reply-To: <20260416211159.44785-1-pbhagavatula@marvell.com>
References: <20260220230745.26418-1-pbhagavatula@marvell.com>
 <20260416211159.44785-1-pbhagavatula@marvell.com>
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

16/04/2026 23:11, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Add configurable mbuf burst size macros:
> - RTE_MBUF_BURST_SIZE_THROUGHPUT: optimized for throughput (default 32)
> - RTE_MBUF_BURST_SIZE_LATENCY: optimized for low latency (default 4)
> - RTE_MBUF_BURST_SIZE_DEFAULT: references the selected profile
> 
> Add meson option 'mbuf_burst_size_default' to select between
> 'throughput' (default) and 'latency' profiles.
> 
> Platform-specific configurations can override
> RTE_MBUF_BURST_SIZE_THROUGHPUT.
> Set to 64 for CN10K which benefits from larger bursts.
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

If it would depend only on the HW, I would agree with this config.
But it's not, as said already with previous versions by others.
It is really an application configuration.
I think such config is misleading,
and useful only to demonstrate some HW with some specific demo apps.

Can we have a constant exported as part of the API
to give a tip about the capability of the hardware?
Then we could have a smarter decision in the apps.


