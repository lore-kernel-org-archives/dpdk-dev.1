Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C684CD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 23:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FFFB402B8;
	Tue,  9 Jun 2026 01:32:25 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11021125.outbound.protection.outlook.com [52.101.62.125])
 by mails.dpdk.org (Postfix) with ESMTP id 67862402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 01:32:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8YTBoEXgwuYISGaspTY2DN+FyTl8hfJa+1Kj7uYQ6Mfo1ePBjLJFrhLIVRwL1+iA5rH0SnNalL6qiFo1hU3R/0fzQUVnfsI4FRqmK+NvdW1l0jYtMZG/nZHFJtU8cXAyIhjjPcunhOkVLJL/wA4+800LXcokbEBg+KLTpJ6AXNglQo1lWeJOyC6mcAnJSu7EPkQVqWq8CJDQ+BI9dJt3pj0XX/hiqlTebKwQFl/t3lNvQCAM1AIKjmv43LYg0qm9w3fgFa6ZXcXEpH9x5ZOcHfmBCL7dPADdhDM0Kg8Q3TIE3HXNgRqmOU8Ifyq0uL3KGKNGCvbFlyXt3gYghqtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSHqb9l3AXUKuIU0gCaWtbZjx81DjVpSOwNa27I0Xfk=;
 b=fjxGtUzsmuKuMq6R8Z0xJUliJCvOCvfq7cxDJiiUkVB3skoLoA50OujVulnNtaL6Im3+ekKSOjoFF8fVl0jfN9a4DJ5r66rZGRpWjguKb7ZTtsYHtu22JMN+E84uXTejR4IUGe/YeQk15aVxn8CmfkETPRbIz80xnXv6Y0L3FJlrXqqqTdqpk5MVi1N+/yo8AeMDrzwL8n045Iz9bsVrQSam76f3TIqYWwCKpQCL4+NKmlFyhAlnujwpxps7cPVLRplPf0iFPYCJ4+P8CQtOfE76QSxASn4lJNo+wFOrX6jeotiYdeTXBRGDCrXaQ8zCo+8qn250Frh0mxBeqBptdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSHqb9l3AXUKuIU0gCaWtbZjx81DjVpSOwNa27I0Xfk=;
 b=QvX2jXledLCUP1bkViYxb7XcqQTy7C/U/iZB6O6RFE6GUcewki7xEsht+jv6VVgq85Y5vu2l7+rn59ti5u6EoDW+F0OsirCR8yLvqQPxPMU2PBnNKZ69UL1b59WaB+N2Wdr7uZNBYt92cpev5Uk2as2VEnbIBs5TrI/r+C+d0x4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA5PR21MB6947.namprd21.prod.outlook.com (2603:10b6:806:4d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.8; Mon, 8 Jun 2026
 23:32:21 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0113.006; Mon, 8 Jun 2026
 23:32:21 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] net/mana: add device reset support
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] net/mana: add device reset support
Thread-Index: AQHc9z+NpKI3AT7hN0qN3YqQone1drY1Br4AgABFn5A=
Date: Mon, 8 Jun 2026 23:32:21 +0000
Message-ID: <SA1PR21MB6683319C458FA6BC3C3E40F5CE1C2@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260608120824.287050-1-weh@linux.microsoft.com>
 <20260608120824.287050-2-weh@linux.microsoft.com>
 <20260608121134.601e4f46@phoenix.local>
