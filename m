Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E18C369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:24:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52709402E7;
	Wed, 16 Apr 2025 18:24:38 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id AC0614025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:24:36 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E28FF2540264;
 Wed, 16 Apr 2025 12:24:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 16 Apr 2025 12:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1744820675;
 x=1744907075; bh=ZbZ8waHuQEz6o7fYs3q1qmsBOsDKowfpZ6S+oXLVGeE=; b=
 dTt6lOY7AQpnVyIi3PMRA8dU/SSbi7GZ2rmqafbmEcNzhwhX3rizhy4XpDQzdvia
 lP1BO3KsfKUaVewDIHp+GzRUse+4/iNi6QpuS5CQjykNkregsMrlNiD0uVbn47WT
 SEnhuGzeaA0wJtimiUAN2X6G/W1WlzP1a4Ho+jdDUkIWAXUUQ/2bNKcHnmjjJ4sw
 m7eNDTCbNapL+/Fa/Zmh9UgGNUVauai0vibxCTRxJ9+2EB58wnhBQ6aZE86/k8ll
 F01g0Mtv9d/a/WQfMVRAjbYeoTt3HNwCs25iolqDgpUe4oZWFqUBUZ+ksSMQU6is
 ERJn0XbY4D8a889ugaW4Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744820675; x=
 1744907075; bh=ZbZ8waHuQEz6o7fYs3q1qmsBOsDKowfpZ6S+oXLVGeE=; b=O
 UbLb/DyVcQeaNU80oFh++iIUvyjCnPgsQvdmC1QXouRhg7LpviSSYYbDOQjqx81R
 BzI+5zccnt4hvHsvGZesaxusR6MwwwhQuVFv2q+lU+UUZ+yFS4iAFSJuwe03TM0A
 d6AUEEFlgH7F4JG2bBb04FyZIBrjq1Wmqhm1wOxHg+XLSWq1Bzt5XQYd7CiFLh65
 kKelkx7p5lw+WxPak1tR/VUpuQ1HnqlGBFKJqoZfTWWMDDXJqfeIWPj+H6fdJAI8
 2WyfVcH/JWAuHG2yAPDp643jjkYLdWXb5F6P1ikkLfXwtTvVrZe8wQl1TnybNKq5
 OZZKt2K3fwN6h87y4szOA==
X-ME-Sender: <xms:w9n_Zx3bFUj99LymVhh5zV-NkEH7SoD6s3llHQw1AjNMCv_iVv4G-w>
 <xme:w9n_Z4F13MC2JggS9rdkm7aL4_8lQsWopGRjFB-NuTF5i4STfx8euGfLltVAfldkO
 m-sa2RNifaTsDTSJg>
X-ME-Received: <xmr:w9n_Zx5GvFcd2psha-Tc6L59pb1COyst05X1fFcbZKqYjqfKP_z_1NaCaCpC_xEF1OJFZfaObv02XU8gEHUFYsLlVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeikeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegumh
 grrhigsehiohhlrdhunhhhrdgvughupdhrtghpthhtohepohhrihhkrgesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghjihht
 rdhkhhgrphgrrhguvgessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:w9n_Z-06tG7yiUpnbG80EAXbs-B6Gp1r2uAxbrqaFgSdx7D1h8CseQ>
 <xmx:w9n_Z0HJbSQ5-NEjkY2OMqYmdGp4gBZmFWzy9C5ATLztzuaXVUmTKg>
 <xmx:w9n_Z_-yYYzU2Y-jJQma42TpYoOA-OqwNXD8axxQ-qlBsvqZFWyxmA>
 <xmx:w9n_ZxniGyTv4hoXutPCOrJeI921l_jqH9Mex2CFwzPJwzWDUi_V3Q>
 <xmx:w9n_Z6t69H6hmnDlyglTyy9YTJrX4Q7eGEPS63_BJ8wz5c8Ug3NMAtzG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 12:24:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dean Marx <dmarx@iol.unh.edu>
Cc: orika@nvidia.com, dev <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>, ajit.khaparde@broadcom.com
Subject: Re: Flow API Test Suite Inquiry
Date: Wed, 16 Apr 2025 18:24:32 +0200
Message-ID: <5050697.TLnPLrj5Ze@thomas>
In-Reply-To: <CABD7UXNy9yymZ0+4SfHJ9tcA9ibg1rfph8Ee1tkgPxsbJwtaGw@mail.gmail.com>
References: <CABD7UXNy9yymZ0+4SfHJ9tcA9ibg1rfph8Ee1tkgPxsbJwtaGw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Hi,

15/04/2025 20:21, Dean Marx:
> The flow API allows for an extremely broad set of rules to be created.
> My understanding from my first pass at writing the test suite is that
> there is a small subset of those rules that are =E2=80=9Ccore functionali=
ty=E2=80=9D
> that the flow API aims to support, and there are also rules which
> technically can be created, but may not be supported by the main PMDs
> and/or may not be useful rules that people want to see tested.
>=20
> For instance, I am pretty confident that a rule like the one below is
> one which the community will care about, and which PMDs will support:
>=20
> flow create 0 ingress pattern eth / ipv4 src is 192.168.0.1 / end
> actions drop / end
>=20
> But I do not know what is the full set of rules that I should be
> validating from a DTS testsuite. Is it possible for you (or anyone
> else on this mailing list) to provide some feedback on what rules are
> most important and I should include in my test suite? If I can get
> that feedback, I will draft a test plan and share it back on this
> thread for community approval before I write up and submit the DTS
> patch.

Ultimately it would be nice to test all flow items and actions.
As this is the first step of this long journey,
I agree we should focus on the minimum.

We can focus on the simple synchronous API for now,
and leave the template asynchronous API for a next step.

Let's talk about basic items and actions to test
simple forwarding rules.

Items are describing protocols.
The most common ones are:
	- RTE_FLOW_ITEM_TYPE_ETH
	- RTE_FLOW_ITEM_TYPE_IPV4 / RTE_FLOW_ITEM_TYPE_IPV6
	- RTE_FLOW_ITEM_TYPE_UDP
	- RTE_FLOW_ITEM_TYPE_TCP
	- RTE_FLOW_ITEM_TYPE_VLAN
Some header field values may be specified as well in the rule.
You probably want to test matching each field of these items,
except checksums, lengths, offsets.
The traffic direction can be specified with:
	- rte_flow_attr.ingress
	- rte_flow_attr.egress

The most basic actions are to specify where to forward a flow:
	- RTE_FLOW_ACTION_TYPE_QUEUE
	- RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT
	- RTE_FLOW_ACTION_TYPE_RSS
	- RTE_FLOW_ACTION_TYPE_DROP

Next we want to create flow rules in groups:
	- rte_flow_attr.group
	- rte_flow_attr.priority
and connect groups with
	- RTE_FLOW_ACTION_TYPE_JUMP

The most versatile action is to modify packets (like TTL or src/dest) with
	- RTE_FLOW_ACTION_TYPE_MODIFY_FIELD

I believe you should play with that first.
Any other opinions?


