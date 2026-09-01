Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24967C624CF
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 11:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 345AA4065A;
	Tue,  1 Sep 2026 13:11:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 379274064E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 13:11:09 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0376E20784;
 Tue,  1 Sep 2026 13:11:09 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC] mbuf: add configurable base private size for pktmbuf pools
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 1 Sep 2026 13:11:08 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A29@smartserver.smartshare.dk>
In-Reply-To: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Index: AQHdOXCgdP+ENN3UFk+QdyL24xrKUra5fBPQ
References: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Randy Tice (rtice)" <rtice@cisco.com>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

> From: Randy Tice (rtice) [mailto:rtice@cisco.com]=20
> Sent: Monday, 31 August 2026 20.20
>=20
> Hi,
> I would like to get feedback on a proposed mbuf change before sending =
patches.
> Some deployments need a guaranteed private-data reservation in every =
packet mbuf, across multiple mbuf pools and across different consumers =
of the mbuf APIs.
> Today, each pktmbuf pool can request a private size when the pool is =
created. That works when the application owns all pool creation policy =
directly. However, not all relevant mbuf pools are necessarily created =
by application code. Some pools may be created by libraries, drivers, or =
other components outside direct application control.
> One example already in DPDK is vhost crypto, which creates its own =
mbuf pool and supplies a private size for struct vhost_crypto_data_req. =
There are also driver-created pktmbuf-style pools, such as cnxk inline =
meta pools and TAP GSO context pools. These are examples of =
pool-creation paths where the application may not directly control the =
private-size value used at creation time.
> A PMD-specific devarg could solve one instance of this problem, such =
as a single driver-created pool, but that seems too narrow if the =
requirement is not inherently PMD-specific. A deployment with multiple =
drivers, libraries, or other pool-creation paths outside application =
control could need the same base private-size adjustment. In that case, =
configuring the same value independently through component-specific =
options would be fragile and easy to get wrong.
> The proposed generic model is to add a configurable base private size =
for pktmbuf pools. The effective private size would be:
> align(pool_requested_priv_size + application_base_priv_size,
>       RTE_MBUF_PRIV_ALIGN)
> The tentative EAL option name is:
> --mbuf-base-priv-size=3D<size>
> The intent is:
> * default behavior remains unchanged when the option is not used;
> * the configured base size is added to the private size requested by =
each pktmbuf pool;
> * the final effective private size remains aligned to =
RTE_MBUF_PRIV_ALIGN;
> * pool-specific private-data requests still work as they do today;
> * DPDK centralizes the policy so pools created outside application =
control can reserve the same base private-data space as =
application-created pools.
> This is not intended to define ownership or layout of the private =
area. It only ensures that a deployment can reserve a common base amount =
of private data consistently. Applications, drivers, libraries, or =
components would still be responsible for their own interpretation of =
the reserved private area.
> Questions for the list:
> 1. Is a deployment-wide pktmbuf base private-size reservation =
something DPDK would consider acceptable?
> 2. Is --mbuf-base-priv-size=3D<size> a reasonable name, or would =
another name better describe the intent?
> 3. Should DPDK expose the effective-size calculation as a helper so =
pool-creation paths outside application control can apply the same rule?
> 4. Would maintainers prefer consumer updates in the same series as =
example users, or as follow-up patches after the generic mbuf/EAL change =
is accepted?
> 5. Would maintainers prefer this to remain component-specific, even if =
more than one driver, library, or pool-creation path may need to apply =
the same base reservation?
> The main goal is to avoid downstream mbuf layout changes and avoid =
component-specific configuration drift, while still allowing deployments =
to reserve a consistent private-data area across all packet mbuf pools, =
including pools created outside direct application control.
> Thanks,
> Randy

DPDK already has Dynamic Mbuf Fields for run-time management of private =
data across all mbuf pools.
DPDK also has the Private Data Area (priv_size), but that is individual =
to each mbuf pool, which does not fit your use case.

Dynamic Mbuf Fields is the perfect fit for the use case you are =
describing.

Currently, it only manages a few small memory areas inside the rte_mbuf =
structure itself, the dynfield1 array and the dynfield2 field.
But it could easily manage one more memory area associated with the =
rte_mbuf structure.

If we want this to be build-time configurable, it should be relatively =
simple to add:

In config/rte_common.h:
+#define RTE_MBUF_DYN_EXTRA_SIZE 128

In lib/mbuf/rte_mbuf_core.h:
	/** Size of the application private data. In case of an indirect
	 * mbuf, it stores the direct mbuf private data size.
	 */
	uint16_t priv_size;

	/** Timesync flags for use with IEEE1588. */
	uint16_t timesync;

	uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
+
+#if RTE_MBUF_DYN_EXTRA_SIZE
+	/** Extra dynamic fields. */
+	uint32_t dynfield3[RTE_MBUF_DYN_EXTRA_SIZE / sizeof(uint32_t)];
+#endif
};

In lib/mbuf/rte_mbuf_dyn.h:
+static_assert(RTE_MBUF_DYN_EXTRA_SIZE % RTE_CACHE_LINE_SIZE =3D=3D 0,
+	"RTE_MBUF_DYN_EXTRA_SIZE must be multiple of cache line size.");

And some associated additions in lib/mbuf/rte_mbuf_dyn.c.

<feature creep>

There may also be considerations about what happens to the extra data =
when:
- Copying an mbuf.
- Attaching an mbuf to another mbuf.
- Detaching an mbuf from another mbuf.
- Cloning an mbuf.

(The considerations apply to both the packet mbuf itself, and for the =
non-first segments of a segmented packet mbuf.)

The developer of the Dynamic Mbuf Fields library was foreseeable enough =
to add a "flags" parameter for dynamic mbuf field creation.
This could be used to specify what happens to each registered dynamic =
field in the events enumerated above.

</feature creep>

IMO, the extended size of Dynamic Mbuf Fields should be build-time =
configurable.

If the community wants the extended size of Dynamic Mbuf Fields run-time =
configurable, the size should be an EAL startup parameter.
It could be named: --mbuf-dyn-extra-size=3D<size>.
The major difference in implementation is that the space for the extra =
dynfields must be dynamically allocated with the mbufs at mbuf pool =
creation.
Notice that the memory for the extra dynfields should be positioned =
between the mbuf structure and the private data area, so their offsets =
remain the same, also for two mbuf pools having different Private Data =
Area sizes.

-Morten

