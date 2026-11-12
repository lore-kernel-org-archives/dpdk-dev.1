Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891A60A261D
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=uMw6wDBm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XmE/nhvX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E0BE42DC1;
	Thu, 12 Nov 2026 22:24:00 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 3387042D7B
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:23:59 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 371091D00644
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:23:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Thu, 12 Nov 2026 16:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794518637;
 x=1794605037; bh=FqvH/fbWO/VvA3Xz+N1H9mdJjQStmV6unZXndIsXYRs=; b=
 uMw6wDBmq9/5O7ZbtmzLObNhck8u5gOMo+dX0cffU59TxZ3TumbsDEJS7hViClGy
 7iWzu0+hTnZfE9vmfX8FpRnLgKCvp64CF1r4XSHakBQFPI0PWu8W0NX/y46ldfH2
 /J/2gtcjGLqMorqXSH4saD0MJUrUUc5gdhWWsURB7vITcrtO1CGNyTFimmeCXpPH
 mYhHlIiGPQSnD8AJd5U+yCruNOjFarHySc5YSrvbPoBn7WZcbNk994nSdrKi+wr0
 MMPddGL5beHRN6sQo9VoJ6ygiXBWIY2J7UgWeTFecwvp87p643gb1Bz6phT97LjW
 JY6q4BiRo2hPl9MTjLevdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794518637; x=
 1794605037; bh=FqvH/fbWO/VvA3Xz+N1H9mdJjQStmV6unZXndIsXYRs=; b=X
 mE/nhvXrMS9xqTww0o8Szp+65S2796zILVEWR1v6cAEeKnxvw/LyKi2kHRhKmoOs
 0uIVy/MtoC/LiZXjOR23fqK8/OKZ8S8ov+1eTSL+RC+XUWOu7/Q06F3Gg/ANQP5b
 hFd4cVHNe3UjV3s2YxtXrFj72j2iLeuTjyyDHkz/pv7RNaMFDXIEGxYa5ixHPvce
 aLmzZbWSCZ0Oy+0BJr+T4eCdd6et2wsUgU7SyY+UCK+XmbTgczzW+PZla6ALJnl2
 dDPAhtvm5tqA2eONeegn8UFxziOItaUQ3aOifhqj1L2JxaK+YGUvkJTQyNvCYzLi
 zaeZdWzxOBXjTclE5jIAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794518637; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:ZoeG0XJ3w0VxKfNIf/4hL0FyovdcywsjueZlGRj75em7hw5
 ZulXZuGoR/eBQest89E/yVGiwKnsdIrrOTmoQEZHKwIZjFp6KnFamQInyZIdFRkN
 0Hr8WlJ4JseU/TA0WI6VTUZFc9NbVVjPQlJrvJtCevIjLrF+Ixv/3UTLs/ErMh13
 6qDL6Xei+QmbQoSYxlscsLVLvukFnC2lkZfswwb3oLcRmAGfFdQk/JvIO38zE/qm
 033ceBgW4M/35lXDK09r5kgdHEgmboqKuiLSKKYVCDdhYQweC+DRyfF0yCm58DWz
 47p69skpr71YsvNArwKw7y3gDJw6DMyFicl5ywg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ZNTxMPw2VeEWabZHW/xQUee/VEa3bQW2+Y4kChvogOA=:P4NDNgqLGpZK37x0KUAqWk78UYISSpxPvtpgrPZw8Rc=;
X-ME-Sender: <xms:bS72ahpyFsx5BVMr5xU80qldpTd239LU-5nA-lAvw3_UpQuIB4mdtw>
 <xme:bS72aslKBtDmRXA23mTOduViBUrL8nXS5bC21JCbpCtjIhOg7AYmchc0mbZoYLNbz
 Q0sPpGHK7e5zaXhpW-Xs74DNkBeeD4fx0HOsu265CC5rVDIDB_06l4>
