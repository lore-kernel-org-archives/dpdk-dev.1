Return-Path: <dev-bounces@dpdk.org>
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96085CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 01:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93F6E402D8;
	Wed, 24 Sep 2025 03:39:43 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23]) by mails.dpdk.org (Postfix) with ESMTP id A2B1A402D6
 for <dev@dpdk.org>; Wed, 24 Sep 2025 03:39:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTIokQ/b2rDIPj3fWTcZ3sgeN1uJi8lps2ThnlbsKsr4nySXCT9+at7FM6fdnAP6sYt+OLFVNIzl+8+TcY7fVQkZfCKc17m+Qox1lfs2pdK+aARl/RjJa3MtU0BrZWB0tTScbvGCxcBHLrczsUW0ygcu/42OLDW34MfhHKO9jDpU2wdqLjdqL2l/Q0Iy0g4LcD1dsR9Xpkwhx18DBuyoMWUg2whehQV9NFDeK778m2f7hDrLRh/pAiIVQ6vQQTAaJ/dwNsWd6GtjplkUTx7b0b8vXi4Hds1Sj3qVUnpIAvWfs7UeOHvD4A8dUySxZZYoS/Yo5WlOWWXO22DhBWmj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkOneeNPnG9iRlOhhOecdolFPfmkvR27nIuHtfOsark=;
 b=el9kDpSse6mmGkiaTBBMSDlh01NpDUPAhdG5hTAAn2BauEpSQDByatFImdCVL0qtByCxqXJu5J6ickNIB0fA1Zf/7K//pfIZx+CKA4SRTcGDncHwpC0XZWu4SRRE3JWa4unuxvsK76v4njf6AzOt+iML+228BKwu6xpyB5K61mkwaL5O+vX4ynOf2XWirmNin/ellN6z8+C9uJoPmkN3LrbZsAwk65L820ntVoEZd5Ffq3MQ0HUWV6a7A8DxcLbRiua/ld4DI2WQXmu7+IJO01mJ0mWOmWDrT9H5vdKC1i9btmYZDaEkUn0BHg+LcRP6jeZvtkOcnNTKFHdtdAUY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkOneeNPnG9iRlOhhOecdolFPfmkvR27nIuHtfOsark=;
 b=FPpo3OgDFG2r/ZfwOGDQvKC424vJx/XWwZrFMrJJgmE9TWQ0jDG1UZW/dKLX/luXhDSkS0nfN2Ng+GGPTW9QDhQ74CTHA/AJzr3pdWhRW7I9GGpzlZ65RyZ73E8C8mOTafIRVw/fUK1KMW9O8KhC5AJK964lOiC4361OzKIvC5Zd/Ha1K1xwEMN2IQT73kNlsFaI8xcS+NvwmZ/rHBtM7oEZXhAX9rzqUPnRikkIBoqnwrqTF8UrLmh5PSYLA/YgeZy9fC3XvkOThmnMaZtsNd7uAAYIGCpoSeKsjBPtPPiZf2V318qphJ/CEjoZMSHU8UBSMc/iqFWRJVqsX4lbng==
Received: from CH2PR03MB5239.namprd03.prod.outlook.com (2603:10b6:610:a2::21)
 by DS7PR03MB5655.namprd03.prod.outlook.com (2603:10b6:5:2c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 01:39:36 +0000
Received: from CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792]) by CH2PR03MB5239.namprd03.prod.outlook.com
 ([fe80::7fea:1069:aa12:4792%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 01:39:36 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "John W. Linville" <linville@tuxdriver.com>, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, shepard.siegel
 <shepard.siegel@atomicrules.com>, Ed Czeck <ed.czeck@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>, Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Potnuri Bharat
 Teja <bharat@chelsio.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>, Evgeny
 Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>, Amit
 Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Gagandeep Singh <g.singh@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>, Gaetan
 Rivet <grive@u256.net>, Jeroen de Borst <jeroendb@google.com>, Joshua
 Washington <joshwash@google.com>, Ziyang Xuan <xuanziyang2@huawei.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>, Xingui Yang
 <yangxingui@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>, Praveen
 Shetty <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Andrew Boyer <andrew.boyer@amd.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Jakub Grajciar
 <jgrajcia@cisco.com>, Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Zyta Szpak <zyta@marvell.com>, Liron Himi
 <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>, Jiawen Wu
 <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>, Christian
 Koue Muf <ckm@napatech.com>, Serhii Iliushyk <sil-plv@napatech.com>, Tetsuya
 Mukawa <mtetsuyah@gmail.com>, Vamsi Attunuru <vattunuru@marvell.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>, Alok Prasad
 <palok@marvell.com>, Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin
 <hau@realtek.com>, Xing Wang <xing_wang@realsil.com.cn>, Wenbo Cao
 <caowenbo@mucse.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Stephen Hemminger <stephen@networkplumber.org>, Jerin Jacob
 <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, Jian Wang
 <jianwang@trustnetic.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Renyong Wan <wanry@yunsilicon.com>, Na Na
 <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang
 <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang
 <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: Re: [RFC PATCH 4/6] drivers/net: update to remove queue stats from
 eth stats
Thread-Topic: [RFC PATCH 4/6] drivers/net: update to remove queue stats from
 eth stats
Thread-Index: AQHcLJQlOS11ENxN2Ea9e+jfOrfIZ7Shjqdf
Date: Wed, 24 Sep 2025 01:39:36 +0000
Message-ID: <CH2PR03MB523960813B7CCA35AA8B5668FC1CA@CH2PR03MB5239.namprd03.prod.outlook.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250923141207.10403-5-bruce.richardson@intel.com>
In-Reply-To: <20250923141207.10403-5-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR03MB5239:EE_|DS7PR03MB5655:EE_
x-ms-office365-filtering-correlation-id: eb112d67-1c8b-4d20-0126-08ddfb0b3885
x-ld-processed: fbd72e03-d4a5-4110-adce-614d51f2077a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|39142699007|376014|7416014|31052699007|366016|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rm1BJ583L1f28zcxxYwfF3GPki6TLUZYEEciRs19BRKESJ0VHEyhQosTDP?=
 =?iso-8859-1?Q?Vb/47t/+tnaNzdmO8CXXxv9u4qp14QNaQWMkwzzDAZzyGoEBj8jEI2eoCP?=
 =?iso-8859-1?Q?tAC7WApioqf1WajzWgiLZTkRfT5gtz70dzuTeAJw3HBAObx1QIq857s8BK?=
 =?iso-8859-1?Q?veaOIBZu7Fn8fwEn8l6UZoommLpeEq4b6047cMdQeWBgxMNbcmf/TFScT1?=
 =?iso-8859-1?Q?7KD2QFhG//NNlk5Kegllxyyl2kFO1xOfJXIIp226EPlN3j8wesCmEvwsNf?=
 =?iso-8859-1?Q?Vilsgqb3jTyYlvUX8VQvv31yGnjwhrv6gvr0eff6tXlScjJJuuQubM5mrd?=
 =?iso-8859-1?Q?Rmwos7JSqiviZztyk8bYo/YXdvUsGb3ByjzQXMH/5oOdlv7xhCzLOypG8V?=
 =?iso-8859-1?Q?+OVoMIZWk+HHQDtMNBk/PX23oDsZ3BphO+pt4spX1BsNlS5brpN+xY3tg1?=
 =?iso-8859-1?Q?aUGhb+eVifLyUBr5aGOwAwyORMz0PczkjbNvWBd7iCAxI6ePD2T3G8hTKB?=
 =?iso-8859-1?Q?9mwaW/cW8gw6Ua7jqF/uXhw2vLOyv3rCzo+tB3uov5Qv4dayttG1tuPVdj?=
 =?iso-8859-1?Q?QrSux7ORAg+0w7kwBZvb5rNUgcN7kVOCoFafZB/Xt5eGUZhdCMcGSjSCrk?=
 =?iso-8859-1?Q?PLzYeEHmsnEXGmYtQnWasC/+h5vmRbTe5eMcbQRvO38zgackvP3sCge9ZN?=
 =?iso-8859-1?Q?W/mRO21sM9hESPl/e1C58IhT/ZdreH8TE8WuAVRbO3lU8X/UucHmZEweZe?=
 =?iso-8859-1?Q?W179XyTPN5mvJzps6bfAikPLnmlX3W/FmjwL0/eHwoniPJWyXmfBHLXQQZ?=
 =?iso-8859-1?Q?CJ/d0aZvlGDfvbHT/DZPlnRWZCSsSsf3YAl/QUfA3bP/e+y++U2dul/MSS?=
 =?iso-8859-1?Q?XnZQPGpMY+J4LkGIgnoLOMiASGEGw/AZIOOYfOY7SODSzjkpf3Ix7Eb7hb?=
 =?iso-8859-1?Q?r4waJSOhhaqXPdZOTbkcTdDFdieDmlm0aaCBSH4BolDjNnch7f1evkLYJQ?=
 =?iso-8859-1?Q?D98MjV/utl5IQ0Xy7cN4dnB0qzMRafFnOs7NnVO9o4GBKdCVz7Vsj4f6IN?=
 =?iso-8859-1?Q?KZGasEcMLFzekhJfX9SS2NZDYxuY/UnZgL0eHXhIqtu4IaUfmB7IAdQx3C?=
 =?iso-8859-1?Q?gLy8bc5ho6d2nkjjgThkv/3zHNxCMF7LGpM3dlfBCTAayESmrXXD1jPg2O?=
 =?iso-8859-1?Q?cEgo8mH+SvqXnepou5Bqe/g+iSXRj5q7KLBLnUVwqRieYVh/EyASuuw290?=
 =?iso-8859-1?Q?mDN6l1+x10lzKDdzgW/BJf8E41DKQldVBqLw7ORsgKZTiklTjdt3MNET3F?=
 =?iso-8859-1?Q?B/sRAwszYXc76Gdx6D70jAzd+Y4dAHjp1oLB5H5EMx8jBcM5aXhcrcXhRV?=
 =?iso-8859-1?Q?VyzHu8to3UHvf+mpYYcUtAvxuGXhGgMEBDs0/6T1l1gKEbpI+Bd/bPh/Kx?=
 =?iso-8859-1?Q?J546FTcfjiBWSqT6Srx53ln9y2YG5oE9yUT91MkcPpZSOv8gEXp69/gM2u?=
 =?iso-8859-1?Q?+iaA0+Vgw6mCCoB8X9UN8Vp8079J0XskpcdUEsMKVpxvJyYkAmcpbQ2NR1?=
 =?iso-8859-1?Q?Fqyqua4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR03MB5239.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(39142699007)(376014)(7416014)(31052699007)(366016)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c4h5tGAfOx5MCmdud0Gw9/ZsjGfPr84eYZj7Yl4DVC9KSnLRiqp3H+5IgJ?=
 =?iso-8859-1?Q?7qQM4QoKOHaujM86RNnrt0pyLi+K4BXumyHePVXiqJd7yxB/SSRzIV3e66?=
 =?iso-8859-1?Q?fiP1tsf4a/4tjQNaWs+As5bnrEgpIGDHNhg6OrjHpPNdB1p0U/EQqlJQqZ?=
 =?iso-8859-1?Q?X3XF/j7DJHPNWLDtIx+UN+8yZTWWHRyfHs8IMdgrRXECkmhZEm05H5EVs1?=
 =?iso-8859-1?Q?Rzzc340Q8cck6hPgeYY8f6yMEgtRde9nc2jHQ1y8bUnYXCvmycsXn3ztRR?=
 =?iso-8859-1?Q?t0z2DPLSU2HHXpxetE34fouZ7sGqKxAMRLZ+PRE6A9a+YI4HyCrhm6K2AK?=
 =?iso-8859-1?Q?q/l/3wHGKvj2VgEhJKYS7uGbV+93za7mi1lsfINPHZ6dmxsjJCUXhg2AND?=
 =?iso-8859-1?Q?jp6uhqwQdceSL5FImmMTL8WwJ5414hcVL/JkrY3qRWkPM3XiNvhF3b/dws?=
 =?iso-8859-1?Q?zCsa+SAzB1PUb6IlJzSpWOT+MqitupMQ19bM3ApLHI/piu3z2wWFbuvX8a?=
 =?iso-8859-1?Q?FaRwiLHP5l/V9mJuLP3iXOe4daH++jxqgAownUSZZAhxHw6upDBsKcFc1u?=
 =?iso-8859-1?Q?XffkV9W+xilUjhxQvqZOj6sPJPjK8tgCBIktYgzSv9aOdZCDjT0VbKWHto?=
 =?iso-8859-1?Q?myQpH5d/y3rqWebLTy2NCPKDfZp7NiRAMYI2ocOETb6e5y2wAkeHGxjGsA?=
 =?iso-8859-1?Q?codpRx+fpFKpQ8/+HyM+AoVp7CEgoP4JinygLFBxYWOZ1qW6mRhhbvWeag?=
 =?iso-8859-1?Q?eAlI0xMeZfs4Lvz6l/d04CLG3v8OD+HSLatkvsbzIFVV+sd9lA9KVfYp9h?=
 =?iso-8859-1?Q?xIz0EqsJL6nOy9BPXvJXWddq5xxc1qqLCANRqdlHtm8Cnf/CkQgEJu/7pp?=
 =?iso-8859-1?Q?OUt1/vcwbvj8EdHuohI66+vtDQCkkMGUvu++roiZO/iF/234SyNrYhAFww?=
 =?iso-8859-1?Q?WiGiTH50dO+l9NpwPPDA5lrWrt9qwVs9e4rbBmtzfRCXQaCAhVx4Q3+5wd?=
 =?iso-8859-1?Q?mgatEXyvND1jmvvENMRYC7g5zXjElWdiMcdV9Xng68/G3JBp6Ibt9g0e6a?=
 =?iso-8859-1?Q?Nuk1La/cU87vBH/K0yazM9ZSm8rrAdFqhkywEGHiPFMegWxeBBwIR6RkRk?=
 =?iso-8859-1?Q?lI7mzKKbn61XhbSphysVA6oG0CGfIhaEGaKHeq3ZQAT0GkIWpz7JXl4ZK2?=
 =?iso-8859-1?Q?Yyw4QWRikS5kBQK+jDnScF8LNOBc38njb6R4b6d+w5YhAxPgvbZGQaYR0G?=
 =?iso-8859-1?Q?nfj4Zo943HUtYDFk1LuviKeTs/t33N7D9XsQ42SyGMz4Hhq7crTUpMh7zD?=
 =?iso-8859-1?Q?Exthm1Z2w6pirrDGSibKwd4GKG1OKMXihQeObPI56GB76vUI0QwQ0DBTfU?=
 =?iso-8859-1?Q?Tb9zDRGkPZp48SSdncfZDhpSzh+po0pAR7xqv7eiL91kM/mCcdQTTH2AVr?=
 =?iso-8859-1?Q?psOuNNP5IIE1+WNlWTrs8IFXka4nhzD2rA7qQiSFbNtF5LHRht0Q3UNnzq?=
 =?iso-8859-1?Q?Vb9vlKitI5dK/i2X99bbhAXIFpvP934jOsNE3bhTH9jpblL+zfZUb2HXJz?=
 =?iso-8859-1?Q?Y9Sot5TtThJKdCeuszFmmnXFWTsRQQduhROy4U9AaDGcRcKTYS4Jobj5pr?=
 =?iso-8859-1?Q?K8NZ2Ieslzhew52D0jYZrwEL2vsOBD8ZsS?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR03MB523960813B7CCA35AA8B5668FC1CACH2PR03MB5239namp_"
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR03MB5239.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb112d67-1c8b-4d20-0126-08ddfb0b3885
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 01:39:36.7273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9yQe9fCjrDnhYW8sSK1i0B1Y+xmohsaKspmYa0Vp8xhdlHGFhG9YYdbLMXJgsQoKkn1QIYd7yxEPQMJupa3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5655
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

--_000_CH2PR03MB523960813B7CCA35AA8B5668FC1CACH2PR03MB5239namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Tuesday, September 23, 2025 10:12 PM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>; John W. Linville <linvil=
le@tuxdriver.com>; Ciara Loftus <ciara.loftus@intel.com>; Maryam Tahhan <mt=
ahhan@redhat.com>; shepard.siegel <shepard.siegel@atomicrules.com>; Ed Czec=
k <ed.czeck@atomicrules.com>; John Miller <john.miller@atomicrules.com>; Ig=
or Russkikh <irusskikh@marvell.com>; Steven Webster <steven.webster@windriv=
er.com>; Matt Peters <matt.peters@windriver.com>; Selwin Sebastian <selwin.=
sebastian@amd.com>; Julien Aube <julien_dpdk@jaube.fr>; Ajit Khaparde <ajit=
.khaparde@broadcom.com>; Somnath Kotur <somnath.kotur@broadcom.com>; Chas W=
illiams <3chas3@gmail.com>; Min Hu (Connor) <humin29@huawei.com>; Nithin Da=
bilpuram <ndabilpuram@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>=
; Sunil Kumar Kori <skori@marvell.com>; Satha Rao <skoteshwar@marvell.com>;=
 Harman Kalra <hkalra@marvell.com>; Potnuri Bharat Teja <bharat@chelsio.com=
>; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nx=
p.com>; Shai Brandes <shaibran@amazon.com>; Evgeny Schemeilin <evgenys@amaz=
on.com>; Ron Beider <rbeider@amazon.com>; Amit Bernstein <amitbern@amazon.c=
om>; Wajeeh Atrash <atrwajee@amazon.com>; Gagandeep Singh <g.singh@nxp.com>=
; Apeksha Gupta <apeksha.gupta@nxp.com>; John Daley <johndale@cisco.com>; H=
yong Youb Kim <hyonkim@cisco.com>; Gaetan Rivet <grive@u256.net>; Jeroen de=
 Borst <jeroendb@google.com>; Joshua Washington <joshwash@google.com>; Ziya=
ng Xuan <xuanziyang2@huawei.com>; Xiaoyun Wang <cloud.wangxiaoyun@huawei.co=
m>; Xingui Yang <yangxingui@huawei.com>; Chengwen Feng <fengchengwen@huawei=
.com>; Praveen Shetty <praveen.shetty@intel.com>; Vladimir Medvedkin <vladi=
mir.medvedkin@intel.com>; Anatoly Burakov <anatoly.burakov@intel.com>; Jing=
jing Wu <jingjing.wu@intel.com>; Xu, Rosen <rosen.xu@altera.com>; Andrew Bo=
yer <andrew.boyer@amd.com>; Long Li <longli@microsoft.com>; Wei Hu <weh@mic=
rosoft.com>; Jakub Grajciar <jgrajcia@cisco.com>; Matan Azrad <matan@nvidia=
.com>; Viacheslav Ovsiienko <viacheslavo@nvidia.com>; Dariusz Sosnowski <ds=
osnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.c=
om>; Suanming Mou <suanmingm@nvidia.com>; Zyta Szpak <zyta@marvell.com>; Li=
ron Himi <lironh@marvell.com>; Chaoyong He <chaoyong.he@corigine.com>; Jiaw=
en Wu <jiawenwu@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>; Chr=
istian Koue Muf <ckm@napatech.com>; Serhii Iliushyk <sil-plv@napatech.com>;=
 Tetsuya Mukawa <mtetsuyah@gmail.com>; Vamsi Attunuru <vattunuru@marvell.co=
m>; Devendra Singh Rawat <dsinghrawat@marvell.com>; Alok Prasad <palok@marv=
ell.com>; Howard Wang <howard_wang@realsil.com.cn>; Chunhao Lin <hau@realte=
k.com>; Xing Wang <xing_wang@realsil.com.cn>; Wenbo Cao <caowenbo@mucse.com=
>; Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>; Stephen Hemminger <ste=
phen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Maciej Czekaj <=
mczekaj@marvell.com>; Jian Wang <jianwang@trustnetic.com>; Maxime Coquelin =
<maxime.coquelin@redhat.com>; Chenbo Xia <chenbox@nvidia.com>; Jochen Behre=
ns <jochen.behrens@broadcom.com>; Renyong Wan <wanry@yunsilicon.com>; Na Na=
 <nana@yunsilicon.com>; Rong Qian <qianr@yunsilicon.com>; Xiaoxiong Zhang <=
zhangxx@yunsilicon.com>; Dongwei Xu <xudw@yunsilicon.com>; Junlong Wang <wa=
ng.junlong1@zte.com.cn>; Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC PATCH 4/6] drivers/net: update to remove queue stats from eth=
 stats

Now that we have removed the queue stats from the ethdev stats, we need
to update the various PMDs to take account of the changes.

Update each stats_get function to take the extra parameters for qstats,
just marking it as unused if the driver does not fill in queue stats.
For those that do complete queue stats, update the structure reference
as appropriate.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
 drivers/net/ark/ark_ethdev.c                  |  36 +++--
 drivers/net/ark/ark_ethdev_rx.c               |  14 +-
 drivers/net/ark/ark_ethdev_rx.h               |   3 +-
 drivers/net/ark/ark_ethdev_tx.c               |  12 +-
 drivers/net/ark/ark_ethdev_tx.h               |   3 +-
 drivers/net/atlantic/atl_ethdev.c             |  19 +--
 drivers/net/atlantic/atl_types.h              |   1 +
 drivers/net/avp/avp_ethdev.c                  |  20 ++-
 drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
 drivers/net/axgbe/axgbe_ethdev.h              |   1 +
 drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
 drivers/net/bnxt/bnxt_reps.c                  |  14 +-
 drivers/net/bnxt/bnxt_reps.h                  |   2 +-
 drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
 drivers/net/bnxt/bnxt_stats.h                 |   2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
 drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
 drivers/net/cnxk/cnxk_rep.h                   |   3 +-
 drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
 drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
 drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
 drivers/net/ena/ena_ethdev.c                  |  46 +++---
 drivers/net/enetc/enetc_ethdev.c              |   4 +-
 drivers/net/enetfec/enet_ethdev.c             |   3 +-
 drivers/net/enic/enic.h                       |   3 +-
 drivers/net/enic/enic_ethdev.c                |   4 +-
 drivers/net/enic/enic_main.c                  |   3 +-
 drivers/net/enic/enic_vf_representor.c        |   3 +-
 drivers/net/failsafe/failsafe_ether.c         |   9 --
 drivers/net/failsafe/failsafe_ops.c           |   3 +-
 drivers/net/gve/gve_ethdev.c                  |   4 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
 drivers/net/hns3/hns3_stats.c                 |   4 +-
 drivers/net/hns3/hns3_stats.h                 |   3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
 drivers/net/intel/e1000/em_ethdev.c           |   7 +-
 drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
 drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
 drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
 drivers/net/intel/ice/ice_ethdev.c            |   5 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |   3 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
 drivers/net/ionic/ionic_ethdev.c              |   6 +-
 drivers/net/ionic/ionic_lif.c                 |  35 +++--
 drivers/net/ionic/ionic_lif.h                 |   3 +-
 drivers/net/mana/mana.c                       |  15 +-
 drivers/net/memif/rte_eth_memif.c             |  15 +-
 drivers/net/mlx4/mlx4.h                       |   3 +-
 drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
 drivers/net/mlx5/mlx5.h                       |   3 +-
 drivers/net/mlx5/mlx5_stats.c                 |  17 +--
 drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
 drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
 drivers/net/netvsc/hn_ethdev.c                |  17 +--
 drivers/net/netvsc/hn_var.h                   |   3 +-
 drivers/net/netvsc/hn_vf.c                    |   3 +-
 drivers/net/nfp/flower/nfp_flower.c           |   8 +-
 .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
 .../net/nfp/flower/nfp_flower_representor.h   |   3 +
 drivers/net/nfp/nfp_net_common.c              |  46 +++---
 drivers/net/nfp/nfp_net_common.h              |   4 +-
 drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
 drivers/net/null/rte_eth_null.c               |  15 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
 drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
 drivers/net/pcap/pcap_ethdev.c                |  23 +--
 drivers/net/pfe/pfe_ethdev.c                  |   3 +-
 drivers/net/qede/qede_ethdev.c                |  23 ++-
 drivers/net/r8169/r8169_ethdev.c              |   6 +-
 drivers/net/ring/rte_eth_ring.c               |  13 +-
 drivers/net/rnp/rnp_ethdev.c                  |  15 +-
 drivers/net/sfc/sfc_ethdev.c                  |   3 +-
 drivers/net/sfc/sfc_repr.c                    |   3 +-
 drivers/net/tap/rte_eth_tap.c                 |  23 +--
 drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
 drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
 drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
 drivers/net/virtio/virtio_ethdev.c            |  23 +--
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
 drivers/net/xsc/xsc_ethdev.c                  |  19 +--
 drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
 drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
 95 files changed, 828 insertions(+), 605 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_pac=
ket/rte_eth_af_packet.c
index 85bc1201b4..88eb705a48 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -426,7 +426,7 @@ packet_drop_count(int sockfd)
 }

 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, struct=
 eth_queue_stats *qstats)
 {
         unsigned int i;
         unsigned long rx_total =3D 0, rx_dropped_total =3D 0, rx_nombuf_to=
tal =3D 0;
@@ -448,11 +448,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)
                 tx_err_total +=3D internal->tx_queue[i].err_pkts;
                 tx_bytes_total +=3D internal->tx_queue[i].tx_bytes;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D internal->rx_queue[i].rx_p=
kts;
-                       stats->q_ibytes[i] =3D internal->rx_queue[i].rx_byt=
es;
-                       stats->q_opackets[i] =3D internal->tx_queue[i].tx_p=
kts;
-                       stats->q_obytes[i] =3D internal->tx_queue[i].tx_byt=
es;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D internal->rx_queue[i].rx_=
pkts;
+                       qstats->q_ibytes[i] =3D internal->rx_queue[i].rx_by=
tes;
+                       qstats->q_opackets[i] =3D internal->tx_queue[i].tx_=
pkts;
+                       qstats->q_obytes[i] =3D internal->tx_queue[i].tx_by=
tes;
+                       qstats->q_errors[i] =3D internal->rx_queue[i].rx_no=
mbuf;
                 }
         }

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_e=
th_af_xdp.c
index f68895c93c..f2a8fb95d1 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -892,7 +892,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_de=
v_info *dev_info)
 }

 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         struct pmd_internals *internals =3D dev->data->dev_private;
         struct pmd_process_private *process_private =3D dev->process_priva=
te;
@@ -901,20 +902,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)
         struct pkt_tx_queue *txq;
         socklen_t optlen;
         int i, ret, fd;
+       unsigned long ipackets =3D 0, ibytes =3D 0, opackets =3D 0, obytes =
=3D 0;
+       unsigned long oerrors =3D 0, imissed =3D 0;

         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
                 optlen =3D sizeof(struct xdp_statistics);
                 rxq =3D &internals->rx_queues[i];
                 txq =3D rxq->pair;
-               stats->q_ipackets[i] =3D rxq->stats.rx_pkts;
-               stats->q_ibytes[i] =3D rxq->stats.rx_bytes;

-               stats->q_opackets[i] =3D txq->stats.tx_pkts;
-               stats->q_obytes[i] =3D txq->stats.tx_bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D rxq->stats.rx_pkts;
+                       qstats->q_ibytes[i] =3D rxq->stats.rx_bytes;
+                       qstats->q_opackets[i] =3D txq->stats.tx_pkts;
+                       qstats->q_obytes[i] =3D txq->stats.tx_bytes;
+                       qstats->q_errors[i] =3D 0; /* Not used */
+               }

-               stats->ipackets +=3D stats->q_ipackets[i];
-               stats->ibytes +=3D stats->q_ibytes[i];
-               stats->oerrors +=3D txq->stats.tx_dropped;
+               ipackets +=3D rxq->stats.rx_pkts;
+               ibytes +=3D rxq->stats.rx_bytes;
+               oerrors +=3D txq->stats.tx_dropped;
                 fd =3D process_private->rxq_xsk_fds[i];
                 ret =3D fd >=3D 0 ? getsockopt(fd, SOL_XDP, XDP_STATISTICS=
,
                                            &xdp_stats, &optlen) : -1;
@@ -922,12 +928,19 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)
                         AF_XDP_LOG_LINE(ERR, "getsockopt() failed for XDP_=
STATISTICS.");
                         return -1;
                 }
-               stats->imissed +=3D xdp_stats.rx_dropped - rxq->stats.imiss=
ed_offset;
+               imissed +=3D xdp_stats.rx_dropped - rxq->stats.imissed_offs=
et;

-               stats->opackets +=3D stats->q_opackets[i];
-               stats->obytes +=3D stats->q_obytes[i];
+               opackets +=3D txq->stats.tx_pkts;
+               obytes +=3D txq->stats.tx_bytes;
         }

+       stats->ipackets =3D ipackets;
+       stats->ibytes =3D ibytes;
+       stats->opackets =3D opackets;
+       stats->obytes =3D obytes;
+       stats->oerrors =3D oerrors;
+       stats->imissed =3D imissed;
+
         return 0;
 }

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index c029dc46b3..02d6683ab9 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -37,7 +37,8 @@ static int eth_ark_dev_link_update(struct rte_eth_dev *de=
v,
 static int eth_ark_dev_set_link_up(struct rte_eth_dev *dev);
 static int eth_ark_dev_set_link_down(struct rte_eth_dev *dev);
 static int eth_ark_dev_stats_get(struct rte_eth_dev *dev,
-                                 struct rte_eth_stats *stats);
+                                 struct rte_eth_stats *stats,
+                                 struct eth_queue_stats *qstats);
 static int eth_ark_dev_stats_reset(struct rte_eth_dev *dev);
 static int eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
                                          struct rte_ether_addr *mac_addr);
@@ -780,25 +781,36 @@ eth_ark_dev_set_link_down(struct rte_eth_dev *dev)
 }

 static int
-eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)
+eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,
+               struct eth_queue_stats *qstats)
 {
         uint16_t i;
         struct ark_adapter *ark =3D dev->data->dev_private;
+       struct rte_eth_dev_data *data =3D dev->data;

-       stats->ipackets =3D 0;
-       stats->ibytes =3D 0;
-       stats->opackets =3D 0;
-       stats->obytes =3D 0;
-       stats->imissed =3D 0;
-       stats->oerrors =3D 0;
+       /* Initialize stats to 0 */
+       memset(stats, 0, sizeof(*stats));

-       for (i =3D 0; i < dev->data->nb_tx_queues; i++)
-               eth_tx_queue_stats_get(dev->data->tx_queues[i], stats);
-       for (i =3D 0; i < dev->data->nb_rx_queues; i++)
-               eth_rx_queue_stats_get(dev->data->rx_queues[i], stats);
+       if (qstats)
+               memset(qstats, 0, sizeof(*qstats));
+
+       /* Get stats for each RX queue */
+       for (i =3D 0; i < data->nb_rx_queues; i++) {
+               if (data->rx_queues[i])
+                       eth_rx_queue_stats_get(data->rx_queues[i], stats, q=
stats);
+       }
+
+       /* Get stats for each TX queue */
+       for (i =3D 0; i < data->nb_tx_queues; i++) {
+               if (data->tx_queues[i])
+                       eth_tx_queue_stats_get(data->tx_queues[i], stats, q=
stats);
+       }
+
+       /* Call user extension if registered */
         if (ark->user_ext.stats_get)
                 return ark->user_ext.stats_get(dev, stats,
                         ark->user_data[dev->data->port_id]);
+
         return 0;
 }

diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_r=
x.c
index 2fff0ffded..d7d480ac90 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -560,13 +560,14 @@ eth_ark_dev_rx_queue_release(void *vqueue)
 }

 void
-eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
+eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+                     struct eth_queue_stats *qstats)
 {
         struct ark_rx_queue *queue;
         struct ark_udm_t *udm;

         queue =3D vqueue;
-       if (queue =3D=3D 0)
+       if (queue =3D=3D NULL)
                 return;
         udm =3D queue->udm;

@@ -574,12 +575,15 @@ eth_rx_queue_stats_get(void *vqueue, struct rte_eth_s=
tats *stats)
         uint64_t ipackets =3D ark_udm_packets(udm);
         uint64_t idropped =3D ark_udm_dropped(queue->udm);

-       stats->q_ipackets[queue->queue_index] =3D ipackets;
-       stats->q_ibytes[queue->queue_index] =3D ibytes;
-       stats->q_errors[queue->queue_index] =3D idropped;
         stats->ipackets +=3D ipackets;
         stats->ibytes +=3D ibytes;
         stats->imissed +=3D idropped;
+
+       if (qstats && queue->queue_index < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+               qstats->q_ipackets[queue->queue_index] =3D ipackets;
+               qstats->q_ibytes[queue->queue_index] =3D ibytes;
+               qstats->q_errors[queue->queue_index] =3D idropped;
+       }
 }

 void
diff --git a/drivers/net/ark/ark_ethdev_rx.h b/drivers/net/ark/ark_ethdev_r=
x.h
index 12d4f61637..27b87445b1 100644
--- a/drivers/net/ark/ark_ethdev_rx.h
+++ b/drivers/net/ark/ark_ethdev_rx.h
@@ -23,7 +23,8 @@ int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint1=
6_t queue_id);
 uint16_t eth_ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
                            uint16_t nb_pkts);
 void eth_ark_dev_rx_queue_release(void *rx_queue);
-void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
+void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats);
 void eth_rx_queue_stats_reset(void *vqueue);
 void eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
                            const char *msg);
diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev_t=
x.c
index ca6cd297a1..5c22de6080 100644
--- a/drivers/net/ark/ark_ethdev_tx.c
+++ b/drivers/net/ark/ark_ethdev_tx.c
@@ -415,23 +415,29 @@ free_completed_tx(struct ark_tx_queue *queue)

 /* ***********************************************************************=
** */
 void
-eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
+eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+                     struct eth_queue_stats *qstats)
 {
         struct ark_tx_queue *queue;
         struct ark_ddm_t *ddm;
         uint64_t bytes, pkts;

         queue =3D vqueue;
+       if (queue =3D=3D NULL)
+               return;
         ddm =3D queue->ddm;

         bytes =3D ark_ddm_queue_byte_count(ddm);
         pkts =3D ark_ddm_queue_pkt_count(ddm);

-       stats->q_opackets[queue->queue_index] =3D pkts;
-       stats->q_obytes[queue->queue_index] =3D bytes;
         stats->opackets +=3D pkts;
         stats->obytes +=3D bytes;
         stats->oerrors +=3D queue->tx_errors;
+
+       if (qstats && queue->queue_index < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+               qstats->q_opackets[queue->queue_index] =3D pkts;
+               qstats->q_obytes[queue->queue_index] =3D bytes;
+       }
 }

 void
diff --git a/drivers/net/ark/ark_ethdev_tx.h b/drivers/net/ark/ark_ethdev_t=
x.h
index 7134dbfeed..639ee8adb4 100644
--- a/drivers/net/ark/ark_ethdev_tx.h
+++ b/drivers/net/ark/ark_ethdev_tx.h
@@ -21,7 +21,8 @@ int eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
 void eth_ark_tx_queue_release(void *vtx_queue);
 int eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
 int eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
-void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
+void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats);
 void eth_tx_queue_stats_reset(void *vqueue);

 #endif
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_e=
thdev.c
index 9cde935834..2925dc2478 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -33,7 +33,7 @@ static int atl_dev_xstats_get_names(struct rte_eth_dev *d=
ev __rte_unused,
                                     unsigned int size);

 static int atl_dev_stats_get(struct rte_eth_dev *dev,
-                               struct rte_eth_stats *stats);
+                               struct rte_eth_stats *stats, struct eth_que=
ue_stats *qstats);

 static int atl_dev_xstats_get(struct rte_eth_dev *dev,
                               struct rte_eth_xstat *stats, unsigned int n)=
;
@@ -930,7 +930,8 @@ int atl_macsec_select_rxsa(struct rte_eth_dev *dev,
 }

 static int
-atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                 struct eth_queue_stats *qstats)
 {
         struct atl_adapter *adapter =3D ATL_DEV_TO_ADAPTER(dev);
         struct aq_hw_s *hw =3D &adapter->hw;
@@ -951,12 +952,14 @@ atl_dev_stats_get(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)

         stats->rx_nombuf =3D swstats->rx_nombuf;

-       for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-               stats->q_ipackets[i] =3D swstats->q_ipackets[i];
-               stats->q_opackets[i] =3D swstats->q_opackets[i];
-               stats->q_ibytes[i] =3D swstats->q_ibytes[i];
-               stats->q_obytes[i] =3D swstats->q_obytes[i];
-               stats->q_errors[i] =3D swstats->q_errors[i];
+       if (qstats !=3D NULL) {
+               for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
+                       qstats->q_ipackets[i] =3D swstats->q_ipackets[i];
+                       qstats->q_opackets[i] =3D swstats->q_opackets[i];
+                       qstats->q_ibytes[i] =3D swstats->q_ibytes[i];
+                       qstats->q_obytes[i] =3D swstats->q_obytes[i];
+                       qstats->q_errors[i] =3D swstats->q_errors[i];
+               }
         }
         return 0;
 }
diff --git a/drivers/net/atlantic/atl_types.h b/drivers/net/atlantic/atl_ty=
pes.h
index e813d9f326..dfd7016600 100644
--- a/drivers/net/atlantic/atl_types.h
+++ b/drivers/net/atlantic/atl_types.h
@@ -13,6 +13,7 @@
 #include <pthread.h>

 #include <rte_common.h>
+#include <ethdev_driver.h>

 typedef uint8_t         u8;
 typedef int8_t          s8;
diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index ed44c1645d..3bc5171336 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -79,7 +79,8 @@ static void avp_dev_rx_queue_release(struct rte_eth_dev *=
dev, uint16_t qid);
 static void avp_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid=
);

 static int avp_dev_stats_get(struct rte_eth_dev *dev,
-                             struct rte_eth_stats *stats);
+                             struct rte_eth_stats *stats,
+                             struct eth_queue_stats *qstats);
 static int avp_dev_stats_reset(struct rte_eth_dev *dev);


@@ -2241,7 +2242,8 @@ avp_vlan_offload_set(struct rte_eth_dev *eth_dev, int=
 mask)
 }

 static int
-avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats=
)
+avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats=
,
+                 struct eth_queue_stats *qstats)
 {
         struct avp_dev *avp =3D AVP_DEV_PRIVATE_TO_HW(eth_dev->data->dev_p=
rivate);
         unsigned int i;
@@ -2254,9 +2256,11 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struc=
t rte_eth_stats *stats)
                         stats->ibytes +=3D rxq->bytes;
                         stats->ierrors +=3D rxq->errors;

-                       stats->q_ipackets[i] +=3D rxq->packets;
-                       stats->q_ibytes[i] +=3D rxq->bytes;
-                       stats->q_errors[i] +=3D rxq->errors;
+                       if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {
+                               qstats->q_ipackets[i] +=3D rxq->packets;
+                               qstats->q_ibytes[i] +=3D rxq->bytes;
+                               qstats->q_errors[i] +=3D rxq->errors;
+                       }
                 }
         }

@@ -2268,8 +2272,10 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struc=
t rte_eth_stats *stats)
                         stats->obytes +=3D txq->bytes;
                         stats->oerrors +=3D txq->errors;

