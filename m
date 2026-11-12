Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC2606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=1mgBk7RL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zMm5eg5U
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5019E42E4A;
	Thu, 12 Nov 2026 22:59:29 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTPS id 185E042E47
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:59:28 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id E60011D0065F
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:59:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 16:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794520766;
 x=1794607166; bh=z4XhJwqF1y2ge8r5bMWJwNEUtIPsVrVXIje2ou0xG1c=; b=
 1mgBk7RLtlA+g335ckIhczfpVE1JuscA1VBKYlrhTTtzJpe3cXyXNp608YCS02WO
 wwu2aqihVd8JqLbKdSyJXIInA+vs/w2WljS7OJ/j5DJ7z0N0vjfnj2lVa56qwIDI
 JDqSUPaDnYDiWWVL8rxJY6OmUVY/rus3pXbEcffzBwYUSNopUPuqwNm4+p3W+ibE
 S4Q/oRVcmtHy8LCixZMe9gQtDvIb6OaPfHAN/3pu0+oizCHjUHKHLUxVsg0cAqsT
 RxlBwI2OIqdF3yUNXxkzeqLQEowRZi2fjS92787bW42eIt26r86hubI+Gb9O4yMD
 vaL2Sry9jmatFVBea4V5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794520766; x=
 1794607166; bh=z4XhJwqF1y2ge8r5bMWJwNEUtIPsVrVXIje2ou0xG1c=; b=z
 Mm5eg5Uqcma7ptdzMpXCTsYpeUa7mEXIytAwgxke0VbfZKB+oR78ZPGMNvn1y3DI
 6DGeblPTHp3b+EczfsXL4zRtb7Tt2HS9ghJXi3rZRiM3r9gi0Vx6pDfqwlTO6tdA
 rd12vpvXt8CjbaNBA+TS+INr4OeucdHzPvdMRBh7J8gGdKQIPMKTyO7HRsySxNWy
 W0hcknlwf9gEPIRoVdDx8J3zwYsZ+mHFMCe5Gt7YRJYk1HJ70xUj+j/Kf+DOH2RX
 1aHtc6cEZgj/UBQ7va/PapkptZYgmBpCZKpG9k0YWXG+e43t0lBmqFODdCNf/Hvo
 iAGmgvFQiAf7Eq3+q9zeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794520766; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:Cf0Qs4TVNfDEN0YmFN87PZT+0QT6JHOCYKVZpSS8Co9g0Hv
 Qd3qycL6NauwwqUUtfJXBLSao82hhxD93H7Ubz2Qqv8rTQ22yCLrSx8xRA0TCvAM
 rDO2PXMh0RBe2T+3brBliFX+0FRlvOeT0NpfN7Mguge4Lj+DByIzVO67vAn4WliZ
 7Q0ytAgTUp4aYgXL9z71XbV6qq4nlmO6ARaEYmi3aN8fCQabU5SPayvsmz38dOWf
 VDFXmErQdqghhVgBn4VNnE+Y9T3u6dyeM98IabhcV5yEgxk7abmbgX6xfFNKuCtu
 THvPuJjsWNJ9z2cvHhQyRJ1GqLwByxI0XtNVH9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ZYGIoJIptEdJoBdO4j2ach4VLgfAWnTiX9pa3Gkur9E=:rDRZdcYBKBlFx6VTzcm2zr7MrRfhj22zp5LvoMR5CmQ=;
X-ME-Sender: <xms:vjb2avCeETGhQY0VlJFt0_Cl8KokNZ3Z04d7cVPIczMoicSR8TLeLg>
 <xme:vjb2ap03JPwEozMVm-Ms9JqyM_6KUuOa1sU58uONNar79d3zDVmWnuqTqfvdTREu7
 n8vLk9fnPZhDcgnqn9miqpP5SYcGzG_zlvf-2nPQiAhG0eBelKFvg>
X-ME-Received: <xmr:vjb2aptusytBRfHqu_PpZ0w3OJzZBhN72UlxDbxMHTNXbX3rVoodr-qesPhQSIn9lOnIO838Sv0sUxeYLIcQ59o>
X-ME-Proxy-Cause: dmFkZTFKxW3eUEv+MLR8kb9a94+aXVFclao1+yscFg2GvQcWzDCLTdStV0H/fFMeBNReCq
 7FQDgTOdUJf7GELiUYSQeclvzGHTLiz9jhr0Lyg6DY3aavYOkKbslsFx/Ckqc2DbflHldp
 c77yhKC/n0uzzvEoDjiQkvD0ucitrk9vcvK1ttlzQRfURr+iA8O+XPLBej4rvotPSpF4cR
 VEF4MrwrWZgzTKM18ysNvSlULlAtLmCXfypRSwPuSVmSvkedBpOT4XzOhPRhZs/gl8yv1A
 B23t/AUbmuqRMuQQ4Rx5P+3B28YvR3uDeBsusM5S56IL7X+zpdHGKnETSKsp1FhPJ/n5OW
 niXxTPwgGr7LtBj63FCK4rYc7pTsH53GwAqhoGKaFR8sWeYZP6p/plwMDpAk3A/2tNda6A
 gIbDLyuMNXGs9SYPoSSeVsFjFJ6c+ty5ANL3LfopXbu2WLU5MVG3YKlj3P2bqGdVE/BwV3
 uMJkRaYOObbLy+ukzCXJjJ1qzjHV/Kd7h7p8eQBtv5LQPkPzU8xhOCS/gv3MW/aDr6YZQ/
 2a8YjfRFJQLWFYw9ZIYa+QssEA5DhCUHuOJyriDML3mWLlkBldvj29NKz2kZHYV0H1sab4
 aXi4Hmw2BBdWGkMh3miqQySwX1ggxmHGW6yggGXeku9hsY4+tecNT6OImL9w
X-ME-Proxy: <xmx:vjb2ap5Re-P8fYRKqIKGOammhcATrTlyPIyjl0HFTILGffBWIBPLGA>
 <xmx:vjb2aqK8-xyjQzl8ygwW4vgRwtlpanoGoH3oETQYDKHHya2G7QYlGw>
 <xmx:vjb2ap5gy8xGnkxkB1gYOALOCSIDWIFJksebXDTQRuRWIhwcGyAQbA>
 <xmx:vjb2atySb2vEHlTfomQktFUcnA0R41OI5_xjstLNHqbTxXWa75s63A>
 <xmx:vjb2atgFdfrd6xoojHffuqMRyRCzUMU3xav2H_tJjXjd1VJi6HagkLXt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:59:25 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] usertools/dpdk-devbind: fix interface names on FreeBSD
Date: Thu, 12 Nov 2026 22:59:24 +0100
Message-ID: <KV1Q9TsPSYKyxN5z5wrVTg@monjalon.net>
In-Reply-To: <20261103174601.3757534-1-bruce.richardson@intel.com>
References: <20261103174601.3757534-1-bruce.richardson@intel.com>
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

03/11/2026 18:46, Bruce Richardson:
> The interface names on BSD were queried from ifconfig on initial device
> scan. Later calls to get additional details used the non-existent linux
> paths to query the interface names and so cleared the values. Fix this
> by ensuring the interface name gets assigned to the extra details on
> BSD.
> 
> Fixes: 06d6605f7906 ("usertools/devbind: add basic FreeBSD support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


