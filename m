Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F3C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18A7B40A6C;
	Wed, 25 Jun 2025 13:31:47 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by mails.dpdk.org (Postfix) with ESMTP id 458AC40A6C;
 Wed, 25 Jun 2025 13:31:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7LWujjs10UpuoasxpcAUzcNIUjXASzWaYaZJJsaZ3V+amE9g6I/EokNsFU7bysBHtW8GL7aym1ABYWdnscgKwRyMZ1XP4r3gwoikq2lTifJNEDNMv0Ip+EuBFkLORh6tT4pOLPCf4CfNCvQVNxC4H2IjgQVlS0pUrWgp6G4qeX4ICA4VjA9Q66XROMACScRRAMGE5+an4LQlj1mkr0vWFEVc4FcZRfN0e5KwekUHfV5G8V2LE6uDRpyIbRMZJEPM1zLtrOUfqLSNmvIMIjy7sfMREwmNMga+zfacd5VHyA0gooIByurQDh8ICaK6w/ghJx2+fNqSLKCjCWH0xnK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY9n3ydaaYg5UmqLOCtx0KJ2eNbdE43zTndnD8KDss0=;
 b=QMRfmwUjX3cNbUejeo+VTIz1g8oSRf35cZLWYUvKzH3TCEJm2IZZ/GaRt1Dqdt2PWYkRPdhvYbKdQrLPM8qzmRwmwZk+a0PEYZLdAUWVpTbpV35PjIud5K65J9aMiCh/ZGAj0gLSnXOli2j0ngWMgBBq2/GTAGTdim/UyTV1VkzuzlaeCFZbYN8jtBPFU6RpVzSjZs5w29r2F23UZ5Qdm3d93aCdD6mwQlmdRVkF3coOf3I1x4wutgUHobvbSGU3H6YRmdpuKMeq2C31t4oOgRufyb/RrkbJixvfqghprhkU69Z/O7q1kk4SQPWR/XVqaUbHZO6WDI6JMTn31OjNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY9n3ydaaYg5UmqLOCtx0KJ2eNbdE43zTndnD8KDss0=;
 b=mDtUptMt2Um7XgBzlTnpFaQ2UAuw3QWQYLC406VxY27C+cnCeNsTX8JBrRIA658gWJ1AU94MZk6ZdAKDugYz6eMboS+NjXXYsbHMpTXGP+Q1t7TO8qPiUTYGhJ5BpM97CHG4v/OCAtbhn3uZo+aetBCwLp3cneUenbu0z+r2aQA=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 25 Jun
 2025 11:31:44 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.027; Wed, 25 Jun 2025
 11:31:43 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 1/2] latencystats: fix receive sample MP issues
Thread-Topic: [PATCH v3 1/2] latencystats: fix receive sample MP issues
Thread-Index: AQHb35j5h2KFwSmgmEiRGtNbIfhR77QTxYQw
Date: Wed, 25 Jun 2025 11:31:43 +0000
Message-ID: <PH7PR12MB85960D943C91FE608DBA4C2F827BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250617150252.814215-1-stephen@networkplumber.org>
 <20250617150252.814215-2-stephen@networkplumber.org>
