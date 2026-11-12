Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5257606A32A
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=pNqob2lV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3lvE5NYg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BCE240E15;
	Thu, 12 Nov 2026 12:07:31 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTPS id 8E96F402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 12:07:29 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 850C8EC00DB
 for <dev@dpdk.org>; Thu, 12 Nov 2026 06:07:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 06:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794481648;
 x=1794568048; bh=uS92RYKt3hz7/3wxTA7NIFm2UkiG1IsVXXg4omcy1c0=; b=
 pNqob2lVeoT7RniL62KjVMLds9TORmzLaqYljJ2ly99sTX6m0hd7sDC9OTQt6w+P
 kdv4Wl6DO6vn6TFPLfcxg6lpm0cKaw5pYZvi2179iGovPxdo2QjK4cOzX8+h3d2h
 7rCWCO9JiWgpZ4P0OLrnsY07fSStpFB8SdeopT9tQ0vB2tExGSGlyS/6EkxrJ8wz
 G9b9r9DUwGTnzAYRLaNfyP29gynHUjqDDf3BTujPB3eZ60AMfEnwgCL5+QYwt8Fd
 usrWRLnCEfFvQhTbUTlS616qUOKrDyor4f6ruvJtPFq35GRTRDjYIN0Rte/Q/2er
 Y800EiG0V0btfMBXQ7CiMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794481648; x=
 1794568048; bh=uS92RYKt3hz7/3wxTA7NIFm2UkiG1IsVXXg4omcy1c0=; b=3
 lvE5NYgZFu8Cc2rN5hUSJ12hRPKiQ2lQBbPsCrU5CuhPa1oTN1etfvKM2FMIwAP0
 jL3OAbdP4eMxdZ+sX+u/55/fpFe9ah2DhN5HA/ZTjJnxbQ6fF1ir4p8m44/qMy4q
 eesixeSCGUEtnkZ5ASQ5O3LVdcEN/xvk6nRrr6VZLTL1Rn/bfLye1pTX6tVXNjrX
 dNim+NDckvsohadwfBb0ySm6cINLmLXQ7X3pt/V167uPRx02bWD+INoJA9s21Oi8
 LkkcAVIJNT/DFNBtw63sxxEcMy+NYjPtSM07l7WAMFggXndB+B/3KYTK5i4CdK42
 TaDgHtzVRLgexs2nMGSNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794481648; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:pLwcWqyB/xz2gntyVh7s1Js+Dr+IdZf3eNv2KCgMaXcj3fI
 iXSWF9izFWq+McirTUEj3HEN10C9mscAHNY89FbGSbjCQJ/AkV2Chnys0Ij9WiFF
 4UREsfBbsywHEkhZrc9aVgRa9KvIOkPAsqQpc3c+8UABr7Mvjj94zRMQvQpEU5tW
 sS1rYqWRjKXOR/ijI/sIQlHmSQrLGUm/10jUouS+9qCfiU56N2P8eTzBvKM0Xy5L
 rdPOQ7edkUiaKMtPb+UC0XJwx4jOr0b7CAD4fFnZMYf9UjDJORxlsn0k/a2d70RB
 8Zc/XaHVUUfKtFm8kXevY41dvyJR42A7dkp1oDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:YQVoMgTkfrF2TsGZRSE4qrv3U6Dhkmc05EOOSoV5RHo=:A+VztIP80lr2MSAWEHXJXI32B8mmUHnoyIFOjIBmI/Q=;
X-ME-Sender: <xms:7531arxClMLQh7y3hzXmDuP3-a92PAiZQRsoME--8VhPy_rMrg-2aQ>
 <xme:7531auuf--gXtY1xxOQCh-UsUH7L5DwnJvtFO9dLFlIYZjJUiNaJokmjT4oVJCaTG
 TRsK0yw-uCLGsguMOaWE8BViZ2HwX9BV9IwqzS3N7M38aPUlijMB_M>
