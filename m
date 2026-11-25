Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C6606A326
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=DJvqvhj0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vRK2EfyN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC323402B2;
	Wed, 25 Nov 2026 12:35:26 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id ABE054027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:35:24 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id F33D0EC0C47
 for <dev@dpdk.org>; Wed, 25 Nov 2026 06:35:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 25 Nov 2026 06:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795606523;
 x=1795692923; bh=9J8A8vHjHxG8Jgl3/jugc7vnlqA7JZLDzuTGEyASbzQ=; b=
 DJvqvhj0rZLpFfshBVJfu/jXQu1jXU/eLOkaRp/ev2p5fMtJrDUIkOaXFjEnh4XY
 y/b46L6B5/1mvEord9QrUpIGr2tPdAjlkCtvFt/lIScTxuorFE+gQ0QKXL+0ySzR
 LtA4lq80izdTBd86v3JNsn4R4QN93BWoXgjN/WFzYFtFd0jAxZeCrDlDJl99QrzT
 QxLIufaRe8eSsDSe0VKShOvtF7WARfsoS8t4bB5duCXbym77h4Q8qedcIE4sRNOu
 Cm4KKlbC+H9mV3D1GOxUVqqggIc458Ai1uLTIP28BQ/YJs086SP9W2cXTWNypwLH
 UcWNSRvoH2vqRh/ILgIHQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795606523; x=
 1795692923; bh=9J8A8vHjHxG8Jgl3/jugc7vnlqA7JZLDzuTGEyASbzQ=; b=v
 RK2EfyNX3Qayffwtdo49ZM8/Z1y3EmhH3MhS8QO/wLl34HjQyJil0yxBXn+mma78
 Fp5avFm1q5GtwrfnjYVTKLUgD2VC+vCN22aYx1BImv1MjHyTstlFhcbS1HpKvP+n
 OB30adguRjV40eUcV8cNfCb8LJYGdYHAzr6kRvmvbsKukK+Fm20X31HZoq5AucQZ
 TZm/HdCcvFn6SUbjSTbEaF5NLGA7dxu51jQAnl7TNeD9Wr+tXHMRaYNFweFJIBDo
 ECCzmgH1ucngW/M16TDY0hJ2GxtpYM6SpHPhlJLKB4jk1WWyDtvVeI+1GLlZCk1F
 LOa9dVbPPoMVzb1zrtZWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606523; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:H/44ecTxkZwnoeRHuuiULQYGsCKKHcfrcoOyDN1rvcAYTAT
 tnA7eTpOHAyOtaAwpIjOi0P4dmcO2OvLmLKTN88mPbwSwpJWcL6JEaddpQEJ0bvG
 wO1zNoFRNqa7fKOw8Pf0U/3P8iNiIJApMaqvVuZB8vVUK+EDXpY1Fp7eoRxzgzkz
 4qrGpAqevm3dJ0We/6864uAJeASYZH+hN4oZwX/TSesYvLtpEakSY+e0WJ+k62KJ
 jbz6kGbN+ktNRKrDqLAI9hfoENGK+Fxf4hfmNYqLY7HgABeV9JY3llLyco3/Jci2
 ZDOAsvKtY+clq5S4wyNY3PzWzXn3dG3wPs9LiLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:dG73Ro6YyxRl89J67JFBuyyHU8N5jmOVaJ6iVELdzn0=:PPwwVJdaIaCtnS/G8XCVRpfOI7lM2RT/Oz4i8jYGWyM=;
X-ME-Sender: <xms:-8cGa7_QK_LmmhECzrYukLaQ_nVQilCsMTT_RzCRSnP1Q8XIRtYMxg>
 <xme:-8cGa0Bo8k1KiiSOtjydUTK_CxMKF1-xMDxthaBSXQ6P3Etg8HsMtGMOim60Uls2R
 eE0BQ6SnhLkUChGdlvCwRy9vnaJpuMgtLeoKHpwRbF6Viu2Gh2hUkI>
X-ME-Received: <xmr:-8cGa7zs3qO3tzL3zW_hEORlWqY4J18JpIgXUuRvJtJGC5PAs1Mb8pyZsOr7pBwSfDgAfu-2-U4blq4SDjhvdzA>
X-ME-Proxy-Cause: dmFkZTFJK08jc+cDYveTfv2PgchTzFEbINcAaPHcYVpm116UcGj2lpzTQro34ichlwtWeE
 bVgh2TkASuojML8VU7AoL3SezshppZHsKjdSo3s+sxGrhzvAMsccpUdyCy2BBoMsdR9MYF
 /DaCPS9iKH3bnzj9V1ksXjjNbCSX0iB1eiAxdnFVv2hWMYSN8+VPKgU0hOPIIPeFRxmahC
 2uh4Lu9G0RcoSUCIlW5Vnh2eCPnROWe9/DWIYSvyqN9ydH2sl1U6JLJZ+9bnhJiUs0lFN5
 ryAI74VkpDhuMFJqOpvlrWAEFtYd2kNlm42ffYQu62t9jWkclgGn+PRjiKHV5ASQToZyiK
 jRhbXwo9CWY5ltXV8XXRGrhCnWgGBd2LQ7k23Mka6AOLjHAiUqpw6Lv5628vjDGzJDxS8T
 F5zlQEBqPQogkCGQUqvV1FaM9R0QehCkHcZCU3n2YD3GrTTvR2jZ1pX+SxhPWA+bLAeFWx
 o6bpI1Uqqo8VuETgOy/lM/7vh2I+q2Buc/XCFwYuIyJA1HgofJ1fwuXHPXknI54eNWwgGY
 niS4Fz/5l1bKOyu+E2Ywt8+xdj9AnKhft3A2D6pmzifGM6Nvo2rd2pQt56irXFWyITGMa9
 O/5hf0tf8IRnIVQq2ssnjoHE+VzpiNXJhURLK9gW/lhj7UG1RfVQiaMg6Hsg
X-ME-Proxy: <xmx:-8cGa5RTfywAPjyG0spowRik9IKvfEtgd9DmhexlIoDnak46ddA0VA>
 <xmx:-8cGay-EBvAqcKiVv8oXmlG6t1MxYs1myuLKSFzii0ArdZ1DfIdHow>
 <xmx:-8cGawrLttJ0yN11dAKQTpcuO8jX8IbwC1FCTqryZpunAkrF_sF1zQ>
 <xmx:-8cGa_nsPbXau4sdYqSsIXHFiyaAFyADtAqRlVRMgV1vLuQMscXuLQ>
 <xmx:-8cGaz9HhnjzOCE4AW7g_dY6KlljK15xVQhjlbPeFvemfcTQz6ap3DIC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:35:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Wed, 25 Nov 2026 12:35:21 +0100
Message-ID: <STAVAg7MQliynK6trsmmQQ@monjalon.net>
In-Reply-To: <20261122154549.48329-1-rasland@nvidia.com>
References: <20261122154549.48329-1-rasland@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

22/11/2026 16:45, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 26.11 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.



