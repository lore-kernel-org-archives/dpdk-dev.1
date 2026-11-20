Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDE606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=IFqzq7xV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pN5PEwkx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4018402C6;
	Fri, 20 Nov 2026 13:02:06 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTPS id 7AB6540151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 13:02:05 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 86109140024A
 for <dev@dpdk.org>; Fri, 20 Nov 2026 07:02:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 07:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795176124;
 x=1795262524; bh=R4kw7lXW/jmD9tTnuONYilIAN5gAw5v35UAzLHLWn7k=; b=
 IFqzq7xVdDA9jo+wn1HYf/TeZVuz8PDjWrvMCjIeEdZEbupZzHfM34fkikhEsMF7
 fwwf2k6sZOeKZR03aa+KG3jFt4G3h8PFAo2twm4aJjJvGWVcV0EJtznSzlWJz6Dq
 k/Xjx0RN/axNFNzTudcQbLRxmPlZmDrankqSV86V/fsd6dL5Fj5bAJpXlNUONe9J
 Nosc16QUUcme71m23oYVi3RifCFqzLgF/+Wzyqq/lGd1EfRzetnAAfeSLMLDQdHT
 HIuc0FHQbUAHs3fUq3bSBN3te0LpeRplRdV3g28sbmG89WpRA7MLlf8pBs6HubWj
 T/wabRen4fCjYLYdiy/E9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176124; x=
 1795262524; bh=R4kw7lXW/jmD9tTnuONYilIAN5gAw5v35UAzLHLWn7k=; b=p
 N5PEwkxHgLJME0T4BHRYPw2nd51qgznqvBoOpIzO57LeXK+fwRL6nYsNRLEfqmmc
 DHRgx9zb157qrQ1N6wLRYYbjl5URcb2LhjbbOWKPpcV/4X+p5l6hDk52YAQuAwrs
 rMxNrBsC3tkBjAY6PkGz847/1F3K6TRyZ/OfAeigvyLaqevEO6q19shpatpW6BJ5
 q59uQyaoOUBNbjdVI3y6oJTBM/qz+4mzjvwYT8nqHb6iXepb63wCXNwyxQKNeHg9
 WKQVp+1aiT5qq6/IPp0JcF0lwZY99BaQ8rvROz/WnD72iXYeSWXHXjDZ8zVeLU7B
 GGVEC+o9mdlZW/nFZyt9g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176124; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:NKKik0tbk2ikOCXRvdaJWJ1MEN96Xz4qhglQp5BbSoOb5n3
 7jI2G6Sl1b2pLk/dxWdLcrSn4szOJjYH4XmgOkowpPW+WYxr/j9dvyeTI1nJctU7
 fORxYB/3bBFkyHfoWwdIZ9kL5+FjRiWngK7l6sdF7GFTQQ0jgCAhRU8nm7QKGd/8
 fBNlyxfJwsb/RZXpx5qa14guHUAVcwEErHwZuiF5OZHGbsxpHRFsj1VpQyFZ2oeB
 N/VJ0o7elTgN1PAl4HxjxBXctnLdA+ked+YzBlpquFbAf9oDzLkwNFaeLKbKLGJZ
 JRgK+vfMXGNGIvvw4mCMnjZktYU4ilCgxAktnPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:NkuqD45z46Hlrg7JuvZiA6zMY8KDptOfPcPQyGXs72M=:UxHPsXjm9QJ1urFWibgXELV989e+Rr+1Obd0kxdIHAU=;
X-ME-Sender: <xms:uzYAawo6HeObKs8x1oEN9MhZpwNdMia13b2B5CIehGV0R5oRibwCFQ>
 <xme:uzYAa1utN7GvZ9dRWhg_GV7rfXjq6-0DcQPSvUA47x3c0X45Mgq-MemTOQvqIgpHn
 dUKiR2hUwVAzpbSmSHWIHbi7IYTHvww-XhsTSTMuqUdicaJpVA1ivs>
