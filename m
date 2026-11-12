Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBC606A338
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=PCyNfFl3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=E6vAHmN9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AABEC40682;
	Thu, 12 Nov 2026 13:53:27 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTPS id B0D9A40682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:53:25 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id E5743EC01DF
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:53:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 07:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794488004;
 x=1794574404; bh=wkC5wKL5kCy/jVSSeuUfcoPfANEoyTX9Z+CelBeCE/g=; b=
 PCyNfFl3dOaUGqOB5vF8GZxE6YCScLroJk2Zm1kNHVXBhZTiYw/bsmiXzvxUKVT8
 Vds7tafUXae8wInuTAjVJnqTxaFqJ0ULS7WdBBZx2iM+Z70Jv1i6J/lhittBouPU
 BET+6kKI+U7LBagNDQ2br1VlkHf8XljSnRNdcWWfavVFWEYBBigm40Ap+U7O2ZyZ
 UJKvzI5XZWJr/FJpp/av7KJalNVyU8Wu5hFNZV2baji5VG91yWto61F80TiQHjbw
 n/voTGMaKvMrugnnIdyvmX4DKInVNlwP0WMy3qvTgX8RAHTvCJewYF5w0+0J4A5l
 nBq+PN7MPfXkUQQ4o0GVvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794488004; x=
 1794574404; bh=wkC5wKL5kCy/jVSSeuUfcoPfANEoyTX9Z+CelBeCE/g=; b=E
 6vAHmN9S/gQLLs7aNAQ0AUUZZ2vMW7ieEkojl9mWYvSUzsjbChv3z4b2RAlo4D7C
 J93AMrQ6a1JpFHsY6lk6oYQsWBv3ms6jP2u9KH9Dnhav2qJdUoicGv9Yzuh//ekF
 YWjXL28HJymMJti/nSb4u5xV3wRiNGCxpZ28qPSfk4dzynWI59EpVkp53KPSth3T
 ufRnkpKTmcCT8yjngb8+Q/4ztQuEDphUL2t9hVaS25SLjlx5Ia9wDmoA0nbM84IL
 F9TF9T/if1jxcdOYSDtbOgEkBt+CmQyDcAPQRajXaQnfi3/0N2XP1Wok2hRWR+yd
 hgb2NL8wbYX5ejY4LIjnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794488004; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:GlZR6LqG+CFX8Vy8lclDIglHKLkT/C+4IVPbBGXOM+nUCNo
 StnoG/joixT+Y+WAzO0g0R6lwU1z9PocTC9Dww3DQRk1p9iIGFnrNHkrLDWIm5Hp
 vH2m7qyHY+ev9dKIC0vKPH/NezFhFd6ZWlY7H5Q+jtBEOA94Ew7+7BNTydhNDD50
 1EiBqMGT8TO7wVCzU+3mbrJJ1QBnE4u/wUGAYk0Bd41gmeCqSl2EEid2fLew9NiM
 7s2YOXvHgfFiMyZWmORjIJ/vAca9KdTtY4QXbfMx7UMXNMmQ8mS4eCOK7GYOzW1q
 ki2Fmvx7IFLfsd6mJZXX4ocVZRKNYWOQVP4n8hg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:jALXB7SwvmcLjO/SyLCWAjwC8qYF/8YFb1rKwoI9Vbg=:Kg0mLlfjimYi4hU7jyRRkK3nWXXJA3On4/NyXUpQEgM=;
X-ME-Sender: <xms:xLb1akfWUfLgN8lVocKBiTq9VFdsGUSjU2ex1qDGIeSEoMb5tgMr7A>
 <xme:xLb1ahpUZh1oyrrUk5OgMjpF_RPvjiG7pUGiPutgUTd8QzXsPimQFDBGwfje7FBW-
 Y3B9ckY4h_bv3mP3WjJb25RC0fItSTZV4dkIDogNLpFc2co4KJURw>
