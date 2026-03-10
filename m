Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DEFFCC9C0
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 05:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C9F7402B8;
	Tue, 10 Mar 2026 06:31:54 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 27C8D4014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 06:31:53 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A2qCvn3507751; Mon, 9 Mar 2026 22:31:52 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022088.outbound.protection.outlook.com
 [40.107.200.88])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8qwqsp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN9ctbJrUg9Lu+yKj2uRw9/FAALBpsnlvW7vRkFZUDcA6DBOACX3RRdAF++AROGXA8n4S3rE+Z+ToWmAgciCs1i+6Jgs802dkrmOizTSv4GV0CeSG2W/OStGjE8pa+hepw1kZ6xO8dI2JilYj0rl2pfAKdXK7moluElzP2Bl2O8uwvXvXzMZSmD5tUUEarH/2+BMkGvytlYJ/XwL9y/MdAwIx+KRB8V1kstZnFMWbyNBBYtd8LkDVBwci7SMw0jjLolldmmgJMrXSMH7sOPCLnWQIH9EB6BKrXUdEh4KmA+hgqr4w2fvnKqSFcDrbOy92Nb+zUC0Lb5HIAxyGYz+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY65ewRHhS9DugxqUlzdMcmp8VxA7Q2FmZgs6PynfaE=;
 b=qukx/zd2IRg6T4lIQDfhBKSt8abRHV2HPZMHqXehr6qAY67trFp1iqAmZcHDUCkT++wy1fMoYnxT1cM7cApjXPiD1EO8dJuqThBLUjaqbfQ6Ht2FUwsvwvkZ3BWzEXGf6uzU7H+cVtoch7cUU/Ug408U9z5ojpSK9Hlugn7GJgXy926fOodK68rTjmpaHv3WoJzNaNxgpZ1orC4DHQPjKLm2HkD2tcaO/YABvBLVJgC8H2lCOUFkQ86KHlMkK2x5eaE/D7H00fJx8Bv99eChzir9WeutEyXHmn8t/GcyCNVGssunJuh3GHR4h/n4AakcPfR/3uFhqFVuI9rqnBYr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY65ewRHhS9DugxqUlzdMcmp8VxA7Q2FmZgs6PynfaE=;
 b=oGe+sXnwx2wWCJT0RKMO8oRJSQIp6afg0Hr0QP3RcgGXmBSUSOu6v3WaFLDNRuwxh+D6G/qGsTF1sB0OaUa80Zm4P73HiFVtOwu6YZnbKR4hg9tVrvnIVDqg7GrY551Tc59xvpjCbmWJEN2WnaQi77qDlR2PGVXNRXbCzkcR7NQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DM6PR18MB3474.namprd18.prod.outlook.com (2603:10b6:5:2a7::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Tue, 10 Mar 2026 05:31:49 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 05:31:49 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] [RFC PATCH dpdk 0/3] graph: deferred enqueue API for
 simplified node processing
Thread-Topic: [EXTERNAL] [RFC PATCH dpdk 0/3] graph: deferred enqueue API for
 simplified node processing
