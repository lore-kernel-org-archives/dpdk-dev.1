Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275F606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=uevPE/QF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vPO9xAuM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58101402DA;
	Thu, 19 Nov 2026 18:18:31 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id DD17840151
 for <dev@dpdk.org>; Thu, 19 Nov 2026 18:18:29 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id B26751D002B7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 12:18:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 19 Nov 2026 12:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795108708;
 x=1795195108; bh=15Lv6Wum1JOM7+1HLw1roSEwDkWiEhYxnTj2SORjN84=; b=
 uevPE/QFgR0LiquZS/OviPGoNje6SA8XQSbcmch8yf77VFWSDubPi1oh3Det10mF
 yqXt5Dn17GeN0PHrr61hjJwgdLHkimdMjR9vGe9W8vGxPEo5r7G3/o6jsnzXfyfl
 vvLdlovG+HFnGOhYKxBUxOK6YQurvGLi2Mi2s13Loyp6cUvbOddbiIzY4fliMCHc
 ngEtdA9n0YO5RJzRjc8CTKvkNTfvJVS02LWR8CeiWmSz3iCtlN888fCMoFTXgapz
 b6GibXVfPk2zarHXVrwpAK5830J9pNU1+n3IUSc/ysyLRDT5HfHabJ6jngooVk4s
 PwA2GoD3m4SNN117EQc7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795108708; x=
 1795195108; bh=15Lv6Wum1JOM7+1HLw1roSEwDkWiEhYxnTj2SORjN84=; b=v
 PO9xAuMSTfwph3J52iO3qZsYKA4amhfHhP9yb68ik0uefng4Pe01g+JanEjwdIKB
 uBQT8iQngoOMWYOnXvNDap+Jo4bUPXrl8m/8SzXtqNjSzCGETWkZJ1i7KjtH6xaX
 uG5roR7EZdKFMQNnq4MZNonlfIX/PHLJXxxGCvykchizNYAh2/5TAJqCJfUVcqzp
 Bscr93JjUNVlFJRXVyyQKGF9Q+5AatsQOzUknupU6sa0h0TQMe7dD9A+xw17p7zf
 H7ew5mXFme4Z4+ZBJ66IRny7z3Mn9MUotXN7v7rZBxOCYe+kcVUWPuFVzFx0La0N
 zE/DPuIcpwek2m67446IQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795108708; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:r0QDyTTVdm56owd5K0IxDzSjgbrGBZrpNSh6uqw9SUxFvWe
 DGG1sZNH0LkeIkp3QjX9989dmBnVM9hHLAohJlSz5DFHytyw0giB6M7sZ9NQvU42
 vO6KprUwRJKQaq04dboa6Oom8I6VrDKwfj2Ph+ChXT7D0mbkA6C6+ybxeejbS7jG
 bJjX+0+xYkYn0DiZn6oipFQjSd5R0gz1CTUSSh1qOaqyBwBdMRLTNlu1jhyqTzQ7
 1qwdvuLQNvWg58yIOHbOdpZGW2biyCTNivoW7ukO0zmAEfxv4t6f1ZQW4R0Uvj3p
 k47WciFiDQgEhLFU0ZvlUfMraLRTfYKjWM1eDZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:qWGdPC+s8M2iLfGnW5GmZNmIiSoXLXOumPzbzmgrhPE=:9RKz3XjrhxjgMHWRP+ubNteeV8u/r1kPInVPKUv37q4=;
X-ME-Sender: <xms:ZC__aigeHyEnOjtnzi-zQSNZM9TOHYNbgZSIhph7sQbPSgIR8xEzpw>
 <xme:ZC__avWz4k03YK1Vw1OBPhg_njlNTzquBjK06qRZ-6bkjeCcFd5CO2kz22bR0-QYz
 wUSF1a24MwNtxUowT6dbCxQsmgw9nGd-8WRt4pD0UDWUj0DPVCWEHU>
X-ME-Received: <xmr:ZC__as3GD0LTj8Uj969RUQG0PVZRisHwyKb2vS8eCJNq9yxmZqbNVK6WdmLH_ixJtg6cIfGQ54JwTTAsYi6reZc>
X-ME-Proxy-Cause: dmFkZTEkRuvUZU689yEaA+ZM1AVktkmdNKXJ3e3NU3DRb6Nqq/Wvsi4VrBwEIcbpaFwB5i
 cGKPvMdEWf0uwVSlhRJk4xwWHx2zNv52I9gsNwE7eiVdok8PJlyk0WkeLq6Z6kgdsiCDVN
 m96xt/dxulwT/UAz8/0845CRNwvX4eKLsz+RemgmDx5BFwfwcKxQeYjmlP+vluDZrZ0N15
 61LWbFMQzn+bwEjzBaJWQ/vBoU1p/N9lOQ5FpPbMUpxvFe0wI99Xo/d6l2QyhqLbPqd7PD
 yZMohdKO2V7IGfhCI8Ifweux2eNbQL2X4nVQreB0A/8Iu0ll19zgixXd/y7w+XlRJIk5GD
 xelWNOE2s3+iVEhU0cN+fVdHhDrdMXEOqp9cbgqJc+D0++Vq/WTVeUmHAR/J6nKegCoC/Q
 G6SbcqKWiaTd0Z1Y2ZVD8jpb8B1wITvKNTDYowmVn4mB2K5J3xHyZW4F+QsKyknFkXCJjR
 wJylM/vkmniM4GeuxlfmReMe9rY7oQqYQzJfT7pLC1z9/sdezkWwMph18M5DxUXcL/WSI3
 CWw2bPkwSmF7DtO8N/If9ZZJFoSRGbD6pWiDw/hiDn/9ewbBGLxhLM6aF1cA6nFw3bLSO6
 PYLOvlUotUArtTXmjkJcKnVl0yE6hO+Jt9KaHor4fWW3mlukmGI08k1mGECg
X-ME-Proxy: <xmx:ZC__atFy4zD-kp0o2hIyHclPXba2IEMtSNvZVKJfAk9MWlXO6Ym0Bw>
 <xmx:ZC__aiif9HTWp2-0prtn49Wy1SGNZVkErdKSJJbh1paITtvwJCDeyA>
 <xmx:ZC__ag_93yNhNMhNcR091vfKff5bRO_loM-osHsxyRc0VFKyUUgNLQ>
 <xmx:ZC__ahq3VLmcFmTJuQ4NG-I5-jgCZWp3HI_hiU-SMTLfPbrvsJBs-w>
 <xmx:ZC__anIK6HwQ3z2wAXU1q7cMBJ0sJlMtFyL-ke6VUZmkSVtWOchQ9TkG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 12:18:27 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/3] deprecate unneeded build options/support
Date: Thu, 19 Nov 2026 18:18:25 +0100
Message-ID: <FEg6v2hOTrCElSHO194zaA@monjalon.net>
In-Reply-To: <20261104201506.4091374-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20261104201506.4091374-1-bruce.richardson@intel.com>
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

> Bruce Richardson (3):
>   build: deprecate kernel dir option
>   build: deprecate standalone tests option
>   build: deprecate HPET support

Series Acked-by: Thomas Monjalon <thomas@monjalon.net>

Applied, thanks.


