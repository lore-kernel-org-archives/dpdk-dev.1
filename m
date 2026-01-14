Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550CCD31A1E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 07:35:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EB484029A;
	Wed, 14 Jan 2026 08:35:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5ACA840289;
 Wed, 14 Jan 2026 08:35:11 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 89D76229AD;
 Wed, 14 Jan 2026 08:35:10 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Date: Wed, 14 Jan 2026 08:35:05 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65658@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260113222742.0e17c7c4@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Thread-Index: AdyFHutO2bciokpuSZG7HjLnxBYeYAABzhKg
References: <20250919071213.818567-1-zhichaox.zeng@intel.com>
 <20260113222742.0e17c7c4@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Zhichao Zeng" <zhichaox.zeng@intel.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Shahaf Shuler" <shahafs@nvidia.com>,
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

+CC Bruce

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>=20
> On Fri, 19 Sep 2025 15:12:13 +0800
> Zhichao Zeng <zhichaox.zeng@intel.com> wrote:
>=20
> > IP packet reassembly requires the MULTI_SEGS offload to be enabled =
in
> order
> > to handle fragmented packets across multiple memory segments.
> However, the
> > MBUF_FAST_FREE offload conflicts with MULTI_SEGS and cannot be
> enabled
> > simultaneously.
> >
> > Remove the MBUF_FAST_FREE offload to avoid conflicts with =
MULTI_SEGS.
> >
> > Fixes: 9df56e69ee3f ("examples/ip_reassembly: convert to new ethdev
> offloads API")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> >
>=20
> Later Tech Board discussion concluded that fast free and multi segs =
are
> not
> conflicting flags. Dropping this patch.

Let's postpone rather than drop this patch.

The documentation still says that FAST_FREE does not allow segmented =
packets.
And it has been reported that some drivers fail when using both flags.
The Tech Board wishes to get rid of the mutual exclusivity, to support =
jumbo frames with FAST_FREE; but the mutual exclusivity is still under =
investigation, and no final conclusion has been reached yet.
For now, it has been concluded that the mbuf library is not the reason =
for mutual exclusivity, but it has not yet been concluded if is required =
for driver implementation purposes.

