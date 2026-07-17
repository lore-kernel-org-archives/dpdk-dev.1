Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF91CC4451C
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:50:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B448A402D4;
	Fri, 17 Jul 2026 14:50:48 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 1F44A402BA
 for <dev@dpdk.org>; Fri, 17 Jul 2026 14:50:47 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id A60CEEC0180;
 Fri, 17 Jul 2026 08:50:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 08:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784292646;
 x=1784379046; bh=vC3jTikM6n/xryGf6DHncNyeRXEEVUnf/kSDIti/s84=; b=
 KABqjFd5RxY5MfFbLWR0n6t1Tb5bCy1YpNeTnJCNzuCF7SeGH96G2kvwFpHhMDBm
 41/nhm1xM6mHHE2hlQuP2eM03aW1NFwXKMV4MVQgy4vOHMdh4HGntvH7GuXc8Rpg
 rSkyFGYomvw2fNY9n01leALY2w+FyK+khe/NwhoUtEmfnkkH4HoCRxV6eNXwrRFC
 XdErjVHgjc8ILMkhJBKDQwNMTIa9aidDRXyJaVtFBATfaKUcnU01qsIy9xnLq5xi
 QcVBA93+CZ+c2Htc4jOa+NCGEgnjEUhcVOfTsRTeFJSnM+slfnMeCdfHRm60UHsW
 rn+ch7D5SOQlfW2e7CcBMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784292646; x=
 1784379046; bh=vC3jTikM6n/xryGf6DHncNyeRXEEVUnf/kSDIti/s84=; b=Q
 5Fv9O/lcUY1lufVExMQccWKkTEaePOiewWGkrYcryoBC5VoWNwWTVnOiHIfgrEp1
 h0GAXIY2AflbRxgk1g9lpJnHwDaAgCw7/OidRUMCJXJvGq91PpuZHBM1yNNUM2Ji
 qU44/e+2EJVcDNLhQ/Mt1Raa7i1LKjZuDlRh4ij3rj1DFECvd7CXypTGMMdVWTRz
 rAB3BpGEii+LmCeLKeMYafa5Nwm0OMuPujN5bCnMxkxOzpLI8nJIqFsvok/eYrrW
 N4Bk0Qo+a90arTI3r+S2kdHAXaRnzsrx+E+qWeS1n9zAh6JhoMfGPv4ulBz9ifc9
 ZHTuDVcgdbzIm+MIhsdMA==
X-ME-Sender: <xms:JiVaah4azF0bkjRUloEhr6nZzeDxzyqVPLl3-O_1XQHgtuE17n7GZQ>
 <xme:JiVaajP-nQTWoZ5-TKKOhe-cnEE-2rDuLGoRQp4lw0T71HJsaJNDbp_jnf7FzqRjx
 26K6Et0AVORqvvsEXrgjSY9cQYw-SVJTs2Rp3wqOPoFxXQ2NQmJRw>
X-ME-Received: <xmr:JiVaannAP1awBKiicbu3u8l9vr70G6lsmcl9vQKA-Vb_ajDO6rKg7OoBo1QhQ8qQxGIcnM243HPeao9PgA>
X-ME-Proxy-Cause: dmFkZTF/efTa96VRoqp0LalCL2ZyA7d3WVJwUyYm4e0EuMROVKykNnsmAj5qlZuUxBSs/H
 wiayIwETBQxVX0RMQYFvUOZsMjg96yDY7tcIepQ061C09GbJVlJyYYZhTZWSyTHnnKbOEn
 XwfNEI3+9uT+tHc4FtQYqSf9HTsq4Orl5XoVcaK7Q4YQC3IwBitPhsM8Adhc5tOa/v5Nsc
 1g+1M/RCCfUbVqc3BA0uhCwom6xAUxjiM+qTPH2n76jOfCS8xsNt4ddVyDUu5HHOg3tn+F
 Msf/Ubh4UOL9NJr8kfNHUuKNMSNzN9AP/+cFPlf85BJUuCcqntyzB16Q5U7yW7gvc5jBto
 Hnc8/XUeHVPaeOm1S4ZEN/O/vzPCj1ebGgNqkRzuGRfr8SmTJaYQ6MF/SYV2UJwatbvlQT
 QsfxunqnoIFtj/JTTF1+d2ffm9BTzckn0KnfVXpYMmJZDn07NWkIQ7O1bydH+f92BmfIRq
 3v8RPL4dBinjmTldMqx1FUUZNPlB2Sx5hlyyBUbHKn80X4cajk29NxCUDvbpExJk3BdKEC
 YqCyocFnNa4yNoDXLFABe9P8/EdNBJDl8Bd/w16D+qIopLCrXkuzna+OCTg0X1kSY/gUQs
 TKHgQOOXks02jXP+6RrWCTtZibgw/VWkvTheD+CGGmmrD13TT2lVoKjudpKA
X-ME-Proxy: <xmx:JiVaaiShbw-mpRdHOwAjgkEojmsj5vXyTtI_Qphy-bhDYoTMVOv2iA>
 <xmx:JiVaarD8-9Yzig350NdLWDbCfSGKlW0eAOCN4PukKIBSoNK7UdjIJw>
 <xmx:JiVaapQ6W2mP_2PSrsyY3O-tDA1zp2sDlnAo-0ls2ig1G_Ki5_9_Mw>
 <xmx:JiVaappkSpXjrpmZWgkh25ry_f_9r1R6JLWFyaLgpOqVlntWGUUd0Q>
 <xmx:JiVaavgeUaDB1CjaM1r_aCns5vIOYc52_TNB3jJSKlr9kAJ8gXxfsPTV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 08:50:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 2/8] doc: document rte_os.h
Date: Fri, 17 Jul 2026 14:50:43 +0200
Message-ID: <o9pff8usTZKoTG6Tp4x0JA@monjalon.net>
In-Reply-To: <d118b8d80ba64106ad538a5d214f1f34@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <4fzQ93JqRAO9h6zzYW03fg@monjalon.net>
 <d118b8d80ba64106ad538a5d214f1f34@huawei.com>
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

17/07/2026 10:34, Marat Khalili:
> > I don't understand the benefit of adding an empty file.
> > rte_os.h files are defining standard functions which do not need documentation.
> 
> It was easier to add a stub file explaining the file purpose than to add an exception just for it, but sure we can exclude it explicitly.

I think an exception would be appropriate, there is nothing to document.


