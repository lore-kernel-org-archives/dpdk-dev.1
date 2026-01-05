Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3BC79F8B
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 12:48:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0EA44026F;
	Mon,  5 Jan 2026 13:48:27 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8541A40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 13:48:26 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 90CBF20445;
 Mon,  5 Jan 2026 13:48:25 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5] net/ice: add MAC anti-spoof option
Date: Mon, 5 Jan 2026 13:48:22 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65625@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <CY5PR11MB61160E26A3AFEA280405C580E486A@CY5PR11MB6116.namprd11.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] net/ice: add MAC anti-spoof option
Thread-Index: AQHceYIypD5T/+EglUuH43h1ow40F7VDegOQgAAPFXA=
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251230114828.6156-1-anurag.mandal@intel.com>
 <CY5PR11MB61160E26A3AFEA280405C580E486A@CY5PR11MB6116.namprd11.prod.outlook.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>,
 "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
	<dev@dpdk.org>
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

> From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> Sent: Monday, 5 January 2026 12.31
>=20
> > VRRP advertisement packets are dropped as TX-errors upon =
transmission
> > from a vsi of ice PF due to MAC anti-spoof check, which is enabled =
by
> default.
> > There is no way to disable this security check in the Tx direction =
to
> avoid these
> > packets being dropped.
> >
> > This patch introduces devargs "mac-anti-spoof" to allow user to
> disable MAC
> > anti-spoof check. Disable MAC Anti-spoof check in the Tx direction =
to
> send
> > outgoing packets even when their destination MAC address matches one
> of
> > the MAC addresses assigned to that same NIC port and avoid getting
> dropped
> > as TX-errors.
> >
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
> > V5: Addressed CI failures
> >  - Removed ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
> >    flag as that is causing CI failures and observed
> >    MAC Anti-spoof check is enabled by default
> >    irrespective of that flag.
> > V4: Addressed ASan CI failures & Morten Br=C3=B8rup's feedback
> >  - set the default value of the devargs to 1
> >  - enabled MAC anti-spoof check by default
> >  - provided devargs option to disbale the same
> >
> > V3: Addressed Morten Br=C3=B8rup's feedback
> >  - set the default value of the devargs to 0
> >  - disabled MAC anti-spoof check by default
> >  - provided devargs option to enable the same
> >  - synchronized with source prune
> >
> > V2: Addressed Bruce Richardson's feedback
> >  - changed devargs name to "mac-anti-spoof"
> >  - changed devargs member name to "mac_anti_spoof"
> >  - changed macro name to "ICE_MAC_ANTI_SPOOF_ARG"
> >  - set the default value of the devargs to 1
> >  - added NOTICE log msg when MAC Anti-spoof is disabled
> >  - added more code comments to provide clarity
> >  - fixed typo error with ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
> >
> >  doc/guides/nics/ice.rst            | 12 ++++++++
> >  drivers/net/intel/ice/ice_ethdev.c | 44
> +++++++++++++++++++++++++++++-
> > drivers/net/intel/ice/ice_ethdev.h |  1 +
> >  3 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst index
> > 6cc27cefa7..c3e9cfaee3 100644
> > --- a/doc/guides/nics/ice.rst
> > +++ b/doc/guides/nics/ice.rst
> > @@ -194,6 +194,18 @@ Runtime Configuration
> >
> >      -a 80:00.0,source-prune=3D1
> >
> > +- ``MAC Anti-spoof Disable`` (default ``1``)

