Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFDAC44539
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 09:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A836B40274;
	Wed, 22 Jul 2026 11:44:12 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id D7E73400EF
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:44:11 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 442AFEC0185;
 Wed, 22 Jul 2026 05:44:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 22 Jul 2026 05:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784713451;
 x=1784799851; bh=U8EJuG9aYBavDoKDnfZ0nZEFWFR0WgzW9bbDgWZDf9g=; b=
 QfieSez+HjmmMR/p4ZNJde9NVHnfMpdC/P3PPzpwCNTgJCE9dYY7zci6ofR8glPe
 dHdGEYxCFwi1nw34L+0wsllEOu+YXbYSCg9jaRxuzKPGBfOEipHYRkTeR1/1L0Ec
 PVCZc8+t2Q3BgHgns10MY7Zuby/MARFfWll/dN+IBMTnldT7xa8KnVjHG2ytt8KO
 QPrxl/mjuqEoB7O6TGNwSeCpQH2MI5d2vdN7nSpNTrobzakpgZuv9yGj1wzgIfB6
 0RYklo2D4Ds5d+s5J7N8V05WTKWIHe2NOnubr/3ZknbilPIXQdtnGZm+0IwAb1Ir
 7TV34CZBRN3AaPgvfsDK9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784713451; x=
 1784799851; bh=U8EJuG9aYBavDoKDnfZ0nZEFWFR0WgzW9bbDgWZDf9g=; b=c
 zVWLn1TWqw2M07HH6JI2acwXWgsmIE2QTqpZJZz78fCVC98wj6Vi7RnygBRFNlVb
 kbnnCFjWHkTGuZomc/8Sd/38z3ZC9EDWctqPQTYf34jYdjboqVEdBN4Qp6Crbx52
 RcSNdA346fjzFZJwqb02ouWyEhrgeSxbHnTyZtFdweTZl/xx+egrq2+nFs45UkGC
 LYIYTRHvQVgoRVQBopixVAWpJRiFf2iNOsoOqLj4P1Nge25SvH7Btidgtk8qHQNp
 8GC15h3/SJzwvmmmZOfZLhzAkUZ2IdTWVDJvS7i7Th6mOQlBA1emCZ8rPN3FQ4HB
 RBFdVfQAkAVYVWgvQrg0g==
X-ME-Sender: <xms:6ZBgaqlzLALKA2pBxKVHKYo0SVlDTQCDarCFjCu_zIIsNuhjh-JUSg>
 <xme:6ZBgaswz05naxoQqvcJKyWI_LwNSOnpI9YEWTR3zCjmREuT9UGxQIt1W3hyuocfNL
 zna3dxoP5bnTMH8qt9hnScjmtsrF1ALE_0MQCorL2-9yCBfFvE5Vw>
X-ME-Received: <xmr:6ZBganrMjvXyL3teX0NkrKI3xsAKq_GwkEUD-F0vLxY_STwfabO4wOVDaJaKpZeg-bHYzJXidiwExzIO-tkoEIwPxQ>
X-ME-Proxy-Cause: dmFkZTFOoHVJomPAXSAGej36zznuA7kcO4Fmn9OIHamBGaalOsWP6iv6uIjpsxx+MBTOua
 B1Uk++aQqTm92pqz4nwYUhkDyqqPrmwFXQoSOCBPAuDo1qacxjX4OZH6ITE9CEA7P9AzpX
 RKIlri5Wbt3ohGuz1a7dAXOYzcsNsY3pSAkvHEWba97rfAhUVcD1nF+MLmiqtI+AIpSvJR
 TWZE4XwkpbML2mNvOIyzla0C+0TRKVwUm3Vc4N6q3FbUEs1rgQ2CzbApA26ofz5ba+HrD6
 w7ZUVYPjHNbKBPSa4Yk5ymEBBxIscNvJ5forW+d63m76a1m9FSpCA92v47pwmV8mOSuclv
 VENdReEgOipE+rBjIwYH6e8sKN5q4F6cwtdiWlIzpTn26b3hQUDBjM9Wuo/hdUV+/ndWhr
 16ung5KpG5ZzMVaI9ehoo+JwKPUA9cCKVYQJy2++HRn/bDgQmyRX9ilAE4sLKwcKFbkMmY
 doDrVEGYs/HqJ/ryKD/lljY7lvnNd3wQe7bLhG9F13Aro6xXhP06Kv29fKtboFaT+bmWqt
 L2J99mTpu1T4+h3K7ms1NtnRtzmIpWK/NsKHzARmxMU9W/n+3uC20cht/0OxaW0a2oRghd
 5KXMhoNvZc7zRvWSrny6/WBk/K4aXiCias7Maesgg3wI0cNT6nbZbMTPxUsw
X-ME-Proxy: <xmx:6ZBgaj6wyCS44GRtNs0mYFW8i3ZgX-WdSQbEmqQ7PcPtNn1s1KKJhQ>
 <xmx:6ZBgameaNiDQbTCLXeZYZqGA3MhxKwdxVgwO8FrlG4R38av507YUbw>
 <xmx:6ZBgag62m_0Y0mkyFeo-AkIGA2oziA-iF-OxsIl1onoimfDrBwMYDg>
 <xmx:6ZBgalvseSFoyMVAwNBSFn2Y_mHzdHsJ6QUUfZtPOWPcnpjEcU4vEQ>
 <xmx:65Bgaqwz_Zc7UPUeE63_It5qrBPyRr_C9GQFALlbt0pquIF3Ot-2L8zY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 05:44:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH] doc: drop recommendation against bool in structures
Date: Wed, 22 Jul 2026 11:44:05 +0200
Message-ID: <dr8OTbOEQGerczIWADcBzg@monjalon.net>
In-Reply-To: <20260720114602.787429-1-maxime@leroys.fr>
References: <20260720114602.787429-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

20/07/2026 13:46, Maxime Leroy:
> The coding style advised against bool in structures, citing space and
> type-size concerns inherited from the Linux kernel. That does not match
> DPDK practice: bool is already used in over 1400 structure fields across
> the tree, including core APIs such as rte_flow. Drop the note so the
> style guide reflects actual usage.
>=20
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>

Applied, thanks.