Thread-Index: AQHcloGbJb7AqE62q0SKlWjqebNOIbWncH3c
Date: Tue, 10 Mar 2026 05:31:49 +0000
Message-ID: <PH0PR18MB4086E4EC631A4D23441C582FDE46A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
In-Reply-To: <20260205092630.100488-6-rjarry@redhat.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DM6PR18MB3474:EE_
x-ms-office365-filtering-correlation-id: ab198d88-a806-4a20-263d-08de7e6653e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 4GaxxYS++NFCQ9paak8mTYRoR5zlmhZgwkn+xOyJoNbJ1UBV8sooI9Pr1Sywy7+AaJh+kKG9+53uW1tpU0BUsvEaVfBbLihZYEGxCGBIdbQlv2vrfpKxeYTLm8wQYYI/OkvOvc/qyOCPvBmZp7F4ESGmIMS8YUOyZahhrpeY2n3bJVvy5WTcK8WqrZJ8SLymAhMtjC2ea7XalkgSgFBNCiOY3sIpYlyZ6V1uteYG8QdXBHklZvKi2KP4fDcP23frjkweOQOB7MIQ4ehwc89U80Xq6kYxy9huQq2cyNgMreFjBG+6YTXGVglscnVLpSu/jBjK/agspBrBElB9ZrydG8eERkwprX3kuGuuKwGEqtr2ZVPuG51YZva+QCDGIhTs+HUE+/QsjcV0c0KshfDOx+88JrzfFOeyyhB0pUESrTnPUJByvNeSMjYaool7u8g1fH5kce7gYgPOeN3EcliBHIrYuYrKB+maUxdzoMkno5qIGPlYu/jTXQa4700TWwBKwcjfJr80my6f5AuxSeKnAqLJiTIwFHExCMFzdoS2bDOVoc/F+NmNd5j+BAfxH1NH+fcRdshQg8quXo9sBUfyAWtwZp+QiBwTLFZKVSNfOQ5ByoHUhmCk0Aj+pYsi+c0rUpB5Esmfvhh2KzQGM5q33Fic3GmzgufIaqCC3tLMQhaQDn5YSWjxtash9MuTINENeDp6JyE2qzykeNLPpJWgOXbauKUQPTziMztoAcOY7CJsQTyeyZNTrI1GcxpNNjvqAzYgMVWzc4JX0VlUT0SdaXr2Pnv4S+zAZ6e9sm1IHbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?US9esJ70Py5BtoRXogzmMQAu0ZLqcXbqKEGyhao+N70igyP5H7i6M+zNCM?=
 =?iso-8859-1?Q?Z6PvUT1AuuIUIucNRyaeEJQUAyjOEsKMatSxa9TpWZvo11/3sq6JPgY7m5?=
 =?iso-8859-1?Q?6UV39i9lQqSeNgPJnd+Zi8ZyjAgmW2wzsQ8TNvJlgP5TosSa5UL5SuoKSC?=
 =?iso-8859-1?Q?NnIWAfGsTabx6m9xQDDb8FZNVTuvGMOTVGir/giRUHvN7+i9sUlUMcvHgt?=
 =?iso-8859-1?Q?73QhWUl0u+tEB7LAk9WgIv2E5Ss2zhMeRsST1R9n7rLyVWP5CHNqUMbpFI?=
 =?iso-8859-1?Q?82x2EmZarVy2XkEMqusU6mgcs9ZyPUDz7+2a6qwQZAM2vMEpb5WKMCAYD8?=
 =?iso-8859-1?Q?xB0cDSZ1rbLDkLDWEzGM+nXVGSZJHFru9sWgkwee7QBt/Uyp2hSf/kHnmb?=
 =?iso-8859-1?Q?AC0mhbQvhxcEKpHPHzMeTqEGAFUVoFppkJZHgB8lWLsnJ37Sp4UUXMoVlw?=
 =?iso-8859-1?Q?huQuUnNc3PIi3bUt4edK6CY5i9PqDvMRRRf8Dcy0bUY057NeY3ETLHeRA+?=
 =?iso-8859-1?Q?kfqAqVDk2IyMQDhn4cqlP+XJTw+LwATjnBNB6mc6I8RkvkzRy2M46W07Ux?=
 =?iso-8859-1?Q?MhL2L194UY/XUTxKtzDzvxk720iOfZOB94u7WeuW9QGxGpMLwUEVjKeWTI?=
 =?iso-8859-1?Q?0RO0M4Yt6Elk8KD97FVSqeTlf/Ub6s2CJXj1xTe0IkvbyVMVuVg9YGsYb2?=
 =?iso-8859-1?Q?dpfXFOB0IMXqNjXtxbvNpQ59VVFwJCpcOh0IolEKfGfxC5+56gd3vwYUrr?=
 =?iso-8859-1?Q?IidigaO5I62g0h0hTz5DSlK8bTUizd8fiG2EX1RO3NGw5iBpbhnNb3qC3J?=
 =?iso-8859-1?Q?mV8x6Th860zE/3bopAGrL21HK126usE356XKKHT/10qr7r0hs4XisB8SzL?=
 =?iso-8859-1?Q?H3dScL02S8Tt5MIo76j0IiRWw8eacwWUTpYvBacD3unhLWSWOXAS/7eMDf?=
 =?iso-8859-1?Q?0ia0ff9SOiTrGBJ0Uga63U0TpZW9j7ZweeRjpL/NcmjwYNYXrRas2ukWeN?=
 =?iso-8859-1?Q?5Ox3K85niLu1I0ZlCqNrXz+Z0CeKwtJka9uIZYoK49J2lT336PFUNKSbNW?=
 =?iso-8859-1?Q?bu8OAfSiuLmDngVOMaNGr+SaSq8dIKuBaat3OfFxvL4lsk2WjnPhbAqT0k?=
 =?iso-8859-1?Q?JqDaFJGpv+av3GTJBsJ8Sgoxmf+CyQgoxiGzaTw5Y3JHF6J4jmAqdfTwRS?=
 =?iso-8859-1?Q?FeUx3NbXbUA9asyNfRAQ11NF6PgC+mSsHw9j+xd/5DR55h9IdiDii+1XC/?=
 =?iso-8859-1?Q?Gg3wNvsWlu05k5tw07v3KB2pmO2OPN8LCVSQwXASBsHveHQCzkDsiqMP2n?=
 =?iso-8859-1?Q?vJ2jS15CuBVruKO/5bEmBMnQVl9A55IUr5NoiSpvMvtBwuKPU9E2F4fHKV?=
 =?iso-8859-1?Q?T0V15jVRoWmTSRqMolYMnX/HClVEyFJ1gg9F9k8wAlilnLHM+tEmpxlIV/?=
 =?iso-8859-1?Q?KM/LG3uAfHUZIFyDY5M43bZht6+4GSF3zWRnOVZkqgkFvnb/NB3IAGgcR8?=
 =?iso-8859-1?Q?3tpbIvQIr9CSgrArtclTWfQxNQ1SAnfnV4W0vaTec9tLsLXNWXRvF3Vysi?=
 =?iso-8859-1?Q?IXrBbrb+1R47U3QfAhpRba/8pzlIsiDTuOSszCVGKI/eKSuHrZ/kmmuH6q?=
 =?iso-8859-1?Q?1XjxUu6nvGSHUt3nGuxA1E5ENXf6N06tKp1yySmwz2c8LgD2avoKj4neBp?=
 =?iso-8859-1?Q?Qwf+84LwRnKMcfP5Nq2ez1joTnaQarpxNQD6C1sIFHiP2IdiwAhq+75zPi?=
 =?iso-8859-1?Q?JyKj2s4Xp5u7xTwGVyps/IecVPwQ9qcy16SI3Bt9duqR/oOriNzXOCiksv?=
 =?iso-8859-1?Q?98lqzO+66A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab198d88-a806-4a20-263d-08de7e6653e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:31:49.1966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbC+FueGr4U4GhTZz2jfinja4z5YsGTtcwwhUJElWgU3jHinntEQ+japa174oOw0IrD4H8SRpjyS0HvXPraRxaQZx43ZcPqUV0GrbKvFSB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3474
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0NCBTYWx0ZWRfX5ve+Nd066qcR
 wP6F8lDAEwwTTbhi8yPL7tuME3Gxgd8Emz91DhCObJjCW1nZoLGEK2QwwoWLGjajeMyscgW0dN1
 jnPxOjlXjJw5reiq8Jx35gcdh1L/G9g0vLxgazOUoArkGGbuFjM+dv6tl+/OKBUu+H1EoQnhoNe
 HmfWRAxyV2kXvAZAOaUabRcgV89y46D4OCS2Q8G2C1BlOV8LCLV5Oqjz5U8gq8jOtky+9y3FRZZ
 K2li4RmczAFAkHSzfilyF0ElsjdIspgqoCvlD07m0iatWMnsCXIW70+SqSVC3wk+WNSeSohn0AD
 3Bx7tQFXPxT3onZ7EeqUBou6NMW2CB+p6fePON8I6gI72UyJhTPla/pFAiOhXwDZiNB1jlNlCh7
 +LFRdAh3Y9KqEwvAZhBGphy1BzWLyvPuOf3QKQHvbchIQNfnwLaX+kkKmb8eQBXAv9OtNMc+HeA
 ZRsr7iiPiP/ceRdGRaA==
