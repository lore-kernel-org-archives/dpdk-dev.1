Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0B606A32C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=KHOfVNY2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GVCKqqP1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DA98402D8;
	Fri,  6 Nov 2026 15:46:16 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTPS id 86C76402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 15:46:14 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 66CAC1D00149
 for <dev@dpdk.org>; Fri,  6 Nov 2026 09:46:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 09:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1793976373;
 x=1794062773; bh=2ZwfqsYuKKhGtG+rPtRPKkh5YV5QsdRGcAClh+vk374=; b=
 KHOfVNY2Cz8wkzd5izlCgrrVmEJMB2VYb/p+uLPClSoAGxnzkbnhOO1e2mg669Xi
 TnJ999jyvo0KRMqaKZhMRRmeLdtupfYoHidBVgFCPbmBjTjdDvZDISL3lZzL36Z+
 P9iYIQDEVuD5PTC4Hy2/g0cFEVhdD/P0koXmzPmtUT2nZP6GqT7gvR0lCshzkutQ
 hWWDubvC1ypm+k9AF2Db9TFb8bMgIzj5nvvB+FXkXG6iSouODVnhOE6Zp8ZPkiLW
 IdpmjTDAalr9QPsf8/8Lesrn+wpzMHZH1eZcSuRJmbC+ZLB2jYICiCAA3vdnyq6K
 WZ5tOPlAFyulTCnG6DMgdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793976373; x=
 1794062773; bh=2ZwfqsYuKKhGtG+rPtRPKkh5YV5QsdRGcAClh+vk374=; b=G
 VCKqqP1Z1cv0xXskvgZLLbpazLhELq5Zp/rt0y8VKevwINwUv8PTE4VvtyYTfQFm
 Y6YlAC0iLXhznnj+nHvPi2ZDUIopSw/9LdmpVYI5Yz9UN4xcHNIw7+mCo+878DG6
 GOn0XTECABrkcVEVU/Wfm3NTIf2gcm6lYnoq3HXpbADXoJNASZPnKwcP92eGVlN3
 Eo3EN/WxIorCpNN3lCJRhVE1ZgVk94wx6FoEAcBKuKinzD6oMcYCa73y/PoCtN6s
 9cc8iaclvETAVtph/an48rEudWnwVrKtNlg2zLHoklaWB8pV+2SYM34No2f4HunC
 my8w9mW3k3vF9s8cXx+tw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793976373; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:RXDUsLjzElHYoyeTSDN8Du1xUGoN2GkMDsRoDMfAhGePVTu
 955iznN+jFcTGeHTFYwu6B7NjgombP7sBRWo6ccYpBsywrQne+Q3z1MikLAziOpC
 W5PTNxLGAM2G64+DSed0p5qZ0RHPg/y//ZCcYBNQFo3SnURCrbU+hxZFW4kXwS5n
 UQYBE9jvUxQVfqz13JAP5UhZwUQpGGAetRfR9egPqB2Y0wXpruMDuAIvjvUYu5jr
 Dq+RXtlpaTH8C5r7Db3YjNuZO7oZu+qngnnoYxSGugKZRsmWQifW8yV4XaS4AINM
 e/W78pQT3cg3cgnbr49k+emk4r3aPlt4+Vd+lGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:/SiRMSDo1nyMnkAtEZVXKrC9H469ezCS1qSXxJghyHI=:2ZwfqsYuKKhGtG+rPtRPKkh5YV5QsdRGcAClh+vk374=;
X-ME-Sender: <xms:NOjtakc2Ne5iWvof5X6elnASXNRaIX5fH3mAQtP_LkBhtiANFxnodg>
 <xme:NOjtavI_3NonqW3iuJlHOf1RAoc7A4oYKl4L1qnopRrIyt2wRyd7s2AkZrGE9uVQQ
 PzRB8zBD92bZjpyd5dhCRp4RTwTVlnWGl39-lErC01zJaZQ-N1vMHY>
X-ME-Received: <xmr:NOjtahHuizYadM0_NM6VyznXJJPKvuIzSRMZmXu-jHOn72vv2EUO4JAc7l9KS3QKwKNZC5JCIw3pLukROOox0Mg>
X-ME-Proxy-Cause: dmFkZTFQyh8ru2t0v8ZPpLShTxcW7DV3mjcGf/GBvjj0ips1ykNDq1CUxlMDlPWN28Mp3l
 6kgD1lvBLhVpdkUvB2aUVQwvnWN+SdWjOx9R7V2bUzbVRffH5FqS730mqWuFLyIBROf+k7
 Jo4yessTidIwXqbHedutTuK7JBmflht83ErkrJOBDaMUvzSzofiaKkK+HEZ+rf19apmueo
 4pTey+sqV2OrgzBvO6S58t1BP4bj3QaQqAHGeluJq4wtbDG6+nALOBS5yY0DBuZIkCsh12
 TjSVWgMU+ACjvfCURheMTpOvZOSPFkn+WD04dlaUxgfCiXwBGiIF3mzyi/lfye1PxG9eU3
 6qjXbnMWcgt8RCwrJUdRu2pofPKbLBffYX8pFAApvJ2lnK7DREyE+v8BkpVyaQr84E4k4b
 glC9TwfrDaGim7GHrM4I2xKFd0SthQZheuHzS7qpfPNPzabJi2jviyZ46Yc+W91JntG01w
 XuZWR2/S1xHky0TrAyUvOSOFzrs8C0lcpDHxt9atyoWd3l0oLLgsrZ1LJXyn7nTSgGAriK
 58V1PSBjs8fJIeFKATr+8IPSi1VNzhroKf2t65UbP/AWM7XNzUV4jUk4QAakRcDHgVU134
 33PpQBL42fB3BqHafvpUabHD2RKmCQp2iopsC4dwzrFpBgOJoSMKmOuizs3A
X-ME-Proxy: <xmx:NOjtaqDklB5hOc-aBo6Y1RfodjaP5XPjLiGk2cYEMc7OOGRhGXv5aw>
 <xmx:NOjtas9yEJdmWTDl50sbttnqmIJ-QlGJ0Ugmel8IZHlE7N13qqpXrA>
 <xmx:NOjtauBL6FVfbNwonKO_31eHCVtlDyaxuCU_a0fJ7Ny-7mFUxDr5-A>
 <xmx:NOjtapRdCeEg3MzvX4RM_5DgTK2WMMtd0GLjIbD8N9SQLWNjHGanNg>
 <xmx:Nejtaj5jNlO86til5tLUgyDoDjisupnjGN9FkYOBnYO3fQRhs-htg8y6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:46:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, frank@dressler.pro,
 david.marchand@redhat.com, Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH] net/af_packet: fix build with old kernel headers
Date: Fri, 06 Nov 2026 15:46:10 +0100
Message-ID: <0QYqK62ORhe5FY4q6NeRZQ@monjalon.net>
In-Reply-To: <20261106142756.241131-1-bingz@nvidia.com>
References: <20261106142756.241131-1-bingz@nvidia.com>
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

06/11/2026 15:27, Bing Zhao:
> The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
> but it was only added to the uapi headers in Linux 4.20. The build
> fails on distributions shipping older kernel headers, like RHEL 8
> (kernel-headers-4.18.0-193.el8, gcc 8.5.0):

+Cc Kevin for RHEL compatibility discussion.



