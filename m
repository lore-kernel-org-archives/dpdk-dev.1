Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A54ED232FF
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 09:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E1A6402A7;
	Fri,  9 Jan 2026 10:26:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AB573400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 10:26:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0F5992073F;
 Fri,  9 Jan 2026 10:26:18 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v11] net: optimize raw checksum computation
Date: Fri, 9 Jan 2026 10:26:16 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65638@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v11] net: optimize raw checksum computation
Thread-Index: AdyA80DEgjZxBvQcQ9iZsgK66ZXnQAAVBZUw
References: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>
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

> Changes in v8:
> - __rte_raw_cksum: use native pointer arithmetic instead of =
RTE_PTR_ADD
>   to avoid incorrect results with -O3 for UDP checksums. Also improves
>   performance due to less assembly generated with Clang.

Personally, I also have observed GCC's optimizer behave as if it loses =
some contextual information when using RTE_PTR_ADD, and thus emitting =
less optimal code.
I didn't look further into it, and thus have no data or examples to back =
up the claim. Which is why I haven't started a discussion about =
discouraging the use of RTE_PTR_ADD.
In other words: I support this change.

>  	/* if length is odd, keeping it byte order independent */
> -	if (unlikely(len % 2)) {
> +	if (len & 1) {
>  		uint16_t left =3D 0;
> -
>  		memcpy(&left, end, 1);
>  		sum +=3D left;
>  	}

Changing "len % 2" to "len & 1" made sense for consistency in previous =
versions handling 32/16/8/4/2-byte chunks before this 1-byte chunk; now =
it makes no difference, so consider not changing this part at all.
Under all circumstances, don't remove the unlikely() for handling odd =
length in __rte_raw_cksum(). The vast majority of packets (and partial =
packets, e.g. headers) being checksummed are even length.

