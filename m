Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0AB606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=i/Q9eyKO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XB9HFU+v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3922D415D7;
	Thu, 12 Nov 2026 18:02:38 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 757F9415D7
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:02:36 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id AB4B0EC01D7
 for <dev@dpdk.org>; Thu, 12 Nov 2026 12:02:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 12:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794502955;
 x=1794589355; bh=0eKuwRv2Byw40rGsbDs3hu1JD7W9uYzo0Rxs7DKfA0g=; b=
 i/Q9eyKOsqIh1xB70QStFPzHZvOnhjVKdCQrjRiAdTgkq3R5tQ/ttzC1/aEKpS5X
 Ep6980fqloCph2xtdEgKY4QvKN/ZMhH1zob3tXZe+srIYWZWxXwZf3I/pR/5eNTf
 43vLoUkUOCvlh7vjghugFCez/yJahqOXRzpL+uQBw8kKrf24KN+xqnXnM2maXM+F
 2xciKSA8n8MRKALTecnSdC9vzuafhUJubDGES6M9ULicKRhQA462CXZH67yoMSbS
 PdRuSVTSXWHINHnG98eqEwGp1Dq3eNoF2v8H6KllR0q8j6N1729XQbfskC6bSrA2
 ZtpABY5rAopCbx9AdoSsOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794502955; x=
 1794589355; bh=0eKuwRv2Byw40rGsbDs3hu1JD7W9uYzo0Rxs7DKfA0g=; b=X
 B9HFU+vvSN6LBQ1lDQEojDGF+fPzsAUq1S6/+vZ3GHpV/fc85sg/OeBZ7FhqpQU+
 2sSl23mqXcMTPzv26DgG5IKG5l8cJOn45TxGvmv1G6HBMU7Dov86yQTfXiIrdmLa
 dawAZbN3SOir6wmIrpKXnVpRN7XZySiKMCnYg7FO22W05RhJ9nZWQ3+OmuzBsyB+
 hi56dPSIQu90A7GcmLHGVEA8ySGKdpgxRgadzYlKm8/epgnoNIPINK+UCxwDd9Lx
 JISty3LblYLQOS2065+JNgq4pGaeJU7/wJ/GV8UixS7F6bkTF85Wn5fEskbD1Xdz
 Mn/fosU6Gziie8y1KgqeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794502955; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:1zgbbQ3DbufcHJUBzJhpadeoUebPybh7h6t0WdZZNNfTXHw
 Ocw+SF0IZUUiGDs+UFqUbbhcBLIZGJptcNvzcPP2P8dxLUW0pLrUeDcg/VVJObA2
 j/W5eXCjQGQ3+9PzS62cUdKGszvFPwV8wayLpvqiBDhBb+TceZBdJBJg5aowq0qx
 s9FX2MAT5dOT1gAWX5nDuLehDYHv4BJ+J37u6i5lToFcnnSVq+zZSg6fD9gq8YJr
 v5PMfvLWfLZiKbOjvkOtPX8veAZ6xZaIsxMGvGNtslolNxUsHJidOHBPLIou6ROg
 BBS5ZuqubQMT2qmnDRxvCUyHDzZNo70EinJ8BsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:UCzUmbn/bw+eGBHvlmktRXLtriwM1dAfGKiHzO7cgu8=:3FAx1MunMz9o11WX8xzTmX0dQ12VgS6t+UvLIQ4hRlc=;
X-ME-Sender: <xms:K_H1aj30w3QSAb806tpR70F337aNQkGXq4t4cfUJWIPNyr0jH46GXg>
 <xme:K_H1ama3sXCw712hrxwFFgjJwDHTOZslTklnGnCcEygzDgj38lOyD0VveZZl8S-j1
 YD8mUE5PNyRIKIHiM8nD0cVFiYQeXEq0Plz72uzra5212SiA1KMFA>
X-ME-Received: <xmr:K_H1ajBtDQhYsiXDgvAIQMhnKk3XjzkGOMqhM0BcU4cLbQ7sCn54YpEwE00GmuKF-5uAdzCHnRmicIfZ4grEWFI>
X-ME-Proxy-Cause: dmFkZTFYLHv8fVkJgrnIelLG3W+VQuqo/aodVuUBPCoO67l0L35rI9fVhRZosVp/L5W2o/
 P3X7razm+Rtdf9CCO8/ae+ZCsMvueqy2rB/paU5zU9bUSGBlDhUndga4VEzfOlWdU+P7Wb
 e8XzgSrd5AOphqm3qqtsuFWin4cNlf90eqILQCLM+SaAzxnQeEY6LAYTDfeTbkfnXo4YUp
 pHgj9p/3gMsk/vSQOWJ65sU+TCnnfNlw4/q8w5NYtOIjlrlGw+aWp4C1chaRpDSdT4v57i
 g73qxul1N1Mm0aw8yzHdKZ82CU4RdzFh5HtCEmgtflF02SZZZfLqjowzdxrYbH2YIyRSME
 Z2DFuP0kJCRra6m8zAWZkX25wAFldZwvz4W/vR/bTGYp3VWjm3s0UVLfB7eyZ8sepZIC2e
 M2Ev6WqTOa5WDiIP7POX/e24Ht+cnXbVjxMavmZE4G7YlPU0wbK9wpXkivYA2y9lVuYobe
 XCwVA5Qpt9M1ld2oUWCLYOm469tP/5NciakCEO2le1UNic3u1dETSNsNUtRiY6h9URUkG0
 NFBoJU9soGfWkR7K8iTTJzvQvZyCClFCWSjeH54mRrQB6Q270i4UAUdeXDrrVHHh6fJ2P9
 opE3VrMsWwzA8u8FWvLRPLrpF0zeAoLt6xfgAIpyrZK6NPHrtCtxdxl4v7ug
X-ME-Proxy: <xmx:K_H1ag-V4neDJY58Jc-0ryARdof9quZdm9wg6_gARODMFV0au5KUgg>
 <xmx:K_H1ar_5tj0d4lidhiw_xjp_T4BzjGwib_KtkFo_72j3nLr0Ff5YCQ>
 <xmx:K_H1avdzKHItFgkVYPdmqEjUWPhGwdJvT1f6psU4DgW8NAlb6i3sJA>
 <xmx:K_H1asHFfneX_JSX8fc0wnB6ihRx6L3YgAzyrTwlPX4qHhdJYrtcag>
 <xmx:K_H1aqksagBvDNl8W8VtEpq_s_BSaBCeDTCVrk8Gcsi_-ZFJ-a9uFmTV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 12:02:34 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH v2] dma/idxd: remove experimental on whole driver
Date: Thu, 12 Nov 2026 18:02:33 +0100
Message-ID: <y2EnTTFySeiT-5s4CRN7tA@monjalon.net>
In-Reply-To: <20261104180503.4061143-1-bruce.richardson@intel.com>
References: <20261008154351.387445-1-bruce.richardson@intel.com>
 <20261104180503.4061143-1-bruce.richardson@intel.com>
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

04/11/2026 19:04, Bruce Richardson:
> The idxd DMA driver was marked as experimental in MAINTAINERS file.
> Remove this designation as it's been stable for a long time now.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Kevin Laatz <kevin.laatz@intel.com>

Applied, thanks.



