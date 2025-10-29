Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD6CCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 04:11:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF66E4028D;
	Wed, 29 Oct 2025 05:11:21 +0100 (CET)
Received: from MA0PR01CU009.outbound.protection.outlook.com
 (mail-southindiaazon11020109.outbound.protection.outlook.com
 [52.101.227.109])
 by mails.dpdk.org (Postfix) with ESMTP id AD36240262
 for <dev@dpdk.org>; Wed, 29 Oct 2025 05:11:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNnBYeJ6/c+4lwj8cpWfmSuYVG3hLd/E9bjJyq4+SlY2logF5TxiVZ5FGjF4NfA6dtd2cZD9L4o2jMOY5yIur65noXQkB1VQII4qsG+ssFWYaLxz4T7KzdgmEoZL9nS/6FECl0UHWIdinwGp2rQ1nKU6CTOUzULvd8MEJrAptDghXqVnfZaD49i0aoUIzGFIr3nxAQAxC026V+55iioeKvWyTuk3VteJvqEIqxQJsb7+D2Fr9D/dDtwHD6fBBvvaXbCj2f99d6F3onU+dByWbkf4puKvruOE981Mz4UqjvTElU/v6BY9wcxlLPbvAc/62KZEEQxJlpI0C2GXCTwjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfTAHX3sLMQlmhuodTwm81ZdS/rOTqJKsWJy8NDzHOY=;
 b=mEwCZlB9khW/1dgAL1utdCv0BI2rE11oTZAE1I3ZAlj6+zXjykmtCB7+690TbmRKsdvVi3u/sgMJ0/HTr0wPDmXepyboeiNi5L3Gn6bOKshPsfAmX5Vgk/ggDICvgi/aYVSUK2ODnJrZESujkULvreVR7QpebVgr31ex1sNuaYjGJl4O80V77zwJpvmfAwanEBfcjbHhiNkjWl26B2bSn3DtWlCGc3Xaql43l2tf4OvdpeWrI5fylOaIw30liOizpPTg6LvGxeKA4syaq7Ucuh8M8oOZu0aSbCksz2vMBN7jk/GbBqQapYxn6KiAXWnRRZnqDo6VsSSfqDXPVi9SHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfTAHX3sLMQlmhuodTwm81ZdS/rOTqJKsWJy8NDzHOY=;
 b=eKv7/qwT+QykCPp+4SE3iSgVySJMgz1QW5i3VsVjTyR62IVUca3z/nIC97lqPaarnIOCRRi6dEhpWvKN3DjDTFVULiBQ/1tFnaoiRUALqoq2Juymv6r+fFicOm8yQ2fie7UjnAjrJY5KV1ZRihYA9RSCwfSmIWlKHqF5iB2ce0lMgHZiEvEygEqJ2i6uQjtkreCFkKtokoxBt7IsodT6hAXveRNlKbbdnFdtAvEFTc4QnkvzOv3mviR0rV4zdbS1tK0I+6SkREfpM+9P20FUNNKjRMMTrjHvMegVRcBUtxojvFOhwsl8V7zFHr5JR99nYRVK6QYfmKRDsg75s1b4Qg==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN3PPF2A9E3F87D.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::99) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 04:11:17 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 04:11:17 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: dev <dev@dpdk.org>
