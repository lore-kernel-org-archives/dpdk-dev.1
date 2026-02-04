Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43982EA7946
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 20:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21791402E1;
	Wed,  4 Feb 2026 21:34:14 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 007D6402AA
 for <dev@dpdk.org>; Wed,  4 Feb 2026 21:34:12 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 747FDEC0329;
 Wed,  4 Feb 2026 15:34:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 04 Feb 2026 15:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770237252;
 x=1770323652; bh=EBgNq0PKCL5YKJOwRYGLoPpdpwfz32YmPug75AHLpBo=; b=
 DkV+drHCz2uvSTBy93cbyITDV+GDjP7z3FtJ71g6tjlB2hjmzO0+rw/q8IOmzE7e
 eJFPARVUcJZ2WikKmkG+lV2pi7zdmtvbNQkANFgmihz/ZQZMu/LAVxBM+w1ExAw4
 EBUpQNEWaLi126fxmhBAhRJt9vGrJU44rKEBgYbr5VH9ihRYX20LFmfFDgEUVDwz
 RaxjBwBkMPE/Jw0i4g7/w6CmUzwoCleV3aMp8BNYlOJF6RVlQPPbnvxucJig5auH
 q1puIY1jWVxsLsX7Hveu5qrJKr4mbt+1GZuG6dVMB7YXlp1d0Kxgr9nwty/kqaC9
 Ywcl+P3hvfcytSpJAWgOvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770237252; x=
 1770323652; bh=EBgNq0PKCL5YKJOwRYGLoPpdpwfz32YmPug75AHLpBo=; b=G
 dtbEC3zY+Jgp5xRkcv7b3uCgspwUymr7gokz/PdrwDsgFh9y50RbDEoJJ/BaWRhe
 dDvXsD9dyIGyuRMHbHTXplUSzYw9LgliGdk9Ak2dpUdmQtlHtHayVYQQw/5r/Y6B
 PQP619ZSqB201gD1gmKZNbkQ5oelSlOBMlP0/AhYJD83MYAei4FHUjlMWjMvkt0P
 PLYHgjCHwiTraCfiIE5So5ejrAGSwgufFwzZwMZJwqKB/fEfWC1jRI1G/hxzyBcZ
 sHIfCBSHT46nsNL7knbeG+47cRpKc3B5PR+GaAwb0WaEpoGG6OQHZmDq9f36MWwZ
 YhRWAcUouxXibliDUh3XQ==
X-ME-Sender: <xms:Q62Daee4HNZYuMMMpaQf9Eq0acYddXD5M2RMnEzQVXGpl2RuT7OVxw>
 <xme:Q62DaS4d9OEgQhElcIkCfNbWwkwDfS_7jyW3Moxfnoes6Be3APuNiz4ImzcSc6NTA
 JxgYo4gooLumooW2SKBg58gih-rm2sGu6hFqVj6iG1OVib2PkCwkQ>
X-ME-Received: <xmr:Q62DaWJzT16cxjVKhAx7Tih_MHl1kzIULjnt39LhUda0pWb1nBBchJT3ecfRjcRCHnfIGJIcEKOmFPYEafaukXBg0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefgeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthho
 pehnihgtohhlrghsrdgthhgruhhtrhhusehinhhtvghlrdgtohhmpdhrtghpthhtohepmh
 grthhtihgrshdrrhhonhhnsghlohhmsegvrhhitghsshhonhdrtghomhdprhgtphhtthho
 pehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsg
 gthhgvnhhkohesohhkthgvthhlrggsshdrrhhupdhrtghpthhtohepjhgvrhhinhhjsehm
 rghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprghmihhtphhrrghkrghshhhssehmrghrvh
 gvlhhlrdgtohhmpdhrtghpthhtohepvhhlrgguihhmihhrrdhmvgguvhgvughkihhnsehi
 nhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Q62DaW7I_oC23df4bEgVoMaW9BZLVtCIfC7L0TkhW12N_N5q8I_k6w>
 <xmx:Q62DaVZKlUioGDVQ0Ozsf1JFwwjKRLWE0J-3-H4Zra0z1_xard9TOA>
 <xmx:Q62DadyBvIXotIbzpY8NnrV2Z4cwpcon835iiq2eflwLRQ5J0GGSMw>
 <xmx:Q62DaROydWj7yQ2iexkL7dNkQl2DNm8cFdNI9kKT1FG7j0ZQQrnFug>
 <xmx:RK2DaciquaWJ3vnzUHp6fDSIu03IFcvKMOUqMWpqholw1UesOcALntBe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 15:34:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>,
 Ori Kam <orika@nvidia.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Jerin Jacob <jerinj@marvell.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] lib: remove extra characters ending comment blocks
Date: Wed, 04 Feb 2026 21:34:07 +0100
Message-ID: <5378649.ejJDZkT8p0@thomas>
In-Reply-To: <20260129121414.6aa40db0@phoenix.local>
References: <20260129144749.3637111-1-thomas@monjalon.net>
 <20260129121414.6aa40db0@phoenix.local>
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

29/01/2026 21:14, Stephen Hemminger:
> On Thu, 29 Jan 2026 15:47:48 +0100
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > At the end of a comment, no need for an extra line.
> > 
> > This pattern was fixed with the following command:
> > git ls lib | xargs sed -i '/^ *\* *$/{N;/ *\*\/ *$/D;}'
> > 
> > A comment should always be terminated with */
> > 
> > Extra asterisks were found with this command:
> > git grep '\* *\*/' lib
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied.


