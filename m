Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C3606A90F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=n6xK8AEX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=LJeleu6/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F34E402E3;
	Mon,  2 Nov 2026 18:09:38 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTPS id 128D44028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 18:09:36 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 071D87A012F
 for <dev@dpdk.org>; Mon,  2 Nov 2026 12:09:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 12:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793639374;
 x=1793725774; bh=NI+GINGWWSv0N0vLHyqXOLtTRjPct9XDgCd1If5v0PQ=; b=
 n6xK8AEXYGSUiS4afzouBSA5TXvjdDF1B4ylOk+FbG69q97gDE6EVpCi1AWeOuPv
 +LXKjk53ra6nSVS4VvVwgleOibox+J0Gd0n7kDLMu77A7yxpYQx4gaXcLfwHVRXt
 +KE0c8pG5hVKecY2zDIoddajsI0QYl5gGOP0eI8YBGsQ+o5XZqimhGBoGOoiz8Cf
 c5em2gBwu1KUgb+YwjxhVjUd9MpR4rFOSX30cvBXAXOF9IbDN9jn8B3XkouJJyTJ
 fFOOX3MP8DftiXDfnOYuAckUh883SUKR/d4DAeaw1u4qXZy0Hs3vi/i4VL4sB4Za
 hSqjbrNXKacAXTjv3o4rKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793639374; x=
 1793725774; bh=NI+GINGWWSv0N0vLHyqXOLtTRjPct9XDgCd1If5v0PQ=; b=L
 Jeleu6/J6rIX2P+ArT7l/86nU6Eqs8p2dCkynTJapyBBNApY73OUfcLzOiXLhZAG
 u6/vdQ4mmoWRJ0Ctd5RAn0/FydX//XEkKRYYOltZ27YAhg3JHC8ESJac09iHXWts
 46IZ95F+rSotJVil5aRLPkBD41kUAlQbawsoaQ7zFemfnYGsnfuqEOB09XuMkuBa
 G5MxxP2EPUYFLR+EO++nF6rx2JrzbPjuB3PXcOfS4DYgkKbclztAsb5+CzbXtnsH
 +11KJ6mohQo9HHLK4saeqGGelUFbm6rFGQTwthMYGDnARmRCKkN/TP7qaETF+98w
 9udXkosbJ7OoHZXnWOQvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793639374; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:lH3Zxq2LS3d0oHAXvLaFwC7KCfoXZoiiayBjGw+WngjLbOU
 /LREzR3MlXbrcwaCzSbRWwHsJPl09gEWBBOpd4w2iblH85LuX035eTjDv8LXZOs9
 CRn0GE89LfXNkUNwcxXCXtHXijVVRZL18ZcBMB3xpI9BtEStt6VIEFtrhgM3LRsd
 L1g5bgGSBXzYhE5xzyvRyGQxRdEpFGanSfg/InPHQvseKMyBk7aqVqBuJtfHtBKP
 gc45mK/rG9+L4IC7pZ/A8KnZPwGVgovVMV5oFctrQrd0OZvUFx3UY50SMsgSh7+o
 CTkb+DmcUpYPReDckWf/hZuvoK3Zp/lcpOsP+LA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:H8o/pGUWqgWqaWvZbPhG2rBhytkUBhH8kxNfi/UTQoo=:CwocaI0RdILATuWVToYyQAJk3JcKWTnlFiKFlM30XS4=;
X-ME-Sender: <xms:zsPoaioNbX853vTj6AWaDSRh6jhn1k1Z6mRWbxjlHatwwJLcSQN3EA>
 <xme:zsPoagzYi9QDjntPwVufsQA-x0-HBg-ayXBe4tbD3oS5SoMpmOQpwHaEs_nSy3NuH
 -EdBYJn5nVLVWCD2qa3JTvAz42bxCuDnuepPBVtb8F35FgaTGAVUruf>
