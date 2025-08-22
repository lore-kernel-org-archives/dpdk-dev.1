Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5940CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 09:20:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04A4040695;
	Fri, 22 Aug 2025 11:20:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EBF274068E
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:20:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BBF64209AA;
 Fri, 22 Aug 2025 11:20:44 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC 2/3] hash: reduce architecture special cases
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Aug 2025 11:20:43 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE60@smartserver.smartshare.dk>
In-Reply-To: <20250821203646.133506-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 2/3] hash: reduce architecture special cases
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwS21yjnYGU51bEQfGfR/mkcfd95AAaJNXw
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 =?iso-8859-1?Q?Mattias_R=F6nnblom?= <mattias.ronnblom@ericsson.com>
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
> Sent: Thursday, 21 August 2025 22.35
>=20
> Make comparison of power of 2 sizes compatible across platforms.
> Keep the special case code for 16 bytes for x86 and arm64 but
> also add simple xor for others.
>=20
> Need to make rte_hash_k32_cmp_eq() exposed because ip_frag
> code poaches it.

One more argument why these architecture optimized compare functions =
should be exposed as generic EAL functions, like rte_mov16() etc. for =
rte_memcpy(), instead of hiding them away in the hash library.

It could be rte_memeq16(const void *, const void *) etc. in =
/lib/eal/include, with architecture optimized variants, and a generic =
variant.

And a wrapper calling them in the hash library, such as:

static inline int
rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len =
__rte_unused)
{
	return !rte_memeq16(key1, key2);
}

>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

With our without suggested feature creep...

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

