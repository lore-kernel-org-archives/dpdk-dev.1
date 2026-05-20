Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63CECD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 13:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2D9D4029D;
	Wed, 20 May 2026 15:50:39 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5C85940144
 for <dev@dpdk.org>; Wed, 20 May 2026 15:50:38 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E5296206EC;
 Wed, 20 May 2026 15:50:37 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Date: Wed, 20 May 2026 15:50:34 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65888@smartserver.smartshare.dk>
In-Reply-To: <ag1me_1XSByq3p9V@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Thread-Index: AdzoLJfovS2P9ayqTrKpMiHc8R0d7QAMqUoA
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
 <20260519124332.5e68fd8f@phoenix.local>
 <ag1me_1XSByq3p9V@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 20 May 2026 09.45
PATCH 0/8] remove use of rte_memcpy from net/intel
>=20
> On Tue, May 19, 2026 at 12:43:32PM -0700, Stephen Hemminger wrote:
> > On Tue, 19 May 2026 16:05:57 +0000
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > This RFC proposed to replace all instances of rte_memcpy in Intel
> > > (and former-Intel) net drivers with just regular memcpy. This is
> > > done on the basis that the memcpy use is not datapath, but is used
> > > for flow configuration, virt-channel (to firmware or PF) messaging
> > > and other control path functions.
> >
> > Makes sense. You might also want to look for where structure
> > assignment can be used instead of memcpy. Keeping data types
> > is a good thing.
>=20
> Yes, it would be nice to use in places. However, it's not a mechanical
> change so I've not taken the time to do the analysis. Just a quick set
> of sed replacements for this RFC.

If you consider structure assignment, look out for fixed-size structures =
ending with field[1]; they are really (ill defined) flex-arrays.

