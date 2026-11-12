Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714FF606A327
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=uCzqUr2/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iWvFxstU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6588415D7;
	Thu, 12 Nov 2026 17:44:23 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 9547C40E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 17:44:22 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 8AC2BEC0110
 for <dev@dpdk.org>; Thu, 12 Nov 2026 11:44:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 11:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794501861;
 x=1794588261; bh=tbeSwj4C76x2aVV5rU1stKtYFtLLzLa+rnYlLvJDyEA=; b=
 uCzqUr2/vJ6i2+Vqdrnn25NTpGQ+Uy7A/Pp8YlVm54sFRi7yDl90WPQdPxbZhlG/
 vyB8u4vYIIlkUoVUi+WcFIpXkWAZbW2eZit4x0XRTAYbH2jm+XksFn9DW4LOOAta
 R/zFFdsLLmbcBtrzlc3RJl4mgdhuZs1HzdU/x+xQc/XezTXdiTBHJ5WLglfg2IVW
 EgX7nF0SxJtcFiWzkq/cSevRIUlf0SWdWND77seAprKGujCsQwY0SnxaPU7n4P/R
 0JAMiWc5Ue5mEDKrmeCipzyOvjXt5mjjPUJdkUot1n8NjYed6Bd3nqoqe2Z/gWGf
 K4QKrZVYUBe6xW9L3YTEyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794501861; x=
 1794588261; bh=tbeSwj4C76x2aVV5rU1stKtYFtLLzLa+rnYlLvJDyEA=; b=i
 WvFxstUIE+lyttqhF+6EfZLp4CShv6VR2sC62V2J5FRBr39Ha300fO6DcWqcsV0I
 53z7Xa8KjYpKnWeu364/G96sQw63kzc7SjUmnSlTTxM5/dEIzLBcPB4TbcV+9AHB
 yxWgyqsx7GoyvOT1WmZ+fKf6MYadxxzSeSM5gDEsAE+iNKANw75ISQ8f3lOJsqOr
 kp3h9M06ucles56z7qN1dbRiyg48/HUw0Nr+JnChpt5mqL3BnqIhVXNeMIQaaT4O
 HzAnJDsTDVMM9Pxa0q3jdpwndhiusQPQ//5ZAJeiaz4f0y6OMcpomLTsSxC477S+
 DD1jllS/+lGYqdhG1Ggqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794501861; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:NNyxSzCK6p8kj/1n18Yt2yFMsxKJOsELv3xSezJaf1qUa2l
 lemXttkYtMfS0fVH2f16S78+dmClXYogRkmtWK1njXbQ0IeLAssEA11/3LX8jVzn
 ejIFXovaXQwQ6QeSq4LNbw3B4TezpCaFjOmdHppWNLnHvGYO4LrwQfmK5NS2bOhZ
 6rwdXgoW2cv1+VfL31ex3kclNAFVhpRcn5HIymhPxxU7nnsLVQ5e5s6Mdwv0h8zT
 pVAFY/Fhkv1DDuZGQ5eamktjUAUhFTUDoatBQhVP4wYJeCEX8KPHEycOtf004ykd
 4gKecdQLwPRbz8Hmsa3QqQ8Lzf0Vl8UYp8SVrkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Z3l5zsKR82R/UOUNS3WrXuDDhSWeJnuEuvbWbEeU42o=:tbeSwj4C76x2aVV5rU1stKtYFtLLzLa+rnYlLvJDyEA=;
X-ME-Sender: <xms:5Oz1ai-Ctz6HGSQ-ejWCMaWR7wUYvZz2uxBQy1HMOCt5cOwrj7iw3Q>
 <xme:5Oz1auL1Aqf8HKA00O-m7HYW_jpxE31DV-XYbaThyO0IQSByZTkzoev6mQaAgpiFG
 8mTMUZUtrEKWiwait3L6ELgZKPQt5Eb3y55lFfHH3nOmKf0MUJ1ig>