CC: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>
Subject: Re: Virtio-PMD in Windows
Thread-Topic: Virtio-PMD in Windows
Thread-Index: AQHcQllTOt/KxgpIwU6HUkaaP8NWhbTMN1BhgAkzIm+AAyS8aQ==
Date: Wed, 29 Oct 2025 04:11:17 +0000
Message-ID: <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN3PPF2A9E3F87D:EE_
x-ms-office365-filtering-correlation-id: 47c51c1c-44a9-4dc7-b045-08de16a1352d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bKJBCpWUEWMEp6z3tnvlHsYsPkQgmSGgDtyhZ4+LODhv8sI9YIV7GU/RfvgC?=
 =?us-ascii?Q?c0kV7kgUP+dD0wznkp6wTqV5QzvsQHvLUJfbTYri3VMDMVq6X9+hVNfh6ToD?=
 =?us-ascii?Q?EzwqZKC1c29bY8vB7fDmmg+TQxps7DEruVN8RFg3x2Eu7rD+V+pMwYfP0rcf?=
 =?us-ascii?Q?CWG0zt0/HqNrkg8KKvGxsffPqIDFslnMBQJUiSybvUkg1O7AfzZxb0HfuYT/?=
 =?us-ascii?Q?YXJRA9gQrbOEDnE4tJdeMB3jjGVe+a6ElN673fIbHt49bqgmc4FeK9ULC56V?=
 =?us-ascii?Q?IrNHsVA1NIhdYpoNLW0iC+eQt7M8S7I9eJaYjFpwhrWaEc90NsHMY06dEQmK?=
 =?us-ascii?Q?C209Nz87H1E8iUxtwJl+Iab7wwNyCwBAyQuF0kjBQJpoM7ft43ZNsxERavd0?=
 =?us-ascii?Q?MQnB1sxORiYQeLueOOsY5RiJUAO9hGzSJ1CDV8FrOZ7c5fqvgGyFYRSibOLa?=
 =?us-ascii?Q?IJ95yzzBVnKApgfwVZAV7h20DQuHNjYJleRxG+Spu/HXTy5+N8DseYKXgS+D?=
 =?us-ascii?Q?O3Xn+D6Y2mMpkpcM7DMiWkQw6ERkL4vBQcnPD8ecsL7wuW0hCTrwHge2Px+w?=
 =?us-ascii?Q?NG+LAJ0STl3Q4HMfEEqJRkYi5xS8SDfGmBQ7z77Ytc0BxjVW44PDaxKI4Gto?=
 =?us-ascii?Q?UopCFaamtgAzGyf7Sqfu/mMgxpgqbkPQmfj4n//DbWdWjfFUwrD9Ph3XPCJM?=
 =?us-ascii?Q?6pzFx+QYs0hrUmlF+B4E78s6tG/qEmoljqEtflOv4nXcX5gyGHGGHkXJUEUK?=
 =?us-ascii?Q?YOzMNVA1Vf50HINdPANOww7LuZLqJIaNkn0Ap5LzTXYPi6pm3gclcWx/wnfS?=
 =?us-ascii?Q?hRKsEEOwYq+GuC7H2Z78hKw5ZJ7LVJi3T4pLtI8L2qxvVCd9B64D7DTqCgq7?=
 =?us-ascii?Q?+AJWdKPBuTTr3DVnhgkc4m99FzcqzLX3ARt9R8rsQwFo5DGZfUSseXJGYXoU?=
 =?us-ascii?Q?3Y/jj8V/Lbh8Wm3c2S9Bkss7L13gzo3t0ptUJLfpY621JKU2Y5T2i80Ocqj8?=
 =?us-ascii?Q?3VxpfPwO7B3UXe3ufX2FEv21eBiaW59p4grgfpbzCVtZhtt4nowosoMl5KyJ?=
 =?us-ascii?Q?4R2fBB08cbGOOLToXBq0RJmZ6Xuc2WDgf96W7M5xznM6PgSwtcfmQSvKyq/K?=
 =?us-ascii?Q?7wK3vivgwujjy8fwwAUfgfEZC8lLaGXLV/1DkgfqfKB33M/oKbRbeGJbf0pb?=
 =?us-ascii?Q?eNphnq0PgqdlSNviB/diKGJwvPAf+SvDqO+Tub9jib00fDrJcvfdzJSPRWez?=
 =?us-ascii?Q?6tUL9unm7pd4pqh+cMfPhgmfLefyJdLeiF8Yv7k6Oxt+Qt4JnzqDLXE+u4YJ?=
 =?us-ascii?Q?WsjJ282LhzWQEAuGopWQGxvv3noRWhX23gfkM5vuvlc7iDM9T+j2DzQCDtBf?=
 =?us-ascii?Q?DJha72rsmI+x/ucbQOSpVm+bX60Fo73jk5sxpYOXti0nyYJZsBj5HI104iOS?=
 =?us-ascii?Q?x7kv873Qq+RfVIM7OYMDkyzfqIXnSXzGu650o/XBgNWeoDMacW3vKQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ldIp9dLix4aBEVX4Vh7b0SS/6qn4BszpNOGQu68GHXxm/GV07vi49ON2Ij1/?=
 =?us-ascii?Q?AvK2eAyTUx5h3yQoRJOKaFD0nuPDbYpt2QvnhrhuEMd54vUJgvvYTKJM6VXO?=
 =?us-ascii?Q?RRqGXiZcUdNo2W6BLJ/px7dZ5roJlZB5BD70f1afeZtfQqihSX5xXocWSpCM?=
 =?us-ascii?Q?ngW5rbT58n0HxTCtYTPOtn6vzyX19QPwynkCf0daD0w7cdMIWN78cj0fo2yK?=
 =?us-ascii?Q?PufRxcSIa7Lv6wrEwF9G2kuS+6QHvSeZIdBs9MRJ6TNBuvn2PiUVHMIY3Lqm?=
 =?us-ascii?Q?KgdCcuKW9HnEfVN1wZhTdh0XsO2HiItd0AKoOE6N0qDCtECTEwUzZ2g4z7Tr?=
 =?us-ascii?Q?upEQBMDwC4+nwnLnlEIazTOoIOI1JgMIJ8orEVp+EoXFZVGNDjfU/F7eQAyH?=
 =?us-ascii?Q?dT4/WevSpH/UTDtOzvleHPld208I4L7R7AqtZfvdXllaIgkbWZzcJNcG3NB2?=
 =?us-ascii?Q?T9ASvWaGlHsW7c3n8wN30JXtDrIl+EV8I3u/P7s1VajcCsS/QXJ1zybpZHvs?=
 =?us-ascii?Q?VvbaPBos0bTMNbW6jxJId9ScRWjVkB8QbZy8xdSdOgv2Hd03b3ML6zdpi7Sh?=
 =?us-ascii?Q?8Xb20tIdLEutvTG691lWb9YyJ0eKgn/R+GowWrFsGxik0OFygRcHDZBaR+fA?=
 =?us-ascii?Q?ppO2Vnd2md7PvHVdBuX4OO3gSUkJx6KNePUbJ4Mmg7/HHDXHR9EZDnGGA5yj?=
 =?us-ascii?Q?mnhdOzDH3cy37w3THNZ7h4j7iQME9B/5FSJc1mP2N3400l2YlFCq6HzC9A0F?=
 =?us-ascii?Q?TzGfhSEICwNdTln91NDYm+ffGXNPg41kFMsG7X+Rq2Rhobaffd9Lc2mfp3no?=
 =?us-ascii?Q?EUOQal7+5OgQH+Crih8qmKW28+RZk5MjWp7CUJgJ66eGOfiqPX8G19MJLLWh?=
 =?us-ascii?Q?kVyNPE2uCS3HxqgZb7jGsf1BGYpONOPqdzA1+DwhMOLE1HB+EqCUsfrnC3sn?=
 =?us-ascii?Q?IzNuP5QiSTbauoxakFwc2IGmutdKphhheWs/MVKpRObcTwYdwwft4C6GWQGm?=
 =?us-ascii?Q?clVLsnf5vG6YOhW1VtDynmZwftvVituRf39Zoj9Eyfjzq2mIjT8fTt3U3bro?=
 =?us-ascii?Q?aCRqvnD2zjwp/c0+Upf6iK4qnHTqD82gWpqJ7XHKmhe9EgdsQVe//RiAdnJu?=
 =?us-ascii?Q?vlBO7JmtYH48+4qzTabBzawDddJGOVTIfzB41sX+tgrYgSh25H16H8i/htzD?=
 =?us-ascii?Q?v7ddyDjZP9g5grAUSEuQzHS/E1MQmiBvo7KOOq3VihYwdqgLHu8yNE+F/o8A?=
 =?us-ascii?Q?afjCO3e4HZPPjqeMmeO5yOG2sxMk8XQidcq00TnSyRjkQZA8zIX9/N9s7ilx?=
 =?us-ascii?Q?A/Um816949r5wHHM7CtWYw+OMYx/86bgsYzXZxGV5kAZqFMkAh88vRb3S94s?=
 =?us-ascii?Q?O4jPOhSTNjhTUwigwoxpWoXPzjrdUbRFiaeJ0MjDuIukgWyzzzgfDeXxBW7W?=
 =?us-ascii?Q?AKBkix4gSW2NyQYjCDaDS/JpAw3LFCAONGovGtRp8bBAqPV6h+Z8qveHd259?=
 =?us-ascii?Q?FnYfJF7vnhbk6C/Tcsht178O+p+3qWR2QB948OVAtlQwj5scxGnTdxLeodsg?=
 =?us-ascii?Q?ybtOc7GbVYCS2XcKPYljn4Gyh/yflv/l4i/2DqSKhBe4OX/BJjn98UX3/eIb?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB25314E093834DFBAA35898A5C5FAAPN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c51c1c-44a9-4dc7-b045-08de16a1352d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 04:11:17.0860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGQR4K9dHiwCvr4hs9p1NlcywhybOPhhsTYahqXspbrCltx1OC9+PzyP6F+KoSgjosxLuOqzQdn1FDav0aHIjByaDTNULqidpYtnPA+wYTYgv2Y9pBySyCKKbELS5Phe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF2A9E3F87D
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

