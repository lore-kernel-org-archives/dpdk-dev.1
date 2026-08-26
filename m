Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC185C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 14:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE6CF40268;
	Wed, 26 Aug 2026 16:46:58 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id C78C040264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:46:56 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0C48C7A010F;
 Wed, 26 Aug 2026 10:46:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 26 Aug 2026 10:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1787755615;
 x=1787842015; bh=JqvAcjQTBRwq+ErAFIiAx6mP+ejcEOvrKd3qcfy6/9k=; b=
 bcetupPVvsJVcvCeCcPc5uqNT2MaTnJMBWcsg0DDMCu43PJNO+/qHeNnBIOtRB7D
 SQWJAwCqipC5iQu6VMdz/AxQIEylnSZ4uT/PWT4vD+gWwhOHqRpuGuBGw0yPp2GJ
 9+c4zWyoPZtlROW0J7Fk4AuI4xEVB9Ec6757ghWQ2WCwMJPOJHMDOgIdXHiac34Q
 SN511wDCzqcKzEMhSYXyHfVVSQn80R684o8R4nwq7JArPRoyDy4Vy1oLMVM/VSdy
 8lXtnOJ8innzdMk+ukgBxd85cvHPsMNXymSlbna3tjrMtI+Lj/d8dBLnzYBOCK9w
 JpJqIe83ronS+Xx3m1CHUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787755615; x=
 1787842015; bh=JqvAcjQTBRwq+ErAFIiAx6mP+ejcEOvrKd3qcfy6/9k=; b=Q
 Q/numEfb7KN/OvVfN8fxS3zAp5IuUh1DIWm8qMLgQB+JU4KrKCxD86TcVakb6oN4
 CMPG9MlEG6GXHMlAo7/HDT7BSpP/5vj06Bfhw3gy3xlmUzBbjXT5Lata3aGi/vBR
 gzEUC1gsJLjB/bKJF3KijYKyDSVFlNF9nXb76aMt/X/K14DcwZPmw2pBlcFKYoJ0
 qHQRWagowNk1wvLsnL+09UXIpqgNu3PpZ+7+UMhqDY+P0YbUwm/xDqef3cYhcRyU
 SCSZ/YjbxgsaoYeA+0PgK+amAuNsL861WbLdbJB4U5mLXD7m7RqYLPYkTtbj0Bai
 2nwFj4fN+mmPmbXsUfG7g==
X-ME-Sender: <xms:X_yOaoL1TQoly_bBkdWH6bqW0lyt9Tb09b5N6t0h7pJRMfgnehHQiA>
 <xme:X_yOaoTVLYi_HxUVM1Pz2Jq2eyi0FkNKGMuge6vSAFAfACjX3MPZ1LTnMDUZUhONi
 1onLZpmHvmBZNagWzPOjVQsR4nae9d1wXqDvULMd-g1-3fJkzE>
X-ME-Received: <xmr:X_yOagqL2-TJS15DROp5GwoAmAfxw23bkW8Ilv6EIebjrKOv3XasDTB3fucChbJuvxwLmjLAU5M_AmLrEOeMjhKoTw>
X-ME-Proxy-Cause: dmFkZTEwbHtd7WKOjEdv/Wmh0SDB1PjKtS/EgCDTJyW+Voq0+9LBK5pL9Ql13jRlFovoAM
 1wJQYZ+lnvkBINRcx2/OEX1zmAXGgzGu+9imYt4lZvBE1OSayifSJ9G9TKeAcm0Tv+ioVD
 mF1qNObsg3LAQ4TT9tLKPpvmF5WgUu3OzFOkPkr0A/2PXWkA5ibXt54/KhrE0KbiDKpd8l
 JvoG+VYr0V5JG7gEoxns402NBt4bN/YuTel/K4Nt16LIx0upMolnS7y7ywVHsR3O5WKnrQ
 EavItg7ftvvTJFqS/Om3Ira699fJY272KDpsSE7sXB/afcwhDGZ2KbSF9J5UiHVNliTvCK
 ljb5MQzisLyi8qdHyer/evF22GrRSnf36x+h3c032DmZdD8ixgNUfsJ4+Hkirct6EQuFZg
 ur6LxpaBe/U/emv35Y2M5p02QsVcj/uMtCPHIRG0cJMOGPteBgOa6mYEG7aFzZcOjOFW3e
 IKHywaUYE8PUCyjjZS4Ixr236vOl03t9O/ecZwfEp8xahI8JHQZfd+GTA+kxp02W3Qc6Wk
 mpGTdIothakVhrI+zzyEqfpfAc45sLtaURqNJ1qYeWYOTOpWyIbMZ9shNgcaQyb3cgOX7h
 NLAHEcmyD65F7+JRgA0tOnISVqfTzWnHmQgjuegh9CMWNf3tXYm5gDoE3oEA
