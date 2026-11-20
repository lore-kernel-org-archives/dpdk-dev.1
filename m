Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9F606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=hwaXYBC2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cMo8mYuq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2A0B40284;
	Fri, 20 Nov 2026 14:09:22 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTPS id B7E2340151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 14:09:21 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B7180140023D
 for <dev@dpdk.org>; Fri, 20 Nov 2026 08:09:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 08:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795180160;
 x=1795266560; bh=odH5dzdst5kgP+1O1hVtnA7bOVhnjQRpqOjCenOVFMU=; b=
 hwaXYBC2H8M+rvVqPbsOgu1eaCYSDEKttSVtZYGJD4jmcV6EdRLe2sEYkcK0p0Kd
 wtGlUiC0tFE8K85gwXjvdZn8I74xH3NBy1/tuolLWcdNcu7+l+KM2VOBy7lS9npr
 yiuYq3fmUdUafjorjXe/8T/+k8JZxWitDS9YZ4xJyW/Pt8wK6P/mXyueEgWct+xi
 o9lO9YT1GLQVkUESt5uHm4LbkvXD32aXIV21JRrGJpKDJiEKWnWAWp7XZIpADIaz
 AKyrxqRi+MxStTarppFWSPYkxuQywwwzj6CHaeSJLwHHBs/7yudGjdgRtgQ3rkXJ
 WH5ND1RXrBRuVTbt7RRc3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795180160; x=
 1795266560; bh=odH5dzdst5kgP+1O1hVtnA7bOVhnjQRpqOjCenOVFMU=; b=c
 Mo8mYuq4u9/gfD1C3Jbf/oZGAy3ic0pUrFQy3YLQwxV+IegfU3AHl3n8kRwklMFn
 SleV9gl1uJnHzvOaWLJDwJ6/BIPJf0I9+vDCEmqJrUVs5acjDeqQRJSj6IsM7jyo
 9Dn44PdRq+Spycl6tBW5eGc9WU37VCyAtLzYKekFq2PEUu5Qf0laN54Mu8Zn5KNG
 0+wxjn3TnYEJ3EQv+I46tF2+4VunNGYCQ5GblE+075JXLkkpBOyPVrPCj9RQFnXr
 /48F+zTOolJofSjsf+kQOxWZOoEHeDqP2pV03u2lilSxVtZaqIxH+BCXX85QTsPG
 GC3qSNpi3DCuvECGgP4kQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795180160; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:OHQb+NUyxbU6jNIx8iN6pP39ef5OPEK7pc+TeFiK0w7Aqxx
 tloWO8BNu2zYxgtUxY0AHO1rHIIEYAtdj983K/+Wj89egHk+Uml1SQ1VMxx2YVq6
 hLUnAVtl1jlGNs/Inz7sBxUdpFqXC9O0jCPEqsuwJbBTGzYcWdKr/JTDACqaIjm9
 UNXbj8AHPSdNKPcqH7NTXaOwSfvAaeCjQyQjVbIx/rhw4eDptlamFp5maHB4HzGp
 FZCrCjxWlAoOl7XSXfw6oll1fVbuV3X+QPSs6vFTjnWCXeM+3xdqW8RXtjwYJ0In
 0S/yMyBJcS9/iTWmrbJjDsKHCP8tUgnjlGt+szQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:V3o8fEMLq/KqgRbqA8orQpauldmOFeu/5a6iAhA4hSk=:10V2FO/Ema7sI6yTG5gk2sLyzGTRCEGoMvgVFrHpme8=;
X-ME-Sender: <xms:gEYAawjx0LTDob29bSpVADVmI9xS-T5kRVcM4U1O1N8i4hBO0ufM3A>
 <xme:gEYAa1W9jprLNE7SHbwGjLnKGiy-yQCJFGB8_JbdSsSVs4PEeLYThkod7AYVtqLxn
 7r2auYBIauVFjD7_r8k9yyujfyU4On1SI1qiVAJlUWKpli-k8Y6yMk>
X-ME-Received: <xmr:gEYAa60EPFwo4d7LrfIsm6YjCqwKzdFtPmuk8T_KBRW_VkvXtGuszAXplnFFmLWNgx-0fZ7POrkrx0aC-Wix9rI>
X-ME-Proxy-Cause: dmFkZTEr2KHpqANrw/yZVz5H5Bx9abtErXt7xvxxwGtt69uFe80ivQInGNBC86b7+bIIuH
 RtJIzLkMLbeq93MyJor3BQnF74sW5h6KMB1FcJSS7KExnESs0WpNpmZhQubKoPFiQ9kRR3
 Tg/anfh9o8xZ+FYHATPSKxPb6EnX+NiOe8WQbXoHOJ7DbUsSFNMwmiYHlJapswbTr5yKfe
 bzWoSAu0uz7iU9ZGwYsaNfLI7dub7xBz2XlpwMeH7TSYB0RP29YFKNbFVW2s/zRKCOkD23
 rQaKhAn/tLwl7qznD+j2LTtv5wIpL4CBRZanl41G27soqeEDs7LcFPWmlbpMyEc79XlEHg
 64aJf4WpWD1ZiA0Gx8g0mlHpCTsT8gvtbXrQr9BQ3F4nO7OS+YNhwZhIVOcZfV7Ja4LjS8
 P3vf5jjLuXgqiVRB7NwCHFfVW/oxmCP77MtuRUq5cuGe9d0ZWWwzd1+pZlp7+7V2eVvJSs
 r82VirB/BE88EaqNbsVVayz5Msr3cyGf2D9x5BinPI8FvE5XCmyjd7XXq19qDtSs4S7BjU
 MQI6cPRzSfdnqTZscE7k4W+2HOyxC0GHv338AETgvaH3y3I7npjjC30rOTz9Z5lC7ZqMUa
 D4HQaJ7HLhSMHfQIYSnX2c/4wqXhV1ty4Hek6YLNRabrT2c/wPz+oXGZ9uMw
X-ME-Proxy: <xmx:gEYAazEL0V92pelLD7WnSc72l6RgqmfuS3ut0mCSxwBFWOl7jEpi5w>
 <xmx:gEYAawjAhJ-pty-53oY5W-m-YTczhSaZP0rdtYN3QYIzjWJXvqONMQ>
 <xmx:gEYAa288R0-riJy_2i5ERtCQBEAbdWWcOPzPxDeMSre6rlgBvoQlrw>
 <xmx:gEYAa_ryuqML8HvyvLGeUljc2NEdN56XPB-pRVIo8EVRbRQbVSOtig>
 <xmx:gEYAa1JcpAaGseJ_EKO7a-GAr5r82Uw5uN3qqOo1irKZYOgMTQG6uGqT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 08:09:19 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: John McNamara <john.mcnamara@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] doc: update release notes for 26.11
Date: Fri, 20 Nov 2026 14:09:17 +0100
Message-ID: <q04UnXq5Qw66kjk0lw46rQ@monjalon.net>
In-Reply-To: <20261120111419.576367-1-john.mcnamara@intel.com>
References: <20261120111419.576367-1-john.mcnamara@intel.com>
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

20/11/2026 12:14, John McNamara:
> Fix grammar, spelling and formatting of DPDK 26.11 release notes.
> 
> Signed-off-by: John McNamara <john.mcnamara@intel.com>

Applied with comments removed, thanks.