--_000_PN0P287MB25314E093834DFBAA35898A5C5FAAPN0P287MB2531INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Team,
I tried to reach out for Windows based DPDK over users@dpdk.org,admin@dpdk.=
org and windows developers in DPDK. But I didnot receive any reply from any=
one. Can you please direct the mail to the corresponding person-in charge.

I am using Virtio-PMD for my custom design in my Linux OS and is operationa=
l both in functional and throughput level. I wanted to know whether the Vir=
tio-PMD (drivers/net/virtio) available in Linux; Is feasible in Windows OS?
What changes to be made to support this? If not supported, could you please=
 elaborate the reason?

In addition linux has pcimem/devmem to access PCI resources, Does Windows h=
as similar application?

In https://core.dpdk.org/roadmap/windows/ link shows, the feature supported=
, but no example where specified. Could you please let me know the tests/wo=
rkaround performed with this PMD.

I tried to reachout at dpdkwin@microsoft.com for the same, the mail respons=
e shows "Your message to dpdkwin@microsoft.com couldn't be delivered". Is t=
his mail id deprecated?

Thanks and regards,
Ayshathul Thuhara

________________________________
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Sent: 27 October 2025 09:44
To: admin@dpdk.org <admin@dpdk.org>
Cc: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>
Subject: Fw: Virtio-PMD in Windows

