Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D02FC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 13:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5452C41104;
	Thu, 12 Jun 2025 15:54:15 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id A73E840ED4
 for <dev@dpdk.org>; Thu, 12 Jun 2025 15:54:14 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2B00A25401FB;
 Thu, 12 Jun 2025 09:54:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 09:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749736454;
 x=1749822854; bh=Ree0GEPKkoOYppE0kgxCp4n9m4aPt1rvIEmrkwTcn7o=; b=
 J2eVoAYKSukrL4Lpji6m1UuSNa9y0Awxcrb8JpNuV+59n8zRr1C3819l/ui6iVfg
 mh63Qum3W974E46CVTUQhijoanl/pEL5K9t+GQUdGxJz2VyK06XvZZcEwhndAH3C
 w5xCT+DLOcS+Q4Me7H9fhKiWnUp2k4Rh9WbwpkAYKU3AvJdRM5Y9MQT/KJl3iAbi
 T6EtXqFrPh6qwx0veEZLJTRG78xareUs6JDdCEe1GsbkX4OXx4iTc0Sc/8nXaf4b
 FeWi9uyV2h7AIyb9unMF1FpJhLxB5TzcHefh77vaVZOpkSHUqhCVGazXvA1RVE27
 aZmL4ctDLSMbl1lMi7u0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1749736454; x=1749822854; bh=R
 ee0GEPKkoOYppE0kgxCp4n9m4aPt1rvIEmrkwTcn7o=; b=htYOf6qt1cqBtR7UL
 vBGQlYT07pgKx2KlA8JgJWdZxESCPMnUryzdaG6D8jwLJuKWBtkEztqWoY15rxwv
 DZVFw/TLCWA5La6P6JC6gp7V7x7HIL3SqRyZgVHOc4umGNW9m7ijrhHUl2wq2FJO
 YqHugO0doKs5pG6+k8bssJEW5eOcbrm9b4TxKEKF2tqZcY5uSwoXGNWT0DaftBDZ
 ahcX2tZkoANZUSQUy7I/Hl1OrRtDyGI5fDVezUKENPxYlJDgO+afjopuCRnJDNRD
 Q1PXXK1cbdgSp4DYF/WqPSfm2EyqduyUIpZWxDGGzQzkSlKcpa9QsIODJF4EGd1L
 YBTzw==
X-ME-Sender: <xms:BdxKaB2ShOnj3ik8KCBAjPuHzeR0Fm41qYVKpYRTEfPCkbABq8eBww>
 <xme:BdxKaIFgaqnOezpDzV8hSVeleQeQDrtyVrMDerYo9RVXqZXJGnysZclpvYOeQoZ0H
 Lki2lV8S8mwb3eVDg>
X-ME-Received: <xmr:BdxKaB5VS4HtXCgrAppAOUiIE2CwDzeqLNIBSHdYMh28og3mCYCmhM07UV5bIwgkUL0ArCo4wsA0tG1vzkEDRjA35Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduhedvgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
 ffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghl
 ohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epledvhefhudduudefhfffhfetfefgjeethefhteefudekvdefgfeludegtedvtdegnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrg
 hssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:BdxKaO2dF3wpAAvRUFraGraB5cqbeEc0G1TpJwqiSmtJqwJ0N_qh8w>
 <xmx:BdxKaEHwsGY8WN7KD7Cl078Ti7GXgXm1B3jNBVKcPWFCxJzzTwGEKw>
 <xmx:BdxKaP9NAww-x94YMjwmvf1xczLUqLXNrVY8n_rVXpLULkRF78x3lA>
 <xmx:BdxKaBnhLJG06md-pZT9l4c_ww37ZPioRGptikpwxYRzu1dtV452SA>
 <xmx:BtxKaP0MoeUc2gZ5RvXUZMH0WYDljWdcFAMPh67Z6g9CHQ8HGESUbi47>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 12 Jun 2025 09:54:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Re: [PATCH] doc: reduce index depth of most guides
Date: Thu, 12 Jun 2025 15:54:10 +0200
Message-ID: <5093420.WAvfycf1tz@thomas>
In-Reply-To: <20250414084531.1759703-1-thomas@monjalon.net>
References: <20250414084531.1759703-1-thomas@monjalon.net>
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

14/04/2025 10:45, Thomas Monjalon:
> The guides having a diverse list of multiple drivers or tools
> are easier to browse with an index limited
> to the first headings (depth 1).
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied



