Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C86C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 07:31:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD18A40268;
	Thu, 20 Aug 2026 09:31:43 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E9713400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 09:31:41 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BA524207DD;
 Thu, 20 Aug 2026 09:31:41 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 00/61] reduce use of rte_memcpy
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 20 Aug 2026 09:31:40 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 00/61] reduce use of rte_memcpy
Thread-Index: Ad0wY/ttzKAX6Le9TveUiuEszTCbngADDdrw
References: <20260820052251.1453273-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

About replacing rte_memcpy with memcpy()...

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, 20 August 2026 07.12
>=20
> The DPDK function rte_memcpy() only exists as an optimization
> for shortcomings in performance of libc memcpy() on some platforms.

Yes, and those platforms should benefit from it.

E.g. the vhost performance improvements for Haswell and Broadwell [1].
Where similar performance improvements implemented in the relevant =
compilers (GCC, Clang, MSVC)?

[1]: =
https://github.com/DPDK/dpdk/commit/4b42e90ef0e421dc777f2b2e377eb237cd367=
5fa

IMO, performance should remain a high priority for DPDK.

> Many platforms have no special rte_memcpy() and just use memcpy().
>=20
> But many analysis and test tools know that memcpy() is a special
> case and check for overwrite, bounds errors etc. Therefore memcpy()
> should be preferred wherever possible.

I think this is the only substantial benefit of replacing rte_memcpy() =
with memcpy()!
Could we reap this benefit by having special builds for such tools, =
where rte_memcpy() is modified to use memcpy() instead?
Then we wouldn't have to compromise on performance.

Also, rte_memcpy() used to have a pragma disabling bounds checks due to =
some Intel drivers using [0] instead of []; the pragma was removed from =
rte_memcpy() when the Intel drivers were fixed.
I'm not sufficiently familiar with analysis/test tools to say what they =
can detect when using memcpy() instead of the copy methods used by =
rte_memcpy().

>=20
> This patch series introduces a coccinelle script to find
> calls to rte_memcpy() where size is fixed, and change them to
> regular memcpy(). This was the starting point for this cleanup.
>=20
> There is also some cleanups to include rte_memcpy.h and string.h
> where needed. Often the includes were happening by some other
> header. And also removal of rte_memcpy.h where no longer needed.
>=20
> The result is a 46% reduction in use of rte_memcpy.
> The remaining rte_memcpy can be cleaned up later:
>  - drivers with active maintenance (like mlx5);
>  - changes to rte_memcpy which need benchmarking;
>  - test code for rte_memcpy can be removed as last step.
>=20
> No functional change, no warnings in all compilers including LTO.

memcpy() does not always use inline vector instructions for fixed size =
copy [2].

[2]: =
https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F659B8@smartse=
rver.smartshare.dk/


Another disadvantage of rte_memcpy() is the lack of developer guidance.
It is not well documented when to use rte_memcpy() and when to use =
memcpy().
We discussed something similar on the Tech Board meeting yesterday; it =
is not well documented when to use which type of "ring" (normal, RTS, =
HTS), so maybe we could remove one of them.
But removing an option is not an improvement, if the removed option =
would have been the better choice for some use cases.

PS: The general guidance for rte_memcpy() usage is something like:
rte_memcpy() only in fast path,
memcpy() everywhere else,
assignment "=3D" when copying fixed size structures.