Hi Team,
I tried to reach out for Windows based DPDK over users@dpdk.org and windows=
 developers in DPDK. But I didnot receive any reply from anyone. Can you pl=
ease direct the mail to the corresponding person-in charge.

I am using Virtio-PMD for my custom design in my Linux OS and is operationa=
l both in functional and throughput level. I wanted to know whether the Vir=
tio-PMD (drivers/net/virtio) available in Linux; Is feasible in Windows OS?
What changes to be made to support this? If not supported, could you please=
 elaborate the reason?

In addition linux has pcimem/devmem to access PCI resources, Does Windows h=
as similar application?

In https://core.dpdk.org/roadmap/windows/ link shows, the feature supported=
, but no example where specified. Could you please let me know the tests/wo=
rkaround performed with this PMD.

I tried to reachout at dpdkwin@microsoft.com for the same, the mail respons=
e shows "Your message to dpdkwin@microsoft.com couldn't be delivered". Is t=
his mail id deprecated?

Thanks and regards,
Ayshathul Thuhara


________________________________
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Sent: 21 October 2025 13:15
To: dmitry.kozliuk@gmail.com <dmitry.kozliuk@gmail.com>; navasile@linux.mic=
rosoft.com <navasile@linux.microsoft.com>; dmitrym@microsoft.com <dmitrym@m=
icrosoft.com>
Subject: Fw: Virtio-PMD in Windows

Dear Team,

       I am using Virtio-PMD for my custom design in my Linux OS and is ope=
rational both in functional and throughput level. I wante to know whether t=
he Virtio-PMD (drivers/net/virtio) available in Linux; Is feasible in Windo=
ws OS?
What changes to be made to support this? If not supported, could you please=
 elaborate the reason?

In https://core.dpdk.org/roadmap/windows/ link shows, the feature supported=
, but no example where specified. Could you please let me know the tests/wo=
rkaround performed with this PMD.

I tried to reachout at dpdkwin@microsoft.com for the same, the mail respons=
e shows "Your message to dpdkwin@microsoft.com couldn't be delivered". Is t=
his mail id deprecated?

