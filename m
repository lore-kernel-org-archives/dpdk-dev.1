Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B75CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7DCC40262;
	Fri, 29 May 2026 17:52:32 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023141.outbound.protection.outlook.com [52.101.127.141])
 by mails.dpdk.org (Postfix) with ESMTP id 6300F400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:52:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmU1/tt3AONPxxoCehlSjGwOAk/gGsXc80JQ0nMwFTwzXGds1RncGispsN/su5jX0RMJFLyspU4hma9kOl66vk2jy41+3zDQN6dBfo59OYRKuQ5sb+uQhS/Lhj7M93FxFHDnbu1EV/gTmfTsc84eD9noZi/Zz2KzcYESA5KE7xwn91G65SQZjl78N/j1W4779YNWKCnrZzXFdwvczIPpT+GOh1ce/4ju6ituEPbdCFavPqz+izBnTTDnLb7FRem4Nc4BpMKoEvEZeImtCceTZGyAQGFyLlaVz0TDXZu+4QLJDsPnEuz+iFN+KWVxVP9v3VikdZeBMkTgW7a4YlN1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=YyVFR+tD4phwitefMy+KOtUUvBdQJ31+TCsf9aGRTeA=;
 b=HRiXPYmEbMrrIgZJeutdxVwk3YNsB5v9vslgozkghMxqgUbmVLnygcVo7XpCxlXSpTEKDTuIQox2tISkm0ShuOBGfhkEZq3hFbu24hW49fSKqI4mKmNmcKJqwZIrjO+GxybhzSSkRYzEW8cZj7M+1t2RiHwkaC/+e9hjuko3+CfBEPouXFh+0qR3PLd+WH6U167WhTkO/fUJk0HEO1gjtxEhzfQ5RJ+hXMFozJ/epjtX8HNfq4mQzBNEDIrlGUuWqg32NAcj6BwfayqGatH1V00boIcoOpjdx+Y9l7HMNp5TYNLzz+RdLOlFw/BAVRcbMzphUUOaR87LDESKuZHkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyVFR+tD4phwitefMy+KOtUUvBdQJ31+TCsf9aGRTeA=;
 b=BFS5iQ2sr7uSu1elBIPD7C2P2vZT6cELmedZtBZTJhVr8t2SWXlhtXck47OCZdoe3kkHGjXszk3dozZrO5g+9YEsNuPR2at/gug/1DHNyFL1QS/g1RFPEOuCQ0I/7UkD7so9vAi7lKYf8q5kfLnHt0BXJCFcmxtG3z3mr0LpndM=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KUXP153MB2401.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.5; Fri, 29 May 2026
 15:52:25 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%4]) with mapi id 15.21.0092.004; Fri, 29 May 2026
 15:52:25 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] net/mana: add device reset support
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] net/mana: add device reset support
Thread-Index: AQHc73c9EVCxCKMK4UeQ1hF02FMZxrYlImwAgAAC46A=
Date: Fri, 29 May 2026 15:52:24 +0000
Message-ID: <SE3P153MB184896360C334993815DA0C2BB162@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260529142648.148407-1-weh@linux.microsoft.com>
 <20260529142648.148407-2-weh@linux.microsoft.com>
 <20260529083446.4082ab23@phoenix.local>
