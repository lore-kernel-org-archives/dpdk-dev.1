Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D0CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 06:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07DE4402A0;
	Wed,  8 Oct 2025 08:01:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3E21840297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 08:01:32 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597NnIc2017483;
 Tue, 7 Oct 2025 23:01:31 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022087.outbound.protection.outlook.com [52.101.48.87])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49ncv0ghp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 23:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agWusR21/opIbhtWfJ/BJff9eRvnAUha4Mc72sds1UHL8oUHQtiuCvEBskuVa+ab5Y78oxktz2JGm1LwDH+mBaItHvhg0gW9yZQ05ELt4I0g8cCYq6wEI+pbVWdTJiKGT32HMimgMyNdnjXOCGiycwm5LljK4FBl3cyeXfweYifR2ETkeJru81rbMtX5z8QUDX/bXygo89HsvZ30lbhwNEHsfaUuIY5jQS86dNbwY6kOV0ofwQ1/bhzYZzg1nhJ3H9SYe9uh1TcnXVqweXo9Eu+JQ1rDSMHNXTUZLbup4FI/jAo7pFL860tyo8TE6wFQ1hQv3Zc4+L5KVSvxK6MARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGONN8zUf+Kdi+QPsUEQJOUKiyiRwnu1ZRwLVI1LHts=;
 b=Z94vpJ5okc/OLIfo9HVr9WDNP4m8BezyqJhX7c+xyXXVlsCkvJLYpPVa9sMOAeDTadNYqmcwjKPfjabc5YKbA3Xauigx8Qupz6XZRIGdN+tsIpza+W/EC57ITnUAZDxGwts+eC99ESV8VpK4dfzA0MoYYDl4XM33T46Taag4y/JErk3RuhlOE8xO2pXaYXsXslBZzfUp3dm0tfifrevVenPEB5HLyhvl2PhztNPG5YZBdtFWjT8vDMg6CilOGSdui0P+AofeG7XM4eQ/jNpHsZeSyhG7cANHdPw8rNiNzT07ruxr9xeIab6MUs9usCnCkVckPB9NI1oF50aWIJeqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGONN8zUf+Kdi+QPsUEQJOUKiyiRwnu1ZRwLVI1LHts=;
 b=FXnf08cmpW/992NPddSITwwRRHiN3VPB/4bur5CRRcrQP0EFizgAJ2qMWQHVLZJ8l9XCKMKDjmrAOZoEgApvt7ZgmOLmeKIoqSOtYkQRXqFUn6hl3RbR89Yrz5wqU+mTHkWBeFXWFhx0WpfGplvzFFmpIYHBtD/tW0om4pLDVHQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 SN7PR18MB3839.namprd18.prod.outlook.com (2603:10b6:806:f5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 06:01:23 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 06:01:23 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, fengchengwen
 <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>
CC: Jerin Jacob <jerinj@marvell.com>, Vamsi Krishna Attunuru
 <vattunuru@marvell.com>, "g.singh@nxp.com" <g.singh@nxp.com>,
 "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Topic: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Thread-Index: AQHcMrTzexClfQ/wYEy+Q4donQ3Hb7S3ys6F
Date: Wed, 8 Oct 2025 06:01:23 +0000
Message-ID: <PH0PR18MB4086F49CE6A43A252C7463D0DEE1A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
 <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
 <PH0PR18MB408699863CC25944A04C2F18DE6BA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <aNK3KPYmVmMKfFoH@bricha3-mobl1.ger.corp.intel.com>
 <PH0PR18MB40863F1D0859F31AF051E164DE1AA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40863F1D0859F31AF051E164DE1AA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|SN7PR18MB3839:EE_
x-ms-office365-filtering-correlation-id: 5d1bc86a-0111-4534-1922-08de06301c40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uI4ShgWd1zLbxfZYCeEZ4yHLyVbOvZPbXDR7wJuw8PURp0EOsmf1cX/LMS?=
 =?iso-8859-1?Q?S4x3XivAQLcXcElr3fW5oIng3jvMRr5IXE59ylfTnubVAKNKVv80H74lrK?=
 =?iso-8859-1?Q?7Vt1n5zTXXSIgaYGEUZDcqh5LsOWW4RYYzVJcvQcAFERcYpvZiWSAMPWpB?=
 =?iso-8859-1?Q?qZ/8ATsy1RmsdPVNCSP83kTrDioumGWQY2FQYhQM2P4szRDQTd2UyI7HUe?=
 =?iso-8859-1?Q?aZ6V9ZXO2fZT+h1cmZBJ/u3smKEVZjYH9YxBrecXWpLcU3NpJMIEbNdalj?=
 =?iso-8859-1?Q?nxyas6K/NxLRXEnPgTSs2tK9/NKEfMm+s6Z1faEV2n7oigP/Zjal3LHJCf?=
 =?iso-8859-1?Q?Kf4j3oOQ1DMELFXzJ3a9w/6TAqa7yXAqsEUffOtWqrTwRb9BM+5EwFncYS?=
 =?iso-8859-1?Q?gIJIgRhPcZw3BwbKIC8s2uUXPIjYFlEbCWF3ldVC4gxg2TdymFSZfa3eF/?=
 =?iso-8859-1?Q?cykYgO3ndopGMb2rElslXJGAzRd2OTk3CFnMBKuh49XMY1DLcl7zTOW4tI?=
 =?iso-8859-1?Q?ESM5iV+/IQdryI/M4H3p/HP2Gg8nKYEGqdK5j7SZIJ99sWM7F9N4KHXAqX?=
 =?iso-8859-1?Q?MoRG5beZNHer1Wn1Menj76YDxzdyA3aueHo2Lk3HO280xs2jns4HNefv43?=
 =?iso-8859-1?Q?HchCQNgIXJ7mk0O1BEBslal7A1DAejS3u4R4aylqx7Qyx2P53yhye+tuTm?=
 =?iso-8859-1?Q?q85EeOJzC6uPEEe9q0Wqlxx/R7Li+svN/NETTAN39zSbm7j18FwjjV6Edr?=
 =?iso-8859-1?Q?0KGXC5KZHEuQFaZbFzLuy8HIfqTpOi7aieZfpDPoKaWWPFNLWZ3UglpdM1?=
 =?iso-8859-1?Q?euYLUthPjiiNhWAx2m3mzC9UcsI6Yby7D8KzGguNmgWKudqgJu7lWPUYQ4?=
 =?iso-8859-1?Q?gSeIWIp6/uLVDvASSDAaNSSQQO8Sn0/LGgfHUc3sFb2GSan1MokZGWU/PN?=
 =?iso-8859-1?Q?2wcNs1zNjv94Yos5pgV66ebtTYgNZqf7ZG8mW3ij5BVCfgPechiiaIK1UD?=
 =?iso-8859-1?Q?vqcd0M4Bt1qPdG/TSokPzxyXP7s/Kn+J82BiHzL/D1ncllHQDEXSAnkLb8?=
 =?iso-8859-1?Q?ifaNAtUx3va3wfq44Y34H6zxei2Igdazp1bPRz5UB1+VUYjstKexr/AS4Y?=
 =?iso-8859-1?Q?rkDXXvJx+HNaN+wcKRGWIYQsa3g7xt/DntCagaBLDRlOZ3hQWRh/hAkabi?=
 =?iso-8859-1?Q?OLdX07f+Uipp+mHCuyp2PZ8y4LGw8uIfu3nCfw5XmkQnWY3xFnc+rUVEBX?=
 =?iso-8859-1?Q?9VzrCP7QSgt/+4I3/0HO0RIg6PXPs2N5OQ0LUGxBrWZ2AxmLj0lLl0eiqS?=
 =?iso-8859-1?Q?SgUtStmdg+RMNKAtTk9obZT+dbdaXyAEtoIH+XMsseqx9Y1cs1JGHdsof9?=
 =?iso-8859-1?Q?L8+YBzKF8336/G1pYP44zdjqeCHBEYea75A98QXkMNBKc0gYG6nkcOhohj?=
 =?iso-8859-1?Q?o/8OWzUxgoyn4eFOzuaF+knz47/f+0SSU3vHr+KHaFFKovcx64RtWr38vY?=
 =?iso-8859-1?Q?ssflkPGTYOg8U9BT3QO5QEvSRROQzA+W8m1Taj5zjf6UwnqptT/jeKFY11?=
 =?iso-8859-1?Q?W5umMkmqV6aqnjIU46r7AV9nnub3JcpN3wvkzUM/jMzmTeVNXg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iawTFx/vR3k5k5gCYd7HuhpFf6VRuFWW0BjZJlvZFuqv4DmR0l491R5y1W?=
 =?iso-8859-1?Q?qmstEecbZR4mFQXkg6gTiKv4JJNOKKp1BYcinLwnl+uqgKAUn/lZsXl7KG?=
 =?iso-8859-1?Q?UwfSxf76LdxrcojdKIRA0cwzztkpYspoVjxI1cNb9H+gqUpvh3LsGU6yUz?=
 =?iso-8859-1?Q?HeA98yI9qTo5XKO3oyOPP5EQiKfFnPN4CH3tgJlPt4YivQPyXw+pmqd30K?=
 =?iso-8859-1?Q?2UCUXVMkFYFVOrJkPsh64jDCq/B+r0wh7Fs6tprhI6HYQ60ZCuCxdvp6JE?=
 =?iso-8859-1?Q?9hd1VgBzPk4Q5l8S7Idb8OGY+yJsvsAl/i4ZcFwTD7S2faRvtFq2iTOmGO?=
 =?iso-8859-1?Q?7TOQeaXpPZ9pvscXjeBWtnrG0APIsCPcFZ4QTHtENRTkmHd8Wrq55aw/54?=
 =?iso-8859-1?Q?2wW2dUBKBc8eh7goGl13ClRG5qWfiToT0MqtJnLNB3Z6zejpvbGvA3HvYp?=
 =?iso-8859-1?Q?6xd5WvVBUxgO1jd0qOaQR19yALdhD8iAhs+4/IpMrK5APe1xObckGVbRmu?=
 =?iso-8859-1?Q?kp8gmIsPRJYmHtkwc4UTUDoEvPrwVijH3Y5X43ILtZoRk2F+84q/Xztn1D?=
 =?iso-8859-1?Q?EbQ0a4uSq1WR1TganPhQ5mF4xDG5Kdudxpl74VRr2QFZDF657/xOw5TN5r?=
 =?iso-8859-1?Q?Xdmq3nrkpyRzCAMU8/uMMvkYCNNCk3ztfXLMFVtcrguD0+rrj9Pq5ijckA?=
 =?iso-8859-1?Q?VNQeCkxF4UaHJUDJtj4eqZ4JYUrBJWF1bLfpmlF6Fsc4ZC2qB7tVgWE4gO?=
 =?iso-8859-1?Q?nbjBUBqTCIi55g/kIAY10hhT5aSi9gL13SB9GKuYGXCYu+WK2gipZcAr8D?=
 =?iso-8859-1?Q?+Xoj5ZosTne+NgaizV2LAScDSy4gKQM3pIN0r93iS9nvMVca9LOR3/aDKn?=
 =?iso-8859-1?Q?IHWUljhtnGA3j3qiKbmtNSzpuUCXFYE9AMmx6OKiqyhbd4a6jkW5fAzh2k?=
 =?iso-8859-1?Q?jOuAx+yXaS7mwffAdxf4zRph1hoBL8yZ+xOQA3f1connuRpj8GyYohZeEc?=
 =?iso-8859-1?Q?IAjXaabd9Xi7xbMP3DTJVOZANTfan+gaAvufpdsEwd+ph4uy63vXrkvIl/?=
 =?iso-8859-1?Q?dFNGdNE6R1eOUF9VVTX8Qgu7PTNdX1Up9CVxcKEiBrzFxnoUSUG6wEZDCc?=
 =?iso-8859-1?Q?2KyDJLVL11zkrkkN77HPu2JYsyXKi1N7lnzmPxry7A0EK+W0KPH1VprWzM?=
 =?iso-8859-1?Q?gB40SYAZwkaVLmFYmyWarSeO/KTTUAvFPsUJ4roDcKA+ApeFVRW4FVEhVn?=
 =?iso-8859-1?Q?oQLlDcVLYXH6TDb0gx/72spALtqIkFW1soCn+LhwHvHHed5a2OvYqYkURu?=
 =?iso-8859-1?Q?1TRZyDEvJ6okgjSa3A3I6l4TAKlJ8SNnzlzrY97CrZGUf9uQMPLmy+6bzv?=
 =?iso-8859-1?Q?nKDmoqKtyFN2fPxAXOw7B3LbhFLtsGjmCTBk507xxcv+spUKD+eJCGTUFX?=
 =?iso-8859-1?Q?1+0CVUTnQpdqxDcICus+R+HeXJWuEwRL2Nsi/egQ4NY2bRsv+qXe/FZTUP?=
 =?iso-8859-1?Q?QWRqOlGJl6fABl/Pza4I0ia6eKrwEtuYKzJ1FetqPpncnm20i8a7aIfo4E?=
 =?iso-8859-1?Q?3We30kgHCfQvj/WKSmxJdFE9xZz4DHT1iOQNOVOgDoH3blVAXXUCslQNpJ?=
 =?iso-8859-1?Q?UAuU6nXDB0VRdPRL7p6U6hY+GZIREXzy7a?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1bc86a-0111-4534-1922-08de06301c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 06:01:23.4860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJustZCF3bKQ7Htb03PiOwwj53pgPuBHTaAxqvo5FgakwQ/7E3Ta7sEkaWqAKd6bQB0RdYhIO+MLI/grIOVvMWL3Um4dplOfWMOLAzaFHKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3839
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE4MiBTYWx0ZWRfX+Bm3V1srkoDM
 boC6PBeuf2YgJFXJ0+Wt2Pd7vATOXbf6pXuEgdO/1bcKdhSYNjY5C1DY+foFcrnUXMcUqfJcZY4
 WFfPo1s3hXUNIi9ouU40oSULdWWigwbct8UU2/WV2y4PES1/czF6hxDqeAfw01ncz0vH+fwNTwF
 uoB5USFX/8q/TxdvHehuh2Yd3I8ztnUCXYkt4Lk/dTkC6MvKDHNrb7NHcHfDXQSRKDfo5M/vaaW
 iuyveXrtJWqalFJnUTo9gtYxC1pdWCBn/FxsA4mzHKAcM2SkSMzyTKkcWt/37GhZNdqpDgyVWwg
 WgLA5H9F/K0yX0jLB4PmbKsFcmZKzpmg0tZd7VEB4psSz4bPr0ULOsaSwe5mquvXW/ex3yNluQw
 IsXHX5D8F/VEqoey6tMPXt4cWmDfRg==
X-Proofpoint-ORIG-GUID: CHWumhT8WmjCkp-UQfQrqk9e9_s3a6wG
X-Authority-Analysis: v=2.4 cv=JeuxbEKV c=1 sm=1 tr=0 ts=68e5fe3b cx=c_pps
 a=uG80++rjBOzHqXi85Z+aBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8
 a=n-czGfdUKBKNmWcxkYIA:9 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: CHWumhT8WmjCkp-UQfQrqk9e9_s3a6wG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
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

@Fengchengwen, @Bruce, @Kevin=0A=
=0A=
Kindly review, since this is a library change we have to merge this before =
rc1.=0A=
=0A=
Thanks,=0A=
Pavan.=0A=
=0A=
>>> Hi Bruce,=0A=
>>>=0A=
>>> >On Sat, May 24, 2025 at 02:43:10PM +0530, <pbhagavatula@marvell.com> w=
rote:=0A=
>>> >> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>> >>=0A=
>>> >> Introduce DMA enqueue/dequeue operations to the DMA device library.=
=0A=
>>> >>=0A=
>>> >> Add configuration flags to rte_dma_config instead of boolean for=0A=
>>> >> individual features.=0A=
>>> >>=0A=
>>> >> The enqueue/dequeue operations allow applications to communicate wit=
h the=0A=
>>> >> DMA device using the rte_dma_op structure, providing a more flexible=
 and=0A=
>>> >> efficient way to manage DMA operations.=0A=
>>> >>=0A=
>>> >=0A=
>>> >While I have no really strong objections to this addition to the dmade=
v=0A=
>>> >API, I'd appreciate if you could explain WHY or how this method of wor=
king=0A=
>>> >is more efficient in your usecase? When designing the dmadev APIs=0A=
>>> >originally, we looked at using both an enqueue-type API as well as the=
=0A=
>>> >implemented individual-op-based APIs. IIRC at that time testing showed=
 that=0A=
>>> >using the single ops directly was faster than using the enqueue APIs, =
so=0A=
>>> >I'm wondering what exactly has changed, or is different about your use=
case?=0A=
>>> >=0A=
>>>=0A=
>>> Here is an example where we see enqueue/dequeue ops to be useful especi=
ally when=0A=
>>> integrating with Graph library.=0A=
>>>=0A=
>>> We had to write an entire wrapper[1] for tracking sges with the current=
 implementation=0A=
>>> making our nodes[2] very complex.=0A=
>>>=0A=
>>=0A=
>>Can you explain a bit more here. Why do you need the wrapper rather than=
=0A=
>>just tracking in a circular ring all the copies offloaded? How does havin=
g=0A=
>>an enqueue API make this better?=0A=
>=0A=
>This is what we already do in our wrapper.=0A=
>We found it unnecessary overhead since, the driver already does this inter=
nally=0A=
>and we can leverage the existing functionality.=0A=
>This also reduces the memory footprint as in the case below we use a lot o=
f VCHANS.=0A=
>=0A=
>Instead of checking for completions and maintaining the circular ring, we =
can spend=0A=
>those cycles doing other things in the application.=0A=
>=0A=
>>Can you perhaps give a trivial example=0A=
>>showing the difference it makes here? The examples you give below are=0A=
>>rather long to understand quickly.=0A=
>>=0A=
>=0A=
>The example below is a graph based application which currently uses the wr=
apper implementation.=0A=
>Which we want to swap with enq/deq ops to reduce overhead.=0A=
>=0A=
>Also, the ops descriptor already existes for eventdev subsystem, we are ju=
st importing it to DMA=0A=
>device and reusing it.=0A=
>=0A=
>>Thanks,=0A=
>>/Bruce=0A=
>>=0A=
>>> [1]<https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_M=
arvellEmbeddedProcessors_dao_blob_dao-2Ddevel_lib_common_dao-5Fdma.h&d=3DDw=
IBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DE3SgYMjtKCMVsB-fmvgGV3o-g_fjLhk5Pupi9ij=
ohpc&m=3DdXtUywAGV8Rir_dtqGP5J-tvRAxN9zQjmM96PeDo6Ke6QybID8eLdPbVwWzlgZFy&s=
=3DQryV2vh2_mWEz5yS37615Xb1F6B-gQZHM1uZ3badxoU&e=3D>=0A=
>>> [2]<https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_M=
arvellEmbeddedProcessors_dao_blob_3f364261de91e355699bd9af20d60ea6459f7d67_=
lib_virtio-5Fnet_virtio-5Fnet-5Fdeq-5Fext.c-23L51&d=3DDwIBAg&c=3DnKjWec2b6R=
0mOyPaz7xtfQ&r=3DE3SgYMjtKCMVsB-fmvgGV3o-g_fjLhk5Pupi9ijohpc&m=3DdXtUywAGV8=
Rir_dtqGP5J-tvRAxN9zQjmM96PeDo6Ke6QybID8eLdPbVwWzlgZFy&s=3DBl2X7g7xXg_XrWvV=
IjPhMuIZuy3PG7tOM-Eje9i2ITA&e=3D>=0A=
>>>=0A=
>>> >/Bruce=0A=
>>>=0A=
>>> Thanks,=0A=
>>> Pavan.=0A=
>>>=0A=
>=
