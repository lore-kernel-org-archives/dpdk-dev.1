Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C164D5CCBB
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 10:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7107C402AC;
	Tue, 16 Dec 2025 11:48:10 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD8B4026D
 for <dev@dpdk.org>; Tue, 16 Dec 2025 11:48:09 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EB047202E1;
 Tue, 16 Dec 2025 11:48:08 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: improve Rx descriptor ring size checks
Date: Tue, 16 Dec 2025 11:48:07 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655EA@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aUEr2u81g44Osaim@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: improve Rx descriptor ring size checks
Thread-Index: AdxucbbuhE0JfyHGSDe0IIkt3NgTrwABl6qQ
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
 <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
 <aUBReiTLkIp-M46a@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E7@smartserver.smartshare.dk>
 <aUEc2jGvHlg13gOm@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E9@smartserver.smartshare.dk>
 <aUEr2u81g44Osaim@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <thomas@monjalon.net>, <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
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
> Sent: Tuesday, 16 December 2025 10.52
>=20
> On Tue, Dec 16, 2025 at 10:25:41AM +0100, Morten Br=F8rup wrote:
> > +TO: Ethdev maintainers
> >
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Tuesday, 16 December 2025 09.48
> > >
> > > On Mon, Dec 15, 2025 at 07:53:27PM +0100, Morten Br=F8rup wrote:
> > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > Sent: Monday, 15 December 2025 19.21
> > > > >
> > > > > On Mon, Dec 15, 2025 at 05:58:33PM +0000, Bruce Richardson
> wrote:
> > > > > > On Mon, Dec 15, 2025 at 06:54:50PM +0100, Morten Br=F8rup
> wrote:
> > > > > > > > From: Bruce Richardson
> [mailto:bruce.richardson@intel.com]
> > > > > > > > Sent: Monday, 15 December 2025 18.36
> > > > > > > >
> > > > > > > > The default Rx ring size checks did not account for the
> fact
> > > that
> > > > > the
> > > > > > > > port would not work correctly if the Rx ring size was
> only
> > > twice
> > > > > the
> > > > > > > > free threshold size or less, so add in a new check for
> this.
> > > This
> > > > > would
> > > > > > > > generally only apply in cases where very small rings
> sizes
> > > are
> > > > > being
> > > > > > > > used, for example, with default Rx free thresh of 32,
> only
> > > ring
> > > > > size of
> > > > > > > > 64 would cause issues.
> > > > > > > >
> > > > > > > > Signed-off-by: Bruce Richardson
> <bruce.richardson@intel.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > Does dev_info.rx_desc_lim.nb_min returned by
> > > rte_eth_dev_info_get()
> > > > > need correction too?
> > > > > > >
> > > > > > The minimum number of descriptors stays the same, however, =
if
> > > > > choosing the
> > > > > > minimum number of descriptors you may need to reduce the
> > > > > rx_free_thresh
> > > > > > value.
> > > > > >
> > > > > However, I think you raise a good point. I'll see about adding
> a
> > > > > specific
> > > > > error message in case the user is using the default threshold
> and
> > > > > setting
> > > > > the min ring size.
> > > >
> > > > The applications need some generic code sequence that always
> works,
> > > on all NICs.
> > > >
> > > > E.g. if an application uses rte_eth_dev_adjust_nb_rx_tx_desc() =
to
> > > move a requested crazy number of descriptors within bounds, and
> uses
> > > the default values for all other parameters, it should work.
> > > >
> > >
> > > This is surprisingly difficult to make working with the way things
> are
> > > set
> > > up right now. For example, if the user wants defaults for config
> > > settings
> > > and passes in NULL to the ethdev API, the ethdev library queries
> the
> > > defaults from the driver and fills those in before calling the
> relevant
> > > ring setup functions. Therefore, the driver level has no knowledge
> of
> > > whether the user explicitly requested a value which happens to
> match
> > > the
> > > default, or if the user just wants a working default value.
> > >
> > > Another option would be to set the default low enough that it =
would
> > > work
> > > with any ring size possible, but that would then cause a perf
> impact
> > > for
> > > apps which don't need such low values (as an extreme example, =
think
> on
> > > a
> > > theoretical driver which allows ring sizes of as small as 16 or 8,
> a
> > > free
> > > threshold to work there is likely suboptimal for more normal ring
> sizes
> > > of
> > > e.g. 1k or 2k).
> >
> > Small descriptor rings are not theoretical.
> > Our application configures very small descriptor rings on unused
> ports, to be able to process background traffic (e.g. slow protocols)
> on those ports, but still conserve memory.
> >
> > E.g. the igb driver reports dev_info.rx_desc_lim.nb_min =3D 32, but
> multiple times this value is required with default thresholds.
> > The i40e driver reports dev_info.rx_desc_lim.nb_min =3D 64, and IIRC
> more is required with default thresholds.
> >
> > I agree that defaults should remain optimized for performance
> (maximum packets per second).
> >
> > The problem is rte_eth_dev_adjust_nb_rx_tx_desc() not having
> sufficient information about all the thresholds to correctly calculate
> its output values. I'll file a bug report.
> >
> > Updating the drivers to report dev_info.rx/tx_desc_lim.nb_min and
> dev_info.rx/tx_desc_lim.nb_align that work with default thresholds
> could be a workaround.
> >
>=20
> I'm not sure I like that option. How would one then query the limits
> with
> non-default thresholds? Also, it doesn't inform user as to which
> thresholds
> are causing what limits, vs limits that are hard ones from the HW.
>=20
> Other options may be greater use of e.g. 0 as a sentinal value for
> allowing
> the driver to pick, or changing things internally so that the source =
of
> the
> rx_conf is passed to the drivers. However, I actually feel that the
> best
> option if we want a "most usable" solution here, is to document that
> the
> free_thresh is a hint, and that it may be adjusted by the driver if
> necessary to accomodate a requested ring size. [We could log a warning
> on
> adjustment]

+1 to your "must usable" suggestion.
(As a workaround for rte_eth_dev_adjust_nb_rx_tx_desc() not having =
sufficient information.)

The Tx side is worse.
It has requirements related to both rs_thresh and free_thresh.
I suppose they could be treated as hints too.

