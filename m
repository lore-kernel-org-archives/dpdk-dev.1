Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D37FF886F
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 12:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F302A402BC;
	Mon,  4 May 2026 14:46:45 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id E67FD402B2
 for <dev@dpdk.org>; Mon,  4 May 2026 14:46:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 64BD2EC020E;
 Mon,  4 May 2026 08:46:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 08:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1777898803;
 x=1777985203; bh=3Y3UN4BeP4R04p/HItpBJMK/AD1qLyy4nugOPgB+60Q=; b=
 HMgbagRPfjCfZl5luGaOY/TrKfhczP+IeylyKULf+83PYAKSXIqcS7Y6YS6j0AWg
 qvaNA/QrvtNWoieUe9SRASLbll4EfEbxAiBe92QC6wnevDArv4NqXyKDZ2mvkvxP
 it35df3c18QgGo0oDVm3s+GEVP87L7bnaW0xN7/CNZRFc9hwFdbgUJTQjPSVq6SE
 WUMUqhNue821Gy3YFqbkSjy6xEYnApNd64a89uJmBcAhAEmiPRTSe5l7jbdsKXP7
 qcz8U6yRAp1TDaenIDUpFjYSO8e9vcNKTgov0zqyg1+heovLbnn/GMRO8GRudS4G
 Yfq/049L7QrGkBv3WDq/Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777898803; x=
 1777985203; bh=3Y3UN4BeP4R04p/HItpBJMK/AD1qLyy4nugOPgB+60Q=; b=T
 8sCztTur/tAJ5kWnxhMc/PRGcfE8zBo1MGhxi/7WGFKVxpLiUmvsf8MHTKc8fBQT
 UyJKHnFQICDE9cvfOOlHQ8rCtzZv5bwE9TPUZQEB2Bu1xrfFqnUcDT98gPfsmC0y
 BGazClhW9H6K4RtPBpx4nZahGQY/Ya+sx+MZ2yTHk8vw7CO1NboT604gAwx55c2g
 NkifejjKOozpV0u5t13lVVu0Uli2KNwCuDgRqDI2uUYj38U24B+ZqSOWpkqTifjZ
 +sWM+NV9uwejj2iZNVuDlNSwNPVQ3apM2sA5x+pCqvB9/Ze4Pq3MNF71Wd3c2hCx
 BOgojavTij4AQqEx5II/Q==
X-ME-Sender: <xms:M5X4aWSeM8VtqErMkeQSJ8uBfOxzX3p-nJzC_B48tzqfOdQifPzq0g>
 <xme:M5X4aYE1I9XdbcS3BNQHq7EQtzilhwhrqmuO5FO8v5nubNRi154oPuDkvDyVTsZ--
 gt39e4RXeK7V6-o2H79sCk4hpYe7_fCQCNGE2UVacczfFUFivp3>
X-ME-Received: <xmr:M5X4aWm3-qGILUlh2exegZGcSZkWN907lMfie8l717cUr_LgIwrIhIDwdW1akr3lPdnO4AliWdRIjuLwDreWga3M7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeekjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:M5X4aT0N6DMtbEXSV80YOln8n-CT7zTh-_2wtFS8xx1jckcIsR_07Q>
 <xmx:M5X4aSRnN-QnFE9Sx-1tUUZTXDqUodpGFplHo1Yp8iqwpxwxf-Y7-g>
 <xmx:M5X4aVuLS2dgCI-gjDxRgFecQtNUP12PhuKdbR1i4ZmI-IYQJ_9SVQ>
 <xmx:M5X4aXaVCCYtWc40SZwlcb0S4qWQVsX9FkgwwImi2iPx3WfW48SYTQ>
 <xmx:M5X4aURxB0MjREBdXVgXU0K1_vdj5ka3uXkkO31_PG34e-_Znudk-hRl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 08:46:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] spinlock: fix API comments
Date: Mon, 04 May 2026 14:46:41 +0200
Message-ID: <2450366.BjyWNHgNrj@thomas>
In-Reply-To: <20260504091251.2926887-1-thomas@monjalon.net>
References: <6261630.31tnzDBltd@thomas>
 <20260504091251.2926887-1-thomas@monjalon.net>
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

04/05/2026 11:12, Thomas Monjalon:
> This is not a read-write lock.
> 
> The user field stores the thread ID, not the core ID.
> 
> The implementation is architecture-specific in some cases only.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Fixes: ca2e2dab079a ("spinlock: support non-EAL thread")
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org


