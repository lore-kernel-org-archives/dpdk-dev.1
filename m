Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BB606B388
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=3MgdEb/W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aH6kLsEK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 424A3402B2;
	Wed, 25 Nov 2026 16:43:12 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTPS id D46B940274
 for <dev@dpdk.org>; Wed, 25 Nov 2026 16:43:10 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id BACA8EC0C2B
 for <dev@dpdk.org>; Wed, 25 Nov 2026 10:43:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 25 Nov 2026 10:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795621389;
 x=1795707789; bh=iPPqjdpe7mzUGwrUNiPIooaHDGVeihjhzJc4r/XTxTk=; b=
 3MgdEb/WOanLoZZ8O1bHk7iXKKDJO3JQlYDniuMemrN9kDgFTbtAKRWstK3pCgdl
 CBlgJyySaIhqgwymzEXS5xftQhOXa2d8LtVrHEJuDlc4S7inxStSEm5RRuAHEUQT
 s28OEMd8Oc+CBDVyFiihO2qdTNDym7uXOoxkvCiZ96i+BKBE4iZ4JzwZ6Q9G0oil
 kPGmmM9rkt6XUgtgBEmJoLJERldUnExa6gd6J18QaIwxN22EED8+/1jP7eSJB/Wi
 FRV8gTp/pGE052EUE51vKxrgCdd93CD3pon0WR7Okr2/wTy1ng0Egi7cDoS5Wpcd
 enmB81V3Xsr8RPqdIPJ+jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795621389; x=
 1795707789; bh=iPPqjdpe7mzUGwrUNiPIooaHDGVeihjhzJc4r/XTxTk=; b=a
 H6kLsEKRrvliIYlldmuuyScUr1tkVur9EsVheZbqJEZuvZPQUmZUcDIfPdgA9OU/
 cdOLFrQWaRUaxmInxS6XXW8X8dChVfPSDpPvEr3G6HpRFMS4um0k9EJ16e2XzXWQ
 VGeHfH3aEfeuow3BH1ehth/4zkjyf/545H4dey8xxZJjkHz0sc+n4PWVoglv8O+e
 7Jsn3qQFXIZrQuO/nj4gaWUgzYBdHvGhGNenkjiVxTt+urNBmMjml9QkGxWVpGdK
 Ftop75sgEaOy/ChLAPFf92a8AsJwGb8XGucrpYWsgYYf35EsUrmQuDPKqNZXiKoQ
 VXxp/0cPtgrSbIhf74RyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795621389; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:dU8/1pa8disQ1L4DI3U+4ynm0ZbvtbJlXIDg9Dhwo9uFpBD
 Qr/Ao07xi+e+HXQSNGaRY9/C8ENghgVcO7fmVk/4ccAEZMMBLg+WsCMOWtz/qp8b
 AxU69MRoPkTJhxVHuALrIsakmuxqpMIRa4HpgTMhpgJw4PCemdThqQv9HG1r86zG
 rT4Fn8GnMgPFmPNgQ4qRIpW5tb4W0QsEewVFc6fj0FR9Kt0B02YMd5OcRm17a/+e
 LVB+TLopPt0V6kb+jm9KktCRXQnmgirRNm3pbP8YFoLDLimCgDJd2nHFQGxUUkxI
 fZ8Jgnv5cxsq5NMRaDrlDpz2CRT+kOpqer/KMSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:P3g4SKra7L9Gdp0WS2/SdrrYkVLSwCRyQo12ffIJaxE=:kBpjeAfwqhjMyRIcYJQVQh7Z9hzo6C2wOUlKPE6/Jqk=;
X-ME-Sender: <xms:DQIHa7nbYP8wR1JmMrbezgLcuFPcOxQrzbPK9YYywBowminfafBjLQ>
 <xme:DQIHazKvyVsVQjf2vCozjzVoC6QUMRHc3B3wkDd_7fx5Nvc6lmpuPe0hE7K41wdqr
 5HStDGYOqpJcMTi-jJ6x_Ptbmb96ql93U-KsMqquszoqQoGheRVcQ>