In-Reply-To: <20250617150252.814215-2-stephen@networkplumber.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-25T11:14:45.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|LV8PR12MB9713:EE_
x-ms-office365-filtering-correlation-id: 9d2ac126-3c1c-400d-23a5-08ddb3dbdcb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/x5G8rvjWYNGrSwKgbkyXPGth7ecasL39XKSosaWUgsfLG8HazfbXDmt9vnP?=
 =?us-ascii?Q?JJnxWo0ONeAP0V+3aguGSJBk86pGCZaV73azm05iEnwrlOH0osGJZWkXD/uR?=
 =?us-ascii?Q?p0ocNj+kBJcYesjhoKPw1hs4RdHfQ7OlOFTd1A/vRqJ7Y9wOjTN/Fovkuvo9?=
 =?us-ascii?Q?ytNY3Q5XoGLA+LmbJqd7PfgKA29rayIqYuWgPwkEnGF6xuCsNLjtROc2DQLS?=
 =?us-ascii?Q?8u7Q7Gjdn4kly4tVwWJiDvik2XOGwb7PNvyU9sNAftKXmosXuUw91yuzuUle?=
 =?us-ascii?Q?AxaebLF0lwU5a+uAj3Er9rnSLMmp1AO4eoOfVpZBr7EHKVVKGcoabpNwMAoT?=
 =?us-ascii?Q?gCzv4nEi/C8u4bL5t/uVcNhWqrx61yf1qieEKhR/FBeKBSMxoaiQ2l7ETPQo?=
 =?us-ascii?Q?rJNszcFvlJc2Nt78Mn98Fvit5vKdS6U9QcWF9FAoXsZBXpqlQ+X24IcKIItU?=
 =?us-ascii?Q?+LRMF2DO9/Udh86eVSQ4ZkfwiW+X5s9+5YtVEa/Lv2G4CmlhE71vsA+JtyS8?=
 =?us-ascii?Q?Lcwj+JDe9pP/P3U+YuV3y7+/nTbhc/fwck/BmbotDD2rD7CaQGB0o0Env/f/?=
 =?us-ascii?Q?d25jKXPSUcKRcAYOGwlyKHnNYokwVkeOpHZaSAHmJif5e1FtNpQBIEZAUort?=
 =?us-ascii?Q?qV7SdL/rk9OGpHFueboahM2fttjrBmIYsl5M0qxBmuWS8cSzUZYecWTMedgO?=
 =?us-ascii?Q?lLuAPBA2+5bhmjOSr/EOH7FY3kQEwC+yDSFUx+TF/Lq4ERcTfkR5oVdcYVJA?=
 =?us-ascii?Q?OT02kYxg0zwl0/I6kCe/aR1vGhNZcgrVKddWFmgeJqBJ94YP1Hnp7tM5IyJs?=
 =?us-ascii?Q?eK84hX/Ru9pknJgq6+ylqku6haG8wte+kM/238YllwOx6zGELYCin4KSumGU?=
 =?us-ascii?Q?StTKWv52IrJq5GQf6gnP+NEONId34WXqFfIXTUukueEeX3PLR+eWV3GdsfDW?=
 =?us-ascii?Q?SS1lwjtoQ05BDqJ/gXa3dhWfkYdRazZK8XuEzLX38AgV4rHcrmb/iuHhFpDt?=
 =?us-ascii?Q?6sIfUe35J/pcHTXEdfjADd4/IkL8IssTPMl6Ev3w2clztqQwDlSyPEqLAycf?=
 =?us-ascii?Q?vy6zjwDQ67fi+YZ4HF+K3X6VQpz4Q3qo0Sk9585+4SoEEFihblhG0SKVEnUe?=
 =?us-ascii?Q?uA4LKaK6zxMqYAKXoPS1Q1WczQUfTgJ7K2PuUHlteC7qMxxVd24e4KYBF4Bd?=
 =?us-ascii?Q?uxgTPx4JpuUxuy+t3H7ttqBhOj+fOeA1fJ8jVij1wn9WlbDUd+cS/LbD48Vb?=
 =?us-ascii?Q?9B4MhxH+kD9saWWUbB6ylJp/LdqtVr807s7CgAh8Jwb66/UXg3Td3fwOcEkY?=
 =?us-ascii?Q?RfzBUTYuSCTvUsJwFT+7fSZG79dStx0MLW3WAIjj7m9u49TArHDZ6ccTXrUi?=
 =?us-ascii?Q?ymJ2B7K/99/TuFmyelcwa2syIBhLBJ53XPbPB5jnzvFe0MtKyZ2p1agJO9oT?=
 =?us-ascii?Q?9lITiTL3wKFxu8ErSawijOCMRbEmmoWTsUxGp4Ce16yiawfq+UK1GR+8zmTt?=
 =?us-ascii?Q?DwsJuBt2Vm2smjw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?inBCqF/qqDvEUYjUPqCmhIuGxI74WT4T24KnWFXN5cCp18RK+/IRRSumyurI?=
 =?us-ascii?Q?uTqgxfQMkPLCyR8N+yJJusmlvFwV5oEITcbxSiz8/6KU0RmHN6Jo272e2NBV?=
 =?us-ascii?Q?mG3ghtnPTHV+fiKoBi5Pt7GOk3aYAaRsYwuGKCOu+Qy1rsyHkfjRR8Y+rJVr?=
 =?us-ascii?Q?fmrSeAwc/3eWBty05k5xuIpEcSomJtWesw3yuwM2QpWKJDzXObQt+Uf3g8O2?=
 =?us-ascii?Q?/ibXTw246p8umWpw141+n7d0AwaIRH0lT49L/AqwcY9clac+zaSZrSHXFfXj?=
 =?us-ascii?Q?kkh+A5PYQCEcif97+lCYc6VopJHlQgXWDQ/5f5IINjMhx4euKKHFzDmsekp6?=
 =?us-ascii?Q?sHfPM8BmchLcZrWVichjAt6/bo8eKAaO8suxgpukTAZFWyp58oeHSKdlDYi2?=
 =?us-ascii?Q?p+mnyo5caYnmZmbZ77SY+hT3OFGwU4A7EiWpBbA3kZBIF+gdj/9f1H5RECUq?=
 =?us-ascii?Q?MAZr6fpxeU+AGlgOT5fjeFsW1aSDqlB8zT3ZNg0vFMs4UU8xjX31IjSR2Etr?=
 =?us-ascii?Q?PaSo+L+It9QNNBOljX1agsr74wkEdd1+X76fglFNeyfv1/cJd92eZY6YD5pG?=
 =?us-ascii?Q?cftGT9gje1PwAcaW/qBJiUz5mNiUK4bon5u7/SQIMAykDTJzpLDb8jBRGatx?=
 =?us-ascii?Q?7uniLRxbmNvV/3lOR5uJzgKzM7PcI+Y9TlfyL754UyWL8PaF5gKCtbIzMcgy?=
 =?us-ascii?Q?uYB7hVn1HbjFiNFRLiihp9KuJzwOIkA/yAuZZISFXeP8fcsYwZ7SJBgu5mLh?=
 =?us-ascii?Q?cyOfIZwi2i7788AK+/4BQcwcDMq1ebQQ5CoJwRNHULKPOVz2fJKLcEJF0Wf8?=
 =?us-ascii?Q?M9p6Y3gtwN5WObeGS/O8oWGMue4bH7rwy6VTmyjNE19uz/4mk7l3bD4KJVWl?=
 =?us-ascii?Q?j5wHK2ObVpWLkUt+4SDTODIcWH2zxoAEktdEw6jt9I3b/yYDWYdOFkBtb/RI?=
 =?us-ascii?Q?yl27SbxbVHDuxru92w6FgVH605ay6K+3xO0GzT/y3Bb9GW6H76yJw/0SqDeb?=
 =?us-ascii?Q?vEYjZfIwhtik6JjIalL1Xle4wvc71+za4ZK8H8/FvZVyZXxYmHkb/FtUtn39?=
 =?us-ascii?Q?2oqc3cpA5lFGAIyFK9P8w8ziZhC5irD1mCJwShD2dKptXGscgRNBHGUsAwyB?=
 =?us-ascii?Q?lkmTW0tFUfOmVuI09aJWxQacaetUA0rJOi8CH5G9R6Brg8O0h8GRVblgtvij?=
 =?us-ascii?Q?ssTx5fde5hw1CJ30aPF0Lgp0f8aGM86bZO4ABxEnnwld6K4tECbPvXvuK6Rq?=
 =?us-ascii?Q?ArhJVgGfPBLifvfGnzn9cMAg+KWRnf2VBX1tIx9U61BIhdzqb5pGj3SS0j0U?=
 =?us-ascii?Q?UqoiJUzps5j32NOvQb4iOA+S2Pmp97w6kXYXDAO85sM+ZFJB5Nk23utqkIf4?=
 =?us-ascii?Q?kd12PZ4YKaj7qMotXNp64o87vica/cjgILkIjl8Hd/HW1QqlDVlVCSDf5idM?=
 =?us-ascii?Q?yJH1iOduBr7PNvhRzz3Z3W/a5uMZfrRVN4lIU9R68omO4wioa34b/A4YRy/r?=
 =?us-ascii?Q?HhYsFVcGwMI8xPIDlW7XRSC0WFmBJhh82lFoqukTLREmaGZy4SBq7L+QNdQj?=
 =?us-ascii?Q?vHW8wo2jt8aiQggrwp0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2ac126-3c1c-400d-23a5-08ddb3dbdcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:31:43.8159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/Quzj44j6n0LAvXsrZWQa/kskscB83ZoHHorV1qTMBdeWkMTKDbR5ZepdimTXytyrO4YTqHmIfkExGddzdqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi David & Stephen,

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, June 17, 2025 8:30 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org
> Subject: [PATCH v3 1/2] latencystats: fix receive sample MP issues
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The receive callback was not safe with multiple queues.
> If one receive queue callback decides to take a sample it needs to add th=
at sample
> and do atomic update to the previous TSC sample value. Add a new lock for=
 that.
