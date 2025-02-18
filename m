Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D26C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3FA04060B;
	Tue, 18 Feb 2025 16:42:25 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by mails.dpdk.org (Postfix) with ESMTP id D8C9C40261;
 Tue, 18 Feb 2025 16:42:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAWfPNMbcvnR/q4lh/z0fpQb8XG3KvUDZIQFl5YDjio1NC1kG7+hDwqDye6pLG7cNgCeMzgt8yL1ZgxDsbJ8wvv7nU+Tjka5hT7fwdZffiXAzPEP+A3lPKgxEhZduf2QTyW8u5v0HRUltT3fn50s0Q26LYr4sydE6xRFZ3LvRBRfCXUlbn6fFy2scPBVzTFvNN5nL4FazAztG2iagav3UaeBvc2MsqveqwOXMRZdpGJA2rLtTrm+Gz5rFNi2gLBac5EQvYpngzXU9q+ouPazPXPeBzAymxDeYzGC3743qhilLC/l96z6AH3sY9vslhkBPuw3Hh/pyIHRkC89NGTZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqNKM++/C4kfXm2gD+Rh1tvou3qkGUhio6muzNocNlc=;
 b=v5deuM7UNm0v300tufGWQueYToLxFDWgSWht2LJWqwq+5q+UWYONqezrkJtjS6fXZo02Q3LGzBytKPpUdhwKVqWZwIJFTLgv5a2FToQExnOFU4skco1VAX6ZJt58q34NhiGWsT/hfIRgNdJAkhxUI7dedus6rcUW3H2BaXVgbV37lniA0kpAYFcFwiHM7JRrwvMzZll7Cq5vrdkEP00DrsIzbEMsM8+k4BXLHd/TTr5NVkmRbnGTgksEnKnCZs8bP+zYnABgHwHnbCk6rSHlmoS6+GCs3JgW7+x7Ssdqp7qKeZ5emSziiDRefmZCHRjBTXOM9/7ajFDzoDVL7PHaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqNKM++/C4kfXm2gD+Rh1tvou3qkGUhio6muzNocNlc=;
 b=JNki2drIiJJB5ez0Iky9VDTIR9CtUQYs8MN8jZ/9YHjkHhGcgKru7GuZZKyGO7nc6tnNrnC9vkEUVk5ATw5AvOTynboRXWA5SR/2TM86OzP3FISd5QSHjscbVnjIJgT38Nqt5J2Tcl7YR2D97wmdxcjEChw3KvMJxQ+ieBTkgLHt4fujBlV3tbXpY9HtWCxaUSbDSNX7h9fKs/VbZ+KevS5ekd8ewYJD+ZjEsH07EsOXAFHkkDitT+1cg28VNtVhCr8Nb1lYSHzGhXM3DRKw7xbugGt0p09YKBc5LZzsY+OJ+v0NvwPpAF4XuAu+C2n7PGYQvs/p+BAoOxGnH5s2gA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 15:42:20 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 15:42:20 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Jack Min <jackmin@nvidia.com>