X-ME-Received: <xmr:5Oz1arjQbvWKYMBXpJ0k6EXpwuceD1qnXjrtsrD5rGImZeRTFlpaSh-pVbGctY40PuKiSmNjyOy63EMLWdh3mg8>
X-ME-Proxy-Cause: dmFkZTG3ES2WJCqkaQSzXYwiv3BaCrZhn49pLiZE4PvtzWkiDCISpOdaS3YGeeKYLaTgLe
 hva4SJNM3+QZJw64oiGzrUGU44n+iLTgLP35K/5YZ2f/48KvnncbE745LIcmFrz+b4J9Md
 xVdqD3UIUMLa/N04U9B1+PrE0J9QX361xfwqV89rqJom4md/4PJLIQPJYn1TqkQ6eidiho
 IHyluuUlJOa5vHB4TTkxPGsMBzngr+09fZw6G+wcARZFVj7Rpei3464WQ+1FNJNuQEK7NA
 jpQrPev5tanbLUd7m6e5QBuCn3uOKwWjWH5gDxZlUdWT4MW285HiO6wn/R16rnTIIQzOts
 NFi373agO7JWFP3IWiL5Yof917p8Zb3Neugi67enETbqnW/REqss2RnKPqwF7c6zsETZ5z
 VoHBXef2YrhTPx3YUUZ3gv/wxedFK0xRTtJOUJteSm/O4/NKoZg915htOnqkkpIF8H0xgY
 BG21Ub9sEr+D3zPV3MZK7McG30YUyKCD9mGX8MnfyuXvu4cNEAD/EYh3kRmOCpigD7+eX4
 Xjx3dx/JjnmpfScUe/rgCLWxqLC3M7nHUdgQXoGuTx3YfHPjPel3i7am7WY8avrFbywG5Q
 10xUT6oMjbNkHQqjnlzugamfJrtSP5EXr2MdmEnDjWSGZjZbfzzAtn7OY3EQ
X-ME-Proxy: <xmx:5Oz1au4UgSQSCoIiARx2JGLv-QQBJMKN9lFBSDci-pPOuGmj7tuKKQ>
 <xmx:5Oz1ajZQPtZjuJgaQTHvM93ufiCWV5P88SkKTiOudvdzq8vK7xNsxw>
 <xmx:5Oz1aj7VAYBp2o3LO0uyx6dciHy263NTbEYhRQ6d--E3AyLC-0t1qw>
 <xmx:5Oz1amA8m7TENuWUrSf16rNrmmKmD4smf0_Ok82OpdP4LMIaFO_48Q>
 <xmx:5ez1alnsRG6syQecUZ6KWoqXejudtJh9tvesqdX7bWJyLNiegiWTSz_I>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 11:44:20 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wei Chen <allen.chen@jaguarmicro.com>
Cc: "Richardson, Bruce" <bruce.richardson@intel.com>, dev@dpdk.org,
 "stable@dpdk.org" <stable@dpdk.org>,
 "Dumitrescu, Cristian" <cristian.dumitrescu@intel.com>
Subject: Re: [PATCH] cfgfile: fix isspace() undefined behavior
Date: Thu, 12 Nov 2026 17:44:18 +0100
Message-ID: <LzMzqxBsRKaqXwDq1o8xZQ@monjalon.net>
In-Reply-To: <DS0PR11MB7442D693AD4BB9C34800961FEB772@DS0PR11MB7442.namprd11.prod.outlook.com>
References: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
 <auxNNQ5dWrmHG96_@bricha3-mobl1.ger.corp.intel.com>
 <DS0PR11MB7442D693AD4BB9C34800961FEB772@DS0PR11MB7442.namprd11.prod.outlook.com>
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

> > > The _strip() function passes a char directly to isspace(), which is
> > > undefined behavior. The ctype functions require an int argument that is
> > > either an unsigned char value or EOF, but char is signed by default on
> > > x86 and ARM, so any byte >= 0x80 in the input is promoted to a negative
> > > int and indexes the ctype table out of bounds.
> > >
> > > Such bytes are reachable from a user-provided config file containing
> > > UTF-8 or other non-ASCII content.
> > >
> > > Cast the argument to unsigned char, as is already done in
> > > app/test-bbdev/test_bbdev_vector.c and elsewhere.
> > >
> > > Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Cristian Dumitrescu <cristian.dumitrescu@intel.com>

Applied, thanks.



