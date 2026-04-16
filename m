Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD72F8A16F
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 13:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85CE5402ED;
	Thu, 16 Apr 2026 15:19:45 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by mails.dpdk.org (Postfix) with ESMTP id 091C740144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 15:19:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDk7t/WTMwq6SnRNQIfWtkqvGVUYrPx86qMlD25eLTUbtHEzpuLCIk6BznHCqqBYpOOCCTKedNai7TIkJeQubF+jK5loaAvixiBLsxJ7OLDvhdR1TC7RjLB43/g/IWp1oyz1v/gBgN6HYsRvAkep2GXRsM4HpFAN7ylSpO2Rl51/J9eIYVSAzOy9xWp1/RY1P0pkjWc6AaQ9H3FazuT6tYiuu/+UCRJj3SpQhStx1AQNsqmDqgYQBrN3PyNenbpBjNRRw9h/2oi+nM3oZN+GvEaYFv346LGcAVgKfwMx0rbKBte2dc++RlevsvwCqOiCqu2mhJRW6gU3Hod81grafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/QYcWkSJq8/IMbsIIipTxJpLGYNPASNlfqrySC+FaI=;
 b=GO7tqX7zrb/+9/Eet9gsuWhIVZTmUGkHzVtaP9+b96oLWVHfRFJduagogqQiDHxp/YVN71cyoYt7L1xeddcKDO3DzwocSH18SCF2137VWKsn2Et+dAdEuZgstmU03AjghYlW8F/weJ4uQszON8VHyTHuIVOdBFQyvrnLg7aUwCuxoLXUkJ0fmDhs4lKbwwHEKn2/zaFQHEkODM8MtxGGiT+hChBqDt5/nVlwcuay3kP9orAka6Jwxe7xNzxNxhrqKgxXl36oBI93eRrhC8sy22AOMRL0WHqZAeD1l/ItMUrwhOVHdfpJCOdtke4G5uIQ0dBcNo2urXnOjty/VIDUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/QYcWkSJq8/IMbsIIipTxJpLGYNPASNlfqrySC+FaI=;
 b=AyCDPs80BzbI1rl1mp0ekzeCnGKyTx7e+8fG1CkimuyIRsbPNhWTN6ub0gZKslD0YKIBCF8e0naQ/4jopcW0FuFOr7iC0v+6yFbJgI4MHJ33gumlrlS0roq6wJGcHk0CBabTaKvs+SaN9pLLvNCPwMdvvuukMw8lf4gbsMG33og=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 13:19:37 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::5909:724e:563f:49d1%4]) with mapi id 15.20.9769.014; Thu, 16 Apr 2026
 13:19:37 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "Tummala, Sivaprasad"
 <Sivaprasad.Tummala@amd.com>
CC: "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "viktorin@cesnet.cz" <viktorin@cesnet.cz>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: RE: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Topic: [PATCH v5 v5 2/3] app: add topology aware test case
Thread-Index: AQHczEan2CVlJsJLuUK0NGxNpAvD+bXhSnKwgABjhRA=
Date: Thu, 16 Apr 2026 13:19:36 +0000
Message-ID: <PH7PR12MB859644299B4823DD03A125DD82232@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-3-vipin.varghese@amd.com>
 <PH7PR12MB85969978BB6EB2C2E9034A8E82232@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB85969978BB6EB2C2E9034A8E82232@PH7PR12MB8596.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-16T13:16:49.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|PH7PR12MB6836:EE_