-                       stats->q_opackets[i] +=3D txq->packets;
-                       stats->q_obytes[i] +=3D txq->bytes;
+                       if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {
+                               qstats->q_opackets[i] +=3D txq->packets;
+                               qstats->q_obytes[i] +=3D txq->bytes;
+                       }
                 }
         }

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_eth=
dev.c
index bc73536604..31d35ff182 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -51,7 +51,8 @@ static int axgbe_dev_link_update(struct rte_eth_dev *dev,
 static int axgbe_dev_get_regs(struct rte_eth_dev *dev,
                               struct rte_dev_reg_info *regs);
 static int axgbe_dev_stats_get(struct rte_eth_dev *dev,
-                               struct rte_eth_stats *stats);
+                               struct rte_eth_stats *stats,
+                               struct eth_queue_stats *qstats);
 static int axgbe_dev_stats_reset(struct rte_eth_dev *dev);
 static int axgbe_dev_xstats_get(struct rte_eth_dev *dev,
                                 struct rte_eth_xstat *stats,
@@ -1133,7 +1134,7 @@ axgbe_dev_xstats_reset(struct rte_eth_dev *dev)

 static int
 axgbe_dev_stats_get(struct rte_eth_dev *dev,
-                   struct rte_eth_stats *stats)
+                   struct rte_eth_stats *stats, struct eth_queue_stats *qs=
tats)
 {
         struct axgbe_rx_queue *rxq;
         struct axgbe_tx_queue *txq;
@@ -1148,14 +1149,16 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
         for (i =3D 0; i < dev->data->nb_rx_queues; i++) {
                 rxq =3D dev->data->rx_queues[i];
                 if (rxq) {
-                       stats->q_ipackets[i] =3D rxq->pkts;
                         stats->ipackets +=3D rxq->pkts;
-                       stats->q_ibytes[i] =3D rxq->bytes;
                         stats->ibytes +=3D rxq->bytes;
                         stats->rx_nombuf +=3D rxq->rx_mbuf_alloc_failed;
-                       stats->q_errors[i] =3D rxq->errors
-                               + rxq->rx_mbuf_alloc_failed;
                         stats->ierrors +=3D rxq->errors;
+
+                       if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {
+                               qstats->q_ipackets[i] =3D rxq->pkts;
+                               qstats->q_ibytes[i] =3D rxq->bytes;
+                               qstats->q_errors[i] =3D rxq->errors + rxq->=
rx_mbuf_alloc_failed;
+                       }
                 } else {
                         PMD_DRV_LOG_LINE(DEBUG, "Rx queue not setup for po=
rt %d",
                                         dev->data->port_id);
@@ -1165,11 +1168,14 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
         for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
                 txq =3D dev->data->tx_queues[i];
                 if (txq) {
-                       stats->q_opackets[i] =3D txq->pkts;
                         stats->opackets +=3D txq->pkts;
-                       stats->q_obytes[i] =3D txq->bytes;
                         stats->obytes +=3D txq->bytes;
                         stats->oerrors +=3D txq->errors;
+
+                       if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {
+                               qstats->q_opackets[i] =3D txq->pkts;
+                               qstats->q_obytes[i] =3D txq->bytes;
+                       }
                 } else {
                         PMD_DRV_LOG_LINE(DEBUG, "Tx queue not setup for po=
rt %d",
                                         dev->data->port_id);
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_eth=
dev.h
index 5cd4317d7a..b94a7f3562 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -8,6 +8,7 @@

 #include <rte_mempool.h>
 #include <rte_lcore.h>
+#include <ethdev_driver.h>
 #include "axgbe_common.h"
 #include "rte_time.h"

diff --git a/drivers/net/bnx2x/bnx2x_ethdev.c b/drivers/net/bnx2x/bnx2x_eth=
dev.c
index 1327cbe912..5e2e555525 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.c
+++ b/drivers/net/bnx2x/bnx2x_ethdev.c
@@ -427,7 +427,8 @@ bnx2xvf_dev_link_update(struct rte_eth_dev *dev, __rte_=
unused int wait_to_comple
 }

 static int
-bnx2x_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+bnx2x_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats __rte_unused)
 {
         struct bnx2x_softc *sc =3D dev->data->dev_private;
         uint32_t brb_truncate_discard;
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index 6f5c3f80eb..bd3bfb8209 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -877,7 +877,7 @@ void bnxt_rep_tx_queue_release_op(struct rte_eth_dev *d=
ev, uint16_t queue_idx)
 }

 int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,
-                            struct rte_eth_stats *stats)
+                            struct rte_eth_stats *stats, struct eth_queue_=
stats *qstats)
 {
         struct bnxt_representor *rep_bp =3D eth_dev->data->dev_private;
         unsigned int i;
@@ -890,11 +890,13 @@ int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev=
,
                 stats->ipackets +=3D rep_bp->rx_pkts[i];
                 stats->imissed +=3D rep_bp->rx_drop_pkts[i];

-               stats->q_ipackets[i] =3D rep_bp->rx_pkts[i];
-               stats->q_ibytes[i] =3D rep_bp->rx_bytes[i];
-               stats->q_opackets[i] =3D rep_bp->tx_pkts[i];
-               stats->q_obytes[i] =3D rep_bp->tx_bytes[i];
-               stats->q_errors[i] =3D rep_bp->rx_drop_pkts[i];
+               if (qstats) {
+                       qstats->q_ipackets[i] =3D rep_bp->rx_pkts[i];
+                       qstats->q_ibytes[i] =3D rep_bp->rx_bytes[i];
+                       qstats->q_opackets[i] =3D rep_bp->tx_pkts[i];
+                       qstats->q_obytes[i] =3D rep_bp->tx_bytes[i];
+                       qstats->q_errors[i] =3D rep_bp->rx_drop_pkts[i];
+               }
         }

         return 0;
diff --git a/drivers/net/bnxt/bnxt_reps.h b/drivers/net/bnxt/bnxt_reps.h
index 3f2db9d1ae..1615ecf11c 100644
--- a/drivers/net/bnxt/bnxt_reps.h
+++ b/drivers/net/bnxt/bnxt_reps.h
@@ -47,7 +47,7 @@ void bnxt_rep_tx_queue_release_op(struct rte_eth_dev *dev=
, uint16_t queue_idx);
 int  bnxt_rep_dev_stop_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_dev_close_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,
-                            struct rte_eth_stats *stats);
+                            struct rte_eth_stats *stats, struct eth_queue_=
stats *qstats);
 int bnxt_rep_stats_reset_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_stop_all(struct bnxt *bp);
 #endif /* _BNXT_REPS_H_ */
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 9d7cdf925d..53f5613eb3 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -561,84 +561,95 @@ void bnxt_free_stats(struct bnxt *bp)

 static void bnxt_fill_rte_eth_stats_ext(struct rte_eth_stats *stats,
                                         struct bnxt_ring_stats_ext *ring_s=
tats,
+                                       struct eth_queue_stats *qstats,
                                         unsigned int i, bool rx)
 {
         if (rx) {
-               stats->q_ipackets[i] =3D ring_stats->rx_ucast_pkts;
-               stats->q_ipackets[i] +=3D ring_stats->rx_mcast_pkts;
-               stats->q_ipackets[i] +=3D ring_stats->rx_bcast_pkts;
-
-               stats->ipackets +=3D stats->q_ipackets[i];
-
-               stats->q_ibytes[i] =3D ring_stats->rx_ucast_bytes;
-               stats->q_ibytes[i] +=3D ring_stats->rx_mcast_bytes;
-               stats->q_ibytes[i] +=3D ring_stats->rx_bcast_bytes;
-
-               stats->ibytes +=3D stats->q_ibytes[i];
-
-               stats->q_errors[i] =3D ring_stats->rx_discard_pkts;
-               stats->q_errors[i] +=3D ring_stats->rx_error_pkts;
-
+               uint64_t ipackets =3D ring_stats->rx_ucast_pkts +
+                               ring_stats->rx_mcast_pkts +
+                               ring_stats->rx_bcast_pkts;
+               uint64_t ibytes =3D ring_stats->rx_ucast_bytes +
+                               ring_stats->rx_mcast_bytes +
+                               ring_stats->rx_bcast_bytes;
+               uint64_t ierrors =3D ring_stats->rx_discard_pkts +
+                               ring_stats->rx_error_pkts;
+
+               stats->ipackets +=3D ipackets;
+               stats->ibytes +=3D ibytes;
                 stats->imissed +=3D ring_stats->rx_discard_pkts;
                 stats->ierrors +=3D ring_stats->rx_error_pkts;
-       } else {
-               stats->q_opackets[i] =3D ring_stats->tx_ucast_pkts;
-               stats->q_opackets[i] +=3D ring_stats->tx_mcast_pkts;
-               stats->q_opackets[i] +=3D ring_stats->tx_bcast_pkts;
-
-               stats->opackets +=3D stats->q_opackets[i];
-
-               stats->q_obytes[i] =3D ring_stats->tx_ucast_bytes;
-               stats->q_obytes[i] +=3D ring_stats->tx_mcast_bytes;
-               stats->q_obytes[i] +=3D ring_stats->tx_bcast_bytes;
-
-               stats->obytes +=3D stats->q_obytes[i];

+               if (qstats) {
+                       qstats->q_ipackets[i] =3D ipackets;
+                       qstats->q_ibytes[i] =3D ibytes;
+                       qstats->q_errors[i] =3D ierrors;
+               }
+       } else {
+               uint64_t opackets =3D ring_stats->tx_ucast_pkts +
+                               ring_stats->tx_mcast_pkts +
+                               ring_stats->tx_bcast_pkts;
+               uint64_t obytes =3D ring_stats->tx_ucast_bytes +
+                               ring_stats->tx_mcast_bytes +
+                               ring_stats->tx_bcast_bytes;
+
+               stats->opackets +=3D opackets;
+               stats->obytes +=3D obytes;
                 stats->oerrors +=3D ring_stats->tx_discard_pkts;
+
+               if (qstats) {
+                       qstats->q_opackets[i] =3D opackets;
+                       qstats->q_obytes[i] =3D obytes;
+               }
         }
 }

 static void bnxt_fill_rte_eth_stats(struct rte_eth_stats *stats,
                                     struct bnxt_ring_stats *ring_stats,
+                                   struct eth_queue_stats *qstats,
                                     unsigned int i, bool rx)
 {
         if (rx) {
-               stats->q_ipackets[i] =3D ring_stats->rx_ucast_pkts;
-               stats->q_ipackets[i] +=3D ring_stats->rx_mcast_pkts;
-               stats->q_ipackets[i] +=3D ring_stats->rx_bcast_pkts;
-
-               stats->ipackets +=3D stats->q_ipackets[i];
-
-               stats->q_ibytes[i] =3D ring_stats->rx_ucast_bytes;
-               stats->q_ibytes[i] +=3D ring_stats->rx_mcast_bytes;
-               stats->q_ibytes[i] +=3D ring_stats->rx_bcast_bytes;
-
-               stats->ibytes +=3D stats->q_ibytes[i];
-
-               stats->q_errors[i] =3D ring_stats->rx_discard_pkts;
-               stats->q_errors[i] +=3D ring_stats->rx_error_pkts;
-
+               uint64_t ipackets =3D ring_stats->rx_ucast_pkts +
+                               ring_stats->rx_mcast_pkts +
+                               ring_stats->rx_bcast_pkts;
+               uint64_t ibytes =3D ring_stats->rx_ucast_bytes +
+                               ring_stats->rx_mcast_bytes +
+                               ring_stats->rx_bcast_bytes;
+               uint64_t ierrors =3D ring_stats->rx_discard_pkts +
+                               ring_stats->rx_error_pkts;
+
+               stats->ipackets +=3D ipackets;
+               stats->ibytes +=3D ibytes;
                 stats->imissed +=3D ring_stats->rx_discard_pkts;
                 stats->ierrors +=3D ring_stats->rx_error_pkts;
-       } else {
-               stats->q_opackets[i] =3D ring_stats->tx_ucast_pkts;
-               stats->q_opackets[i] +=3D ring_stats->tx_mcast_pkts;
-               stats->q_opackets[i] +=3D ring_stats->tx_bcast_pkts;
-
-               stats->opackets +=3D stats->q_opackets[i];
-
-               stats->q_obytes[i] =3D ring_stats->tx_ucast_bytes;
-               stats->q_obytes[i] +=3D ring_stats->tx_mcast_bytes;
-               stats->q_obytes[i] +=3D ring_stats->tx_bcast_bytes;
-
-               stats->obytes +=3D stats->q_obytes[i];

+               if (qstats) {
+                       qstats->q_ipackets[i] =3D ipackets;
+                       qstats->q_ibytes[i] =3D ibytes;
+                       qstats->q_errors[i] =3D ierrors;
+               }
+       } else {
+               uint64_t opackets =3D ring_stats->tx_ucast_pkts +
+                               ring_stats->tx_mcast_pkts +
+                               ring_stats->tx_bcast_pkts;
+               uint64_t obytes =3D ring_stats->tx_ucast_bytes +
+                               ring_stats->tx_mcast_bytes +
+                               ring_stats->tx_bcast_bytes;
+
+               stats->opackets +=3D opackets;
+               stats->obytes +=3D obytes;
                 stats->oerrors +=3D ring_stats->tx_discard_pkts;
+
+               if (qstats) {
+                       qstats->q_opackets[i] =3D opackets;
+                       qstats->q_obytes[i] =3D obytes;
+               }
         }
 }

 static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
-                                struct rte_eth_stats *bnxt_stats)
+                                struct rte_eth_stats *bnxt_stats,
+                                struct eth_queue_stats *qstats)
 {
         int rc =3D 0;
         unsigned int i;
@@ -661,7 +672,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_d=
ev,
                 if (unlikely(rc))
                         return rc;

-               bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, i, tru=
e);
+               bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, qstats=
, i, true);
                 bnxt_stats->rx_nombuf +=3D
                                 rte_atomic_load_explicit(&rxq->rx_mbuf_all=
oc_fail,
                                                          rte_memory_order_=
relaxed);
@@ -683,14 +694,14 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth=
_dev,
                 if (unlikely(rc))
                         return rc;

-               bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, i, fal=
se);
+               bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, qstats=
, i, false);
         }

         return rc;
 }

 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
-                     struct rte_eth_stats *bnxt_stats)
+                     struct rte_eth_stats *bnxt_stats, struct eth_queue_st=
ats *qstats)
 {
         int rc =3D 0;
         unsigned int i;
@@ -705,7 +716,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
                 return -EIO;

         if (BNXT_TPA_V2_P7(bp))
-               return bnxt_stats_get_ext(eth_dev, bnxt_stats);
+               return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);

         num_q_stats =3D RTE_MIN(bp->rx_cp_nr_rings,
                               (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
@@ -723,7 +734,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
                 if (unlikely(rc))
                         return rc;

-               bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, i, true);
+               bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, qstats, i,=
 true);
                 bnxt_stats->rx_nombuf +=3D
                                 rte_atomic_load_explicit(&rxq->rx_mbuf_all=
oc_fail,
                                                          rte_memory_order_=
relaxed);
@@ -745,7 +756,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
                 if (unlikely(rc))
                         return rc;

-               bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, i, false);
+               bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, qstats, i,=
 false);
                 bnxt_stats->oerrors +=3D
                                 rte_atomic_load_explicit(&txq->tx_mbuf_dro=
p,
                                                          rte_memory_order_=
relaxed);
diff --git a/drivers/net/bnxt/bnxt_stats.h b/drivers/net/bnxt/bnxt_stats.h
index e46c05eed3..c0508e773a 100644
--- a/drivers/net/bnxt/bnxt_stats.h
+++ b/drivers/net/bnxt/bnxt_stats.h
@@ -10,7 +10,7 @@

 void bnxt_free_stats(struct bnxt *bp);
 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
-                          struct rte_eth_stats *bnxt_stats);
+                          struct rte_eth_stats *bnxt_stats, struct eth_que=
ue_stats *qstats);
 int bnxt_stats_reset_op(struct rte_eth_dev *eth_dev);
 int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
         struct rte_eth_xstat_name *xstats_names,
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/r=
te_eth_bond_pmd.c
index 4906701a95..b7bab6bc99 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2636,11 +2636,12 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev,=
 int wait_to_complete)


 static int
-bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)
+bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,
+                     struct eth_queue_stats *qstats __rte_unused)
 {
         struct bond_dev_private *internals =3D dev->data->dev_private;
         struct rte_eth_stats member_stats;
-       int i, j;
+       int i;

         for (i =3D 0; i < internals->member_count; i++) {
                 rte_eth_stats_get(internals->members[i].port_id, &member_s=
tats);
@@ -2653,15 +2654,6 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struc=
t rte_eth_stats *stats)
                 stats->ierrors +=3D member_stats.ierrors;
                 stats->oerrors +=3D member_stats.oerrors;
                 stats->rx_nombuf +=3D member_stats.rx_nombuf;
-
-               for (j =3D 0; j < RTE_ETHDEV_QUEUE_STAT_CNTRS; j++) {
-                       stats->q_ipackets[j] +=3D member_stats.q_ipackets[j=
];
-                       stats->q_opackets[j] +=3D member_stats.q_opackets[j=
];
-                       stats->q_ibytes[j] +=3D member_stats.q_ibytes[j];
-                       stats->q_obytes[j] +=3D member_stats.q_obytes[j];
-                       stats->q_errors[j] +=3D member_stats.q_errors[j];
-               }
-
         }

         return 0;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.=
h
index 7868185768..67867c889b 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -682,7 +682,8 @@ int cnxk_nix_link_update(struct rte_eth_dev *eth_dev, i=
nt wait_to_complete);
 int cnxk_nix_queue_stats_mapping(struct rte_eth_dev *dev, uint16_t queue_i=
d,
                                  uint8_t stat_idx, uint8_t is_rx);
 int cnxk_nix_stats_reset(struct rte_eth_dev *dev);
-int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s);
+int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,
+                      struct eth_queue_stats *qstats);
 int cnxk_nix_xstats_get(struct rte_eth_dev *eth_dev,
                         struct rte_eth_xstat *xstats, unsigned int n);
 int cnxk_nix_xstats_get_names(struct rte_eth_dev *eth_dev,
diff --git a/drivers/net/cnxk/cnxk_rep.h b/drivers/net/cnxk/cnxk_rep.h
index b9601854ce..9ede1e6dad 100644
--- a/drivers/net/cnxk/cnxk_rep.h
+++ b/drivers/net/cnxk/cnxk_rep.h
@@ -130,7 +130,8 @@ void cnxk_rep_rx_queue_release(struct rte_eth_dev *dev,=
 uint16_t queue_idx);
 void cnxk_rep_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx=
);
 int cnxk_rep_dev_stop(struct rte_eth_dev *eth_dev);
 int cnxk_rep_dev_close(struct rte_eth_dev *eth_dev);
-int cnxk_rep_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *=
stats);
+int cnxk_rep_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *=
stats,
+                      struct eth_queue_stats *qstats);
 int cnxk_rep_stats_reset(struct rte_eth_dev *eth_dev);
 int cnxk_rep_flow_ops_get(struct rte_eth_dev *ethdev, const struct rte_flo=
w_ops **ops);
 int cnxk_rep_state_update(struct cnxk_eswitch_dev *eswitch_dev, uint32_t s=
tate, uint16_t *rep_id);
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_op=
s.c
index c88d28ff72..c481015592 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -574,7 +574,8 @@ native_repte_eth_stats(struct cnxk_rep_dev *rep_dev, st=
ruct rte_eth_stats *stats
 }

 int
-cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats=
)
+cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats=
,
+                  struct eth_queue_stats *qstats)
 {
         struct cnxk_rep_dev *rep_dev =3D cnxk_rep_pmd_priv(ethdev);
         struct rte_eth_stats vf_stats;
@@ -612,13 +613,15 @@ cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct=
 rte_eth_stats *stats)
                 rte_memcpy(&vf_stats, adata.u.data, adata.size);
         }

-       stats->q_ipackets[0] =3D vf_stats.ipackets;
-       stats->q_ibytes[0] =3D vf_stats.ibytes;
+       if (qstats !=3D NULL) {
+               qstats->q_ipackets[0] =3D vf_stats.ipackets;
+               qstats->q_ibytes[0] =3D vf_stats.ibytes;
+               qstats->q_opackets[0] =3D vf_stats.opackets;
+               qstats->q_obytes[0] =3D vf_stats.obytes;
+       }
+
         stats->ipackets =3D vf_stats.ipackets;
         stats->ibytes =3D vf_stats.ibytes;
-
-       stats->q_opackets[0] =3D vf_stats.opackets;
-       stats->q_obytes[0] =3D vf_stats.obytes;
         stats->opackets =3D vf_stats.opackets;
         stats->obytes =3D vf_stats.obytes;

diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index 469faff405..d57659ef51 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -8,7 +8,8 @@
 #define CNXK_NB_TXQ_STATS 4

 int
-cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stat=
s)
+cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stat=
s,
+                  struct eth_queue_stats *qstats)
 {
         struct cnxk_eth_dev *dev =3D cnxk_eth_pmd_priv(eth_dev);
         struct roc_nix *nix =3D &dev->nix;
@@ -32,28 +33,30 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct =
rte_eth_stats *stats)
         stats->ibytes =3D nix_stats.rx_octs;
         stats->ierrors =3D nix_stats.rx_err;

-       for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-               struct roc_nix_stats_queue qstats;
-               uint16_t qidx;
-
-               if (dev->txq_stat_map[i] & (1U << 31)) {
-                       qidx =3D dev->txq_stat_map[i] & 0xFFFF;
-                       rc =3D roc_nix_stats_queue_get(nix, qidx, 0, &qstat=
s);
-                       if (rc)
-                               goto exit;
-                       stats->q_opackets[i] =3D qstats.tx_pkts;
-                       stats->q_obytes[i] =3D qstats.tx_octs;
-                       stats->q_errors[i] =3D qstats.tx_drop_pkts;
-               }
-
-               if (dev->rxq_stat_map[i] & (1U << 31)) {
-                       qidx =3D dev->rxq_stat_map[i] & 0xFFFF;
-                       rc =3D roc_nix_stats_queue_get(nix, qidx, 1, &qstat=
s);
-                       if (rc)
-                               goto exit;
-                       stats->q_ipackets[i] =3D qstats.rx_pkts;
-                       stats->q_ibytes[i] =3D qstats.rx_octs;
-                       stats->q_errors[i] +=3D qstats.rx_drop_pkts;
+       if (qstats !=3D NULL) {
+               for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
+                       struct roc_nix_stats_queue qstats_data;
+                       uint16_t qidx;
+
+                       if (dev->txq_stat_map[i] & (1U << 31)) {
+                               qidx =3D dev->txq_stat_map[i] & 0xFFFF;
+                               rc =3D roc_nix_stats_queue_get(nix, qidx, 0=
, &qstats_data);
+                               if (rc)
+                                       goto exit;
+                               qstats->q_opackets[i] =3D qstats_data.tx_pk=
ts;
+                               qstats->q_obytes[i] =3D qstats_data.tx_octs=
;
+                               qstats->q_errors[i] =3D qstats_data.tx_drop=
_pkts;
+                       }
+
+                       if (dev->rxq_stat_map[i] & (1U << 31)) {
+                               qidx =3D dev->rxq_stat_map[i] & 0xFFFF;
+                               rc =3D roc_nix_stats_queue_get(nix, qidx, 1=
, &qstats_data);
+                               if (rc)
+                                       goto exit;
+                               qstats->q_ipackets[i] =3D qstats_data.rx_pk=
ts;
+                               qstats->q_ibytes[i] =3D qstats_data.rx_octs=
;
+                               qstats->q_errors[i] +=3D qstats_data.rx_dro=
p_pkts;
+                       }
                 }
         }
 exit:
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_eth=
dev.c
index 9b6a3651f9..0c337a6cc8 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -701,7 +701,8 @@ void cxgbe_dev_rx_queue_release(struct rte_eth_dev *eth=
_dev, uint16_t qid)
  * Get port statistics.
  */
 static int cxgbe_dev_stats_get(struct rte_eth_dev *eth_dev,
-                               struct rte_eth_stats *eth_stats)
+                               struct rte_eth_stats *eth_stats,
+                               struct eth_queue_stats *qstats __rte_unused=
)
 {
         struct port_info *pi =3D eth_dev->data->dev_private;
         struct adapter *adapter =3D pi->adapter;
diff --git a/drivers/net/cxgbe/cxgbevf_ethdev.c b/drivers/net/cxgbe/cxgbevf=
_ethdev.c
index a62c56c2b9..d8eba8afef 100644
--- a/drivers/net/cxgbe/cxgbevf_ethdev.c
+++ b/drivers/net/cxgbe/cxgbevf_ethdev.c
@@ -34,7 +34,8 @@
  * Get port statistics.
  */
 static int cxgbevf_dev_stats_get(struct rte_eth_dev *eth_dev,
-                                struct rte_eth_stats *eth_stats)
+                                struct rte_eth_stats *eth_stats,
+                                struct eth_queue_stats *qstats __rte_unuse=
d)
 {
         struct port_info *pi =3D eth_dev->data->dev_private;
         struct adapter *adapter =3D pi->adapter;
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.=
c
index 34b691fde7..789a55c2a0 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -855,7 +855,8 @@ static int dpaa_eth_link_update(struct rte_eth_dev *dev=
,
 }

 static int dpaa_eth_stats_get(struct rte_eth_dev *dev,
-                              struct rte_eth_stats *stats)
+                              struct rte_eth_stats *stats,
+                              struct eth_queue_stats *qstats __rte_unused)
 {
         PMD_INIT_FUNC_TRACE();

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_eth=
dev.c
index 41678ce09b..ada4a79b36 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1602,7 +1602,7 @@ dpaa2_dev_set_mac_addr(struct rte_eth_dev *dev,

 static int
 dpaa2_dev_stats_get(struct rte_eth_dev *dev,
-       struct rte_eth_stats *stats)
+       struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
         struct dpaa2_dev_priv *priv =3D dev->data->dev_private;
         struct fsl_mc_io *dpni =3D dev->process_private;
@@ -1659,18 +1659,20 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
         stats->imissed =3D value.page_2.ingress_nobuffer_discards;

         /* Fill in per queue stats */
-       for (i =3D 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-               (i < priv->nb_rx_queues || i < priv->nb_tx_queues); ++i) {
-               dpaa2_rxq =3D priv->rx_vq[i];
-               dpaa2_txq =3D priv->tx_vq[i];
-               if (dpaa2_rxq)
-                       stats->q_ipackets[i] =3D dpaa2_rxq->rx_pkts;
-               if (dpaa2_txq)
-                       stats->q_opackets[i] =3D dpaa2_txq->tx_pkts;
-
-               /* Byte counting is not implemented */
-               stats->q_ibytes[i]   =3D 0;
-               stats->q_obytes[i]   =3D 0;
+       if (qstats !=3D NULL) {
+               for (i =3D 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
+                       (i < priv->nb_rx_queues || i < priv->nb_tx_queues);=
 ++i) {
+                       dpaa2_rxq =3D priv->rx_vq[i];
+                       dpaa2_txq =3D priv->tx_vq[i];
+                       if (dpaa2_rxq)
+                               qstats->q_ipackets[i] =3D dpaa2_rxq->rx_pkt=
s;
+                       if (dpaa2_txq)
+                               qstats->q_opackets[i] =3D dpaa2_txq->tx_pkt=
s;
+
+                       /* Byte counting is not implemented */
+                       qstats->q_ibytes[i]   =3D 0;
+                       qstats->q_obytes[i]   =3D 0;
+               }
         }

         return 0;
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index f5cf5c3811..448de25fdc 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -9,6 +9,7 @@
 #include <rte_version.h>
 #include <rte_net.h>
 #include <rte_kvargs.h>
+#include <ethdev_driver.h>

 #include "ena_ethdev.h"
 #include "ena_logs.h"
@@ -270,7 +271,8 @@ static int ena_start(struct rte_eth_dev *dev);
 static int ena_stop(struct rte_eth_dev *dev);
 static int ena_close(struct rte_eth_dev *dev);
 static int ena_dev_reset(struct rte_eth_dev *dev);
-static int ena_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *st=
ats);
+static int ena_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *st=
ats,
+                         struct eth_queue_stats *qstats);
 static void ena_rx_queue_release_all(struct rte_eth_dev *dev);
 static void ena_tx_queue_release_all(struct rte_eth_dev *dev);
 static void ena_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
@@ -1240,7 +1242,8 @@ static void ena_stats_restart(struct rte_eth_dev *dev=
)
 }

 static int ena_stats_get(struct rte_eth_dev *dev,
-                         struct rte_eth_stats *stats)
+                         struct rte_eth_stats *stats,
+                         struct eth_queue_stats *qstats)
 {
         struct ena_admin_basic_stats ena_stats;
         struct ena_adapter *adapter =3D dev->data->dev_private;
@@ -1276,26 +1279,29 @@ static int ena_stats_get(struct rte_eth_dev *dev,
         stats->oerrors =3D rte_atomic64_read(&adapter->drv_stats->oerrors)=
;
         stats->rx_nombuf =3D rte_atomic64_read(&adapter->drv_stats->rx_nom=
buf);

-       max_rings_stats =3D RTE_MIN(dev->data->nb_rx_queues,
-               RTE_ETHDEV_QUEUE_STAT_CNTRS);
-       for (i =3D 0; i < max_rings_stats; ++i) {
-               struct ena_stats_rx *rx_stats =3D &adapter->rx_ring[i].rx_s=
tats;
-
-               stats->q_ibytes[i] =3D rx_stats->bytes;
-               stats->q_ipackets[i] =3D rx_stats->cnt;
-               stats->q_errors[i] =3D rx_stats->bad_desc_num +
-                       rx_stats->bad_req_id +
-                       rx_stats->bad_desc +
-                       rx_stats->unknown_error;
-       }
+       /* Queue statistics */
+       if (qstats) {
+               max_rings_stats =3D RTE_MIN(dev->data->nb_rx_queues,
+                       RTE_ETHDEV_QUEUE_STAT_CNTRS);
+               for (i =3D 0; i < max_rings_stats; ++i) {
+                       struct ena_stats_rx *rx_stats =3D &adapter->rx_ring=
[i].rx_stats;
+
+                       qstats->q_ibytes[i] =3D rx_stats->bytes;
+                       qstats->q_ipackets[i] =3D rx_stats->cnt;
+                       qstats->q_errors[i] =3D rx_stats->bad_desc_num +
+                               rx_stats->bad_req_id +
+                               rx_stats->bad_desc +
+                               rx_stats->unknown_error;
+               }

-       max_rings_stats =3D RTE_MIN(dev->data->nb_tx_queues,
-               RTE_ETHDEV_QUEUE_STAT_CNTRS);
-       for (i =3D 0; i < max_rings_stats; ++i) {
-               struct ena_stats_tx *tx_stats =3D &adapter->tx_ring[i].tx_s=
tats;
+               max_rings_stats =3D RTE_MIN(dev->data->nb_tx_queues,
+                       RTE_ETHDEV_QUEUE_STAT_CNTRS);
+               for (i =3D 0; i < max_rings_stats; ++i) {
+                       struct ena_stats_tx *tx_stats =3D &adapter->tx_ring=
[i].tx_stats;

-               stats->q_obytes[i] =3D tx_stats->bytes;
-               stats->q_opackets[i] =3D tx_stats->cnt;
+                       qstats->q_obytes[i] =3D tx_stats->bytes;
+                       qstats->q_opackets[i] =3D tx_stats->cnt;
+               }
         }

         return 0;
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_eth=
dev.c
index ffbecc407c..37a61f8ff6 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -4,6 +4,7 @@

 #include <stdbool.h>
 #include <ethdev_pci.h>
+#include <ethdev_driver.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>

@@ -543,7 +544,8 @@ enetc_rx_queue_release(struct rte_eth_dev *dev, uint16_=
t qid)

 static
 int enetc_stats_get(struct rte_eth_dev *dev,
-                   struct rte_eth_stats *stats)
+                   struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats __rte_unused)
 {
         struct enetc_eth_hw *hw =3D
                 ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_e=
thdev.c
index 7c2926409e..c336db75e8 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -314,7 +314,8 @@ enetfec_set_mac_address(struct rte_eth_dev *dev,

 static int
 enetfec_stats_get(struct rte_eth_dev *dev,
-             struct rte_eth_stats *stats)
+             struct rte_eth_stats *stats,
+             struct eth_queue_stats *qstats __rte_unused)
 {
         struct enetfec_private *fep =3D dev->data->dev_private;
         struct rte_eth_stats *eth_stats =3D &fep->stats;
diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index dc1d16f7d5..87f6b35fcd 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -419,7 +419,8 @@ int enic_disable(struct enic *enic);
 void enic_remove(struct enic *enic);
 int enic_get_link_status(struct enic *enic);
 int enic_dev_stats_get(struct enic *enic,
-                      struct rte_eth_stats *r_stats);
+                      struct rte_eth_stats *r_stats,
+                      struct eth_queue_stats *qstats __rte_unused);
 int enic_dev_stats_clear(struct enic *enic);
 int enic_add_packet_filter(struct enic *enic);
 int enic_set_mac_address(struct enic *enic, uint8_t *mac_addr);
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.=
c
index 749cc9ca5c..a853a5047a 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -432,12 +432,12 @@ static int enicpmd_dev_link_update(struct rte_eth_dev=
 *eth_dev,
 }

 static int enicpmd_dev_stats_get(struct rte_eth_dev *eth_dev,
-       struct rte_eth_stats *stats)
+       struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
         struct enic *enic =3D pmd_priv(eth_dev);

         ENICPMD_FUNC_TRACE();
-       return enic_dev_stats_get(enic, stats);
+       return enic_dev_stats_get(enic, stats, qstats);
 }

 static int enicpmd_dev_stats_reset(struct rte_eth_dev *eth_dev)
diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 4124c48b85..2696fa77d4 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -111,7 +111,8 @@ int enic_dev_stats_clear(struct enic *enic)
         return 0;
 }

-int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats)
+int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,
+                       struct eth_queue_stats *qstats __rte_unused)
 {
         struct vnic_stats *stats;
         struct enic_soft_stats *soft_stats =3D &enic->soft_stats;
diff --git a/drivers/net/enic/enic_vf_representor.c b/drivers/net/enic/enic=
_vf_representor.c
index 8469e06de9..05b2efedcb 100644
--- a/drivers/net/enic/enic_vf_representor.c
+++ b/drivers/net/enic/enic_vf_representor.c
@@ -419,13 +419,14 @@ static int enic_vf_link_update(struct rte_eth_dev *et=
h_dev,
 }

 static int enic_vf_stats_get(struct rte_eth_dev *eth_dev,
-       struct rte_eth_stats *stats)
+       struct rte_eth_stats *stats, struct eth_queue_stats *qstats __rte_u=
nused)
 {
         struct enic_vf_representor *vf;
         struct vnic_stats *vs;
         int err;

         ENICPMD_FUNC_TRACE();
+
         vf =3D eth_dev->data->dev_private;
         /* Get VF stats via PF */
         err =3D vnic_dev_stats_dump(vf->enic.vdev, &vs);
diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/f=
ailsafe_ether.c
index dc4aba6e30..f0fd662c7b 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -565,8 +565,6 @@ failsafe_eth_dev_state_sync(struct rte_eth_dev *dev)
 void
 failsafe_stats_increment(struct rte_eth_stats *to, struct rte_eth_stats *f=
rom)
 {
-       uint32_t i;
-
         RTE_ASSERT(to !=3D NULL && from !=3D NULL);
         to->ipackets +=3D from->ipackets;
         to->opackets +=3D from->opackets;
@@ -576,13 +574,6 @@ failsafe_stats_increment(struct rte_eth_stats *to, str=
uct rte_eth_stats *from)
         to->ierrors +=3D from->ierrors;
         to->oerrors +=3D from->oerrors;
         to->rx_nombuf +=3D from->rx_nombuf;
-       for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-               to->q_ipackets[i] +=3D from->q_ipackets[i];
-               to->q_opackets[i] +=3D from->q_opackets[i];
-               to->q_ibytes[i] +=3D from->q_ibytes[i];
-               to->q_obytes[i] +=3D from->q_obytes[i];
-               to->q_errors[i] +=3D from->q_errors[i];
-       }
 }

 int
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/fai=
lsafe_ops.c
index 5321c3385c..ddc8808ebe 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -898,7 +898,8 @@ fs_link_update(struct rte_eth_dev *dev,

 static int
 fs_stats_get(struct rte_eth_dev *dev,
-            struct rte_eth_stats *stats)
+            struct rte_eth_stats *stats,
+            struct eth_queue_stats *qstats __rte_unused)
 {
         struct rte_eth_stats backup;
         struct sub_device *sdev;
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 56e1a470b8..6341d89f39 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -10,6 +10,7 @@
 #include "gve_version.h"
 #include "rte_ether.h"
 #include "gve_rss.h"
+#include <ethdev_driver.h>

 static void
 gve_write_version(uint8_t *driver_version_register)
@@ -671,7 +672,8 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_et=
h_dev_info *dev_info)
 }

 static int
-gve_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+gve_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                 struct eth_queue_stats *qstats __rte_unused)
 {
         uint16_t i;
         if (gve_is_gqi(dev->data->dev_private))
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic=
_pmd_ethdev.c
index cb5c013b21..75534c1ce2 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -5,6 +5,7 @@
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <ethdev_pci.h>
+#include <ethdev_driver.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
@@ -1305,7 +1306,8 @@ static int hinic_set_dev_promiscuous(struct hinic_nic=
_dev *nic_dev, bool enable)
  *   negative error value otherwise.
  */
 static int
-hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats)
 {
         int i, err, q_num;
         u64 rx_discards_pmd =3D 0;
@@ -1326,29 +1328,45 @@ hinic_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)
         dev->data->rx_mbuf_alloc_failed =3D 0;

         /* rx queue stats */