X-ME-Received: <xmr:7531ao1MXwN0q22NEFa8JB1GvtkniiTupbpMBq3pdFbxJ2qTTv6I5qdgZz7yagwO69eIYi3MPdFD7zIskVvbwKs>
X-ME-Proxy-Cause: dmFkZTEpivuw5klwp9MGKGKIk/7Sjt5/oLvY8R5qWTwrMTCdpCdd7gz4gIhHf8UZqlfYsZ
 JDiUCSCXszz1iD9Lqm8rsrtFzosbGNyDkTiMRqpidqEZWpqBRbHHZhLemhMZFKbiJm98ee
 /THv/kxR5dcCmZJBgvYrowkBfPRa4tkq2QIzBZJJGXFC/nsFJGX4xLHCwe5/4UMCiQaAp3
 ffOD70fjB30MdGV4o4sMM0BWjEqpmbvHddDXYGcQtBQ/QHmtuaOfTshRDk8eXm/MuEopwj
 jWaXibdMlxLFeMSmLextvys12lPJUrI5Ju5GL9UwfE+GldMCOuRb3lxmID95mqcnQHXmkN
 I8aTmSmxfr1MCVGh2quIDjGn9hJzz3D24t3aFzq6h3JwXMT8Q9IVkhlR/uA5qWywSn89wA
 Tqujdv+jRxUSHJbqJGg8ZjoX2rRFS3gwG6onNUOvFf134yILu+BWXQLnnXgmMkcjVc+t5T
 JdV99OG/iXYisGzuizE9TA5LQRSS68Ow59ExRWb64lHB4Df2fA1aCzy5mzEENleeC37scO
 glpr+gi40OuTf3/reZRT69EALK+J1FYf/cRUSbHBaqeo+lszF2/7ut5agJIoOuRiWFMrh9
 i1VGztHdrF2QQHDQwPU+wA7pRDOfEUDB8CAZZIyGpG3NZzdZXRdlGfkKQ6eg
X-ME-Proxy: <xmx:7531ap8sgwETew0xLAj7FS3cth2p5CVqWUHNLjwwZoZpHyZkk8xFbw>
 <xmx:7531apNslyYfh5PKbq18jTAQGFRTUi0lYbKbitiNKNit9feHIILbcA>
 <xmx:7531atd2KpEohWxOAzPYQMn-5LSRN7V1FB7lm_P5_k3ZEiYuT50iYA>
 <xmx:7531aoWAIyuWuJ3bcyqB2HDR9g53Z1eRhdzeJvLRvGl98zHHaLs4IA>
 <xmx:8J31apdZ2hdpfUFdrLWMwmAqliP6csY_7lWTSHnp5G_-8F7ezRWmEQSV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 06:07:26 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrey Mokrushin <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, dmitry.kozliuk@gmail.com, stable@dpdk.org,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH v2] acl: reject rules with inverted range
Date: Thu, 12 Nov 2026 12:07:25 +0100
Message-ID: <xxhZnR6-TJuwAe3nHkDEXg@monjalon.net>
In-Reply-To: <e48945f0-9f78-442e-a2df-b9315371851d@yandex.ru>
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
 <20261111073041.38712-1-a.mokrushin@ideco.ru>
 <e48945f0-9f78-442e-a2df-b9315371851d@yandex.ru>
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

> > rte_acl_build() doesn't check that for a RANGE field the low bound
> > (value) doesn't exceed the high bound (mask_range). Field types are
> > known only from the rte_acl_config passed to rte_acl_build(), so
> > rte_acl_add_rules() doesn't validate ranges. Such a rule is accepted,
> > and then:
> > - for a 1-byte field the build crashes with a NULL pointer
> >    dereference in acl_gen_node();
> > - for a 2-byte field (e.g. port range 80..22) the build succeeds,
> >    but the rule matches every value of the field instead of none.
> >
> > The check was done only for the legacy ipv4vlan rules
> > (acl_ipv4vlan_check_rule(), now in app/test). Validate RANGE fields
> > of all rules in acl_check_bld_param(), together with the rest of the
> > build parameters, and fail rte_acl_build() with -EINVAL.
> > Add a test case with the generic API.
> >
> > Fixes: dc276b5780c2 ("acl: new library")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
> 
> Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

Applied, thanks.


