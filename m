Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44AFCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 17:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D25B84066E;
	Fri, 12 Sep 2025 19:02:02 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id B78C94065E;
 Fri, 12 Sep 2025 19:02:01 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1DEA41400436;
 Fri, 12 Sep 2025 13:02:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 12 Sep 2025 13:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757696521;
 x=1757782921; bh=OH39lNRrIvfbSl9m8cCAq4dNWjZbz9/6PXv9SeuFnqc=; b=
 fxetwG5p1vSFisMyFWeAiEij5Dhr2DWH+PzSr41WnNUPrUtmmYiBn4RhBAy11NhG
 5P3Jj0zL4lE1lgL9mXHT2mXLFhJ6j+GybzO7m53/hB0NUEOuR4m74tbGKuPEylRG
 Lv5clBUXiuGDS1PJNdLkma6E1H1IfLP9xUiGiEYEAPF6LuJrgco1YpeFd68BQNEe
 RLjoVXn5fDhpD/+5CVmM+A9zcd/+4erHTv4QLTFg2eYHiGwdO47H6pp0YAHTwzxo
 bp3yExgOGQbSuT27/WiHH0qPW58Ljw15imryhHq6gf+x4lyB4nYmcG11o34jh0zP
 IUr9R8NJNndkYdfWzE9RYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757696521; x=
 1757782921; bh=OH39lNRrIvfbSl9m8cCAq4dNWjZbz9/6PXv9SeuFnqc=; b=B
 +F2U5+ezy8fORIXlosZI1Dr0rmfCEJ8Sqj/8DmjkmM7qmWSfsAb68eYb3kP3B2uJ
 zjjH9R+JxeyqrUHMNXaGAmRUJSWU498holA76/NObpYmePJbkE2NKxPBAZ/Iunwl
 zKNLRo1O2IDMIQdpLNXHgqUPqoLqG9X9bhuoJhiwK08FQyTak1YKVj60nARYLVvB
 fQ9s27+yeuqi1QYjsZ0jegZJelR+qKucHvs0mr2v3dzUxf+hh0VsQHXGW4m3WIMf
 wsi5w2zLHqdtk/hQhEXoLnGlkKWKglAMTHjDPA9CrupcfnOv8UDTu5V4uXhy8HrO
 n5BQ7Y2Sn5IXf68ctWNTA==
X-ME-Sender: <xms:CFLEaJ5TIPQujm9aub2iovu7uWbvj1nViNVnaxaSkoSfM3KjI7OkDA>
 <xme:CFLEaMShdp7Ys3uLueJXzSfU0jQdLeSvIOmbhTofFdIM62hsdFxT49nCPTM8PKYmi
 pPYMsWnvTQikZb4PA>
X-ME-Received: <xmr:CFLEaArftUE3r8MLpTOsq3BR2bFyH2pIQW4bD8FdNP_LYU7dqdAhbnD2l5pugS4hMx4Sra35m0zl_kgkWbX5ArYwrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvrhgvmhdrrghkshhusehivdhiqdhshi
 hsthgvmhhsrdgtohhmpdhrtghpthhtoheplhhinhhvihhllhgvsehtuhigughrihhvvghr
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:CFLEaCKGHU2_6qzhiVYOeXV5Xm48LQczbKwCR8R09X4lQs85pBMnrQ>
 <xmx:CFLEaLrSDQU7fAXLRt4VsGByDwzLDOAMMmoECkpPah0NqNJmYCiN2Q>
 <xmx:CFLEaCySw1bOSq5j1GZjg09vAEljNat6-6Cw6JOESrXDG4Vv5O-1IQ>
 <xmx:CFLEaHMeJZP_S8a03DnI7ajmO477zwucuBV9PjLdW8Sl2CRc3h7xmw>
 <xmx:CVLEaCTsiNaJkdQWW2vE8CV0-n8RuJutr_oNpU7tA8iz4rSG544YMH1E>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 13:01:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: linville@tuxdriver.com, dev@dpdk.org, stephen@networkplumber.org,
 stable@dpdk.org
Subject: Re: [PATCH v2] net/af_packet: fix crash in secondary process
Date: Fri, 12 Sep 2025 19:01:58 +0200
Message-ID: <24079784.6Emhk5qWAg@thomas>
In-Reply-To: <20250912113525.396070-1-kerem.aksu@i2i-systems.com>
References: <20250912084758.354208-1-kerem.aksu@i2i-systems.com>
 <20250912113525.396070-1-kerem.aksu@i2i-systems.com>
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

12/09/2025 13:35, Kerem Aksu:
> dumpcap crashes when trying to capture from af_packet devices. This is
> caused by allocating interface name with
> strdup (i.e. malloc). Interface name is not accessible from secondary
> process and causes segmentation fault. Use rte_malloc instead of
> strdup to fix the issue.
> 
> Bugzilla ID: 1786
> Fixes: 1b93c2aa81b4 ("net/af_packet: add interface name to internals")
> Cc: stable@dpdk.org
> 
> Reported-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>

Great, thank you.