-       q_num =3D (nic_dev->num_rq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-                       nic_dev->num_rq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
-       for (i =3D 0; i < q_num; i++) {
-               rxq =3D nic_dev->rxqs[i];
-               hinic_rxq_get_stats(rxq, &rxq_stats);
-               stats->q_ipackets[i] =3D rxq_stats.packets;
-               stats->q_ibytes[i] =3D rxq_stats.bytes;
-               stats->q_errors[i] =3D rxq_stats.rx_discards;
-
-               stats->ierrors +=3D rxq_stats.errors;
-               rx_discards_pmd +=3D rxq_stats.rx_discards;
-               dev->data->rx_mbuf_alloc_failed +=3D rxq_stats.rx_nombuf;
-       }
+       if (qstats) {
+               q_num =3D (nic_dev->num_rq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
+                               nic_dev->num_rq : RTE_ETHDEV_QUEUE_STAT_CNT=
RS;
+               for (i =3D 0; i < q_num; i++) {
+                       rxq =3D nic_dev->rxqs[i];
+                       hinic_rxq_get_stats(rxq, &rxq_stats);
+                       qstats->q_ipackets[i] =3D rxq_stats.packets;
+                       qstats->q_ibytes[i] =3D rxq_stats.bytes;
+                       qstats->q_errors[i] =3D rxq_stats.rx_discards;
+
+                       stats->ierrors +=3D rxq_stats.errors;
+                       rx_discards_pmd +=3D rxq_stats.rx_discards;
+                       dev->data->rx_mbuf_alloc_failed +=3D rxq_stats.rx_n=
ombuf;
+               }

-       /* tx queue stats */
-       q_num =3D (nic_dev->num_sq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-               nic_dev->num_sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
-       for (i =3D 0; i < q_num; i++) {
-               txq =3D nic_dev->txqs[i];
-               hinic_txq_get_stats(txq, &txq_stats);
-               stats->q_opackets[i] =3D txq_stats.packets;
-               stats->q_obytes[i] =3D txq_stats.bytes;
-               stats->oerrors +=3D (txq_stats.tx_busy + txq_stats.off_errs=
);
+               /* tx queue stats */
+               q_num =3D (nic_dev->num_sq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
+                       nic_dev->num_sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
+               for (i =3D 0; i < q_num; i++) {
+                       txq =3D nic_dev->txqs[i];
+                       hinic_txq_get_stats(txq, &txq_stats);
+                       qstats->q_opackets[i] =3D txq_stats.packets;
+                       qstats->q_obytes[i] =3D txq_stats.bytes;
+                       stats->oerrors +=3D (txq_stats.tx_busy + txq_stats.=
off_errs);
+               }
+       } else {
+               /* Still aggregate error stats even without qstats */
+               for (i =3D 0; i < nic_dev->num_rq; i++) {
+                       rxq =3D nic_dev->rxqs[i];
+                       hinic_rxq_get_stats(rxq, &rxq_stats);
+                       stats->ierrors +=3D rxq_stats.errors;
+                       rx_discards_pmd +=3D rxq_stats.rx_discards;
+                       dev->data->rx_mbuf_alloc_failed +=3D rxq_stats.rx_n=
ombuf;
+               }
+               for (i =3D 0; i < nic_dev->num_sq; i++) {
+                       txq =3D nic_dev->txqs[i];
+                       hinic_txq_get_stats(txq, &txq_stats);
+                       stats->oerrors +=3D (txq_stats.tx_busy + txq_stats.=
off_errs);
+               }
         }

         /* vport stats */
diff --git a/drivers/net/hns3/hns3_stats.c b/drivers/net/hns3/hns3_stats.c
index 9a1e8935e5..c8d5070a5b 100644
--- a/drivers/net/hns3/hns3_stats.c
+++ b/drivers/net/hns3/hns3_stats.c
@@ -3,6 +3,7 @@
  */

 #include <rte_ethdev.h>
+#include <ethdev_driver.h>
 #include <rte_io.h>
 #include <rte_malloc.h>

@@ -609,7 +610,8 @@ hns3_rcb_tx_ring_stats_get(struct hns3_tx_queue *txq,
  *   0 on success.
  */
 int
-hns3_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stat=
s)
+hns3_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stat=
s,
+              struct eth_queue_stats *qstats __rte_unused)
 {
         struct hns3_adapter *hns =3D eth_dev->data->dev_private;
         struct hns3_hw *hw =3D &hns->hw;
diff --git a/drivers/net/hns3/hns3_stats.h b/drivers/net/hns3/hns3_stats.h
index 74bc4173cc..511af430a3 100644
--- a/drivers/net/hns3/hns3_stats.h
+++ b/drivers/net/hns3/hns3_stats.h
@@ -151,7 +151,8 @@ struct hns3_reset_stats;
 struct hns3_hw;

 int hns3_stats_get(struct rte_eth_dev *eth_dev,
-                  struct rte_eth_stats *rte_stats);
+                  struct rte_eth_stats *rte_stats,
+                  struct eth_queue_stats *qstats);
 int hns3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xst=
ats,
                         unsigned int n);
 int hns3_dev_xstats_reset(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/=
cpfl_ethdev.c
index 6d7b23ad7a..ed6852f23d 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -311,7 +311,8 @@ cpfl_get_mbuf_alloc_failed_stats(struct rte_eth_dev *de=
v)
 }

 static int
-cpfl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+cpfl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct cpfl_vport *cpfl_vport =3D dev->data->dev_private;
         struct idpf_vport *vport =3D &cpfl_vport->base;
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/=
em_ethdev.c
index 39dddf3384..ec3924bf6b 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -42,7 +42,7 @@ static int eth_em_allmulticast_disable(struct rte_eth_dev=
 *dev);
 static int eth_em_link_update(struct rte_eth_dev *dev,
                                 int wait_to_complete);
 static int eth_em_stats_get(struct rte_eth_dev *dev,
-                               struct rte_eth_stats *rte_stats);
+                               struct rte_eth_stats *rte_stats, struct eth=
_queue_stats *qstats);
 static int eth_em_stats_reset(struct rte_eth_dev *dev);
 static int eth_em_infos_get(struct rte_eth_dev *dev,
                                 struct rte_eth_dev_info *dev_info);
@@ -926,7 +926,8 @@ em_hardware_init(struct e1000_hw *hw)

 /* This function is based on em_update_stats_counters() in e1000/if_em.c *=
/
 static int
-eth_em_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
+eth_em_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct e1000_hw *hw =3D E1000_DEV_PRIVATE_TO_HW(dev->data->dev_pri=
vate);
         struct e1000_hw_stats *stats =3D
@@ -1049,7 +1050,7 @@ eth_em_stats_reset(struct rte_eth_dev *dev)
                         E1000_DEV_PRIVATE_TO_STATS(dev->data->dev_private)=
;

         /* HW registers are cleared on read */
-       eth_em_stats_get(dev, NULL);
+       eth_em_stats_get(dev, NULL, NULL);

         /* Reset software totals */
         memset(hw_stats, 0, sizeof(*hw_stats));
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000=
/igb_ethdev.c
index 124cf75762..f4e2a6442e 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -86,7 +86,7 @@ static int  eth_igb_allmulticast_disable(struct rte_eth_d=
ev *dev);
 static int  eth_igb_link_update(struct rte_eth_dev *dev,
                                 int wait_to_complete);
 static int eth_igb_stats_get(struct rte_eth_dev *dev,
-                               struct rte_eth_stats *rte_stats);
+                               struct rte_eth_stats *rte_stats, struct eth=
_queue_stats *qstats);
 static int eth_igb_xstats_get(struct rte_eth_dev *dev,
                               struct rte_eth_xstat *xstats, unsigned n);
 static int eth_igb_xstats_get_by_id(struct rte_eth_dev *dev,
@@ -163,7 +163,7 @@ static int igbvf_allmulticast_enable(struct rte_eth_dev=
 *dev);
 static int igbvf_allmulticast_disable(struct rte_eth_dev *dev);
 static int eth_igbvf_link_update(struct e1000_hw *hw);
 static int eth_igbvf_stats_get(struct rte_eth_dev *dev,
-                               struct rte_eth_stats *rte_stats);
+                               struct rte_eth_stats *rte_stats, struct eth=
_queue_stats *qstats);
 static int eth_igbvf_xstats_get(struct rte_eth_dev *dev,
                                 struct rte_eth_xstat *xstats, unsigned n);
 static int eth_igbvf_xstats_get_names(struct rte_eth_dev *dev,
@@ -1943,7 +1943,8 @@ igb_read_stats_registers(struct e1000_hw *hw, struct =
e1000_hw_stats *stats)
 }

 static int
-eth_igb_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
)
+eth_igb_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct e1000_hw *hw =3D E1000_DEV_PRIVATE_TO_HW(dev->data->dev_pri=
vate);
         struct e1000_hw_stats *stats =3D
@@ -1976,7 +1977,7 @@ eth_igb_stats_reset(struct rte_eth_dev *dev)
                         E1000_DEV_PRIVATE_TO_STATS(dev->data->dev_private)=
;

         /* HW registers are cleared on read */
-       eth_igb_stats_get(dev, NULL);
+       eth_igb_stats_get(dev, NULL, NULL);

         /* Reset software totals */
         memset(hw_stats, 0, sizeof(*hw_stats));
@@ -2212,7 +2213,8 @@ eth_igbvf_xstats_get(struct rte_eth_dev *dev, struct =
rte_eth_xstat *xstats,
 }

 static int
-eth_igbvf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_sta=
ts)
+eth_igbvf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_sta=
ts,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct e1000_hw *hw =3D E1000_DEV_PRIVATE_TO_HW(dev->data->dev_pri=
vate);
         struct e1000_vf_stats *hw_stats =3D (struct e1000_vf_stats *)
@@ -2237,7 +2239,7 @@ eth_igbvf_stats_reset(struct rte_eth_dev *dev)
                         E1000_DEV_PRIVATE_TO_STATS(dev->data->dev_private)=
;

         /* Sync HW register to the last stats */
-       eth_igbvf_stats_get(dev, NULL);
+       eth_igbvf_stats_get(dev, NULL, NULL);

         /* reset HW current stats*/
         memset(&hw_stats->gprc, 0, sizeof(*hw_stats) -
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000=
/igc_ethdev.c
index 68444e4fba..b9c91d2446 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -226,7 +226,7 @@ static int eth_igc_allmulticast_enable(struct rte_eth_d=
ev *dev);
 static int eth_igc_allmulticast_disable(struct rte_eth_dev *dev);
 static int eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 static int eth_igc_stats_get(struct rte_eth_dev *dev,
-                       struct rte_eth_stats *rte_stats);
+                       struct rte_eth_stats *rte_stats, struct eth_queue_s=
tats *qstats);
 static int eth_igc_xstats_get(struct rte_eth_dev *dev,
                         struct rte_eth_xstat *xstats, unsigned int n);
 static int eth_igc_xstats_get_by_id(struct rte_eth_dev *dev,
@@ -2029,7 +2029,8 @@ igc_read_queue_stats_register(struct rte_eth_dev *dev=
)
 }

 static int
-eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
)
+eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
,
+               struct eth_queue_stats *qstats)
 {
         struct igc_adapter *igc =3D IGC_DEV_PRIVATE(dev);
         struct e1000_hw *hw =3D IGC_DEV_PRIVATE_HW(dev);
@@ -2068,19 +2069,21 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct r=
te_eth_stats *rte_stats)
         rte_stats->obytes   =3D stats->gotc;

         /* Get per-queue statuses */
-       for (i =3D 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
-               /* GET TX queue statuses */
-               int map_id =3D igc->txq_stats_map[i];
-               if (map_id >=3D 0) {
-                       rte_stats->q_opackets[map_id] +=3D queue_stats->pqg=
ptc[i];
-                       rte_stats->q_obytes[map_id] +=3D queue_stats->pqgot=
c[i];
-               }
-               /* Get RX queue statuses */
-               map_id =3D igc->rxq_stats_map[i];
-               if (map_id >=3D 0) {
-                       rte_stats->q_ipackets[map_id] +=3D queue_stats->pqg=
prc[i];
-                       rte_stats->q_ibytes[map_id] +=3D queue_stats->pqgor=
c[i];
-                       rte_stats->q_errors[map_id] +=3D queue_stats->rqdpc=
[i];
+       if (qstats) {
+               for (i =3D 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
+                       /* GET TX queue statuses */
+                       int map_id =3D igc->txq_stats_map[i];
+                       if (map_id >=3D 0) {
+                               qstats->q_opackets[map_id] +=3D queue_stats=
->pqgptc[i];
+                               qstats->q_obytes[map_id] +=3D queue_stats->=
pqgotc[i];
+                       }
+                       /* Get RX queue statuses */
+                       map_id =3D igc->rxq_stats_map[i];
+                       if (map_id >=3D 0) {
+                               qstats->q_ipackets[map_id] +=3D queue_stats=
->pqgprc[i];
+                               qstats->q_ibytes[map_id] +=3D queue_stats->=
pqgorc[i];
+                               qstats->q_errors[map_id] +=3D queue_stats->=
rqdpc[i];
+                       }
                 }
         }

diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm1=
0k/fm10k_ethdev.c
index 75ce2e19cf..bb05aecd97 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1314,7 +1314,8 @@ fm10k_xstats_get(struct rte_eth_dev *dev, struct rte_=
eth_xstat *xstats,
 }

 static int
-fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         uint64_t ipackets, opackets, ibytes, obytes, imissed;
         struct fm10k_hw *hw =3D
@@ -1329,17 +1330,19 @@ fm10k_stats_get(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)

         ipackets =3D opackets =3D ibytes =3D obytes =3D imissed =3D 0;
         for (i =3D 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-               (i < hw->mac.max_queues); ++i) {
-               stats->q_ipackets[i] =3D hw_stats->q[i].rx_packets.count;
-               stats->q_opackets[i] =3D hw_stats->q[i].tx_packets.count;
-               stats->q_ibytes[i]   =3D hw_stats->q[i].rx_bytes.count;
-               stats->q_obytes[i]   =3D hw_stats->q[i].tx_bytes.count;
-               stats->q_errors[i]   =3D hw_stats->q[i].rx_drops.count;
-               ipackets +=3D stats->q_ipackets[i];
-               opackets +=3D stats->q_opackets[i];
-               ibytes   +=3D stats->q_ibytes[i];
-               obytes   +=3D stats->q_obytes[i];
-               imissed  +=3D stats->q_errors[i];
+                       (i < hw->mac.max_queues); ++i) {
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D hw_stats->q[i].rx_packets=
.count;
+                       qstats->q_opackets[i] =3D hw_stats->q[i].tx_packets=
.count;
+                       qstats->q_ibytes[i]   =3D hw_stats->q[i].rx_bytes.c=
ount;
+                       qstats->q_obytes[i]   =3D hw_stats->q[i].tx_bytes.c=
ount;
+                       qstats->q_errors[i]   =3D hw_stats->q[i].rx_drops.c=
ount;
+               }
+               ipackets +=3D hw_stats->q[i].rx_packets.count;
+               opackets +=3D hw_stats->q[i].tx_packets.count;
+               ibytes   +=3D hw_stats->q[i].rx_bytes.count;
+               obytes   +=3D hw_stats->q[i].tx_bytes.count;
+               imissed  +=3D hw_stats->q[i].rx_drops.count;
         }
         stats->ipackets =3D ipackets;
         stats->opackets =3D opackets;
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/=
i40e_ethdev.c
index 7a562a6e0b..b8ce79061b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -256,7 +256,7 @@ static int i40e_dev_allmulticast_disable(struct rte_eth=
_dev *dev);
 static int i40e_dev_set_link_up(struct rte_eth_dev *dev);
 static int i40e_dev_set_link_down(struct rte_eth_dev *dev);
 static int i40e_dev_stats_get(struct rte_eth_dev *dev,
-                              struct rte_eth_stats *stats);
+                              struct rte_eth_stats *stats,      struct eth=
_queue_stats *qstats);
 static int i40e_dev_xstats_get(struct rte_eth_dev *dev,
                                struct rte_eth_xstat *xstats, unsigned n);
 static int i40e_dev_xstats_get_names(struct rte_eth_dev *dev,
@@ -3474,7 +3474,8 @@ i40e_read_stats_registers(struct i40e_pf *pf, struct =
i40e_hw *hw)

 /* Get all statistics of a port */
 static int
-i40e_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+i40e_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct i40e_pf *pf =3D I40E_DEV_PRIVATE_TO_PF(dev->data->dev_priva=
te);
         struct i40e_hw *hw =3D I40E_DEV_PRIVATE_TO_HW(dev->data->dev_priva=
te);
diff --git a/drivers/net/intel/i40e/i40e_vf_representor.c b/drivers/net/int=
el/i40e/i40e_vf_representor.c
index c00ae832aa..e8f0bb62a0 100644
--- a/drivers/net/intel/i40e/i40e_vf_representor.c
+++ b/drivers/net/intel/i40e/i40e_vf_representor.c
@@ -209,7 +209,7 @@ rte_pmd_i40e_get_vf_native_stats(uint16_t port,

 static int
 i40e_vf_representor_stats_get(struct rte_eth_dev *ethdev,
-               struct rte_eth_stats *stats)
+               struct rte_eth_stats *stats, struct eth_queue_stats *qstats=
 __rte_unused)
 {
         struct i40e_vf_representor *representor =3D ethdev->data->dev_priv=
ate;
         struct i40e_eth_stats native_stats;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/=
iavf_ethdev.c
index 08c814725d..56bc6480e5 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -105,7 +105,7 @@ static int iavf_dev_info_get(struct rte_eth_dev *dev,
 static const uint32_t *iavf_dev_supported_ptypes_get(struct rte_eth_dev *d=
ev,
                                                      size_t *no_of_element=
s);
 static int iavf_dev_stats_get(struct rte_eth_dev *dev,
-                            struct rte_eth_stats *stats);
+                            struct rte_eth_stats *stats, struct eth_queue_=
stats *qstats);
 static int iavf_dev_stats_reset(struct rte_eth_dev *dev);
 static int iavf_dev_xstats_reset(struct rte_eth_dev *dev);
 static int iavf_dev_xstats_get(struct rte_eth_dev *dev,
@@ -1798,7 +1798,8 @@ iavf_update_stats(struct iavf_vsi *vsi, struct virtch=
nl_eth_stats *nes)
 }

 static int
-iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct iavf_adapter *adapter =3D
                 IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice=
/ice_dcf_ethdev.c
index 499062be40..81da5a4656 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1514,7 +1514,8 @@ ice_dcf_update_stats(struct virtchnl_eth_stats *oes,


 static int
-ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct ice_dcf_adapter *ad =3D dev->data->dev_private;
         struct ice_dcf_hw *hw =3D &ad->real_hw;
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice=
_ethdev.c
index 31f1419897..cdc4943667 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -161,7 +161,7 @@ static int ice_get_module_info(struct rte_eth_dev *dev,
 static int ice_get_module_eeprom(struct rte_eth_dev *dev,
                                  struct rte_dev_eeprom_info *info);
 static int ice_stats_get(struct rte_eth_dev *dev,
-                        struct rte_eth_stats *stats);
+                        struct rte_eth_stats *stats, struct eth_queue_stat=
s *qstats);
 static int ice_stats_reset(struct rte_eth_dev *dev);
 static int ice_xstats_get(struct rte_eth_dev *dev,
                           struct rte_eth_xstat *xstats, unsigned int n);
@@ -6340,7 +6340,8 @@ ice_read_stats_registers(struct ice_pf *pf, struct ic=
e_hw *hw)

 /* Get all statistics of a port */
 static int
-ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private=
);
         struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private=
);
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/=
idpf_ethdev.c
index 90720909bf..3c505e882a 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -268,7 +268,8 @@ idpf_get_mbuf_alloc_failed_stats(struct rte_eth_dev *de=
v)
 }

 static int
-idpf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+idpf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct idpf_vport *vport =3D
                 (struct idpf_vport *)dev->data->dev_private;
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c
index c5aca0ea8f..cd34d08055 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -2119,7 +2119,8 @@ ipn3ke_rpst_stats_reset(struct rte_eth_dev *ethdev)

 static int
 ipn3ke_rpst_stats_get
-(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats)
+(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         uint16_t port_id =3D 0;
         char *ch;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixg=
be/ixgbe_ethdev.c
index 4f0343245e..7e1278c026 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -164,7 +164,7 @@ static int ixgbe_dev_allmulticast_disable(struct rte_et=
h_dev *dev);
 static int ixgbe_dev_link_update(struct rte_eth_dev *dev,
                                 int wait_to_complete);
 static int ixgbe_dev_stats_get(struct rte_eth_dev *dev,
-                               struct rte_eth_stats *stats);
+                               struct rte_eth_stats *stats, struct eth_que=
ue_stats *qstats);
 static int ixgbe_dev_xstats_get(struct rte_eth_dev *dev,
                                 struct rte_eth_xstat *xstats, unsigned n);
 static int ixgbevf_dev_xstats_get(struct rte_eth_dev *dev,
@@ -265,7 +265,7 @@ static int  ixgbevf_dev_reset(struct rte_eth_dev *dev);
 static void ixgbevf_intr_disable(struct rte_eth_dev *dev);
 static void ixgbevf_intr_enable(struct rte_eth_dev *dev);
 static int ixgbevf_dev_stats_get(struct rte_eth_dev *dev,
-               struct rte_eth_stats *stats);
+               struct rte_eth_stats *stats, struct eth_queue_stats *qstats=
);
 static int ixgbevf_dev_stats_reset(struct rte_eth_dev *dev);
 static int ixgbevf_vlan_filter_set(struct rte_eth_dev *dev,
                 uint16_t vlan_id, int on);
@@ -3398,7 +3398,7 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
  * This function is based on ixgbe_update_stats_counters() in ixgbe/ixgbe.=
c
  */
 static int
-ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, =
struct eth_queue_stats *qstats)
 {
         struct ixgbe_hw *hw =3D
                         IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -3427,13 +3427,15 @@ ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)
         stats->opackets =3D hw_stats->gptc;
         stats->obytes =3D hw_stats->gotc;

-       for (i =3D 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
-                       RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
-               stats->q_ipackets[i] =3D hw_stats->qprc[i];
-               stats->q_opackets[i] =3D hw_stats->qptc[i];
-               stats->q_ibytes[i] =3D hw_stats->qbrc[i];
-               stats->q_obytes[i] =3D hw_stats->qbtc[i];
-               stats->q_errors[i] =3D hw_stats->qprdc[i];
+       if (qstats !=3D NULL) {
+               for (i =3D 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
+                               RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i+=
+) {
+                       qstats->q_ipackets[i] =3D hw_stats->qprc[i];
+                       qstats->q_opackets[i] =3D hw_stats->qptc[i];
+                       qstats->q_ibytes[i] =3D hw_stats->qbrc[i];
+                       qstats->q_obytes[i] =3D hw_stats->qbtc[i];
+                       qstats->q_errors[i] =3D hw_stats->qprdc[i];
+               }
         }

         /* Rx Errors */
@@ -3468,7 +3470,7 @@ ixgbe_dev_stats_reset(struct rte_eth_dev *dev)
                         IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_private)=
;

         /* HW registers are cleared on read */
-       ixgbe_dev_stats_get(dev, NULL);
+       ixgbe_dev_stats_get(dev, NULL, NULL);

         /* Reset software totals */
         memset(stats, 0, sizeof(*stats));
@@ -3887,7 +3889,8 @@ ixgbevf_dev_xstats_get(struct rte_eth_dev *dev, struc=
t rte_eth_xstat *xstats,
 }

 static int
-ixgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)
+ixgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct ixgbevf_hw_stats *hw_stats =3D (struct ixgbevf_hw_stats *)
                           IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_privat=
e);
@@ -3911,7 +3914,7 @@ ixgbevf_dev_stats_reset(struct rte_eth_dev *dev)
                         IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_private)=
;

         /* Sync HW register to the last stats */
-       ixgbevf_dev_stats_get(dev, NULL);
+       ixgbevf_dev_stats_get(dev, NULL, NULL);

         /* reset HW current stats*/
         hw_stats->vfgprc =3D 0;
diff --git a/drivers/net/ionic/ionic_ethdev.c b/drivers/net/ionic/ionic_eth=
dev.c
index aa22b6a70d..6e9cd5f7eb 100644
--- a/drivers/net/ionic/ionic_ethdev.c
+++ b/drivers/net/ionic/ionic_ethdev.c
@@ -39,7 +39,7 @@ static int  ionic_dev_rss_hash_conf_get(struct rte_eth_de=
v *eth_dev,
 static int  ionic_dev_rss_hash_update(struct rte_eth_dev *eth_dev,
         struct rte_eth_rss_conf *rss_conf);
 static int  ionic_dev_stats_get(struct rte_eth_dev *eth_dev,
-       struct rte_eth_stats *stats);
+       struct rte_eth_stats *stats, struct eth_queue_stats *queue_stats);
 static int  ionic_dev_stats_reset(struct rte_eth_dev *eth_dev);
 static int  ionic_dev_xstats_get(struct rte_eth_dev *dev,
         struct rte_eth_xstat *xstats, unsigned int n);
@@ -722,11 +722,11 @@ ionic_dev_rss_hash_update(struct rte_eth_dev *eth_dev=
,

 static int
 ionic_dev_stats_get(struct rte_eth_dev *eth_dev,
-               struct rte_eth_stats *stats)
+               struct rte_eth_stats *stats, struct eth_queue_stats *qstats=
)
 {
         struct ionic_lif *lif =3D IONIC_ETH_DEV_TO_LIF(eth_dev);

-       ionic_lif_get_stats(lif, stats);
+       ionic_lif_get_stats(lif, stats, qstats);

         return 0;
 }
diff --git a/drivers/net/ionic/ionic_lif.c b/drivers/net/ionic/ionic_lif.c
index b4dc118fef..b52c8cad88 100644
--- a/drivers/net/ionic/ionic_lif.c
+++ b/drivers/net/ionic/ionic_lif.c
@@ -100,7 +100,8 @@ ionic_lif_reset(struct ionic_lif *lif)
 }

 static void
-ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats =
*stats)
+ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats =
*stats,
+               struct eth_queue_stats *qstats)
 {
         struct ionic_lif_stats *ls =3D &lif->info->stats;
         uint32_t i;
@@ -144,13 +145,15 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, =
struct rte_eth_stats *stats
                 ls->rx_desc_fetch_error +
                 ls->rx_desc_data_error;

-       for (i =3D 0; i < num_rx_q_counters; i++) {
-               struct ionic_rx_stats *rx_stats =3D &lif->rxqcqs[i]->stats;
-               stats->q_ipackets[i] =3D rx_stats->packets;
-               stats->q_ibytes[i] =3D rx_stats->bytes;
-               stats->q_errors[i] =3D
-                       rx_stats->bad_cq_status +
-                       rx_stats->bad_len;
+       if (qstats !=3D NULL) {
+               for (i =3D 0; i < num_rx_q_counters; i++) {
+                       struct ionic_rx_stats *rx_stats =3D &lif->rxqcqs[i]=
->stats;
+                       qstats->q_ipackets[i] =3D rx_stats->packets;
+                       qstats->q_ibytes[i] =3D rx_stats->bytes;
+                       qstats->q_errors[i] =3D
+                               rx_stats->bad_cq_status +
+                               rx_stats->bad_len;
+               }
         }

         /* TX */
@@ -179,18 +182,20 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, =
struct rte_eth_stats *stats
                 ls->tx_desc_fetch_error +
                 ls->tx_desc_data_error;

-       for (i =3D 0; i < num_tx_q_counters; i++) {
-               struct ionic_tx_stats *tx_stats =3D &lif->txqcqs[i]->stats;
-               stats->q_opackets[i] =3D tx_stats->packets;
-               stats->q_obytes[i] =3D tx_stats->bytes;
+       if (qstats !=3D NULL) {
+               for (i =3D 0; i < num_tx_q_counters; i++) {
+                       struct ionic_tx_stats *tx_stats =3D &lif->txqcqs[i]=
->stats;
+                       qstats->q_opackets[i] =3D tx_stats->packets;
+                       qstats->q_obytes[i] =3D tx_stats->bytes;
+               }
         }
 }

 void
 ionic_lif_get_stats(const struct ionic_lif *lif,
-               struct rte_eth_stats *stats)
+               struct rte_eth_stats *stats, struct eth_queue_stats *qstats=
)
 {
-       ionic_lif_get_abs_stats(lif, stats);
+       ionic_lif_get_abs_stats(lif, stats, qstats);

         stats->ipackets  -=3D lif->stats_base.ipackets;
         stats->opackets  -=3D lif->stats_base.opackets;
@@ -214,7 +219,7 @@ ionic_lif_reset_stats(struct ionic_lif *lif)
                         sizeof(struct ionic_tx_stats));
         }

-       ionic_lif_get_abs_stats(lif, &lif->stats_base);
+       ionic_lif_get_abs_stats(lif, &lif->stats_base, NULL);
 }

 void
diff --git a/drivers/net/ionic/ionic_lif.h b/drivers/net/ionic/ionic_lif.h
index f4a1b9937e..2d85ebbcae 100644
--- a/drivers/net/ionic/ionic_lif.h
+++ b/drivers/net/ionic/ionic_lif.h
@@ -9,6 +9,7 @@

 #include <rte_ethdev.h>
 #include <rte_ether.h>
+#include <ethdev_driver.h>

 #include "ionic.h"
 #include "ionic_dev.h"
@@ -244,7 +245,7 @@ int ionic_lif_rss_config(struct ionic_lif *lif, const u=
int16_t types,
 int ionic_lif_set_features(struct ionic_lif *lif);

 void ionic_lif_get_stats(const struct ionic_lif *lif,
-       struct rte_eth_stats *stats);
+       struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 void ionic_lif_reset_stats(struct ionic_lif *lif);

 void ionic_lif_get_hw_stats(struct ionic_lif *lif,
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 48e44bfafc..b7ae01b152 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -645,7 +645,8 @@ mana_dev_link_update(struct rte_eth_dev *dev,
 }

 static int
-mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                  struct eth_queue_stats *qstats)
 {
         unsigned int i;

@@ -659,9 +660,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)
                 stats->obytes +=3D txq->stats.bytes;
                 stats->oerrors +=3D txq->stats.errors;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] =3D txq->stats.packets;
-                       stats->q_obytes[i] =3D txq->stats.bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D txq->stats.packets;
+                       qstats->q_obytes[i] =3D txq->stats.bytes;
                 }
         }

@@ -678,9 +679,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)

                 /* There is no good way to get stats->imissed, not setting=
 it */

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D rxq->stats.packets;
-                       stats->q_ibytes[i] =3D rxq->stats.bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D rxq->stats.packets;
+                       qstats->q_ibytes[i] =3D rxq->stats.bytes;
                 }

                 stats->rx_nombuf +=3D rxq->stats.nombuf;
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_=
memif.c
index f7b04c4f9e..9de6f97cd9 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1578,7 +1578,8 @@ memif_link_update(struct rte_eth_dev *dev,
 }

 static int
-memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         struct pmd_internals *pmd =3D dev->data->dev_private;
         struct memif_queue *mq;
@@ -1598,8 +1599,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)
         /* RX stats */
         for (i =3D 0; i < nq; i++) {
                 mq =3D dev->data->rx_queues[i];
-               stats->q_ipackets[i] =3D mq->n_pkts;
-               stats->q_ibytes[i] =3D mq->n_bytes;
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D mq->n_pkts;
+                       qstats->q_ibytes[i] =3D mq->n_bytes;
+               }
                 stats->ipackets +=3D mq->n_pkts;
                 stats->ibytes +=3D mq->n_bytes;
         }
@@ -1612,8 +1615,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)
         /* TX stats */
         for (i =3D 0; i < nq; i++) {
                 mq =3D dev->data->tx_queues[i];
-               stats->q_opackets[i] =3D mq->n_pkts;
-               stats->q_obytes[i] =3D mq->n_bytes;
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[i] =3D mq->n_pkts;
+                       qstats->q_obytes[i] =3D mq->n_bytes;
+               }
                 stats->opackets +=3D mq->n_pkts;
                 stats->obytes +=3D mq->n_bytes;
         }
diff --git a/drivers/net/mlx4/mlx4.h b/drivers/net/mlx4/mlx4.h
index c992a1c5ea..f68eeb991a 100644
--- a/drivers/net/mlx4/mlx4.h
+++ b/drivers/net/mlx4/mlx4.h
@@ -219,7 +219,8 @@ int mlx4_mac_addr_set(struct rte_eth_dev *dev, struct r=
te_ether_addr *mac_addr);
 int mlx4_set_mc_addr_list(struct rte_eth_dev *dev, struct rte_ether_addr *=
list,
                           uint32_t num);
 int mlx4_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on=
);
-int mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                  struct eth_queue_stats *qstats);
 int mlx4_stats_reset(struct rte_eth_dev *dev);
 int mlx4_fw_version_get(struct rte_eth_dev *dev, char *fw_ver, size_t fw_s=
ize);
 int mlx4_dev_infos_get(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx4/mlx4_ethdev.c b/drivers/net/mlx4/mlx4_ethdev.=
c
index f11c6b4373..efc6ee4577 100644
--- a/drivers/net/mlx4/mlx4_ethdev.c
+++ b/drivers/net/mlx4/mlx4_ethdev.c
@@ -702,7 +702,8 @@ int mlx4_fw_version_get(struct rte_eth_dev *dev, char *=
fw_ver, size_t fw_size)
  *   Stats structure output buffer.
  */
 int
-mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+              struct eth_queue_stats *qstats)
 {
         struct rte_eth_stats tmp;
         unsigned int i;
@@ -716,10 +717,10 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *stats)
                 if (rxq =3D=3D NULL)
                         continue;
                 idx =3D rxq->stats.idx;
-               if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       tmp.q_ipackets[idx] +=3D rxq->stats.ipackets;
-                       tmp.q_ibytes[idx] +=3D rxq->stats.ibytes;
-                       tmp.q_errors[idx] +=3D (rxq->stats.idropped +
+               if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) =
{
+                       qstats->q_ipackets[idx] +=3D rxq->stats.ipackets;
+                       qstats->q_ibytes[idx] +=3D rxq->stats.ibytes;
+                       qstats->q_errors[idx] +=3D (rxq->stats.idropped +
                                               rxq->stats.rx_nombuf);
                 }
                 tmp.ipackets +=3D rxq->stats.ipackets;
@@ -733,9 +734,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_=
stats *stats)
                 if (txq =3D=3D NULL)
                         continue;
                 idx =3D txq->stats.idx;
-               if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       tmp.q_opackets[idx] +=3D txq->stats.opackets;
-                       tmp.q_obytes[idx] +=3D txq->stats.obytes;
+               if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) =
{
+                       qstats->q_opackets[idx] +=3D txq->stats.opackets;
+                       qstats->q_obytes[idx] +=3D txq->stats.obytes;
                 }
                 tmp.opackets +=3D txq->stats.opackets;
                 tmp.obytes +=3D txq->stats.obytes;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 93e298d648..e7fd4066ba 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2418,7 +2418,8 @@ int mlx5_allmulticast_disable(struct rte_eth_dev *dev=
);

 /* mlx5_stats.c */

-int mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                  struct eth_queue_stats *qstats);
 int mlx5_stats_reset(struct rte_eth_dev *dev);
 int mlx5_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *stats,
                     unsigned int n);
diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.c
index ebc6f9fb53..5cd3e303cc 100644
--- a/drivers/net/mlx5/mlx5_stats.c
+++ b/drivers/net/mlx5/mlx5_stats.c
@@ -208,7 +208,8 @@ mlx5_xstats_get(struct rte_eth_dev *dev, struct rte_eth=
_xstat *stats,
  *   rte_errno is set.
  */
 int
-mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+              struct eth_queue_stats *qstats)
 {
         struct mlx5_priv *priv =3D dev->data->dev_private;
         struct mlx5_stats_ctrl *stats_ctrl =3D &priv->stats_ctrl;
@@ -226,14 +227,14 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *stats)
                 if (rxq =3D=3D NULL)
                         continue;
                 idx =3D rxq->idx;
-               if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+               if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) =
{
 #ifdef MLX5_PMD_SOFT_COUNTERS
-                       tmp.q_ipackets[idx] +=3D rxq->stats.ipackets -
+                       qstats->q_ipackets[idx] +=3D rxq->stats.ipackets -
                                 rxq->stats_reset.ipackets;
-                       tmp.q_ibytes[idx] +=3D rxq->stats.ibytes -
+                       qstats->q_ibytes[idx] +=3D rxq->stats.ibytes -
                                 rxq->stats_reset.ibytes;
 #endif
-                       tmp.q_errors[idx] +=3D (rxq->stats.idropped +
+                       qstats->q_errors[idx] +=3D (rxq->stats.idropped +
                                               rxq->stats.rx_nombuf) -
                                               (rxq->stats_reset.idropped +
                                               rxq->stats_reset.rx_nombuf);
@@ -252,11 +253,11 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *stats)
                 if (txq =3D=3D NULL)
                         continue;
                 idx =3D txq->idx;
-               if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+               if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) =
{
 #ifdef MLX5_PMD_SOFT_COUNTERS
-                       tmp.q_opackets[idx] +=3D txq->stats.opackets -
+                       qstats->q_opackets[idx] +=3D txq->stats.opackets -
                                                 txq->stats_reset.opackets;
-                       tmp.q_obytes[idx] +=3D txq->stats.obytes -
+                       qstats->q_obytes[idx] +=3D txq->stats.obytes -
                                                 txq->stats_reset.obytes;
 #endif
                 }
diff --git a/drivers/net/mvneta/mvneta_ethdev.c b/drivers/net/mvneta/mvneta=
_ethdev.c
index f99f9e6289..eef9758224 100644
--- a/drivers/net/mvneta/mvneta_ethdev.c
+++ b/drivers/net/mvneta/mvneta_ethdev.c
@@ -712,7 +712,8 @@ mvneta_mac_addr_set(struct rte_eth_dev *dev, struct rte=
_ether_addr *mac_addr)
  *   0 on success, negative error value otherwise.
  */
 static int
-mvneta_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mvneta_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                struct eth_queue_stats *qstats __rte_unused)
 {
         struct mvneta_priv *priv =3D dev->data->dev_private;
         struct neta_ppio_statistics ppio_stats;
@@ -765,7 +766,7 @@ mvneta_stats_reset(struct rte_eth_dev *dev)
         if (!priv->ppio)
                 return 0;

-       ret =3D mvneta_stats_get(dev, &priv->prev_stats);
+       ret =3D mvneta_stats_get(dev, &priv->prev_stats, NULL);
         if (unlikely(ret))
                 MVNETA_LOG(ERR, "Failed to reset port statistics");

diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethde=
v.c
index 4200c11d46..845819e4d8 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -1486,7 +1486,8 @@ mrvl_mac_addr_set(struct rte_eth_dev *dev, struct rte=
_ether_addr *mac_addr)
  *   0 on success, negative error value otherwise.
  */
 static int
-mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+              struct eth_queue_stats *qstats)
 {
         struct mrvl_priv *priv =3D dev->data->dev_private;
         struct pp2_ppio_statistics ppio_stats;
@@ -1521,12 +1522,14 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)
                         break;
                 }

-               stats->q_ibytes[idx] =3D rxq->bytes_recv;
-               stats->q_ipackets[idx] =3D rx_stats.enq_desc - rxq->drop_ma=
c;
-               stats->q_errors[idx] =3D rx_stats.drop_early +
-                                      rx_stats.drop_fullq +
-                                      rx_stats.drop_bm +
-                                      rxq->drop_mac;
+               if (qstats !=3D NULL) {
+                       qstats->q_ibytes[idx] =3D rxq->bytes_recv;
+                       qstats->q_ipackets[idx] =3D rx_stats.enq_desc - rxq=
->drop_mac;
+                       qstats->q_errors[idx] =3D rx_stats.drop_early +
+                                              rx_stats.drop_fullq +
+                                              rx_stats.drop_bm +
+                                              rxq->drop_mac;
+               }
                 stats->ibytes +=3D rxq->bytes_recv;
                 drop_mac +=3D rxq->drop_mac;
         }
@@ -1553,8 +1556,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats)
                         break;
                 }

-               stats->q_opackets[idx] =3D tx_stats.deq_desc;
-               stats->q_obytes[idx] =3D txq->bytes_sent;
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[idx] =3D tx_stats.deq_desc;
+                       qstats->q_obytes[idx] =3D txq->bytes_sent;
+               }
                 stats->obytes +=3D txq->bytes_sent;
         }

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.=
c
index 1d788f3fb7..a31aac1a8a 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -817,11 +817,12 @@ static int hn_dev_configure(struct rte_eth_dev *dev)
 }

 static int hn_dev_stats_get(struct rte_eth_dev *dev,
-                           struct rte_eth_stats *stats)
+                           struct rte_eth_stats *stats,
+                           struct eth_queue_stats *qstats)
 {
         unsigned int i;

-       hn_vf_stats_get(dev, stats);
+       hn_vf_stats_get(dev, stats, qstats);

         for (i =3D 0; i < dev->data->nb_tx_queues; i++) {
                 const struct hn_tx_queue *txq =3D dev->data->tx_queues[i];
@@ -833,9 +834,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
                 stats->obytes +=3D txq->stats.bytes;
                 stats->oerrors +=3D txq->stats.errors;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] +=3D txq->stats.packets;
-                       stats->q_obytes[i] +=3D txq->stats.bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] +=3D txq->stats.packets;
+                       qstats->q_obytes[i] +=3D txq->stats.bytes;
                 }
         }

