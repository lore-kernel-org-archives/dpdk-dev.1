Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A2FC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 13:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DA6540662;
	Mon, 21 Jul 2025 15:09:46 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 140064014F;
 Mon, 21 Jul 2025 15:09:44 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 9A7C2EC0229;
 Mon, 21 Jul 2025 09:09:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 21 Jul 2025 09:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753103383;
 x=1753189783; bh=/ZxNzaTohGdVchdsostYGh/FWMj/zh1FJW2V/KivAvY=; b=
 ryIMeZzTTUQ9sqKqmLbQ+sEaHeDRZJwRbHKEVfylVCMvo2eIICT590Ov8DSzc9DM
 wjKjWn5bN3VhzuHT5jj8Al7Uz4k1yFgjxzvqK7i283g4jvlSt/ThggrjFBCkKPf9
 mpRBnJh5TS04czQq/eefgP9mXGKHA43q9FVOj5M4mPXn7I7aTPomhHv7k+ulBLJc
 N6GnYd6RtcZAAZ9voWGECnKs73rHBVssMeDCKQzIu/tmsiSiQJYc/8hvD55aynC9
 j91v01K80RbkMjBYAtjLtGQu5/QOL6BPLK/PZarE6REiKVTHq2BTBCtdCiwokU/I
 dNnEnCrmI/wiFyfNO7ZJbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753103383; x=
 1753189783; bh=/ZxNzaTohGdVchdsostYGh/FWMj/zh1FJW2V/KivAvY=; b=J
 cp79RXbPBQU8PEgOdEmav1C6Fi1UdwOcZEDdsQVxxticcL0HLBiwMPBBwf+Fejrz
 NjcyDtTJMPT44mpZfAFjwaEineY4G7azpzXOEHpV3JhmvI/aeRJykkBOAa4eN4bO
 gKmEDB2XeHXK5TZxwY1OCwy8M6e5E/8pjzPiQeLNlOz0pbYYqGd+YMMLZ7ZKRIwY
 dUEdUz/PZvDMXXxNB/QTk07Q4LYOWE4LNetZxNYk4p3EbVtRKzukcD83MTWEXRgd
 ja+5iHV0p8W7YfK0MeLFqS8S5ImPlPBIw9QevoNAYUbrrucxSmCsyLk5XMthNf4A
 +OR8P30P+PJsqnk+HnPXw==
X-ME-Sender: <xms:Fzx-aEZXbKik_yRaVUbxk8QIIOjOps_KuV89sarM7dya3H2ILoXBzA>
 <xme:Fzx-aEwg_bxPvib-cRJWKkMZ75-Q8mvy6PcR9Nq44y4MeO9OqkzNCW8KkUIFtJSvi
 9hp46SSfvkIfjiTtA>
X-ME-Received: <xmr:Fzx-aPLuB6x38l9_XDkN_Dc2N8O26BaCIuJIUVJ_eHLxJv_tgfAaFfKX9KIV0MZP30PRLL6L2f6SrWAQ1NSozgIiCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihrghnghdrfihusehjrghguhgrrh
 hmihgtrhhordgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepfhgvrhhruhhhrdihihhgihhtsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvg
 ifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphhtthhopehsthgr
 sghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:Fzx-aOq7OCbmrqFs5v8sRo8ckc2aOu8gfGcl5W2lCh2zbc1oraCJuw>
 <xmx:Fzx-aOJoVeyCDsJf0egfZExk-PTmA-gg8_mprU3-6HHLR74d-nucPw>
 <xmx:Fzx-aDRxBj6G4sKuf4PXyBfVf7BEb-8OFWmoTJycFhb-0vpqy8lKiQ>
 <xmx:Fzx-aNtEX6qPWAlgSWybGC61piWv-NyOxEgiC68ud4vEqY_vQRCP7g>
 <xmx:Fzx-aG_vdJX5QznJqN_JoX-GiNnaY-aSTXqiPwUpGmkyvAjNRCpy7Fqs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 09:09:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru,
 stable@dpdk.org
Subject: Re: [PATCH v2] ethdev: Align enable logic handling with disable
 functions
Date: Mon, 21 Jul 2025 15:09:40 +0200
Message-ID: <2703418.7s5MMGUR32@thomas>
In-Reply-To: <20250721130545.38200-1-sunyang.wu@jaguarmicro.com>
References: <20250721130545.38200-1-sunyang.wu@jaguarmicro.com>
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

21/07/2025 15:05, Sunyang Wu:
> This patch modifies the handling logic of the "enable" related
> operations. The key intention is to align it with the processing
> approach of the "disable" functions.
> Previously, there was an inconsistency in how failure scenarios were
> dealt with between the "enable" and "disable" logic. Now, after
> adjustment, their behaviors in exceptional cases are made more uniform.
> Importantly, this change does not introduce any alteration to the actual
> runtime behavior of the functions; it only serves to enhance code
> consistency and maintainability, making the overall logic easier to
> understand and maintain in the long run.
> In this way, we ensure the codebase follows a more cohesive pattern,
> reducing potential confusion during future development and maintenance
> efforts that could stem from logical disparities.
> 
> Cc: stable@dpdk.org

No need this Cc, as it is an improvement, no need to backport.