X-ME-Proxy: <xmx:X_yOatrvy-zzgU3Kjpx_zEsNNIESYnGSnQF4jN5UNuE8Ize2PIRbhA>
 <xmx:X_yOaqMJNaNPFHRKpwht8LlyEm53h5X4AdxAIvn00TbYtGhGtnW_Ww>
 <xmx:X_yOamyaoTmjPM4YvcXeCy3BPzgmS2fbaCJ9cnZq9DnwEozkgoe2hw>
 <xmx:X_yOarv9XGsfDlC_406FoHEuPxfSj3C29-wJB3ULNzmFr-PBAx3GFw>
 <xmx:X_yOahkHE-1_8-Z-U0SXv43e8Vg7k8KKABjJlkwimmQePFVLe_MNsJkh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 10:46:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
Date: Wed, 26 Aug 2026 16:46:53 +0200
Message-ID: <IR-o-Ca4RH6Rr1n8j2NshA@monjalon.net>
In-Reply-To: <64e2bbcc-b77e-4b2c-9997-c99553486d0a@intel.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
 <64e2bbcc-b77e-4b2c-9997-c99553486d0a@intel.com>
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

26/08/2026 12:20, Burakov, Anatoly:
> On 8/26/2026 11:21 AM, Thomas Monjalon wrote:
> > 26/08/2026 10:58, Burakov, Anatoly:
> >> On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
> >>> 20/08/2026 16:00, Anatoly Burakov:
> >>>> This commit adds a flow graph parsing API. This is a helper API intended to
> >>>> help ethdev drivers implement rte_flow parsers, as common usages map to
> >>>> graph traversal problem very well.
> >>>>
> >>>> Features provided by the API:
> >>>> - Flow graph, edge, and node definitions
> >>>> - Graph traversal logic
> >>>> - Declarative validation against common flow item types
> >>>> - Per-node validation and state processing callbacks
> >>> [...]
> >>>>    lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
> >>>
> >>> Are we sure about the name? Why not "parsing" instead of "graph"?
> >>>
> >>
> >> Because it is intended to help build *protocol graphs*, not *generic
> >> flow parsing*. I.e. only things that lend themselves to be represented
> >> by a graph would work with this - things like conntrack wouldn't. So, I
> >> feel like "graph" is a more accurate name for this, because this is only
> >> for enabling the protocol graph walk, not for full flow parsing.
> > 
> > OK
> > 
> >>> Is it only for drivers? In this case, no need to make it a public API.
> >>
> >> Yes, it is for drivers. It is not a public API, it is not installed into
> >> public headers. If there is anything I forgot to do to remove it from
> >> being public, please let me know.
> > 
> > You should not use the rte_ prefix for files which are not public.
> > I know this convention is not well followed for historical reason,
> > like rte_flow_driver.h should be flow_driver.h
> > 
> > 
> 
> The fact that it didn't look like there was no convention was why I 
> picked rte_ prefix. I'll happily use a non-rte prefix for these. Maybe 
> use eth_ prefix for both flow_graph and flow_driver? Or does flow_graph 
> work fine?

I don't think adding eth prefix is needed.

> [on a separate note: should rte_vfio follow suit and be renamed? it is 
> no longer a public API following my patchset. renaming it to `vfio` 
> would probably cause conflicts with Linux headers, so maybe something 
> like vfio_driver like flow_driver?]

Yes vfio_driver looks fine.


