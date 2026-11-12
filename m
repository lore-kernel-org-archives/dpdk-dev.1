Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063A606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=vZ/5CEHX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eJx6uMKO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF079427C8;
	Thu, 12 Nov 2026 20:46:13 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id E48EE427AE
 for <dev@dpdk.org>; Thu, 12 Nov 2026 20:46:11 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id D56DC1D003DD
 for <dev@dpdk.org>; Thu, 12 Nov 2026 14:46:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 12 Nov 2026 14:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794512770;
 x=1794599170; bh=YloSnj9HjI+BlOYqDNoO81lghoESoBf9nq/Op/n4FS0=; b=
 vZ/5CEHX0e1lpqKdh7OJdFKbH5hSP1eUGDz7QY/itcedy0Dkkv40fDadfngEtXUG
 lXI6MgpAZ81IgYmnABkM5LhEJAN8LsMWKFTMV+jblRlJwW6/YAc6e8WEjUBkUW48
 f6cB3vhH7CjTDgI8wiE/R63wfDTx1DQodybdVOdxsPo29Z/mpJond4elhw2Wvf4M
 TQHhYotmuCbxnVvsgbFoGSRx1chh4H5KszW9/Xu8Se223dw0HlgsHaD5IGvb8BD8
 K1WS754rzp8dvb8hsEBeeCo69RiHS5N4w9BF/rBgOQHO7dpS1tONX7RGmbX9u0Ob
 jgxd52gqIIjVDlc6pTcc1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794512770; x=
 1794599170; bh=YloSnj9HjI+BlOYqDNoO81lghoESoBf9nq/Op/n4FS0=; b=e
 Jx6uMKOAlhiHvUzipQ574U/AxPZegT2bzlIqkVZKnLetEfZHglNer+2cRdtpQKg7
 Mx8u/7kcWlrdlDVk7hrrvRt68mEZZwRIHfSQk8sM1X9ZaSLEY6ShI4ujWWuN5dVb
 k6fAhlVO1OGQKtw6W/4FHkT4FDa53kbJpqdBenIBBvHu5RAmGgnTqPVZBucH6/pD
 pK+agWsygCv9xKXgx7DghXqpAXdkc/0BROXCdm3FeYxLD810CbDIn2lanCLiB31l
 /x0Q7oxUkDpOrGRL7bwem2k4MwPAjuSgGMNsFY6mZxw5SQe2mV8OoUZKbxvsyNh+
 iDB2W27oRX9T8sj3Ry2dw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794512770; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:tSeiwoHK0Azaf4BFMy05fXhnwPL9huSB9yLGEgocnknBoLt
 j81CtHf47dPiYcZqcRDjcmqL33Qopz8+RwzsRZaAZidp8yEJzCcKHuvtMSGenkSa
 l58yfeN2QXCx6HG1RwGrIUrzZ2HgBphtmkjFWzNq/dDb2No/rwrou7N/IOI8tukE
 fffwPYZuQkuUUvG/mbGBDj1psj0KJlgrOh5QmQy+cjFezQzKHp7L+pz6Vq9+wNmK
 jxQZJ7VaWbqlGQihfRdO3ARduGwRycUVIQvnUO95NjnfsVc2t9Avli1tc5P+5Ot6
 NBLcPbtWYYsPKWtO1Y5sjAw2RPT6w8fTddPGYCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:n/lBwKp8+VIz1KDmpKgN5kmDHVWFUSnRxaqPLvhXupY=:j49wSMzIx7nNs58VYTPZZrNxzzwoc4INoustFI6GpiE=;
X-ME-Sender: <xms:gRf2ahA6xDdLt7k390HSrWhHNDEExZOdegLJdQ6M0YAScX8h253Zrg>
 <xme:gRf2aq9mDcDiW_7sAgOygdCkZHgzwTZtXKgyZGY3Ti9ucrCZoyxuvff4TI2zTaC-a
 OSHREYsiXxHuZSLOOqtKwmlLkPsJVbcz47-pLnD56m0FtWaCEWMTTE>
