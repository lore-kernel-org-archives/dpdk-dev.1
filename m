Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868F606A327
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=PH3h/jQi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uWhfeyyn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA5D402B2;
	Wed, 25 Nov 2026 12:27:18 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id 441C34027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:27:17 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 5FE57EC0C5A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 06:27:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 06:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795606036;
 x=1795692436; bh=kTIDTnvCbLVMsWPBxvzxFBWETcYv99w7dWG2GI00oO4=; b=
 PH3h/jQiU8T6xhIDvAkxUso7+ZqEb+QMtLMHemUQSW4iqqFCOuIdqGprz/34ccZc
 vXtDvuGGlZwWSvg1Ba98g1fs5bBdL11l3BlYc3GEZsX1ka+gHR6o7MrJzI4eOl/z
 2RGEDU9MVbfLaQRkuojESVcBS8ArCYvcxWYDasGdBwWgQxBjifEbH7KAkbAFxOPr
 wMUQ3QVUn3xHVZfUi6Mz69WEn0+SU1gjja8rVKb3u+ODCb+7wqZ29doFAbkJMW/z
 V8Vtays9E3jwMIT7xGmHfEJHvzAdT/TH57IQr8Ql7XyvQslDugoVaHrio/TKlL8F
 XG0+2iD3TMdCY9LpCaGhqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795606036; x=
 1795692436; bh=kTIDTnvCbLVMsWPBxvzxFBWETcYv99w7dWG2GI00oO4=; b=u
 WhfeyynJADngz02y8dp0pAlyfiwLeQ7S0kI33oB6BFXa6Lj6LKKcVsDfLNqg/WwK
 geoShAnW69YbYQeWvBzok7hgbZ02QYjEwcpslS4T70ZriHUmLT6+CrNaNQidp42H
 HavlkQG/aTM5KPePPvxpSly7W2oi5PjyocAjIZX94u0JE7L8Q8s0/YmEibV0Lg0x
 nG7/LZ1tkdYA5ImlpEdXm+g4Q1mXLG2kWv1zwynttg8PfuDNfR80SiN77hgzGsTN
 4brQCSW8rxc/1jiaXt1uUOUwHvI9L/hNKFBZT9HFjcDj4wSUhGoyjEKIuj3IT/jG
 A3HqY2VvrEmHISvAXxcHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606036; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:xtC3uFkyfkBVJa46SD3VFGTd+NWCUvAHaPNs4MRsqWCGEu3
 ISjQa6jyyeD3SVMzAx43LRLZ9E2PhUGoPV4Qjwh2Wr9NyacjzvfqLAr14tBFdigj
 jAdz2iH3zOz3XCHJa3CltRk+enGawcMtkW52otPeX5dhApBfcuHE3F6sm+xHy6Xe
 ie0jePq/ZYFAZfinrxG9WRVGtdOxGzEQOBvYXvGl+kZIFBX9F+xq8Gcww0kPi45p
 73HVtD6Bx2NgeEuIvwlYH2ZOdr4aFm6ahWxogcPtmqOST0NJehpyTvu7pNv8ekUG
 OGjXgchBk5X00o2SOenrOvdlTKgEdwXxZHZPWnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:h1cnQZZAGtVx0k9AvFOXtLtc3E2BQPQ4M+qFe8vzMco=:usxgSgzGhrFBLFKf59rZPY65tEtYQU7KRBgqNjIVLNc=;
X-ME-Sender: <xms:FMYGaxnqlbA204nX1pakkLplTQ9OLuHm-7YvoVSxijPgY00F0MHgbA>
 <xme:FMYGa8-jxGdCEyTLA8M1JEgn5TPxePnqeEiQbHV3oHB4YiDlq3pVIdeRU-S-xR9VS
 HbGKC_JF4zr6_JxWWfhpxhKwp-AXPb-A0LThe2-t_Pd6laKk6blkjw>