@@ -850,9 +851,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
                 stats->ierrors +=3D rxq->stats.errors;
                 stats->imissed +=3D rxq->stats.ring_full;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] +=3D rxq->stats.packets;
-                       stats->q_ibytes[i] +=3D rxq->stats.bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] +=3D rxq->stats.packets;
+                       qstats->q_ibytes[i] +=3D rxq->stats.bytes;
                 }
         }

diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index ccbd6b6a33..17c1d5d07b 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -269,7 +269,8 @@ int hn_vf_rx_queue_setup(struct rte_eth_dev *dev,
                              struct rte_mempool *mp);
 void    hn_vf_rx_queue_release(struct hn_data *hv, uint16_t queue_id);

-int    hn_vf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s);
+int    hn_vf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,
+                       struct eth_queue_stats *qstats);
 int     hn_vf_stats_reset(struct rte_eth_dev *dev);
 int     hn_vf_xstats_get_names(struct rte_eth_dev *dev,
                                struct rte_eth_xstat_name *xstats_names,
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index d922e685f4..0ecfaf54ea 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -677,7 +677,8 @@ void hn_vf_rx_queue_release(struct hn_data *hv, uint16_=
t queue_id)
 }

 int hn_vf_stats_get(struct rte_eth_dev *dev,
-                   struct rte_eth_stats *stats)
+                   struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats __rte_unused)
 {
         struct hn_data *hv =3D dev->data->dev_private;
         struct rte_eth_dev *vf_dev;
diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/n=
fp_flower.c
index 804ad494d5..4eeb9aee3b 100644
--- a/drivers/net/nfp/flower/nfp_flower.c
+++ b/drivers/net/nfp/flower/nfp_flower.c
@@ -238,8 +238,8 @@ nfp_flower_multiple_pf_recv_pkts(void *rx_queue,
                 for (i =3D 0; i < recv; i++)
                         data_len +=3D rx_pkts[i]->data_len;

-               repr->repr_stats.q_ipackets[rxq->qidx] +=3D recv;
-               repr->repr_stats.q_ibytes[rxq->qidx] +=3D data_len;
+               repr->repr_qstats.q_ipackets[rxq->qidx] +=3D recv;
+               repr->repr_qstats.q_ibytes[rxq->qidx] +=3D data_len;
         }

         return recv;
@@ -276,8 +276,8 @@ nfp_flower_multiple_pf_xmit_pkts(void *tx_queue,
                 for (i =3D 0; i < sent; i++)
                         data_len +=3D tx_pkts[i]->data_len;

-               repr->repr_stats.q_opackets[txq->qidx] +=3D sent;
-               repr->repr_stats.q_obytes[txq->qidx] +=3D data_len;
+               repr->repr_qstats.q_opackets[txq->qidx] +=3D sent;
+               repr->repr_qstats.q_obytes[txq->qidx] +=3D data_len;
         }

         return sent;
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/=
nfp/flower/nfp_flower_representor.c
index 6c3a30c694..9b984dbc8d 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -314,7 +314,7 @@ nfp_flower_repr_tx_queue_setup(struct rte_eth_dev *dev,

 static int
 nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
-               struct rte_eth_stats *stats)
+               struct rte_eth_stats *stats, struct eth_queue_stats *qstats=
 __rte_unused)
 {
         uint16_t i;
         struct nfp_flower_representor *repr;
@@ -324,15 +324,15 @@ nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
         repr->repr_stats.ipackets =3D 0;
         repr->repr_stats.ibytes =3D 0;
         for (i =3D 0; i < ethdev->data->nb_rx_queues; i++) {
-               repr->repr_stats.ipackets +=3D repr->repr_stats.q_ipackets[=
i];
-               repr->repr_stats.ibytes +=3D repr->repr_stats.q_ibytes[i];
+               repr->repr_stats.ipackets +=3D repr->repr_qstats.q_ipackets=
[i];
+               repr->repr_stats.ibytes +=3D repr->repr_qstats.q_ibytes[i];
         }

         repr->repr_stats.opackets =3D 0;
         repr->repr_stats.obytes =3D 0;
         for (i =3D 0; i < ethdev->data->nb_tx_queues; i++) {
-               repr->repr_stats.opackets +=3D repr->repr_stats.q_opackets[=
i];
-               repr->repr_stats.obytes +=3D repr->repr_stats.q_obytes[i];
+               repr->repr_stats.opackets +=3D repr->repr_qstats.q_opackets=
[i];
+               repr->repr_stats.obytes +=3D repr->repr_qstats.q_obytes[i];
         }

         *stats =3D repr->repr_stats;
@@ -347,6 +347,7 @@ nfp_flower_repr_stats_reset(struct rte_eth_dev *ethdev)

         repr =3D ethdev->data->dev_private;
         memset(&repr->repr_stats, 0, sizeof(struct rte_eth_stats));
+       memset(&repr->repr_qstats, 0, sizeof(struct eth_queue_stats));

         return 0;
 }
@@ -402,8 +403,8 @@ nfp_flower_repr_rx_burst(void *rx_queue,
                 for (i =3D 0; i < total_dequeue; i++)
                         data_len +=3D rx_pkts[i]->data_len;

-               repr->repr_stats.q_ipackets[rxq->qidx] +=3D total_dequeue;
-               repr->repr_stats.q_ibytes[rxq->qidx] +=3D data_len;
+               repr->repr_qstats.q_ipackets[rxq->qidx] +=3D total_dequeue;
+               repr->repr_qstats.q_ibytes[rxq->qidx] +=3D data_len;
         }

         return total_dequeue;
@@ -450,8 +451,8 @@ nfp_flower_repr_tx_burst(void *tx_queue,
                 for (i =3D 0; i < sent; i++)
                         data_len +=3D tx_pkts[i]->data_len;

-               repr->repr_stats.q_opackets[txq->qidx] +=3D sent;
-               repr->repr_stats.q_obytes[txq->qidx] +=3D data_len;
+               repr->repr_qstats.q_opackets[txq->qidx] +=3D sent;
+               repr->repr_qstats.q_obytes[txq->qidx] +=3D data_len;
         }

         return sent;
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.h b/drivers/net/=
nfp/flower/nfp_flower_representor.h
index a7416eccab..66714d9a51 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.h
+++ b/drivers/net/nfp/flower/nfp_flower_representor.h
@@ -6,6 +6,8 @@
 #ifndef __NFP_FLOWER_REPRESENTOR_H__
 #define __NFP_FLOWER_REPRESENTOR_H__

+#include <ethdev_driver.h>
+
 #include "nfp_flower.h"

 struct nfp_flower_representor {
@@ -20,6 +22,7 @@ struct nfp_flower_representor {
         struct rte_ring **ring;
         struct rte_eth_link link;
         struct rte_eth_stats repr_stats;
+       struct eth_queue_stats repr_qstats;

         struct rte_eth_xstat *repr_xstats_base;
         uint8_t *mac_stats;
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_com=
mon.c
index 730372e279..d35eee970a 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -904,7 +904,7 @@ nfp_net_link_update(struct rte_eth_dev *dev,

 int
 nfp_net_stats_get(struct rte_eth_dev *dev,
-               struct rte_eth_stats *stats)
+               struct rte_eth_stats *stats, struct eth_queue_stats *qstats=
)
 {
         uint16_t i;
         struct nfp_net_hw *hw;
@@ -922,15 +922,16 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
                 if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
                         break;

-               nfp_dev_stats.q_ipackets[i] =3D
-                               nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_ST=
ATS(i));
-               nfp_dev_stats.q_ipackets[i] -=3D
-                               hw->eth_stats_base.q_ipackets[i];
+               uint64_t q_ipackets =3D nn_cfg_readq(&hw->super, NFP_NET_CF=
G_RXR_STATS(i));
+               q_ipackets -=3D hw->eth_qstats_base.q_ipackets[i];

-               nfp_dev_stats.q_ibytes[i] =3D
-                               nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_ST=
ATS(i) + 0x8);
-               nfp_dev_stats.q_ibytes[i] -=3D
-                               hw->eth_stats_base.q_ibytes[i];
+               uint64_t q_ibytes =3D nn_cfg_readq(&hw->super, NFP_NET_CFG_=
RXR_STATS(i) + 0x8);
+               q_ibytes -=3D hw->eth_qstats_base.q_ibytes[i];
+
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D q_ipackets;
+                       qstats->q_ibytes[i] =3D q_ibytes;
+               }
         }

         /* Reading per TX ring stats */
@@ -938,13 +939,16 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
                 if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
                         break;

-               nfp_dev_stats.q_opackets[i] =3D
-                               nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_ST=
ATS(i));
-               nfp_dev_stats.q_opackets[i] -=3D hw->eth_stats_base.q_opack=
ets[i];
+               uint64_t q_opackets =3D nn_cfg_readq(&hw->super, NFP_NET_CF=
G_TXR_STATS(i));
+               q_opackets -=3D hw->eth_qstats_base.q_opackets[i];

-               nfp_dev_stats.q_obytes[i] =3D
-                               nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_ST=
ATS(i) + 0x8);
-               nfp_dev_stats.q_obytes[i] -=3D hw->eth_stats_base.q_obytes[=
i];
+               uint64_t q_obytes =3D nn_cfg_readq(&hw->super, NFP_NET_CFG_=
TXR_STATS(i) + 0x8);
+               q_obytes -=3D hw->eth_qstats_base.q_obytes[i];
+
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[i] =3D q_opackets;
+                       qstats->q_obytes[i] =3D q_obytes;
+               }
         }

         nfp_dev_stats.ipackets =3D nn_cfg_readq(&hw->super, NFP_NET_CFG_ST=
ATS_RX_FRAMES);
@@ -982,8 +986,8 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
 }

 /*
- * hw->eth_stats_base records the per counter starting point.
- * Lets update it now.
+ * hw->eth_stats_base and hw->eth_qstats_base record the per counter start=
ing point.
+ * Let's update them now.
  */
 int
 nfp_net_stats_reset(struct rte_eth_dev *dev)
@@ -998,10 +1002,10 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)
                 if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
                         break;

-               hw->eth_stats_base.q_ipackets[i] =3D
+               hw->eth_qstats_base.q_ipackets[i] =3D
                                 nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_S=
TATS(i));

-               hw->eth_stats_base.q_ibytes[i] =3D
+               hw->eth_qstats_base.q_ibytes[i] =3D
                                 nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_S=
TATS(i) + 0x8);
         }

@@ -1010,10 +1014,10 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)
                 if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)
                         break;

-               hw->eth_stats_base.q_opackets[i] =3D
+               hw->eth_qstats_base.q_opackets[i] =3D
                                 nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_S=
TATS(i));

-               hw->eth_stats_base.q_obytes[i] =3D
+               hw->eth_qstats_base.q_obytes[i] =3D
                                 nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_S=
TATS(i) + 0x8);
         }

diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_com=
mon.h
index a6addf8610..2bd2d54028 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -250,6 +250,7 @@ struct nfp_net_hw {

         /** Records starting point for counters */
         struct rte_eth_stats eth_stats_base;
+       struct eth_queue_stats eth_qstats_base;
         struct rte_eth_xstat *eth_xstats_base;

         struct nfp_cpp_area *ctrl_area;
@@ -301,7 +302,8 @@ int nfp_net_link_update_common(struct rte_eth_dev *dev,
                 uint32_t link_status);
 int nfp_net_link_update(struct rte_eth_dev *dev,
                 __rte_unused int wait_to_complete);
-int nfp_net_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
);
+int nfp_net_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,
+               struct eth_queue_stats *qstats);
 int nfp_net_stats_reset(struct rte_eth_dev *dev);
 uint32_t nfp_net_xstats_size(const struct rte_eth_dev *dev);
 int nfp_net_xstats_get_names(struct rte_eth_dev *dev,
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.=
c
index d3ac40299f..adb7785498 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -1498,7 +1498,8 @@ ngbe_read_stats_registers(struct ngbe_hw *hw,
 }

 static int
-ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         struct ngbe_hw *hw =3D ngbe_dev_hw(dev);
         struct ngbe_hw_stats *hw_stats =3D NGBE_DEV_STATS(dev);
@@ -1518,29 +1519,31 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)
         stats->opackets =3D hw_stats->tx_packets;
         stats->obytes =3D hw_stats->tx_bytes;

-       memset(&stats->q_ipackets, 0, sizeof(stats->q_ipackets));
-       memset(&stats->q_opackets, 0, sizeof(stats->q_opackets));
-       memset(&stats->q_ibytes, 0, sizeof(stats->q_ibytes));
-       memset(&stats->q_obytes, 0, sizeof(stats->q_obytes));
-       memset(&stats->q_errors, 0, sizeof(stats->q_errors));
-       for (i =3D 0; i < NGBE_MAX_QP; i++) {
-               uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;
-               uint32_t offset =3D (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
-               uint32_t q_map;
-
-               q_map =3D (stat_mappings->rqsm[n] >> offset)
-                               & QMAP_FIELD_RESERVED_BITS_MASK;
-               j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-                    ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-               stats->q_ipackets[j] +=3D hw_stats->qp[i].rx_qp_packets;
-               stats->q_ibytes[j] +=3D hw_stats->qp[i].rx_qp_bytes;
-
-               q_map =3D (stat_mappings->tqsm[n] >> offset)
-                               & QMAP_FIELD_RESERVED_BITS_MASK;
-               j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-                    ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-               stats->q_opackets[j] +=3D hw_stats->qp[i].tx_qp_packets;
-               stats->q_obytes[j] +=3D hw_stats->qp[i].tx_qp_bytes;
+       if (qstats !=3D NULL) {
+               memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
+               memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
+               memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
+               memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
+               memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
+               for (i =3D 0; i < NGBE_MAX_QP; i++) {
+                       uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;
+                       uint32_t offset =3D (i % NB_QMAP_FIELDS_PER_QSM_REG=
) * 8;
+                       uint32_t q_map;
+
+                       q_map =3D (stat_mappings->rqsm[n] >> offset)
+                                       & QMAP_FIELD_RESERVED_BITS_MASK;
+                       j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+                            ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS)=
;
+                       qstats->q_ipackets[j] +=3D hw_stats->qp[i].rx_qp_pa=
ckets;
+                       qstats->q_ibytes[j] +=3D hw_stats->qp[i].rx_qp_byte=
s;
+
+                       q_map =3D (stat_mappings->tqsm[n] >> offset)
+                                       & QMAP_FIELD_RESERVED_BITS_MASK;
+                       j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+                            ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS)=
;
+                       qstats->q_opackets[j] +=3D hw_stats->qp[i].tx_qp_pa=
ckets;
+                       qstats->q_obytes[j] +=3D hw_stats->qp[i].tx_qp_byte=
s;
+               }
         }

         /* Rx Errors */
@@ -1580,7 +1583,7 @@ ngbe_dev_stats_reset(struct rte_eth_dev *dev)

         /* HW registers are cleared on read */
         hw->offset_loaded =3D 0;
-       ngbe_dev_stats_get(dev, NULL);
+       ngbe_dev_stats_get(dev, NULL, NULL);
         hw->offset_loaded =3D 1;

         /* Reset software totals */
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethd=
ev_vf.c
index 846bc981f6..e575c47049 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -425,7 +425,8 @@ ngbevf_dev_xstats_get(struct rte_eth_dev *dev, struct r=
te_eth_xstat *xstats,
 }

 static int
-ngbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ngbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct ngbevf_hw_stats *hw_stats =3D (struct ngbevf_hw_stats *)
                           NGBE_DEV_STATS(dev);
@@ -449,7 +450,7 @@ ngbevf_dev_stats_reset(struct rte_eth_dev *dev)
                         NGBE_DEV_STATS(dev);

         /* Sync HW register to the last stats */
-       ngbevf_dev_stats_get(dev, NULL);
+       ngbevf_dev_stats_get(dev, NULL, NULL);

         /* reset HW current stats*/
         hw_stats->vfgprc =3D 0;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_eth=
dev.c
index 79ef9e7e7c..4c090aa521 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -167,7 +167,8 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
         return p_drv;
 }

-static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_=
eth_stats *stats)
+static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_=
eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         const struct ntnic_filter_ops *ntnic_filter_ops =3D get_ntnic_filt=
er_ops();

@@ -201,19 +202,19 @@ static int dpdk_stats_collect(struct pmd_internals *i=
nternals, struct rte_eth_st
         ntnic_filter_ops->poll_statistics(internals);

         for (i =3D 0; i < internals->nb_rx_queues; i++) {
-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D internals->rxq_scg[i].rx_p=
kts;
-                       stats->q_ibytes[i] =3D internals->rxq_scg[i].rx_byt=
es;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D internals->rxq_scg[i].rx_=
pkts;
+                       qstats->q_ibytes[i] =3D internals->rxq_scg[i].rx_by=
tes;
                 }
                 rx_total +=3D internals->rxq_scg[i].rx_pkts;
                 rx_total_b +=3D internals->rxq_scg[i].rx_bytes;
         }

         for (i =3D 0; i < internals->nb_tx_queues; i++) {
-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] =3D internals->txq_scg[i].tx_p=
kts;
-                       stats->q_obytes[i] =3D internals->txq_scg[i].tx_byt=
es;
-                       stats->q_errors[i] =3D internals->txq_scg[i].err_pk=
ts;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D internals->txq_scg[i].tx_=
pkts;
+                       qstats->q_obytes[i] =3D internals->txq_scg[i].tx_by=
tes;
+                       qstats->q_errors[i] =3D internals->txq_scg[i].err_p=
kts;
                 }
                 tx_total +=3D internals->txq_scg[i].tx_pkts;
                 tx_total_b +=3D internals->txq_scg[i].tx_bytes;
@@ -303,10 +304,11 @@ eth_link_update(struct rte_eth_dev *eth_dev, int wait=
_to_complete __rte_unused)
         return 0;
 }

-static int eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats=
 *stats)
+static int eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats=
 *stats,
+               struct eth_queue_stats *qstats)
 {
         struct pmd_internals *internals =3D eth_dev->data->dev_private;
-       dpdk_stats_collect(internals, stats);
+       dpdk_stats_collect(internals, stats, qstats);
         return 0;
 }

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_nul=
l.c
index 4f273319f2..14bc65c8ad 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -426,7 +426,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }

 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         const struct pmd_internals *internal =3D dev->data->dev_private;
         unsigned int i;
@@ -438,9 +439,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_s=
tats *stats)
                 stats->ipackets +=3D pkts;
                 stats->ibytes +=3D bytes;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D pkts;
-                       stats->q_ibytes[i] =3D bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D pkts;
+                       qstats->q_ibytes[i] =3D bytes;
                 }
         }

@@ -454,9 +455,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_s=
tats *stats)
                 stats->opackets =3D pkts;
                 stats->obytes =3D bytes;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] =3D pkts;
-                       stats->q_obytes[i] =3D bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D pkts;
+                       qstats->q_obytes[i] =3D bytes;
                 }
         }

diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/=
otx_ep_ethdev.c
index 10f2f8a2e0..79dc02ee0b 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -608,7 +608,8 @@ otx_ep_dev_stats_reset(struct rte_eth_dev *dev)

 static int
 otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
-                               struct rte_eth_stats *stats)
+                               struct rte_eth_stats *stats,
+                               struct eth_queue_stats *qstats)
 {
         struct otx_ep_device *otx_epvf =3D OTX_EP_DEV(eth_dev);
         struct otx_ep_iq_stats *ostats;
@@ -619,17 +620,21 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,

         for (i =3D 0; i < otx_epvf->nb_tx_queues; i++) {
                 ostats =3D &otx_epvf->instr_queue[i]->stats;
-               stats->q_opackets[i] =3D ostats->tx_pkts;
-               stats->q_obytes[i] =3D ostats->tx_bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D ostats->tx_pkts;
+                       qstats->q_obytes[i] =3D ostats->tx_bytes;
+               }
                 stats->opackets +=3D ostats->tx_pkts;
                 stats->obytes +=3D ostats->tx_bytes;
                 stats->oerrors +=3D ostats->instr_dropped;
         }
         for (i =3D 0; i < otx_epvf->nb_rx_queues; i++) {
                 istats =3D &otx_epvf->droq[i]->stats;
-               stats->q_ipackets[i] =3D istats->pkts_received;
-               stats->q_ibytes[i] =3D istats->bytes_received;
-               stats->q_errors[i] =3D istats->rx_err;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D istats->pkts_received;
+                       qstats->q_ibytes[i] =3D istats->bytes_received;
+                       qstats->q_errors[i] =3D istats->rx_err;
+               }
                 stats->ipackets +=3D istats->pkts_received;
                 stats->ibytes +=3D istats->bytes_received;
                 stats->imissed +=3D istats->rx_alloc_failure;
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/=
octeontx_ethdev.c
index 9451431144..21e3e56901 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1022,7 +1022,8 @@ octeontx_dev_xstats_get(struct rte_eth_dev *dev,
 }

 static int
-octeontx_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s)
+octeontx_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,
+                      struct eth_queue_stats *qstats __rte_unused)
 {
         struct octeontx_nic *nic =3D octeontx_pmd_priv(dev);

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.=
c
index 728ef85d53..f323c0b0df 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -750,7 +750,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }

 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+             struct eth_queue_stats *qstats)
 {
         unsigned int i;
         unsigned long rx_packets_total =3D 0, rx_bytes_total =3D 0;
@@ -762,21 +763,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)

         for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
                         i < dev->data->nb_rx_queues; i++) {
-               stats->q_ipackets[i] =3D internal->rx_queue[i].rx_stat.pkts=
;
-               stats->q_ibytes[i] =3D internal->rx_queue[i].rx_stat.bytes;
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D internal->rx_queue[i].rx_=
stat.pkts;
+                       qstats->q_ibytes[i] =3D internal->rx_queue[i].rx_st=
at.bytes;
+               }
                 rx_nombuf_total +=3D internal->rx_queue[i].rx_stat.rx_nomb=
uf;
                 rx_err_total +=3D internal->rx_queue[i].rx_stat.err_pkts;
-               rx_packets_total +=3D stats->q_ipackets[i];
-               rx_bytes_total +=3D stats->q_ibytes[i];
+               rx_packets_total +=3D internal->rx_queue[i].rx_stat.pkts;
+               rx_bytes_total +=3D internal->rx_queue[i].rx_stat.bytes;
                 rx_missed_total +=3D queue_missed_stat_get(dev, i);
         }

         for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
                         i < dev->data->nb_tx_queues; i++) {
-               stats->q_opackets[i] =3D internal->tx_queue[i].tx_stat.pkts=
;
-               stats->q_obytes[i] =3D internal->tx_queue[i].tx_stat.bytes;
-               tx_packets_total +=3D stats->q_opackets[i];
-               tx_bytes_total +=3D stats->q_obytes[i];
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[i] =3D internal->tx_queue[i].tx_=
stat.pkts;
+                       qstats->q_obytes[i] =3D internal->tx_queue[i].tx_st=
at.bytes;
+               }
+               tx_packets_total +=3D internal->tx_queue[i].tx_stat.pkts;
+               tx_bytes_total +=3D internal->tx_queue[i].tx_stat.bytes;
                 tx_packets_err_total +=3D internal->tx_queue[i].tx_stat.er=
r_pkts;
         }

diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 725ffcb2bc..1efa17539e 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -713,7 +713,8 @@ pfe_dev_set_mac_addr(struct rte_eth_dev *dev,

 static int
 pfe_stats_get(struct rte_eth_dev *dev,
-             struct rte_eth_stats *stats)
+             struct rte_eth_stats *stats,
+             struct eth_queue_stats *qstats __rte_unused)
 {
         struct pfe_eth_priv_s *priv =3D dev->data->dev_private;
         struct rte_eth_stats *eth_stats =3D &priv->stats;
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.=
c
index bee9fa4f60..e1c28a0ac2 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1592,7 +1592,8 @@ static int qede_dev_close(struct rte_eth_dev *eth_dev=
)
 }

 static int
-qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stat=
s)
+qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stat=
s,
+              struct eth_queue_stats *qstats)
 {
         struct qede_dev *qdev =3D eth_dev->data->dev_private;
         struct ecore_dev *edev =3D &qdev->edev;
@@ -1645,18 +1646,18 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct =
rte_eth_stats *eth_stats)
                        " appropriately and retry.\n");

         for (qid =3D 0; qid < eth_dev->data->nb_rx_queues; qid++) {
-               eth_stats->q_ipackets[i] =3D 0;
-               eth_stats->q_errors[i] =3D 0;
+               uint64_t q_ipackets =3D 0;
+               uint64_t q_errors =3D 0;

                 for_each_hwfn(edev, hw_fn) {
                         idx =3D qid * edev->num_hwfns + hw_fn;

-                       eth_stats->q_ipackets[i] +=3D
+                       q_ipackets +=3D
                                 *(uint64_t *)
                                         (((char *)(qdev->fp_array[idx].rxq=
)) +
                                          offsetof(struct qede_rx_queue,
                                          rcv_pkts));
-                       eth_stats->q_errors[i] +=3D
+                       q_errors +=3D
                                 *(uint64_t *)
                                         (((char *)(qdev->fp_array[idx].rxq=
)) +
                                          offsetof(struct qede_rx_queue,
@@ -1667,25 +1668,33 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct =
rte_eth_stats *eth_stats)
                                          rx_alloc_errors));
                 }

+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D q_ipackets;
+                       qstats->q_errors[i] =3D q_errors;
+               }
+
                 i++;
                 if (i =3D=3D rxq_stat_cntrs)
                         break;
         }

         for (qid =3D 0; qid < eth_dev->data->nb_tx_queues; qid++) {
-               eth_stats->q_opackets[j] =3D 0;
+               uint64_t q_opackets =3D 0;

                 for_each_hwfn(edev, hw_fn) {
                         idx =3D qid * edev->num_hwfns + hw_fn;

                         txq =3D qdev->fp_array[idx].txq;
-                       eth_stats->q_opackets[j] +=3D
+                       q_opackets +=3D
                                 *((uint64_t *)(uintptr_t)
                                         (((uint64_t)(uintptr_t)(txq)) +
                                          offsetof(struct qede_tx_queue,
                                                   xmit_pkts)));
                 }

+               if (qstats !=3D NULL)
+                       qstats->q_opackets[j] =3D q_opackets;
+
                 j++;
                 if (j =3D=3D txq_stat_cntrs)
                         break;
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_eth=
dev.c
index 8071e14412..69512ced8b 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -37,7 +37,8 @@ static int rtl_dev_set_link_down(struct rte_eth_dev *dev)=
;
 static int rtl_dev_infos_get(struct rte_eth_dev *dev,
                              struct rte_eth_dev_info *dev_info);
 static int rtl_dev_stats_get(struct rte_eth_dev *dev,
-                            struct rte_eth_stats *rte_stats);
+                            struct rte_eth_stats *rte_stats,
+                            struct eth_queue_stats *qstats);
 static int rtl_dev_stats_reset(struct rte_eth_dev *dev);
 static int rtl_promiscuous_enable(struct rte_eth_dev *dev);
 static int rtl_promiscuous_disable(struct rte_eth_dev *dev);
@@ -533,7 +534,8 @@ rtl_sw_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *rte_stats)
 }

 static int
-rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
)
+rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
,
+               struct eth_queue_stats *qstats __rte_unused)
 {
         struct rtl_adapter *adapter =3D RTL_DEV_PRIVATE(dev);
         struct rtl_hw *hw =3D &adapter->hw;
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_rin=
g.c
index b1085bf390..b639544eab 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -196,7 +196,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }

 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+             struct eth_queue_stats *qstats)
 {
         unsigned int i;
         unsigned long rx_total =3D 0, tx_total =3D 0;
@@ -204,14 +205,16 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)

         for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
                         i < dev->data->nb_rx_queues; i++) {
-               stats->q_ipackets[i] =3D internal->rx_ring_queues[i].rx_pkt=
s;
-               rx_total +=3D stats->q_ipackets[i];
+               if (qstats !=3D NULL)
+                       qstats->q_ipackets[i] =3D internal->rx_ring_queues[=
i].rx_pkts;
+               rx_total +=3D internal->rx_ring_queues[i].rx_pkts;
         }

         for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
                         i < dev->data->nb_tx_queues; i++) {
-               stats->q_opackets[i] =3D internal->tx_ring_queues[i].tx_pkt=
s;
-               tx_total +=3D stats->q_opackets[i];
+               if (qstats !=3D NULL)
+                       qstats->q_opackets[i] =3D internal->tx_ring_queues[=
i].tx_pkts;
+               tx_total +=3D internal->tx_ring_queues[i].tx_pkts;
         }

         stats->ipackets =3D rx_total;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index de1c077f61..f5babb797d 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1233,7 +1233,8 @@ static void rnp_get_hw_stats(struct rte_eth_dev *dev)

 static int
 rnp_dev_stats_get(struct rte_eth_dev *dev,
-                 struct rte_eth_stats *stats)
+                 struct rte_eth_stats *stats,
+                 struct eth_queue_stats *qstats)
 {
         struct rnp_eth_port *port =3D RNP_DEV_TO_PORT(dev);
         struct rnp_hw_eth_stats *eth_stats =3D &port->eth_stats;
@@ -1251,9 +1252,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
                         continue;
                 stats->ipackets +=3D rxq->stats.ipackets;
                 stats->ibytes +=3D rxq->stats.ibytes;
-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D rxq->stats.ipackets;
-                       stats->q_ibytes[i] =3D rxq->stats.ibytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D rxq->stats.ipackets;
+                       qstats->q_ibytes[i] =3D rxq->stats.ibytes;
                 }
         }

@@ -1265,9 +1266,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
                 stats->opackets +=3D txq->stats.opackets;
                 stats->obytes +=3D txq->stats.obytes;
                 stats->oerrors +=3D txq->stats.errors;
-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] =3D txq->stats.opackets;
-                       stats->q_obytes[i] =3D txq->stats.obytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D txq->stats.opackets;
+                       qstats->q_obytes[i] =3D txq->stats.obytes;
                 }
         }
         stats->imissed =3D eth_stats->rx_trans_drop + eth_stats->rx_trunc_=
drop;
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 8b0bf4eeee..99141bdda5 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -823,7 +823,8 @@ sfc_update_diff_stat(uint64_t *stat, uint64_t newval)
 }

 static int
-sfc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+sfc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+             struct eth_queue_stats *qstats __rte_unused)
 {
         const struct sfc_adapter_priv *sap =3D sfc_adapter_priv_by_eth_dev=
(dev);
         bool have_dp_rx_stats =3D sap->dp_rx->features & SFC_DP_RX_FEAT_ST=
ATS;
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 18e76fa7da..93da97387c 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -846,7 +846,8 @@ sfc_repr_mac_addr_set(struct rte_eth_dev *dev, struct r=
te_ether_addr *mac_addr)
 }

 static int
-sfc_repr_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+sfc_repr_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats __rte_unused)
 {
         union sfc_pkts_bytes queue_stats;
         uint16_t i;
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 650ddbd706..3c9ba829d6 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1030,7 +1030,8 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_=
dev_info *dev_info)
 }

 static int
-tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats)
+tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
+             struct eth_queue_stats *qstats)
 {
         unsigned int i, imax;
         unsigned long rx_total =3D 0, tx_total =3D 0, tx_err_total =3D 0;
@@ -1042,10 +1043,12 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *tap_stats)
         imax =3D (dev->data->nb_rx_queues < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
                 dev->data->nb_rx_queues : RTE_ETHDEV_QUEUE_STAT_CNTRS;
         for (i =3D 0; i < imax; i++) {
-               tap_stats->q_ipackets[i] =3D pmd->rxq[i].stats.ipackets;
-               tap_stats->q_ibytes[i] =3D pmd->rxq[i].stats.ibytes;
-               rx_total +=3D tap_stats->q_ipackets[i];
-               rx_bytes_total +=3D tap_stats->q_ibytes[i];
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D pmd->rxq[i].stats.ipacket=
s;
+                       qstats->q_ibytes[i] =3D pmd->rxq[i].stats.ibytes;
+               }
+               rx_total +=3D pmd->rxq[i].stats.ipackets;
+               rx_bytes_total +=3D pmd->rxq[i].stats.ibytes;
                 rx_nombuf +=3D pmd->rxq[i].stats.rx_nombuf;
                 ierrors +=3D pmd->rxq[i].stats.ierrors;
         }
@@ -1055,11 +1058,13 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *tap_stats)
                 dev->data->nb_tx_queues : RTE_ETHDEV_QUEUE_STAT_CNTRS;

         for (i =3D 0; i < imax; i++) {
-               tap_stats->q_opackets[i] =3D pmd->txq[i].stats.opackets;
-               tap_stats->q_obytes[i] =3D pmd->txq[i].stats.obytes;
-               tx_total +=3D tap_stats->q_opackets[i];
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[i] =3D pmd->txq[i].stats.opacket=
s;
+                       qstats->q_obytes[i] =3D pmd->txq[i].stats.obytes;
+               }
+               tx_total +=3D pmd->txq[i].stats.opackets;
+               tx_bytes_total +=3D pmd->txq[i].stats.obytes;
                 tx_err_total +=3D pmd->txq[i].stats.errs;
-               tx_bytes_total +=3D tap_stats->q_obytes[i];
         }

         tap_stats->ipackets =3D rx_total;
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nic=
vf_ethdev.c
index 4441a90bdf..76ed76a045 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -289,7 +289,8 @@ nicvf_dev_get_regs(struct rte_eth_dev *dev, struct rte_=
dev_reg_info *regs)
 }

 static int
-nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats)
 {
         uint16_t qidx;
         struct nicvf_hw_rx_qstats rx_qstats;
@@ -309,8 +310,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)
                         break;

                 nicvf_hw_get_rx_qstats(nic, &rx_qstats, qidx);
-               stats->q_ibytes[qidx] =3D rx_qstats.q_rx_bytes;
-               stats->q_ipackets[qidx] =3D rx_qstats.q_rx_packets;
+               if (qstats !=3D NULL) {
+                       qstats->q_ibytes[qidx] =3D rx_qstats.q_rx_bytes;
+                       qstats->q_ipackets[qidx] =3D rx_qstats.q_rx_packets=
;
+               }
         }

         /* TX queue indices for the first VF */
@@ -322,8 +325,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)
                         break;

                 nicvf_hw_get_tx_qstats(nic, &tx_qstats, qidx);
-               stats->q_obytes[qidx] =3D tx_qstats.q_tx_bytes;
-               stats->q_opackets[qidx] =3D tx_qstats.q_tx_packets;
+               if (qstats !=3D NULL) {
+                       qstats->q_obytes[qidx] =3D tx_qstats.q_tx_bytes;
+                       qstats->q_opackets[qidx] =3D tx_qstats.q_tx_packets=
;
+               }
         }

         for (i =3D 0; i < nic->sqs_count; i++) {
@@ -342,8 +347,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)

                         nicvf_hw_get_rx_qstats(snic, &rx_qstats,
                                                qidx % MAX_RCV_QUEUES_PER_Q=
S);
-                       stats->q_ibytes[qidx] =3D rx_qstats.q_rx_bytes;
-                       stats->q_ipackets[qidx] =3D rx_qstats.q_rx_packets;
+                       if (qstats !=3D NULL) {
+                               qstats->q_ibytes[qidx] =3D rx_qstats.q_rx_b=
ytes;
+                               qstats->q_ipackets[qidx] =3D rx_qstats.q_rx=
_packets;
+                       }
                 }

                 /* TX queue indices for a secondary VF */
@@ -355,8 +362,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)

                         nicvf_hw_get_tx_qstats(snic, &tx_qstats,
                                                qidx % MAX_SND_QUEUES_PER_Q=
S);
-                       stats->q_obytes[qidx] =3D tx_qstats.q_tx_bytes;
-                       stats->q_opackets[qidx] =3D tx_qstats.q_tx_packets;
+                       if (qstats !=3D NULL) {
+                               qstats->q_obytes[qidx] =3D tx_qstats.q_tx_b=
ytes;
+                               qstats->q_opackets[qidx] =3D tx_qstats.q_tx=
_packets;
+                       }
                 }
         }

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_eth=
dev.c
index 580579094b..33d1d59ead 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2342,7 +2342,8 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 }

 static int
-txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats)
 {
         struct txgbe_hw *hw =3D TXGBE_DEV_HW(dev);
         struct txgbe_hw_stats *hw_stats =3D TXGBE_DEV_STATS(dev);
@@ -2362,29 +2363,31 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)
         stats->opackets =3D hw_stats->tx_packets;
         stats->obytes =3D hw_stats->tx_bytes;

-       memset(&stats->q_ipackets, 0, sizeof(stats->q_ipackets));
-       memset(&stats->q_opackets, 0, sizeof(stats->q_opackets));
-       memset(&stats->q_ibytes, 0, sizeof(stats->q_ibytes));
-       memset(&stats->q_obytes, 0, sizeof(stats->q_obytes));
-       memset(&stats->q_errors, 0, sizeof(stats->q_errors));
-       for (i =3D 0; i < TXGBE_MAX_QP; i++) {
-               uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;
-               uint32_t offset =3D (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
-               uint32_t q_map;
-
-               q_map =3D (stat_mappings->rqsm[n] >> offset)
-                               & QMAP_FIELD_RESERVED_BITS_MASK;
-               j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-                    ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-               stats->q_ipackets[j] +=3D hw_stats->qp[i].rx_qp_packets;
-               stats->q_ibytes[j] +=3D hw_stats->qp[i].rx_qp_bytes;
-
-               q_map =3D (stat_mappings->tqsm[n] >> offset)
-                               & QMAP_FIELD_RESERVED_BITS_MASK;
-               j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-                    ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-               stats->q_opackets[j] +=3D hw_stats->qp[i].tx_qp_packets;
-               stats->q_obytes[j] +=3D hw_stats->qp[i].tx_qp_bytes;
+       if (qstats !=3D NULL) {
+               memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
+               memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
+               memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
+               memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
+               memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
+               for (i =3D 0; i < TXGBE_MAX_QP; i++) {
+                       uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;
+                       uint32_t offset =3D (i % NB_QMAP_FIELDS_PER_QSM_REG=
) * 8;
+                       uint32_t q_map;
+
+                       q_map =3D (stat_mappings->rqsm[n] >> offset)
+                                       & QMAP_FIELD_RESERVED_BITS_MASK;
+                       j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+                            ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS)=
;
+                       qstats->q_ipackets[j] +=3D hw_stats->qp[i].rx_qp_pa=
ckets;
+                       qstats->q_ibytes[j] +=3D hw_stats->qp[i].rx_qp_byte=
s;
+
+                       q_map =3D (stat_mappings->tqsm[n] >> offset)
+                                       & QMAP_FIELD_RESERVED_BITS_MASK;
+                       j =3D (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+                            ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS)=
;
+                       qstats->q_opackets[j] +=3D hw_stats->qp[i].tx_qp_pa=
ckets;
+                       qstats->q_obytes[j] +=3D hw_stats->qp[i].tx_qp_byte=
s;
+               }
         }

         /* Rx Errors */
@@ -2426,7 +2429,7 @@ txgbe_dev_stats_reset(struct rte_eth_dev *dev)

         /* HW registers are cleared on read */
         hw->offset_loaded =3D 0;
-       txgbe_dev_stats_get(dev, NULL);
+       txgbe_dev_stats_get(dev, NULL, NULL);
         hw->offset_loaded =3D 1;

         /* Reset software totals */
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_=
ethdev_vf.c
index 847febf8c3..b369070da8 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -494,7 +494,8 @@ txgbevf_dev_xstats_get(struct rte_eth_dev *dev, struct =
rte_eth_xstat *xstats,
 }

 static int
-txgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)
+txgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,
+                     struct eth_queue_stats *qstats __rte_unused)
 {
         struct txgbevf_hw_stats *hw_stats =3D (struct txgbevf_hw_stats *)
                           TXGBE_DEV_STATS(dev);
@@ -528,7 +529,7 @@ txgbevf_dev_stats_reset(struct rte_eth_dev *dev)
         uint32_t i;

         /* Sync HW register to the last stats */
-       txgbevf_dev_stats_get(dev, NULL);
+       txgbevf_dev_stats_get(dev, NULL, NULL);

         /* reset HW current stats*/
         for (i =3D 0; i < 8; i++) {
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_=
vhost.c
index 87c91e2f96..05940f2461 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1310,7 +1310,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }

 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+             struct eth_queue_stats *qstats)
 {
         unsigned i;
         unsigned long rx_total =3D 0, tx_total =3D 0;
@@ -1323,11 +1324,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats)
                 if (dev->data->rx_queues[i] =3D=3D NULL)
                         continue;
                 vq =3D dev->data->rx_queues[i];
