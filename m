Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA918CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 307D840E39;
	Thu, 16 Oct 2025 11:47:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1A56F40BA6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 11:47:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E5F63206E3;
 Thu, 16 Oct 2025 11:47:48 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] dmadev: replace zero length array
Date: Thu, 16 Oct 2025 11:47:46 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654D4@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aPCpiEAYt6YM4-Ai@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] dmadev: replace zero length array
Thread-Index: Adw+dQI/6Pn7BesISyC6Kge5cGPPkgADN7cQ
References: <20251015185946.338417-1-stephen@networkplumber.org>
 <aPCpiEAYt6YM4-Ai@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <pbhagavatula@marvell.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>,
 "Kevin Laatz" <kevin.laatz@intel.com>
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
> Sent: Thursday, 16 October 2025 10.15
>=20
> On Wed, Oct 15, 2025 at 11:59:46AM -0700, Stephen Hemminger wrote:
> > Use of zero length arrays is Gcc extension.
> > Found by zero_length_array.cocci.
> >
> > Fixes: 9674119fbf27 ("dmadev: add enqueue/dequeue operations")
> > Cc: pbhagavatula@marvell.com
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/dmadev/rte_dmadev.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> > index 30e168825e..8ae9ee031b 100644
> > --- a/lib/dmadev/rte_dmadev.h
> > +++ b/lib/dmadev/rte_dmadev.h
> > @@ -856,7 +856,7 @@ struct rte_dma_op {
> >  	/** Number of destination segments. */
> >  	uint16_t nb_dst;
> >  	/** Source and destination segments. */
> > -	struct rte_dma_sge src_dst_seg[0];
> > +	struct rte_dma_sge src_dst_seg[];
> >  };
> >
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

