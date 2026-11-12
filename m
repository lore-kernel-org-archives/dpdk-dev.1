Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134CA606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=U7pRpqai;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=f5ZiR3zd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7EC142E56;
	Thu, 12 Nov 2026 23:08:27 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 43BDC42E4A;
 Thu, 12 Nov 2026 23:08:26 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTPS id 82711427BE
 for <announce@dpdk.org>; Thu, 12 Nov 2026 23:08:24 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 871B81D006A0
 for <announce@dpdk.org>; Thu, 12 Nov 2026 17:08:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 17:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1794521303; x=1794607703; bh=sHT/XuLZi+
 bGIRVrqDimMLp8mskUsti/fKGu37WhBas=; b=U7pRpqaibuuJQ5+mpjeeVmLsKe
 ey8+i9GyZBNKR/oHFbLpaRnPIhwtdW4Rs5p2zWmD5zrRXS/oPtvGJOQMN+rn9qdx
 Z1HFUJEWsSccSPAMKZ4IzTiewpBK14FFx3UbsJfnKuo2w00MVUtlva+ycu6DvO2j
 BLsxKgny8Nr3R9/bNK213YiW2SY3Ui5twXKUgASU6c/vGX4YYZaGGw2IMg810NtY
 wMl5/ip2HhMJcwWHKY4tJEBCPgz8Rh+gJWKRN+zJPs1EnOoqBbquBIx4uvIRK0DC
 fjy0JqDRbRCFP3cmI+bduaW6BBiMN3fyONWkj4kBqeQUf2kAxlbtJS04/jsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794521303; x=1794607703; bh=sHT/XuLZi+bGIRVrqDimMLp8mskUsti/fKG
 u37WhBas=; b=f5ZiR3zd5+ha/uUE+d9yclLGu7SyjHeAlgMy0q9NgHi71yVdtbe
 BmpvU8NovcPIklkneGoQc1I6P3exmtQgdQ7HG1+kgonuKYWfhgOFad/eIPVIlFVx
 PRKTzwzPTV/MBRaOpQrUJ1gJ5q/A3tXuzYkQV1l0kD7rt7aqZro4enPe0kC1uHOr
 glf6D1PL/nHblZVrvOUtNGj2YiLobAeplt1BUNgePUMwocL2UQYvdqfcJzu+9b0p
 dauZQ4O8klUlW2bddy3XctSWcxc+dRIR4aPRx5l8JSOD1UhDj5zXPgid9f9/kAX1
 MnHueE0eW1FqhwfYVSyjN+nI9QFMujA5zzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794521303; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+;
 rt=PGFubm91bmNlQGRwZGsub3JnPg==;
 s=fm3:rsa-sha256:H3itIB/oNlnpuaJ5pK/ixeAonCzs9jB1ySzwqDDvr88zhKO
 Ore2Ba/BY0GEGG5oXBKVpSHBLoXteqNanz0HfPPsMICr2jd9JBTvF0XFp1S/AA5/
 Cr8MYAHtq/upSQQk52ce8Mh5ShRfrOeHnu8BdgfPnvdPSkjunaMFk56h6vZiq0CW
 vUDIYYgJEDBsjrctx7ruzPM5WBzofzH8CyjYzvq+G+0I+Mcvt6nV1TmHJ1yGJVQI
 lo3LerGLZIs2oB6GXTEbgISIBoUolf0XdUKJFH4mdlr3B0vk8kVMEmGlBCoEuVo4
 nxxTOJdPkSDS6dJKL1uNz3Bbza+zqsBpDbtbjuQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:f5P0LK5aOuRxzeOnr8CJy5bQAblI3BBeDMYjqn9AkiI=:r40xuA086tYlFcSymHEni6494BTqqjHTqayXkLwcJk8=;
X-ME-Sender: <xms:1zj2amu1QlYizShCMLgvJWsA-3nFxg9_p1M8yWx7L0rPwsDG5sqBAQ>
 <xme:1zj2ahXypiTr2Cn3p0EIqk_1x8MngrY2YQuoCS2M5GNBF7znlbGrO3BlE_y4Sur3q
 soD_FGCHPUlMHARxZ8STcVg1pObECH9ZsNyzl_4hEYX9-enxnmHng>
X-ME-Received: <xmr:1zj2as29oAJ0BsXNz13doAc0_GA5CSh80tsIDhG0-wHK824jNJ0lJh9YD5BWsGv0SK7QYf9OEOBWjZCj66EWOXI>
X-ME-Proxy-Cause: dmFkZTEo5GME3y3DT0viy7JpdH/TywpbWtXmA9F11vFRawU0HYK3HZyxEQIBHLA8oTenc3
 p4CIS34nYqT6WTm97sgaUOrCYRIkldX7vf2CNUB+OdBndlU662O9ILEn7gm2tQZtGGTF37
 cBmhVd4FRIG4+ZROAjFNyQ7kD2+hm6gTBcz2vaBR4kqDMpKE+ed1NSyQaE1kfDoP1dOC5w
 CW55WvVkD3MuRucwFr5w6ZYZQaRh6yb/gK7cpei8QugHR3aJ9YrHOgUk0ke4IzJ5uZmVF8
 P7U8KR/R57cGBGN94vljJ1Fhal3wUmo5bLt5ksFCg51JZpg0www6bHlpjrPmgVMCQVDdSN
 ey4ULhDvVNj1Fbt516r1rff/3gS1Upfg+m5qLolWtbrEgmz4euFrN5l1C9XVzfep16/sYq
 rtqnoc6CZ8kkEl02kn71kCRYvKGNiwVANUjPQFxQDyGC+rPYSRkg5HLapMdbG5E3wP7ztS
 8mqKz+iDrBOorfZFMFi5HFWZYc+2pLWD35EnAXfniZHnbE4glEgKfno793bOhDG1g6NvQ+
 eb/0u4e9bsT7NfDx7bUkyqzXU+iU7hJGJO3q7I7IU4hKZBZF6OTpAimYiG7PKSmQdr1B2U
 VZhfduRycZjqKk84llcGXIGKLXk06s/t3/Mzrs38a05g/UYjVI0GPlWck4uQ
X-ME-Proxy: <xmx:1zj2auASk-6hCKr5IliT6dUJhiKAU4E-WH2TIxeBEnuIToh_2C3Vjw>
 <xmx:1zj2aqi0NtqPcfT8a5dA0xhfjIgimhNnFQ2n0EfrtKgxcgxxRhZaAw>
 <xmx:1zj2aq9c77KzG3oqRmJQ2JcuEF8S2YexbHiyNp5lKf3bKDsGgzQMJg>
 <xmx:1zj2au-lqBE0fIvl1tHmqNLyCYdZIaR1N_2gbPkFCcBZMPk9XsoviA>
 <xmx:1zj2arOhd9TM6NNv0E107fqAQJH_Ggh4CaYYsDsB3wvr3i2tdke1jF1a>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Thu, 12 Nov 2026 17:08:22 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK release candidate 26.11-rc3
Date: Thu, 12 Nov 2026 23:08:21 +0100
Message-ID: <RBroyiAPRh-kx6sUEfHtWA@monjalon.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A new DPDK release candidate is ready for testing:
	https://git.dpdk.org/dpdk/tag/?id=v26.11-rc3

There are 160 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_11.html

Please test and report issues on bugs.dpdk.org.

You may share some release validation results
by replying to this message at dev@dpdk.org
and by adding tested hardware in the release notes.

Only documentation changes and critical fixes are expected at this stage.

Thank you everyone


