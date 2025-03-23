Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887A0C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 17:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0E4340277;
	Sun, 23 Mar 2025 18:15:10 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id A084140150
 for <dev@dpdk.org>; Sun, 23 Mar 2025 18:15:08 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C475E25400D9;
 Sun, 23 Mar 2025 13:15:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 23 Mar 2025 13:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742750107;
 x=1742836507; bh=HswEEFD5Wa/e00/aZZ9WKEqPLH1bqKdjA9Etf+CVZkY=; b=
 C0+wyjPoGR1Q2M5KitGyxHPiBuGphmBcVbRQ5DRkTd29LY0vLOBVvmQzI9kQasE7
 z0owVAk1UwPRWXYfVlMej4dP8qFfyKotsRCcpPbVWQAqWNwkFdDbfrwDF5fhLnvT
 WOs8gnjae/S4Qd4uEzRm8JAGViklzpRVZ41HEdnTASxRtk6Sf8KF0bZ3Om3uh06i
 sC0Gtm4xkjuDN+9YYT7AjM17OWcJfoAr9+Lhyxk4YaV5eKE6aXw4QhxsOXCtIVWP
 Rm5Dxrf72oqP7ATkjafhEJlFc6ak5aSp9Pvu8eZ45v26iHOxPgfh81vVLMcBcmwr
 ow6chMTqUQoNISmEkgyHIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742750107; x=
 1742836507; bh=HswEEFD5Wa/e00/aZZ9WKEqPLH1bqKdjA9Etf+CVZkY=; b=p
 5WUHVZrfamNKePDTTozczJOkR83Uxw8XhVM547hG4d85RZayfa3wha1BPKuDg8ks
 QAH7z3e7pPPIlDAdpfFtqOyn6U3RQnByFqyYORO+D6Lz/J0ThzuYQYN2ozg5zi5E
 gG8xafujPpm4jUoW3UZrDFa0yQRrjAWLQAe1iLAk1/gG717c0yY6cR0AsnZje7Ip
 0u3JGep2SE+DhEKor2eGrkmB6nTYw3YsWMuyb5M8GfPjbNJuaJuBYzvVUMcGK+FT
 S7X6vawNGZDKSJ2bUFGmJq9pF40I+r7UEbgA1fj/0/jj5CqhCiy2Ao3OV75mGEkX
 D/A03dE/iyypKqthrvNwA==
X-ME-Sender: <xms:m0HgZ5mlAX4YBqxt4Y7tYvrSx92vIo9GCYQyjm9CbkLaeBPcJBeftw>
 <xme:m0HgZ00UfcA7qIWo3xI4GRryvflBuM2kJ-gHX1LniFcsvA6IoCvLfk0zi8SgX01fx
 LgSAeIqazyn3VN9XQ>
X-ME-Received: <xmr:m0HgZ_oq28n0qVvh-rbfxcnSFpB7YqgXZeUjDdrCGKb4MRQvSN19NT9hrqRBRDzyhcfvK9X73BLbh1LyfRHHTy95iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihuh
 igrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdho
 rhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtoh
 hmpdhrtghpthhtoheprhgrjhgvshhhrdhtrdhpuhhtthgrshifrghmhiesihhnthgvlhdr
 tghomhdprhgtphhtthhopehjohhhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:m0HgZ5lUSYpmCSdomi9NHVZ_zBNxLAVl3hvbDD-_9_QifQLs4xVTpA>
 <xmx:m0HgZ30_iqp5iCRB7CJn4OCdoKxO3QN6ShtnPD-mJWi0z47IdHv1ug>
 <xmx:m0HgZ4vyCUB8sPbZ2QsPWRZuxjuInbTMWN76MV8E5e9UX8EvR-kkPw>
 <xmx:m0HgZ7W45siw7GqYTo6AeGWmjOXqDWCho6z_gvB5C2F7xlpWToYRXQ>
 <xmx:m0HgZ3_y1P8WyWPBckmXM0_sE0JE8j8ciu5Ni5Cm1dipkKTQXMkxpV85>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 13:15:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Jiang, YuX" <yux.jiang@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>,
 "Mcnamara, John" <john.mcnamara@intel.com>
Subject: Re: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Sun, 23 Mar 2025 18:15:05 +0100
Message-ID: <6870121.ejJDZkT8p0@thomas>
In-Reply-To: <PH8PR11MB68040B66701697332F62778BFCDB2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20250321090340.35913-1-yux.jiang@intel.com>
 <PH8PR11MB68040B66701697332F62778BFCDB2@PH8PR11MB6804.namprd11.prod.outlook.com>
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

21/03/2025 10:20, Mcnamara, John:
> > Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
> > 
> > Add tested Intel platforms with Intel NICs to v25.03 release note.
> 
> Acked-by: John McNamara <john.mcnamara@intel.com>

Applied, thanks.



