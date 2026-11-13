Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4E606A32D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=T61P36Eg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YjqeP9x1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43B4A402A4;
	Fri, 13 Nov 2026 21:23:04 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTPS id 3600C402A7
 for <dev@dpdk.org>; Fri, 13 Nov 2026 21:23:02 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0CB177A0050
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:23:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 13 Nov 2026 15:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794601380;
 x=1794687780; bh=T58g3e9MxaWzfw5dh4H1e+mDfpMRWtaTri8RDIlq0Nw=; b=
 T61P36EgvT9xjimswadk9rk9zOQd95L6ikRPRIjpCBWfZj7N/Kzf36mAvcHAxch/
 RQH8fRv6u/VXSBeAnzn1+ddoQfQwN7NYqc5mjW6Lz70fA5j1i2f0qLF/l2tWxd0l
 ShmRTSXN++zF+frxYXE9IJ89wFSgEj4sbaDUF/7WsLJuOr/IqrsXuSWhn3n/b7rp
 zoUujug9kxAll9LxoBUKGf8vThexpdR9KrVjUL5I5AjZ/n/CrXO89FutNNOAjtiB
 Cp94u/CwkVckdPe2pymt3s1nfSploEtG6UqctoE5YVbFugPXzMNNixQ1D/LZ1I60
 MrIntOQxZ6IMeLN0ykUbXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794601380; x=
 1794687780; bh=T58g3e9MxaWzfw5dh4H1e+mDfpMRWtaTri8RDIlq0Nw=; b=Y
 jqeP9x1j/qu8KfUQLTDYvQjjTDGI40lBIkJUcg7NTodX25R7cqiZnNWmfIP6wIfl
 aoMt+vdnHSemnQwG33KyFVybAtiBQ7hVO9LvENKqjFYUmt3dRDvzG+iE+s9WiIq+
 1yt1AcUTkn5hMeynso92lVfoKOKm+aOlDsN832B/uzlo1XNBME8NLA0zyzEINYeJ
 3vsn+O3oBTheZsQSX5nOUI13vdW2S4yYVHpaN6YkWXUjZylFJPSbdNZo/P/+tWxQ
 ivazwpyouOXx4QeujiL/cmuaF3JcURFC/5fKigkOItj4KShc60AncaOX3kuyfA5a
 1dDZV1JsRFZWer7KPEAgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794601380; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:L801Z+PVY9s0uLAJJZCYZ0ethN8Y4Ic15Xq/7V1gWYG6Ke6
 FX9NN5HdRX1s71TQvO0oMXdRnfF47/bwJgLLDT8554AoyrFAlVZ+GWUZQbuat36x
 /CRTpH58FTEE3F3Pffw50Wi1N0N18nWJ2yQZYELwLvhPU6GN5w2PeG3wmLakW1FW
 8zcAhwZrVnGsf6tnxGlEkewUPuiDGEWuPk563W0OTIXx7+Lt4N6kye8SuD66DZ0i
 mUQ9SVr0p8EQN3FRjdXmdfBXlnwSLctjuEahhH0RcMOxBVdugEw9RANKfzUIjL2u
 alju/zo/eMAffB9Hc8JqCkUdqBl2tykuYTisvFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:5Wlhl/fu9Qfi+2Zwh2F8iGs9OszNV0Q4RNDr5PWljjI=:T58g3e9MxaWzfw5dh4H1e+mDfpMRWtaTri8RDIlq0Nw=;
X-ME-Sender: <xms:pHH3ajk6kde3iSRMcWXva6VfQJeUf-QCf3zOXAA-75pLGMBfAJFB_Q>
 <xme:pHH3arLrSPuNgfdRU-j6Rr63EFUGQec-gbkqqbI_gfBHzOPAMUIOH0oRmKM4-T4FO
 S2y78bi5vFhlM-FKN-eOIG6lv6J0Wcj1lsjTXp6NMn9o2JPJOzZ>
X-ME-Received: <xmr:pHH3aoz5egHaXlwBeAWlJvQ_Z5lSzOdTRJfu9ocyvLRWr6XAQeA5EGksVO56J0x1CGVB26Kq0dwpxCp3lngBTxE>
X-ME-Proxy-Cause: dmFkZTEZAGON11+CHoddtUruXSgTaJG95Nc+LhP6DzqbLsard6/tPZcnpOubw42pxuNKko
 Nw507oY9mtkKwoM/6g9p+CJa5nGZIPq60NYYiuDSrA9t3U4IOroSFwgCqA9uT41y9meev5
 fgGjTBO6EPMdy3UYxXua+x9p0RMp65U1G5e5J0tKwpDTtN9jLjic1QuJYM6JOSuwRNRb5h
 LOq6nfv8zb0XW1ZkPVyJnPKm00o7063aoFMIR41UaL23q2OuA0Q4MJhaK6NroQXuCbbdV3
 5UpdtbrF+7/DmRNYfjK7N+McHvhIkKEDTYq44qdkHGaI35YReRVl2prAfbrl2AeB3FfgqD
 N2AfDpl/HAFqG5nqQoY9foP25ACo6bqTekR8HTUHGioaVZq+vr4+cmft8SH3WYEvQfmzKg
 yE2SQuEaieqC8ySDgqWzdRhy9r+4f2vcUefG0YHX7bzNFLg+NY2TaizDEzSQ8mp+XJ2CGf
 Y/cT0p1eu1RshGZgQLnzEg3SMMJY9JTXGNhZRyV4W0hbYLTbzL0mrfSJLm1y1lBtxhL7/a
 i8Wq1Cu9UqZqo3F1ub95EuYFDcF0ceqbVBdx1XxRPH4bjL05C0AAorZc+Krg3fbGnj6ga/
 lo24WPy93XDd9pOlmos++7qYSygfPmAAFH19BbNxkXD9qLV7t5vFpinJbXNA
X-ME-Proxy: <xmx:pHH3ajsAckR0FwSiVFXuxNnfq4sDGG0u-ao2yeGzx_WGzaUpKOan6A>
 <xmx:pHH3ansjoSVDG6v42mNc07MbGvqeWhCvdoDP3_vgbpCgwfX58R7IgQ>
 <xmx:pHH3agMhqxNTb8jydv4jSCkMj-F7m12Fw_LW0Oioy8dD6CKwxLAXow>
 <xmx:pHH3at07q5KDOa4vBbyw_p7g0mRGTPgwevVSFOgI4wV1NGp0xMovCg>
 <xmx:pHH3aksemGa-4S9q9hHKIuaXobcrygt6macaCVG96drFLLM4opEMjWxz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 15:22:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v6] examples/l3fwd: fix RFC 1812 checks
Date: Fri, 13 Nov 2026 21:22:57 +0100
Message-ID: <BydTunSNQoiltn4u_4EulQ@monjalon.net>
In-Reply-To: <20261113201423.596856-1-mb@smartsharesystems.com>
References: <20260915105822.988106-1-mb@smartsharesystems.com>
 <20261113201423.596856-1-mb@smartsharesystems.com>
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

This new version does not compile on main:

examples/l3fwd/l3fwd_acl.c:1094:17: error:
incompatible types when assigning to type 'struct lcore_conf *' from type 'struct lcore_conf'