-               stats->q_ipackets[i] =3D vq->stats.pkts;
-               rx_total +=3D stats->q_ipackets[i];
-
-               stats->q_ibytes[i] =3D vq->stats.bytes;
-               rx_total_bytes +=3D stats->q_ibytes[i];
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D vq->stats.pkts;
+                       qstats->q_ibytes[i] =3D vq->stats.bytes;
+               }
+               rx_total +=3D vq->stats.pkts;
+               rx_total_bytes +=3D vq->stats.bytes;
         }

         for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
@@ -1335,12 +1337,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats)
                 if (dev->data->tx_queues[i] =3D=3D NULL)
                         continue;
                 vq =3D dev->data->tx_queues[i];
-               stats->q_opackets[i] =3D vq->stats.pkts;
-               tx_total +=3D stats->q_opackets[i];
-
-               stats->q_obytes[i] =3D vq->stats.bytes;
-               tx_total_bytes +=3D stats->q_obytes[i];
-
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[i] =3D vq->stats.pkts;
+                       qstats->q_obytes[i] =3D vq->stats.bytes;
+               }
+               tx_total +=3D vq->stats.pkts;
+               tx_total_bytes +=3D vq->stats.bytes;
                 tx_total_errors +=3D vq->stats.missed_pkts;
         }

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio=
_ethdev.c
index eebc3ea817..e45dbd8ee9 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -68,7 +68,8 @@ static void virtio_set_hwaddr(struct virtio_hw *hw);
 static void virtio_get_hwaddr(struct virtio_hw *hw);

 static int virtio_dev_stats_get(struct rte_eth_dev *dev,
-                                struct rte_eth_stats *stats);
+                                struct rte_eth_stats *stats,
+                                struct eth_queue_stats *qstats);
 static int virtio_dev_xstats_get(struct rte_eth_dev *dev,
                                  struct rte_eth_xstat *xstats, unsigned n)=
;
 static int virtio_dev_xstats_get_names(struct rte_eth_dev *dev,
@@ -673,7 +674,8 @@ const struct eth_dev_ops virtio_user_secondary_eth_dev_=
ops =3D {
 };

 static void
-virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                   struct eth_queue_stats *qstats)
 {
         unsigned i;

@@ -685,9 +687,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)
                 stats->opackets +=3D txvq->stats.packets;
                 stats->obytes +=3D txvq->stats.bytes;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] =3D txvq->stats.packets;
-                       stats->q_obytes[i] =3D txvq->stats.bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D txvq->stats.packets;
+                       qstats->q_obytes[i] =3D txvq->stats.bytes;
                 }
         }

@@ -700,9 +702,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)
                 stats->ibytes +=3D rxvq->stats.bytes;
                 stats->ierrors +=3D rxvq->stats.errors;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D rxvq->stats.packets;
-                       stats->q_ibytes[i] =3D rxvq->stats.bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D rxvq->stats.packets;
+                       qstats->q_ibytes[i] =3D rxvq->stats.bytes;
                 }
         }

@@ -802,9 +804,10 @@ virtio_dev_xstats_get(struct rte_eth_dev *dev, struct =
rte_eth_xstat *xstats,
 }

 static int
-virtio_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+virtio_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+                    struct eth_queue_stats *qstats)
 {
-       virtio_update_stats(dev, stats);
+       virtio_update_stats(dev, stats, qstats);

         return 0;
 }
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmx=
net3_ethdev.c
index e19aa43888..b0c19c5c7c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -77,7 +77,8 @@ static int vmxnet3_dev_link_update(struct rte_eth_dev *de=
v,
                                    int wait_to_complete);
 static void vmxnet3_hw_stats_save(struct vmxnet3_hw *hw);
 static int vmxnet3_dev_stats_get(struct rte_eth_dev *dev,
-                                 struct rte_eth_stats *stats);
+                                 struct rte_eth_stats *stats,
+                                 struct eth_queue_stats *qstats);
 static int vmxnet3_dev_stats_reset(struct rte_eth_dev *dev);
 static int vmxnet3_dev_xstats_get_names(struct rte_eth_dev *dev,
                                         struct rte_eth_xstat_name *xstats,
@@ -1470,7 +1471,8 @@ vmxnet3_dev_xstats_get(struct rte_eth_dev *dev, struc=
t rte_eth_xstat *xstats,
 }

 static int
-vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)
+vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,
+               struct eth_queue_stats *qstats)
 {
         unsigned int i;
         struct vmxnet3_hw *hw =3D dev->data->dev_private;
@@ -1495,9 +1497,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)
                 stats->obytes +=3D bytes;
                 stats->oerrors +=3D txStats.pktsTxError + txStats.pktsTxDi=
scard;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[i] =3D packets;
-                       stats->q_obytes[i] =3D bytes;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_opackets[i] =3D packets;
+                       qstats->q_obytes[i] =3D bytes;
                 }
         }

@@ -1517,10 +1519,10 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, stru=
ct rte_eth_stats *stats)
                 stats->ierrors +=3D rxStats.pktsRxError;
                 stats->imissed +=3D rxStats.pktsRxOutOfBuf;

-               if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[i] =3D packets;
-                       stats->q_ibytes[i] =3D bytes;
-                       stats->q_errors[i] =3D rxStats.pktsRxError;
+               if (qstats !=3D NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+                       qstats->q_ipackets[i] =3D packets;
+                       qstats->q_ibytes[i] =3D bytes;
+                       qstats->q_errors[i] =3D rxStats.pktsRxError;
                 }
         }

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 988d734b5b..07fc52ac7b 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -577,7 +577,8 @@ xsc_ethdev_set_mtu(struct rte_eth_dev *dev, uint16_t mt=
u)
 }

 static int
-xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         struct xsc_ethdev_priv *priv =3D TO_XSC_ETHDEV_PRIV(dev);
         uint32_t rxqs_n =3D priv->num_rq;
@@ -592,10 +593,10 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)
                         continue;

                 idx =3D rxq->idx;
-               if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_ipackets[idx] +=3D rxq->stats.rx_pkts;
-                       stats->q_ibytes[idx] +=3D rxq->stats.rx_bytes;
-                       stats->q_errors[idx] +=3D rxq->stats.rx_errors +
+               if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) =
{
+                       qstats->q_ipackets[idx] +=3D rxq->stats.rx_pkts;
+                       qstats->q_ibytes[idx] +=3D rxq->stats.rx_bytes;
+                       qstats->q_errors[idx] +=3D rxq->stats.rx_errors +
                                                 rxq->stats.rx_nombuf;
                 }
                 stats->ipackets +=3D rxq->stats.rx_pkts;
@@ -610,10 +611,10 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)
                         continue;

                 idx =3D txq->idx;
-               if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-                       stats->q_opackets[idx] +=3D txq->stats.tx_pkts;
-                       stats->q_obytes[idx] +=3D txq->stats.tx_bytes;
-                       stats->q_errors[idx] +=3D txq->stats.tx_errors;
+               if (qstats !=3D NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) =
{
+                       qstats->q_opackets[idx] +=3D txq->stats.tx_pkts;
+                       qstats->q_obytes[idx] +=3D txq->stats.tx_bytes;
+                       qstats->q_errors[idx] +=3D txq->stats.tx_errors;
                 }
                 stats->opackets +=3D txq->stats.tx_pkts;
                 stats->obytes +=3D txq->stats.tx_bytes;
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_eth=
dev_ops.c
index da32512b03..6d9f0af748 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
@@ -1698,7 +1698,8 @@ zxdh_hw_np_stats_get(struct rte_eth_dev *dev, struct =
zxdh_hw_np_stats *np_stats)
 }

 int
-zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+               struct eth_queue_stats *qstats)
 {
         struct zxdh_hw *hw =3D dev->data->dev_private;
         struct zxdh_hw_vqm_stats vqm_stats =3D {0};
@@ -1730,14 +1731,16 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)

                 if (rxvq =3D=3D NULL)
                         continue;
-               stats->q_ipackets[i] =3D *(uint64_t *)(((char *)rxvq) +
-                               zxdh_rxq_stat_strings[0].offset);
-               stats->q_ibytes[i] =3D *(uint64_t *)(((char *)rxvq) +
-                               zxdh_rxq_stat_strings[1].offset);
-               stats->q_errors[i] =3D *(uint64_t *)(((char *)rxvq) +
-                               zxdh_rxq_stat_strings[2].offset);
-               stats->q_errors[i] +=3D *(uint64_t *)(((char *)rxvq) +
-                               zxdh_rxq_stat_strings[5].offset);
+               if (qstats !=3D NULL) {
+                       qstats->q_ipackets[i] =3D *(uint64_t *)(((char *)rx=
vq) +
+                                       zxdh_rxq_stat_strings[0].offset);
+                       qstats->q_ibytes[i] =3D *(uint64_t *)(((char *)rxvq=
) +
+                                       zxdh_rxq_stat_strings[1].offset);
+                       qstats->q_errors[i] =3D *(uint64_t *)(((char *)rxvq=
) +
+                                       zxdh_rxq_stat_strings[2].offset);
+                       qstats->q_errors[i] +=3D *(uint64_t *)(((char *)rxv=
q) +
+                                       zxdh_rxq_stat_strings[5].offset);
+               }
         }

         for (i =3D 0; (i < dev->data->nb_tx_queues) && (i < RTE_ETHDEV_QUE=
UE_STAT_CNTRS); i++) {
@@ -1745,14 +1748,16 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)

                 if (txvq =3D=3D NULL)
                         continue;
-               stats->q_opackets[i] =3D *(uint64_t *)(((char *)txvq) +
-                               zxdh_txq_stat_strings[0].offset);
-               stats->q_obytes[i] =3D *(uint64_t *)(((char *)txvq) +
-                               zxdh_txq_stat_strings[1].offset);
-               stats->q_errors[i] +=3D *(uint64_t *)(((char *)txvq) +
-                               zxdh_txq_stat_strings[2].offset);
-               stats->q_errors[i] +=3D *(uint64_t *)(((char *)txvq) +
-                               zxdh_txq_stat_strings[5].offset);
+               if (qstats !=3D NULL) {
+                       qstats->q_opackets[i] =3D *(uint64_t *)(((char *)tx=
vq) +
+                                       zxdh_txq_stat_strings[0].offset);
+                       qstats->q_obytes[i] =3D *(uint64_t *)(((char *)txvq=
) +
+                                       zxdh_txq_stat_strings[1].offset);
+                       qstats->q_errors[i] +=3D *(uint64_t *)(((char *)txv=
q) +
+                                       zxdh_txq_stat_strings[2].offset);
+                       qstats->q_errors[i] +=3D *(uint64_t *)(((char *)txv=
q) +
+                                       zxdh_txq_stat_strings[5].offset);
+               }
         }
         return 0;
 }
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.h b/drivers/net/zxdh/zxdh_eth=
dev_ops.h
index 86db6efe40..85e926887b 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.h
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.h
@@ -130,7 +130,8 @@ int zxdh_dev_rss_reta_query(struct rte_eth_dev *dev,
 int zxdh_rss_hash_update(struct rte_eth_dev *dev, struct rte_eth_rss_conf =
*rss_conf);
 int zxdh_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_con=
f *rss_conf);
 int zxdh_rss_configure(struct rte_eth_dev *dev);
-int zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s);
+int zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,
+               struct eth_queue_stats *qstats);
 int zxdh_dev_stats_reset(struct rte_eth_dev *dev);
 int zxdh_dev_mtu_set(struct rte_eth_dev *dev, uint16_t new_mtu);
 int zxdh_hw_np_stats_pf_reset(struct rte_eth_dev *dev, uint32_t stats_id);
--
2.48.1

Reviewed-by: Rosen Xu <rosen.xu@altera.com>

--_000_CH2PR03MB523960813B7CCA35AA8B5668FC1CACH2PR03MB5239namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi,</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, September 23, 2025 10:12 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;; John W=
. Linville &lt;linville@tuxdriver.com&gt;; Ciara Loftus &lt;ciara.loftus@in=
tel.com&gt;; Maryam Tahhan &lt;mtahhan@redhat.com&gt;; shepard.siegel &lt;s=
hepard.siegel@atomicrules.com&gt;; Ed Czeck &lt;ed.czeck@atomicrules.com&gt=
;;
 John Miller &lt;john.miller@atomicrules.com&gt;; Igor Russkikh &lt;irusski=
kh@marvell.com&gt;; Steven Webster &lt;steven.webster@windriver.com&gt;; Ma=
tt Peters &lt;matt.peters@windriver.com&gt;; Selwin Sebastian &lt;selwin.se=
bastian@amd.com&gt;; Julien Aube &lt;julien_dpdk@jaube.fr&gt;; Ajit
 Khaparde &lt;ajit.khaparde@broadcom.com&gt;; Somnath Kotur &lt;somnath.kot=
ur@broadcom.com&gt;; Chas Williams &lt;3chas3@gmail.com&gt;; Min Hu (Connor=
) &lt;humin29@huawei.com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com=
&gt;; Kiran Kumar K &lt;kirankumark@marvell.com&gt;; Sunil Kumar Kori
 &lt;skori@marvell.com&gt;; Satha Rao &lt;skoteshwar@marvell.com&gt;; Harma=
n Kalra &lt;hkalra@marvell.com&gt;; Potnuri Bharat Teja &lt;bharat@chelsio.=
com&gt;; Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;; Sachin Saxena &lt;s=
achin.saxena@nxp.com&gt;; Shai Brandes &lt;shaibran@amazon.com&gt;; Evgeny
 Schemeilin &lt;evgenys@amazon.com&gt;; Ron Beider &lt;rbeider@amazon.com&g=
t;; Amit Bernstein &lt;amitbern@amazon.com&gt;; Wajeeh Atrash &lt;atrwajee@=
amazon.com&gt;; Gagandeep Singh &lt;g.singh@nxp.com&gt;; Apeksha Gupta &lt;=
apeksha.gupta@nxp.com&gt;; John Daley &lt;johndale@cisco.com&gt;; Hyong You=
b
 Kim &lt;hyonkim@cisco.com&gt;; Gaetan Rivet &lt;grive@u256.net&gt;; Jeroen=
 de Borst &lt;jeroendb@google.com&gt;; Joshua Washington &lt;joshwash@googl=
e.com&gt;; Ziyang Xuan &lt;xuanziyang2@huawei.com&gt;; Xiaoyun Wang &lt;clo=
ud.wangxiaoyun@huawei.com&gt;; Xingui Yang &lt;yangxingui@huawei.com&gt;;
 Chengwen Feng &lt;fengchengwen@huawei.com&gt;; Praveen Shetty &lt;praveen.=
shetty@intel.com&gt;; Vladimir Medvedkin &lt;vladimir.medvedkin@intel.com&g=
t;; Anatoly Burakov &lt;anatoly.burakov@intel.com&gt;; Jingjing Wu &lt;jing=
jing.wu@intel.com&gt;; Xu, Rosen &lt;rosen.xu@altera.com&gt;; Andrew
 Boyer &lt;andrew.boyer@amd.com&gt;; Long Li &lt;longli@microsoft.com&gt;; =
Wei Hu &lt;weh@microsoft.com&gt;; Jakub Grajciar &lt;jgrajcia@cisco.com&gt;=
; Matan Azrad &lt;matan@nvidia.com&gt;; Viacheslav Ovsiienko &lt;viacheslav=
o@nvidia.com&gt;; Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;; Bing Zha=
o
 &lt;bingz@nvidia.com&gt;; Ori Kam &lt;orika@nvidia.com&gt;; Suanming Mou &=
lt;suanmingm@nvidia.com&gt;; Zyta Szpak &lt;zyta@marvell.com&gt;; Liron Him=
i &lt;lironh@marvell.com&gt;; Chaoyong He &lt;chaoyong.he@corigine.com&gt;;=
 Jiawen Wu &lt;jiawenwu@trustnetic.com&gt;; Zaiyu Wang &lt;zaiyuwang@trustn=
etic.com&gt;;
 Christian Koue Muf &lt;ckm@napatech.com&gt;; Serhii Iliushyk &lt;sil-plv@n=
apatech.com&gt;; Tetsuya Mukawa &lt;mtetsuyah@gmail.com&gt;; Vamsi Attunuru=
 &lt;vattunuru@marvell.com&gt;; Devendra Singh Rawat &lt;dsinghrawat@marvel=
l.com&gt;; Alok Prasad &lt;palok@marvell.com&gt;; Howard Wang &lt;howard_wa=
ng@realsil.com.cn&gt;;
 Chunhao Lin &lt;hau@realtek.com&gt;; Xing Wang &lt;xing_wang@realsil.com.c=
n&gt;; Wenbo Cao &lt;caowenbo@mucse.com&gt;; Andrew Rybchenko &lt;andrew.ry=
bchenko@oktetlabs.ru&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&=
gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; Maciej Czekaj &lt;mczekaj@marv=
ell.com&gt;;
 Jian Wang &lt;jianwang@trustnetic.com&gt;; Maxime Coquelin &lt;maxime.coqu=
elin@redhat.com&gt;; Chenbo Xia &lt;chenbox@nvidia.com&gt;; Jochen Behrens =
&lt;jochen.behrens@broadcom.com&gt;; Renyong Wan &lt;wanry@yunsilicon.com&g=
t;; Na Na &lt;nana@yunsilicon.com&gt;; Rong Qian &lt;qianr@yunsilicon.com&g=
t;;
 Xiaoxiong Zhang &lt;zhangxx@yunsilicon.com&gt;; Dongwei Xu &lt;xudw@yunsil=
icon.com&gt;; Junlong Wang &lt;wang.junlong1@zte.com.cn&gt;; Lijie Shan &lt=
;shan.lijie@zte.com.cn&gt;<br>
<b>Subject:</b>&nbsp;[RFC PATCH 4/6] drivers/net: update to remove queue st=
ats from eth stats</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">Now that we have r=
emoved the queue stats from the ethdev stats, we need<br>
to update the various PMDs to take account of the changes.<br>
<br>
Update each stats_get function to take the extra parameters for qstats,<br>
just marking it as unused if the driver does not fill in queue stats.<br>
For those that do complete queue stats, update the structure reference<br>
as appropriate.<br>
<br>
Signed-off-by: Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
---<br>
&nbsp;drivers/net/af_packet/rte_eth_af_packet.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 13 +-<br>
&nbsp;drivers/net/af_xdp/rte_eth_af_xdp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 35 +++--<br>
&nbsp;drivers/net/ark/ark_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 36 ++=
+--<br>
&nbsp;drivers/net/ark/ark_ethdev_rx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +-<br>
&nbsp;drivers/net/ark/ark_ethdev_rx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/ark/ark_ethdev_tx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 +-<br>
&nbsp;drivers/net/ark/ark_ethdev_tx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/atlantic/atl_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 19 +--<br>
&nbsp;drivers/net/atlantic/atl_types.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/net/avp/avp_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 ++=
-<br>
&nbsp;drivers/net/axgbe/axgbe_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 22 +--<br>
&nbsp;drivers/net/axgbe/axgbe_ethdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/net/bnx2x/bnx2x_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/bnxt/bnxt_reps.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +-=
<br>
&nbsp;drivers/net/bnxt/bnxt_reps.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +-<br>
&nbsp;drivers/net/bnxt/bnxt_stats.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 133 ++++++++++--=
------<br>
&nbsp;drivers/net/bnxt/bnxt_stats.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;drivers/net/bonding/rte_eth_bond_pmd.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 14 +-<br>
&nbsp;drivers/net/cnxk/cnxk_ethdev.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/cnxk/cnxk_rep.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +-<br>
&nbsp;drivers/net/cnxk/cnxk_rep_ops.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 +-<br>
&nbsp;drivers/net/cnxk/cnxk_stats.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 49 ++++---=
<br>
&nbsp;drivers/net/cxgbe/cxgbe_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/cxgbe/cxgbevf_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/dpaa/dpaa_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/dpaa2/dpaa2_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 28 ++--<br>
&nbsp;drivers/net/ena/ena_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 46 ++=
+---<br>
&nbsp;drivers/net/enetc/enetc_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;drivers/net/enetfec/enet_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/enic/enic.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/enic/enic_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;drivers/net/enic/enic_main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +-<br>
&nbsp;drivers/net/enic/enic_vf_representor.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/failsafe/failsafe_ether.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 --<br>
&nbsp;drivers/net/failsafe/failsafe_ops.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/gve/gve_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 4 +-<br>
&nbsp;drivers/net/hinic/hinic_pmd_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 64 ++++++---<br>
&nbsp;drivers/net/hns3/hns3_stats.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-=
<br>
&nbsp;drivers/net/hns3/hns3_stats.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-=
<br>
&nbsp;drivers/net/intel/cpfl/cpfl_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/intel/e1000/em_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 +-<br>
&nbsp;drivers/net/intel/e1000/igb_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +-<br>
&nbsp;drivers/net/intel/e1000/igc_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 33 +++--<br>
&nbsp;drivers/net/intel/fm10k/fm10k_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 27 ++--<br>
&nbsp;drivers/net/intel/i40e/i40e_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/net/intel/i40e/i40e_vf_representor.c&nbsp; |&nbsp;&nbsp; 2 +-=
<br>
&nbsp;drivers/net/intel/iavf/iavf_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/net/intel/ice/ice_dcf_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/intel/ice/ice_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/net/intel/idpf/idpf_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/intel/ipn3ke/ipn3ke_representor.c |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/intel/ixgbe/ixgbe_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 29 ++--<br>
&nbsp;drivers/net/ionic/ionic_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +-<br>
&nbsp;drivers/net/ionic/ionic_lif.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 35 +++--<b=
r>
&nbsp;drivers/net/ionic/ionic_lif.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-=
<br>
&nbsp;drivers/net/mana/mana.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 15 +-<br>
&nbsp;drivers/net/memif/rte_eth_memif.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 +-<br>
&nbsp;drivers/net/mlx4/mlx4.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/mlx4/mlx4_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +--<br>
&nbsp;drivers/net/mlx5/mlx5.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/mlx5/mlx5_stats.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +--<br>
&nbsp;drivers/net/mvneta/mvneta_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/net/mvpp2/mrvl_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 +--<br>
&nbsp;drivers/net/netvsc/hn_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +--<br>
&nbsp;drivers/net/netvsc/hn_var.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 3 +-<br>
&nbsp;drivers/net/netvsc/hn_vf.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/nfp/flower/nfp_flower.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-<br>
&nbsp;.../net/nfp/flower/nfp_flower_representor.c&nbsp;&nbsp; |&nbsp; 19 +-=
-<br>
&nbsp;.../net/nfp/flower/nfp_flower_representor.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +<br>
&nbsp;drivers/net/nfp/nfp_net_common.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 46 +++---<br>
&nbsp;drivers/net/nfp/nfp_net_common.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&nbsp;drivers/net/ngbe/ngbe_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 53 +++----<br>
&nbsp;drivers/net/ngbe/ngbe_ethdev_vf.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/net/ntnic/ntnic_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 22 +--<br>
&nbsp;drivers/net/null/rte_eth_null.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 +-<br>
&nbsp;drivers/net/octeon_ep/otx_ep_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 17 ++-<br>
&nbsp;drivers/net/octeontx/octeontx_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/pcap/pcap_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 +--<br>
&nbsp;drivers/net/pfe/pfe_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +-<br>
&nbsp;drivers/net/qede/qede_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 ++-<br>
&nbsp;drivers/net/r8169/r8169_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +-<br>
&nbsp;drivers/net/ring/rte_eth_ring.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 13 +-<br>
&nbsp;drivers/net/rnp/rnp_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 15 +-=
<br>
&nbsp;drivers/net/sfc/sfc_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +-<br>
&nbsp;drivers/net/sfc/sfc_repr.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 3 +-<br>
&nbsp;drivers/net/tap/rte_eth_tap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 +--<br>
&nbsp;drivers/net/thunderx/nicvf_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 27 ++--<br>
&nbsp;drivers/net/txgbe/txgbe_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 53 +++----<br>
&nbsp;drivers/net/txgbe/txgbe_ethdev_vf.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&nbsp;drivers/net/vhost/rte_eth_vhost.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 26 ++--<br>
&nbsp;drivers/net/virtio/virtio_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 23 +--<br>
&nbsp;drivers/net/vmxnet3/vmxnet3_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +--<br>
&nbsp;drivers/net/xsc/xsc_ethdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 19 +-=
-<br>
&nbsp;drivers/net/zxdh/zxdh_ethdev_ops.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 39 ++---<br>
&nbsp;drivers/net/zxdh/zxdh_ethdev_ops.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&nbsp;95 files changed, 828 insertions(+), 605 deletions(-)<br>
<br>
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_pac=
ket/rte_eth_af_packet.c<br>
index 85bc1201b4..88eb705a48 100644<br>
--- a/drivers/net/af_packet/rte_eth_af_packet.c<br>
+++ b/drivers/net/af_packet/rte_eth_af_packet.c<br>
@@ -426,7 +426,7 @@ packet_drop_count(int sockfd)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, struct=
 eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long rx_total =3D=
 0, rx_dropped_total =3D 0, rx_nombuf_total =3D 0;<br>
@@ -448,11 +448,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_err_total +=3D internal-&gt;tx_queue[i].err_pkts;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_bytes_total +=3D internal-&gt;tx_queue[i].tx_bytes=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D internal-&gt;rx_queue[i].rx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D internal-&gt;rx_queue[i].rx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D internal-&gt;tx_queue[i].tx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D internal-&gt;tx_queue[i].tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D internal-&gt;rx_queue[i].rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D internal-&gt;rx_queue[i].rx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D internal-&gt;tx_queue[i].tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D internal-&gt;tx_queue[i].tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D internal-&gt;rx_queue[i].rx_nombuf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_e=
th_af_xdp.c<br>
index f68895c93c..f2a8fb95d1 100644<br>
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c<br>
@@ -892,7 +892,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_de=
v_info *dev_info)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pmd_internals *inte=
rnals =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pmd_process_private=
 *process_private =3D dev-&gt;process_private;<br>
@@ -901,20 +902,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pkt_tx_queue *txq;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socklen_t optlen;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret, fd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ipackets =3D 0, ibytes =
=3D 0, opackets =3D 0, obytes =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long oerrors =3D 0, imissed =
=3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dev-&=
gt;data-&gt;nb_rx_queues; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; optlen =3D sizeof(struct xdp_statistics);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rxq =3D &amp;internals-&gt;rx_queues[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; txq =3D rxq-&gt;pair;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D rxq-&gt;stats.rx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D rxq-&gt;stats.rx_bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D txq-&gt;stats.tx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D txq-&gt;stats.tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rxq-&gt;stats.rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rxq-&gt;stats.rx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D txq-&gt;stats.tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D txq-&gt;stats.tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D 0; /* Not used */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ipackets +=3D stats-&gt;q_ipackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ibytes +=3D stats-&gt;q_ibytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;oerrors +=3D txq-&gt;stats.tx_dropped;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ipackets +=3D rxq-&gt;stats.rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ibytes +=3D rxq-&gt;stats.rx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; oerrors +=3D txq-&gt;stats.tx_dropped;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fd =3D process_private-&gt;rxq_xsk_fds[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D fd &gt;=3D 0 ? getsockopt(fd, SOL_XDP, XDP_ST=
ATISTICS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;xdp_stats, &amp;optlen) : -1;<br>
@@ -922,12 +928,19 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AF_XD=
P_LOG_LINE(ERR, &quot;getsockopt() failed for XDP_STATISTICS.&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;imissed +=3D xdp_stats.rx_dropped - rxq-&gt;stats.imis=
sed_offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; imissed +=3D xdp_stats.rx_dropped - rxq-&gt;stats.imissed_offset=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;opackets +=3D stats-&gt;q_opackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;obytes +=3D stats-&gt;q_obytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; opackets +=3D txq-&gt;stats.tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; obytes +=3D txq-&gt;stats.tx_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets =3D ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes =3D ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors =3D oerrors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed =3D imissed;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c<br=
>
index c029dc46b3..02d6683ab9 100644<br>
--- a/drivers/net/ark/ark_ethdev.c<br>
+++ b/drivers/net/ark/ark_ethdev.c<br>
@@ -37,7 +37,8 @@ static int eth_ark_dev_link_update(struct rte_eth_dev *de=
v,<br>
&nbsp;static int eth_ark_dev_set_link_up(struct rte_eth_dev *dev);<br>
&nbsp;static int eth_ark_dev_set_link_down(struct rte_eth_dev *dev);<br>
&nbsp;static int eth_ark_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)=
;<br>
&nbsp;static int eth_ark_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct rte_ether_addr *mac_addr);<br>
@@ -780,25 +781,36 @@ eth_ark_dev_set_link_down(struct rte_eth_dev *dev)<br=
>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)<br>
+eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ark_adapter *ark =
=3D dev-&gt;data-&gt;dev_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev_data *data =3D dev=
-&gt;data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize stats to 0 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(stats, 0, sizeof(*stats));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dev-&gt;data-&gt=
;nb_tx_queues; i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; eth_tx_queue_stats_get(dev-&gt;data-&gt;tx_queues[i], stats);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dev-&gt;data-&gt=
;nb_rx_queues; i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; eth_rx_queue_stats_get(dev-&gt;data-&gt;rx_queues[i], stats);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(qstats, 0, sizeof(*qstats));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get stats for each RX queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data-&gt;nb_rx_q=
ueues; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (data-&gt;rx_queues[i])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_rx_queue_sta=
ts_get(data-&gt;rx_queues[i], stats, qstats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get stats for each TX queue */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data-&gt;nb_tx_q=
ueues; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (data-&gt;tx_queues[i])<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_tx_queue_sta=
ts_get(data-&gt;tx_queues[i], stats, qstats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Call user extension if registered =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ark-&gt;user_ext.stats=
_get)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ark-&gt;user_ext.stats_get(dev, stats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ark-&=
gt;user_data[dev-&gt;data-&gt;port_id]);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_r=
x.c<br>
index 2fff0ffded..d7d480ac90 100644<br>
--- a/drivers/net/ark/ark_ethdev_rx.c<br>
+++ b/drivers/net/ark/ark_ethdev_rx.c<br>
@@ -560,13 +560,14 @@ eth_ark_dev_rx_queue_release(void *vqueue)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
-eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)<br>
+eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qsta=
ts)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ark_rx_queue *queue=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ark_udm_t *udm;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue =3D vqueue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udm =3D queue-&gt;udm;<br>
&nbsp;<br>
@@ -574,12 +575,15 @@ eth_rx_queue_stats_get(void *vqueue, struct rte_eth_s=
tats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ipackets =3D ark_=
udm_packets(udm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t idropped =3D ark_=
udm_dropped(queue-&gt;udm);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipackets[queue-&gt;queue_=
index] =3D ipackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibytes[queue-&gt;queue_in=
dex] =3D ibytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_errors[queue-&gt;queue_in=
dex] =3D idropped;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D ip=
ackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D ibyt=
es;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D idr=
opped;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats &amp;&amp; queue-&gt;queue=
_index &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_ipackets[queue-&gt;queue_index] =3D ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_ibytes[queue-&gt;queue_index] =3D ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_errors[queue-&gt;queue_index] =3D idropped;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
diff --git a/drivers/net/ark/ark_ethdev_rx.h b/drivers/net/ark/ark_ethdev_r=
x.h<br>
index 12d4f61637..27b87445b1 100644<br>
--- a/drivers/net/ark/ark_ethdev_rx.h<br>
+++ b/drivers/net/ark/ark_ethdev_rx.h<br>
@@ -23,7 +23,8 @@ int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint1=
6_t queue_id);<br>
&nbsp;uint16_t eth_ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint16_t nb_pkts);<br>
&nbsp;void eth_ark_dev_rx_queue_release(void *rx_queue);<br>
-void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);<br=
>
+void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;void eth_rx_queue_stats_reset(void *vqueue);<br>
&nbsp;void eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; const char *msg);<br>
diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev_t=
x.c<br>
index ca6cd297a1..5c22de6080 100644<br>
--- a/drivers/net/ark/ark_ethdev_tx.c<br>
+++ b/drivers/net/ark/ark_ethdev_tx.c<br>
@@ -415,23 +415,29 @@ free_completed_tx(struct ark_tx_queue *queue)<br>
&nbsp;<br>
&nbsp;/* ******************************************************************=
******* */<br>
&nbsp;void<br>
-eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)<br>
+eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qsta=
ts)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ark_tx_queue *queue=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ark_ddm_t *ddm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bytes, pkts;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue =3D vqueue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ddm =3D queue-&gt;ddm;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D ark_ddm_queue_by=
te_count(ddm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pkts =3D ark_ddm_queue_pkt=
_count(ddm);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opackets[queue-&gt;queue_=
index] =3D pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obytes[queue-&gt;queue_in=
dex] =3D bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets +=3D pk=
ts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D byte=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D que=
ue-&gt;tx_errors;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats &amp;&amp; queue-&gt;queue=
_index &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_opackets[queue-&gt;queue_index] =3D pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_obytes[queue-&gt;queue_index] =3D bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
diff --git a/drivers/net/ark/ark_ethdev_tx.h b/drivers/net/ark/ark_ethdev_t=
x.h<br>
index 7134dbfeed..639ee8adb4 100644<br>
--- a/drivers/net/ark/ark_ethdev_tx.h<br>
+++ b/drivers/net/ark/ark_ethdev_tx.h<br>
@@ -21,7 +21,8 @@ int eth_ark_tx_queue_setup(struct rte_eth_dev *dev,<br>
&nbsp;void eth_ark_tx_queue_release(void *vtx_queue);<br>
&nbsp;int eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id)=
;<br>
&nbsp;int eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id=
);<br>
-void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);<br=
>
+void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;void eth_tx_queue_stats_reset(void *vqueue);<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_e=
thdev.c<br>
index 9cde935834..2925dc2478 100644<br>
--- a/drivers/net/atlantic/atl_ethdev.c<br>
+++ b/drivers/net/atlantic/atl_ethdev.c<br>
@@ -33,7 +33,7 @@ static int atl_dev_xstats_get_names(struct rte_eth_dev *d=
ev __rte_unused,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned=
 int size);<br>