X-ME-Received: <xmr:bS72apy1Y8-agA6cyL_zcaqdkEc3cl5H-TFw_vTdh830u26wGZH8lP5ZrYppRX37D6yUt_uhJvk0NDXlR3qNKA8>
X-ME-Proxy-Cause: dmFkZTGJ0gL/VxvTa/t4LONMGzwZvrcmoGM4SiocGUkltSrKGwalDNwHYzo7udYcX9OR+L
 nfZqbnKyoqRZuzkPOcDW6xQxxD9BM+2CYh4mB8D80dbewso+uvqzuod0NTxghD2yUSeJ+8
 r9PbJeuFM4/7ooIyAgrNnyy8PWdRFiTP3YwOI7SVyQ55odWTM+MYXzHdwJM9hs/ANUVGCu
 sAsP4gYAHuiq9BNf8H4XsyumbBmWIScvUf0QT24zeLLmyknWLUMSYvQiQvouCvh0yuEdZ3
 8V+KBhKbzOcG/2VHhhAkRco7eYsuPgAMU5y+7cyyXWuqFhsobUJyNnhkBO59+6ifV3gpZl
 U0aNGjZm7Dvra6pXN38YKHhba7SBnyO342HUIw4obvZyaM2sWz60RibUPFIhGietTWZx9q
 u31TSy8BnN9/eZI+jPv4QRmb9XQYLeR4IgoJ1Tj/uFVabxEqhz/EUOkFPqkVbrN0wEK0u9
 5KfUPm1b+8ZN8iZqvxYMS4Ug/WUX5T0ePdqhiL1Xe3nhN2NfefagrcxlDp//gPIuA6OdAu
 TD8G3N1No4RlJkz6qsUQa4d04/VYpz0fj8XJ2MSyOM8h4AIo/IHyxErzUy1ORddiD65aTu
 wj/kBUIDY0kKK4INTMtdw4J20peKBv9y8Yf9KILMdsl3rW4lL2SGahvOXb3A
X-ME-Proxy: <xmx:bS72as-8340Sbu8G-wa1Mmr6yNXMLf-5ehb79Ckj59mas9AvhG9G4Q>
 <xmx:bS72atK4fEXUn2em2_2sY0g6mMb4ExZnM-b5pTnN19bA1602u9_xfA>
 <xmx:bS72aifNrAWxNkHO0yrDvj0VK12R6oz0ayEtrMIUQMEKnX04y4wxQA>
 <xmx:bS72as8yTgM3eiF1kAi7tQ7ZtGmdhQ7Z0YkwBH6aUXVt-UrOhNSxVA>
 <xmx:bS72amN2kwxgrpGlk4ptEAx84Cq4a8wR6DegBL_8Ar_5fkbv2le2eRMh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:23:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrei-Niculae Petre <p31andrei@gmail.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Sean Morrissey <sean.morrissey@intel.com>, stable@dpdk.org
Subject: Re: [PATCH v3] examples/l3fwd: fix compilation when DP debug on
Date: Thu, 12 Nov 2026 22:23:54 +0100
Message-ID: <h2Pe81DMT4Wbag_ICm5Ztg@monjalon.net>
In-Reply-To: <20261107221707.20990-1-p31andrei@gmail.com>
References: <20260414025137.91776-1-p31andrei@gmail.com>
 <20261107221707.20990-1-p31andrei@gmail.com>
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

07/11/2026 23:17, Andrei-Niculae Petre:
> Update l3fwd example app to fix compilation when building dpdk with
> RTE_LOG_DP_LEVEL=RTE_LOG_DEBUG in config/rte_config.h .
> Move l3fwd_acl.h include above all #ifdef L3FWDACL_DEBUG checks,
> as previously one ifdef would evaluate to false all the time (as
> header include was added too late).
> 
> Adapt maintainers line from previous examples/l3fwd-acl (removed in
> 6de0ea50e9b9) to examples/l3fwd/l3fwd_acl* after l3fwd-acl app
> unification into l3fwd. In 6de0ea50e9b9, a line with maintainer
> expertise was removed.

It is not related to the compilation fix, but OK to add this line.

> 
> Own testing of the l3fwd example:
> 1. It now compiles with "#define RTE_LOG_DP_LEVEL RTE_LOG_DEBUG" in
>    config/rte_config.h. See Bugzilla ID 1318 comments for full error
>    seen before this patch.
> 2. I ran the l3fwd app with IPv4/IPv6 ACL rules to see the prints (when
>    RTE_LOG_DP_LEVEL RTE_LOG_DEBUG is set) in the application around ACL
>    work as expected. See extract below (I added \ to format to 72chars):
> 
> // dump_acl4_rule extract:
> Packet Src:192.168.1.100 Dst:192.168.1.101 Src port:2048,Dst port:1846 \
> hit ACL 1 - 192.168.1.100/24 0.0.0.0/0 0 : 65535 0 : 65535 0x0/0x0 \
> 0xffffffff-0x1ffffffe-0xf0000001
> 
> // dump_acl6_rule extract:
> Packet Src2001:db8:1::100
> Dst2001:db8:1::101
> Src port:32768,Dst port:21005 hit ACL 0 - \
> 2001:0db8:0001:0000:0000:0000:0000:0000/64 \
> 0000:0000:0000:0000:0000:0000:0000:0000/0 0 : 65535 0 : 65535 \
> 0x0/0x0 0xffffffff-0x1fffffff-0xf0000000

These testing results are unrelated. Dropped.

> Bugzilla ID: 1318
> Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
> Cc: stable@dpdk.org
> Cc: sean.morrissey@intel.com
> 
> Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>

Applied, thanks.


