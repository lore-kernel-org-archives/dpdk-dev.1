Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B0810F92E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECA3D406FF;
	Tue, 31 Mar 2026 18:42:56 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 7559E40615
 for <dev@dpdk.org>; Tue, 31 Mar 2026 18:42:55 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id C873B1D000EA;
 Tue, 31 Mar 2026 12:42:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 12:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774975374;
 x=1775061774; bh=plfGKgwcGjtqChrcBDoTZzTtc8xbmiNPEe6OoG3mDQQ=; b=
 g8pyl/RwzRAfZIaSPnA0yw29aRssg3Rpq5VRUSBsnQeNpXeOgl1fbk8Sx7UYTmjC
 jEL87WWXonegcDKXDTYtcQD/tyoyY3HVdppd/RV5Ayup8b9GGY7gAEklye83Rylw
 bBMTlajM40M/QOn8epvTiyl1sH0IMPT7kzyezLJVRCN1vqAcKT9GOMrYigIgEw5h
 +p8cjaKXHXJCz0jJ7hBxFSPo4VMz/n5IBdOiuRflpdIB0KSfaZX7c6znaQEIwgZY
 8vKl4X2iRpzzHAmB97jZ59Ate7PBY4DZhLxFu4IT0IS9sZFLcB+OE8srmx+6mlcx
 OK6uH7V1aNiUEfw87KWuzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774975374; x=
 1775061774; bh=plfGKgwcGjtqChrcBDoTZzTtc8xbmiNPEe6OoG3mDQQ=; b=P
 JcwR+MMWNdemdrr4nj7GzJp3S5MloCVNZQPmSVALlz3xb+V1vY7xh/OirMFDSjF7
 Bi4gAaHTGUhFeAcvBhvOM3ZgPPqXB7DIjIFXMQ3FbDt+w+kORSPS7rWk9y4S1CCe
 z9WSQ+hufkBAvBQaeay6BauFcE7Jt8AQLS1IehlFSMQf4zRW23zKrXNV13oJauSC
 qhO/rFl0jdh1Vw1PGUWg9MfklWBsBIwXpHFi2O6aA9NOmXIzIgPSb1ZR29pAd9ds
 +r+1UAZku83qZtY+nyQSqayfgYuUIPR7IeyyyFfybVE8pYImcosvyTAg3zp2s9UU
 6C9g2u57SaTR7xz754BOg==
X-ME-Sender: <xms:jvnLac-PaHcvy2svLGj5n_QgykOxkssqWvRcrg0SBB12qR7I_zHnVQ>
 <xme:jvnLaavUILaWiBKreQ3OxGSDfyJGYihqLoVNQJAcqpzkPWBO35xUKMMzHniG8Wv3W
 bgE4_CQsRz0F5hc2GP5RvO-1NB0ckCNpXoR2fosps3wgbId-xEPT4M>
X-ME-Received: <xmr:jvnLafok-ZbdBBYt093GgMx8uPS7j8YuzycDJSnc62PhCmtE_lsV7Tg6AqRaRskePQUk_vl4WND0zsy_UexwiKTdqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtoheprhhilhgvhihfsehlihhnuhigrdhisghmrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:jvnLaXmjnymDVlQ1j5wBAeoegySDEDjxUtIt-TXSyM33DVvQ0xCl2g>
 <xmx:jvnLaTzOKbG-ob5Jy0nW-XM1ZdAy6xchX8Nu5sFM1wVPgMI2CbpRhg>
 <xmx:jvnLafmi_sK2TQVAXDyD9s054Hn6z2QNBnb6G6K8z2eo3jlfLCkLhg>
 <xmx:jvnLacfM99MaullA7i63-vOnOIimEwVte4OKF7bowbE5_aW1PjZPJA>
 <xmx:jvnLaei667qmQBMYMq6ZqZ0WZDn4sq8Ry0-Du_hHT57cGfPE54QGZ4zN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:42:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: Power11 results added to tested platforms
Date: Tue, 31 Mar 2026 18:42:52 +0200
Message-ID: <8691140.T7Z3S40VBb@thomas>
In-Reply-To: <20260331154952.2077911-1-rileyf@linux.ibm.com>
References: <20260331154952.2077911-1-rileyf@linux.ibm.com>
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

31/03/2026 17:49, Riley Fletcher:
> Power11 testing results for 26.03 release notes
> 
> Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>

Applied, thanks.



