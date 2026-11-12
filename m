Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A04606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=Q/tXKZRt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=as+TS87u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8640942D26;
	Thu, 12 Nov 2026 21:38:20 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 23F6B42831
 for <dev@dpdk.org>; Thu, 12 Nov 2026 21:38:19 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 32FA11D00502
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:38:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 15:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794515897;
 x=1794602297; bh=zy3Srzg3/Z55MDd1wHyjxqgtcTilhSfCScYjsBfZ8c8=; b=
 Q/tXKZRtwWxkg0baS36XJYjntjvKKljcWYF1LM3oVh1bIXH6VAk8Otunv1axsfpC
 NwEJ8EW2VFoZOdm64y+ifJyXr71JStA/2DumFe9JYWghxoZlz9DkKwllwePFJWH3
 MrUkq8DsCIF1x9x52mwboPo5k/UUeYA41OSZMs/4Rw3tkAcb4LMPSMCf07iDBndt
 ImBU8pNm0ZVTfNdI6XySVBd2u2z+ikl57kYztYH2EP594u3WGoAPBGsnIwfjdQgo
 niiA0lc4MxTPoXb7E25mgernnpib+TBgBEFkhNyC1UXHdll2aqvfpaqptdI2nFSH
 NC028jYHBKmqnUsFHkLxHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794515897; x=
 1794602297; bh=zy3Srzg3/Z55MDd1wHyjxqgtcTilhSfCScYjsBfZ8c8=; b=a
 s+TS87u5mVPAQ0wd5COBYSwj6iMCUolGtea7BnijkdUDq9gPDcZiXD630xgObqzg
 j0XtDxPIof2Kc7bI08i0XZPiKq0SBmE8n9rx0kPO9/1UYcQ+92tkmYElfRyclwoa
 UGo8kUwRwt+KliPGe0pbpjB8Xp1UUmi9/cP6BANtk9Y+C6cJ0aBB/whaXUkfARzj
 lDlATZLY4f1TO2+yaB3YqvNhAVC8+aSVKngBrnFrHunZ/sa2c3/0pX47g0KS1chF
 BGlhE/9s1z85ZjHVvjvRcc+Ps3meFGL0eJZ+aFQ3J5aw0GlrOVO+mNdpR1xQuLoD
 wWcI9BwAsGn0bAfBGKocg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794515897; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:cRURjV2L0OEsrREQASCWjWWL/T3EcjpZXB/8lCbriJv/uUV
 4sEkfDV+/aP9Pa9YvvzVTrMMZvd0aiO6U6vJLNcQH0JiY72vipFinkpvGTML/7WB
 svAHvB8ogg+3+x+AU9Cu6G/fQY2DXWNfVtB069mCxpjvCw1fFruBb+Ka2Be/sT03
 6fT4MvIicLDKPHUOHMCrAAgEqfGTiXhuYrgkBfW2U9Y994yMvMMvgIEVOhNIjE93
 iYpBhcFl7u7OkE9VWLa+gRXdAISNSabq4medyRW+xZ0wxt2zLP3cl1ktM2+96Fa2
 ehdezHZHrYHNLkzPpUccQay1jCR4kVXYqRRUHCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:yr2mq8aeZrY2As1k8sPtWP+18DrpY/sjRZF+ImpReEA=:ryuSrSd+bSZBOP+vkcG3KCDF572vDNN/dZwHyX4xOuY=;
X-ME-Sender: <xms:uSP2avrA7fa2d-izoYW2bxsqD-KLT8CSfP-jf-huN-4Et3Z69Sm1hg>
 <xme:uSP2at-xqw5etBAD1uMhARsZusuFx-DRxVKX-Nw_zFA59VXo48Xmn10rqQP3IHBWO
 OkzT9KfQCcNC9NtsIVu8iFMTa4yVAAPu9MejpchGG_6qzHzxaX6Jb-t>
X-ME-Received: <xmr:uSP2arXIEbgqbju2rMp0IJSoMp9TrGwHbL4sFFNMT31ROF37XIGOwcA98VK-tp9oSgpfs-U6qgC24_40YGegpjg>
X-ME-Proxy-Cause: dmFkZTF26H51pPQ9dAdqjOVmzhuNmD7N8vMbaeQ0e1mQroqxeOwYY1C13V7TFR2jD2rqYX
 nNo9YNeFblAvRykAdy1KgTUkx7ujKUbRws8XfD3a6uXu9w106sNGubvw0GD//UFGj96FrV
 RQxVz8GuT8X1WKFIdEOLmrundfpbHdkETjLSxKnQTiHlShQsflhuoz9sabUAYrpUgTorpi
 /gnQYdBdz8pNHFIuZpUXTGMvtoMkCJ+ZR86vMKwYlsEbGlp79CoKRiuBhtrdhYFokncFQh
 MtfdDVQVFkd0Vxspw9v8R937X7xKSEm0WbEUF+x16NZBE+ye9A3neuJTAuXeipXSHN7wLx
 DPk+GAypp3jzW+4MJAkGNk4gDVbzuyQDjIZy+kSrBqzvGQN8Iqn3h1uYmHNcw+Ig4ckUhi
 BB4vNjukDkhXo2b69GqlRJoMnJj7oFyBJsmjRLj7/S1mBEKcWBeI1PDlFisvvkjmQ2XrZh
 dvjy0Ld47B350xiNcuqVPJ1WKDhJO5441VskMjtyHOO9/k/eAI6J7ovIy2EUrSM9wwtTqL
 hp99Ljr+cUBIl0yu3flhQHrPfnMTWH6VSwSuTVnysj/avv3IbSzahdG8NtRYOPKZ2fkujM
 sPYz9vqIgmsyHl5X9vazkh5A1bcqmYFO02FmShU+W+ZsR4IhLv3fvuqQC2vQ
X-ME-Proxy: <xmx:uSP2arAKkwgQylcSq9nZ0o6ul_lV7CL7dF1CG2mXCg6nev4mm-GTdQ>
 <xmx:uSP2aky183A4G4NoTEaA24xxgjItWNFgHHBuVB350utBUIblgQdkow>
 <xmx:uSP2agD9gP-oOsMji8INfHsDhZ932X3_V70c4aNIzB2GIGBRNt25AQ>
 <xmx:uSP2apY0m1OwQt7OFtpzoyZDMjZAkU7y2zEFECRsyATbsfbkuXs-0A>
 <xmx:uSP2asuEJnf7mmpZBQX8bdcAzJjVeUDu4futPKjrkWGJzz8kJwfDpBsb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:38:16 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yang Xiaoliang <yang_xiaoliang1990@163.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH] doc: fix typo in l3fwd sample app guide
Date: Thu, 12 Nov 2026 21:38:14 +0100
Message-ID: <mBSCDiV0R6mmfvMLglm4dA@monjalon.net>
In-Reply-To: <597077b248584bab83f148098acb6cd5@huawei.com>
References: <20260807071546.13795-1-yang_xiaoliang1990@163.com>
 <597077b248584bab83f148098acb6cd5@huawei.com>
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

> > Fix "menthod" typo, should be "method".
> > 
> > Signed-off-by: Yang Xiaoliang <yang_xiaoliang1990@163.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> 
> Consider also running this line through an LLM for better flow.

I consider it is good enough.

Applied, thanks.