&nbsp;<br>
&nbsp;static int atl_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct eth_que=
ue_stats *qstats);<br>
&nbsp;<br>
&nbsp;static int atl_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *stats, unsigned int n)=
;<br>
@@ -930,7 +930,8 @@ int atl_macsec_select_rxsa(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br=
>
+atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atl_adapter *adapte=
r =3D ATL_DEV_TO_ADAPTER(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aq_hw_s *hw =3D &am=
p;adapter-&gt;hw;<br>
@@ -951,12 +952,14 @@ atl_dev_stats_get(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;rx_nombuf =3D sw=
stats-&gt;rx_nombuf;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_ETHDEV_QUEUE=
_STAT_CNTRS; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D swstats-&gt;q_ipackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D swstats-&gt;q_opackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D swstats-&gt;q_ibytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D swstats-&gt;q_obytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D swstats-&gt;q_errors[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D swstats-&gt;q_ipackets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D swstats-&gt;q_opackets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D swstats-&gt;q_ibytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D swstats-&gt;q_obytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D swstats-&gt;q_errors[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/net/atlantic/atl_types.h b/drivers/net/atlantic/atl_ty=
pes.h<br>
index e813d9f326..dfd7016600 100644<br>
--- a/drivers/net/atlantic/atl_types.h<br>
+++ b/drivers/net/atlantic/atl_types.h<br>
@@ -13,6 +13,7 @@<br>
&nbsp;#include &lt;pthread.h&gt;<br>
&nbsp;<br>
&nbsp;#include &lt;rte_common.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;<br>
&nbsp;typedef uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8;<b=
r>
&nbsp;typedef int8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
s8;<br>
diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c<br=
>
index ed44c1645d..3bc5171336 100644<br>
--- a/drivers/net/avp/avp_ethdev.c<br>
+++ b/drivers/net/avp/avp_ethdev.c<br>
@@ -79,7 +79,8 @@ static void avp_dev_rx_queue_release(struct rte_eth_dev *=
dev, uint16_t qid);<br>
&nbsp;static void avp_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_=
t qid);<br>
&nbsp;<br>
&nbsp;static int avp_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;static int avp_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;<br>
&nbsp;<br>
@@ -2241,7 +2242,8 @@ avp_vlan_offload_set(struct rte_eth_dev *eth_dev, int=
 mask)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats=
)<br>
+avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct avp_dev *avp =3D AV=
P_DEV_PRIVATE_TO_HW(eth_dev-&gt;data-&gt;dev_private);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
@@ -2254,9 +2256,11 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struc=
t rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;ibytes +=3D rxq-&gt;bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;ierrors +=3D rxq-&gt;errors;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] +=3D rxq-&gt;packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] +=3D rxq-&gt;bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] +=3D rxq-&gt;errors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D =
NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipackets[i] +=3D rxq-&gt;packe=
ts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ibytes[i] +=3D rxq-&gt;bytes;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_errors[i] +=3D rxq-&gt;errors;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -2268,8 +2272,10 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struc=
t rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;obytes +=3D txq-&gt;bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;oerrors +=3D txq-&gt;errors;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] +=3D txq-&gt;packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] +=3D txq-&gt;bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D =
NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opackets[i] +=3D txq-&gt;packe=
ts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_obytes[i] +=3D txq-&gt;bytes;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_eth=
dev.c<br>
index bc73536604..31d35ff182 100644<br>
--- a/drivers/net/axgbe/axgbe_ethdev.c<br>
+++ b/drivers/net/axgbe/axgbe_ethdev.c<br>
@@ -51,7 +51,8 @@ static int axgbe_dev_link_update(struct rte_eth_dev *dev,=
<br>
&nbsp;static int axgbe_dev_get_regs(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_dev_reg_info *regs);<br>
&nbsp;static int axgbe_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;static int axgbe_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int axgbe_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *stats,<br>
@@ -1133,7 +1134,7 @@ axgbe_dev_xstats_reset(struct rte_eth_dev *dev)<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;axgbe_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct eth_=
queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct axgbe_rx_queue *rxq=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct axgbe_tx_queue *txq=
;<br>
@@ -1148,14 +1149,16 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dev-&=
gt;data-&gt;nb_rx_queues; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rxq =3D dev-&gt;data-&gt;rx_queues[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (rxq) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D rxq-&gt;pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;ipackets +=3D rxq-&gt;pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D rxq-&gt;bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;ibytes +=3D rxq-&gt;bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;rx_nombuf +=3D rxq-&gt;rx_mbuf_alloc_failed;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] =3D rxq-&gt;errors<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + rxq-&gt;rx_mbuf_alloc_failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;ierrors +=3D rxq-&gt;errors;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D =
NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipackets[i] =3D rxq-&gt;pkts;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ibytes[i] =3D rxq-&gt;bytes;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_errors[i] =3D rxq-&gt;errors +=
 rxq-&gt;rx_mbuf_alloc_failed;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PMD_D=
RV_LOG_LINE(DEBUG, &quot;Rx queue not setup for port %d&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev-&gt;data-&gt;port_id);<br>
@@ -1165,11 +1168,14 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dev-&=
gt;data-&gt;nb_tx_queues; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; txq =3D dev-&gt;data-&gt;tx_queues[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (txq) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D txq-&gt;pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;opackets +=3D txq-&gt;pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D txq-&gt;bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;obytes +=3D txq-&gt;bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats=
-&gt;oerrors +=3D txq-&gt;errors;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D =
NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opackets[i] =3D txq-&gt;pkts;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_obytes[i] =3D txq-&gt;bytes;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PMD_D=
RV_LOG_LINE(DEBUG, &quot;Tx queue not setup for port %d&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev-&gt;data-&gt;port_id);<br>
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_eth=
dev.h<br>
index 5cd4317d7a..b94a7f3562 100644<br>
--- a/drivers/net/axgbe/axgbe_ethdev.h<br>
+++ b/drivers/net/axgbe/axgbe_ethdev.h<br>
@@ -8,6 +8,7 @@<br>
&nbsp;<br>
&nbsp;#include &lt;rte_mempool.h&gt;<br>
&nbsp;#include &lt;rte_lcore.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;#include &quot;axgbe_common.h&quot;<br>
&nbsp;#include &quot;rte_time.h&quot;<br>
&nbsp;<br>
diff --git a/drivers/net/bnx2x/bnx2x_ethdev.c b/drivers/net/bnx2x/bnx2x_eth=
dev.c<br>
index 1327cbe912..5e2e555525 100644<br>
--- a/drivers/net/bnx2x/bnx2x_ethdev.c<br>
+++ b/drivers/net/bnx2x/bnx2x_ethdev.c<br>
@@ -427,7 +427,8 @@ bnx2xvf_dev_link_update(struct rte_eth_dev *dev, __rte_=
unused int wait_to_comple<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-bnx2x_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<=
br>
+bnx2x_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unu=
sed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bnx2x_softc *sc =3D=
 dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t brb_truncate_disc=
ard;<br>
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c<br=
>
index 6f5c3f80eb..bd3bfb8209 100644<br>
--- a/drivers/net/bnxt/bnxt_reps.c<br>
+++ b/drivers/net/bnxt/bnxt_reps.c<br>
@@ -877,7 +877,7 @@ void bnxt_rep_tx_queue_release_op(struct rte_eth_dev *d=
ev, uint16_t queue_idx)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats)<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bnxt_representor *r=
ep_bp =3D eth_dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
@@ -890,11 +890,13 @@ int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D rep_bp-&gt;rx_pkts[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D rep_bp-&gt;rx_drop_pkts[i];<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D rep_bp-&gt;rx_pkts[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D rep_bp-&gt;rx_bytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D rep_bp-&gt;tx_pkts[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D rep_bp-&gt;tx_bytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D rep_bp-&gt;rx_drop_pkts[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rep_bp-&gt;rx_pkts[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rep_bp-&gt;rx_bytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D rep_bp-&gt;tx_pkts[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D rep_bp-&gt;tx_bytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D rep_bp-&gt;rx_drop_pkts[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/net/bnxt/bnxt_reps.h b/drivers/net/bnxt/bnxt_reps.h<br=
>
index 3f2db9d1ae..1615ecf11c 100644<br>
--- a/drivers/net/bnxt/bnxt_reps.h<br>
+++ b/drivers/net/bnxt/bnxt_reps.h<br>
@@ -47,7 +47,7 @@ void bnxt_rep_tx_queue_release_op(struct rte_eth_dev *dev=
, uint16_t queue_idx);<br>
&nbsp;int&nbsp; bnxt_rep_dev_stop_op(struct rte_eth_dev *eth_dev);<br>
&nbsp;int bnxt_rep_dev_close_op(struct rte_eth_dev *eth_dev);<br>
&nbsp;int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats);=
<br>
&nbsp;int bnxt_rep_stats_reset_op(struct rte_eth_dev *eth_dev);<br>
&nbsp;int bnxt_rep_stop_all(struct bnxt *bp);<br>
&nbsp;#endif /* _BNXT_REPS_H_ */<br>
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c<=
br>
index 9d7cdf925d..53f5613eb3 100644<br>
--- a/drivers/net/bnxt/bnxt_stats.c<br>
+++ b/drivers/net/bnxt/bnxt_stats.c<br>
@@ -561,84 +561,95 @@ void bnxt_free_stats(struct bnxt *bp)<br>
&nbsp;<br>
&nbsp;static void bnxt_fill_rte_eth_stats_ext(struct rte_eth_stats *stats,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct bnxt_ring_stats_ext *ring_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct eth_queue_stats *qstats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; unsigned int i, bool rx)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rx) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D ring_stats-&gt;rx_ucast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] +=3D ring_stats-&gt;rx_mcast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] +=3D ring_stats-&gt;rx_bcast_pkts;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ipackets +=3D stats-&gt;q_ipackets[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D ring_stats-&gt;rx_ucast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] +=3D ring_stats-&gt;rx_mcast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] +=3D ring_stats-&gt;rx_bcast_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ibytes +=3D stats-&gt;q_ibytes[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D ring_stats-&gt;rx_discard_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] +=3D ring_stats-&gt;rx_error_pkts;<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t ipackets =3D ring_stats-&gt;rx_ucast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_mcast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_bcast_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t ibytes =3D ring_stats-&gt;rx_ucast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_mcast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_bcast_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t ierrors =3D ring_stats-&gt;rx_discard_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_error_pkts;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ipackets +=3D ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ibytes +=3D ibytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D ring_stats-&gt;rx_discard_pkts=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors +=3D ring_stats-&gt;rx_error_pkts;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D ring_stats-&gt;tx_ucast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] +=3D ring_stats-&gt;tx_mcast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] +=3D ring_stats-&gt;tx_bcast_pkts;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;opackets +=3D stats-&gt;q_opackets[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D ring_stats-&gt;tx_ucast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] +=3D ring_stats-&gt;tx_mcast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] +=3D ring_stats-&gt;tx_bcast_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;obytes +=3D stats-&gt;q_obytes[i];<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D ierrors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t opackets =3D ring_stats-&gt;tx_ucast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_mcast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_bcast_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t obytes =3D ring_stats-&gt;tx_ucast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_mcast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_bcast_bytes;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;opackets +=3D opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;obytes +=3D obytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D ring_stats-&gt;tx_discard_pkts=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void bnxt_fill_rte_eth_stats(struct rte_eth_stats *stats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct b=
nxt_ring_stats *ring_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_st=
ats *qstats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned=
 int i, bool rx)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rx) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D ring_stats-&gt;rx_ucast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] +=3D ring_stats-&gt;rx_mcast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] +=3D ring_stats-&gt;rx_bcast_pkts;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ipackets +=3D stats-&gt;q_ipackets[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D ring_stats-&gt;rx_ucast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] +=3D ring_stats-&gt;rx_mcast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] +=3D ring_stats-&gt;rx_bcast_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ibytes +=3D stats-&gt;q_ibytes[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D ring_stats-&gt;rx_discard_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] +=3D ring_stats-&gt;rx_error_pkts;<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t ipackets =3D ring_stats-&gt;rx_ucast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_mcast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_bcast_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t ibytes =3D ring_stats-&gt;rx_ucast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_mcast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_bcast_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t ierrors =3D ring_stats-&gt;rx_discard_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;rx_error_pkts;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ipackets +=3D ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ibytes +=3D ibytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D ring_stats-&gt;rx_discard_pkts=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors +=3D ring_stats-&gt;rx_error_pkts;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D ring_stats-&gt;tx_ucast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] +=3D ring_stats-&gt;tx_mcast_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] +=3D ring_stats-&gt;tx_bcast_pkts;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;opackets +=3D stats-&gt;q_opackets[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D ring_stats-&gt;tx_ucast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] +=3D ring_stats-&gt;tx_mcast_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] +=3D ring_stats-&gt;tx_bcast_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;obytes +=3D stats-&gt;q_obytes[i];<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D ierrors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t opackets =3D ring_stats-&gt;tx_ucast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_mcast_pkts +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_bcast_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t obytes =3D ring_stats-&gt;tx_ucast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_mcast_bytes +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_stats-&gt;tx_bcast_bytes;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;opackets +=3D opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;obytes +=3D obytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D ring_stats-&gt;tx_discard_pkts=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *bnxt_stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *bnxt_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
@@ -661,7 +672,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(rc))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n rc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats_ext(bnxt_stats, &amp;ring_stats, i, true=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats_ext(bnxt_stats, &amp;ring_stats, qstats,=
 i, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bnxt_stats-&gt;rx_nombuf +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_atomic_load_explicit(&amp;rx=
q-&gt;rx_mbuf_alloc_fail,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memory_order_relaxed);<br>
@@ -683,14 +694,14 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth=
_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(rc))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n rc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats_ext(bnxt_stats, &amp;ring_stats, i, fals=
e);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats_ext(bnxt_stats, &amp;ring_stats, qstats,=
 i, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *bnxt_s=
tats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *bnxt_s=
tats, struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
@@ -705,7 +716,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EIO;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (BNXT_TPA_V2_P7(bp))<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return bnxt_stats_get_ext(eth_dev, bnxt_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_q_stats =3D RTE_MIN(bp=
-&gt;rx_cp_nr_rings,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);<=
br>
@@ -723,7 +734,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(rc))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n rc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats(bnxt_stats, &amp;ring_stats, i, true);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats(bnxt_stats, &amp;ring_stats, qstats, i, =
true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bnxt_stats-&gt;rx_nombuf +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_atomic_load_explicit(&amp;rx=
q-&gt;rx_mbuf_alloc_fail,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memory_order_relaxed);<br>
@@ -745,7 +756,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(rc))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n rc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats(bnxt_stats, &amp;ring_stats, i, false);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bnxt_fill_rte_eth_stats(bnxt_stats, &amp;ring_stats, qstats, i, =
false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bnxt_stats-&gt;oerrors +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_atomic_load_explicit(&amp;tx=
q-&gt;tx_mbuf_drop,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memory_order_relaxed);<br>
diff --git a/drivers/net/bnxt/bnxt_stats.h b/drivers/net/bnxt/bnxt_stats.h<=
br>
index e46c05eed3..c0508e773a 100644<br>
--- a/drivers/net/bnxt/bnxt_stats.h<br>
+++ b/drivers/net/bnxt/bnxt_stats.h<br>
@@ -10,7 +10,7 @@<br>
&nbsp;<br>
&nbsp;void bnxt_free_stats(struct bnxt *bp);<br>
&nbsp;int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct rte_eth_stats *bnxt_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct rte_eth_stats *bnxt_stats, struct eth_queue_stats *qstats);<br>
&nbsp;int bnxt_stats_reset_op(struct rte_eth_dev *eth_dev);<br>
&nbsp;int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat_name =
*xstats_names,<br>
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/r=
te_eth_bond_pmd.c<br>
index 4906701a95..b7bab6bc99 100644<br>
--- a/drivers/net/bonding/rte_eth_bond_pmd.c<br>
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c<br>
@@ -2636,11 +2636,12 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev,=
 int wait_to_complete)<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;static int<br>
-bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)<br>
+bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qsta=
ts __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bond_dev_private *i=
nternals =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats membe=
r_stats;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; inter=
nals-&gt;member_count; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_eth_stats_get(internals-&gt;members[i].port_id, &=
amp;member_stats);<br>
@@ -2653,15 +2654,6 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struc=
t rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors +=3D member_stats.ierrors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D member_stats.oerrors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;rx_nombuf +=3D member_stats.rx_nombuf;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS; j++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[j] +=3D member_stats.q_ipackets[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[j] +=3D member_stats.q_opackets[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[j] +=3D member_stats.q_ibytes[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[j] +=3D member_stats.q_obytes[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[j] +=3D member_stats.q_errors[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.=
h<br>
index 7868185768..67867c889b 100644<br>
--- a/drivers/net/cnxk/cnxk_ethdev.h<br>
+++ b/drivers/net/cnxk/cnxk_ethdev.h<br>
@@ -682,7 +682,8 @@ int cnxk_nix_link_update(struct rte_eth_dev *eth_dev, i=
nt wait_to_complete);<br>
&nbsp;int cnxk_nix_queue_stats_mapping(struct rte_eth_dev *dev, uint16_t qu=
eue_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t stat_idx, uint8_t =
is_rx);<br>
&nbsp;int cnxk_nix_stats_reset(struct rte_eth_dev *dev);<br>
-int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s);<br>
+int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats=
 *qstats);<br>
&nbsp;int cnxk_nix_xstats_get(struct rte_eth_dev *eth_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t rte_eth_xstat *xstats, unsigned int n);<br>
&nbsp;int cnxk_nix_xstats_get_names(struct rte_eth_dev *eth_dev,<br>
diff --git a/drivers/net/cnxk/cnxk_rep.h b/drivers/net/cnxk/cnxk_rep.h<br>
index b9601854ce..9ede1e6dad 100644<br>
--- a/drivers/net/cnxk/cnxk_rep.h<br>
+++ b/drivers/net/cnxk/cnxk_rep.h<br>
@@ -130,7 +130,8 @@ void cnxk_rep_rx_queue_release(struct rte_eth_dev *dev,=
 uint16_t queue_idx);<br>
&nbsp;void cnxk_rep_tx_queue_release(struct rte_eth_dev *dev, uint16_t queu=
e_idx);<br>
&nbsp;int cnxk_rep_dev_stop(struct rte_eth_dev *eth_dev);<br>
&nbsp;int cnxk_rep_dev_close(struct rte_eth_dev *eth_dev);<br>
-int cnxk_rep_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *=
stats);<br>
+int cnxk_rep_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *=
stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats=
 *qstats);<br>
&nbsp;int cnxk_rep_stats_reset(struct rte_eth_dev *eth_dev);<br>
&nbsp;int cnxk_rep_flow_ops_get(struct rte_eth_dev *ethdev, const struct rt=
e_flow_ops **ops);<br>
&nbsp;int cnxk_rep_state_update(struct cnxk_eswitch_dev *eswitch_dev, uint3=
2_t state, uint16_t *rep_id);<br>
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_op=
s.c<br>
index c88d28ff72..c481015592 100644<br>
--- a/drivers/net/cnxk/cnxk_rep_ops.c<br>
+++ b/drivers/net/cnxk/cnxk_rep_ops.c<br>
@@ -574,7 +574,8 @@ native_repte_eth_stats(struct cnxk_rep_dev *rep_dev, st=
ruct rte_eth_stats *stats<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int<br>
-cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats=
)<br>
+cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cnxk_rep_dev *rep_d=
ev =3D cnxk_rep_pmd_priv(ethdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats vf_st=
ats;<br>
@@ -612,13 +613,15 @@ cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct=
 rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rte_memcpy(&amp;vf_stats, adata.u.data, adata.size);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipackets[0] =3D vf_stats.=
ipackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibytes[0] =3D vf_stats.ib=
ytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_ipackets[0] =3D vf_stats.ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_ibytes[0] =3D vf_stats.ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_opackets[0] =3D vf_stats.opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qstats-&gt;q_obytes[0] =3D vf_stats.obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets =3D vf_=
stats.ipackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes =3D vf_st=
ats.ibytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opackets[0] =3D vf_stats.=
opackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obytes[0] =3D vf_stats.ob=
ytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D vf_=
stats.opackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D vf_st=
ats.obytes;<br>
&nbsp;<br>
diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c<=
br>
index 469faff405..d57659ef51 100644<br>
--- a/drivers/net/cnxk/cnxk_stats.c<br>
+++ b/drivers/net/cnxk/cnxk_stats.c<br>
@@ -8,7 +8,8 @@<br>
&nbsp;#define CNXK_NB_TXQ_STATS 4<br>
&nbsp;<br>
&nbsp;int<br>
-cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stat=
s)<br>
+cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stat=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cnxk_eth_dev *dev =
=3D cnxk_eth_pmd_priv(eth_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct roc_nix *nix =3D &a=
mp;dev-&gt;nix;<br>
@@ -32,28 +33,30 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct =
rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes =3D nix_s=
tats.rx_octs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors =3D nix_=
stats.rx_err;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_ETHDEV_QUEUE=
_STAT_CNTRS; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct roc_nix_stats_queue qstats;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t qidx;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dev-&gt;txq_stat_map[i] &amp; (1U &lt;&lt; 31)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qidx =3D dev-&gt=
;txq_stat_map[i] &amp; 0xFFFF;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D roc_nix_s=
tats_queue_get(nix, qidx, 0, &amp;qstats);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D qstats.tx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D qstats.tx_octs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] =3D qstats.tx_drop_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dev-&gt;rxq_stat_map[i] &amp; (1U &lt;&lt; 31)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qidx =3D dev-&gt=
;rxq_stat_map[i] &amp; 0xFFFF;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D roc_nix_s=
tats_queue_get(nix, qidx, 1, &amp;qstats);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D qstats.rx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D qstats.rx_octs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] +=3D qstats.rx_drop_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct roc_nix_s=
tats_queue qstats_data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t qidx;<b=
r>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;txq_=
stat_map[i] &amp; (1U &lt;&lt; 31)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qidx =3D dev-&gt;txq_stat_map[i] &amp; 0xFF=
FF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D roc_nix_stats_queue_get(nix, qidx, 0=
, &amp;qstats_data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto exit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opackets[i] =3D qstats_data.tx=
_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_obytes[i] =3D qstats_data.tx_o=
cts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_errors[i] =3D qstats_data.tx_d=
rop_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;rxq_=
stat_map[i] &amp; (1U &lt;&lt; 31)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qidx =3D dev-&gt;rxq_stat_map[i] &amp; 0xFF=
FF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D roc_nix_stats_queue_get(nix, qidx, 1=
, &amp;qstats_data);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto exit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipackets[i] =3D qstats_data.rx=
_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ibytes[i] =3D qstats_data.rx_o=
cts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_errors[i] +=3D qstats_data.rx_=
drop_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;exit:<br>
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_eth=
dev.c<br>
index 9b6a3651f9..0c337a6cc8 100644<br>
--- a/drivers/net/cxgbe/cxgbe_ethdev.c<br>
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c<br>
@@ -701,7 +701,8 @@ void cxgbe_dev_rx_queue_release(struct rte_eth_dev *eth=
_dev, uint16_t qid)<br>
&nbsp; * Get port statistics.<br>
&nbsp; */<br>
&nbsp;static int cxgbe_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *eth_stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *eth_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unused=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct port_info *pi =3D e=
th_dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct adapter *adapter =
=3D pi-&gt;adapter;<br>
diff --git a/drivers/net/cxgbe/cxgbevf_ethdev.c b/drivers/net/cxgbe/cxgbevf=
_ethdev.c<br>
index a62c56c2b9..d8eba8afef 100644<br>
--- a/drivers/net/cxgbe/cxgbevf_ethdev.c<br>
+++ b/drivers/net/cxgbe/cxgbevf_ethdev.c<br>
@@ -34,7 +34,8 @@<br>
&nbsp; * Get port statistics.<br>
&nbsp; */<br>
&nbsp;static int cxgbevf_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *eth_stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *eth_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_=
unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct port_info *pi =3D e=
th_dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct adapter *adapter =
=3D pi-&gt;adapter;<br>
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.=
c<br>
index 34b691fde7..789a55c2a0 100644<br>
--- a/drivers/net/dpaa/dpaa_ethdev.c<br>
+++ b/drivers/net/dpaa/dpaa_ethdev.c<br>
@@ -855,7 +855,8 @@ static int dpaa_eth_link_update(struct rte_eth_dev *dev=
,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int dpaa_eth_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PMD_INIT_FUNC_TRACE();<br>
&nbsp;<br>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_eth=
dev.c<br>
index 41678ce09b..ada4a79b36 100644<br>
--- a/drivers/net/dpaa2/dpaa2_ethdev.c<br>
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c<br>
@@ -1602,7 +1602,7 @@ dpaa2_dev_set_mac_addr(struct rte_eth_dev *dev,<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;dpaa2_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct e=
th_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpaa2_dev_priv *pri=
v =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fsl_mc_io *dpni =3D=
 dev-&gt;process_private;<br>
@@ -1659,18 +1659,20 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed =3D valu=
e.page_2.ingress_nobuffer_discards;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in per queue stats=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; (i &lt; RTE_ETHDEV_QUEU=
E_STAT_CNTRS) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (i &lt; priv-&gt;nb_rx_queues || i &lt; priv-&gt;nb_tx_queues); =
++i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dpaa2_rxq =3D priv-&gt;rx_vq[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dpaa2_txq =3D priv-&gt;tx_vq[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dpaa2_rxq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D dpaa2_rxq-&gt;rx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dpaa2_txq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D dpaa2_txq-&gt;tx_pkts;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Byte counting is not implemented */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i]&nbsp;&nbsp; =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i]&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) &amp;&amp;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i &lt; priv-&gt=
;nb_rx_queues || i &lt; priv-&gt;nb_tx_queues); ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpaa2_rxq =3D pr=
iv-&gt;rx_vq[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpaa2_txq =3D pr=
iv-&gt;tx_vq[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpaa2_rxq)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipackets[i] =3D dpaa2_rxq-&gt;=
rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpaa2_txq)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opackets[i] =3D dpaa2_txq-&gt;=
tx_pkts;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Byte counting=
 is not implemented */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i]&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i]&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c<br=