Subject: RE: [PATCH] net/mlx5: fix leak in HWS flow counter action
Thread-Topic: [PATCH] net/mlx5: fix leak in HWS flow counter action
Thread-Index: AQHbcKnIt+N3Xrg4L06LppE+C+eI7bNNVd9g
Date: Tue, 18 Feb 2025 15:42:20 +0000
Message-ID: <CH3PR12MB846071BA1F2596530B3E2CD7A4FA2@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250127105347.1077802-1-david.marchand@redhat.com>
In-Reply-To: <20250127105347.1077802-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB6468:EE_
x-ms-office365-filtering-correlation-id: 256b67dd-884c-4d1f-db78-08dd5032d498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HDtJ8xeRJX3RAjJLRQ07IQEf2YQ28hVVacDKtIDgs+jd9/Ndki8PgfVnhjsQ?=
 =?us-ascii?Q?MJYWc6Ph6dqdoTBxqO7yQKsPZUEs2tocYj61TxEfjcuE/iNWYqCpGx43CU8C?=
 =?us-ascii?Q?xEr+DLM9fkpgeSoAlkob6s+73HCURqSeYIzmFHJQjDkp61o7WEy1DSaUWkvz?=
 =?us-ascii?Q?dBvABtGq3lXpD+SqlgVm2IMTtzyE3J1Df5QNlfUY4dDAbW2R21/TmLgxPl60?=
 =?us-ascii?Q?J7sWBIZnPdMiS4Z9CzG4Ciub65j7KUNWP4DU3Qm+t+im/uzsp0CitsSYx0zx?=
 =?us-ascii?Q?TAMBbfzxulPeoL2lg2PT0pzxjSIjpVnbk95CX+h9QV3eUlHVI7wtbtAxz2Yp?=
 =?us-ascii?Q?5ricCHUjWc1UduvAK7SVTN+pi6DtKlum0hn+x2WkXd+Ip594dPTHuyU/HfHA?=
 =?us-ascii?Q?8nx502M0Ryd1g26nugLtTs1V0ixEJLk8OTGzeeUtCEWa++b3lh7XT7TbTcql?=
 =?us-ascii?Q?b/U58wM3P1qIcsZr66SUvg0cusC8L/q5gvj7bwdSaqBQxYE1PdMrihd8vhZJ?=
 =?us-ascii?Q?4BWE2uWw6H3ldy2VdmiqJrEqzpaq+S286eV0DH0Pv7LZ7JGTDIncTPK8OZZS?=
 =?us-ascii?Q?ZytIxheGzdQR4jlACUBSajTxOM5fpVuglx2tL7THVXl2CrLeAcPUyQpAligu?=
 =?us-ascii?Q?uBWZmbKGUlI3lnr5lFCApFGqopPLa7oTUCvYxKCIBT6K3Uim8E5P03Ef0792?=
 =?us-ascii?Q?VEskb+UQ4BjK8kbxrT4HZ0e0fWlSdWevo7IRf9nOSCufZIl3fXg/KmXf2XkR?=
 =?us-ascii?Q?kFRPUPaoMcwez54pw5RnFJrgJXG3Cvj+O6hLT/AfKfwMCbC1CSuE0f9YkMUp?=
 =?us-ascii?Q?TDH0pv0v0zDc0xHS4kj/3pLCcQkqhr5dFgMHZBazkYVNESGUSY6iNPMLKJ8P?=
 =?us-ascii?Q?PoA5+2QDBfyLhrecAnWvysg69B8kkNyh8JO1w4tMtbI0csxGzs89xk4YOE5D?=
 =?us-ascii?Q?T3xF5pYAh3X2BYLvnPqHusr4Ve3nbVC1IIjKT5RFhr0yc10kJWMe7vYsa1pI?=
 =?us-ascii?Q?b4YFdxtNVISW2lPnuVM+MBLblmZfwoSCzTSdGdWJwLQ9rihX3Jrg2Qi/wQuM?=
 =?us-ascii?Q?j0SQnp2huZwBQ3M1HJTbF0zltn8DS2hV6F9TAfniJ8wXGeCR3GgFNckSSH5A?=
 =?us-ascii?Q?lpaInlUGQOUl5mG6q7ogSlRl2cdSSl5/iyukxRHWuunqVzjDZPscyyqU0ZTD?=
 =?us-ascii?Q?h6i0iADZrni7JCRK5ck9yqqoNFMhaVzW5dHYy46CGt1NqPD3m8TFCOZTmgqD?=
 =?us-ascii?Q?fVUnr0ibKXvoPoJzsT/rc5DQvX8lGkXC71qRhSwDNjuCBQJDXb2iBKekFyWu?=
 =?us-ascii?Q?lcSF0Vr4af+laTC1aoZqLGnrHXAEo3/ruBioLRwBZy245cbdNQ0/L5SN9r1J?=
 =?us-ascii?Q?ttzDhilnc2407jpInJ62itceF46xvfhNWmDEK2exxowk0/WeTgYq/dlmfgwg?=
 =?us-ascii?Q?Kz7ZnPH7HPx93sIJcHEQRWyKhZO4CFOL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+6mK1MExFK9xgVgmVlNgpKCHgNYoNxjTIQS2+Lzfki1dIkf87OQszeDt8uE0?=
 =?us-ascii?Q?PiwUE8vj4TTkkBzGzE5/AAN3FtkJ3tyvtHtSXH1bBiAm2Mk8d0FBBO3LsV0E?=
 =?us-ascii?Q?4+LcecyrAWAwQSWsk81xkaV0PRaUfdn/kFvmhrmExjfuQNDkfLSIb0rbk1ui?=
 =?us-ascii?Q?mt/Afm5YMtgyL6eTYJS6o8pcXqeJUSUhDsyxfrnx+957OsRht9RFDcTV3MGj?=
 =?us-ascii?Q?rzPNswaAH60dTcTEJWaj6TBwlDZf2lXBSnrJXZtYTcl0Vxi3rDYnXJ9+oqSo?=
 =?us-ascii?Q?4BHdhz7K+MGq4ZL6iE84rudtShXZYaRSifnYfF3ocFnR6kgy4ZbG3QhNFYvc?=
 =?us-ascii?Q?qFDvxuUypFvodtw1IsGZZz68IzKbYEWDK18DhT8Mbj9Lw/c1oJ/Ej46+gfdb?=
 =?us-ascii?Q?CKG242fIjAnabuZoIyZTDSsDlPCt6LBZmakvW4nT1AkHwGlA53UKp+b5Iv+t?=
 =?us-ascii?Q?AaDmdD4u4nra2ua5ZL/W00EWjmqhzT5nW5kY7RpyVR1ESSGpC923bk31Mib8?=
 =?us-ascii?Q?uYfxT2aNgoqxugu/8DS+yySfhSTkT54UogXJQqCWHrHXBH8wv1SOYY6D96wT?=
 =?us-ascii?Q?8P20aT89tYhQDpipXdmWS20YqqAwgFtnlqnG7gKWMqUm4OQ7SUdsUuz4NyUS?=
 =?us-ascii?Q?2ro53TOtpwOhJmdSo1bmZ5Ck8H6nXOMweD8NqT/8ajKglWWxH+qLIXq9+8lt?=
 =?us-ascii?Q?/baBBJ4+hJsVIUYSmGpmEf2TicV5TaFuuBm5a5WLJeRQ07fUTDrQtUOGpu7v?=
 =?us-ascii?Q?mulZJbNirPtZELvJSLzg6gBGafHKmxBPJYMx+h3IxBuKU5XG9nnwxgkuTrHm?=
 =?us-ascii?Q?iPpb08f2qVvNYenumUc3RRsVxTYfsWxtkgD9FEIoVx8F0Rb71Koorxq4hgPK?=
 =?us-ascii?Q?o7lGBKMFsjkqVRdeeBohRMKwDsoFSJL+9o0Hi9Un2Iq79RctlOJt4e9ZpECS?=
 =?us-ascii?Q?jtLAlhmdsQsrtaZj3jHG8gQ3MLgT0R0Owgif1O3gVne2a54OnofxmWY4T6QJ?=
 =?us-ascii?Q?gGThMg0MSJIaVQVu58eA85cP3BlovZK4K7Pv8YeSEXWV1wnNlFitWOX7S27j?=
 =?us-ascii?Q?EMZI5sKxBNZqI5JZeRR+mvG2HMWxpK35nwAyDGP8e8XerKygWKNLfufE8DiV?=
 =?us-ascii?Q?PlIbbArzhrTdtb5CRPac5H9Klrfr65DqxBoAnWZVyD6TkGkCMcJ3C6ONmB9l?=
 =?us-ascii?Q?/zawYCMkexn7NZKmqa1C2CG36WV5sPn7gdVJhUl8ggtznK4c0ATpAEE+wZ+x?=
 =?us-ascii?Q?axMFrRAjXI2fWD5rMHoZ4MQ15JVamp47Glr1c6CqnbwezaIfROfJ3bKpFGes?=
 =?us-ascii?Q?oNRKxDSsl+tTlUaeYxkbg2rjbxn2gH58Q9Lrl0r8r40WtTp8cWPrQWhcvgtj?=
 =?us-ascii?Q?zLLRNX7Q5doT9UrlhKZsc1Mocz5NqB9NbDk7vTFQTuPNgSxnCM2sKXKDB5At?=
 =?us-ascii?Q?Ht5pJF0Wqnryjt1ubTqssIJwX8f+hJkyW6782Y3eTC1NhVVR6hmUBHp5+3aE?=
 =?us-ascii?Q?aDnVokUx5I0G73dZSxwZJ2SxVDoilmdj+YWtnZ6jVoOYgDTEDL9jPLuioim8?=
 =?us-ascii?Q?q07Yori0cZbhs7XJ5KTwAeqKmB16JZ/qtZkCbKaX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256b67dd-884c-4d1f-db78-08dd5032d498
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 15:42:20.1305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJxy+mhLF2yHghGg8X3439QlXaZ2KdxyiVmWxHsrkiYWS7wiQaJknSPcNdwseI42ifmltvz3mbGUKT6bU8c8DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Monday, January 27, 2025 11:54
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava
> Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; Jack Min <jackmin@nvidia.com>
> Subject: [PATCH] net/mlx5: fix leak in HWS flow counter action
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> This was caught by our internal covscan.
> mp_name can be leaked in case of errors.
>=20
> Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
