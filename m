Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CF606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=aC/Zyvmj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NQ0v4qUj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D90B640EF1;
	Mon,  2 Nov 2026 19:18:38 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 3145940612;
 Mon,  2 Nov 2026 19:18:37 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTPS id F1C314028D
 for <announce@dpdk.org>; Mon,  2 Nov 2026 19:18:35 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 0D1D2EC05C1
 for <announce@dpdk.org>; Mon,  2 Nov 2026 13:18:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 13:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1793643515; x=1793729915; bh=CCnZuY9QaO
 ekrzGzONSvNj17PUNXB2Lf805WFbVdA+g=; b=aC/ZyvmjtoP792lZK83Vp3K1zF
 RLtWF+Niu9JzvHcKmC0RXJiJ5geU7xpiOgt0PLq7DE/GJ3s9hCxrNbWpw807Vl//
 ujJvyARNwfqpDtdc3vHmgWR6tnYSUqrsjqjUYonU7mWX6g42BctCOrp+jkpFVHai
 XfDr094VHLjNHThdgqS17H5OZptDBnupZh8EaQNH/bsNTVt31SffokewUXcuhcHB
 aX1hrUweZTKzAn9ytnlAMWrW9J3VT2+aHWc0Z+kRzwfni7zTMTP5ov2MxbkbZuLr
 215Pl7VdgDK7Sc6Jexdw0KGj5Q4lW9H4Coj7bGLHKjm7vYtoM1MydujH3o3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1793643515; x=1793729915; bh=CCnZuY9QaOekrzGzONSvNj17PUNXB2Lf805
 WFbVdA+g=; b=NQ0v4qUjf45/ixpFaR1rp7q2OvrMNC0K4ewX8TpEp8mNtUMPWEB
 Q19KRDlQIVTv0ZP3+SpmpqgLiYwhC7ChHi9oW6Eul+vktrsypuxUn4Wf9CFwRxZN
 PvW7P85ueCSp3/KyQy4HPapE6xEWZJ9MUW5qNvux/Ds4TXhlTZqKjEHV9OcD2BN5
 DeQfbQNE1Y1vVkVenVLAvWais15Nq/CkeyWXz2RybWrEMnHFnKeVvXrblTC+dvbd
 XvhY+XbF/1W1O0k1M2si0vZKAPt74xA9jszSVHUjY7JSiom0BB8gnDkr80fJMI0y
 r6VOp7gbCo6cLyy6d7du1rtZlyr/PEvytCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793643515; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+;
 rt=PGFubm91bmNlQGRwZGsub3JnPg==;
 s=fm2:rsa-sha256:Nb9qPgxgvcOLyfJ0uyBtPEgzTt6OqNzl8QQBJpeQdRsKe9/
 yeZhmlCX10C4m9reHAw4DDyovwceCGDsQipu3KiEjpY+oq09W8yfKfhhMvPIkIaX
 VOi98htGMlyyyPjZUUsmsryAwr5NAYy2iG7BS/EVQ6UZP1owd3LiSbanDRj0dRU5
 GZhhxx3lzpMyw+gRUHtB8HpwlrrzPElRayB4UCJ9fn1dLYCK4g6ISIg0jUElJ1G4
 oAA5plQj7Gewxxmiawt3MVL0F3W1+Yu37JlkcAB5EkooVc0BjNwvucbAUPfZcZcs
 40+z80bdVuD8DnPdxseH27yWGQHIN2Opy8BWe9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:3jx+RMkd08jt/3DiiLo77Oc46XJdZp7aLEUnEfZbg0A=:uSe2c3x2wAPe7oNie+vKJi0KBxKKkZnw9/1wkduon4U=;
X-ME-Sender: <xms:-tPoahOc-e5VNsm4t839UdmHftQig41HnDVcT0boIt9JuWR18Wcb0w>
 <xme:-tPoap0XotBprmttccKgOq3tzWkQHpMceglIB0xSm-Pusei8rcTu5776vYl7sQMFo
 ww9buZscXLfMawY80Pi427bw5AoawUytyGf3kpKrmQh3jTpMXSsmoE>
X-ME-Received: <xmr:-tPoarXop2nqEXrDjakrQOFvw5iNEQC23F7mD3LIqwPT45g33H1znizjSq8rvA>
X-ME-Proxy-Cause: dmFkZTEcfAehiqdRfFFEFf3LkyUz4HhcQSn0pkXz6k7dKjCziKCbwmcwswnrHWzHam8/oY
 +xXrfaeBa3v9+O1jMFfrN2n6XR3Ofrsu4PAbHeau/Lxh8x8Dmh5WEzSwBH8F+4UO2c3FOd
 skNxLFwIO4Ka5cUIgyIEzH01Ndk+kHEhd1MCMHLo8jFbU/uq5V2z2qHnviH8Mv8/d08FDc
 GpwbKD4CtAS+Ga09IprgC3CBtnK3dZBthnThNmw6gr42X/UWjang35K5o2NupQvJ3Ygpmu
 4ouDBAWtbywHgMNnZGHXzU/LIcgSl8xusFdj5gWkdr9J8vy4CxLU2Ah4lcMeXTw64PuVJA
 l3AnrmbrDmKxDROEj7s00k18sARXfGVugQLib4yuS/B46hQt8+owm3zyCjQmiZo53U+QR3
 2FF/txvdFu8dL/V1QGdVCFHvVGxSx4KP2dVJmVTPAWG8d06c2C8nidZufr2YD42q9S84CL
 RSFyFhAFERBju1i9CyWGEOK/r7kGwGX/xlwIk1QaMPxvx3xOtVW1FogjevUAlGdKlSerU4
 cNa46kiZqWxbiBy+zTC5VnOVUerqRJvNxNSUpPj4fRkeI/PRCTkPnhMfkoMUDax4ADzHQi
 ntKkI+LllFZR15aveT7cTb6SCOr8+RJQxO49/2LPOQg/PejF0xBxXkMnlhUA
X-ME-Proxy: <xmx:-tPoaqjHDPuL0-b6kt55RZnhFzxr_yAa-qroQIbaCYzlSjw9NLI36Q>
 <xmx:-tPoatBd1JrKF8GCBtoRH5FlUIAMzrubtjtgskfWJN2digfW4dvCGA>
 <xmx:-tPoardS6vxoXv_52dOFzWaSma2GMMICbA0w5ZXt_Ce2cX2jyNYu4A>
 <xmx:-tPoaleX7skFyXY0KSHPzo5Q8-EQhBU1fJ3BSTkUuTHDY09neaL-sg>
 <xmx:-9Poajs5J3eQ61156ff6ZKlCkugVh8PvS0XRcbjoe_DWGlEEuMS89TWC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Mon, 2 Nov 2026 13:18:33 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK release candidate 26.11-rc2
Date: Mon, 02 Nov 2026 19:18:29 +0100
Message-ID: <xr97c_w-SU6AD1Rq8Uh_NQ@monjalon.net>
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
	https://git.dpdk.org/dpdk/tag/?id=v26.11-rc2

There are 357 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_11.html

There are many fixes and drivers features, including AMD NTB.

Please test and report issues on bugs.dpdk.org.

Patches to improve tooling, examples and documentation are welcome
for the next release candidates.

We'll try to close -rc3 and -rc4 in one week each.

Thank you everyone


