Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CE606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=PolQwCyg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PbKGIpLW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2FD415D7;
	Thu, 12 Nov 2026 17:54:39 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTPS id D888840E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 17:54:37 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 17D79EC0067
 for <dev@dpdk.org>; Thu, 12 Nov 2026 11:54:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 11:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794502477;
 x=1794588877; bh=qOtFm1cKo41L48mfprYWWbv2MSwPc/phjQeW8EjSECA=; b=
 PolQwCyg/DNkIEXrrMBo2jVVmcFUyyNM6drn99z9BASpBcpXbN08nNNOPXorfSzE
 nyCoG29zwAQfXouRolWOU9wyzQ4DxkqLdbvFl+Wx6tk0+GC3eeh7VeE8lfpgiP18
 d5wj36z3LLE/PWrmikvw5OQE/9GK+nbtLbHhZX7Ya6LZUmt0UHKADmFLrSsiRhkU
 Ixd3JfBcwiuoAWhDMkw3PbK2mxq4bsar22Vi744eDq6iZ2iHaWT+7UB0gEV0PdNr
 rDLWoXQcWd34r47sakdcs1EnjGXRiphdB2SHTy57OX2I3XDUpSDpSDyXbWn4lVIt
 p/OlQKrohKZMhrICgzjIQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794502477; x=
 1794588877; bh=qOtFm1cKo41L48mfprYWWbv2MSwPc/phjQeW8EjSECA=; b=P
 bKGIpLW/gx7QC/Ktt4sZ3MtkeZWyYdsUNsyKFBNFJP2IKjXISUUH2bpOtDHVuSiZ
 stG0PtKr4QNpQmTCsfbASu6pr4r8qD8Ie4l79lAE2ZJ1UIpEMQm4zh53IS51LU0C
 v17ieMQ+Ht4QzzgzL1S5ZaUbQjeDlz1oCL6byuvQQuEk5beRin89rhzUavlA2BEP
 y6MmpP2MM84nXkgmsAkAdjvKAXFI/lCjaky6F7QQ6uoLXFF0hox7u8C712TqVTYM
 BnbTbhGoJ44CN3z1Icpth5y+jf0IP8Y+pp4KKVUvBG7ZHymzOy+A3IrV9BPnPBXv
 ARfu8cCc5uooVJqB2PFMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794502477; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:JFvpwuNHYfPKlNlK43mFURcoq8N4UI31qovufndESUtVyzE
 gDwyw6snxP5obup0Xw0jAKrpGEf54R9WuFbBjvrGwsLmgSz6R2Gva8GJgxuWTZcy
 iti5E4+5MEbLD83e9UjUnomnqL0geK14nvxfyHklGIM2NY8s6oFUIUko/FDGrLDB
 Xs3O0RXvL1pja6gjIFaU71aQ9V+1+uZkl5tUKadLxU/8szspfxyyCfmcnPmqtxOh
 WWncGwea45KDd6ptubNnR9wLcHwzcT9r/wzClIv7+z6IvT6RSTBV5O3ws+5Vw/gI
 skUMhJ4kyf8D4FEoVtFXnJhEGXnNHZ0GuRsANfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ucKGU0xdTgBYVfB4prqLHmOtoXEhHHY00sQaNEi3To8=:6mSt/EobBYwEMOBXUeUFF/VCTgirnuzPVN4a1FZyTjo=;
X-ME-Sender: <xms:TO_1apXGYmo-_W5-vw-1rz0PosU_-WnGX3ObMUAYeg_wSEZsNwHrSw>
 <xme:TO_1ajrLIaTOBLFy8j40QRbyainYS5JbuXjouIMCgisGt4hB8FwlCwEJEQMozbcpK
 HNHfQgQ-3V4S-Pn0E8qkjRqJjBkr1WOdS5NiaSg8eaE_le8J4l21Q>