X-ME-Received: <xmr:FMYGa_nCjMzcQe6zalZH0SQr2rWJpvm-QHf2j-LZ3teYyGCk7frhWwuzVno2vJqMwmrCCvKt0B2Nen2u8ZuFrdI>
X-ME-Proxy-Cause: dmFkZTFlytzQmZA37XbINz9PeJYVumGeCiYXL+r57tmtutJE2E4fdLxmk7rTxkXUcAlQo8
 bixvwK+yjfeIeypV+CfCvpMQDpRXeOSHzHMb8yC0FnlAi8BALzcHgZEh7vyQtVBDaoS3qm
 nWLHR1XPCLy3sDe3oXGs49Qab5ARmOSBb9CYQRoOiLmdW7m2aUYT5yHkubKHRoR6DCwZob
 muUJQnU+zNHw+s9uBmlYbcrzi8u+VLn0mUs3JhwjGWmBR2ST2u4SUNKxtYrBUWd6Hd97HO
 p7g7mdlZkUVf9kknGGeGEwadHBY68j+Ytl1ZFvjOT9D6ztgepdllzOtj25MIv7inMvfnIB
 csoVEjBz2SQafJLbgdQ5412M56ozicpAUcCcvCPjbWCVK9mdDD+4oVG4JBJ2uGe86oYnFF
 vZHrGm5V9NajkHTj0mQVmxZB1HEb29P8lIX+CVW+WQPAx1/3V0WvzfnxdawG0NPHpRBDVx
 Xls++PSYgz9KkZExXW9FGjCn1gApplEncM/EV2SsMo7z+UD1u3nqifHUIoGxK+WvgK/H/o
 tkD4P/ncIkijQhFtJF721iqJJ3c0PLjuo9hQVzFa5BYIVG+yB4Ia+nJyQ86K0GlJ+wvwTo
 X2CGSlWNq7Zig6lRH9oiCZMc+LB6X5oSRO9lMNLBx+CShb0wWY8Srg0II8Qg
X-ME-Proxy: <xmx:FMYGa5161Z0Jp_F38dU6vrA_at9RD_Aw-Y9d7Io_dseCvWvwBbChZA>
 <xmx:FMYGa6pQtJwIjEJZRa9NuJct5oC3TgpOm6gb_PV-RO-y75ztH0FbUw>
 <xmx:FMYGa2ciF1tFMl6Y_nbBucjMNAJMM9iUUFzR-Vnxn3REwLeL9igDHA>
 <xmx:FMYGa5pl90dTkBic0_zSZrfZ7h0JazTTItG_xQyBmG7Ic799FMy8bg>
 <xmx:FMYGa4l0Ab4DRP1VsxLL7er6aEFMVHEOczZwjXoG7G1qxjcq9kmDruTe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:27:15 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yu Jiang <yux.jiang@intel.com>
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com, dev@dpdk.org
Subject: Re: [ 26.11 intel doc PATCH V1] doc: add tested Intel platforms with
 Intel NICs
Date: Wed, 25 Nov 2026 12:27:13 +0100
Message-ID: <09j8LqNuSwqWHGnm3vfyPQ@monjalon.net>
In-Reply-To: <20261123021534.1345651-1-yux.jiang@intel.com>
References: <20261123021534.1345651-1-yux.jiang@intel.com>
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

23/11/2026 03:15, Yu Jiang:
> Add tested Intel platforms with Intel NICs to v26.11 release note.
> 
> Signed-off-by: Yu Jiang <yux.jiang@intel.com>
[...]
> +    * Fedora Linux 43
> +    * Fedora Linux 44
> +    * FreeBSD 15.1
> +    * Microsoft Azure Linux 3.0
> +    * OpenAnolis OS 8.10
> +    * openEuler 24.03 (LTS-SP4)
> +    * Red Hat Enterprise Linux Server release 10
> +    * Red Hat Enterprise Linux Server release 10.2
> +    * Ubuntu 24.04.4 LTS
> +    * Ubuntu 26.04.1 LTS
> +    * Vmware Exsi 9.0

VMware ESXi

Applied with above fix, thanks.