Thanks and regards,
Ayshathul Thuhara



________________________________
From: Ayshathul Thuhara
Sent: 21 October 2025 12:40
To: users@dpdk.org <users@dpdk.org>
Subject: Virtio-PMD in Windows

Dear Team,

       The Virtio-PMD (drivers/net/virtio) available in Linux; Is feasible =
in Windows OS?
       What changes to be made to support this? Is not support, can you ple=
ase elaborate the reason?

Thanks and regards,
Ayshathul Thuhara

--_000_PN0P287MB25314E093834DFBAA35898A5C5FAAPN0P287MB2531INDP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" id=3D"UniqueMessageBody_235">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Hi Team,&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; color: black;"><span=
 style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cali=
bri, Helvetica, sans-serif; font-size: 12pt;">I tried to reach out for Wind=
ows based DPDK over
</span><span style=3D"font-family: Calibri, sans-serif; font-size: 11pt;">u=
sers@dpdk.org,admin@dpdk.org and windows developers in DPDK</span><span sty=
le=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,=
 Helvetica, sans-serif; font-size: 12pt;">.
 But I didnot receive any reply from anyone. Can you please direct the mail=
 to the corresponding person-in charge.</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;">I am using Virtio-PMD for my cust=
om design in my Linux OS and is operational both in functional and throughp=
ut level. I wanted to know
<b>whether the Virtio-PMD (drivers/net/virtio) available in Linux; Is feasi=
ble in Windows OS?</b></span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;">What changes to be made to suppor=
t this? If not supported, could you please elaborate the reason?</span></di=
v>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;">In addition linux has <b>pcimem/d=
evmem</b>&nbsp;to access PCI resources, Does Windows has similar applicatio=
n?</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;"><br>
In <a data-auth=3D"NotApplicable" data-linkindex=3D"0" rel=3D"noopener nore=
ferrer" title=3D"https://core.dpdk.org/roadmap/windows/" class=3D"OWAAutoLi=
nk" id=3D"OWAdc60eb27-5a04-78aa-6ae7-fee8fa9a1b2f" target=3D"_blank" href=
=3D"https://core.dpdk.org/roadmap/windows/">
https://core.dpdk.org/roadmap/windows/</a>&nbsp;link shows, the feature sup=
ported, but no example where specified. Could you please let me know the te=
sts/workaround performed with this PMD.</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<span style=3D"background-color: yellow;">I tried to reachout at dpdkwin@mi=
crosoft.com for the same, the mail response shows &quot;Your message to dpd=
kwin@microsoft.com couldn't be delivered&quot;. Is this mail id deprecated?=
</span></div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: black;">
<br>
Thanks and regards,<br>
Ayshathul Thuhara</div>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ayshathul Thuhara &lt=
;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Sent:</b> 27 October 2025 09:44<br>
<b>To:</b> admin@dpdk.org &lt;admin@dpdk.org&gt;<br>
<b>Cc:</b> Chaturbhuja Nath Prabhu &lt;c.prabhu@iwave-global.com&gt;<br>
<b>Subject:</b> Fw: Virtio-PMD in Windows</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof">Hi Team,&nbsp;</div>
<div class=3D"x_elementToProof" style=3D"color:rgb(0,0,0)"><span style=3D"f=
ont-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,s=
ans-serif; font-size:12pt">I tried to reach out for Windows based DPDK over
</span><span style=3D"font-family:Calibri,sans-serif; font-size:11pt">users=
@dpdk.org and windows developers in DPDK</span><span style=3D"font-family:A=
ptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; f=
ont-size:12pt">. But I didnot receive
 any reply from anyone. Can you please direct the mail to the corresponding=
 person-in charge.</span></div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)">I am using Virtio-PMD for m=