In-Reply-To: <20260529083446.4082ab23@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a4834d26-7260-4ac6-97e0-68ce925ae3a4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-29T15:45:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KUXP153MB2401:EE_
x-ms-office365-filtering-correlation-id: c4a31919-042f-4cab-10f9-08debd9a46fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: rVXE6TfItIXrRZ5OEvSFWrvwoFBbu56AKusqYuUS5bc4Dbw7/PrYnw6YcRlyeuAq4SK7ErIoHR+FgJ2eWOjLZE21c65PWUrrrNDuwYvbDF/Nc+TPN/zoc0vWtsXbllqSjN8gsQKaO1vRxfqM7qdmIBdkUuRlH2d6hd2fOG9RJHHLg3HHtshkdhdgxadDEU3RSVvY0tRUE7WyFbwdIKR5//p+ZIhMGAI9cKdK8xby1yyVClcfVBczWcx91KAYe5n12M/TRMDreE5Vpzs6eaYbwDw6VrELrI1jt1Z9LpXR5l71gJZu24lN4iyy3OlHvRWfJX8W/SxiJS9b9xDrwx9FJgeVXdB9L48THTjxxIfMDS8RrsFhszB3IJYeDbl5G3OFKdFSQi1D+9AdfII7ewWmcaDMN4Jc1SwVZXGzttoBSdHZX+4/vmc5qEftBJeVSeMz/2cZyVtwcq9oueN74aw+JWeUAu1HZGXNCCQNjehyoB+lb5vrca4rrdrmkZlTd5UXMun6bscLsqURMwbAu1FdXFe14fqI6ysCEY/kFNnv8+P7jTCNZ+z+KHctM1zNyHSje7P2M1WEEVlN5rVKY0GXfKn7R3pGU6m4iONodVnbJZcMlI/qJJzcBPRpVeZPR5cfXO8Ctg0Rx+zorK6Yj5OI3nbY4WZm4BQAOySLKKOeuA2lCMQ+FXmF6h4vkgv6pxYWplhrLiLcp0QjXdAMGkeWmofb4S621o2tHGeGRD2JvSiLBHA3CbeSURnq6glLdKjj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+LNfiEG6JatNoagIRPr6nVGaBlSL6CPXOgOOnN4nMpKMKTKjppeO54l/mblG?=
 =?us-ascii?Q?nvtFWjdyfsY24DyeF6NIgkX1sdpBrQvXQHLh+1ooir8lRj9HtSzC96bEUgHC?=
 =?us-ascii?Q?SaCLkBTJcIaGhAXzZY64BR72Ll+RB8WtO/iyfYmcw8Eb7i4C3m+9SjRM+6SQ?=
 =?us-ascii?Q?4+Qs0G7jXybjg0AhAdToH1kktaSRNgtZ4lNxSe1xF+FOIdpu033lObY096kM?=
 =?us-ascii?Q?4MzMbvhb7/ZrIMu5XlZGs93e1K2FCJfaVoUHq57iBKsgQGHZuHECVE8+p2s9?=
 =?us-ascii?Q?XJ528JXTVlpfclWzWFyJ5CJNz1G+Gsj81PONapsFhfNz72KmktBA9fvedGfg?=
 =?us-ascii?Q?preYBBaN92n56iqULe30gChBvEV9VAvBYckRCFvECCFXejxIuyDXSPSDslRQ?=
 =?us-ascii?Q?Z0R4geUnxCKvds2+6pSlQy1GtwBk8t+4d7g3XE/7/ZQdvPcfs3geXIQW/NoA?=
 =?us-ascii?Q?Npl7CCIwyqwZb7knc+TpOo6/unKb3+NYDupI7NAN3AX9FbpLYYCghAyX6YB9?=
 =?us-ascii?Q?Ld+IChu7snKi2PEo8MWHp+AdEJOXJc3uiOCwg9n+SUg6gmiGP2fpRz/j5MJU?=
 =?us-ascii?Q?tP+3yiPn86QV/EXi481lgI26byC+thcKcRBIplDxE6NM08RX8HLyHiMzBW8k?=
 =?us-ascii?Q?7CMzoCnsR8lOws5GZi0qTYBuMytJLLG8qItXLo4OCgZt1C4qoFvaj0y53tG3?=
 =?us-ascii?Q?MfGSCvlA0chxa8ftu4WqV4JrjdnOOYc6r4uOr1EqU1bZ6zQPQI8eZJq5yoWl?=
 =?us-ascii?Q?H2HzK8MZg8XXkLZN5PHfDTG1HEzOY4Yv6YxvD278eHJAFfzy7Dg0WKxNnS56?=
 =?us-ascii?Q?oGJCdWnAIE0u0xy64XEjJhxYmQnKHNKwxgn4UbQFQaE/MHYJlhV+usUr0dT+?=
 =?us-ascii?Q?kEwIkU3/DgvRmOlLTZny6MruMbZmiEswUk3WP+6ROKFaHaIbNFTb8fmXpFAB?=
 =?us-ascii?Q?DQcPdoob5cCQPRd5rLCswI7aDUZYQvxITKiZVnsGSS667cGBcaVeaoLbQwvE?=
 =?us-ascii?Q?YqM6uvcWgJ2MjmAHUFcKIkAbIyItJQ2NKGm/jWaIKLkfn15Eg1vZnS8hsp4w?=
 =?us-ascii?Q?163xrnVXXwrRnGOBkpcxXHoBLXBsm2Y4ww9iGo4Cc/tIaIhDAJ9N7jR4nbPn?=
 =?us-ascii?Q?pUfppyV4ervXSkkP+vAyXkfB8cQHLIJ3ox0xKQKLikpBjnDN+ZJbNGxRxTbd?=
 =?us-ascii?Q?1xpXQXKDZmcjfvgCcqXMptI4ZecaFdCFmWsysk5OB3ZPVj68Pw0eyTl5HKen?=
 =?us-ascii?Q?xCF4VwFkz0DpFgt8jK8vWTMc9/nrsaSBg5xFmw1TsAzDzpCWFNMGSYGjHJlK?=
 =?us-ascii?Q?yo14o8jcwMn3fLPRx/XzLHhF+uovoYuszqC+D/SMvGt4KaDsb7pMv2MicMph?=
 =?us-ascii?Q?tnlHfynfvlIxAwgelG6WLY9aeoREgcmYfdGLgh9dAbuwMnwDN9yvzGZMwq8l?=
 =?us-ascii?Q?XDIenTSJnOA8KwjOG+YAnxZZM2J2lVL0chP3SvGFVRQfbn/mdq9ZBeWYsRSU?=
 =?us-ascii?Q?y5XGM5IkeLuWzevfqJ+491soci/JGBvUBNTJK22KF+Lb30yKkfkAvn8AGAU/?=
 =?us-ascii?Q?Nn/y2We8xbe0skQCYLrWfoMG3NGTQOL4NnHSItJqkwliqDDdJXIuoOInlovT?=
 =?us-ascii?Q?77WybKiA5MJt2HDowap4mLAh8LHy1wQGNyl4nxvd8QSf8yx5CxcNLoF4qVTo?=
 =?us-ascii?Q?ReQgzHSok51S5S3Kl73q7otPCYMcBcdhDkYO3n35kppmhBNA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a31919-042f-4cab-10f9-08debd9a46fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 15:52:24.6095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnSf6HAuJPOmnEwSh2eDAeGGyJ8qicfeFthtDByU1t2v185yf3uZmPT/Nk5woCxsJ3WDGtVN3iPlvR20iWssEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB2401
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
> Sent: Friday, May 29, 2026 11:35 PM
> To: Wei Hu <weh@linux.microsoft.com>
> Cc: dev@dpdk.org; Long Li <longli@microsoft.com>; Wei Hu
> <weh@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH v5 1/1] net/mana: add device reset support
>=20
> On Fri, 29 May 2026 07:26:48 -0700
> Wei Hu <weh@linux.microsoft.com> wrote:
>=20
> > diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c index
> > 67396cda1f..89e45c53c1 100644
> > --- a/drivers/net/mana/mana.c
> > +++ b/drivers/net/mana/mana.c
> > @@ -13,7 +13,10 @@
> >  #include <ethdev_pci.h>
> >  #include <rte_kvargs.h>
> >  #include <rte_eal_paging.h>
> > +#include <rte_alarm.h>
> >  #include <rte_pci.h>
> > +#include <rte_rcu_qsbr.h>
> > +#include <rte_lock_annotations.h>
> >
> >  #include <infiniband/verbs.h>
> >  #include <infiniband/manadv.h>
> > @@ -103,6 +106,23 @@ mana_dev_configure(struct rte_eth_dev *dev)
> >  			      RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
> >
> >  	priv->num_queues =3D dev->data->nb_rx_queues;
> > +	DRV_LOG(DEBUG, "priv %p, port %u, dev port %u, num_queues: %u",
> > +		priv, priv->port_id, priv->dev_port, priv->num_queues);
> > +
> > +	/*
> > +	 * Register data path thread IDs (rx and tx) with the RCU
> > +	 * quiescent state variable for device state synchronization.
> > +	 */
> > +	for (int i =3D 0; i < 2 * priv->num_queues; i++) {
> > +		if (rte_rcu_qsbr_thread_register(priv->dev_state_qsv, i) !=3D 0) {
> > +			DRV_LOG(ERR, "Failed to register rcu qsv thread %d of
> total %d",
> > +				i, 2 * priv->num_queues - 1);
> > +			return -EINVAL;
> > +		}
> > +		DRV_LOG(DEBUG,
> > +			"Register thread 0x%x for priv %p, port %u",
> > +			i, priv, priv->port_id);
> > +	}
> >
>=20
> If device driver now has dependency on RCU you need to update meson.build
> to show that. No other driver does this. Creating threads in driver is
> discouraged because it can lead to other problems in applications.
>=20
> If possible, I would figure out how to manage reset without creating a th=
read
> per-queue. Or at least one control thread and use epoll() and eventfd's.

Update in meson.build was included in the patch.=20

I didn't create a thread per-queue. I just added a tid for each queue and u=
se it
as an identifier in rte_rcu_qsbr_thread_register(). Calling=20
rte_rcu_qsbr_thread_register() doesn't create any additional thread. It jus=
t let
the rcu_qsbr know how many tx and rx threads it should expect to be offline=
 before
device resetting can proceed.=20

Wei