X-ME-Received: <xmr:TO_1alT_S1hGFpTCYbXSy78qDqCKelYWkj5WhAmy6FjDXynRCvqGryD-InRowCmLJIICVwFgo8KtQ-z02k2kDN8>
X-ME-Proxy-Cause: dmFkZTGnRF+4bRcHL/BJFGiKENMNTINUdy7K/1oZuBip5NquaYJ9q+LRSSZOq45KLtuZO+
 JIP/hX3cqGi0qDlg3vr2rpq9xdv+eXFtGLaBCPOvoJH1XcUFjsNv3JNkc+HvgEsJ1nZGt0
 NAySeXehYXbSmnbh4ZgrpNNGUH4UIeHVOz5SaOahitKS7t9CUj2nkCJWK0SPihQ6TcnkqG
 LKTognfaqalvRdpBsb8z0S1LHE80KonldBUingKkauDwV6ETIaUdmKsGk+xxecAwrTaT26
 n6+pW94Pw2Fc8YUfIftUV8gyL9s5l8SC2Z+StY5MYwVV3RVNNghuRvqeaLlZ6qLEKOxqod
 QHxu5du6zqcZaN9POrmc6rE/WRZwvcsErr8U47eBiwrda+g018Vvp5fmcxdjP5mzkISUjz
 3zsM+d5yfo6s6IuEZ7mNr1pwG/uU6iMnsyCZfQug5IIr9JMpg2Gehwrq30pZ7kJ/4YF/Rf
 OpeZ0oGhmUgzYYLYhHivv/fKryr02LIRioHMQ5SrcTiFIO6OA8PmhP1v+nKXMI3OWn0tt/
 tmvbVI9MD3TLa4781qphIfXgq7q2eLFSnIKCKIQqOA9+t4wbhg0j5UVU6T5qzR+SXrmsVM
 WnG63C8UBTr+G8cB43Oo0fXwt/m1x5v08BMeTW1Jc7aFVmTaI4O4zuzs5q1w
X-ME-Proxy: <xmx:TO_1at0pmqchYjDJJclYqOh7854QDgDgvFM5F5Bulr7QMEPBFn0BDQ>
 <xmx:TO_1ahAfia_uN5nLLCOPU63mUl5dqafI7efAQ5mcTVFApVxyuPqy8w>
 <xmx:TO_1api38-a5k81zLtB9fT2VYGYVtBX75eJ5hO1KRAQGwWbr4oQaPw>
 <xmx:TO_1ajNKFoWHha14N-rtzByCVh-_Y1CMUsVJM5YRQOuQyqTQxCKPTw>
 <xmx:Te_1au39lolnTmBxf9ZAkg4gze2SD3xB2JaJDJ9Wmvmr4iZYYw4B4YWb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 11:54:35 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, jerinj@marvell.com,
 ndabilpuram@marvell.com, rbhansali@marvell.com, stable@dpdk.org
Subject: Re: [PATCH v2] mem: fix fbarray placement colliding with PCI BARs
Date: Thu, 12 Nov 2026 17:54:34 +0100
Message-ID: <ddamo9BMSNyciouUA8Rprg@monjalon.net>
In-Reply-To: <20261027052151.1416368-1-ajp@marvell.com>
References: <20261023060523.978899-1-ajp@marvell.com>
 <20261027052151.1416368-1-ajp@marvell.com>
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

27/10/2026 06:21, Aarnav JP:
> Since the VA space of all memseg lists is reserved in one go, it is
> reserved before the memseg lists are created. The fbarray of each list
> is allocated from the same VA allocator, so the first fbarray now ends
> up right after the end of the memseg lists.
> 
> On Linux, the PCI bus maps device BARs in the primary process starting
> at the end of the memseg lists (pci_find_max_end_va()), using it as an
> address hint. This address is now taken by the fbarray, so the hint is
> not honored and the kernel places the first BAR elsewhere in the mmap
> area, among the shared libraries and thread stacks.
> 
> With VFIO, secondary processes map BARs at the addresses chosen by the
> primary process, using MAP_FIXED, which replaces any existing mapping.
> As the mmap area layout is randomized for each process (ASLR), the BAR
> can overlap the libraries or stacks of the secondary process, which are
> then replaced. This intermittently crashes secondary processes during
> EAL init, for example dpdk-proc-info. On arm64 with 64K pages, this
> was seen in about one in ten secondary process starts.
> 
> Create the memseg lists before reserving the VA space, so that, as
> before that change, nothing is mapped right after the memseg lists and
> the BARs can be placed there again. The VA space is still reserved in
> one go.
> 
> Also destroy the memseg lists created so far if a later step fails,
> since their fbarrays now exist before the VA space is reserved.
> 
> Fixes: 3368bc8600e8 ("mem: allocate all VA space in one go")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Aarnav JP <ajp@marvell.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.