y custom design in my Linux OS and is operational both in functional and th=
roughput level. I wanted to know
<b>whether the Virtio-PMD (drivers/net/virtio) available in Linux; Is feasi=
ble in Windows OS?</b></span></div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)">What changes to be made to =
support this? If not supported, could you please elaborate the reason?</spa=
n></div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)"><br>
</span></div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)">In addition linux has <b>pc=
imem/devmem</b> to access PCI resources, Does Windows has similar applicati=
on?</span></div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)"><br>
In <a data-auth=3D"NotApplicable" class=3D"x_x_OWAAutoLink" id=3D"OWA445691=
16-97ba-3ac8-695c-2bcfef2b9cb7" href=3D"https://core.dpdk.org/roadmap/windo=
ws/">
https://core.dpdk.org/roadmap/windows/</a>&nbsp;link shows, the feature sup=
ported, but no example where specified. Could you please let me know the te=
sts/workaround performed with this PMD.</span></div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)"><br>
</span></div>
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
<span style=3D"background-color:rgb(255,255,0)">I tried to reachout at dpdk=
win@microsoft.com for the same, the mail response shows &quot;Your message =
to dpdkwin@microsoft.com couldn't be delivered&quot;. Is this mail id depre=
cated?</span></div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
Thanks and regards,<br>
Ayshathul Thuhara</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg">
<div style=3D"direction:ltr; font-family:Calibri,sans-serif; font-size:11pt=
; color:rgb(0,0,0)">
<b>From:</b>&nbsp;Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&=
gt;<br>
<b>Sent:</b>&nbsp;21 October 2025 13:15<br>
<b>To:</b>&nbsp;dmitry.kozliuk@gmail.com &lt;dmitry.kozliuk@gmail.com&gt;; =
navasile@linux.microsoft.com &lt;navasile@linux.microsoft.com&gt;; dmitrym@=
microsoft.com &lt;dmitrym@microsoft.com&gt;<br>
<b>Subject:</b>&nbsp;Fw: Virtio-PMD in Windows</div>
<div style=3D"direction:ltr">&nbsp;</div>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Dear Team,</div>
<div id=3D"x_x_UniqueMessageBody_317">
<div id=3D"x_x_x_UniqueMessageBody_291">
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
&nbsp; &nbsp; &nbsp; &nbsp;I am using Virtio-PMD for my custom design in my=
 Linux OS and is operational both in functional and throughput level. I wan=
te to know
<b>whether the Virtio-PMD (drivers/net/virtio) available in Linux; Is feasi=
ble in Windows OS?</b></div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
What changes to be made to support this? If not supported, could you please=
 elaborate the reason?</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
In <a data-auth=3D"NotApplicable" class=3D"x_x_OWAAutoLink" id=3D"OWAbf0744=
55-3ea2-8cb1-f2de-f0b253ef82a0" href=3D"https://core.dpdk.org/roadmap/windo=
ws/">
https://core.dpdk.org/roadmap/windows/</a>&nbsp;link shows, the feature sup=
ported, but no example where specified. Could you please let me know the te=
sts/workaround performed with this PMD.</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
I tried to reachout at dpdkwin@microsoft.com for the same, the mail respons=
e shows &quot;Your message to dpdkwin@microsoft.com couldn't be delivered&q=
uot;. Is this mail id deprecated?</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
Thanks and regards,<br>
Ayshathul Thuhara&nbsp;</div>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
<br>
</div>
<hr style=3D"direction:ltr; display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg">
<div style=3D"direction:ltr; font-family:Calibri,sans-serif; font-size:11pt=
; color:rgb(0,0,0)">
<b>From:</b>&nbsp;Ayshathul Thuhara<br>
<b>Sent:</b>&nbsp;21 October 2025 12:40<br>
<b>To:</b>&nbsp;users@dpdk.org &lt;users@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;Virtio-PMD in Windows</div>
<div style=3D"direction:ltr">&nbsp;</div>
</div>
<div style=3D"direction:ltr; font-family:Aptos,&quot;Aptos_EmbeddedFont&quo=
t;,&quot;Aptos_MSFontService&quot;,Calibri,Helvetica,sans-serif; font-size:=
12pt; color:rgb(0,0,0)">
Dear Team,<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp;The Virtio-PMD (drivers/net/virtio) available in=
 Linux; Is feasible in Windows OS?<br>
&nbsp; &nbsp; &nbsp; &nbsp;What changes to be made to support this? Is not =
support, can you please elaborate the reason?<br>
<br>
Thanks and regards,<br>
Ayshathul Thuhara&nbsp;</div>
</div>
</body>
</html>

--_000_PN0P287MB25314E093834DFBAA35898A5C5FAAPN0P287MB2531INDP_--
