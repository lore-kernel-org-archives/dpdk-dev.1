Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33D606A896
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=Kfw3iRvY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TDfYy1kD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01F4240297;
	Wed, 11 Nov 2026 17:21:19 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 62DC14026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 17:21:17 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 5214BEC0217
 for <dev@dpdk.org>; Wed, 11 Nov 2026 11:21:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 11 Nov 2026 11:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794414076;
 x=1794500476; bh=vULeZjQj+Ot3QD/a8PWEDVn+HkITDtOnrzDwv7URBXs=; b=
 Kfw3iRvYTtv80YyeeygMzwVwhnA1IZMlR9Iay6WZV9OoNE7NJnAWXXXslimvmpL3
 Lhl9bXftqP8z6IjcNLAXcbEnrwc101GNkXev550700WKdsFDW2ZXgTRjsz3tWI+I
 28mbNIi/tJpp4BZ+JOqLcbungHsEsZWLf8zLqsLZ1AVBeW3Ip/H3LkrZeX6vPiiB
 eX+0VrdN7oiKiw5XCoQpT9pd863W4nYu71xmMqP2CNj6O3qUS65T+QzlyRfId5LU
 CG2MISmNE0vwEJic0cvFYQbMCEZnxoxWU7T0HDS1jL1mv/r4N9MAfWL2RZzfy7iH
 DDCzfVpcU2QsMExFUYkfjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794414076; x=
 1794500476; bh=vULeZjQj+Ot3QD/a8PWEDVn+HkITDtOnrzDwv7URBXs=; b=T
 DfYy1kD0Y7zsKZ1ODQwRDw+/sjs5kklWQx76Z+VaDUu0VXBhu4OfHBLD0KWGgScU
 sRZlbujTvGB30BoZo/7EpZ1KOgdZ+qBNK0CxhFviOllwN2BQr8O2qBu2qAZnOVF0
 khm9n+oSmh2foUlQVqUKPnuc35ZoIDD1q4dk3/DU0tiAAHwgoqEouUBnzswqx57u
 /sVnKnw3fguDhFVjLobWyR2z8oRUlPKhI/dy/PvMnXKMgdDdlk23wXGDW578Nf6x
 Q74tzIjmV7rIMY7iSOavSQkvgEmTqywVt10lkr/Z99TWxe/sO6EuEW25bQb33SCL
 DAIy5WfI8Hnics80MvrLQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794414076; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:sE0oaJQtP+0bzv7EChbRKXlSipCP7wRUl0EDopK6g3stSVq
 xfa/vKocmT/w5vG7+0Y6bMjbXGufGr9lFWhNa5D5VVK4vsI0TtTqjHkkLqfMuxvb
 rTyusQVNn3T9I8Tk2QF++0SjJ5mUiqsvLj02ewdzqt1bInRc5/mZya1TgOUzTt10
 z50VYMN6fgCUqFCk6HqGi0BMlIv5FMC56tn1ysrHO7L/5inuXFw8ifjLS9Fa+v+S
 g+lXr8dVnnJs75R7y1FsJiK88e97FY0M53Bu8e3Qmd2DgtmXTIIIUKqBGiGlfjv3
 tEjHci4HRoivM/ilbGZeAuoIhxwshweZV9KBy8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:rswwVVZ+RwRlVbEWS/1P1KM/tqQFtoI3Aj4FMV52QJw=:irkByyISP/aHw9QKjcAdpkWJY9G5hFXqd6CToEZdBdc=;
X-ME-Sender: <xms:-5X0ah0RE-0WneGAQgw0ToiOo7pte-9bdcRwJfIZdqwFkcl176lXbw>
 <xme:-5X0akFV8t_pJKkaQ8yONObpUlLucI6m6fdkkrUO31FgirrRuGgv79WVpdAdc_udT
 4v9tsJ5o-nsrXjTKYJMvsXqB-hJw5lySIFDl1yh-Cmm62qU1Rits5bj>