X-ME-Received: <xmr:uzYAa7ZP5cddPC-0mJB-j6JE7H9lNRRpjaCyIDIaOgb5BjdiaNVoRCAM_fS_6US6GcuCYqUYMCgaJ3udVCZYcZQ>
X-ME-Proxy-Cause: dmFkZTFY9s97HSOr0huaj1VLY8WFOCg5IjVuM25zM/ATUpxHZ679byCSVgGMUU6rRTW3FY
 la3jJEauaVgU2LleRTusaylYDyNbiNxDUpTf1m+45T9ZCTRmdCR4yJRoMy7jFm3sap65D5
 Dls9n12xu2mORCYBO3oiWt5DFtCArNrZlVuUC+5cfSUsSuY7oPS8l57U0LFP8a4K6LFlbO
 caVxAJwEk9FixEOTmHVW0HHvRJxHXcDlG9bd8zFBcz3Iy6lSvdJLhyuB/6CA4KhNn5LvpT
 RIuniDNO9GsfQaVVPx8DLS4MAVkUzNDt85sAjy9Xdch7UP8J9tClGCHIqUhUNl4nrDsOY4
 wZwkhQJjVs4dy0EYtm6WzCAsGOnMD4UuQJsUYFfntQ0hP3xAzAeyK4JHBksxfET5IvMbUU
 rfVyP5UpH5erCoRs+J5rp7zBfQ/O9BsAz1isBZHfSFk0XOoTaJ80Uckp5DR5GuMyFGvvL0
 0dKNIT2xuoqQWb6IYV9cSj9jE6+tibaelHo5OjXFiLr2QPIzzvDx00rQKJinyta5+qcsPY
 heJpDzd/qkK3GFH3uc/aMiYXXVsNbEbOS++boW9asijRTgCbFTSoJhcqcAWGX7IRyPNynR
 Rgc/ii4wxHvatvqRl2xMC/lO85gVOTeEsusAgBWtF+z3nj0BAMG0eTKnQJlA
X-ME-Proxy: <xmx:uzYAa0aS8ebfotXKuO0xn2qSmPUFfWBBffoBIhySRvoF7IWtKLVY8w>
 <xmx:uzYAa0m6DBOZodApiRDatKt6hRvbAyqDNhRaKeuyjOLIqmI9mMzsbA>
 <xmx:uzYAa_3kzHV3_-T_KH7eOO02pSa34xR_CUWnq0yUm7ArZE_kDtwgIQ>
 <xmx:uzYAa00e-D-pHtE8KfbdYKaW5iqW8843VtN4xvfeItef6dc3wxTCZw>
 <xmx:vDYAa0vC4gUDMrNtH8oBGU2NdH_h2ixQDjiqBj4bIg2NgdOA6OHowS7B>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:02:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>,
 Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu,
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Subject: Re: [PATCH v6 1/3] dts: create default performance test configuration
Date: Fri, 20 Nov 2026 13:02:00 +0100
Message-ID: <lTuAz4H2SHqZxiHnoZmOPw@monjalon.net>
In-Reply-To: <b03c740b-38b6-4bba-bf36-96a249f92ca5@arm.com>
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261112210009.1620168-1-knimoji@iol.unh.edu>
 <b03c740b-38b6-4bba-bf36-96a249f92ca5@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

19/11/2026 19:41, Luca Vizzarro:
> Hi Koushik,
>=20
> thank you for this. Accepted to next-dts with minor doc changes.
>=20
> Luca
>=20

I've pulled it in main,
but my AI raises multiple warnings:

=2D With the chained port list [0, 2, 1], reverse traffic bypasses virtio
  but contributes to aggregate throughput, allowing false passes.

=2D Virtio-user defaults to 256 descriptors:
  setting testpmd=E2=80=99s ring sizes does not replace the missing queue_s=
ize vdev parameter.

=2D The queues=3D2 case leaves testpmd using one Rx/Tx queue;
  rx_queues and tx_queues must also be set.

=2D allowed_ports=3D[] bypasses DTS=E2=80=99s configured port selection,
  making the assumed port numbering unreliable.

=2D Hardcoded core IDs ignore DTS=E2=80=99s configured CPU selection.

=2D The packed vectorized case can silently fall back to scalar processing;
  the selected datapath should be verified.

=2D In the vhost suite, virtio=E2=80=99s two requested forwarding cores are=
 reduced to one
  because it has only one forwarding stream.