X-ME-Received: <xmr:gRf2agEGNcPpaxtXdnJYIxhRkBVJ-33LGfYyiS9CWD3bflOu-OwdLnvqX3GgkNmSc3zWqsJjYvxbtDLigJ-Mlps>
X-ME-Proxy-Cause: dmFkZTEdkI118tV3dHeyrig8O+tdi5xjT1ZDEOX+mmJoQ1DMm1w7pS6Z9X3IUwgx+t45rX
 rmvUlKX4QyBE0nad4BAyJUUh8WkkXaitIzdXDZS5EiZqP/X/RwsrZw257AuOJ6uwCFB0NU
 30q6nDl9TmP1xJaqm9dhJIn6reO5B796YOaB4AMuHUCMDVfv0fdxZwPycYJ07xNTA8zkbO
 ecEgpCXucHPaxTAdaeWUn5Jm1i2iRz1mK728k+vVMUd86KHc5uKqERTcAIgkxk1aIy39VT
 QGmtaau4HR5ilxq95+Huc2+XPPpLOmoeRGcxuRPW7SgqXEkKvXRdflM84+OxBoc1zr8Tcs
 Hc4yyQ/fXiacHwb7fyJZ8ZkhUKXC+lV5i6axVd2dM9ce5zglDov4dRS3B4Oh/t9zogHva6
 aMB1DAS48fV+31wJ00F/W1jX6N4zHQwZQQjgIiawoTQEJKX0EA7DQ7MykIO83PU4Ba3DMc
 hc0LpmiouBrx6a9AbSpOHH7fINCxX6oTwqQlnAXyF88BJWVSKw4HFO9woDc2nJbHkN6gTq
 XmNxAcyRGA8N9FyDF/G30AJtI3Sr68frjiW9yJwoSybpPlFSlW7HDYG+m9S8kRKEBGbDw2
 ft7LXaS1MNEcZUkMBPZi2dD+Fxr1jKiOENZ33Zv76TF8QE8/9m74YNx9gSUA
X-ME-Proxy: <xmx:ghf2agNbEUN5y7FfZDkriawG4zQx8uAZll5XQ99nQe0oTH8qxlJKgQ>
 <xmx:ghf2aicF_0lnlc8r9jVz8uVwlS3-Tt9ax3jKhwfBvKk_X4GPvgUylA>
 <xmx:ghf2attly7cS8CiU4YDxhfGfFzefmrGGdafjyhU4ujGPoQfhb0QUng>
 <xmx:ghf2ajndFgSwVF_gBsYXfe7RTjXTAlssQgOpDESRtvH9RbONdAqrBg>
 <xmx:ghf2alu9GsPy4TScF2bgwOysJJuJLMwawLpiTyBJPqrVLdr9pvQ0h_sd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:46:09 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Frank Dressler <frank@dressler.pro>
Cc: stephen@networkplumber.org, dev@dpdk.org, stable@dpdk.org,
 tiago.lam@intel.com
Subject: Re: [PATCH 1/1] doc: fix qdisc bypass default
Date: Thu, 12 Nov 2026 20:46:07 +0100
Message-ID: <yRcdnp0NQ2-cMKZ4KU5Sxg@monjalon.net>
In-Reply-To: <20261020173735.94410-1-frank@dressler.pro>
References: <20261020173735.94410-1-frank@dressler.pro>
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

20/10/2026 19:37, Frank Dressler:
> The guide incorrectly stated that qdisc bypass is disabled by
> default. However, it has actually been enabled by default ever
> since the introduction of the PMD in 2014 (364e08f2bbc0).
> 
> Fixes: 6ef75e405d5a ("doc: add af_packet PMD guide")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Frank Dressler <frank@dressler.pro>

Applied, thanks.



