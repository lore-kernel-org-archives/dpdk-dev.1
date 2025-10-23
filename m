Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47DCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 07:04:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3559F40151;
	Thu, 23 Oct 2025 09:04:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E4872400D6
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:04:54 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A77692041E;
 Thu, 23 Oct 2025 09:04:54 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4] mbuf: optimize segment prefree
Date: Thu, 23 Oct 2025 09:04:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654F5@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aPjyFK392slWz5R5@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4] mbuf: optimize segment prefree
Thread-Index: AdxDZPWsgk+NnNOVTYOveeGbob2DmQAhhV9w
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251022144708.150069-1-mb@smartsharesystems.com>
 <aPjyFK392slWz5R5@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>
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

> > +#if !defined(RTE_TOOLCHAIN_GCC) || defined __DOXYGEN__
> >  /**
> >   * Returns TRUE if given mbuf is direct, or FALSE otherwise.
> >   *
> > @@ -714,6 +715,52 @@ struct rte_mbuf_ext_shared_info {
> >   */
> >  #define RTE_MBUF_DIRECT(mb) \
> >  	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
> > +#else /* RTE_TOOLCHAIN_GCC */
>=20
> Do we need the non-gcc block?

I have now tested with a bunch of compilers on Godbolt, and it seems =
only clang doesn't need this optimization, so I'll remove the compiler =
check and make the optimized variant the only one.