In-Reply-To: <20260608121134.601e4f46@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4a6a28a5-bf1c-4f58-aff9-ad49f0f55728;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-08T23:20:44Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA5PR21MB6947:EE_
x-ms-office365-filtering-correlation-id: 852ecca4-012a-4c06-252c-08dec5b63024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: Kkse1ABXZtb6E9EZqELEq9dxh/kwJne5tBwF0BHN2dSg3katdi/zs3cKK4ZOJPeeqTS7y3JE4rx2QgpAb3+q9TZl+FbyVRJZII53kKbERuZv2LLYG5B2FXRJA7u/gNfs7CV9ZjpczZA04MDKB1JeMJW/mxhvxOsPRCCeQZ9MlPcOqJS0x3giX+T8ItPpkbWQASthMOLzZRCrsHlIWGpIAIqrs4nIk9RSR1eK2Wz9h3DjJV41FC5HQSkSsSg+Am5YCzYsE0PDzdkEHxop15XwY3jWAhK0e87RHzCmTdf7/uuuwhe/SKRS48dlyBrZ+pxR2ziehVjgFX8tZy+5+1yehGZzlSvUgJMp/zBcHc/K2nju2Sfbq0rkY87z+PugkBb5I/lW0ftnBbegl+YdLjg/0NW5g0B7P4WbIf6h8V4Xv8mMOkkszngFTLPMqodHp0uPBRjbn4hRkAq6mRXm68z286codRbJ4qU3kvP/LusF4ohesvYkgT89UeSH5rjKYMY429I8zyF1qfIoigH1weAPJMTSTiZq6hd5rJ4AnqlKlpXteBKGOqNX7IFNhM9CyO0xrebJPlPl1PblaUOsyiIE8tgWzws9F+P5/cmWnhvM4nH/r6ho14PnewqElsHZ81JPyO/5uELp2PRN/ODA+BT7AOciIBtMdLHZY4iKqbp0MjZ9m9bLucQQFIrk5eUbnn3IB6tp98YoUw81CKxfQBZOetr55Li82oorHfE/Ej089UpaQ2P9vjsosJkpyEBrDie4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2NifXhIcf6wasd8V2wzXkt2L/LEZqSF0DG7PyOLnDPGXG9dJqWkb4VtQ2BHy?=
 =?us-ascii?Q?qrWvWWTicUswxBKLBKNVw/14lb9k8yip7izwUXUqdXxaJJ/uivcjpSBBcr6J?=
 =?us-ascii?Q?eiBrKMhsAT+khCGbsPqTSL/TtmRF3YkXcHT+QEW57OpoxMH1dU/u+KN30Q4E?=
 =?us-ascii?Q?YfSzfY06VE4Om5Aes25npQSzTqYY6p7Vm0VB6fUzO5WgPiJL41YKvImAif8j?=
 =?us-ascii?Q?d8LdKYC5pcuSIz+cE079D2AwSBH8SNNAhiIY2KZTXCW1qHL9AdkHKH7RTJdG?=
 =?us-ascii?Q?XloWmKD7dqhXVyMwtW9gLKRu/UA1w/rA/FuE+1jC3AH4wXuz2+q2uBDyjOLE?=
 =?us-ascii?Q?pJVC3Nvq2MMiUU/17QbBtU7dGr5Ea2JcrAujVViRlm7eroYOYj+HbIyb5tT+?=
 =?us-ascii?Q?C0onsUajD5hvn0R8Uqn2kxVr8IpdjtqCePZ6NwEmaFW1Ux7D5Oc783vzVZuo?=
 =?us-ascii?Q?4SariKzCs+w0b6eQ72onEXnWc4SM6ieljuZJMovuJni2aOypuYKup1gwl6LG?=
 =?us-ascii?Q?22Trh5b1pc4I9r/ktks3zaRhL/o+cKwg1B6ctJwmSBTujA1ix3IAo7rEsZEd?=
 =?us-ascii?Q?72ZpGwuFQnBx3rLKB6EZUr+qqM6GY/ed9LFgGiMQpVfUkaCuCOu70TWcSIvu?=
 =?us-ascii?Q?5SBYVOMNBYOsQmftaTeu3L7dkcYdYgD8CEiZY1/44+pvMi17chUPuFsN08aT?=
 =?us-ascii?Q?wkyJwtmdtzAhfY+pAPQdQJ/L+zxInynQCxQ1EULvUPkF9htKcypw3dZB/ICB?=
 =?us-ascii?Q?zr9XkQ9DhThw97z2VTejUijwcY7Ab5fVxTG7UpTLh5et+CO1gWdrRw6QGUqD?=
 =?us-ascii?Q?prDDzCOQWHArZL+oIeE7X0eKHSVyvYClxEb1cG8PQsN1tS8Znx1lUiqDjbcU?=
 =?us-ascii?Q?hPaFOTXe8uNH0P+NjtUBDzmLSx2MJsdqcmqxd5OXYnKOas9VKqnW1/nHZszy?=
 =?us-ascii?Q?x5kbgXZWogoOHZt/cQn07sOdNbDCpodnQ9L0VhYRa5jEW2fxd3EH5n+Kc4Kd?=
 =?us-ascii?Q?/DKTGAb5hi1AURev0ZDNw2NV5Z/pEItHU9UjOI8ld8NceVcH8FbjE2qj6Y1c?=
 =?us-ascii?Q?WruurswMqkTWxmCTA1sCpG1C7oWZmO8SJKIKNE2m7I95tnwkK8RRvVdHbXfJ?=
 =?us-ascii?Q?d1UyC57Cc6LTtzkKW7b1xe/5POuPCSdLlRRG+wD9tbDAcFt+KYc9YzSg3WeT?=
 =?us-ascii?Q?31WeWsHmXe9ImXiwoEZaaxqUEJwsw0kEaRRa5mVP2NoE3qaJTJFP8qNiFWJi?=
 =?us-ascii?Q?o8bCaqSFmvEb06J7+yXQ6aRNVJX0dPq4SJjvLlwjfyFplx5smWjEu3sdiAjQ?=
 =?us-ascii?Q?n1kpYqz6jY7bXpwwKL7I/9JmQ1vUGT2YSfpbtvObxBYCGVhLZrF2Ntauf9Hg?=
 =?us-ascii?Q?eTbfg2JhZRtZLVSA03RVnXPluQifjFlF0RrB/EyMKCXL237BdlJUufECNCbp?=
 =?us-ascii?Q?IZYBC3WBtN2Cc2MmY6Y5m8aJ2C9Ew1lMcf6FDq74J9GSu1KNAvSqS7DLq2vw?=
 =?us-ascii?Q?rROis9md3X05v+k3jvfU4Vsb7FDVfxzbr80Qj97FHxWCxFdQSzAmHjTuXFCP?=
 =?us-ascii?Q?hN0WFvwl/Syp4WfR+qeseC0aCQ7bwlXPVKPFAZFRBbbadqfcVYR/z+mwFiKV?=
 =?us-ascii?Q?k/1GsDlywJOLU7ff0R0ogYmQKM2C34RGRDAISU5e1OqWmmnlINR0xyxbm9BC?=
 =?us-ascii?Q?CGXaP8yx3jhf82X51xf+hT3QZ7c8LAnU4Z1WYEzHGEZfN+Jo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ecca4-012a-4c06-252c-08dec5b63024
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 23:32:21.5320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2ur2dLfnjG0ge4RYnhJ/rGx2TfcwPIqBzrIPqK4gS1C0t94Nd5yovCU/4etaT/1L9Z0CMpckRFYv7cYFn1G3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR21MB6947
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