X-ME-Received: <xmr:zsPoavLOiCTQ3jvEHUiyP643azR_jTJWKVe-yGOFa4-9hcfzbR7dQytXvEdz3iUf_wLVylcNWl0UNVkeuLSZv6c>
X-ME-Proxy-Cause: dmFkZTFdIrzqH5WY4XQMBI2Xt0oNq7SS+vrButsz7Bkqx43q3OfwqL94NZVxccLySO/0Vd
 pgTKWBdGG9M+3hGBi3ruix+Nt+b6sMTsx4MWJg7IsCv4sl3Q8tkknEaaFGPQb35Xchq0+T
 ZU5eGwxJo8sR+y7requP424ew/7AatoDyKKC4k7cUBBj55+6gaqfSqpQZUfXZrMUESUHmg
 GqCkc5/MPwOq5/033RuUvkRd3UNB8v8/6C0tzeAyzqt6HF+FOsnXsC9PpgRdyDFHMut0et
 SUwDaiBAJHA0qNI8wI5J38vmQP0SDmf5qbmSa5qb/u5/yEFU62lTlMRDC1VRMlJXEBsnte
 n7hgzV1RTmHGyHUHYcPFCWGEAUKc/7gxMy6dtbj7Di8p/AKcwnv8XCSuqcRIf702/cgd2D
 s8Mc99uBd3CftxjDlK9EXOnDmqiUvvxZ6jlPUd/VxD/KWrZoZcBrhtw0MIoItiDGIyDqJQ
 0VeldLGVrGuup84oXPLxIx1Bsjr5Hos9V29BLC6lpKA3l129Itk2hA4KWf0ssUSGr+jrO/
 IxtLlcKFDoAQM3WRXBlHNBGB4fvMAXUp1ZNLgSKvmuo6kMUdRfMJD76bxup/1+v+ZUJWRP
 kAMXva80af4tavfZOE4e/+Gq7V/KqT5CSwYSwOsQ9up7ZaBtUvBZUabpvtiA
X-ME-Proxy: <xmx:zsPoaqJJdH7y5NlHfwqcLPa8yEYt1BghXnqC-mPKqcXszoOC6geWWg>
 <xmx:zsPoasvz7BzvM4dGb-JG7OugCrdHwCKVY9gNkCiuunRladQWZ1Qi1A>
 <xmx:zsPoanQ9MNaiy3vFvIDBLoUzIZ94c24WGB1abYw8uCkjkiBjSH1afQ>
 <xmx:zsPoaiOY8XVkm-Vy7rjZtsWxzcsIFVLcG1dw-cDn4MYY_McKYDEmIg>
 <xmx:zsPoamnPp1A4nQcdjVtq7IyonvQ35XhPr3b3MD8eXjxrMPY8bW7_xDy->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 12:09:33 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] vfio: fix cdev build with old Linux headers
Date: Mon, 02 Nov 2026 18:09:31 +0100
Message-ID: <fEk3CF5PRNmGFEuo4obfhA@monjalon.net>
In-Reply-To: <auitnhsTX1eYCuFm@bricha3-mobl1.ger.corp.intel.com>
References: <20261102152805.644416-1-thomas@monjalon.net>
 <auitnhsTX1eYCuFm@bricha3-mobl1.ger.corp.intel.com>
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

02/11/2026 16:34, Bruce Richardson:
> On Mon, Nov 02, 2026 at 04:27:59PM +0100, Thomas Monjalon wrote:
> > System headers may indirectly include linux/stddef.h
> > before the imported UAPI headers.
> > Both versions share the _LINUX_STDDEF_H include guard,
> > so the imported header is then skipped.
> > 
> > If the system header lacks __counted_by,
> > its fallback definition in the imported header is not processed,
> > causing a compilation failure in vfio.h:
> > 
> > In file included from lib/eal/linux/eal_vfio_cdev.c:14:
> > kernel/linux/uapi/linux/vfio.h:1524:51: error:
> > expected ':', ',', ';', '}' or '__attribute__' before '__counted_by'
> > 
> > Include the imported UAPI headers before the system headers
> > so their compatibility definitions are available.
> > 
> > Fixes: d129414711aa ("vfio: introduce cdev mode")
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>

Applied