X-ME-Received: <xmr:DQIHaww38wEAUhzWjTMnICYFqUzcoFxcMmXVmMcEMatWdIWhn7Udi4I7Jii8o_QWAZV80vHV9GnbPtRTAiO2tQs>
X-ME-Proxy-Cause: dmFkZTFaLIAG+Wi2pnwEah5ROEp0q+nYmg1/m7T6ogn1c8NnCpj/aAT7HvT5UFNRR2nM+1
 i8wbSmW0FCGfq3IdjKKvART7M4iTDBfCjUSJh1ZCN9nwM97KTJd1hxra5KZeWFJ3F6FqKU
 06Q9/Kbq+pbny0qpQ+/1yZk7RyKFe63qrs6XNwxORmA0dr/Kelj3dQqQS0/Z/X+1Hoej/F
 ScRG5/3/RdGxYJwgGGdZmgu/1kxF0YBifi5tEkpHC6EBCChL5Ymb82Axzqry3H02Y6lQJv
 YccsqJoYq8Ce6al/1FrDo16BU668h0urqzqCmgswDlQXUqYbbjch02zkxcsXVJw3zt1/nx
 k7q7OITBMOmZ5RQmKugowAXm+qgTYC9w6bFlEIfzhDfdToAhjaZp6RjwsQV5fdiY8YNKjL
 udBP3Vm1AYtlxCof6o+rJ1DwJtrHqq48tjmU0tGTE1eo/z34U7PfRwmsEVwq5eEpDYkvs8
 1uWmzoflX554zL1TcWj2daK32HbLjUSe5waZvuPxmRkxir1vuAngDm8sAmBgDRC6OADl9S
 qhwvXh24khUG8s71705aWqchbrn43KvmIh5Jt8C7ImC8HEq8oqM/fVEiTEXvHf8ftoJEGQ
 UNSN4XLCWgKae33c7EmUuV5KsywR2iNKqJxLzdfrk5RCC0VozU+T6tn+IZgg
X-ME-Proxy: <xmx:DQIHa7sv5TANbW6cHNh_KkfWMvKf8LQUyCFGUGkubEmTLNodlOMCIw>
 <xmx:DQIHa_tcWRntWCkAqfQ0EN-2h9CCcV4U5z76upiHmsOzoA_u1W0vhA>
 <xmx:DQIHa4OcxF6AHJU6jh_-FF7CjsBQyp1spJVkmDI0Ov_L0QbjZqMj9w>
 <xmx:DQIHa13ReUuovDq1rAKiQzh1SUFmbZd25XN8Z0ONYiMUP6OE2mBgCQ>
 <xmx:DQIHaz_fPuuV9QRHHiL9G5x4xBCAgRUKAKc3W2c-R_qfNNrn4k9Jq1mc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 10:43:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v4 7/7] doc: add missing headers to doxy-api-index.md
Date: Wed, 25 Nov 2026 16:43:07 +0100
Message-ID: <0s9ScXdJQn-lIOVNYbtG-A@monjalon.net>
In-Reply-To: <5vPKTCp5Sn66gfsbe2E_FQ@monjalon.net>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-8-marat.khalili@huawei.com>
 <5vPKTCp5Sn66gfsbe2E_FQ@monjalon.net>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

25/11/2026 16:32, Thomas Monjalon:
> 21/07/2026 16:58, Marat Khalili:
> > Make sure all public headers are listed in `doxy-api-index.md` to be
> > reachable in HTML version. Presumably each of them should contain at
> > least a general file description, though this is not checked now.
> 
> I'm not sure having an index of all header files is convenient in this format.
> Doxygen offers a tree structure to navigate through them.
> I suggest we simplify this page to become an index of main entries only.

Also, before adding an entry in this index,
we must make sure there is documentation generated for it.
For example, rte_net.h does not have the required format to generate a page.



