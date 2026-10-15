Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCFCCA466
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 20:45:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7262F400EF;
	Thu, 15 Oct 2026 22:45:47 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 502A540041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 22:45:46 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id AA26C1D000DD
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:45:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 15 Oct 2026 16:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792097145;
 x=1792183545; bh=PRhis628oH+kMNDLTSyzHRzu/GDkdbG1mI9IMiBHYsc=; b=
 eD2pft5BxpidH09R0inZIhVy+h7qbn6klBupX7LEe8YcoPogcNqVhPbnjrWMVNIV
 vcLMirMs6PBQyaRu1NCEV/Ka8ieBEisLYJNoo9wlwz4SIVnHWgTvIv/lFt+9eCZ+
 fvUZgYWeOIZ/8DUCpaBT4l60HtzZcuDvrgW9NWj3cu2tvlYys8oPH2WXsbNZVkga
 dQkjGeMBU0sBJHojvXHxPcTRc7ssjkIrMl6V7RKMV4xlvg/IQkNfSf1f6Kt36IHd
 JANPhaVEvgNMZdymu2QS+eZn9atbyjL1uPOlHPle6Cjifw8XkgZH5cpGg7HHhp+K
 aaMNcz4v2DLkdTD/BgY0Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792097145; x=
 1792183545; bh=PRhis628oH+kMNDLTSyzHRzu/GDkdbG1mI9IMiBHYsc=; b=u
 BfEPJdesiDytWSyFgudBup/ejgqo1XwVirtSvoUT4D8ZR25Cgp2a3Qkwx2SdNbSk
 Udk321H2RJcB9ZSFkAtBtpRhFaz5nFQOf0GTnkdYq9THcfo1KaCbJpBjE57AUUbG
 +W1VD4TdiqW+Jn/DVEJpz//pJMMifV9BAIciT1/7F2UxdeGpVY8L3+A0mhP41dvp
 vIq/o0itsTOttMPkuxqKgmA2coVW7xVIGhFGn3chxiu6uFmIXg0f20RVQwtYPRqQ
 wlWeltGsnrU9Ie8lhE4qRNyiFdP5KSSKEJ7L5qt6D2qJNnYCUAQRZYvgosOeleaS
 xAYOmqLur/TJFtpmBqs1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792097145; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:nQcrQTRvCnZfR96hzZkprGvyukkedxcQ9KJJ+nfLuYIAY6u
 N7sB46oFokdPatX0tiaSfMKvJuFglTSEEaOG1E6NZrrokyeYu8KYNrhJ+NseGc/5
 UQs3yPfnUvawskgQ3J0TEknk1fMTleenYKMP9t1tRJ+92nwk0TY3gDqQJFWlOKS1
 9Qh0MiM/yarcq50h4LkIlsLVTsgquUOSpN0bhqCL3ynVvh8a7HYfEDLoTSiO8cX9
 QlegnpInpm8F2cW8CHgVxC9I09eYU3l2RFOQqwe90ZD85RO8OL3teVV6TU6SvMLl
 eif6AbkljtNdqqLgHszTDIBDJ1c6lCexCO+2XBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ZwUkHRAOZVDOR0d9IYcoMhnEpRFz3ZvO5KZbZZVjkiA=:j+yDAWOXmkpaQZTA061FeFKjCiWsOnndVX9FHh4gy+8=;
X-ME-Sender: <xms:eTvRauRn-kgRqgLYbkP1RHpFViEolhpg8UzjLT1CVVk2ZSgY01gTYQ>
 <xme:eTvRaoH_vCfvqcFkyUfGBDpzODBln9ZWGhkRg2l3CHnAFLwvn78L86LHAvJhBOqTW
 MyO-LJrBvB5HSdOcFCd_sG4q7HcuDZz37BHRU-pAWVsA6K_yfkXOw>
X-ME-Received: <xmr:eTvRaq9ih_1UPMLapu020en2ZqldwmTVmAza3dPbhx3Dl3nu4aRasUUQK6FLtft5r9HXuiY1jQuMKMfwhvJbOYA>
X-ME-Proxy-Cause: dmFkZTFYEmwipeqJWZjdtA39crX71cUgbXLgg+Bo622BagCpOG/dbbLNIyhz+XCApHCKxc
 EVpwiSJX6PU1qk/eGTOEECsZ0OxDSzfFHp4xykd4whi7xjTo5MYkg/uBHalWWu0Pl93szr
 QvXv8jl5PMAHTnu5+6myCI487x9hz4cD6LI0Hn1KKKnyyFC2zxnV6EOz8IKS4gvSrKavOD
 qGKKpDgkwms3WLMRHc+Gq+zlrDK8bne5EZtRS437leO97Di6cfj4SaUpulyaKu5B2UDU31
 oFdsvI9C4YZ7Wp6ETHC/ubukTy4yRBJU0WEz4/dhc8rfL/dBatj0gJBcGFaOL2Cbcg8hAt
 WZwuznzhSQwnq2dHbWZN0WNVPttj0zRpzKv7ioDDsYD4SVhGwuSzk9+ZLz6n87AEyM+MuK
 w47JDAWjRNZ4gZ7+yiLQ9tPHEwpixNWdBHlffK/rLaJjTa2vNQtl4mANYIwZpslmdxCiV6
 C5webC2lratJ/D6LCfXvpywillYncmyZYly6haCFFXrsA5UcfXNM5Jsj+TpNpJSRknfjZA
 wtmWgRRq9hWRD8K8GvOemN2//IQgznG9uc2lInB1ZB9DcoeykWcIFRVqwUlAufhPI64mQB
 R/WUlFfruB1nJyA2YkwYRNnYLZ9QvuecFUJv3DlXl6wjUdDWcSjwjsjofJTw
X-ME-Proxy: <xmx:eTvRaiI2dALIapkB0Ocn_nbpdj4LlLQ9oP9Y66ALzYHNEYBSPy32Pw>
 <xmx:eTvRatag8wsHN9eIqwQFLBH5CeC2MlWFqb8MUVJ7cm0bFSI1t7YeDQ>
 <xmx:eTvRasJCTrsvVjGVaKsaI1Dwyssf5_6ZC2SRer-seVsSjw9pEfeHzw>
 <xmx:eTvRajA0hkHN034oGN82O46DIRhuzz5qOIqsTq3-f2-ibSjxk8CGLQ>
 <xmx:eTvRapcQSMgkNafe6Xqa0CN8ASpuqYXBDiwD8UcJP9BdrPzGNMFpqdJa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 16:45:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Marat Khalili <qm2k21@gmail.com>
Subject: Re: [PATCH v8 00/10] bpf: JIT and interpreter fixes
Date: Thu, 15 Oct 2026 22:45:41 +0200
Message-ID: <B2MZKifMS0eqt3v5CkJwKw@monjalon.net>
In-Reply-To: <20260827214236.1415047-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260827214236.1415047-1-stephen@networkplumber.org>
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

> Christophe Fontaine (1):
>   bpf/arm64: fix offset type to allow a negative jump
> 
> Stephen Hemminger (9):
>   bpf/x86: fix JIT encoding of fixed-width immediates
>   test/bpf: add JSET test with small immediate
>   bpf: mask shift count in interpreter per RFC 9669
>   bpf/arm64: mask shift count per RFC 9669
>   test/bpf: add test for large shift
>   Subject: [PATCH 07/10] bpf/arm64: add BPF_ABS/BPF_IND packet load
>     support
>   test/bpf: check that JIT was generated
>   test/bpf: check that bpf_convert can be JIT'd
>   bpf: fix uninitialized warning

Applied, thanks.