Suggest removing "Disable" from this headline, to clarify that the =
default 1 value enables MAC Anti-spoof (does not activate "MAC =
Anti-spoof Disable").

> > +
> > +  Disable MAC Anti-spoof check in the Tx direction to send outgoing
> > + packets when their destination MAC address matches one of the  MAC
> > + addresses assigned to that same NIC port.By default, these
> outgoing
> > + packets are dropped due to MAC Anti-spoof check.

The default 1 (instead of 0) is a temporary workaround due to CI issues.
This (incorrect default value) should be registered as a bug in =
Bugzilla.

And a warning should be added to the description here =
(/doc/guides/nics/ice.rst) that the default 1 is a known bug, and is =
expected to be changed to 0 at a later time. This warning can refer to =
the bug in Bugzilla.

> > +
> > +  MAC Anti-spoof can be disabled by resetting the devargs parameter
> > + ``mac-anti-spoof``,  for example::
> > +
> > +    -a 80:00.0,mac-anti-spoof=3D0
> > +
> >  - ``Protocol extraction for per queue``
> >
> >    Configure the RX queues to do protocol extraction into mbuf for
> protocol
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> > b/drivers/net/intel/ice/ice_ethdev.c
> > index c1d92435d1..7251b111e0 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -42,6 +42,7 @@
> >  #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
> >  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
> >  #define ICE_SOURCE_PRUNE_ARG      "source-prune"
> > +#define ICE_MAC_ANTI_SPOOF_ARG    "mac-anti-spoof"
> >  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
> >
> >  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL @@ -60,6 +61,7
> @@
> > static const char * const ice_valid_args[] =3D {
> >  	ICE_DDP_LOAD_SCHED_ARG,
> >  	ICE_TM_LEVELS_ARG,
> >  	ICE_SOURCE_PRUNE_ARG,
> > +	ICE_MAC_ANTI_SPOOF_ARG,
> >  	ICE_LINK_STATE_ON_CLOSE,
> >  	NULL
> >  };
> > @@ -1761,13 +1763,46 @@ ice_setup_vsi(struct ice_pf *pf, enum
> > ice_vsi_type type)
> >  		/* Source Prune */
> >  		if (ad->devargs.source_prune !=3D 1) {
> >  			/* Disable source prune to support VRRP
> > -			 * when source-prune devarg is not set
> > +			 * when source-prune devargs is not set
> >  			 */
> >  			vsi_ctx.info.sw_flags =3D
> >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> >  			vsi_ctx.info.sw_flags |=3D
> >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> >  		}
> > +		/* MAC Anti-spoof */
> > +		/* By default, Source Prune in Rx is disabled
> > +		 * and MAC Anti-spoof check in Tx is enabled.
> > +		 *
> > +		 * Source Prune is disabled by setting local
> > +		 * loopback with ICE_AQ_VSI_SW_FLAG_LOCAL_LB
> > +		 * flag in the Rx direction.
> > +		 * ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to
> > +		 * prevent transmitted packets from being
> > +		 * looped back in some circumstances.
> > +		 *
> > +		 * MAC Anti-spoof check can be disabled by
> > +		 * clearing ICE_AQ_VSI_SW_FLAG_SRC_PRUNE
> > +		 * flag and setting Tx loopback with
> > +		 * ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the
> > +		 * Tx direction.
> > +		 */
> > +		if (ad->devargs.mac_anti_spoof =3D=3D 0) {
> > +			/* Disable mac anti-spoof check in the
> > +			 * Tx direction to avoid outgoing
> > +			 * packets getting dropped as
> > +			 * TX-errors for VRRP support when
> > +			 * mac-anti-spoof devargs is not set
> > +			 */
> > +			vsi_ctx.info.sw_flags &=3D
> > +				~ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > +			PMD_INIT_LOG(NOTICE,
> > +				     "Disabling MAC Anti-spoof check "
> > +				     "in the Tx direction does not "
> > +				     "affect Source Prune in the Rx
> direction");

Try shortening the log message to fit on one line, so it is easier to =
"grep" for.

> > +			vsi_ctx.info.sw_flags |=3D
> > +				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
> > +		}

If implicitly enabled, please PMD_INIT_LOG(WARNING, "MAC Anti-spoof =
check is enabled"), as this kind of filtering is not the behavior =
expected by normal applications.
We can probably not distinguish between implicitly and explicitly =
enabled, so simply log it if enabled.

> >  		cfg =3D ICE_AQ_VSI_PROP_SW_VALID;
> >  		vsi_ctx.info.valid_sections |=3D rte_cpu_to_le_16(cfg);
> >  		vsi_ctx.info.sw_flags2 =3D ICE_AQ_VSI_SW_FLAG_LAN_ENA;
> > @@ -2398,6 +2433,7 @@ static int ice_parse_devargs(struct =
rte_eth_dev
> > *dev)
> >  		return -EINVAL;
> >  	}
> >
> > +	ad->devargs.mac_anti_spoof =3D 1; /* enabled by default */
> >  	ad->devargs.proto_xtr_dflt =3D PROTO_XTR_NONE;
> >  	memset(ad->devargs.proto_xtr, PROTO_XTR_NONE,
> >  	       sizeof(ad->devargs.proto_xtr)); @@ -2467,6 +2503,11 @@
> static
> > int ice_parse_devargs(struct rte_eth_dev *dev)
> >  	if (ret)
> >  		goto bail;
> >
> > +	ret =3D rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_ARG,
> > +				 &parse_bool, &ad-
> > >devargs.mac_anti_spoof);
> > +	if (ret)
> > +		goto bail;
> > +
> >  	ret =3D rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
> >  				 &parse_link_state_on_close, &ad-
> > >devargs.link_state_on_close);
> >
> > @@ -7732,6 +7773,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
> >  			      ICE_DDP_LOAD_SCHED_ARG "=3D<0|1>"
> >  			      ICE_TM_LEVELS_ARG "=3D<N>"
> >  			      ICE_SOURCE_PRUNE_ARG "=3D<0|1>"
> > +			      ICE_MAC_ANTI_SPOOF_ARG "=3D<0|1>"
> >  			      ICE_RX_LOW_LATENCY_ARG "=3D<0|1>"
> >  			      ICE_LINK_STATE_ON_CLOSE
> > "=3D<down|up|initial>");
> >
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> > b/drivers/net/intel/ice/ice_ethdev.h
> > index 72ed65f13b..5fe4688d57 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -617,6 +617,7 @@ struct ice_devargs {
> >  	uint8_t ddp_load_sched;
> >  	uint8_t tm_exposed_levels;
> >  	uint8_t source_prune;
> > +	uint8_t mac_anti_spoof;
> >  	int link_state_on_close;
> >  	int xtr_field_offs;
> >  	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
> > --
> > 2.34.1
>=20
> Hi Morten Br=F8rup/Bruce,
>=20
> Kindly review this patch. No CI errors reported.
>=20
> Thank you.
>=20
> Regards,
> Anurag M

