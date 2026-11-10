Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4360A260A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=gszBGt43;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QqXgisAe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C989840285;
	Tue, 10 Nov 2026 15:16:07 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTPS id A286740281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:16:05 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 7CC321D00265
 for <dev@dpdk.org>; Tue, 10 Nov 2026 09:16:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 09:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794320163;
 x=1794406563; bh=O5+oPkPytW3cYgky7WegIVEYsM8O6ZKsdlFeL0wOGwI=; b=
 gszBGt43M4PCZxGQ7B1K+e+IUA67i2RsHupfJ7JEX9dqiAb1uxxtXrnxpPIV1SLZ
 oXOPo6FtIrHGUl2+zek7ZX5vBcrmR8KwrT+8FuF0e0YyskCg+VEhZmdNCcfvY2Ez
 3ODjhgHvDEvE/PjdKUAf1MqTzi5sRgSOW2bth+6+EiirMh5esN3jBDBulNbhEbte
 G8fsqeIk2YYNP+XXAzcIAufZqZR91ajiTH9uX8cUx/lqnu6ay50pFayWoqTXdrmb
 xQQtBctAPd65NeOf2DqswtNq0nWr8NmNeSfnPpIHGfCOI2ssBf4tAGTb9m1jG9dF
 AI6dmMcar5kONkUUEJYl+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794320163; x=
 1794406563; bh=O5+oPkPytW3cYgky7WegIVEYsM8O6ZKsdlFeL0wOGwI=; b=Q
 qXgisAeenymKdDCTLhSRkosp8kvt2L8PKnfpwSyxEAlKIVA6ASbrLh8YbGmtGLZP
 iOIPh6wO9fX5UgbHwte944KYEPgFOSHo5TUX9/yGwpCyEhAQONurAWBaER456a/J
 881iAbeeNaYdi2uhVh8JbjJTlY6ZOkZ7/XtHoNCa/EOmlxEIBOyhXYAoRS+Nor3j
 QWIPHxOpOT8ZkV3zN9IA6iHh6u/TVptJMz92+76bqulqpCtYIGdoTjZmwlGtYqvU
 TxWmg9jrRy4NFp7tgRYWqSK7rkqDKRrbpT5MDdF+KJFengHdw3rBIFLOaQ3PWca1
 vKlLBjncb7GEJbMn+Sj0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794320163; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:m6eF5ihLr7KYoFNbT0mpBa/BmHkT7mW4+coTXJ2WtkEFGya
 HqPHxblQtHEkvkETxw4uCJs4AfxMgfPMW/wqUoFKXkuD428U/IVLKYYa9yZqiGsm
 rtAQzbk4UOsGMmqQU9c8W0onylZrktj3F0bMkrqoqSt8NflLkHhfttZ18SeMrJOO
 DT0MfiRl2vb0pufmaAz9RmUqR4VBBdHBLJ9jtg6EOHEaP927pkCY7Wi/95ewUTJq
 5sUk7x2lkjPkbhX6gBZ1U7O9G5MQ74f0mD1fYbxJJRKnuRzQA85mLNybOSLMK9ES
 mKznztOSIaTZIU7SvEb6hQIPeTiHD9480X6vzKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:BRHOdGiuAX5kYwwnw+5bk+S7uI/wlJGHtgQSaxZEmJE=:Hp4nxzNPiNolqJmXOrf0L6m+yitl2Cgq8SogJ20O0Ks=;
X-ME-Sender: <xms:Iyfzam4oNhihevKs_r-hqVGS__jbRSrZKERkibRuLLLLRLfpY3-MKg>
 <xme:Iyfzao1kxqSOXqPG3pg5jFRxDcNR9R4KOl87mkqpJk9G7oYEasEykNnqXlCXqZEZM
 OPFV4GjyUCl1M5Cp80l9xc0QhDtysD22tR0jr6rFkfstxTgXhLDojQ>
X-ME-Received: <xmr:IyfzahDGBLVhCyEg61Z_eLIPL8toIAv6DhUySvhIlb3YaZqbj_HJ854sZ1br9-j79cH55FYZTeLD3dLAqGzgmnQ>
X-ME-Proxy-Cause: dmFkZTGzVU3tPvULvqaQy7IE1HEXASg3Aj14f3hqTo7DOzfjM7PReYZaQN1arlYOnSaYsG
 OCHUeqKuuhsuTN+Nqg9j4G29muRv2T6sYZRdrxgLGFlcrHPXUKXZWoA6btYPXZzjorHb1o
 lsM4CVlaXGJZPPOyuVUUGk487wuKBjPgxNAFfttZHDl9xDXiGeUSkOaOOUy5Wu7Gg7NYqQ
 Fjuq/aUUJD3JIYT4TSUszR+gZmq8Z0C6lP/goyaok5KaNM6WpUq6HPPRKOJ/tX5gzae2y7
 xmAtHLiXzgFGxO4hnY2Y3NQWsfxoCsWsHhS8uj+EDIi6da7u7LzoZcHw1OAN3aJ8kd4cnB
 in08oEYub+2t2/AHUC2WVXcg+8wP6QGdKwn1QIwFwtxSPzaA+yLPQtcyn9z2hF1NUCJw3y
 DQVPQeW3Z2fmglmI1cuoK8JLz5WvuzPXOkIA1TaWRxUNFhH+t178VRatPhpZtW9O4XMbXL
 8G90Rm2y2D4cQbl/WHkUs0IEr83R552WALUfdBYcX1yZsvT+kjGJJSVjVgdIoSlOMAlvr5
 p//x/L+ICs89LzQvAwuRBOeufuI6vGKg79ruVuniVl+YhG5+hvX9sSZmrkfCGENun/Sh6n
 Bbqdyfk1WPyFCo9eD8BGO4KXX8+TfgGHAv9PV+ZsKEwSjWNzbui/he+qwNfQ
X-ME-Proxy: <xmx:IyfzajP2K8uosiG0FwdnDOWli6E6HFfR60HJsuXDIHgkvTH_AU5xUg>
 <xmx:IyfzamYAsXqY4_AfSZfkT1L8LVgc1lwr7ZCcscOwDrXyasammUfSXw>
 <xmx:Iyfzais_rvk88zhkQSkt_IWSnPZQjP3FEw8RiScYla4Suvr0Tb37BA>
 <xmx:IyfzaoNWC8iraXem1cEQp1n4JuoqYxqtKDl5onjokMynj4Mfccaorw>
 <xmx:IyfzaoaW22V3pIyjsnWLz1C9repHOI1hQZnGewUEpMPYZ2VEKhoXm_p5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 09:16:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Harman Kalra <hkalra@marvell.com>
Cc: jerinj@marvell.com, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: Re: [PATCH v2] config/arm: add Marvell CN20k
Date: Tue, 10 Nov 2026 15:16:00 +0100
Message-ID: <i9tqF1fNRBe2oSp9wundkw@monjalon.net>
In-Reply-To: <20261102160124.64412-1-pbhagavatula@marvell.com>
References: <20261102155754.63324-1-pbhagavatula@marvell.com>
 <20261102160124.64412-1-pbhagavatula@marvell.com>
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

02/11/2026 17:01, pbhagavatula@marvell.com:
> From: Harman Kalra <hkalra@marvell.com>
> 
> Add config support to cross compile for Marvell CN20k SoC.
> Marvell CN20k SoC is based on ARM Neoverse N3 cores.
> 
> Signed-off-by: Harman Kalra <hkalra@marvell.com>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied after sorting.