x-ms-office365-filtering-correlation-id: d342e569-884b-466f-6b49-08de9bbacee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: NooVRyHu8Cji72/BPYR42EqN8i9JvAfY3olJc7MYp+2NCN8UwRjeGU4+Cns5ClQAm6KeNV7jNI29lbZ4o56B7VZAem1AUH5cFZMA9NbonlnvzNq996pVqznSn7/Brye6Sw0RpQcoyTBTNeiK2LcXGvRNJJ8XU6jrft2olrcJ5O1cWKiVzm/Yqh2wdOOsxGLH3DBLtd2nkWO91YrcZ0HKTNS2ICSI2xnH4M1vRt1yNhde+XLjlkqMY7tlaIf+ZcD8ARrRWhiDl1eUiwVF0PXotwsmj0eAVL0elv/KvZ+51OZWQ3SyWq+ogCFgD6an4j9FeCmrCl21qe4EQddqIAZhD0Agsn0yhPlUbVTKPIo/uMOEKzHFGXnJLvc/s4GyjK1UUA2+nKDhH/TXbHCdYwriMNBch0nv1POQYznIVoLTwo8vKK3r1Zpo59Q5v9pYkctN2rlk3TIRYo3I9cXGn2e1krwpu4ptWEaeaP81FHtRWmm2RE7tQ2mQRHiqfKvMt6XWvIYJkATCpV/UqMQPVDVG7SC+6o/h187EBOX4z3WS7azvTSGeEI5Y6R2QMJWtIkL1E+Z7zB7/XaDn3M9euBNlfkkEl3ivACUyT12i2mRudUm0PWdOPxhK1EXe6a/vkvbpCBZtPUqczi/nRwjeicJrCDa5EgNmdluPwW35+cAkFievNfVoeK9ULKdchWURXO5Fjkvqz/rK3Pz107zwpymtV4uwj4UO1nzR1QU5u+YJDZnJQ3MZWl/pu2VGlYu4VQJO0g+Hm2b9jveegdE14oA20Vha5vlQN/JPddGkpV8WBHs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HFl7huAPkSob5hcS4OdRzynwEYlZCTNprQ7umiuV8KWbvQfGtZDjgnFNw/y6?=
 =?us-ascii?Q?hHwe5au3dWhtm+UhUL9FAhP8d1LqOhfoYyFuzIHb1cagTmNuYuY2fcNohI6b?=
 =?us-ascii?Q?3uUu1GZ0xpjt5V4xJO0uD0mpqISrbztVAkrgutT41tY1MAXLXubqZOsOG489?=
 =?us-ascii?Q?T3FxER4+Sq9Jyy7URqkk5tNDDjFXIirCV5tlOPuo49+16MiGq9mzlLnKG8J4?=
 =?us-ascii?Q?ssu0bdQKKLGeOu+fw7PGW4MBdvGybZ+FeUEcWPUtF/dwzt0pwH5Xl0FqmmKy?=
 =?us-ascii?Q?bgc/pzVNQxrPFdN6Fs1kQ8aCM1nSenQ4ZvsvdZETVevOURn9fq3FqGE9fXAu?=
 =?us-ascii?Q?LqEA4LKVE/3FwF5HilN5MxW+B+VFjMVT3i9VhwgCd6Q8ExM/A8JNMOfjnK/K?=
 =?us-ascii?Q?8rwRZEAloONBmZ9js6xXQQn0ApxWQwW+BwUh0yEwOvmR4dZEtQwY2c2Ww0Yi?=
 =?us-ascii?Q?15HhsUMhmcvAB1YeBTA3I5W+EPjvk3N9Kh46gljwYF9pslaZCchd0ZesC/Ad?=
 =?us-ascii?Q?x1mpqpEdf40jzQfmPoXMDYWeUX177p8c7dCeRSjdY6RdHeikgPWDA+GdNis7?=
 =?us-ascii?Q?mWIPxpZKNC2/IcHfgIwUrZIXdN3YlXoeglJ672KUCVj0nXvNNA1DkGGSt9UO?=
 =?us-ascii?Q?buYV7a3TlrfrCGEY98ZD3+snWYvJxVWw3JzrgeNJDJdyfzWsLvExMtgoOCRR?=
 =?us-ascii?Q?kja3eklD9+ZITug+wEXDZJ0bHqN2M9/WcIPy7ZqI/gbuGS6EmqviSEjHBR8a?=
 =?us-ascii?Q?yln5vufTC5wSAGBM5hJJxYwS1GwBeuXyPNGZjbhVJZB6JTYt8B7ndI8cIQf6?=
 =?us-ascii?Q?2tOfP4VG/rB5VcsD0/PTumOcmpNBs5KGSvMZ89NmkSXduWVsfT/HUt9uEni2?=
 =?us-ascii?Q?9QgaIeL0pxb7N+v2VbiN7B7PoZqF9h5dPQntSUNqstXc5wgOkKa3pdUxFloG?=
 =?us-ascii?Q?/pI5qws8ThfgSN9/RaO0SU5MK3KgxvMK3N1jWKZH9h5LTODk6CX0H28IO1Np?=
 =?us-ascii?Q?fEymbxYcw3MgAFU52dVlOcVyGb75H8YmAZzIfKo81mLIygaYb4at5PJFTUDS?=
 =?us-ascii?Q?U0PqfLaAtW7/u6foRzCn85y005GTN7hLdzTFL6Qy2P+oFw+Z759kuIGuRta9?=
 =?us-ascii?Q?pCC1car5FzlLPa7u4/RL2ZQj1adfX72TdrBEaXyA7yHoEo7IbQbzIpt8aEuP?=
 =?us-ascii?Q?vOxGp5zchPmKQHcsD9J2k0CKDTzILa4PJaohUx9w1wfGvb6BNNL4vgKYrUvs?=
 =?us-ascii?Q?a+0YDEQnXm8WystIGeczoNYUBN6EwYASHbcElKQQInDeprcqLyt/wEkKicD2?=
 =?us-ascii?Q?OAILlY8U74bvFe6kL6zeJJ9Q3sumymRpcLfoe/50ErRtLeFVNQNvWJH+oHtp?=
 =?us-ascii?Q?afJw9osQ1Hwpo4EedAD7ZLxg4iGGNE6irQn+PTB0ytJ1Ky9xXtHsNMt/jSM0?=
 =?us-ascii?Q?jwENwVA2kQwsyVQcPovewmEMFMe7fSwgC2/VAO8s/TiJA0IQH1Pi6+61HduM?=
 =?us-ascii?Q?VJB8DzK6IOjpw0Q1suu9S7TUDL5XXnIvTf0q/IK8hvUg54q+cx3Bcc0qkwNM?=
 =?us-ascii?Q?oDZaOuKIYBEOgvJ/SPHwps6iWCv1zwdtEjWboWVkjqxd3hIO+roDeZ10x6mw?=
 =?us-ascii?Q?k/k97y0y9PbjiqPQ4Uvb1F0xDca4mTHSFf4yliHEQn7hB3D2o3LkNqH+qdAx?=
 =?us-ascii?Q?xzDENxT+Bihe0XbVZz6eVG+bXII9LKwR4qFW4v55r4NvtvJI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d342e569-884b-466f-6b49-08de9bbacee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 13:19:37.0108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwBtJVjOFNb6lcOq4Yu9vmG6bvu6qcn30K5uZBSRl0iDfG0/UMghI9/nSQn78JUTNF9wwKML/aYduEwoN/P7SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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

