Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62862606A33B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=OdFunHor;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aHTFX8Pg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 684B3402E5;
	Fri, 20 Nov 2026 14:20:57 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id B045C40263;
 Fri, 20 Nov 2026 14:20:55 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTPS id D9D6C40151
 for <announce@dpdk.org>; Fri, 20 Nov 2026 14:20:53 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0789E1400248
 for <announce@dpdk.org>; Fri, 20 Nov 2026 08:20:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 20 Nov 2026 08:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1795180853; x=1795267253; bh=+Ezmb/p39r
 Acu39dsCX7aXPWe3w5GK/vEQZrY7L73Jg=; b=OdFunHorI16QnmBUz+YpbMUjh1
 ilh1L02EYeksBX9I3cigCkbg6/SaQrw6qK7Vbsud5D00p/gH1yGLmxQIcPoymlQ2
 +IYt34N2pgwuUeCfZHBzdsLbFKJcmovxc6ablsLR2lmYE75pQgYx1EDkMREiVAIn
 XYeZ5YLuWy0A3CASEXEDcoCSoOEm/WG+6ESj9WwQMhmBYEy8BTw94qmyGLYq7tg/
 G2mdOwxLjervWrTUV2fbp8B5d4bY3F6n8O9gXbefDmLNoOhwEa/n1QusZcfA2muk
 DLtZDivqXdN1haAuSzdrkYyfCGv0+ppZs4qKIk7qptF6xiwVk/jhmX7xiHUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795180853; x=1795267253; bh=+Ezmb/p39rAcu39dsCX7aXPWe3w5GK/vEQZ
 rY7L73Jg=; b=aHTFX8PgZZoa+ULM6J0MKtscIgbvzcHpgjfklM2nJogcA2U3Y8x
 QDVh9j4/6caqWHhtQQn46OWikx6ombNst0VoUFtWnJV2wGrGRwZgZgrym86D+ho/
 YWOZers1rVinarpw3DjGIZbYXoek01yuY5FkFKho7LN5dj6kxRa8CZaFYYt3AX8c
 3woyGxGPfqedeXjQPvGXii51c7tR7O8SeJHSdKkC/pNl+PM0/rhy2c7Ai5aKypfJ
 GRKxAJmT0HS5FsnrkYaDGiCiKKmjZoO64vvYXzgF4YwITyw0krp80Wfq/eoonmNC
 SxwH7ZNIMRaBJ9UplEJpJr+Pbc7/W/4sn7A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795180853; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+;
 rt=PGFubm91bmNlQGRwZGsub3JnPg==;
 s=fm3:rsa-sha256:2I97RC1apbESfXfnzFAw2tqvQBUtxuKZvaY+Up2VFU4CB4y
 MbvDP3DZqKfGlFeqy09Hf0qKehHxsNgqlEj9nnnhATLlOZDYZIJay/VGvTdTcyn7
 CKigjYMGxzblDdLHZf4Bo77ugbRqoiAYZbBd1r6gJnskVTsjO2WmJAgPNMq/1/U3
 bv+Dxi7LmCu5hrEbys0GheD8spodNqBMxbyqyAydXOKF/BnO39qTzMw7J9sRwyQ8
 BSjbQwEebmXurr57VykU50Eq6mJ80QnthVPkEDRjqtquod73pTN1vBCzoijvMMH/
 nDTfv4VRywHQYuSuSDtUx/KkAXpLbUCgOygXMtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:Bhe2YqHaAT+aP6qQwCDv6FYsPc9ljMtXUvz13Mv6qLc=:y5V+S8SFIZ2J6vkoyJgdnwSjRA5HMV9F2oxCqwKPZqo=;
X-ME-Sender: <xms:NEkAa4ph21tTued7wpkf6G1RXGHKyo8Y_oIQ7ivb_ewH8Nj2d7phjw>
 <xme:NEkAa0gV4D8orsQe3bR9T34pGoVB9KNrB6NSGViNvaLzG_tIuT0Uc8dgNBlFBFNSi
 3K22zguAZUWwFCTCK68oNZj2AJGfVE0GXJg6NkYesPw0TEuClOBOw>
X-ME-Received: <xmr:NEkAa4SMmJyC38Gm-0hkKtc4PXI3fnyWAycK9GnDU3AasC69UHl6s2HFETpHDu9DTixcnEx0u6-gFOJqPZYWrck>
X-ME-Proxy-Cause: dmFkZTGDQug+u/mNKSmUpLbxZwmDDLWK5DzWoS288rFUmgJCcUwyEe0FLN6NhAJxB3Xcsw
 tnZr2wrN8/YvbP85EgBDiPwCZCla6kmXB8ms0SN01kx7cazfzAWK93aH3MC+eijFU9Y+i8
 Xuq2siN07wfT2rS0ywu3GYh/6NuJP6VKz1r3SnRTxBl4HFrAJXGzHG9KLfN+cRjT8JugYP
 Q0ZkSJQEFB8uzE5YO8pPHJl4OLVnFT8pnss1vS89U/krisNew2UuPCCM064P9nsPh9YSwf
 Jk1f1uO8iU/Kfey+X8i38ue2AN8IaijPS6eDVAZtp87Q83YfF5BGb4b6mu2FziyK1aErAJ
 xQQKpNtVoQQkZ30OJgvVkkUZTsL+qpg8k2hm4wDs+ovbLenv265Kv7Bn9LyX8QyZ7fSzfl
 gOOtn6wtDinzMy7dFMwZ6ij7PV11HctJyIwzq5g+q6OKA4PhHQUgJMDMZPgT9jGWPq8rzi
 Q47ZYaa+ps4J0Swqh2hNEMmeyXiw37ZOxTQTem1eEoRFBRebRGELV41SeoTllVCJOZGV3j
 DydApbQmcRIXCwTDbQrcftOJsfqbkYOFDyDhYHGhejeDxMV5Z7cjmrVj8aelCSeOqj0hhz
 nscpeBwQU4AkBOtlpTkvzXZbzThfDymAs6HZ4b9/HRSxE+srDCv81ViPqOXg
X-ME-Proxy: <xmx:NEkAa8uAgmMEatcnXzS-P6nM9C2zSWCyF-fenMBWNGJRswzibZUKIg>
 <xmx:NEkAa7ejjd9Uwr9W-mg2ZpRVp0_UFsP-1ZWOwD5op_VixhPgloQm5A>
 <xmx:NEkAaxKgjncUfuKS3oVXZNIcddlafGgQ52z1hIifzeYUyi5utNoO6w>
 <xmx:NEkAaxZJR9mUe4GqSmv_qgBvYoC2ohODs7U80TECL-i9P63qTvUaCw>
 <xmx:NUkAa6b3W0MJ7jWWFVn2CEqKgZZTeEDtXmwWExxK7mdWx-2xtJs_TcUY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Fri, 20 Nov 2026 08:20:52 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK release candidate 26.11-rc4
Date: Fri, 20 Nov 2026 14:19:50 +0100
Message-ID: <cku3Z3NASyqANwzCcnMu7g@monjalon.net>
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
	https://git.dpdk.org/dpdk/tag/?id=v26.11-rc4

There are 44 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_11.html

Please test and report issues on bugs.dpdk.org.

You may share some release validation results
by replying to this message at dev@dpdk.org
and by adding tested hardware in the release notes.

We'll close the 26.11 release cycle
once we have received enough positive validation results.

Thank you everyone


