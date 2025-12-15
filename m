Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B5D5B866
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 18:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEEBC4029A;
	Mon, 15 Dec 2025 19:53:29 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0488E40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 19:53:27 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D77D1202E1;
 Mon, 15 Dec 2025 19:53:27 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: improve Rx descriptor ring size checks
Date: Mon, 15 Dec 2025 19:53:27 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655E7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aUBReiTLkIp-M46a@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: improve Rx descriptor ring size checks
Thread-Index: Adxt741lhnho/bI2SoeKYhdVhRDkmgAAvMVw
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
 <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
 <aUBReiTLkIp-M46a@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>
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
> Sent: Monday, 15 December 2025 19.21
>=20
> On Mon, Dec 15, 2025 at 05:58:33PM +0000, Bruce Richardson wrote:
> > On Mon, Dec 15, 2025 at 06:54:50PM +0100, Morten Br=F8rup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Monday, 15 December 2025 18.36
> > > >
> > > > The default Rx ring size checks did not account for the fact =
that
> the
> > > > port would not work correctly if the Rx ring size was only twice
> the
> > > > free threshold size or less, so add in a new check for this. =
This
> would
> > > > generally only apply in cases where very small rings sizes are
> being
> > > > used, for example, with default Rx free thresh of 32, only ring
> size of
> > > > 64 would cause issues.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > >
> > > Does dev_info.rx_desc_lim.nb_min returned by =
rte_eth_dev_info_get()
> need correction too?
> > >
> > The minimum number of descriptors stays the same, however, if
> choosing the
> > minimum number of descriptors you may need to reduce the
> rx_free_thresh
> > value.
> >
> However, I think you raise a good point. I'll see about adding a
> specific
> error message in case the user is using the default threshold and
> setting
> the min ring size.

The applications need some generic code sequence that always works, on =
all NICs.

E.g. if an application uses rte_eth_dev_adjust_nb_rx_tx_desc() to move a =
requested crazy number of descriptors within bounds, and uses the =
default values for all other parameters, it should work.

Nonetheless, more detailed error messages are always helpful. :-)

-Morten