X-ME-Received: <xmr:xLb1apA-BBBLuXznVO-cl3uToKoiqoX6a-Il0BkcU8bUvSQ7WAXUXc_r9jnTKlwA3QgLs560Zy-79avsZQwCnzI>
X-ME-Proxy-Cause: dmFkZTF+hRXWbGRqePa2C6zVPSkHUAR/EVNTR8+WFjcOG/D7GQZyiAO/5+DQB6QsSQdI5P
 NwpLchodozfFpQzLxcj1J3bwBnbWXCES0i1/0To+B1sQ/FSB3d2VR7W+oU8aZFgAZ8Azcw
 9oAU0eNFB3BsO2yyqdjArFGkSPc5w1DUW9t8ZLNqZAPyTqm4AC9+OGn3yDQt8JjZQdCMmN
 ydfRYpYrL26jyk5+/8iT0TZ2uhRLGn9I5TmbH0GACjTaKAJzLVAiujtQa2nozNCgaMhmHB
 vqiwlSblQP/bYKVWQziLGcztX6DU2vaTXetmg2m5ouVZHRkfPYyJHv8PQjoWsVOaLm5ALR
 dtHtXnHgMYiAxkC3Zl31fr+7dh4VNykV7J76N29kN7TDZdS0wAboGoyiRUq4/zGNf3QBHo
 baBOu5MLIEQBBIzFwub8mV+eqUbHJfK29ctRCwBPAJFlQIKRaSwv664E7WW3LWYV9wFsNj
 PPmY45Nqr4F7w9hjA9JxavA6ncV8cWcBSbEIWSfQLIqnUdY9X1qt66806N2F0PVObWdwWg
 xGHRcca7rSn73Bj+xbG3lQigZkRuippi3ZoeIfPFnwQZZtyp6Bksp+XM93WDbI83Fbsg2v
 HRQLHGnH2uVJKaZFH8n04qIFD0MzXgF8eYM8vgZvE++7/xBBeiT22wuWLkTQ
X-ME-Proxy: <xmx:xLb1aubp8ElwHo6lrMfNwjkAh7fbjDIMWGzoAFZBAyhIeR7kcdi8aQ>
 <xmx:xLb1as7N0qT-OpD3LTHdGRJFddPwO5R7HdfQXUz_SSCPY8DPOCrsEg>
 <xmx:xLb1avbeMXYYVQwjx1OD-tGpqQem3wfE-Xnxzsk8Ljt_MmpmLPRHqw>
 <xmx:xLb1arivajXB5HJvt50xKyisF5o3P7Kw9-rQipkNN18hI3xNOuk_Ow>
 <xmx:xLb1anJQtMq1A6SRTlnje6vDKdyUrXsKdYEptxHm4wgr-pPidolXXtW1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 07:53:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, Jiayu Hu <hujiayu.hu@foxmail.com>, stable@dpdk.org
Subject: Re: [PATCH v2] gro: fix packet type comparisons
Date: Thu, 12 Nov 2026 13:53:21 +0100
Message-ID: <VEBke0uyRjOebKwiwZhmoQ@monjalon.net>
In-Reply-To: <20261109112657.106114-1-a.mokrushin@ideco.ru>
References: <98CBD80474FA8B44BF855DF32C47DC35F65AF0@smartserver.smartshare.dk>
 <20261109112657.106114-1-a.mokrushin@ideco.ru>
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

09/11/2026 12:26, Andrey Mokrushin:
> Hi Morten,
> 
> We hit the same issue while fuzzing lib/gro: with both
> RTE_GRO_IPV4_VXLAN_TCP_IPV4 and RTE_GRO_IPV4_VXLAN_UDP_IPV4 enabled,
> fragments of inner UDP in VXLAN match IS_IPV4_VXLAN_TCP4_PKT()
> (RTE_PTYPE_INNER_L4_FRAG includes the RTE_PTYPE_INNER_L4_TCP bit),
> are rejected by gro_vxlan_tcp4_reassemble(), and never reach the
> VXLAN UDP path, so they are not merged.
> 
> With two fragments of one inner UDP datagram, packet_type taken from
> rte_net_get_ptype(), rte_gro_reassemble_burst() returns:
> - without the patch: 2 with both VXLAN types, 1 with VXLAN UDP only;
> - with the patch: 1 in both cases.
> 
> Tested on 25.11.2 with a standalone program and our fuzzing corpus
> for gro/gso, no regressions.
> 
> Tested-by: Andrey Mokrushin <a.mokrushin@ideco.ru>

Applied, thanks.


