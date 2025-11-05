Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E3ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E811F40A76;
	Wed,  5 Nov 2025 16:22:17 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id E24F84021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:22:16 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 60C45140017D;
 Wed,  5 Nov 2025 10:22:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 05 Nov 2025 10:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762356136;
 x=1762442536; bh=AwIHANTB4IoXQ1UCUe7fWhpKnN03JGkWXcMsjQQDHzg=; b=
 vSbYxXpfl2++JRUuapgFUJb9MwP1bVcHcFXPCKr6hPbL99N+5yXGHOvwhQQuGWXt
 XCkjd79J0xA+P7jK1SzyVWWFjgsFjMiJ1jP2tu0bughRSVzzUSVCu8FRaa/Gf+0r
 7O6vNVw7xReO5n6Uqvk0Ied2oduTSFWBqbwhOZa63N/wfHmy63nlo4YMNMjGjFbO
 fG/Mjk5RCF8XsqmMOxw4D+ovyqsLNPt1+TEXahtn9phFKnn7Xf4q0rxBzuKf3fjX
 nSB4Y8d8vPjzFs1Ug31VT2FsShzLWKw0kIxhQkCRmdNecqUyc1YB0Jo1+MB97a+i
 JxXVjMFVVkNuwq4X4QYz9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762356136; x=
 1762442536; bh=AwIHANTB4IoXQ1UCUe7fWhpKnN03JGkWXcMsjQQDHzg=; b=B
 Jcq69Fb0TwtZ2Hzus3tNYiRmQhLnOYnhgFJxXyyfOvnYiAv0DLt8Tk4rmp+9cLr/
 iZ3NXLT0YRO47OiwmgM5qzwpBMj9eqTNLKxRl/JptvOMpCXkAw7DnrHL+EEv3jhR
 vyRhfynsQ8iPZWz9r7wBTmorsQ0CD7yxMWXrBfnLOCOAk3onCYYYQnVDNcuroRd8
 dI2v8tJOmLVcgIlMzaeqv/jslRhL2e1m36oEW07H5WyQK/K5uXuvANwQjZ6QKFPi
 xXP3/YAKedVxJN3OcSIGGDBdlL2cbqpAhbbtYEgDWls17+JxtfbzEcg4fogZhtKO
 3OUGDmqM/l/PZjb/+/eQQ==
X-ME-Sender: <xms:p2sLaXjLntKlG2GtC9l_Vek2mx8g9ZK9Jq2XSw7KdjC7_PdmMRdGww>
 <xme:p2sLafe_oEkVEke5vVc24rpp3vAk0mhA9I5prEiRGlgAnywKb8Z_N6kJVubyUhjLQ
 A9ie_KcE6Idg9IhmZeMMDz3hn0sjeP9rhCNESSmqhhEjIk8Qzuo6Eg>
X-ME-Received: <xmr:p2sLaam5iHep-AfbJ0C9vcjz8OK2VKDWkM9MFAQFDkG5Ux6gIUWE064oH5DmMFfNhJO8PdsL1UNW-YIBCjtKVTamZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegvdehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrrdhstghhohhllhhmvgihvghrsehshi
 hsvghlvghvvghnrdguvgdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehmihgthhgrvghlrdhrohhsshgsvghrghesthhuqdhilhhmvghnrghurdguvgdprh
 gtphhtthhopegvrhgviihfsehnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhn
 ohifshhkihesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:p2sLaYvJ_Yw1Di2_9TMm8wg04mmJjqjOj2RSfv1k_UQDnw-t1Yfqjg>
 <xmx:p2sLaQ9FWAQHq7GVHPGgydyxk4igr1OMmyHVxewKjanwtX51ztt0xg>
 <xmx:p2sLaaMLFln5v3PubDJkuo0yY83hbfh_YCcNWTPm_HXePk4Dy1WnkQ>
 <xmx:p2sLaWEjMQaBtNIRYqJByDVbsm7mm0QNSE6VJRtwb1jRWyR4p4wDRw>
 <xmx:qGsLaWj9vfDqZ7ozHfzwxbtu_dnZm9hhFuY7RaJEqhTFZEOftd2omoec>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 10:22:14 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Cc: dev@dpdk.org, Michael Rossberg <michael.rossberg@tu-ilmenau.de>,
 Erez Ferber <erezf@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH] net/mlx5: store rxq MTU at allocation time
Date: Wed, 05 Nov 2025 16:22:13 +0100
Message-ID: <2962335.1SvkZsmPdQ@thomas>
In-Reply-To: <20251028095240.35281-1-a.schollmeyer@syseleven.de>
References: <20251028095240.35281-1-a.schollmeyer@syseleven.de>
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

Hello,

I don't find this patch in patchwork.
Please could you try sending it again?
Please use --cc-cmd devtools/get-maintainer.sh
to make sure the maintainers are in Cc.

Thanks


28/10/2025 10:52, a.schollmeyer@syseleven.de:
> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> For shared Rx queues, equal MTU for all ports sharing queues is enforced
> using mlx5_shared_rxq_match() to make sure, the memory allocated in the
> Rx buffer is large enough. The check uses the MTU as reported by the
> ports' private dev_data structs, which contain the MTU currently set for
> the device. In case one port's MTU is altered after Rx queues are
> allocated and then a second port joins the shared Rx queue with the old,
> yet correct MTU, the check fails despite the fact that the Rx buffer
> size is correct for both ports.
> 
> This patch adds a new entry to the Rx queue control structure that
> captures the MTU at the time the Rx buffer was allocated, since this is
> the relevant information that needs to be checked when a port joins a
> shared Rx queue.
> 
> Fixes: 09c2555303be




