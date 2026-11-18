Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24128606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=RybWa1+9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D+5cKYrO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E369340298;
	Wed, 18 Nov 2026 23:29:42 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTPS id 9B0BC4003C
 for <dev@dpdk.org>; Wed, 18 Nov 2026 23:29:41 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 7D7151D00279
 for <dev@dpdk.org>; Wed, 18 Nov 2026 17:29:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 17:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795040980;
 x=1795127380; bh=/axGRbLXkpGTcUjdHcVY4TRx228z+jc/atYOvnMMbsc=; b=
 RybWa1+9K484dV+Znfl4jDgOTIwvdV02iRYjRJHmuEvaKNKrY05NQUYDHXtUmv3z
 dak/9bu01GruncD/15dC9KgBgSGCcq2FaGoNzScAA5gbVOIfWS3/2nmJLHmq8lBu
 Er2EmlOQrt7wwM2vm/qfk5KgGZLgri2xhqEWYTKbGCGyCbxIdIqg5kfZygsWPyZt
 1xjGDCRl4nSr3bn00Jf3ImDweaBysUCoA9yCKWXmPlCFbUd17dT1Lcz2JDAj6pdQ
 OtViz/cXpAVCuGHWXrq1smFLO+Mjx4U6QfDIJXCWrpLGpGYJHB/Omgb9yeA4RUqo
 iSUjFYgQDIlB1IRuWpWH+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795040980; x=
 1795127380; bh=/axGRbLXkpGTcUjdHcVY4TRx228z+jc/atYOvnMMbsc=; b=D
 +5cKYrOfD8I0N1S3MCQDRlpxEpR8RZ4877C/0gOjelOQ8L6jXy9RhBq5NjTYd7je
 pBQKlCZ4dv2dfug3fiW1binnHoRokzXKeMiH6YEb3vwdFWD9ZJViehthXb2ClbSJ
 Te2BKG+qVyLpmv6t/W+mTEL/V6bdrGQrvRMUG+xExWPnRRTyRoaQcrLQKh23kodW
 zolt+sbAO9uwmVgf78z9Q+vToejDhYU1GEKpGdRdZfRbjuwrs3ts1p4WPaXGZVvA
 PGGrxJn2RSiITJyhz98JQe28tnmd75yqeV4vwQm6dFkO61kXqZnOvFQGOX9nZXcY
 nnDI2xFcuZgZ9sgejUEnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795040980; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:ubDnWxgK3kw0dX1fexp91foTUR91fsWGKXM3es/C9ZVX3Lu
 xmKLMeytTc+qjAEuEn0pY207T2/CWlXGFD46XCPEwMb8HuXXipSd5jPQBu7AOe20
 R9sIxkLhABTliTOedRyV9BntXwwZlVi1fqFasJEDNzyqTI/IO94uIu0Cqm+EsHM4
 os6vPK9tFnp2iwO8dfyJbxPLXwX+slaS+bDA2aLFLnNZ6rf59oRzJAZuMmM16TEL
 uj61NvI8ZoaCl4cKmK0xuGs8ayikNTZgkYgWsbHKob63cmfQtRp9KRl8ovKelcL/
 GGtXYh//RK6AJp9jpxOXYKtqaVa/KBCa0Cm6O+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:1yLtfcoTJ5T1ZH1XyGgoc83umGvIGRqRZHiSn4ftmRU=:GjFwHyIZ9tkJoMzG7q3oJa+9S1Z34ZoMrfkhma3f++U=;
X-ME-Sender: <xms:0yb-avejge2Axsvmk64DHg9Q7VqyJKuOpRzJSX2O_OtEMGkKZKs0qg>
 <xme:0yb-agoIzUECYez_S-dkbsMJX4-xW-sm91iEHu_vz5SwLrukRnIU3pCvZuDVHHGkk
 myRznWBNiubTz8N36hMKJmC3TECSXtBOMQFzf6hSEhgdAYvyiGa_4U>