>
index f5cf5c3811..448de25fdc 100644<br>
--- a/drivers/net/ena/ena_ethdev.c<br>
+++ b/drivers/net/ena/ena_ethdev.c<br>
@@ -9,6 +9,7 @@<br>
&nbsp;#include &lt;rte_version.h&gt;<br>
&nbsp;#include &lt;rte_net.h&gt;<br>
&nbsp;#include &lt;rte_kvargs.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;ena_ethdev.h&quot;<br>
&nbsp;#include &quot;ena_logs.h&quot;<br>
@@ -270,7 +271,8 @@ static int ena_start(struct rte_eth_dev *dev);<br>
&nbsp;static int ena_stop(struct rte_eth_dev *dev);<br>
&nbsp;static int ena_close(struct rte_eth_dev *dev);<br>
&nbsp;static int ena_dev_reset(struct rte_eth_dev *dev);<br>
-static int ena_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *st=
ats);<br>
+static int ena_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *st=
ats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct eth_queue_stats *qstats);<br>
&nbsp;static void ena_rx_queue_release_all(struct rte_eth_dev *dev);<br>
&nbsp;static void ena_tx_queue_release_all(struct rte_eth_dev *dev);<br>
&nbsp;static void ena_rx_queue_release(struct rte_eth_dev *dev, uint16_t qi=
d);<br>
@@ -1240,7 +1242,8 @@ static void ena_stats_restart(struct rte_eth_dev *dev=
)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int ena_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ena_admin_basic_sta=
ts ena_stats;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ena_adapter *adapte=
r =3D dev-&gt;data-&gt;dev_private;<br>
@@ -1276,26 +1279,29 @@ static int ena_stats_get(struct rte_eth_dev *dev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors =3D rte_=
atomic64_read(&amp;adapter-&gt;drv_stats-&gt;oerrors);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;rx_nombuf =3D rt=
e_atomic64_read(&amp;adapter-&gt;drv_stats-&gt;rx_nombuf);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_rings_stats =3D RTE_MIN(dev-&gt;d=
ata-&gt;nb_rx_queues,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_ETHDEV_QUEUE_STAT_CNTRS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; max_rings_stats;=
 ++i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ena_stats_rx *rx_stats =3D &amp;adapter-&gt;rx_ring[i].rx=
_stats;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D rx_stats-&gt;bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D rx_stats-&gt;cnt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D rx_stats-&gt;bad_desc_num +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad=
_req_id +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad=
_desc +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;unk=
nown_error;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Queue statistics */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_rings_stats =3D RTE_MIN(dev-&gt;data-&gt;nb_rx_queues,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETHDEV_QUEUE=
_STAT_CNTRS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; max_rings_stats; ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ena_stats=
_rx *rx_stats =3D &amp;adapter-&gt;rx_ring[i].rx_stats;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rx_stats-&gt;bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rx_stats-&gt;cnt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D rx_stats-&gt;bad_desc_num +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad_req_id +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad_desc +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;unknown_error;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_rings_stats =3D RTE_MIN(dev-&gt;d=
ata-&gt;nb_tx_queues,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_ETHDEV_QUEUE_STAT_CNTRS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; max_rings_stats;=
 ++i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ena_stats_tx *tx_stats =3D &amp;adapter-&gt;tx_ring[i].tx=
_stats;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; max_rings_stats =3D RTE_MIN(dev-&gt;data-&gt;nb_tx_queues,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETHDEV_QUEUE=
_STAT_CNTRS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; max_rings_stats; ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ena_stats=
_tx *tx_stats =3D &amp;adapter-&gt;tx_ring[i].tx_stats;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D tx_stats-&gt;bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D tx_stats-&gt;cnt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D tx_stats-&gt;bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D tx_stats-&gt;cnt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_eth=
dev.c<br>
index ffbecc407c..37a61f8ff6 100644<br>
--- a/drivers/net/enetc/enetc_ethdev.c<br>
+++ b/drivers/net/enetc/enetc_ethdev.c<br>
@@ -4,6 +4,7 @@<br>
&nbsp;<br>
&nbsp;#include &lt;stdbool.h&gt;<br>
&nbsp;#include &lt;ethdev_pci.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;#include &lt;rte_random.h&gt;<br>
&nbsp;#include &lt;dpaax_iova_table.h&gt;<br>
&nbsp;<br>
@@ -543,7 +544,8 @@ enetc_rx_queue_release(struct rte_eth_dev *dev, uint16_=
t qid)<br>
&nbsp;<br>
&nbsp;static<br>
&nbsp;int enetc_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unu=
sed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct enetc_eth_hw *hw =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ENETC_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private)=
;<br>
diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_e=
thdev.c<br>
index 7c2926409e..c336db75e8 100644<br>
--- a/drivers/net/enetfec/enet_ethdev.c<br>
+++ b/drivers/net/enetfec/enet_ethdev.c<br>
@@ -314,7 +314,8 @@ enetfec_set_mac_address(struct rte_eth_dev *dev,<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;enetfec_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct enetfec_private *fe=
p =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *eth_=
stats =3D &amp;fep-&gt;stats;<br>
diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h<br>
index dc1d16f7d5..87f6b35fcd 100644<br>
--- a/drivers/net/enic/enic.h<br>
+++ b/drivers/net/enic/enic.h<br>
@@ -419,7 +419,8 @@ int enic_disable(struct enic *enic);<br>
&nbsp;void enic_remove(struct enic *enic);<br>
&nbsp;int enic_get_link_status(struct enic *enic);<br>
&nbsp;int enic_dev_stats_get(struct enic *enic,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *=
r_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *=
r_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats=
 *qstats __rte_unused);<br>
&nbsp;int enic_dev_stats_clear(struct enic *enic);<br>
&nbsp;int enic_add_packet_filter(struct enic *enic);<br>
&nbsp;int enic_set_mac_address(struct enic *enic, uint8_t *mac_addr);<br>
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.=
c<br>
index 749cc9ca5c..a853a5047a 100644<br>
--- a/drivers/net/enic/enic_ethdev.c<br>
+++ b/drivers/net/enic/enic_ethdev.c<br>
@@ -432,12 +432,12 @@ static int enicpmd_dev_link_update(struct rte_eth_dev=
 *eth_dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int enicpmd_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct e=
th_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct enic *enic =3D pmd_=
priv(eth_dev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENICPMD_FUNC_TRACE();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return enic_dev_stats_get(enic, stats=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return enic_dev_stats_get(enic, stats=
, qstats);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int enicpmd_dev_stats_reset(struct rte_eth_dev *eth_dev)<br>
diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c<br=
>
index 4124c48b85..2696fa77d4 100644<br>
--- a/drivers/net/enic/enic_main.c<br>
+++ b/drivers/net/enic/enic_main.c<br>
@@ -111,7 +111,8 @@ int enic_dev_stats_clear(struct enic *enic)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats)<b=
r>
+int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue=
_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vnic_stats *stats;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct enic_soft_stats *so=
ft_stats =3D &amp;enic-&gt;soft_stats;<br>
diff --git a/drivers/net/enic/enic_vf_representor.c b/drivers/net/enic/enic=
_vf_representor.c<br>
index 8469e06de9..05b2efedcb 100644<br>
--- a/drivers/net/enic/enic_vf_representor.c<br>
+++ b/drivers/net/enic/enic_vf_representor.c<br>
@@ -419,13 +419,14 @@ static int enic_vf_link_update(struct rte_eth_dev *et=
h_dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int enic_vf_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct e=
th_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct enic_vf_representor=
 *vf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vnic_stats *vs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENICPMD_FUNC_TRACE();<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vf =3D eth_dev-&gt;data-&g=
t;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get VF stats via PF */<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D vnic_dev_stats_dum=
p(vf-&gt;enic.vdev, &amp;vs);<br>
diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/f=
ailsafe_ether.c<br>
index dc4aba6e30..f0fd662c7b 100644<br>
--- a/drivers/net/failsafe/failsafe_ether.c<br>
+++ b/drivers/net/failsafe/failsafe_ether.c<br>
@@ -565,8 +565,6 @@ failsafe_eth_dev_state_sync(struct rte_eth_dev *dev)<br=
>
&nbsp;void<br>
&nbsp;failsafe_stats_increment(struct rte_eth_stats *to, struct rte_eth_sta=
ts *from)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ASSERT(to !=3D NULL &a=
mp;&amp; from !=3D NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to-&gt;ipackets +=3D from-=
&gt;ipackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to-&gt;opackets +=3D from-=
&gt;opackets;<br>
@@ -576,13 +574,6 @@ failsafe_stats_increment(struct rte_eth_stats *to, str=
uct rte_eth_stats *from)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to-&gt;ierrors +=3D from-&=
gt;ierrors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to-&gt;oerrors +=3D from-&=
gt;oerrors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to-&gt;rx_nombuf +=3D from=
-&gt;rx_nombuf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_ETHDEV_QUEUE=
_STAT_CNTRS; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; to-&gt;q_ipackets[i] +=3D from-&gt;q_ipackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; to-&gt;q_opackets[i] +=3D from-&gt;q_opackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; to-&gt;q_ibytes[i] +=3D from-&gt;q_ibytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; to-&gt;q_obytes[i] +=3D from-&gt;q_obytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; to-&gt;q_errors[i] +=3D from-&gt;q_errors[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int<br>
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/fai=
lsafe_ops.c<br>
index 5321c3385c..ddc8808ebe 100644<br>
--- a/drivers/net/failsafe/failsafe_ops.c<br>
+++ b/drivers/net/failsafe/failsafe_ops.c<br>
@@ -898,7 +898,8 @@ fs_link_update(struct rte_eth_dev *dev,<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;fs_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats backu=
p;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sub_device *sdev;<b=
r>
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c<br=
>
index 56e1a470b8..6341d89f39 100644<br>
--- a/drivers/net/gve/gve_ethdev.c<br>
+++ b/drivers/net/gve/gve_ethdev.c<br>
@@ -10,6 +10,7 @@<br>
&nbsp;#include &quot;gve_version.h&quot;<br>
&nbsp;#include &quot;rte_ether.h&quot;<br>
&nbsp;#include &quot;gve_rss.h&quot;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;<br>
&nbsp;static void<br>
&nbsp;gve_write_version(uint8_t *driver_version_register)<br>
@@ -671,7 +672,8 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_et=
h_dev_info *dev_info)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-gve_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br=
>
+gve_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gve_is_gqi(dev-&gt;dat=
a-&gt;dev_private))<br>
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic=
_pmd_ethdev.c<br>
index cb5c013b21..75534c1ce2 100644<br>
--- a/drivers/net/hinic/hinic_pmd_ethdev.c<br>
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c<br>
@@ -5,6 +5,7 @@<br>
&nbsp;#include &lt;rte_pci.h&gt;<br>
&nbsp;#include &lt;bus_pci_driver.h&gt;<br>
&nbsp;#include &lt;ethdev_pci.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;#include &lt;rte_mbuf.h&gt;<br>
&nbsp;#include &lt;rte_malloc.h&gt;<br>
&nbsp;#include &lt;rte_memcpy.h&gt;<br>
@@ -1305,7 +1306,8 @@ static int hinic_set_dev_promiscuous(struct hinic_nic=
_dev *nic_dev, bool enable)<br>
&nbsp; *&nbsp;&nbsp; negative error value otherwise.<br>
&nbsp; */<br>
&nbsp;static int<br>
-hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<=
br>
+hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, err, q_num;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 rx_discards_pmd =3D 0;=
<br>
@@ -1326,29 +1328,45 @@ hinic_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt;rx_mbuf_a=
lloc_failed =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rx queue stats */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_num =3D (nic_dev-&gt;num_rq &lt; RT=
E_ETHDEV_QUEUE_STAT_CNTRS) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nic_dev-&gt;num_=
rq : RTE_ETHDEV_QUEUE_STAT_CNTRS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; q_num; i++) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rxq =3D nic_dev-&gt;rxqs[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hinic_rxq_get_stats(rxq, &amp;rxq_stats);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D rxq_stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D rxq_stats.bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D rxq_stats.rx_discards;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;ierrors +=3D rxq_stats.errors;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_discards_pmd +=3D rxq_stats.rx_discards;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev-&gt;data-&gt;rx_mbuf_alloc_failed +=3D rxq_stats.rx_nombuf;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_num =3D (nic_dev-&gt;num_rq &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) =
?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nic_dev-&gt;num_rq : RTE_ETHDEV_QUEUE_STAT_=
CNTRS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; q_num; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq =3D nic_dev-=
&gt;rxqs[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hinic_rxq_get_st=
ats(rxq, &amp;rxq_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rxq_stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rxq_stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D rxq_stats.rx_discards;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ierror=
s +=3D rxq_stats.errors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_discards_pmd =
+=3D rxq_stats.rx_discards;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt=
;rx_mbuf_alloc_failed +=3D rxq_stats.rx_nombuf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* tx queue stats */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_num =3D (nic_dev-&gt;num_sq &lt; RT=
E_ETHDEV_QUEUE_STAT_CNTRS) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nic_dev-&gt;num_sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; q_num; i++) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; txq =3D nic_dev-&gt;txqs[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hinic_txq_get_stats(txq, &amp;txq_stats);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D txq_stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D txq_stats.bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;oerrors +=3D (txq_stats.tx_busy + txq_stats.off_errs);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* tx queue stats */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_num =3D (nic_dev-&gt;num_sq &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) =
?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nic_dev-&gt;num_=
sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; q_num; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txq =3D nic_dev-=
&gt;txqs[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hinic_txq_get_st=
ats(txq, &amp;txq_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D txq_stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D txq_stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;oerror=
s +=3D (txq_stats.tx_busy + txq_stats.off_errs);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Still aggregate error stats even without qstats */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; nic_dev-&gt;num_rq; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq =3D nic_dev-=
&gt;rxqs[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hinic_rxq_get_st=
ats(rxq, &amp;rxq_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ierror=
s +=3D rxq_stats.errors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_discards_pmd =
+=3D rxq_stats.rx_discards;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt=
;rx_mbuf_alloc_failed +=3D rxq_stats.rx_nombuf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; nic_dev-&gt;num_sq; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txq =3D nic_dev-=
&gt;txqs[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hinic_txq_get_st=
ats(txq, &amp;txq_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;oerror=
s +=3D (txq_stats.tx_busy + txq_stats.off_errs);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vport stats */<br>
diff --git a/drivers/net/hns3/hns3_stats.c b/drivers/net/hns3/hns3_stats.c<=
br>
index 9a1e8935e5..c8d5070a5b 100644<br>
--- a/drivers/net/hns3/hns3_stats.c<br>
+++ b/drivers/net/hns3/hns3_stats.c<br>
@@ -3,6 +3,7 @@<br>
&nbsp; */<br>
&nbsp;<br>
&nbsp;#include &lt;rte_ethdev.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;#include &lt;rte_io.h&gt;<br>
&nbsp;#include &lt;rte_malloc.h&gt;<br>
&nbsp;<br>
@@ -609,7 +610,8 @@ hns3_rcb_tx_ring_stats_get(struct hns3_tx_queue *txq,<b=
r>
&nbsp; *&nbsp;&nbsp; 0 on success.<br>
&nbsp; */<br>
&nbsp;int<br>
-hns3_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stat=
s)<br>
+hns3_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stat=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hns3_adapter *hns =
=3D eth_dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hns3_hw *hw =3D &am=
p;hns-&gt;hw;<br>
diff --git a/drivers/net/hns3/hns3_stats.h b/drivers/net/hns3/hns3_stats.h<=
br>
index 74bc4173cc..511af430a3 100644<br>
--- a/drivers/net/hns3/hns3_stats.h<br>
+++ b/drivers/net/hns3/hns3_stats.h<br>
@@ -151,7 +151,8 @@ struct hns3_reset_stats;<br>
&nbsp;struct hns3_hw;<br>
&nbsp;<br>
&nbsp;int hns3_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;int hns3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat=
 *xstats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsig=
ned int n);<br>
&nbsp;int hns3_dev_xstats_reset(struct rte_eth_dev *dev);<br>
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/=
cpfl_ethdev.c<br>
index 6d7b23ad7a..ed6852f23d 100644<br>
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c<br>
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c<br>
@@ -311,7 +311,8 @@ cpfl_get_mbuf_alloc_failed_stats(struct rte_eth_dev *de=
v)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-cpfl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+cpfl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cpfl_vport *cpfl_vp=
ort =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_vport *vport =
=3D &amp;cpfl_vport-&gt;base;<br>
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/=
em_ethdev.c<br>
index 39dddf3384..ec3924bf6b 100644<br>
--- a/drivers/net/intel/e1000/em_ethdev.c<br>
+++ b/drivers/net/intel/e1000/em_ethdev.c<br>
@@ -42,7 +42,7 @@ static int eth_em_allmulticast_disable(struct rte_eth_dev=
 *dev);<br>
&nbsp;static int eth_em_link_update(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int wait_to_complete);<br>
&nbsp;static int eth_em_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats, struct eth=
_queue_stats *qstats);<br>
&nbsp;static int eth_em_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int eth_em_infos_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev_info *dev_inf=
o);<br>
@@ -926,7 +926,8 @@ em_hardware_init(struct e1000_hw *hw)<br>
&nbsp;<br>
&nbsp;/* This function is based on em_update_stats_counters() in e1000/if_e=
m.c */<br>
&nbsp;static int<br>
-eth_em_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)=
<br>
+eth_em_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_hw *hw =3D E1=
000_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_hw_stats *sta=
ts =3D<br>
@@ -1049,7 +1050,7 @@ eth_em_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E1000=
_DEV_PRIVATE_TO_STATS(dev-&gt;data-&gt;dev_private);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HW registers are cleare=
d on read */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_em_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_em_stats_get(dev, NULL, NULL);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset software totals *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hw_stats, 0, sizeof=
(*hw_stats));<br>
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000=
/igb_ethdev.c<br>
index 124cf75762..f4e2a6442e 100644<br>
--- a/drivers/net/intel/e1000/igb_ethdev.c<br>
+++ b/drivers/net/intel/e1000/igb_ethdev.c<br>
@@ -86,7 +86,7 @@ static int&nbsp; eth_igb_allmulticast_disable(struct rte_=
eth_dev *dev);<br>
&nbsp;static int&nbsp; eth_igb_link_update(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int wait_to_complete);<br>
&nbsp;static int eth_igb_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats, struct eth=
_queue_stats *qstats);<br>
&nbsp;static int eth_igb_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *xstats, unsigned n);<b=
r>
&nbsp;static int eth_igb_xstats_get_by_id(struct rte_eth_dev *dev,<br>
@@ -163,7 +163,7 @@ static int igbvf_allmulticast_enable(struct rte_eth_dev=
 *dev);<br>
&nbsp;static int igbvf_allmulticast_disable(struct rte_eth_dev *dev);<br>
&nbsp;static int eth_igbvf_link_update(struct e1000_hw *hw);<br>
&nbsp;static int eth_igbvf_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *rte_stats, struct eth=
_queue_stats *qstats);<br>
&nbsp;static int eth_igbvf_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *xstats, un=
signed n);<br>
&nbsp;static int eth_igbvf_xstats_get_names(struct rte_eth_dev *dev,<br>
@@ -1943,7 +1943,8 @@ igb_read_stats_registers(struct e1000_hw *hw, struct =
e1000_hw_stats *stats)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_igb_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
)<br>
+eth_igb_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_hw *hw =3D E1=
000_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_hw_stats *sta=
ts =3D<br>
@@ -1976,7 +1977,7 @@ eth_igb_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E1000=
_DEV_PRIVATE_TO_STATS(dev-&gt;data-&gt;dev_private);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HW registers are cleare=
d on read */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_igb_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_igb_stats_get(dev, NULL, NULL);<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset software totals *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hw_stats, 0, sizeof=
(*hw_stats));<br>
@@ -2212,7 +2213,8 @@ eth_igbvf_xstats_get(struct rte_eth_dev *dev, struct =
rte_eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_igbvf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_sta=
ts)<br>
+eth_igbvf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_sta=
ts,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_hw *hw =3D E1=
000_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_vf_stats *hw_=
stats =3D (struct e1000_vf_stats *)<br>
@@ -2237,7 +2239,7 @@ eth_igbvf_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; E1000=
_DEV_PRIVATE_TO_STATS(dev-&gt;data-&gt;dev_private);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sync HW register to the=
 last stats */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_igbvf_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_igbvf_stats_get(dev, NULL, NULL);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset HW current stats*=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;hw_stats-&gt;g=
prc, 0, sizeof(*hw_stats) -<br>
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000=
/igc_ethdev.c<br>
index 68444e4fba..b9c91d2446 100644<br>
--- a/drivers/net/intel/e1000/igc_ethdev.c<br>
+++ b/drivers/net/intel/e1000/igc_ethdev.c<br>
@@ -226,7 +226,7 @@ static int eth_igc_allmulticast_enable(struct rte_eth_d=
ev *dev);<br>
&nbsp;static int eth_igc_allmulticast_disable(struct rte_eth_dev *dev);<br>
&nbsp;static int eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);<br=
>
&nbsp;static int eth_igc_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_s=
tats *rte_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_s=
tats *rte_stats, struct eth_queue_stats *qstats);<br>
&nbsp;static int eth_igc_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t rte_eth_xstat *xstats, unsigned int n);<br>
&nbsp;static int eth_igc_xstats_get_by_id(struct rte_eth_dev *dev,<br>
@@ -2029,7 +2029,8 @@ igc_read_queue_stats_register(struct rte_eth_dev *dev=
)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
)<br>
+eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct igc_adapter *igc =
=3D IGC_DEV_PRIVATE(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct e1000_hw *hw =3D IG=
C_DEV_PRIVATE_HW(dev);<br>
@@ -2068,19 +2069,21 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct r=
te_eth_stats *rte_stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_stats-&gt;obytes&nbsp;=
&nbsp; =3D stats-&gt;gotc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get per-queue statuses =
*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; IGC_QUEUE_PAIRS_=
NUM; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* GET TX queue statuses */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int map_id =3D igc-&gt;txq_stats_map[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (map_id &gt;=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_stats-&gt;q_=
opackets[map_id] +=3D queue_stats-&gt;pqgptc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_stats-&gt;q_=
obytes[map_id] +=3D queue_stats-&gt;pqgotc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Get RX queue statuses */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; map_id =3D igc-&gt;rxq_stats_map[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (map_id &gt;=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_stats-&gt;q_=
ipackets[map_id] +=3D queue_stats-&gt;pqgprc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_stats-&gt;q_=
ibytes[map_id] +=3D queue_stats-&gt;pqgorc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_stats-&gt;q_=
errors[map_id] +=3D queue_stats-&gt;rqdpc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; IGC_QUEUE_PAIRS_NUM; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GET TX queue =
statuses */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int map_id =3D i=
gc-&gt;txq_stats_map[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (map_id &gt;=
=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opackets[map_id] +=3D queue_st=
ats-&gt;pqgptc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_obytes[map_id] +=3D queue_stat=
s-&gt;pqgotc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get RX queue =
statuses */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_id =3D igc-&=
gt;rxq_stats_map[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (map_id &gt;=
=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipackets[map_id] +=3D queue_st=
ats-&gt;pqgprc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ibytes[map_id] +=3D queue_stat=
s-&gt;pqgorc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_errors[map_id] +=3D queue_stat=
s-&gt;rqdpc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm1=
0k/fm10k_ethdev.c<br>
index 75ce2e19cf..bb05aecd97 100644<br>
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c<br>
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c<br>
@@ -1314,7 +1314,8 @@ fm10k_xstats_get(struct rte_eth_dev *dev, struct rte_=
eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ipackets, opacket=
s, ibytes, obytes, imissed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fm10k_hw *hw =3D<br=
>
@@ -1329,17 +1330,19 @@ fm10k_stats_get(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipackets =3D opackets =3D =
ibytes =3D obytes =3D imissed =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; (i &lt; RTE_=
ETHDEV_QUEUE_STAT_CNTRS) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (i &lt; hw-&gt;mac.max_queues); ++i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D hw_stats-&gt;q[i].rx_packets.count;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D hw_stats-&gt;q[i].tx_packets.count;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i]&nbsp;&nbsp; =3D hw_stats-&gt;q[i].rx_bytes=
.count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i]&nbsp;&nbsp; =3D hw_stats-&gt;q[i].tx_bytes=
.count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i]&nbsp;&nbsp; =3D hw_stats-&gt;q[i].rx_drops=
.count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ipackets +=3D stats-&gt;q_ipackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; opackets +=3D stats-&gt;q_opackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ibytes&nbsp;&nbsp; +=3D stats-&gt;q_ibytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; obytes&nbsp;&nbsp; +=3D stats-&gt;q_obytes[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; imissed&nbsp; +=3D stats-&gt;q_errors[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (i &lt; hw-&gt;m=
ac.max_queues); ++i) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D hw_stats-&gt;q[i].rx_packets.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D hw_stats-&gt;q[i].tx_packets.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i]&nbsp;&nbsp; =3D hw_stats-&gt;q[i].rx_bytes.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i]&nbsp;&nbsp; =3D hw_stats-&gt;q[i].tx_bytes.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i]&nbsp;&nbsp; =3D hw_stats-&gt;q[i].rx_drops.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ipackets +=3D hw_stats-&gt;q[i].rx_packets.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; opackets +=3D hw_stats-&gt;q[i].tx_packets.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ibytes&nbsp;&nbsp; +=3D hw_stats-&gt;q[i].rx_bytes.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; obytes&nbsp;&nbsp; +=3D hw_stats-&gt;q[i].tx_bytes.count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; imissed&nbsp; +=3D hw_stats-&gt;q[i].rx_drops.count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets =3D ipa=
ckets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D opa=
ckets;<br>
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/=
i40e_ethdev.c<br>
index 7a562a6e0b..b8ce79061b 100644<br>
--- a/drivers/net/intel/i40e/i40e_ethdev.c<br>
+++ b/drivers/net/intel/i40e/i40e_ethdev.c<br>
@@ -256,7 +256,7 @@ static int i40e_dev_allmulticast_disable(struct rte_eth=
_dev *dev);<br>
&nbsp;static int i40e_dev_set_link_up(struct rte_eth_dev *dev);<br>
&nbsp;static int i40e_dev_set_link_down(struct rte_eth_dev *dev);<br>
&nbsp;static int i40e_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;static int i40e_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *xstats, unsigned=
 n);<br>
&nbsp;static int i40e_dev_xstats_get_names(struct rte_eth_dev *dev,<br>
@@ -3474,7 +3474,8 @@ i40e_read_stats_registers(struct i40e_pf *pf, struct =
i40e_hw *hw)<br>
&nbsp;<br>
&nbsp;/* Get all statistics of a port */<br>
&nbsp;static int<br>
-i40e_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+i40e_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i40e_pf *pf =3D I40=
E_DEV_PRIVATE_TO_PF(dev-&gt;data-&gt;dev_private);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i40e_hw *hw =3D I40=
E_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);<br>
diff --git a/drivers/net/intel/i40e/i40e_vf_representor.c b/drivers/net/int=
el/i40e/i40e_vf_representor.c<br>
index c00ae832aa..e8f0bb62a0 100644<br>
--- a/drivers/net/intel/i40e/i40e_vf_representor.c<br>
+++ b/drivers/net/intel/i40e/i40e_vf_representor.c<br>
@@ -209,7 +209,7 @@ rte_pmd_i40e_get_vf_native_stats(uint16_t port,<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;i40e_vf_representor_stats_get(struct rte_eth_dev *ethdev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats __rt=
e_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i40e_vf_representor=
 *representor =3D ethdev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i40e_eth_stats nati=
ve_stats;<br>
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/=
iavf_ethdev.c<br>
index 08c814725d..56bc6480e5 100644<br>
--- a/drivers/net/intel/iavf/iavf_ethdev.c<br>
+++ b/drivers/net/intel/iavf/iavf_ethdev.c<br>
@@ -105,7 +105,7 @@ static int iavf_dev_info_get(struct rte_eth_dev *dev,<b=
r>
&nbsp;static const uint32_t *iavf_dev_supported_ptypes_get(struct rte_eth_d=
ev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; size_t *no_of_elements);<br>
&nbsp;static int iavf_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats);=
<br>
&nbsp;static int iavf_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int iavf_dev_xstats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int iavf_dev_xstats_get(struct rte_eth_dev *dev,<br>
@@ -1798,7 +1798,8 @@ iavf_update_stats(struct iavf_vsi *vsi, struct virtch=
nl_eth_stats *nes)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct iavf_adapter *adapt=
er =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; IAVF_DEV_PRIVATE_TO_ADAPTER(dev-&gt;data-&gt;dev_priv=
ate);<br>
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice=
/ice_dcf_ethdev.c<br>
index 499062be40..81da5a4656 100644<br>
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c<br>
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c<br>
@@ -1514,7 +1514,8 @@ ice_dcf_update_stats(struct virtchnl_eth_stats *oes,<=
br>
&nbsp;<br>
&nbsp;<br>
&nbsp;static int<br>
-ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br=
>
+ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ice_dcf_adapter *ad=
 =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ice_dcf_hw *hw =3D =
&amp;ad-&gt;real_hw;<br>
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice=
_ethdev.c<br>
index 31f1419897..cdc4943667 100644<br>
--- a/drivers/net/intel/ice/ice_ethdev.c<br>
+++ b/drivers/net/intel/ice/ice_ethdev.c<br>
@@ -161,7 +161,7 @@ static int ice_get_module_info(struct rte_eth_dev *dev,=
<br>
&nbsp;static int ice_get_module_eeprom(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_dev_eeprom_info=
 *info);<br>
&nbsp;static int ice_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte=
_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte=
_eth_stats *stats, struct eth_queue_stats *qstats);<br>
&nbsp;static int ice_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int ice_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct rte_eth_xstat *xstats, unsigned int n);<br>
@@ -6340,7 +6340,8 @@ ice_read_stats_registers(struct ice_pf *pf, struct ic=
e_hw *hw)<br>
&nbsp;<br>
&nbsp;/* Get all statistics of a port */<br>
&nbsp;static int<br>
-ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ice_pf *pf =3D ICE_=
DEV_PRIVATE_TO_PF(dev-&gt;data-&gt;dev_private);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ice_hw *hw =3D ICE_=
DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);<br>
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/=
idpf_ethdev.c<br>
index 90720909bf..3c505e882a 100644<br>
--- a/drivers/net/intel/idpf/idpf_ethdev.c<br>
+++ b/drivers/net/intel/idpf/idpf_ethdev.c<br>
@@ -268,7 +268,8 @@ idpf_get_mbuf_alloc_failed_stats(struct rte_eth_dev *de=
v)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-idpf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+idpf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_vport *vport =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (struct idpf_vport *)dev-&gt;data-&gt;dev_private;<br=
>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/in=
tel/ipn3ke/ipn3ke_representor.c<br>
index c5aca0ea8f..cd34d08055 100644<br>
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c<br>
@@ -2119,7 +2119,8 @@ ipn3ke_rpst_stats_reset(struct rte_eth_dev *ethdev)<b=
r>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;ipn3ke_rpst_stats_get<br>
-(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats)<br>
+(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t port_id =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *ch;<br>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixg=
be/ixgbe_ethdev.c<br>
index 4f0343245e..7e1278c026 100644<br>
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c<br>
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c<br>
@@ -164,7 +164,7 @@ static int ixgbe_dev_allmulticast_disable(struct rte_et=
h_dev *dev);<br>
&nbsp;static int ixgbe_dev_link_update(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int wait_to_complete);<br>
&nbsp;static int ixgbe_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct eth_que=
ue_stats *qstats);<br>
&nbsp;static int ixgbe_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *xstats, un=
signed n);<br>
&nbsp;static int ixgbevf_dev_xstats_get(struct rte_eth_dev *dev,<br>
@@ -265,7 +265,7 @@ static int&nbsp; ixgbevf_dev_reset(struct rte_eth_dev *=
dev);<br>
&nbsp;static void ixgbevf_intr_disable(struct rte_eth_dev *dev);<br>
&nbsp;static void ixgbevf_intr_enable(struct rte_eth_dev *dev);<br>
&nbsp;static int ixgbevf_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats);<br=
>
&nbsp;static int ixgbevf_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int ixgbevf_vlan_filter_set(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t vlan_id, int on);<br>
@@ -3398,7 +3398,7 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,<br>
&nbsp; * This function is based on ixgbe_update_stats_counters() in ixgbe/i=
xgbe.c<br>
&nbsp; */<br>
&nbsp;static int<br>
-ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<=
br>
+ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, =
struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ixgbe_hw *hw =3D<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IXGBE=
_DEV_PRIVATE_TO_HW(dev-&gt;data-&gt;dev_private);<br>
@@ -3427,13 +3427,15 @@ ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D hw_=
stats-&gt;gptc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D hw_st=
ats-&gt;gotc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_MIN_T(IXGBE_=
QUEUE_STAT_COUNTERS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETHDEV_QUEUE=
_STAT_CNTRS, typeof(i)); i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D hw_stats-&gt;qprc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D hw_stats-&gt;qptc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D hw_stats-&gt;qbrc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D hw_stats-&gt;qbtc[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D hw_stats-&gt;qprdc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i+=
+) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D hw_stats-&gt;qprc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D hw_stats-&gt;qptc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D hw_stats-&gt;qbrc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D hw_stats-&gt;qbtc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D hw_stats-&gt;qprdc[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Rx Errors */<br>
@@ -3468,7 +3470,7 @@ ixgbe_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IXGBE=
_DEV_PRIVATE_TO_STATS(dev-&gt;data-&gt;dev_private);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HW registers are cleare=
d on read */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixgbe_dev_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixgbe_dev_stats_get(dev, NULL, NULL);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset software totals *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(stats, 0, sizeof(*s=
tats));<br>
@@ -3887,7 +3889,8 @@ ixgbevf_dev_xstats_get(struct rte_eth_dev *dev, struc=
t rte_eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-ixgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)<br>
+ixgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ixgbevf_hw_stats *h=
w_stats =3D (struct ixgbevf_hw_stats *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; IXGBE_DEV_PRIVATE_TO_STATS(dev-&gt;data-&gt;dev_private);<br>
@@ -3911,7 +3914,7 @@ ixgbevf_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IXGBE=
_DEV_PRIVATE_TO_STATS(dev-&gt;data-&gt;dev_private);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sync HW register to the=
 last stats */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixgbevf_dev_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixgbevf_dev_stats_get(dev, NULL, NULL=
);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset HW current stats*=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_stats-&gt;vfgprc =3D 0;=
<br>
diff --git a/drivers/net/ionic/ionic_ethdev.c b/drivers/net/ionic/ionic_eth=
dev.c<br>
index aa22b6a70d..6e9cd5f7eb 100644<br>
--- a/drivers/net/ionic/ionic_ethdev.c<br>
+++ b/drivers/net/ionic/ionic_ethdev.c<br>
@@ -39,7 +39,7 @@ static int&nbsp; ionic_dev_rss_hash_conf_get(struct rte_e=
th_dev *eth_dev,<br>
&nbsp;static int&nbsp; ionic_dev_rss_hash_update(struct rte_eth_dev *eth_de=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_rss_conf *r=
ss_conf);<br>
&nbsp;static int&nbsp; ionic_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct e=
th_queue_stats *queue_stats);<br>
&nbsp;static int&nbsp; ionic_dev_stats_reset(struct rte_eth_dev *eth_dev);<=
br>
&nbsp;static int&nbsp; ionic_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *xsta=
ts, unsigned int n);<br>
@@ -722,11 +722,11 @@ ionic_dev_rss_hash_update(struct rte_eth_dev *eth_dev=
,<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;ionic_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ionic_lif *lif =3D =
IONIC_ETH_DEV_TO_LIF(eth_dev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ionic_lif_get_stats(lif, stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ionic_lif_get_stats(lif, stats, qstat=
s);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/net/ionic/ionic_lif.c b/drivers/net/ionic/ionic_lif.c<=
br>
index b4dc118fef..b52c8cad88 100644<br>
--- a/drivers/net/ionic/ionic_lif.c<br>
+++ b/drivers/net/ionic/ionic_lif.c<br>
@@ -100,7 +100,8 @@ ionic_lif_reset(struct ionic_lif *lif)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void<br>
-ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats =
*stats)<br>
+ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats =
*stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ionic_lif_stats *ls=
 =3D &amp;lif-&gt;info-&gt;stats;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
@@ -144,13 +145,15 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, =
struct rte_eth_stats *stats<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ls-&gt;rx_desc_fetch_error +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ls-&gt;rx_desc_data_error;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_rx_q_counter=
s; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ionic_rx_stats *rx_stats =3D &amp;lif-&gt;rxqcqs[i]-&gt;s=
tats;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D rx_stats-&gt;packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D rx_stats-&gt;bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad=
_cq_status +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad=
_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_rx_q_counters; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ionic_rx_=
stats *rx_stats =3D &amp;lif-&gt;rxqcqs[i]-&gt;stats;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rx_stats-&gt;packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rx_stats-&gt;bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad_cq_status +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats-&gt;bad_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TX */<br>
@@ -179,18 +182,20 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, =
struct rte_eth_stats *stats<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ls-&gt;tx_desc_fetch_error +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ls-&gt;tx_desc_data_error;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_tx_q_counter=
s; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct ionic_tx_stats *tx_stats =3D &amp;lif-&gt;txqcqs[i]-&gt;s=
tats;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D tx_stats-&gt;packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D tx_stats-&gt;bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_tx_q_counters; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ionic_tx_=
stats *tx_stats =3D &amp;lif-&gt;txqcqs[i]-&gt;stats;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D tx_stats-&gt;packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D tx_stats-&gt;bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
&nbsp;ionic_lif_get_stats(const struct ionic_lif *lif,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ionic_lif_get_abs_stats(lif, stats);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ionic_lif_get_abs_stats(lif, stats, q=
stats);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets&nbsp; -=
=3D lif-&gt;stats_base.ipackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets&nbsp; -=
=3D lif-&gt;stats_base.opackets;<br>
@@ -214,7 +219,7 @@ ionic_lif_reset_stats(struct ionic_lif *lif)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(struct ionic_tx_stats));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ionic_lif_get_abs_stats(lif, &amp;lif=
-&gt;stats_base);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ionic_lif_get_abs_stats(lif, &amp;lif=
-&gt;stats_base, NULL);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void<br>
diff --git a/drivers/net/ionic/ionic_lif.h b/drivers/net/ionic/ionic_lif.h<=
br>
index f4a1b9937e..2d85ebbcae 100644<br>
--- a/drivers/net/ionic/ionic_lif.h<br>
+++ b/drivers/net/ionic/ionic_lif.h<br>
@@ -9,6 +9,7 @@<br>
&nbsp;<br>
&nbsp;#include &lt;rte_ethdev.h&gt;<br>
&nbsp;#include &lt;rte_ether.h&gt;<br>
+#include &lt;ethdev_driver.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;ionic.h&quot;<br>
&nbsp;#include &quot;ionic_dev.h&quot;<br>
@@ -244,7 +245,7 @@ int ionic_lif_rss_config(struct ionic_lif *lif, const u=
int16_t types,<br>
&nbsp;int ionic_lif_set_features(struct ionic_lif *lif);<br>
&nbsp;<br>
&nbsp;void ionic_lif_get_stats(const struct ionic_lif *lif,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats, struct e=
th_queue_stats *qstats);<br>
&nbsp;void ionic_lif_reset_stats(struct ionic_lif *lif);<br>
&nbsp;<br>
&nbsp;void ionic_lif_get_hw_stats(struct ionic_lif *lif,<br>
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c<br>
index 48e44bfafc..b7ae01b152 100644<br>
--- a/drivers/net/mana/mana.c<br>
+++ b/drivers/net/mana/mana.c<br>
@@ -645,7 +645,8 @@ mana_dev_link_update(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;<br>
@@ -659,9 +660,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D txq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D txq-&gt;stats.errors;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D txq-&gt;stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D txq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D txq-&gt;stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D txq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -678,9 +679,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* There is no good way to get stats-&gt;imissed, not=
 setting it */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D rxq-&gt;stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D rxq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rxq-&gt;stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rxq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;rx_nombuf +=3D rxq-&gt;stats.nombuf;<br>
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_=
memif.c<br>
index f7b04c4f9e..9de6f97cd9 100644<br>
--- a/drivers/net/memif/rte_eth_memif.c<br>
+++ b/drivers/net/memif/rte_eth_memif.c<br>
@@ -1578,7 +1578,8 @@ memif_link_update(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pmd_internals *pmd =
=3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct memif_queue *mq;<br=
>
@@ -1598,8 +1599,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RX stats */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; nq; i=
++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mq =3D dev-&gt;data-&gt;rx_queues[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D mq-&gt;n_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D mq-&gt;n_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D mq-&gt;n_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D mq-&gt;n_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D mq-&gt;n_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D mq-&gt;n_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1612,8 +1615,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TX stats */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; nq; i=
++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mq =3D dev-&gt;data-&gt;tx_queues[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D mq-&gt;n_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D mq-&gt;n_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D mq-&gt;n_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D mq-&gt;n_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets +=3D mq-&gt;n_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D mq-&gt;n_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/net/mlx4/mlx4.h b/drivers/net/mlx4/mlx4.h<br>
index c992a1c5ea..f68eeb991a 100644<br>
--- a/drivers/net/mlx4/mlx4.h<br>
+++ b/drivers/net/mlx4/mlx4.h<br>
@@ -219,7 +219,8 @@ int mlx4_mac_addr_set(struct rte_eth_dev *dev, struct r=
te_ether_addr *mac_addr);<br>
&nbsp;int mlx4_set_mc_addr_list(struct rte_eth_dev *dev, struct rte_ether_a=
ddr *list,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t num);<br>
&nbsp;int mlx4_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, i=
nt on);<br>
-int mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);<=
br>
+int mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;int mlx4_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;int mlx4_fw_version_get(struct rte_eth_dev *dev, char *fw_ver, size_t=
 fw_size);<br>
&nbsp;int mlx4_dev_infos_get(struct rte_eth_dev *dev,<br>
diff --git a/drivers/net/mlx4/mlx4_ethdev.c b/drivers/net/mlx4/mlx4_ethdev.=
c<br>
index f11c6b4373..efc6ee4577 100644<br>
--- a/drivers/net/mlx4/mlx4_ethdev.c<br>
+++ b/drivers/net/mlx4/mlx4_ethdev.c<br>
@@ -702,7 +702,8 @@ int mlx4_fw_version_get(struct rte_eth_dev *dev, char *=
fw_ver, size_t fw_size)<br>
&nbsp; *&nbsp;&nbsp; Stats structure output buffer.<br>
&nbsp; */<br>
&nbsp;int<br>
-mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats tmp;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
@@ -716,10 +717,10 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (rxq =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D rxq-&gt;stats.idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (idx &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_ipackets[i=
dx] +=3D rxq-&gt;stats.ipackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_ibytes[idx=
] +=3D rxq-&gt;stats.ibytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_errors[idx=
] +=3D (rxq-&gt;stats.idropped +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; idx &lt; RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[idx] +=3D rxq-&gt;stats.ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[idx] +=3D rxq-&gt;stats.ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[idx] +=3D (rxq-&gt;stats.idropped +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;stats.rx_nombuf=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp.ipackets +=3D rxq-&gt;stats.ipackets;<br>
@@ -733,9 +734,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_=
stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (txq =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D txq-&gt;stats.idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (idx &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_opackets[i=
dx] +=3D txq-&gt;stats.opackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_obytes[idx=
] +=3D txq-&gt;stats.obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; idx &lt; RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[idx] +=3D txq-&gt;stats.opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[idx] +=3D txq-&gt;stats.obytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp.opackets +=3D txq-&gt;stats.opackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp.obytes +=3D txq-&gt;stats.obytes;<br>
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h<br>
index 93e298d648..e7fd4066ba 100644<br>
--- a/drivers/net/mlx5/mlx5.h<br>
+++ b/drivers/net/mlx5/mlx5.h<br>
@@ -2418,7 +2418,8 @@ int mlx5_allmulticast_disable(struct rte_eth_dev *dev=
);<br>
&nbsp;<br>
&nbsp;/* mlx5_stats.c */<br>
&nbsp;<br>
-int mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);<=
br>
+int mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;int mlx5_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;int mlx5_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *st=
ats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int n);<br>
diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.c<=
br>
index ebc6f9fb53..5cd3e303cc 100644<br>
--- a/drivers/net/mlx5/mlx5_stats.c<br>
+++ b/drivers/net/mlx5/mlx5_stats.c<br>
@@ -208,7 +208,8 @@ mlx5_xstats_get(struct rte_eth_dev *dev, struct rte_eth=
_xstat *stats,<br>
&nbsp; *&nbsp;&nbsp; rte_errno is set.<br>
&nbsp; */<br>
&nbsp;int<br>
-mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mlx5_priv *priv =3D=
 dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mlx5_stats_ctrl *st=
ats_ctrl =3D &amp;priv-&gt;stats_ctrl;<br>
@@ -226,14 +227,14 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (rxq =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D rxq-&gt;idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (idx &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; idx &lt; RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {<br>
&nbsp;#ifdef MLX5_PMD_SOFT_COUNTERS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_ipackets[i=
dx] +=3D rxq-&gt;stats.ipackets -<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[idx] +=3D rxq-&gt;stats.ipackets -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;stats_reset.ipackets;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_ibytes[idx=
] +=3D rxq-&gt;stats.ibytes -<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[idx] +=3D rxq-&gt;stats.ibytes -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;stats_reset.ibytes;<br>
&nbsp;#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_errors[idx=
] +=3D (rxq-&gt;stats.idropped +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[idx] +=3D (rxq-&gt;stats.idropped +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;stats.rx_nombuf=
) -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rxq-&gt;stats_reset.id=
ropped +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;stats_reset.rx_=
nombuf);<br>
@@ -252,11 +253,11 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (txq =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D txq-&gt;idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (idx &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; idx &lt; RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {<br>
&nbsp;#ifdef MLX5_PMD_SOFT_COUNTERS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_opackets[i=
dx] +=3D txq-&gt;stats.opackets -<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[idx] +=3D txq-&gt;stats.opackets -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txq-&gt;sta=
ts_reset.opackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.q_obytes[idx=
] +=3D txq-&gt;stats.obytes -<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[idx] +=3D txq-&gt;stats.obytes -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txq-&gt;sta=
ts_reset.obytes;<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/net/mvneta/mvneta_ethdev.c b/drivers/net/mvneta/mvneta=
_ethdev.c<br>
index f99f9e6289..eef9758224 100644<br>
--- a/drivers/net/mvneta/mvneta_ethdev.c<br>
+++ b/drivers/net/mvneta/mvneta_ethdev.c<br>
@@ -712,7 +712,8 @@ mvneta_mac_addr_set(struct rte_eth_dev *dev, struct rte=
_ether_addr *mac_addr)<br>
&nbsp; *&nbsp;&nbsp; 0 on success, negative error value otherwise.<br>
&nbsp; */<br>
&nbsp;static int<br>
-mvneta_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+mvneta_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mvneta_priv *priv =
=3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct neta_ppio_statistic=
s ppio_stats;<br>
@@ -765,7 +766,7 @@ mvneta_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!priv-&gt;ppio)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D mvneta_stats_get(dev, &amp;pr=
iv-&gt;prev_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D mvneta_stats_get(dev, &amp;pr=
iv-&gt;prev_stats, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; MVNETA_LOG(ERR, &quot;Failed to reset port statistics=
&quot;);<br>
&nbsp;<br>
diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethde=
v.c<br>
index 4200c11d46..845819e4d8 100644<br>
--- a/drivers/net/mvpp2/mrvl_ethdev.c<br>
+++ b/drivers/net/mvpp2/mrvl_ethdev.c<br>
@@ -1486,7 +1486,8 @@ mrvl_mac_addr_set(struct rte_eth_dev *dev, struct rte=
_ether_addr *mac_addr)<br>
&nbsp; *&nbsp;&nbsp; 0 on success, negative error value otherwise.<br>
&nbsp; */<br>
&nbsp;static int<br>
-mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mrvl_priv *priv =3D=
 dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp2_ppio_statistics=
 ppio_stats;<br>
@@ -1521,12 +1522,14 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[idx] =3D rxq-&gt;bytes_recv;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[idx] =3D rx_stats.enq_desc - rxq-&gt;drop_m=
ac;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[idx] =3D rx_stats.drop_early +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
x_stats.drop_fullq +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
x_stats.drop_bm +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
xq-&gt;drop_mac;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[idx] =3D rxq-&gt;bytes_recv;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[idx] =3D rx_stats.enq_desc - rxq-&gt;drop_mac;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[idx] =3D rx_stats.drop_early +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats.drop_fullq +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rx_stats.drop_bm +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;drop_mac;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D rxq-&gt;bytes_recv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drop_mac +=3D rxq-&gt;drop_mac;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1553,8 +1556,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[idx] =3D tx_stats.deq_desc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[idx] =3D txq-&gt;bytes_sent;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[idx] =3D tx_stats.deq_desc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[idx] =3D txq-&gt;bytes_sent;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D txq-&gt;bytes_sent;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.=
c<br>
index 1d788f3fb7..a31aac1a8a 100644<br>
--- a/drivers/net/netvsc/hn_ethdev.c<br>
+++ b/drivers/net/netvsc/hn_ethdev.c<br>
@@ -817,11 +817,12 @@ static int hn_dev_configure(struct rte_eth_dev *dev)<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int hn_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hn_vf_stats_get(dev, stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hn_vf_stats_get(dev, stats, qstats);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dev-&=
gt;data-&gt;nb_tx_queues; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const struct hn_tx_queue *txq =3D dev-&gt;data-&gt;tx=
_queues[i];<br>
@@ -833,9 +834,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D txq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D txq-&gt;stats.errors;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] +=3D txq-&gt;stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] +=3D txq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] +=3D txq-&gt;stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] +=3D txq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -850,9 +851,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors +=3D rxq-&gt;stats.errors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D rxq-&gt;stats.ring_full;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] +=3D rxq-&gt;stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] +=3D rxq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] +=3D rxq-&gt;stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] +=3D rxq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h<br>
index ccbd6b6a33..17c1d5d07b 100644<br>
--- a/drivers/net/netvsc/hn_var.h<br>
+++ b/drivers/net/netvsc/hn_var.h<br>
@@ -269,7 +269,8 @@ int hn_vf_rx_queue_setup(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct rte_mempool *mp);<br>
&nbsp;void&nbsp;&nbsp;&nbsp; hn_vf_rx_queue_release(struct hn_data *hv, uin=
t16_t queue_id);<br>
&nbsp;<br>
-int&nbsp;&nbsp;&nbsp; hn_vf_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats);<br>
+int&nbsp;&nbsp;&nbsp; hn_vf_stats_get(struct rte_eth_dev *dev, struct rte_=
eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue=
_stats *qstats);<br>
&nbsp;int&nbsp;&nbsp;&nbsp;&nbsp; hn_vf_stats_reset(struct rte_eth_dev *dev=
);<br>
&nbsp;int&nbsp;&nbsp;&nbsp;&nbsp; hn_vf_xstats_get_names(struct rte_eth_dev=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat_name *xstats_name=
s,<br>
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c<br>
index d922e685f4..0ecfaf54ea 100644<br>
--- a/drivers/net/netvsc/hn_vf.c<br>
+++ b/drivers/net/netvsc/hn_vf.c<br>
@@ -677,7 +677,8 @@ void hn_vf_rx_queue_release(struct hn_data *hv, uint16_=
t queue_id)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int hn_vf_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unu=
sed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hn_data *hv =3D dev=
-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev *vf_dev=
;<br>
diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/n=
fp_flower.c<br>
index 804ad494d5..4eeb9aee3b 100644<br>
--- a/drivers/net/nfp/flower/nfp_flower.c<br>
+++ b/drivers/net/nfp/flower/nfp_flower.c<br>
@@ -238,8 +238,8 @@ nfp_flower_multiple_pf_recv_pkts(void *rx_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; recv; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len +=3D rx_pkts[i]-&gt;data_len;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_ipackets[rxq-&gt;qidx] +=3D recv;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_ibytes[rxq-&gt;qidx] +=3D data_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_ipackets[rxq-&gt;qidx] +=3D recv;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_ibytes[rxq-&gt;qidx] +=3D data_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return recv;<br>
@@ -276,8 +276,8 @@ nfp_flower_multiple_pf_xmit_pkts(void *tx_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; sent; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len +=3D tx_pkts[i]-&gt;data_len;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_opackets[txq-&gt;qidx] +=3D sent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_obytes[txq-&gt;qidx] +=3D data_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_opackets[txq-&gt;qidx] +=3D sent;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_obytes[txq-&gt;qidx] +=3D data_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sent;<br>
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/=
nfp/flower/nfp_flower_representor.c<br>
index 6c3a30c694..9b984dbc8d 100644<br>
--- a/drivers/net/nfp/flower/nfp_flower_representor.c<br>
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c<br>
@@ -314,7 +314,7 @@ nfp_flower_repr_tx_queue_setup(struct rte_eth_dev *dev,=
<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats __rt=
e_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct nfp_flower_represen=
tor *repr;<br>
@@ -324,15 +324,15 @@ nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; repr-&gt;repr_stats.ipacke=
ts =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; repr-&gt;repr_stats.ibytes=
 =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ethde=
v-&gt;data-&gt;nb_rx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.ipackets +=3D repr-&gt;repr_stats.q_ipackets=
[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.ibytes +=3D repr-&gt;repr_stats.q_ibytes[i];=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.ipackets +=3D repr-&gt;repr_qstats.q_ipacket=
s[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.ibytes +=3D repr-&gt;repr_qstats.q_ibytes[i]=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; repr-&gt;repr_stats.opacke=
ts =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; repr-&gt;repr_stats.obytes=
 =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ethde=
v-&gt;data-&gt;nb_tx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.opackets +=3D repr-&gt;repr_stats.q_opackets=
[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.obytes +=3D repr-&gt;repr_stats.q_obytes[i];=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.opackets +=3D repr-&gt;repr_qstats.q_opacket=
s[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.obytes +=3D repr-&gt;repr_qstats.q_obytes[i]=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *stats =3D repr-&gt;repr_s=
tats;<br>
@@ -347,6 +347,7 @@ nfp_flower_repr_stats_reset(struct rte_eth_dev *ethdev)=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; repr =3D ethdev-&gt;data-&=
gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;repr-&gt;repr_=
stats, 0, sizeof(struct rte_eth_stats));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;repr-&gt;repr_qstats, 0, =
sizeof(struct eth_queue_stats));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -402,8 +403,8 @@ nfp_flower_repr_rx_burst(void *rx_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; total_dequeue; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len +=3D rx_pkts[i]-&gt;data_len;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_ipackets[rxq-&gt;qidx] +=3D total_dequeue;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_ibytes[rxq-&gt;qidx] +=3D data_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_ipackets[rxq-&gt;qidx] +=3D total_dequeue=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_ibytes[rxq-&gt;qidx] +=3D data_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return total_dequeue;<br>
@@ -450,8 +451,8 @@ nfp_flower_repr_tx_burst(void *tx_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; sent; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_=
len +=3D tx_pkts[i]-&gt;data_len;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_opackets[txq-&gt;qidx] +=3D sent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_stats.q_obytes[txq-&gt;qidx] +=3D data_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_opackets[txq-&gt;qidx] +=3D sent;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; repr-&gt;repr_qstats.q_obytes[txq-&gt;qidx] +=3D data_len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sent;<br>
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.h b/drivers/net/=
nfp/flower/nfp_flower_representor.h<br>
index a7416eccab..66714d9a51 100644<br>
--- a/drivers/net/nfp/flower/nfp_flower_representor.h<br>
+++ b/drivers/net/nfp/flower/nfp_flower_representor.h<br>
@@ -6,6 +6,8 @@<br>
&nbsp;#ifndef __NFP_FLOWER_REPRESENTOR_H__<br>
&nbsp;#define __NFP_FLOWER_REPRESENTOR_H__<br>
&nbsp;<br>
+#include &lt;ethdev_driver.h&gt;<br>
+<br>
&nbsp;#include &quot;nfp_flower.h&quot;<br>
&nbsp;<br>
&nbsp;struct nfp_flower_representor {<br>
@@ -20,6 +22,7 @@ struct nfp_flower_representor {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_ring **ring;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_link link;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats repr_=
stats;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats repr_qstats;<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *repr=
_xstats_base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *mac_stats;<br>
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_com=
mon.c<br>
index 730372e279..d35eee970a 100644<br>
--- a/drivers/net/nfp/nfp_net_common.c<br>
+++ b/drivers/net/nfp/nfp_net_common.c<br>
@@ -904,7 +904,7 @@ nfp_net_link_update(struct rte_eth_dev *dev,<br>
&nbsp;<br>
&nbsp;int<br>
&nbsp;nfp_net_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_eth_stats *stats, struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct nfp_net_hw *hw;<br>
@@ -922,15 +922,16 @@ nfp_net_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_ipackets[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CFG=
_RXR_STATS(i));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_ipackets[i] -=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;eth_stats_base.q_ipackets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_ipackets =3D nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_=
CFG_RXR_STATS(i));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_ipackets -=3D hw-&gt;eth_qstats_base.q_ipackets[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_ibytes[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CFG=
_RXR_STATS(i) + 0x8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_ibytes[i] -=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;eth_stats_base.q_ibytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_ibytes =3D nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CF=
G_RXR_STATS(i) + 0x8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_ibytes -=3D hw-&gt;eth_qstats_base.q_ibytes[i];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D q_ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D q_ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reading per TX ring sta=
ts */<br>
@@ -938,13 +939,16 @@ nfp_net_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_opackets[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CFG=
_TXR_STATS(i));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_opackets[i] -=3D hw-&gt;eth_stats_base.q_opacket=
s[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_opackets =3D nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_=
CFG_TXR_STATS(i));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_opackets -=3D hw-&gt;eth_qstats_base.q_opackets[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_obytes[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CFG=
_TXR_STATS(i) + 0x8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; nfp_dev_stats.q_obytes[i] -=3D hw-&gt;eth_stats_base.q_obytes[i]=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_obytes =3D nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CF=
G_TXR_STATS(i) + 0x8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_obytes -=3D hw-&gt;eth_qstats_base.q_obytes[i];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D q_opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D q_obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nfp_dev_stats.ipackets =3D=
 nn_cfg_readq(&amp;hw-&gt;super, NFP_NET_CFG_STATS_RX_FRAMES);<br>
@@ -982,8 +986,8 @@ nfp_net_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
- * hw-&gt;eth_stats_base records the per counter starting point.<br>
- * Lets update it now.<br>
+ * hw-&gt;eth_stats_base and hw-&gt;eth_qstats_base record the per counter=
 starting point.<br>
+ * Let's update them now.<br>
&nbsp; */<br>
&nbsp;int<br>
&nbsp;nfp_net_stats_reset(struct rte_eth_dev *dev)<br>
@@ -998,10 +1002,10 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_stats_base.q_ipackets[i] =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_qstats_base.q_ipackets[i] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, =
NFP_NET_CFG_RXR_STATS(i));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_stats_base.q_ibytes[i] =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_qstats_base.q_ibytes[i] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, =
NFP_NET_CFG_RXR_STATS(i) + 0x8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1010,10 +1014,10 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i =3D=3D RTE_ETHDEV_QUEUE_STAT_CNTRS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_stats_base.q_opackets[i] =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_qstats_base.q_opackets[i] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, =
NFP_NET_CFG_TXR_STATS(i));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_stats_base.q_obytes[i] =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw-&gt;eth_qstats_base.q_obytes[i] =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nn_cfg_readq(&amp;hw-&gt;super, =
NFP_NET_CFG_TXR_STATS(i) + 0x8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_com=
mon.h<br>
index a6addf8610..2bd2d54028 100644<br>
--- a/drivers/net/nfp/nfp_net_common.h<br>
+++ b/drivers/net/nfp/nfp_net_common.h<br>
@@ -250,6 +250,7 @@ struct nfp_net_hw {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Records starting point=
 for counters */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats eth_s=
tats_base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats eth_qstats_bas=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *eth_=
xstats_base;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct nfp_cpp_area *ctrl_=
area;<br>
@@ -301,7 +302,8 @@ int nfp_net_link_update_common(struct rte_eth_dev *dev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t link_status);<br>
&nbsp;int nfp_net_link_update(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __rte_unused int wait_to_complete);<br>
-int nfp_net_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
);<br>
+int nfp_net_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;int nfp_net_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;uint32_t nfp_net_xstats_size(const struct rte_eth_dev *dev);<br>
&nbsp;int nfp_net_xstats_get_names(struct rte_eth_dev *dev,<br>
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.=
c<br>
index d3ac40299f..adb7785498 100644<br>
--- a/drivers/net/ngbe/ngbe_ethdev.c<br>
+++ b/drivers/net/ngbe/ngbe_ethdev.c<br>
@@ -1498,7 +1498,8 @@ ngbe_read_stats_registers(struct ngbe_hw *hw,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ngbe_hw *hw =3D ngb=
e_dev_hw(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ngbe_hw_stats *hw_s=
tats =3D NGBE_DEV_STATS(dev);<br>
@@ -1518,29 +1519,31 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D hw_=
stats-&gt;tx_packets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D hw_st=
ats-&gt;tx_bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_ipackets, 0, =
sizeof(stats-&gt;q_ipackets));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_opackets, 0, =
sizeof(stats-&gt;q_opackets));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_ibytes, 0, si=
zeof(stats-&gt;q_ibytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_obytes, 0, si=
zeof(stats-&gt;q_obytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_errors, 0, si=
zeof(stats-&gt;q_errors));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NGBE_MAX_QP; i++=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t offset =3D (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t q_map;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_map =3D (stat_mappings-&gt;rqsm[n] &gt;&gt; offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; j =3D (q_map &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE=
_STAT_CNTRS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[j] +=3D hw_stats-&gt;qp[i].rx_qp_packets;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[j] +=3D hw_stats-&gt;qp[i].rx_qp_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_map =3D (stat_mappings-&gt;tqsm[n] &gt;&gt; offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; j =3D (q_map &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE=
_STAT_CNTRS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[j] +=3D hw_stats-&gt;qp[i].tx_qp_packets;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[j] +=3D hw_stats-&gt;qp[i].tx_qp_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_ipackets, 0, sizeof(qstats-&gt;q_ipacke=
ts));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_opackets, 0, sizeof(qstats-&gt;q_opacke=
ts));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_ibytes, 0, sizeof(qstats-&gt;q_ibytes))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_obytes, 0, sizeof(qstats-&gt;q_obytes))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_errors, 0, sizeof(qstats-&gt;q_errors))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; NGBE_MAX_QP; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t n =3D i=
 / NB_QMAP_FIELDS_PER_QSM_REG;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset =
=3D (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t q_map;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_map =3D (stat_=
mappings-&gt;rqsm[n] &gt;&gt; offset)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D (q_map &lt=
; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[j] +=3D hw_stats-&gt;qp[i].rx_qp_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[j] +=3D hw_stats-&gt;qp[i].rx_qp_bytes;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_map =3D (stat_=
mappings-&gt;tqsm[n] &gt;&gt; offset)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D (q_map &lt=
; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[j] +=3D hw_stats-&gt;qp[i].tx_qp_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[j] +=3D hw_stats-&gt;qp[i].tx_qp_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Rx Errors */<br>
@@ -1580,7 +1583,7 @@ ngbe_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HW registers are cleare=
d on read */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;offset_loaded =3D 0=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ngbe_dev_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ngbe_dev_stats_get(dev, NULL, NULL);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;offset_loaded =3D 1=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset software totals *=
/<br>
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethd=
ev_vf.c<br>
index 846bc981f6..e575c47049 100644<br>
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c<br>
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c<br>
@@ -425,7 +425,8 @@ ngbevf_dev_xstats_get(struct rte_eth_dev *dev, struct r=
te_eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-ngbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)=
<br>
+ngbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ngbevf_hw_stats *hw=
_stats =3D (struct ngbevf_hw_stats *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; NGBE_DEV_STATS(dev);<br>
@@ -449,7 +450,7 @@ ngbevf_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NGBE_=
DEV_STATS(dev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sync HW register to the=
 last stats */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ngbevf_dev_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ngbevf_dev_stats_get(dev, NULL, NULL)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset HW current stats*=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_stats-&gt;vfgprc =3D 0;=
<br>
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_eth=
dev.c<br>
index 79ef9e7e7c..4c090aa521 100644<br>
--- a/drivers/net/ntnic/ntnic_ethdev.c<br>
+++ b/drivers/net/ntnic/ntnic_ethdev.c<br>
@@ -167,7 +167,8 @@ get_pdrv_from_pci(struct rte_pci_addr addr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p_drv;<br>
&nbsp;}<br>
&nbsp;<br>
-static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_=
eth_stats *stats)<br>
+static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_=
eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ntnic_filter_=
ops *ntnic_filter_ops =3D get_ntnic_filter_ops();<br>
&nbsp;<br>
@@ -201,19 +202,19 @@ static int dpdk_stats_collect(struct pmd_internals *i=
nternals, struct rte_eth_st<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ntnic_filter_ops-&gt;poll_=
statistics(internals);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; inter=
nals-&gt;nb_rx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D internals-&gt;rxq_scg[i].rx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D internals-&gt;rxq_scg[i].rx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D internals-&gt;rxq_scg[i].rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D internals-&gt;rxq_scg[i].rx_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_total +=3D internals-&gt;rxq_scg[i].rx_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_total_b +=3D internals-&gt;rxq_scg[i].rx_bytes;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; inter=
nals-&gt;nb_tx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D internals-&gt;txq_scg[i].tx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D internals-&gt;txq_scg[i].tx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] =3D internals-&gt;txq_scg[i].err_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D internals-&gt;txq_scg[i].tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D internals-&gt;txq_scg[i].tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D internals-&gt;txq_scg[i].err_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_total +=3D internals-&gt;txq_scg[i].tx_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_total_b +=3D internals-&gt;txq_scg[i].tx_bytes;<br=
>
@@ -303,10 +304,11 @@ eth_link_update(struct rte_eth_dev *eth_dev, int wait=
_to_complete __rte_unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats=
 *stats)<br>
+static int eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats=
 *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pmd_internals *inte=
rnals =3D eth_dev-&gt;data-&gt;dev_private;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpdk_stats_collect(internals, stats);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpdk_stats_collect(internals, stats, =
qstats);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_nul=
l.c<br>
index 4f273319f2..14bc65c8ad 100644<br>
--- a/drivers/net/null/rte_eth_null.c<br>
+++ b/drivers/net/null/rte_eth_null.c<br>
@@ -426,7 +426,8 @@ eth_dev_info(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pmd_internals=
 *internal =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
@@ -438,9 +439,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_s=
tats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -454,9 +455,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_s=
tats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/=
otx_ep_ethdev.c<br>
index 10f2f8a2e0..79dc02ee0b 100644<br>
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c<br>
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c<br>
@@ -608,7 +608,8 @@ otx_ep_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct otx_ep_device *otx_=
epvf =3D OTX_EP_DEV(eth_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct otx_ep_iq_stats *os=
tats;<br>
@@ -619,17 +620,21 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; otx_e=
pvf-&gt;nb_tx_queues; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ostats =3D &amp;otx_epvf-&gt;instr_queue[i]-&gt;stats=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D ostats-&gt;tx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D ostats-&gt;tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D ostats-&gt;tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D ostats-&gt;tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets +=3D ostats-&gt;tx_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D ostats-&gt;tx_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D ostats-&gt;instr_dropped;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; otx_e=
pvf-&gt;nb_rx_queues; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; istats =3D &amp;otx_epvf-&gt;droq[i]-&gt;stats;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D istats-&gt;pkts_received;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D istats-&gt;bytes_received;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D istats-&gt;rx_err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D istats-&gt;pkts_received;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D istats-&gt;bytes_received;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D istats-&gt;rx_err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D istats-&gt;pkts_received;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D istats-&gt;bytes_received;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D istats-&gt;rx_alloc_failure;<b=
r>
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/=
octeontx_ethdev.c<br>
index 9451431144..21e3e56901 100644<br>
--- a/drivers/net/octeontx/octeontx_ethdev.c<br>
+++ b/drivers/net/octeontx/octeontx_ethdev.c<br>
@@ -1022,7 +1022,8 @@ octeontx_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-octeontx_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s)<br>
+octeontx_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats=
 *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct octeontx_nic *nic =
=3D octeontx_pmd_priv(dev);<br>
&nbsp;<br>
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.=
c<br>
index 728ef85d53..f323c0b0df 100644<br>
--- a/drivers/net/pcap/pcap_ethdev.c<br>
+++ b/drivers/net/pcap/pcap_ethdev.c<br>
@@ -750,7 +750,8 @@ eth_dev_info(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long rx_packets_t=
otal =3D 0, rx_bytes_total =3D 0;<br>
@@ -762,21 +763,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_E=
THDEV_QUEUE_STAT_CNTRS &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &lt=
; dev-&gt;data-&gt;nb_rx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D internal-&gt;rx_queue[i].rx_stat.pkt=
s;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D internal-&gt;rx_queue[i].rx_stat.bytes=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D internal-&gt;rx_queue[i].rx_stat.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D internal-&gt;rx_queue[i].rx_stat.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_nombuf_total +=3D internal-&gt;rx_queue[i].rx_stat=
.rx_nombuf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_err_total +=3D internal-&gt;rx_queue[i].rx_stat.er=
r_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_packets_total +=3D stats-&gt;q_ipackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_bytes_total +=3D stats-&gt;q_ibytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_packets_total +=3D internal-&gt;rx_queue[i].rx_stat.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_bytes_total +=3D internal-&gt;rx_queue[i].rx_stat.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_missed_total +=3D queue_missed_stat_get(dev, i);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_E=
THDEV_QUEUE_STAT_CNTRS &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &lt=
; dev-&gt;data-&gt;nb_tx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D internal-&gt;tx_queue[i].tx_stat.pkt=
s;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D internal-&gt;tx_queue[i].tx_stat.bytes=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_packets_total +=3D stats-&gt;q_opackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_bytes_total +=3D stats-&gt;q_obytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D internal-&gt;tx_queue[i].tx_stat.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D internal-&gt;tx_queue[i].tx_stat.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_packets_total +=3D internal-&gt;tx_queue[i].tx_stat.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_bytes_total +=3D internal-&gt;tx_queue[i].tx_stat.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_packets_err_total +=3D internal-&gt;tx_queue[i].tx=
_stat.err_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c<br=
>
index 725ffcb2bc..1efa17539e 100644<br>
--- a/drivers/net/pfe/pfe_ethdev.c<br>
+++ b/drivers/net/pfe/pfe_ethdev.c<br>
@@ -713,7 +713,8 @@ pfe_dev_set_mac_addr(struct rte_eth_dev *dev,<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;pfe_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pfe_eth_priv_s *pri=
v =3D dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *eth_=
stats =3D &amp;priv-&gt;stats;<br>
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.=
c<br>
index bee9fa4f60..e1c28a0ac2 100644<br>
--- a/drivers/net/qede/qede_ethdev.c<br>
+++ b/drivers/net/qede/qede_ethdev.c<br>
@@ -1592,7 +1592,8 @@ static int qede_dev_close(struct rte_eth_dev *eth_dev=
)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stat=
s)<br>
+qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stat=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qede_dev *qdev =3D =
eth_dev-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ecore_dev *edev =3D=
 &amp;qdev-&gt;edev;<br>
@@ -1645,18 +1646,18 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct =
rte_eth_stats *eth_stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; appr=
opriately and retry.\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (qid =3D 0; qid &lt; e=
th_dev-&gt;data-&gt;nb_rx_queues; qid++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; eth_stats-&gt;q_ipackets[i] =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; eth_stats-&gt;q_errors[i] =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_ipackets =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_errors =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for_each_hwfn(edev, hw_fn) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =
=3D qid * edev-&gt;num_hwfns + hw_fn;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_stats-&gt;q_=
ipackets[i] +=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_ipackets +=3D<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (((char *)(qdev-&gt;fp_array[idx].rxq)) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; offsetof(struct qede_rx_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rcv_pkts));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_stats-&gt;q_=
errors[i] +=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_errors +=3D<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (((char *)(qdev-&gt;fp_array[idx].rxq)) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; offsetof(struct qede_rx_queue,<br>
@@ -1667,25 +1668,33 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct =
rte_eth_stats *eth_stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_alloc_errors));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D q_ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D q_errors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; i++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (i =3D=3D rxq_stat_cntrs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (qid =3D 0; qid &lt; e=
th_dev-&gt;data-&gt;nb_tx_queues; qid++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; eth_stats-&gt;q_opackets[j] =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t q_opackets =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for_each_hwfn(edev, hw_fn) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =
=3D qid * edev-&gt;num_hwfns + hw_fn;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txq =
=3D qdev-&gt;fp_array[idx].txq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth_stats-&gt;q_=
opackets[j] +=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_opackets +=3D<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *((uint64_t *)(uintptr_t)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (((uint64_t)(uintptr_t)(txq)) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; offsetof(struct qede_tx_queue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 xmit_pkts)));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[j] =3D q_opackets;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; j++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (j =3D=3D txq_stat_cntrs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_eth=
dev.c<br>
index 8071e14412..69512ced8b 100644<br>
--- a/drivers/net/r8169/r8169_ethdev.c<br>
+++ b/drivers/net/r8169/r8169_ethdev.c<br>
@@ -37,7 +37,8 @@ static int rtl_dev_set_link_down(struct rte_eth_dev *dev)=
;<br>
&nbsp;static int rtl_dev_infos_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev_info *dev_info);<br>
&nbsp;static int rtl_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *rte_stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct rte_eth_stats *rte_stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;static int rtl_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int rtl_promiscuous_enable(struct rte_eth_dev *dev);<br>
&nbsp;static int rtl_promiscuous_disable(struct rte_eth_dev *dev);<br>
@@ -533,7 +534,8 @@ rtl_sw_stats_get(struct rte_eth_dev *dev, struct rte_et=
h_stats *rte_stats)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
)<br>
+rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rtl_adapter *adapte=
r =3D RTL_DEV_PRIVATE(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rtl_hw *hw =3D &amp=
;adapter-&gt;hw;<br>
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_rin=
g.c<br>
index b1085bf390..b639544eab 100644<br>
--- a/drivers/net/ring/rte_eth_ring.c<br>
+++ b/drivers/net/ring/rte_eth_ring.c<br>
@@ -196,7 +196,8 @@ eth_dev_info(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long rx_total =3D=
 0, tx_total =3D 0;<br>
@@ -204,14 +205,16 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth=
_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_E=
THDEV_QUEUE_STAT_CNTRS &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &lt=
; dev-&gt;data-&gt;nb_rx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D internal-&gt;rx_ring_queues[i].rx_pk=
ts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total +=3D stats-&gt;q_ipackets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D internal-&gt;rx_ring_queues[i].rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total +=3D internal-&gt;rx_ring_queues[i].rx_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_E=
THDEV_QUEUE_STAT_CNTRS &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &lt=
; dev-&gt;data-&gt;nb_tx_queues; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D internal-&gt;tx_ring_queues[i].tx_pk=
ts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total +=3D stats-&gt;q_opackets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D internal-&gt;tx_ring_queues[i].tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total +=3D internal-&gt;tx_ring_queues[i].tx_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets =3D rx_=
total;<br>
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c<br=
>
index de1c077f61..f5babb797d 100644<br>
--- a/drivers/net/rnp/rnp_ethdev.c<br>
+++ b/drivers/net/rnp/rnp_ethdev.c<br>
@@ -1233,7 +1233,8 @@ static void rnp_get_hw_stats(struct rte_eth_dev *dev)=
<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;rnp_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rnp_eth_port *port =
=3D RNP_DEV_TO_PORT(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rnp_hw_eth_stats *e=
th_stats =3D &amp;port-&gt;eth_stats;<br>
@@ -1251,9 +1252,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D rxq-&gt;stats.ipackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D rxq-&gt;stats.ibytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D rxq-&gt;stats.ipackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D rxq-&gt;stats.ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rxq-&gt;stats.ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rxq-&gt;stats.ibytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1265,9 +1266,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets +=3D txq-&gt;stats.opackets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D txq-&gt;stats.obytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D txq-&gt;stats.errors;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D txq-&gt;stats.opackets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D txq-&gt;stats.obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D txq-&gt;stats.opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D txq-&gt;stats.obytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed =3D eth_=
stats-&gt;rx_trans_drop + eth_stats-&gt;rx_trunc_drop;<br>
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c<br=
>
index 8b0bf4eeee..99141bdda5 100644<br>
--- a/drivers/net/sfc/sfc_ethdev.c<br>
+++ b/drivers/net/sfc/sfc_ethdev.c<br>
@@ -823,7 +823,8 @@ sfc_update_diff_stat(uint64_t *stat, uint64_t newval)<b=
r>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-sfc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+sfc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct sfc_adapter_p=
riv *sap =3D sfc_adapter_priv_by_eth_dev(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool have_dp_rx_stats =3D =
sap-&gt;dp_rx-&gt;features &amp; SFC_DP_RX_FEAT_STATS;<br>
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c<br>
index 18e76fa7da..93da97387c 100644<br>
--- a/drivers/net/sfc/sfc_repr.c<br>
+++ b/drivers/net/sfc/sfc_repr.c<br>
@@ -846,7 +846,8 @@ sfc_repr_mac_addr_set(struct rte_eth_dev *dev, struct r=
te_ether_addr *mac_addr)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-sfc_repr_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+sfc_repr_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats __rte_unu=
sed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union sfc_pkts_bytes queue=
_stats;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t i;<br>
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c<=
br>
index 650ddbd706..3c9ba829d6 100644<br>
--- a/drivers/net/tap/rte_eth_tap.c<br>
+++ b/drivers/net/tap/rte_eth_tap.c<br>
@@ -1030,7 +1030,8 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_=
dev_info *dev_info)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats)<br=
>
+tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, imax;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long rx_total =3D=
 0, tx_total =3D 0, tx_err_total =3D 0;<br>
@@ -1042,10 +1043,12 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *tap_stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; imax =3D (dev-&gt;data-&gt=
;nb_rx_queues &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt;nb_rx_queues : RTE_ETHDEV_QUEUE_STAT=
_CNTRS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; imax;=
 i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tap_stats-&gt;q_ipackets[i] =3D pmd-&gt;rxq[i].stats.ipackets;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tap_stats-&gt;q_ibytes[i] =3D pmd-&gt;rxq[i].stats.ibytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total +=3D tap_stats-&gt;q_ipackets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_bytes_total +=3D tap_stats-&gt;q_ibytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D pmd-&gt;rxq[i].stats.ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D pmd-&gt;rxq[i].stats.ibytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total +=3D pmd-&gt;rxq[i].stats.ipackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_bytes_total +=3D pmd-&gt;rxq[i].stats.ibytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rx_nombuf +=3D pmd-&gt;rxq[i].stats.rx_nombuf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ierrors +=3D pmd-&gt;rxq[i].stats.ierrors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1055,11 +1058,13 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *tap_stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev-&gt;data-&gt;nb_tx_queues : RTE_ETHDEV_QUEUE_STAT=
_CNTRS;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; imax;=
 i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tap_stats-&gt;q_opackets[i] =3D pmd-&gt;txq[i].stats.opackets;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tap_stats-&gt;q_obytes[i] =3D pmd-&gt;txq[i].stats.obytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total +=3D tap_stats-&gt;q_opackets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D pmd-&gt;txq[i].stats.opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D pmd-&gt;txq[i].stats.obytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total +=3D pmd-&gt;txq[i].stats.opackets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_bytes_total +=3D pmd-&gt;txq[i].stats.obytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_err_total +=3D pmd-&gt;txq[i].stats.errs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_bytes_total +=3D tap_stats-&gt;q_obytes[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tap_stats-&gt;ipackets =3D=
 rx_total;<br>
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nic=
vf_ethdev.c<br>
index 4441a90bdf..76ed76a045 100644<br>
--- a/drivers/net/thunderx/nicvf_ethdev.c<br>
+++ b/drivers/net/thunderx/nicvf_ethdev.c<br>
@@ -289,7 +289,8 @@ nicvf_dev_get_regs(struct rte_eth_dev *dev, struct rte_=
dev_reg_info *regs)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<=
br>
+nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t qidx;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct nicvf_hw_rx_qstats =
rx_qstats;<br>
@@ -309,8 +310,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; nicvf_hw_get_rx_qstats(nic, &amp;rx_qstats, qidx);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[qidx] =3D rx_qstats.q_rx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[qidx] =3D rx_qstats.q_rx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[qidx] =3D rx_qstats.q_rx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[qidx] =3D rx_qstats.q_rx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TX queue indices for th=
e first VF */<br>
@@ -322,8 +325,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; nicvf_hw_get_tx_qstats(nic, &amp;tx_qstats, qidx);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[qidx] =3D tx_qstats.q_tx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[qidx] =3D tx_qstats.q_tx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[qidx] =3D tx_qstats.q_tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[qidx] =3D tx_qstats.q_tx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; nic-&=
gt;sqs_count; i++) {<br>
@@ -342,8 +347,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nicvf=
_hw_get_rx_qstats(snic, &amp;rx_qstats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qidx % MAX_RCV_QU=
EUES_PER_QS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[qidx] =3D rx_qstats.q_rx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[qidx] =3D rx_qstats.q_rx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D =
NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ibytes[qidx] =3D rx_qstats.q_r=
x_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipackets[qidx] =3D rx_qstats.q=
_rx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* TX queue indices for a secondary VF */<br>
@@ -355,8 +362,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rt=
e_eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nicvf=
_hw_get_tx_qstats(snic, &amp;tx_qstats,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qidx % MAX_SND_QU=
EUES_PER_QS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[qidx] =3D tx_qstats.q_tx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[qidx] =3D tx_qstats.q_tx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D =
NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_obytes[qidx] =3D tx_qstats.q_t=
x_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opackets[qidx] =3D tx_qstats.q=
_tx_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_eth=
dev.c<br>
index 580579094b..33d1d59ead 100644<br>
--- a/drivers/net/txgbe/txgbe_ethdev.c<br>
+++ b/drivers/net/txgbe/txgbe_ethdev.c<br>
@@ -2342,7 +2342,8 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<=
br>
+txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct txgbe_hw *hw =3D TX=
GBE_DEV_HW(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct txgbe_hw_stats *hw_=
stats =3D TXGBE_DEV_STATS(dev);<br>
@@ -2362,29 +2363,31 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets =3D hw_=
stats-&gt;tx_packets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes =3D hw_st=
ats-&gt;tx_bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_ipackets, 0, =
sizeof(stats-&gt;q_ipackets));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_opackets, 0, =
sizeof(stats-&gt;q_opackets));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_ibytes, 0, si=
zeof(stats-&gt;q_ibytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_obytes, 0, si=
zeof(stats-&gt;q_obytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;stats-&gt;q_errors, 0, si=
zeof(stats-&gt;q_errors));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; TXGBE_MAX_QP; i+=
+) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t n =3D i / NB_QMAP_FIELDS_PER_QSM_REG;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t offset =3D (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t q_map;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_map =3D (stat_mappings-&gt;rqsm[n] &gt;&gt; offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; j =3D (q_map &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE=
_STAT_CNTRS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[j] +=3D hw_stats-&gt;qp[i].rx_qp_packets;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[j] +=3D hw_stats-&gt;qp[i].rx_qp_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; q_map =3D (stat_mappings-&gt;tqsm[n] &gt;&gt; offset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; j =3D (q_map &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE=
_STAT_CNTRS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[j] +=3D hw_stats-&gt;qp[i].tx_qp_packets;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[j] +=3D hw_stats-&gt;qp[i].tx_qp_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_ipackets, 0, sizeof(qstats-&gt;q_ipacke=
ts));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_opackets, 0, sizeof(qstats-&gt;q_opacke=
ts));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_ibytes, 0, sizeof(qstats-&gt;q_ibytes))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_obytes, 0, sizeof(qstats-&gt;q_obytes))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(&amp;qstats-&gt;q_errors, 0, sizeof(qstats-&gt;q_errors))=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; TXGBE_MAX_QP; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t n =3D i=
 / NB_QMAP_FIELDS_PER_QSM_REG;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset =
=3D (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t q_map;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_map =3D (stat_=
mappings-&gt;rqsm[n] &gt;&gt; offset)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D (q_map &lt=
; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[j] +=3D hw_stats-&gt;qp[i].rx_qp_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[j] +=3D hw_stats-&gt;qp[i].rx_qp_bytes;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q_map =3D (stat_=
mappings-&gt;tqsm[n] &gt;&gt; offset)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp; QMAP_FIELD_RESERVED_BITS_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D (q_map &lt=
; RTE_ETHDEV_QUEUE_STAT_CNTRS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[j] +=3D hw_stats-&gt;qp[i].tx_qp_packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[j] +=3D hw_stats-&gt;qp[i].tx_qp_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Rx Errors */<br>
@@ -2426,7 +2429,7 @@ txgbe_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HW registers are cleare=
d on read */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;offset_loaded =3D 0=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txgbe_dev_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txgbe_dev_stats_get(dev, NULL, NULL);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw-&gt;offset_loaded =3D 1=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset software totals *=
/<br>
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_=
ethdev_vf.c<br>
index 847febf8c3..b369070da8 100644<br>
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c<br>
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c<br>
@@ -494,7 +494,8 @@ txgbevf_dev_xstats_get(struct rte_eth_dev *dev, struct =
rte_eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-txgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)<br>
+txgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qsta=
ts __rte_unused)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct txgbevf_hw_stats *h=
w_stats =3D (struct txgbevf_hw_stats *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; TXGBE_DEV_STATS(dev);<br>
@@ -528,7 +529,7 @@ txgbevf_dev_stats_reset(struct rte_eth_dev *dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sync HW register to the=
 last stats */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txgbevf_dev_stats_get(dev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; txgbevf_dev_stats_get(dev, NULL, NULL=
);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset HW current stats*=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i+=
+) {<br>
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_=
vhost.c<br>
index 87c91e2f96..05940f2461 100644<br>
--- a/drivers/net/vhost/rte_eth_vhost.c<br>
+++ b/drivers/net/vhost/rte_eth_vhost.c<br>
@@ -1310,7 +1310,8 @@ eth_dev_info(struct rte_eth_dev *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<br>
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long rx_total =3D=
 0, tx_total =3D 0;<br>
@@ -1323,11 +1324,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;data-&gt;rx_queues[i] =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vq =3D dev-&gt;data-&gt;rx_queues[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D vq-&gt;stats.pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total +=3D stats-&gt;q_ipackets[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D vq-&gt;stats.bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total_bytes +=3D stats-&gt;q_ibytes[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D vq-&gt;stats.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D vq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total +=3D vq-&gt;stats.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rx_total_bytes +=3D vq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; RTE_E=
THDEV_QUEUE_STAT_CNTRS &amp;&amp;<br>
@@ -1335,12 +1337,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_e=
th_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;data-&gt;tx_queues[i] =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vq =3D dev-&gt;data-&gt;tx_queues[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D vq-&gt;stats.pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total +=3D stats-&gt;q_opackets[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D vq-&gt;stats.bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total_bytes +=3D stats-&gt;q_obytes[i];<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D vq-&gt;stats.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D vq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total +=3D vq-&gt;stats.pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_total_bytes +=3D vq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tx_total_errors +=3D vq-&gt;stats.missed_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio=
_ethdev.c<br>
index eebc3ea817..e45dbd8ee9 100644<br>
--- a/drivers/net/virtio/virtio_ethdev.c<br>
+++ b/drivers/net/virtio/virtio_ethdev.c<br>
@@ -68,7 +68,8 @@ static void virtio_set_hwaddr(struct virtio_hw *hw);<br>
&nbsp;static void virtio_get_hwaddr(struct virtio_hw *hw);<br>
&nbsp;<br>
&nbsp;static int virtio_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;static int virtio_dev_xstats_get(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_xstat *xsta=
ts, unsigned n);<br>
&nbsp;static int virtio_dev_xstats_get_names(struct rte_eth_dev *dev,<br>
@@ -673,7 +674,8 @@ const struct eth_dev_ops virtio_user_secondary_eth_dev_=
ops =3D {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static void<br>
-virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<=
br>
+virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&nbsp;<br>
@@ -685,9 +687,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets +=3D txvq-&gt;stats.packets;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D txvq-&gt;stats.bytes;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D txvq-&gt;stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D txvq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D txvq-&gt;stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D txvq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -700,9 +702,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte=
_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ibytes +=3D rxvq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors +=3D rxvq-&gt;stats.errors;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D rxvq-&gt;stats.packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D rxvq-&gt;stats.bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D rxvq-&gt;stats.packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D rxvq-&gt;stats.bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -802,9 +804,10 @@ virtio_dev_xstats_get(struct rte_eth_dev *dev, struct =
rte_eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-virtio_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)=
<br>
+virtio_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_update_stats(dev, stats);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_update_stats(dev, stats, qstat=
s);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmx=
net3_ethdev.c<br>
index e19aa43888..b0c19c5c7c 100644<br>
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c<br>
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c<br>
@@ -77,7 +77,8 @@ static int vmxnet3_dev_link_update(struct rte_eth_dev *de=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int wait_to_co=
mplete);<br>
&nbsp;static void vmxnet3_hw_stats_save(struct vmxnet3_hw *hw);<br>
&nbsp;static int vmxnet3_dev_stats_get(struct rte_eth_dev *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_stats *stats,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct eth_queue_stats *qstats)=
;<br>
&nbsp;static int vmxnet3_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;static int vmxnet3_dev_xstats_get_names(struct rte_eth_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct rte_eth_xstat_name *xstats,<br>
@@ -1470,7 +1471,8 @@ vmxnet3_dev_xstats_get(struct rte_eth_dev *dev, struc=
t rte_eth_xstat *xstats,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
)<br>
+vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vmxnet3_hw *hw =3D =
dev-&gt;data-&gt;dev_private;<br>
@@ -1495,9 +1497,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct=
 rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;oerrors +=3D txStats.pktsTxError + txStats.=
pktsTxDiscard;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[i] =3D packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[i] =3D bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1517,10 +1519,10 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, stru=
ct rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ierrors +=3D rxStats.pktsRxError;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;imissed +=3D rxStats.pktsRxOutOfBuf;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[i] =3D packets;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[i] =3D bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[i] =3D rxStats.pktsRxError;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; i &lt; RTE_ETHDEV_QUEUE_STAT_CNT=
RS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D packets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D rxStats.pktsRxError;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c<br=
>
index 988d734b5b..07fc52ac7b 100644<br>
--- a/drivers/net/xsc/xsc_ethdev.c<br>
+++ b/drivers/net/xsc/xsc_ethdev.c<br>
@@ -577,7 +577,8 @@ xsc_ethdev_set_mtu(struct rte_eth_dev *dev, uint16_t mt=
u)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
-xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)=
<br>
+xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xsc_ethdev_priv *pr=
iv =3D TO_XSC_ETHDEV_PRIV(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rxqs_n =3D priv-&=
gt;num_rq;<br>
@@ -592,10 +593,10 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D rxq-&gt;idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (idx &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ipac=
kets[idx] +=3D rxq-&gt;stats.rx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_ibyt=
es[idx] +=3D rxq-&gt;stats.rx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[idx] +=3D rxq-&gt;stats.rx_errors +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; idx &lt; RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[idx] +=3D rxq-&gt;stats.rx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[idx] +=3D rxq-&gt;stats.rx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[idx] +=3D rxq-&gt;stats.rx_errors +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rxq-&gt;sta=
ts.rx_nombuf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;ipackets +=3D rxq-&gt;stats.rx_pkts;<br>
@@ -610,10 +611,10 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D txq-&gt;idx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (idx &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_opac=
kets[idx] +=3D txq-&gt;stats.tx_pkts;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_obyt=
es[idx] +=3D txq-&gt;stats.tx_bytes;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stats-&gt;q_erro=
rs[idx] +=3D txq-&gt;stats.tx_errors;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL &amp;&amp; idx &lt; RTE_ETHDEV_QUEUE_STAT_C=
NTRS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[idx] +=3D txq-&gt;stats.tx_pkts;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[idx] +=3D txq-&gt;stats.tx_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[idx] +=3D txq-&gt;stats.tx_errors;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;opackets +=3D txq-&gt;stats.tx_pkts;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; stats-&gt;obytes +=3D txq-&gt;stats.tx_bytes;<br>
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_eth=
dev_ops.c<br>
index da32512b03..6d9f0af748 100644<br>
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c<br>
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c<br>
@@ -1698,7 +1698,8 @@ zxdh_hw_np_stats_get(struct rte_eth_dev *dev, struct =
zxdh_hw_np_stats *np_stats)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int<br>
-zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)<b=
r>
+zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct zxdh_hw *hw =3D dev=
-&gt;data-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct zxdh_hw_vqm_stats v=
qm_stats =3D {0};<br>
@@ -1730,14 +1731,16 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (rxvq =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ipackets[i] =3D *(uint64_t *)(((char *)rxvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_rxq_stat_strings[0].offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_ibytes[i] =3D *(uint64_t *)(((char *)rxvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_rxq_stat_strings[1].offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] =3D *(uint64_t *)(((char *)rxvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_rxq_stat_strings[2].offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] +=3D *(uint64_t *)(((char *)rxvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_rxq_stat_strings[5].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_ipa=
ckets[i] =3D *(uint64_t *)(((char *)rxvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_rxq_stat_strings[0].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_iby=
tes[i] =3D *(uint64_t *)(((char *)rxvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_rxq_stat_strings[1].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] =3D *(uint64_t *)(((char *)rxvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_rxq_stat_strings[2].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] +=3D *(uint64_t *)(((char *)rxvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_rxq_stat_strings[5].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; (i &lt; dev-=
&gt;data-&gt;nb_tx_queues) &amp;&amp; (i &lt; RTE_ETHDEV_QUEUE_STAT_CNTRS);=
 i++) {<br>
@@ -1745,14 +1748,16 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct =
rte_eth_stats *stats)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (txvq =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_opackets[i] =3D *(uint64_t *)(((char *)txvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_txq_stat_strings[0].offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_obytes[i] =3D *(uint64_t *)(((char *)txvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_txq_stat_strings[1].offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] +=3D *(uint64_t *)(((char *)txvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_txq_stat_strings[2].offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; stats-&gt;q_errors[i] +=3D *(uint64_t *)(((char *)txvq) +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; zxdh_txq_stat_strings[5].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qstats !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_opa=
ckets[i] =3D *(uint64_t *)(((char *)txvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_txq_stat_strings[0].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_oby=
tes[i] =3D *(uint64_t *)(((char *)txvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_txq_stat_strings[1].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] +=3D *(uint64_t *)(((char *)txvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_txq_stat_strings[2].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qstats-&gt;q_err=
ors[i] +=3D *(uint64_t *)(((char *)txvq) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; zxdh_txq_stat_strings[5].offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.h b/drivers/net/zxdh/zxdh_eth=
dev_ops.h<br>
index 86db6efe40..85e926887b 100644<br>
--- a/drivers/net/zxdh/zxdh_ethdev_ops.h<br>
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.h<br>
@@ -130,7 +130,8 @@ int zxdh_dev_rss_reta_query(struct rte_eth_dev *dev,<br=
>
&nbsp;int zxdh_rss_hash_update(struct rte_eth_dev *dev, struct rte_eth_rss_=
conf *rss_conf);<br>
&nbsp;int zxdh_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rs=
s_conf *rss_conf);<br>
&nbsp;int zxdh_rss_configure(struct rte_eth_dev *dev);<br>
-int zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s);<br>
+int zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stat=
s,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct eth_queue_stats *qstats);<br>
&nbsp;int zxdh_dev_stats_reset(struct rte_eth_dev *dev);<br>
&nbsp;int zxdh_dev_mtu_set(struct rte_eth_dev *dev, uint16_t new_mtu);<br>
&nbsp;int zxdh_hw_np_stats_pf_reset(struct rte_eth_dev *dev, uint32_t stats=
_id);<br>
--<br>
2.48.1<br>
<br>
</div>
<div style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica =
Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
<span style=3D"background-color: rgb(255, 255, 255);">Reviewed-by: Rosen Xu=
 &lt;rosen.xu@altera.com&gt;</span></div>
</body>
</html>

--_000_CH2PR03MB523960813B7CCA35AA8B5668FC1CACH2PR03MB5239namp_--