>
> Optimize the check for when to take sample so that it only needs to lock =
when likely
> to need a sample.
>
> Also, add code to handle TSC wraparound in comparison.
> Perhaps this should move to rte_cycles.h?
>
> Bugzilla ID: 1723
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: 5cd3cac9ed22 ("latency: added new library for latency stats")
> Cc: stable@dpdk.org
> ---
>  lib/latencystats/rte_latencystats.c | 55 ++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_l=
atencystats.c
> index 6873a44a92..72a58d78d1 100644
> --- a/lib/latencystats/rte_latencystats.c
> +++ b/lib/latencystats/rte_latencystats.c
> @@ -22,6 +22,7 @@
>  #include <rte_metrics.h>
>  #include <rte_spinlock.h>
>  #include <rte_string_fns.h>
> +#include <rte_stdatomic.h>
>
>  #include "rte_latencystats.h"
>
> @@ -45,11 +46,20 @@ timestamp_dynfield(struct rte_mbuf *mbuf)
>                         timestamp_dynfield_offset, rte_mbuf_timestamp_t *=
);  }
>
> +/* Compare two 64 bit timer counter but deal with wraparound correctly.
> +*/ static inline bool tsc_after(uint64_t t0, uint64_t t1) {
> +       return (int64_t)(t1 - t0) < 0;
> +}
> +
> +#define tsc_before(a, b) tsc_after(b, a)
> +
>  static const char *MZ_RTE_LATENCY_STATS =3D "rte_latencystats";  static =
int
> latency_stats_index;
> +
> +static rte_spinlock_t sample_lock =3D RTE_SPINLOCK_INITIALIZER;
>  static uint64_t samp_intvl;
> -static uint64_t timer_tsc;
> -static uint64_t prev_tsc;
> +static RTE_ATOMIC(uint64_t) next_tsc;
>
>  #define LATENCY_AVG_SCALE     4
>  #define LATENCY_JITTER_SCALE 16
> @@ -147,25 +157,29 @@ add_time_stamps(uint16_t pid __rte_unused,
>                 void *user_cb __rte_unused)  {
>         unsigned int i;
> -       uint64_t diff_tsc, now;
> -
> -       /*
> -        * For every sample interval,
> -        * time stamp is marked on one received packet.
> -        */
> -       now =3D rte_rdtsc();
> -       for (i =3D 0; i < nb_pkts; i++) {
> -               diff_tsc =3D now - prev_tsc;
> -               timer_tsc +=3D diff_tsc;
> -
> -               if ((pkts[i]->ol_flags & timestamp_dynflag) =3D=3D 0
> -                               && (timer_tsc >=3D samp_intvl)) {
> -                       *timestamp_dynfield(pkts[i]) =3D now;
> -                       pkts[i]->ol_flags |=3D timestamp_dynflag;
> -                       timer_tsc =3D 0;
> +       uint64_t now =3D rte_rdtsc();
> +
> +       /* Check without locking */
> +       if (likely(tsc_before(now, rte_atomic_load_explicit(&next_tsc,
> +                                                           rte_memory_or=
der_relaxed))))
> +               return nb_pkts;
> +
> +       /* Try and get sample, skip if sample is being done by other core=
. */
> +       if (likely(rte_spinlock_trylock(&sample_lock))) {
> +               for (i =3D 0; i < nb_pkts; i++) {
> +                       struct rte_mbuf *m =3D pkts[i];
> +
> +                       /* skip if already timestamped */
> +                       if (unlikely(m->ol_flags & timestamp_dynflag))
> +                               continue;
> +
> +                       m->ol_flags |=3D timestamp_dynflag;
> +                       *timestamp_dynfield(m) =3D now;
> +                       rte_atomic_store_explicit(&next_tsc, now + samp_i=
ntvl,
> +                                                 rte_memory_order_relaxe=
d);
> +                       break;
>                 }
> -               prev_tsc =3D now;
> -               now =3D rte_rdtsc();
> +               rte_spinlock_unlock(&sample_lock);
>         }
>
>         return nb_pkts;
> @@ -270,6 +284,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
>         glob_stats =3D mz->addr;
>         rte_spinlock_init(&glob_stats->lock);
>         samp_intvl =3D (uint64_t)(app_samp_intvl * cycles_per_ns);
> +       next_tsc =3D rte_rdtsc();
>
>         /** Register latency stats with stats library */
>         for (i =3D 0; i < NUM_LATENCY_STATS; i++)


Application: testpmd io mode with latency-stats enabled
CPU: AMD EPYC 7713 64-Core Processor (AVX2) Huge page: 1GB pages * 32

Nic: Intel E810 1CQ DA2, 1 * 100Gbps
+++++++++++++++++++++++++++++

Firmware: 3.20 0x8000d83e 1.3146.0
DDP: comms package 1.3.53

With no args, Before patch (min, max, avg, jitter)
- 1Q: 30ns, 27432ns, 94ns, 19
- 4Q: 30ns, 27722ns, 95ns, 20

With no args, After Patch (min, max, avg, jitter)
 - 1Q: 40ns, 19136ns, 47ns, 5
 - 4Q: 10ns, 18334ns, 194ns, 64

With args: rx_low_latency=3D1, Before patch (min, max, avg, jitter)
- 1Q: 30ns, 27432ns, 94ns, 19
- 4Q: 30ns, 27722ns, 95ns, 20

With args: rx_low_latency=3D1, After Patch
 - 1Q: 40ns, 21631ns, 74ns, 12
 - 4Q: 10ns, 23725ns, 116ns, 112

With Solar flare NIC:
+++++++++++++++

throughput profile; After Patch (min, max, avg, jitter)
 - 1Q: 10ns, 23115ns, 96ns, 65
 - 4Q: 10ns, 2981ns, 136ns, 140

low-latency profile , After Patch
 - 1Q: 10ns, 19399ns, 367ns, 238
 - 4Q: 10ns, 19970ns, 127ns, 100


Following are our understanding

1. increase in multi-queue latency is attributed by spinlock.
2. the lower latency with patch for multi-queue is because the lowest of al=
l queues are taken into account.

Question: will there be per queue min, max, avg stats be enhanced in future=
?

Tested-by: Thiyagarajan P <Thiyagarajan.P@amd.com>
Reviewed-by: Vipin Varghese <Vipin.Varghese@amd.com>


> --
> 2.47.2

