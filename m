Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A702606A327
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=yuTWapFS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I0FBsNid
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83ED2402ED;
	Wed, 25 Nov 2026 16:33:02 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 6324E40274
 for <dev@dpdk.org>; Wed, 25 Nov 2026 16:33:01 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 58BF2EC0CDB
 for <dev@dpdk.org>; Wed, 25 Nov 2026 10:33:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 10:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795620780;
 x=1795707180; bh=hJTuwn+iWsntMnm/xKX1owz9f8qm7u/OZuDVqcEHoxU=; b=
 yuTWapFS+fUiIE0REgz3M0JE4qP2YBqNfUU9ZLx95y7zIlfIyV4yQBDE7jxS80Yv
 EDbUF+C1UCJmjACaucEWoWo09ft53s97hh4tV4vl+wNoyQDy0tryBjPuJ/Z1U6gI
 mFMv30q0WgXjVWqV9E3H8aecEEpjIA1lEJZamPlGeyGHEyGt/xCgCll7OpoMIUiG
 HFA6eFr0Wy63ueiSne11JLASLBxf2ErUMsGpAB5UUsj10hldJfZEGoAr6NMoBMgE
 hC0lI/zbEeUUGYZHi9350UVcS9qdrhkh2Tvt0t/ITcZqc5vJsfzLCqRGNEyZ0nwz
 iOnpqmqF5RG0jgUigdnUpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795620780; x=
 1795707180; bh=hJTuwn+iWsntMnm/xKX1owz9f8qm7u/OZuDVqcEHoxU=; b=I
 0FBsNid2j4EILMSnIVprUDXVwk1X+oVQSgP0mAQnDgG5OCXzO/iMw0JcwJwUf8k3
 L0N6Su3BAJ95PLQcQKk9ZRnIX+/BLVHE23OBUigHfk/96uDqG2WBkkbKDc/z3Lok
 2XWH7mok7nuKdMK26p91S/NzeiZi/2JN/bO3S5ajr4M8q13LNjhFQHDbH/HYAyWh
 vSKVgaY4rBC2LB/XLxukI6DtPInh43+cR4TjZfDG9xGvSchRC1iASgA2SUYkS2rc
 iAeFN+aq2M9RBT57NYE54wsEr2wiF925N4PCzYZtwWbz1J6Tu58Zx8jgd2WIfTdk
 ekWSeTbW1LkTTyNJGu1fw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795620780; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:0N9WRaSokRc0EVYexriwW7gXE7N85CfRnGepjqtj3QJ4g26
 haNTjPE/eoJzjw4ZKcLhtxuF4eTHciinf9qd299zMWPJYyFZVojSVwTQkMjHgp8j
 aCd7R1rBVqXU8ANoZBm+Q5Y6Ypdht//KQmjVEPamnlgfSzqZPHram/D4LdPhSgah
 9nHqWf7SYhKX28ufzEZR3E554p2iZXRTqdiBY/vPjWa4egvebuXThgfFeZj1vBsC
 CTM+7BVEgXuiK+D7bI+hFiOkCrqifybxR7eDcatmVTCm3DMilyHMpen/tEHfK0zC
 0izxm4O6a69+Ykk7IpxqC1ZJghXIGtGZHCkMVzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Z+x75BRi9AsRAv+MuIeR/aGUibNA9GieC4lgLw7beLc=:hJTuwn+iWsntMnm/xKX1owz9f8qm7u/OZuDVqcEHoxU=;
X-ME-Sender: <xms:q_8Ga82Q9Bn3AG3PNtzhGILz9ZOjtTfTjELnXT5tUk3h7wQY4ibvJA>
 <xme:q_8Ga7bAzaeJkrZTKemPAsw6Nje8dKkRgkgUg4FbkQVcbtV588R4aYEhx-mZXabW-
 oNznL1hpc_4RVZHEPlJtlC50iaBr__7wkm9OKSX-Tvj2_hrctJw26c>
X-ME-Received: <xmr:q_8Ga0BEG6U1zC491mkZ3iIHri7GJfzom4aBbByTOqrGnrOxZ_VTLeQiZnfII0UHoDB308wy2rPcULkOhEAxxUA>
X-ME-Proxy-Cause: dmFkZTGh7i+h6xu59uYD2JxuxcRqNjqZEztp4wQE5sfQG5fPAlhc47PFD3mso/mqD42SFX
 5h7eTvY4fkXumQIgdrkqyL+ksbYdj/iAmkBU4h88vCibGxCT1cFpinablykp7ZutudqESz
 a+AAAFni2Wgp3qVUagqH5AI5qR5fyh5GgdpH2dWa9YSAvgovJ7Xe9+u18Jc+jPZSJimL88
 TQ0CVtjAQSqfkL2l2HULIg494FTRke6AvBRClKl4SuF//SpByFWR0zi7P/SWKzQRHHSV9Y
 cig69Oe7wZBA6EDBQ5tTVUgIUpZ6i+WmOIlX2Goec3RpmV8M+pzjngSpjL5OwOg/+Y3lgh
 F/f8plciGzO76ndJLp0jUpRiMg8yhEAse8hQeJ1lbUYgO+7cTY5gv6VTJwaA0z7OdykgUM
 VguxEp4o3pJsXuVNB/xm6lfALzuXGWIQedkQERoEa9q5WaY+nYRFrlFau/yrshCZz2T/Ve
 d6vvKMKneTQ1WSn/FzPJUFhCEy9k4tD4py+/FUNB2NTQm1t9W2hTU7WwPeFwZVEepromrx
 1EefDS4QMw2ENnjQDynnkreXvo2skbh1WcD5L2wD80vxPunS4JHQlFweWiTu2/V0iKjfSu
 XUq5F4lQIwPAMiM8GkdiVpZ4d6aRgMV9vCA3Wi3QNEeuLop8tImlTNNIPB/Q
X-ME-Proxy: <xmx:q_8Ga9-Gv-i8qPggFuoWhc10ljJN2tiYFOSLtzK7X0cVC8PIcGmzgg>
 <xmx:q_8Ga0_PyhjvZW-459t0tCNWDAT-tph_-Hlyf8f5vZzItkbgE3QRAA>
 <xmx:q_8Ga0fCOUz8O2lzslOVZ9yL8wRu8IIOL0dS8UxkIxqDf3ZFiDMjww>
 <xmx:q_8Ga9H9-G4G8HGaTnDv37H9QsDWD56wMXajpadYAXNrZrsCJ-RnLQ>
 <xmx:rP8Ga6MnoNFR3B-JHcM5buQ4UnOdfNjhyNa4gARnLNfxcyFEU4EjshsS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 10:32:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v4 7/7] doc: add missing headers to doxy-api-index.md
Date: Wed, 25 Nov 2026 16:32:57 +0100
Message-ID: <5vPKTCp5Sn66gfsbe2E_FQ@monjalon.net>
In-Reply-To: <20260721145841.7424-8-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
 <20260721145841.7424-8-marat.khalili@huawei.com>
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

21/07/2026 16:58, Marat Khalili:
> Make sure all public headers are listed in `doxy-api-index.md` to be
> reachable in HTML version. Presumably each of them should contain at
> least a general file description, though this is not checked now.

I'm not sure having an index of all header files is convenient in this format.
Doxygen offers a tree structure to navigate through them.
I suggest we simplify this page to become an index of main entries only.


