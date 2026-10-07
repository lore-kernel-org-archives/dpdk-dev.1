Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E57CA6007
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 14:40:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1AA140268;
	Wed,  7 Oct 2026 16:40:43 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id E796F40265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 16:40:41 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3C6FC14000EA
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:40:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 10:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791384041;
 x=1791470441; bh=sqqmEdoaeHlwboEBrOIcrfyW4QwqdlB6L+CWUFj4I4w=; b=
 RPMEU6zLDZP7eWaGyEKrn+TKnYxg1o/Vsqm/6OKWA3ICSpkbi1dqY+7Ak8+zO3KG
 YA1WkkrNshHPMCzafU3MM32cf4Ktx55hs9r/+Fqj7EPZsylIGQr4ryVBEhbR1oAb
 RDfR+JpKhP7BhHifc4dsaaiz5s0eyYNA6TTnyvm6fJCbhGr1cHzBMMuA/qSY62k/
 bWxQ7mqSyh0zbREVgI/CyPjyY8HSfYgOlVrEE4pk+IGb+rhA2xM3208JMm7/XTem
 cD+EuNG8+P7zUGdxWu4e0/jBaEInvjrArOLut/HeNpQ2iCHJXJB2VnsVs5rmUhcK
 T4CeclAnC3GXbOA8TzTIlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791384041; x=
 1791470441; bh=sqqmEdoaeHlwboEBrOIcrfyW4QwqdlB6L+CWUFj4I4w=; b=Y
 ILOmNjEmtcjVJtcVxF7Gy263aDwBL7blWUoSsPoQEkVcCt7/50jF0mBgAKha8jVK
 nggmtXD83WvoxOTYqyH5DTTdFyPS8UHXY9An8Zq6FFkaq8xNE9/Kyju55LM/pwRY
 ltbtS6O9CCLnUF4a/5oKBkthUbG7AuVMIr21m9voXh/ggeeR6AAY1K27/7K5E4Wx
 B0plnECpAPvRDX0XKl+KeTTqNi7Dgw8J7u96a+iwTbWvdwmDT1zHjNl4jOg/wK3f
 CpemhcR7au3HOXThy+WN6V1hzxEdWG0SwzYlZnXUrMinvJe2zZP7/Kg7MVbqvLDs
 myTLggw3efc51aXXykYUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791384041; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:MBunPxN2pzgSTlr6QFCbYrdaau4BaO5kkiaP5FqwR9PyGPE
 MuXkQ3Rw1/W2D8m4dt5xoc9RCl7th5XS1SlBGPERxdkqCbG5kU+ORpjY7mDQjtrT
 HmXh+vlPxsgQWVoMErxN4Hs8z5WqVOnMNjKAvH/S+9v9iHUET9PKyifFZplWIca9
 mXYm7nUZa33FdCptW3YLci1DFTcwKo8weN6TXL9WIrUgIw4QtMHzqyVFzt4NUera
 VIcxVOMtfe8KW33OOrK2lUoBW+/QMDUie4xzjeI+YYyQo83Fp+FZT4OXCQuhzzmP
 EwCMni9xdG1t8EhLoHVR9KR8CtXrdjE0bCa8PhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:jcp+nphTFFscb6O/Bq8TmuEJZhvCgrHv098aYc3D+NA=:tOgFoxgNowECtg57fyNxeGtMgDc5S5AjRsfzUchnzSY=;
X-ME-Sender: <xms:6FnGaqzrWWN7mLNNiYVS1LqIzQW0-73r6SZTaIH55qAkwSimSvJGzQ>
 <xme:6FnGahsuLNC_o-SNBa5IqjDfKBke1rzXABwC_E08DFk2WTfK4jN1RmsGjoEowWfrw
 HyvAS64t_IaAZ7LBhKdkEElwAFywY3RK0sjJCqzPLd3APXto7QP7k4>
X-ME-Received: <xmr:6FnGav32CseNewRL5ZU9WkDeOFrotOIB7B5YnkSfc2wQkKCYSFrZTWbFt14GZfha8hQjzZ7DKa4xdYZeYSXxVeY>
X-ME-Proxy-Cause: dmFkZTE6MT+G0KaBdRYemovZMn0K09+URo/PEKeVPY6ngc2j7IUAsxmC+NC606McC7rsaF
 mBJs4bCKMCjRBPPjHjwclPqvZ1CIhhSL7SpvM0mlHIWCA7VprIriGj2/jgC13fi+3/5MZD
 oJw35cmhsQc8GriN6ehu3v2qUxRASgdn5jHuv8iqSRPcjfr5qDI3ofwpAE2qCLGjcP4Ziz
 lJXuMT545VfdWImXhgFkcWodne2I+DxwPanWjTaGEDla1E9LTTixOrSjcRZehdCivzOLMU
 URlHshU5X+B2fsfIhAL2MaDAbM15Yqy2l8eQW9/9YWsGehLx5CLl7o/NHVvdZoxG6zcHLn
 rAILwQ6lG9DUgE8kRs6i0whdHnn3xKnut0CJjnctIYJRqtebuAxZID2p4XkNC5kzKsTkyv
 jeGXbomieGvSJXw43krjq8jRCBbprlNh1g/82GaODJ/7gk6ftvPppkXQPhAErcQOlM2h13
 Vr7abp9Vx60pEfWZ98SHFeDOam+t3geV+8b2BK6u4ULigk8Z4rFKq8XQ14ZYwiPHRfrTNY
 UEs7OeEBOzRcH6aYVUhSJzDEF9j8WiSe5aCtBVA6KP2fPe9rdxhu7gnELFDa6yv+BhDUdz
 1GpStoVgMqd//UDIVy7EphjS+RRLwHObYXXg3fHO+l28yIgzPO7kXgyO+1Aw
X-ME-Proxy: <xmx:6FnGak9e-8u6rLbC-5hwPyv0lxMUyHshWdEGMOP3_0VcJT9Opf0FeA>
 <xmx:6FnGaoO0qMbNl9lqVY8sL4ZqRyDNOgln0sF5BAMvLoFvxYZhzEzQcg>
 <xmx:6FnGage4Z7B0-RHAmKAYD1JbatCeZ2qwAHS26FNVLhYw1Kbz7T8jTw>
 <xmx:6FnGavVhCTnvhNKBSjna2A4axBriDk7tDV3Dt_3oi9uCCwLXNh1_qw>
 <xmx:6VnGaqktJJ8-B1qPZ1fFtA5co4htUxQIL4hVOE2KE3naBXfatpxR_Qha>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 10:40:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v5 01/25] ethdev: add default mask query to flow
Date: Wed, 07 Oct 2026 16:40:37 +0200
Message-ID: <0XhiT_Q2Rha3FyaVstQ6_Q@monjalon.net>
In-Reply-To: <338aa9ecd08cbdaf39ec5696afa9b6c619d66e53.1791369980.git.anatoly.burakov@intel.com>
References: <338aa9ecd08cbdaf39ec5696afa9b6c619d66e53.1791369980.git.anatoly.burakov@intel.com>
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

07/10/2026 12:49, Anatoly Burakov:
> The rte_flow API defines that if the mask provided with the flow item is
> NULL, a default mask should be used where applicable. There is no API to
> get such mask, so add this API to rte_flow.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

It fills a gap in the API.

Acked-by: Thomas Monjalon <thomas@monjalon.net>

Thanks


