Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C9FEE20AA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1785840276;
	Fri,  6 Feb 2026 15:36:44 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A64D440156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 15:36:42 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AB4CA20BEE;
 Fri,  6 Feb 2026 15:36:41 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v6 0/4] af_packet correctness, performance, cksum
Date: Fri, 6 Feb 2026 15:36:37 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656F0@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260205174901.462eddb1@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 0/4] af_packet correctness, performance, cksum
Thread-Index: AdyXCswei643l+mVTdOq8+h/zg7C9gAaH7QQ
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
 <20260205174901.462eddb1@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 <scott.k.mitch1@gmail.com>
Cc: <dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Friday, 6 February 2026 02.49
>=20
> Why are the header structures marked packed, that is bogus, BSD and
> Linux don't do it.

They have been packed since the first public release in 2013 [1].

I guess it's because the IP and TCP headers contain 4-byte fields, which =
make those structures 4-byte aligned; but since the IP header follows a =
14 byte Ethernet header (without the magic 2-byte pre-padding done by =
the kernel), the instances of the IP header are not 4-byte aligned, but =
2-byte aligned. Marking them packed is a way of stripping the alignment.

BTW, the IPv4 header was bumped (from no alignment) to 2-byte alignment =
with patch [2].

[1]: =
https://github.com/DPDK/dpdk/commit/af75078fece3615088e561357c1e97603e43a=
5fe#diff-620c2b2031359304a7f26328a52035c9f8ddf722b9280f957047dcb81467777f=

[2]: =
https://github.com/DPDK/dpdk/commit/c14fba68edfa4aeba7c0dfb5dbc3b4f23affb=
b81


> Windows probably does=20

Yes, probably.
The Microsoft compiler is more pedantic (leading to fewer bugs), and =
many of those structures should formally be packed (or more correctly: =
unaligned).

> but Windows code seems to love packed even when
> it is not necessary.

I guess packing (without thinking about the need for it) has become a =
bad habit for some Windows programmers.

