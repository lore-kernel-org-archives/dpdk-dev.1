Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22FFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9895E4066E;
	Wed, 29 Apr 2026 11:58:24 +0200 (CEST)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id 75E78402EA;
 Mon, 27 Apr 2026 18:30:19 +0200 (CEST)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id 62347C1777;
 Mon, 27 Apr 2026 19:30:18 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-type:content-type:date:from:from:message-id
 :mime-version:reply-to:subject:subject:to:to; s=default; bh=SKlw
 aEpALGZb1BO/4/pn2x3NHeSatMNJ/V2bIFmqFbc=; b=O0EYE2qzeuHTv759vZyi
 v7QVSCuceGYqe2Ntjh+tyYU/5kEQUJexIRpycwlRHadM8Z1b0fiq5+u4V3X2wHPY
 oUVvbl2BOtCwza1m1JGX8vsJSnHvXqP99xQCNdfkIWpNFgwWiNjSn7C0FRqx+Lng
 wh6v+HAimhZzv0jnST1UMib67HdCBGcYrIWeJQv/MYV+sEKDM59zVkcu5PC12uh9
 ciR5U/6rNX1qUUxWVJb14WblaGvQS/F63HI31gaf41CDGlO4FuZwukxHh9IMQBYC
 oA10Gaa2c7ubYqNYaP5L3a0IzjzqeeEL9DaJ7aUOjDGY3KKUG8TlyuYN/K1GXr/F
 og==
Date: Mon, 27 Apr 2026 19:30:18 +0300 (AST)
From: Abdulrahman Alshawi <ashawi@wirefilter.com>
To: dev <dev@dpdk.org>
Cc: bharat <bharat@chelsio.com>, stable <stable@dpdk.org>
Message-ID: <2136264989.15868282.1777307418083.JavaMail.zimbra@wirefilter.com>
Subject: [PATCH 0/2] net/cxgbe: fix packed Rx handling and flow port scoping
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_a124a1c2-25d8-4372-b55d-bdbcd1d837d3"
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraModernWebClient - GC147
 (Mac)/10.1.16_GA_4850)
Thread-Index: vibgbhNHf0ETdtVkwLuwbZrWfuFjrQ==
Thread-Topic: net/cxgbe: fix packed Rx handling and flow port scoping
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

--=_a124a1c2-25d8-4372-b55d-bdbcd1d837d3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

 
 
 

This series fixes two correctness issues in the cxgbe PMD that can cause
traffic loss on Chelsio T6 adapters, especially when rte_flow QUEUE
rules concentrate ingress on a small set of RX queues. 

Patch 1 fixes packed Rx response handling. The current PMD assumes every
response descriptor starts a new Free List buffer by requiring
F_RSPD_NEWBUF on each response. That assumption does not always hold for
packed ingress responses. Under sustained small-packet traffic to a
single ingress queue, the FL/IQ state goes out of sync and the affected
Rx path stops making forward progress. 

Patch 2 scopes rte_flow rules to the ingress port they were created on.
Chelsio filters are programmed in adapter-wide tables, and the PMD
already supports the iport field in the hardware filter spec. However,
the flow parser never fills it for normal per-port rules, so a rule
created on one port can also match traffic arriving on sibling ports of
the same adapter. 

Both issues reproduce with stock testpmd on T62100-LP-CR. The per-patch
commit messages include the details and reproducers. 

Abdulrahman Alshawi (2):
net/cxgbe: fix Rx handling for packed responses
net/cxgbe: restrict rte_flow rules to ingress port 

.mailmap | 1 +
drivers/net/cxgbe/base/adapter.h | 1 +
drivers/net/cxgbe/cxgbe_flow.c | 19 +++++
drivers/net/cxgbe/sge.c | 122 ++++++++++++++++++++++++-------
4 files changed, 118 insertions(+), 25 deletions(-) 

--
2.39.5   
 

--=_a124a1c2-25d8-4372-b55d-bdbcd1d837d3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body><div style="font-size: 11pt; font-family: arial, helvetica, sans-serif; direction: null; color: #000000;" data-attr="forced_root_block_attrs">
<div>
<div data-attr="forced_root_block_attrs">
<p>This series fixes two correctness issues in the cxgbe PMD that can cause<br>traffic loss on Chelsio T6 adapters, especially when rte_flow QUEUE<br>rules concentrate ingress on a small set of RX queues.</p>
<p>Patch 1 fixes packed Rx response handling. The current PMD assumes every<br>response descriptor starts a new Free List buffer by requiring<br>F_RSPD_NEWBUF on each response. That assumption does not always hold for<br>packed ingress responses. Under sustained small-packet traffic to a<br>single ingress queue, the FL/IQ state goes out of sync and the affected<br>Rx path stops making forward progress.</p>
<p>Patch 2 scopes rte_flow rules to the ingress port they were created on.<br>Chelsio filters are programmed in adapter-wide tables, and the PMD<br>already supports the iport field in the hardware filter spec. However,<br>the flow parser never fills it for normal per-port rules, so a rule<br>created on one port can also match traffic arriving on sibling ports of<br>the same adapter.</p>
<p>Both issues reproduce with stock testpmd on T62100-LP-CR. The per-patch<br>commit messages include the details and reproducers.</p>
<p>Abdulrahman Alshawi (2):<br>net/cxgbe: fix Rx handling for packed responses<br>net/cxgbe: restrict rte_flow rules to ingress port</p>
<p>.mailmap | 1 +<br>drivers/net/cxgbe/base/adapter.h | 1 +<br>drivers/net/cxgbe/cxgbe_flow.c | 19 +++++<br>drivers/net/cxgbe/sge.c | 122 ++++++++++++++++++++++++-------<br>4 files changed, 118 insertions(+), 25 deletions(-)</p>
<p>--<br>2.39.5</p>
</div>
</div>
<div id="signature-content-no-signature" data-marker="__SIG_PRE__"></div>
</div></body></html>
--=_a124a1c2-25d8-4372-b55d-bdbcd1d837d3--

