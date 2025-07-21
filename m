Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA6FC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 16:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D31E40648;
	Mon, 21 Jul 2025 18:25:42 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 34B81402DC
 for <dev@dpdk.org>; Mon, 21 Jul 2025 18:25:41 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id A8674EC0245;
 Mon, 21 Jul 2025 12:25:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 21 Jul 2025 12:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753115140;
 x=1753201540; bh=O9FFrJgbutMe1LLasc0Tw2JTdzGJpJ0KKeNtGMihNZg=; b=
 KB5y4KD2rKz0/MAlSZ9ij701oqWhGok8g/9BEhFyD+hoZgfr8JZv2bvETjtBHoqC
 p12PB/3Gf4rDMR2LjUlCV/4w+B6JhHPj/OVjnwF7FA+DObvaigP6mi0b9YW+XK2Z
 H2w0qbsXkknKvQO/GFfdq0/4g90gzYcJCpornjbRmIpJ2aZsPvE0yEx26TIAJDKw
 g/5JIl3dV8zZ1U1+bCFX1iDRCKuOwMqFTqp7/RTC95WZpUcA4pBSzFW5kevuIgkt
 SIdv0030/2O+RY/+ZijVpbgT+yoHGcvFLSfv/wXVjZC1yDv9RZoiYfKNiLaD1lMM
 FKHQXZa67aEfKoIsJ4mCkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753115140; x=
 1753201540; bh=O9FFrJgbutMe1LLasc0Tw2JTdzGJpJ0KKeNtGMihNZg=; b=A
 zlvcwgsmCtCekcij569nn2vTvwMZMMoLykvV76OI8V10f0y/HqMjgDTjkMr0PBcu
 346DEdFpkJzCZ6D9bwfEkyrzJz7fCpgAS7b9MniDS1EiUnRNZKgx7Li7IIcxmUaB
 Vh/pGWueXpnuTxUnk3jGBW/T8sjuL3s/73IyLPBXtOf/6F1Qni9odb1UuY0aLOFf
 316Q5CoYjsIhIkYXu2Z5QolyVSlZ4OHpHyrqLHdfRQZ6w0w7HEi63O81zhzja/WT
 wq44+LFOiHJhDc33Hd7q0jHR9wFX2+Ity4DauO6zEr+CSQ4Ob7HkK23ZeI/jtPxy
 D6s+VK2B6BFfcdITgivfA==
X-ME-Sender: <xms:BGp-aFeE5i_gxleQlp4xTv2hbvgNwdgkKl3fo1FxNjxw4GZSMnitCQ>
 <xme:BGp-aOGME2AllMx734CrdBbjUCZBDxUKECtoH_6MOCFjvLbBkimG4byRYsGVFIwTb
 5L57weDSojMvD87RA>
X-ME-Received: <xmr:BGp-aGXif9nGllIGUTSwDbe8UxSHUpTj2IM1BE4YX-dTXGDQImP5AWyh_n-R8KzWmcSxAMWy4rTinWGB1DJrsBkdBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgf
 dtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehp
 rhgrvhhinhdrphgrthhhrghkrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgt
 ohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtoh
 hm
X-ME-Proxy: <xmx:BGp-aNIw4DkT2IgQ50bIpZgr4QfW-jkDo7Vle_oeKVAPX-tUn0G6Vg>
 <xmx:BGp-aG-DCQffsJwtMcNJUyc7X-nwaDyfEvgbJfUAGb6Z_oscFSv4gA>
 <xmx:BGp-aALmt6Qo8k31jEST35Wn-V18TeKJhrfIDbPuchkOUNAfS6QeXA>
 <xmx:BGp-aLkIYW_m4PUVL20l_hlJn_91mi_VHlEK4AGGDr9wMiyX6XVwsw>
 <xmx:BGp-aLGcSS6K3iL_EmRQXarACu5kv0W3vJOKX3n5KpmQ9woOfar4thrT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 12:25:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin Pathak <pravin.pathak.dev@gmail.com>
Cc: dev@dpdk.org, jerinj@marvell.com, bruce.richardson@intel.com
Subject: Re: [PATCH v3] mailmap: add new email to DPDK
Date: Mon, 21 Jul 2025 18:25:37 +0200
Message-ID: <2047215.8hb0ThOEGa@thomas>
In-Reply-To: <20250719151750.48539-1-pravin.pathak.dev@gmail.com>
References: <20250714191141.1243467-1-pravin.pathak@intel.com>
 <20250719151750.48539-1-pravin.pathak.dev@gmail.com>
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

19/07/2025 17:17, Pravin Pathak:
> Adding new mail for DPDK contribution
> 
> Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
> ---
> -Pravin Pathak <pravin.pathak@intel.com>
> +Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>

Applied, thanks.


