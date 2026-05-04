Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C4FF886F
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 12:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A1FA402BC;
	Mon,  4 May 2026 14:40:37 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id CA59D402B2
 for <dev@dpdk.org>; Mon,  4 May 2026 14:40:35 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4170E14000EC;
 Mon,  4 May 2026 08:40:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 04 May 2026 08:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1777898435;
 x=1777984835; bh=VucBlFbTBeg3Ez6R81rbB9oveMjV7i277wL8Z0iqG78=; b=
 QALQLMtKk7SSUC+e8DpXq/fGKimDJ5XWUvu1C4cM6BmIk4IwH7Hae+woZkllOddB
 jeer9UxjHEVt9oIFGQ04AOsmbhZfCjEhAw1E2bLF45Zky/n2Jn1BVzvysWvzHt8U
 x7StLSo8OanNoP3h0JSt9J360JVkeXN8+N0RTkVH6mJt5k+0rTbxYRpc8r9OkQkZ
 JviYvewGRf7GHywDtQDtg8sTZwDWr8KWyOX5Fog7AzXCIYSvMEjWi3dR6BXoZ/ZB
 5YiDktkF4U7fE7xdfEMMpwAuIODpm44fQOa0MPCsKfg+KYNDm00hB/AxLe6PuP+R
 s4aHwQRpR0XAh1xzKX8qqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777898435; x=
 1777984835; bh=VucBlFbTBeg3Ez6R81rbB9oveMjV7i277wL8Z0iqG78=; b=F
 zx21x6QzuURtCC4EGACDDQFQ836ySBd3QVZDGq/T+FWwgpVTH6b9clYb1bmdG1Im
 0nXgD0JLDj5GljPPExfhs2Ez5XB0+PIAkKs27R0eMu93QpkedOslYPpGJiAesEtV
 CuyWT/cWDrCWM+7PcsA7eGh3ifhedIlmP32zoZ6ILpZftNLVVHjRoVGqKL/LehDD
 pZOhHbz6XhfYXaHsP+oUuTxi18xvMWz/MLvctU7FD7XlBpY2W7h5UFMaqEm+gRCF
 WGMYpVnUFKlqDoXcsW17NoTLpj/ioqLtKWYau89tHLTcocSN2l2A9kLtdMP7WdTo
 i6g8V45Y91U/6DUsVIc3A==
X-ME-Sender: <xms:wpP4aWokeniI_DL9CAAJMa7VhNRv_rR67Y6lZTspfOmBtJv8zEDV1g>
 <xme:wpP4aQ-qG0h_ovW9-z6tc4q03CN_xRFHSSSLSvEC5T_hyLFAVheSpeoUTjP8DvYlS
 YHt-blbyAcgkGwxondLsv-NdRoqvHphd5rMLGi5YEP55Ga0fmuHPw>
X-ME-Received: <xmr:wpP4ad_rY2VhmZ34dbHVNj9KPcTH-ItbC6_QmSs8MWhRiWaA9No5MC1zosdFrbbg4J25WAqS5w2zS3LZzFo6IhtIkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeekiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsth
 gvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:wpP4aXtnnZ0zBNzOydI3pyqSR7jEhi7bhzpeYtIp8PPRGhbfI7ePVQ>
 <xmx:wpP4aYqHqsqQAvABK6U3dNf_1pxP9eMRCLSm2YKCxogegkPzh5oJRw>
 <xmx:wpP4acn6c0crXk8vxAL0obodJS6UZGkIxUGJYULaQocMlY16iZf0BA>
 <xmx:wpP4aUzbxAg-x3etTeTbFzEn_-eH5Dlo7z70EPO2Qc_R3rG23Z_5qQ>
 <xmx:w5P4aYI6JvI12Jfm5DrbpJmzbzIfiiVbpb2sESmcuDcc_ftntSWM1ReM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 08:40:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] mempool: introduce statistics reset function
Date: Mon, 04 May 2026 14:40:31 +0200
Message-ID: <2350080.3ZeAukHxDK@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65841@smartserver.smartshare.dk>
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <20260224092802.359592-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65841@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

04/05/2026 12:50, Morten Br=C3=B8rup:
> Thomas,
>=20
> This patch is ready for merge, but didn't make it into 26.03.
> Will you replace 26.03 in the two instances of RTE_EXPORT_EXPERIMENTAL_SY=
MBOL() with 26.07 while merging, or do you prefer that I submit a new versi=
on?

I can replace while merging, no problem.


