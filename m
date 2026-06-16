Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADB5CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 15:40:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E682A40289;
	Tue, 16 Jun 2026 17:40:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
 by mails.dpdk.org (Postfix) with ESMTP id 4B4EB40150
 for <dev@dpdk.org>; Tue, 16 Jun 2026 17:40:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtRNo9yNBOaYPMqRqZdSVDMOyXRy0Zc74jmLguri+j52A0Iahc2KKgEbKaobzahaPCE9r/IeQ7Uzn+70n5wFrqmcNQn2UK1AI4sJMYXrGQm5IBlecY77yITG4wUstcvmWdjaCbxRbxt8lQtEWeRmYgRHSZagTMtq3gRbmmIVAZ5RfWm+wf8UEBkDjDBkhX6CDoDZRhz76RH57VUFcisPDk762ERA0Ek3rO8DRnYk7heQKTwCh3TsrnknRCUTb0gP0vSPc02G5aXC0x1NS85l0ipn2LGEJEH8E9MEMvmodz3EuRA7+/CNOckasW9ZNOtfo0jTQ3uI0YD3v3DsH0HPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7MgrNZmtDonfGhYoktXAbIThS2Er09MwOWE586Ajvc=;
 b=e21waqQyLkBmQy5tL93OIWOfesBsPfGArbVNJelTz2A8hjd8OOaeIKqrSDm1YuSJ3Kk4y/Y3aqy1Fa9sgkaY5PJXXEGacoQsvofTvj7JqWztZ8GB8Vm6wc1fxHuVe9M7M5a6WfqL0UJvHIMVtI5HjPBOD7NRqG1uMKsrOG56gYLM4vh1Zx5JqtKajuhNwVzrwa4QAzRUiL9ecrE0ES53e7urANA7XzrOPyfUbLuqKJZinq1DaL+ShMFL1DsSKueUT7UqshGLxvR73DlO/lzOeJMAU+6qNr4+bqszU9iA/37hY50+1ZbQYvt5YNJdmQUtJSZ5Q73VTWiQ8ziTM3RUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7MgrNZmtDonfGhYoktXAbIThS2Er09MwOWE586Ajvc=;
 b=K1Ur5XfuP0wY4JzZ9lj8XSRPRCqhXnxyNmnE+i/BGAh0S+r3Lve04LQJTmbKp7RoUDX1SIIYJnCUKN4gyRl//7yYeZ5q4gso0BH899s1YG4OlZ9dKZoF1BKaCCpyByrAvYUIdIlUONZUgRXAz7wq/jOmax3hGkUqmBM+qDPAxRuKe1kfhgntYAKNd5ifbuqzUCnDrJsy8rWrsFyjUhX+SO57MZunwOY0SuPivWMR0MTOEw7ilOntloTXriwzJO4aNcU3AB9+NcA34KuvIDM7Rkj0k4FRyWtSvLKiylB4oi+7ctUo0bsM+aWsS0zyan9PFJj3e22LXV1FeXLyKv5cCw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DB9PR04MB9282.eurprd04.prod.outlook.com
 (2603:10a6:10:36e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:40:15 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:40:15 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Maxime Leroy
 <maxime@leroys.fr>
CC: "dev@dpdk.org" <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>
Subject: RE: [PATCH v2 6/6] net/dpaa2: drop the fake software VLAN strip
 offload
Thread-Topic: [PATCH v2 6/6] net/dpaa2: drop the fake software VLAN strip
 offload
Thread-Index: AQHc/XrMr3OEKWyl6Eq7EfUvl4M1mLZBOQAAgAAYwWA=
Date: Tue, 16 Jun 2026 15:40:14 +0000
Message-ID: <GV1PR04MB107509FA6AF5BEA46A72676DA89E52@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
 <20260616102727.708948-7-maxime@leroys.fr>
 <20260616071110.1baf1beb@phoenix.local>
In-Reply-To: <20260616071110.1baf1beb@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|DB9PR04MB9282:EE_
x-ms-office365-filtering-correlation-id: 29599463-8c0a-4780-8741-08decbbd8f81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|19092799006|1800799024|56012099006|4143699003|5023799004|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: qajjnq6etCG5vfgnGKpx9maW05IwFUyrpLtdsQ/eKYhlZMed5aQLDE3Z+j62hFa8Nk/fo0soAqWoxThfLp0fwvxkKw9tJcaafLiK+6SVvO0BU/WbaUQON3LIyMnYX53CclnkFJQTvR5AiKoAbWfQvjNfRCa6OOS20BY/gmgTT8iadN9WAgTTTyv3j13bVXEegBIAQLySfcoZKzbyiPUn2pM7HZt6lLFBISvf9sb1KWnloGBPzIPm7H8AnD3y9aea3oOcMd0aUWdYrUbC/lJp4tQWuB1+qni92LxumeuUtT/4vC7AvQlcJj6ajH5dwvhNMPdjcF1Wfumf23KrwaBrp4T3m4xxDaUzqupN93PqhohC92wMC4TwdfgJ6qr7i+w4B6JVSl45Iaf7M8eFAI17y4umqQLs5Dc2fhE+CVeuEQ6IW2CraOq4rRHljKHb+9rIR8NWMPMQ2LAJR8fVAxTlP2Xf+xBpKqZCNMoFFiNRdY5RB1+ggcJfkSudI9vjkBqPoPqlJFdL7ug3jZo6pEfnqhmog12OzQIzVlxtYkLUV3aTVa2wgPlrdkwMU1Q36Z3VWYSMEcNbXKYCrrVl/KH7QwWDMqc4P2+kbUmtMu3S9wEi2V8s+qeG49OM79ypGUTi9y8QKyAtolrPV+XIIXPEumVyU01SivZKjza/0SlbJhKGAVzVFulFxPnMomToHyGPoyPxIF06ashXZjLTpaMIFNUVcz8IWV9P5QGtwyfvqUMcjDAXlLipfgY+HRr7JV0f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(56012099006)(4143699003)(5023799004)(11063799006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Baya3IgojoJGkBBwpYmDKcEsRveJ5YbdelUadqoRkPq88m2bcBXzfK9oc/nz?=
 =?us-ascii?Q?2KEvQ+59TsOBS9ZK4L7+GjFoJ3BbFR/J/RXAT64YgZbu7TC4LonvoNqBLfnG?=
 =?us-ascii?Q?WlO9Gx+//SsE+c1qK8PIXwFZU3CYuVwM6liH1vJT3ptKwLX6tzfTOozr+2fP?=
 =?us-ascii?Q?0YC4uEwbxmwL+rjK23g7BClpHFrLdKjUF+dDzrdTKj/D2F/qtQVGuZFV/BVs?=
 =?us-ascii?Q?exsmXszQOiyokByqEW0jiQjlW+IpTED5+Np76pu13Wp2+g9x5xw0xGygy4fs?=
 =?us-ascii?Q?WSCcjUcf0juvCZQbnFLiQ3KWCdc4NJ+fC4rPtjcl4ysFDmkdvYyt8yVX2jjq?=
 =?us-ascii?Q?Jle89faHi89LzVVm6rJ/4nVvCGYRwEjCH0mUTNTqMzRyWnP4sO5fMCSLBd+9?=
 =?us-ascii?Q?LfVB1wU9rNLRYUlnf3/Rrg4yzYQWUc4sn6VWgpFoKFR4OWUEkYroxAGw0daT?=
 =?us-ascii?Q?67k/Fpcd/oOxOb/yVsabjc9GL+907V6AI9NxSMNZ1wAfZNbqjeckrhVEVuFv?=
 =?us-ascii?Q?zna0Ns/np0Hpc5Z+V+6NmdyM+alR+FFKTxo4kOKpUdyY11xZQ6zgRh4PWJ4V?=
 =?us-ascii?Q?i3Tt8YHw/dTSLhuRuik7HsXEDp0cnQUKDdjDssy2Qv9VCUVFipCTSYz+LrWv?=
 =?us-ascii?Q?Rivv4K5F6xOIw2lG9lEQx3kUwaaIVcWe12waaGqMjtiGOKqIvJ/bwG930wYS?=
 =?us-ascii?Q?kRmIlPliRGzGrYfbsJullZCiIRSbHb9mlM0AcFV/tDDjwrwbXes7mpVlxWBq?=
 =?us-ascii?Q?WtutybkNBJbg0Ya0PJKfpbPVOHARicvPeEGTLkj6HR/giI+MKHXKNwcozoMd?=
 =?us-ascii?Q?bqQoQpo8uE/gsHaH9GKEdjU2GsetMubNEbtzokcEzgZFNbpTa5wlXCLpKA2z?=
 =?us-ascii?Q?rUxjJQS9pnmtZH+te28BJ8pc7LmQVO1xm80pBHPrO9kCfOc8ljk2hoTdPjGF?=
 =?us-ascii?Q?vyNCYataGaNd9e1Iibq9cBk8VQK/PFQYL2f4C531kEmCl9awWlFJboRf61Xd?=
 =?us-ascii?Q?YstTxGzhM+wHzrfKDUgKAlVIJC6vvob7HNDwjT3cC8K47hjRBYayLtzrip/R?=
 =?us-ascii?Q?JXPxDobzi/H6CL8Amzve0Rf7yxa0uFd8mHZrclCB82kfsQT4OhRFlfgX3OZR?=
 =?us-ascii?Q?QolTfW2dvjxwaUhuaKqOtFODZQWVYjSfGu60wS77aRjF7A9CZcI4UR5cB+DW?=
 =?us-ascii?Q?tj9ExCHWbtZ3z9bFRVCythVUjeKGJGm2AFMqdPjt2jlBKMe/CGASviU0I9nQ?=
 =?us-ascii?Q?j/thPW2coxHXewMe7fqpsdq3YCue7P+aDnPsJbaIcHRyI30kRIHP0AKy76fI?=
 =?us-ascii?Q?q2jGkDQJLY33APcsDOTbQAbMLPdI3j0/QFjOYQKsGMQpkF074TDD6F20/bRB?=
 =?us-ascii?Q?vGsUvh2jadLFe/A8l+CNLMKTK5Q1tq+84+topOS8+LEldhfj/QSEs3595Jtn?=
 =?us-ascii?Q?9EWMDBHHQ4TQCH/UQQtNauN8iZNRcCRX+s6I4cKY0Oj+s6dYCSlVTAaGRm41?=
 =?us-ascii?Q?H6Jhkf+H5aU//lYQCxBSjJNOtZkO9ak+VHPE3xFkpJPrOac07yUzsu1rDbAu?=
 =?us-ascii?Q?PZL1rrzka+qP9u1yUrhx1gh103IsSEYOz19NufyWcELw/UYlwY+kVHXfq9/1?=
 =?us-ascii?Q?LelNjNjgHaDiLftwQiwP9tk45DR2n0lRUWLBQuXIqUoWfm/v+4QHPzlAEsLa?=
 =?us-ascii?Q?33a4oyhAAX4QMKB48oWYAMvDvkmfuD97OcwraJHGvOejB0G7sHrJ8mZ3qnT5?=
 =?us-ascii?Q?p1oxV51/fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29599463-8c0a-4780-8741-08decbbd8f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 15:40:14.9744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2n46iz617m5bkZGmTWlT+1yhHpLY9DQSs7BD229cWjU07Dw0DxAbc7J5Nf95Xyfne6YHywGje3NCVbGmyms8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 16 June 2026 19:41
> To: Maxime Leroy <maxime@leroys.fr>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin
> Saxena <sachin.saxena@nxp.com>
> Subject: Re: [PATCH v2 6/6] net/dpaa2: drop the fake software VLAN strip
> offload
> Importance: High
>=20
> On Tue, 16 Jun 2026 12:27:26 +0200
> Maxime Leroy <maxime@leroys.fr> wrote:
>=20
> > RTE_ETH_RX_OFFLOAD_VLAN_STRIP is advertised, but no hardware VLAN
> > strip backs it: when enabled, the Rx burst calls rte_vlan_strip() on
> > every frame, a software op masquerading as a hardware offload.
> >
> > It saves a forwarding application nothing: the datapath reads the L2
> > header anyway to classify or strip. The offload does not remove that
> > read, it relocates it into the driver Rx burst, where it is far more
> > expensive.
> >
> > The cost is a matter of timing. rte_vlan_strip() reaches the L2 header
> > through rte_pktmbuf_mtod(), which dereferences mbuf->buf_addr. On a
> > freshly recycled buffer that mbuf cacheline is cold. eth_fd_to_mbuf()
> > has just written other fields of it (data_off, ol_flags), but buf_addr
> > is a persistent field it does not rewrite. A write does not stall: it
> > posts to the store buffer while the line fills in the background, and
> > the rewritten fields are forwarded straight from there. buf_addr has
> > nothing to forward, so it must be read from the line, whose fill is
> > still in flight, and the read stalls. The ethertype read that follows,
> > on the cold payload line, stalls again. Read later by the application,
> > when the fill has completed, the same read hits. The offload just
> > performs it at the worst possible moment.
> >
> > Measured on a single-core port-to-port forwarding test over two 10G
> > ports (one core at 2 GHz, 64-byte untagged frames):
> >
> >   - throughput 4.22 -> 5.00 Mpps (+18 percent)
> >   - IPC 0.93 -> 1.25: the cost was memory stall, not compute
> >   - L3/DRAM-bound L2 refills 319M -> 200M over 10s (-37 percent)
> >
> > perf confirms it: with the offload, the buf_addr load (the cold mbuf
> > field) and the payload load account for about 84 percent of the Rx
> > burst's L2 refills; removing it, those vanish and only the inherent
> > DQRR dequeue misses remain.
> >
> > Stop advertising VLAN_STRIP and remove the rte_vlan_strip() calls from
> > every Rx path. This is a behavioural change: the tag is left in the
> > frame, so an application must strip it itself, on the L2 header it
> > already reads.
> >
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
>=20
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