X-ME-Received: <xmr:0yb-asB7qNYPJIzBVQSwSKK4V34qZ5j_5jo_YnEuMyXaGrmBo84X8dsn26JnuaXdEUy0jEUf4_E8KROeTOVEciQ>
X-ME-Proxy-Cause: dmFkZTEcuKG1p6eRPz/+HbZ3IUXKEcLciqZNfA1LzvmEWX+1DtM7kRcxvqVCRX1EVPPxng
 62YJ1QCkH9X6AdPMYTiYOrG+cj8lWhLz0Gv2SXyI3c1XsuIPZv4rL4+ydJyjPcXiGVuqHH
 gM26BaOOTNvyZiiZ4hekY1KCM1S8RKX6bF0XBwJ9F0Add+W86/uBTNrv4gBtDeHaGO1zwj
 0U6ogWMQ41B+a3loB4RasV/YpU+1lFd8tDeMIVIV8oeo1w1kEfdCjl9O/qUuJQtiLtTYhB
 EZybatE9VP+BF2wZOeoBxZbo7NHHEX7FURmf/XhUxX2WI1AgJ2GRLgV9eqN2iJS21fkNDx
 WdCCBs357InJqZKo4AkEAN64O+gWSGUbQkboE5kYHIKqGhmx3ODYzdXYAlZCM9wm8MO08A
 PpBti++MoLY43dsSG29HZwppbB0AkINnuu7dqHyQY71TXAmPf+b0PtD1Y1rn4IBBYyYeGw
 cYkuqgf2tCc1DNybQboiZV5/86WdTN4yFnbK3X9DmvoiXtWPQLnx5oTRYZc1p88nECO9eP
 BDwwEknRdhe/zE9qXZ82HJYk9WSXex54bxrQQwnljV11HKqKqTKLU5LSJkXVtgnfkqvBZh
 Tlgu2i1RJkdZjRYyFPfF0nptw1bQENZU/m5AcYnWs3V9kydiEmxJUID/aI2g
X-ME-Proxy: <xmx:0yb-alYXGHVIhNLN6YzBBvHsntpeZL542TKpQ4Zr9kc-G4ml4VIkBw>
 <xmx:0yb-an7GkzoKSSb9Lnr0X6kblHDT507BVCcxXUeCfKOa-yoRIod0cw>
 <xmx:0yb-aubhCXu_LN8m2Q8b6nzdvuju7zS4e4VVvlfEWwy19Rtycv3GMA>
 <xmx:0yb-auiPRy2WrJ0_etTo_EJsyyPichrvu6FVIPx_Lj-2fFDeSLabIg>
 <xmx:1Cb-av1nd5I6vInOyiooqIZoz_T_2-xtKgjiOvx8yZ1bNn3U1Dz2z9Rd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:29:38 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 1/3] mempool: remove assumptions on maximum cache size
Date: Wed, 18 Nov 2026 23:29:36 +0100
Message-ID: <iVmiXEBnRaubdV3WtX4xQQ@monjalon.net>
In-Reply-To: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
References: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
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

13/11/2026 20:44, Kishore Padmanabha:
> Since the cache size limit was removed, a mempool cache can be created
> with any size up to the number of objects in the mempool.
> RTE_MEMPOOL_CACHE_MAX_SIZE is therefore no longer an upper bound for
> the cache size, nor for the number of objects in the cache.
> 
> The put and get functions still passed assumptions derived from this
> constant to the compiler. They are wrong for a cache larger than
> RTE_MEMPOOL_CACHE_MAX_SIZE, and violating a compiler assumption is
> undefined behavior.
> 
> Remove the assumptions based on the constant, and assume that the number
> of objects in the cache does not exceed the cache size instead.
> 
> Fixes: b815acfdfc48 ("mempool: remove cache size limit")
> Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> Reviewed-by: Morten Brorup <mb@smartsharesystems.com>

Series applied, thanks.