> > ---
>=20
> This is is a rather complex set of state transitions so admit to relying =
on AI as
> backup for tracking this. It still sees some errors here.
>=20
> Worth asking the question, "what does mlx5 do?" and "should DPDK EAL be
> doing this at the PCI layer instead?"

MLX5 doesn't have this device service model and will not attempt device rec=
overy, it just quits and tells the app the device is removed via sending ou=
t RTE_ETH_EVENT_INTR_RMV.

This service event has very limited visibility over the PCI, as the device =
is servicing itself while keeping all the PCI endpoints alive. PCI device p=
ersists during the reset. Only the DMA queues need to be recreated.

I think processing the service events entirely in the mana driver is the ri=
ght thing to do.

>=20
> ---
>=20
> Much better - this addresses the RCU, the macros, the thread-safety-analy=
sis
> suppressions, and the callback-under-lock deadlock. The single-variable
> burst_state CAS is a clean way to do the drain and the acquire/release
> reasoning checks out.
>=20
> One structural thing remains. The enter phase still runs the heavy teardo=
wn on
> the EAL interrupt thread under reset_ops_lock: dev_stop, then
> mana_mp_req_on_rxtx(RESET_ENTER) which is a blocking
> rte_mp_request_sync with a multi-second timeout, then dev_close with its =
ibv
> calls. You already moved the exit phase to a control thread because
> intr_callback_unregister cannot run on the interrupt thread; the same
> argument applies to blocking IPC and verbs teardown. A slow or absent
> secondary will stall the interrupt thread for the MP timeout, and this is=
 the
> blocking-under-a-sleeping-mutex pattern. Please have the interrupt handle=
r
> just set state and drain, then hand the rest of the teardown to the contr=
ol
> thread. That also removes the last lock hand-off between functions/thread=
s,
> so each function can own its lock.

Yes, we should move all the blocking calls from the system interrupt thread=
 to the MANA control thread.

>=20
> Smaller points:
> - RECOVERY_SUCCESS/FAILED are emitted from the reset thread. If the
> callback
>   calls dev_stop/dev_close, mana_join_reset_thread() joins the current th=
read
>   (EDEADLK, leaked handle). INTR_RMV is fine since it runs on the dev-eve=
nt
>   thread.
> - The burst_state comment says bits 1+ encode device state, but only
>   RESET_ENTER<<1 is ever stored - it is effectively a single "blocked" fl=
ag.