X-ME-Received: <xmr:-5X0akEDdos7whC3uKj-PINsm-pUbbRXOMJFzWigTb9qD1I-O8qCsXwKcH7Rs4dMCRX2h363ztIsGxkk0S2CIvE>
X-ME-Proxy-Cause: dmFkZTGJ+k+gYMgopogQ9G3oObJkAqRd4cb9gPxZKQ6NVQDb/8JsPLYLyMBj9/r8wJ5v/v
 EqB4c1ass3DRQB7Bsc/CCr7FJ92MvdTP5AMxxMitJ2xlnaU4o00Z1QE6c9vgHxIpe6zK3L
 30U7PHYtKS3vVNqqiiXs5eYt6pUtnP1G/Yeu7Ly3fgCCUroO2uesFiNRxAVF2GtDa9j8pY
 QKgz5fI/aNJprU+NxBkrBOaPC6GX91CQfMn6XvFRuF0fsZ9xnbO+Osjbp2h1dtx3VRCjqq
 Hc4T0g6ct7uwEvAl+ce1n5DNlbPt8qnUYXXeBs23p80b11mdfaotk0BX1AS11oMKiKDNVm
 O+4fZp1M8VxsSVe90JTLHy8gg60lO3sYGF4BjgWrTMUarAPoCnQcHjJrBoU4uB6EqUEjUW
 7eAVQDu3uHA/HCnwLMWOZc1Iz74VedP7TkWWz8+VO5kseH5a88mgdBDjziIEmFBk52m5XB
 nDCA0JjlTSuQsQTh3N/taB/BMNmC2DXD0c8R2NzhxvvOC+i/ShdyjCRVCDYjaFxfqSIt9D
 aeZa8edjGly0s1JCYc+j8Xx9hcNicn4OHeBAkYQgofndwjCXoNxrUK7cwlnFhZQHh3Iye8
 Q2TAQnLodnRZSZTmJK/INYEJeRD+skkqsz/YSJusj6a1/zKEWuRrj+3dhvCg
X-ME-Proxy: <xmx:-5X0av6oy_iuMITZxM7sojeqyl8e8tNKaKuVoXLF4mlHxkGm5EFYSQ>
 <xmx:-5X0ahz90H19BXDHn9wifdRSFnoCemXfVhYn2Ju3DBlUMxW1cbV-7g>
 <xmx:-5X0amOivwAUk20kub0xfOySBYTDgwLCNauXgT0zOumW2fURqWeuhw>
 <xmx:-5X0avlFQYy7NxcjjZ9dCfZRAghX41ac9JIVEjSPJE8eao6z7Q86mA>
 <xmx:_JX0ak1YXABY0Up6uKh70FAj00jiVh5uYOf8pkYqX99rarSr2p7fivxE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 11:21:14 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mohit Kumar Parjapat <mprajapat@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2] common/cnxk: use one interrupt handle per vector
Date: Wed, 11 Nov 2026 17:21:12 +0100
Message-ID: <9JuLD5ytQOWP1gyh2xevNQ@monjalon.net>
In-Reply-To: <20261110162000.768230-1-hkalra@marvell.com>
References: <20261110162000.768230-1-hkalra@marvell.com>
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

10/11/2026 17:20, Harman Kalra:
> From: Mohit Kumar Parjapat <mprajapat@marvell.com>
> 
> All MSI-X vectors were registered on pci_dev->intr_handle, rewriting
> its fd before each rte_intr_callback_register(). Since EAL references
> the caller's handle instead of a copy, all vectors share one interrupt
> source whose fd is read live, so only the last vector is polled.
> Mailbox replies are lost, probe times out, and the cleanup path leaves
> a closed fd in the source, making the interrupt thread panic in
> epoll_ctl().
> 
> Register each vector on its own handle, tracked in a list so that
> unregister uses and frees the same handle. Reject duplicate vector
> registration, close the vector's own eventfd on unregister, and unwind
> all error paths of plt_irq_register().
> 
> Fixes: c663018eb7f3 ("interrupts: do not duplicate interrupt handles")
> 
> Signed-off-by: Mohit Kumar Parjapat <mprajapat@marvell.com>
> Signed-off-by: Harman Kalra <hkalra@marvell.com>

Applied, thanks.



