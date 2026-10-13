Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE25FCA9ED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:44:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF6DF4028B;
	Tue, 13 Oct 2026 14:44:48 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 3643C4027B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:44:48 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A77881400156
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:44:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 08:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791895487;
 x=1791981887; bh=uQvLTgZiCJuUBVpzRaHsY/yDRjxExOiKkNs99/WZA+0=; b=
 bR+5h6j+NU7E3GIYYEACKFEGGlm/w0UmR83mVO9+htTf9ImpNflzKld4/AZe3Lsz
 DEH1kZs3rxVvdAWvPFX/rM8RtG5okvWF6ggzAEsjXcEfWOs0qYD0jCLM2y5j8xD1
 ZDQkvSNRMEEW23saS3zvDs2zffPXSOtn4ePWEigLyYvJgGcSrIRnM0CwXpqtp0kr
 lBqyMuD6RaZ2WCzOO+/7p6x6AsoAlCJdanrspRCMFVt3m6RVZnAigMUszfDlzRKA
 MJTylKVX5oXIQ6yp2MSaOghG2i3RJjEho1FhK2IT7I8ShjWpEMfSRnYMM9hsOEkD
 r9b4zZdm2I9te1e+kRoCaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791895487; x=
 1791981887; bh=uQvLTgZiCJuUBVpzRaHsY/yDRjxExOiKkNs99/WZA+0=; b=w
 SPRiGn0Wo/y1TMEEK6pT3U26JRDerqEGIZjMwd6kRB56Xn6US4/WukWQ8H5Awnsz
 34s6VhFcc3/8yf8P5BGT5/QB6SMdS+8Ku27J4IZ17gSh/LcYtZYFnp5huSd8STnc
 akmRtcQRGJBZ/uDEUijmRjnrTnEyoicm4aUA1JMdhI+4/U4RAg9nK2PBK1RUazeB
 HZN2vnPcMMG6QMPSoLL6Z1QTBOqir2o+QA/fd0Y4He/s3NEVNQB/Wj13ZuP3C5g6
 xN76n4gjNfsrrGK43GpxrnRGp4sGqQdCitzDb3kxmH6QjaCzNXDrj6M14atIAY0h
 x7yLIFs8tPXMn0/etBRtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791895487; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:npPxgRULwtkjKxOc39zLxnXkkAQ5o93GmLXzbUQ+svYg93n
 8orbB8sOF5FFrqCnqy5B7uJQUBv8kXHzh2rzRhePLL63iswZNcxziSe51vjgqYrs
 Zc0RqI8OAVMZKlCM/h0D1wxncvKMfNyve3iE92Dm18JKWOBwQRSYAen7VJgCgbPZ
 lDvI9TCcnEBE/JG7NuaFWvS6W4Rf+QkGKdu3zmpOrMcta6p7QidND7bn9X+/p/Ar
 OOq6hN6/UYBI9HxzyUofmB2l0/Gxzu5HmJROSzeaWi1bRFZ6Thk28PfK7qnlePHn
 erwMcm91QNmXMoB26yeU0OygM23PVNz4ToQJn0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:i/bXOclw6qgMr9ReFhA9j20sQq5OKR42S7bvZJDhCN8=:jGUWSgEplbC4uk8aFj2tHoOAuoxb5QhsmAfen8lEPTI=;
X-ME-Sender: <xms:vyfOajdCFw-Fa2boIwtXdNaT-yTfoOvy3iEliN5t8XQURoU7ninXeA>
 <xme:vyfOaliIw9CO9T6OuMD6cy3rb90p_2Nc4W6ROsV1alUT1uE4NvzvqnaBay38mNINy
 oHG0gUhQNAr2uGtTemR-pcpV3MOnyOyKdL06DMLPVZ8X7j6HggkLN44>
X-ME-Received: <xmr:vyfOavQm35_DAYBnFOY4zcUIy-tay-gEeuIECjLDVTX0QvNMz6RCQzAbL5BnkIGKJfkj84CTG3_AZnkXNmYn31Q>
X-ME-Proxy-Cause: dmFkZTEb4qW/Z8qIXH46Pw1NrkTLxzX2rNXDF76/vKlrgJjP46XZ/eWBkKI245E0qbjrrM
 oL1q4yyFqJ8LRQ4iYcMqCQzDGBc+8YTK6A/Wma/+n0902TT+b+ADGyVV7EjJZy0HeLKH7P
 yYIMzAwjx8kn57YIsp+5nLUHb0h3ToMGiWLrR0pCi7mgBVGi/ZTVYUO/Zxv+Yr+Xfw/3pO
 0TTGnNBLcu7vapeL4jFsen94r93KBUc/YAne5ovbIlIFUx1OSQWnXJl6hp5ugaHcivFUGN
 BRoZ4Tbi22z0hKGAwJIAEScRdj6N5i8ab9ln6w+6G+id3BWsg20J+fa/9m6ThZHof2RfrQ
 9DUZx0wlBNSfFNEKA124pRUhBJGpyhzotyDXgxMC5f8uQhwk6KN4Km0/jbMj6+k/Jox7lY
 iX21sywzJSOJpiqJcKcfoWjAyml7ZqSRJJSQYsaiZqrGsCZEjgShQRRywzCaAUglAQWpJp
 wx1Sbp9xhU+25HUfMAYtDqpIGK6v0PPwR3wNc6oeDvrc/im44KdzjPOHefR2ZVOdMQb6vA
 HL34uygq1EPtiSLGV/2Y7eY6ccF++d+yayqRtS3/evblZe3Tef6TBGep9KheHzG4O9ZT4U
 1aznoUeRlmllc0sNPz5o7OVKEhR4Zy5JpUOduP4xUIsDyRRoZC0wYoyb5dQA
X-ME-Proxy: <xmx:vyfOamxthuhb7x-XAZMHmnSbqeutozTu5vKOs429QG5v8LALCv9Tow>
 <xmx:vyfOaieVZIOUWIG5qGamqL2fvHgQPb3CnRsJHuhVhZaB62QZ1UeH2g>
 <xmx:vyfOaqLUosnND3b5Sc2p7fgSASJmFF1oQ0x-TFvlhVcnsdfNSTfSEg>
 <xmx:vyfOarGSfJBi7ChBfBp9H7VdnBVtC-7R2xvATamtflvu7yaQ-gTZmQ>
 <xmx:vyfOam8pxXz5M2tKyUCAL0av7cKU7Dz8b2tTLsxSQx-4CzuxsHPOQTv4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:44:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/3] power: fixes for amd-pstate frequency scaling
Date: Tue, 13 Oct 2026 14:44:45 +0200
Message-ID: <nu4pW9zKTi6-BOftSg_2mg@monjalon.net>
In-Reply-To: <20260908165447.450006-1-stephen@networkplumber.org>
References: <20260328193419.106100-1-stephen@networkplumber.org>
 <20260908165447.450006-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

> Stephen Hemminger (3):
>   power/amd_pstate: fix frequency matching for continuous scaling
>   power: check for errors when writing frequency
>   test/power: fix nominal frequency check with amd-pstate

Applied, thanks.