[Public]

<snipped>
>
> Unable to find `Sudheendra Sampath` in dpdk mailing list and Slack. Can y=
ou please
> connect with me email address or slack.

Hi Sudheendra,

Thank you for the suggestion and welcome to dpdk review too.

My initial code design were

```
#ifdef RTE_LIBHWLOC_PROBE
+static int
+get_same_domains(struct lcore_pair *lcp, uint32_t domain_sel)
+{
+       if (rte_topo_get_domain_count(domain_sel) =3D=3D 0)
+               return 1;
+
+       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
+       unsigned int domain =3D 0;
+
+       RTE_TOPO_FOREACH_DOMAIN(domain, domain_sel) {
+               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
+                       break;
+
+               if (rte_topo_get_lcore_count_from_domain(domain_sel, domain=
) < 2)
+                       continue;
+
+               id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0, do=
main_sel);
+               id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0, do=
main_sel);
+       }
+
+       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
+               return 2;
+
+       if (id1 =3D=3D id2)
+               return 3;
+
+       lcp->c1 =3D id1;
+       lcp->c2 =3D id2;
+
+       return 0;
+}
+
+static int
+get_two_domains(struct lcore_pair *lcp, uint32_t domain_sel)
+{
+       if (rte_topo_get_domain_count(domain_sel) < 2)
+               return 1;
+
+       unsigned int id1 =3D RTE_MAX_LCORE, id2 =3D RTE_MAX_LCORE;
+       unsigned int domain =3D 0;
+
+       RTE_TOPO_FOREACH_DOMAIN(domain, domain_sel) {
+               if ((id1 !=3D RTE_MAX_LCORE) && (id2 !=3D RTE_MAX_LCORE))
+                       break;
+
+               if (rte_topo_get_lcore_count_from_domain(domain_sel, domain=
) =3D=3D 0)
+                       continue;
+
+               if (id1 =3D=3D RTE_MAX_LCORE) {
+                       id1 =3D rte_topo_get_nth_lcore_from_domain(domain,
+                               0, 0, domain_sel);
+                       continue;
+               }
+               if (id2 =3D=3D RTE_MAX_LCORE) {
+                       id2 =3D rte_topo_get_nth_lcore_from_domain(domain,
+                               0, 0, domain_sel);
+                       continue;
+               }
+       }
+
+       if ((id1 =3D=3D RTE_MAX_LCORE) || (id2 =3D=3D RTE_MAX_LCORE))
+               return 2;
+
+       if (id1 =3D=3D id2)
+               return 3;
+
+       lcp->c1 =3D id1;
+       lcp->c2 =3D id2;
+
+       return 0;
+}
+#endif
+
 /* Get cycle counts for dequeuing from an empty ring. Should be 2 or 3 cyc=
les */
 static void
 test_empty_dequeue(struct rte_ring *r, const int esize,
@@ -488,6 +574,33 @@ test_ring_perf_esize_run_on_two_cores(
                if (run_on_core_pair(&cores, param1, param2) < 0)
                        return -1;
        }
+#ifdef RTE_LIBHWLOC_PROBE
+       if (rte_lcore_count() > 2) {
+               for (uint32_t d =3D 0; d < RTE_DIM(domain_types); d++) {
+                       if (get_same_domains(&cores, domain_types[d]) =3D=
=3D 0) {
+                               printf("\n### Testing using same %s domain =
nodes ###\n",
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_NUMA) ? "NUMA" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L4) ? "L4" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L3) ? "L3" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L2) ? "L2" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L1) ? "L1" : NULL);
+                               if (run_on_core_pair(&cores, param1, param2=
) < 0)
+                                       return -1;
+                       }
+
+                       if (get_two_domains(&cores, domain_types[d]) =3D=3D=
 0) {
+                               printf("\n### Testing using two %s domain n=
odes ###\n",
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_NUMA) ? "NUMA" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L4) ? "L4" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L3) ? "L3" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L2) ? "L2" :
+                                       (domain_types[d] =3D=3D RTE_TOPO_DO=
MAIN_L1) ? "L1" : NULL);
+                               if (run_on_core_pair(&cores, param1, param2=
) < 0)
+                                       return -1;
+                       }
+               }
+       }
+#endif
        return 0;
 }

```

Since it breaks the current function test format, I went ahead with current=
 approach.
I will re-introduce the domain iterator design in v6 for you. Please try it=
 out and let me know.

Regards
Vipin Varghese