X-Proofpoint-GUID: pSuogiMlE-LThpNc0JzAdE56V0VGT4Gx
X-Proofpoint-ORIG-GUID: pSuogiMlE-LThpNc0JzAdE56V0VGT4Gx
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69afacc8 cx=c_pps
 a=72vqVjiraSETVmPwcAq+qg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=Ic4yoLHJP41jjXr-rX4A:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

>=0A=
>Performance was measured with l3fwd forwarding between two ports of an=0A=
>Intel E810-XXV 2x25G NIC (1 RX queue per port). Two graph worker threads=
=0A=
>ran on hyper threads of the same physical core on an Intel Xeon Silver=0A=
>4316 CPU @ 2.30GHz.=0A=
>=0A=
>Results:=0A=
>- Baseline (manual speculation): 37.0 Mpps=0A=
>- Deferred API:                  36.2 Mpps (-2.2%)=0A=
>=0A=
=0A=
On Octeon(Neoverse-n2) platform we see a slight performance increase ~1.5%.=
=0A=
=0A=
>The slight overhead comes from per-packet edge comparisons. However,=0A=
>this is offset by:=0A=
>- 826 fewer lines of code across 13 node implementations=0A=
>- Reduced instruction cache pressure from simpler code paths=0A=
>- Elimination of per-node speculation boilerplate=0A=
>- Easier development of new nodes=0A=
=0A=
=0A=
=0A=
