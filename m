Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD485606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=kahzFcjs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Fyk0Li9g
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D95FF40298;
	Wed, 18 Nov 2026 22:40:51 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTPS id 9C15E4003C
 for <dev@dpdk.org>; Wed, 18 Nov 2026 22:40:50 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 7B4291D00297
 for <dev@dpdk.org>; Wed, 18 Nov 2026 16:40:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 18 Nov 2026 16:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795038049;
 x=1795124449; bh=ODPjNu+BfJlT468JCTVUHJ2L+FdmEYf6qEZomjETgfU=; b=
 kahzFcjs4vIigL+29zgLltoqScJ73i9EGpVUM+4Xz2ugy7uUTLwzty8JqI9AM965
 uJUYNfGmojuZM3EaG2v7sIxLTBUjQa8S+wdmlYq3nC+wihcDT8f2ZYxABGlezXdt
 Hl+ge6JRYVN8NYwebg/ymtnRbLG1WLhoJEkuS1OA/MXizY1IYYokozP6SdbYFBsU
 AonpXkN4j97+T4hRcDWitGU2MArKERN4mAVskWlIBHK8UUctHGUv6eLpez7vTWVa
 IYQ4VhFCwZuT58N4+FQd0rfHGvs6oWPHkqwrq0aNtDVu4FbYhG5oTSR8q2ry5RFS
 kXwcucpSOXYKnDIgzXd45A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795038049; x=
 1795124449; bh=ODPjNu+BfJlT468JCTVUHJ2L+FdmEYf6qEZomjETgfU=; b=F
 yk0Li9goFw64eJKjk9PtN4BdgVeExUSj0MtAo90kxtcCL4ikokbFmJC5fRLzzxbi
 JUzl0J3/g0M0kpcm+xwPUk0JfQ3O1T/xqC1V3zD6Zy5n7tSyf8TTRg+lTc46Jqd6
 eUz6sEpkvsmmORgClNhnmQZQ0JU0O6kDHKDpaZrTz3ePKS+NGskJ1T1eeGbVWCVu
 5aeLaMwED+4+VaZP0AZ5rlMhYlAGBuQuqODrqRdb1DSG6e7juv4srRzvbdMtqxI6
 G/cs/IbpHgLC9xxzDlqkSFi+cmGHDpfnfO9tlMLlqFGwpbSRyNenVewhRYjKqXw1
 rPd+JJ9HBJExiHFA+Lqew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795038049; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:G2jQuCDYFUVU9cPgf2If3YxtGD5I79oIxJrZdTefaZMmmfk
 qOOYX5YWLFtDUgO2uAv7kWFKhd/gLCjlcuYFXqKK4htrxTOm8JN/XoQ9MIZFVMR6
 lYC83g3v1Il1f91M6oLmq2NLz6nXf2vN+hsN9kOiBN1EKO3S1Z9kPRPAxEGVJRwk
 aJuzUZW8fwiYTUe+UJvo1PPNR3aeTdPVXNSOH2FkkOfUpoICOEr172OTRp3QyEJU
 ZdCzpcLAwUd9Yst34ctEHqmGBLlqR4k6YfSqRHKxLMTBxZPZlW454wS/9+9FDi6C
 s4qQKXMXXMJYrHpShHbGcBFMSdmj2qVloE/p66Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:7dtNSfljRMH26nUoZKs3KbK2LrxKNc7UORwUs/kXA3Q=:brw3i9egglXEn8VNdytAoA1YGRkPLBPD2FY96D7J+nE=;
X-ME-Sender: <xms:YBv-am8V-aNbgde02lzmQ8TkU6iQ0hR8jSrFlrkLYNyR82doY50k9g>
 <xme:YBv-ajDHTmAz4Hj0TQfpv_BD6grVWseBv81ScVEFs6bdpn9ZRv3rXUAT2r88y1Q0T
 BeAJfpj6grjTTiawYzXUNeOE-AaWO5VX1bY5ht8CdUknbL02Z8QHKw>
X-ME-Received: <xmr:YBv-auz4vhcuOjfDYhNjD3wf5JHSvXPh_-6LiSWnH_OegetTBtpBD51z62PGd_S6HHcZEGwg1S1Pw0EikJoTvsk>
X-ME-Proxy-Cause: dmFkZTEfPdFzo8ey5e713HpMqYX1uNX57dhtm3kXSvLW+UqLJv5TlZxAM5F+Db2C9VuY62
 OaIg0wnPMKm9Rn0VHAxPuuPPUixoGOXoanTyrKM0/KE1HhHiQAWv9qhusAXh9CPlArcDci
 ijxWYGLABBCLIy1RX+32WsLngUzWmrkNR1aB4adpSpBQflw9OyO2ofgHMT9jVYsUOm1tHh
 vHmDJWE4V1YAAoUTgU26BF1mxouGXegmJscd0EfAIX5o/VRocAHMJqXfbfsC0orCfBZw/G
 fVb+xX3B99I3//VCFGFk/+2p7/04eha0/r2yMqyCGZYU+kmSB+MxzHxxVWdOxWWf8mGEGi
 nzaaO7leVx9xQIIqS5kYJIReS5rtEf57vQEBOwiJTInQj1ohk7HWT9aLB/5urwZrS3w1Oi
 RyncBVbC4LJMXn8m0mIp5gYc+rRvSvRTG5QHlUMBOSZNAXNTm4+/UKXl6ELt88+vT/6kyz
 QYwKUwtHZiSOOSI5tVKR66rQl/uyrfPlbMIbVRWNGwTgLKvXN0nWoBdKNYhCZgZ/+ifRSb
 DL+WmUs0Vl6HZs6Y//oScs2Ar+4++tldTUo0zQO0lCJcVTfrgugki+gkq/IqjjluT8CBuS
 MxgOqtTrYiDDimq2eiiWnabstYBnVaBw7uJxfwVMpidC7N+KGZ09GuH9Tt+A
X-ME-Proxy: <xmx:YBv-agSkF6plbq_WC9U8XHl_aO0a4l9N2r_w5UDbUN8MztImvwLEjw>
 <xmx:YBv-at9jZYkmleXHfP_uI5GxrOGw0QL7Lui_PcLu3ZLwPkwaykV6Xg>
 <xmx:YBv-avooVDMBTUvySKJSkM22prS7aLygUasHxSoasErfmzcZavVKqA>
 <xmx:YBv-aimM5PPZeSiUApII1Ahdi_83pkqX7DeDzl_pMtq5uIH8HXVHww>
 <xmx:YRv-anKQMhMLDeiLc_wDjjHDPFrCKAO-9xWwiZS5TeiCc7ZPtv1ErAJ8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 16:40:48 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrei-Niculae Petre <p31andrei@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] examples/l3fwd: sync cli options with documentation
Date: Wed, 18 Nov 2026 22:40:46 +0100
Message-ID: <baEpCnydSf6bVr4v-qkk7Q@monjalon.net>
In-Reply-To: <20261115215657.14694-1-p31andrei@gmail.com>
References: <20261109004913.72418-1-p31andrei@gmail.com>
 <20261115215657.14694-1-p31andrei@gmail.com>
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

15/11/2026 22:56, Andrei-Niculae Petre:
> Synchronize options between print_usage() in main.c and the sample app
> guide documentation (l3_forward.rst).
[...]
> Bugzilla ID: 545
> 
> Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>

Applied, thanks.


