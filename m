Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8599607F4AF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=DhFvMzep;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=khUl9PYR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF00440297;
	Mon, 19 Oct 2026 17:05:00 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 678E84028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:04:59 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id C7E38EC0077
 for <dev@dpdk.org>; Mon, 19 Oct 2026 11:04:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 11:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792422298;
 x=1792508698; bh=uCd13LEbTOuQ2Vd7CT8e6HL4fJCU9xoE/fBLSECfvSg=; b=
 DhFvMzepDOGWWsOccDe8V0jzryGjlk0x+TIT+Gp5kaDjnlPl2HxKQcKMNFBNnqzH
 S1KeUgESNj0lFv7gxqnTD4uwhhCgy7+lvUJuXcTJKFZ/kw0lTeJrW1TNKJJbKkyz
 PcUF6r9qdX1C40OJ6iAKjVUUEsP4iQsG6jvLALycABULZ5mF1tCWaLYvC+tGBqHq
 MhP+pA53CyrzQe0Xyy7N4T65a6lQXvCzP81UVxxXAKKgPNhw3W/RlH35Gu8PV/VG
 E6N3n9H13r29Oxm+qi7iWteofAt/RQQ/luIl6WFfdycKc7wyCvxoA88jmtpNcYjQ
 VuCIYMw3pTedQB+UjuJBaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792422298; x=
 1792508698; bh=uCd13LEbTOuQ2Vd7CT8e6HL4fJCU9xoE/fBLSECfvSg=; b=k
 hUl9PYR0JNbu/2w/hoeW6vHpkmA54boIvhDrBhW5x+QD++G3D6r5vlqTzHW7hvKZ
 Aw1eH6ikJfQW51kAPBbRn0hRwqCFadwuPPS9E8YIOhLM4hmpAwSDUJ2RtmnFNCHc
 ua+z3nLnM6kLuPwajdj5+mfTLS1IkMMhQVGprfQecTu4x7l0iVlu55CIh2C1X80P
 fApSfl0oqVuTwN2wJzPDfw0mXM/GDyIDJhh/yu8yLtHJXnKprmiHtqDBb8NwlFNi
 MVDgwvzIBqWCsSSFbJ4TjGs3o3ebQGMWGQeWXqPrc0KOMPXFKnRe7Dl4P3pBKpUW
 Ewa2HmvXi7j+cg7vv5gsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792422298; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:apiD2H5M1bn7FwAbbuljjYHZOP4Dtl7iDmk0b/K+gUPal2r
 wRV00SY9bcM5wd/vjoqm2YkWwUW4LP7R3IZu9McaZBn2Yah7GysfiY4a4Hq55UWZ
 dg0Co1KK4Qr/EXlYbzVYw9Mr5GXyg0tmW7fGYFW5oCz5cemrmnNPNVHcjJ1qyI/w
 aqfxjGSkpmyVDg/wIKBUyX/zaJrwEaLOxGnNKiNe/D9GcTax0p5Qw8WYtcwy0x5l
 dYc1aQ1oPDQ75GuH/r9a3SbEIYThF6LrrQy4dLWqSXVgFAmifR1SEu+9KTCrODoX
 4ssjoO9a9v/WgyvR/vw1TKMgPlsT3ui3Eyp2O3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:EuDPnZdja3HCNha7QeEGdtwKBpAYzqEIkNg0pjUhyv0=:XjjU3FxaqeuwcnDKLSlaNaiXr2R8msvUdkAD7zZVmDo=;
X-ME-Sender: <xms:mjHWaqSBfUkMzjRIrFgKHyCjtVRVGRMUX-BADkOkNNfKOi0rge8j0w>
 <xme:mjHWav4Lq9L3-W6cnKDAbuPGJF0pUBygCLSqLrJcfGS39qqkM41xbz2Enp7XGBd28
 6AyQScyUKxRllBU-xKm7J2uyj4itarOzqrXw0MQh5QvKVdUY6XThQ>
