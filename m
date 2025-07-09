Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F7C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 18:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A836040A87;
	Wed,  9 Jul 2025 20:18:52 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 8211540A7D
 for <dev@dpdk.org>; Wed,  9 Jul 2025 20:18:51 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 076E41400339;
 Wed,  9 Jul 2025 14:18:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 14:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752085131;
 x=1752171531; bh=kTlQmRdZBAypvEiN+kif3kRGlOmaWY/atiTu/5pFvz8=; b=
 Ghd+2Ckn63keiBDRqa014RpfUCjCjNmbBJakhFcyAp8S4FhhqsqOgE3Gac279bwX
 dE0Qx72j9kvjJIko3GMXGkcS+3DomujRc1BHJWOdIhHw/FNPgLOeIJx2p7IE1ZgE
 C/l4W0669zRFghaFR+vVMaTdvEwyWNhnmAtMWFCfvdK0ECnVcSrHm9gP4BfHdQ33
 7ZQr4uKV4nbK0CasS/99mRdMWioTEwcsdfoLmkuJsZdW+RlUlSdWOeJNQTzPRZKh
 Jr5oB+RSSZPJsQYtpFCwuYtvCwztCInlyH+Ln9llh1pykdurKbc6vDdI572sBS7N
 H+fp/zsliTfk9KKZC9hF5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752085131; x=
 1752171531; bh=kTlQmRdZBAypvEiN+kif3kRGlOmaWY/atiTu/5pFvz8=; b=k
 94gV8HlykqLEvmJ/VH7j5ihtn+2IV0hn9h5BnCxmMPRk3iDHVk7woYJ92HZRpYRx
 /vEjr/mgWA71V04Ga5u4I6eHfbpeqk0w+3//2vwU1yO0PVE5L8GwvL9EawOVfnEj
 Ep7UKJGMtfYXN7pcDkpZJpAE7w0sC/48fGlanJLnXISzF4jb/BkEwvA14XGXKd3a
 4rWuRC2cd4G6mzlYB8VrQvxBmu0LegwXHnxZgev9nOTd8xLnZnYI6/JRpw+JrNJk
 wRupdoiLEs/PDxP8FxcVroSfZA1u44q3AsjQwaYeBDWpwjG3n80nZaCcJgR4LWDF
 6aHYVa+cbtp414UpSK5dA==
X-ME-Sender: <xms:irJuaL0Vuck4jbje_ASm9Ah9KHpEk2gnAp1zdTtaTn66Yqfm67dMaw>
 <xme:irJuaDvCJvkC7uM7zleWPBt-7-ECfN307aECIkpcu8SWTPYZhUhZWYnyC-hYmMIV0
 3chEZT6AKzcEP4E-g>
X-ME-Received: <xmr:irJuaL6sN9I2Qd-DogIHKOfEN-ue-mMYAX2ys72AboLc47cLDaYy8grJGPxJKS215xuip31oHgQJqLNydBbBYMmyHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehorhhikhgr
 sehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:irJuaEJJjb5lC5OS_e6VwKqv_N-aFyQveX-Fty2iA5-uOoq-RA-_xw>
 <xmx:irJuaL4AnL_O8oTNrtyjQMwZCPdr78EzMjHI74v12eh935IDMRaSTw>
 <xmx:irJuaHyAoJst4ZwrAFhr9IvsaZpR9iRK7vFcQD7_KhOsLol8aqD_oQ>
 <xmx:irJuaPadp3u8wYWG3AnN4Df5nS2DxRJzq7xbhBlcYZ-JMXmwfT40dQ>
 <xmx:irJuaN0DqckhViDTjbMXSOy6tXimJTOpXEaZ967LHOjkaNj9-vuPexTU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 14:18:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH] examples/flow_filtering: add re-route to kernel snippet
Date: Wed, 09 Jul 2025 20:18:48 +0200
Message-ID: <20434052.MNNF8PUAaN@thomas>
In-Reply-To: <20250521072736.141817-1-shperetz@nvidia.com>
References: <20250521072736.141817-1-shperetz@nvidia.com>
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

21/05/2025 09:27, Shani Peretz:
> The snippet enables direct packet re-routing to kernel by using
> the new RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL action.
> 
> Added support for snippet-specific configurations:
>   * port configuration: set promiscuous mode / flow isolation mode
>   * Flow configuration: Setup beyond basic ingress flows
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Applied, thanks.