X-ME-Received: <xmr:mjHWavxYlR-nOG8vW6e_QPYQ-XzTj4cchJvaSYu_-CBn6wl1r4HvpQIo_OfCLzWBbViI_HtM_HPCUZxAfSbExy8>
X-ME-Proxy-Cause: dmFkZTFppfLdpPVMo8gZMiGsKUD8T3/SiT3cZvK9AwR6/Giedh0iQp56ogGRKMtYbpbNhz
 ZJKHmKIIkUl/KwWYlwvXGPbbQRiswlAZbJFxislZyUcBBnKiqJ0qb2esoB3HI5nz14whgc
 MRyS1LZLwZrwJyauPbhe+B2wHAf13cGGL6lDifAlMqnwO8FzSdMwFa8sGl/5qJArZebrME
 ZVgAKwx5CNfqtHn9Yd63yrS8dP4WLSI3QTYKM+zVN3wT7lI90RInZSUv+2Z95a+UFnxz5E
 U/Ed2H7pUExT4S3/5XsUNlRq35q+GKs+vA2ihcdfh2Hp1TY3UsInSRLcK6plNOHDYuiBKq
 9PckldOuqBqXyYOA3MEb3939OKFEbp8jiW39RcNhvd9T6nK9oZF9UFn1tXCpAmpqXvas8n
 JLpp7EToYKpoRV3HZgUaHuNC/fMt+/SYa2j9hN33ewrdqrWp7BDmxw0wkCsAu8jQ3Sd0+K
 Hoq3DO8kB9GJArnqGMgdNDDIQTNioEJO2br4IpATa78M5WuB2v6xG4IZorfOtZaqTV+dh/
 gp2MiVPZfIAdk0s1P3g54SG9KVs7NxLF7jOV/OF7P0NWzi+ucV8jEONHoMrpULgQ2vHhC3
 zQBquPxcwbRMGac0EEllpGtZcS1YwdEWiIV3d70C9OVbgizX4a2Fb06Ecpvg
X-ME-Proxy: <xmx:mjHWauQLCJSL1uG63Yjx1_vbynWWGBlr3BZc6gyGkkrZ7fBcPdluyQ>
 <xmx:mjHWauX1NV43_st9uh--OuVFctyI8AbxUz5uuN84yofpbGWWYuUYRQ>
 <xmx:mjHWaoZ-IbYnmFiEhhRthEnwMzSesRMqQEKZ2DibZEZZhAloyE__cA>
 <xmx:mjHWas14uCicF9_iKeSR0FAtuOyejo7CZJM_UPafiSZhJevNyubWWQ>
 <xmx:mjHWaitzc6FlMfWGxrEbt6WLTZ9sobF9xHSH-pMeGYeRAMSLXWSdXZ2Q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:04:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, Kai Ji <kai.ji@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Mon, 19 Oct 2026 17:04:55 +0200
Message-ID: <uyjFhmv-QzKanl-x0A8T0A@monjalon.net>
In-Reply-To: <18b34f38-6961-42e1-a828-ca60035a11eb@intel.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <8OA9ksWHSu-USgHcEeFFXg@monjalon.net>
 <18b34f38-6961-42e1-a828-ca60035a11eb@intel.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

19/10/2026 16:16, Radu Nicolau:
>=20
> On 19-Oct-26 12:27 PM, Thomas Monjalon wrote:
> > 19/10/2026 11:25, Radu Nicolau:
> >> On 13-Oct-26 8:41 PM, Thomas Monjalon wrote:
> >>> 12/10/2026 15:58, Radu Nicolau:
> >>>> Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
> >>>> codenamed T=C3=BAnel Pablo
> >>>> https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0
> >>>>
> >>>> This patchset adds support for the new library version and support
> >>>> for the new algorithms included in this release.
> >>>>
> >>>> Series-acked-by: Kai Ji <kai.ji@intel.com>
> >>>>
> >>>> Radu Nicolau (4):
> >>>>     crypto/ipsec_mb: add support for IPsecMB 3.0
> >>>>     crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
> >>>>     crypto/ipsec_mb: add support for ML-KEM and ML-DSA
> >>>>     test/crypto: add asym test suite for AESNI_MB
> >>> Sorry I will give a defensive NACK
> >>> because you never fixed the problem with the Arm fork.
> >>> The crypto branch is already not compiling on Arm
> >>> because of your recent change for IPsec MB 2.0.
> >> Hi Thomas, with the latest changes and removal of minimum required
> >> version these patches are now compiling on Arm, are we ok to withdraw
> >> the NACK?
> > If they compile, yes.
> > What changed?
>=20
> The main change is that they are now rebased on main, and not=20
> next-crypto, which included the change for IPsec MB min version 2.0.
>=20
> They compile (and there should be no further issue with Arm compilation)

So let's say I remove my NACK.
But I am not supportive of the way it is ignoring the Arm fork.
I really would like to see a unified repo for IPsec MB.


