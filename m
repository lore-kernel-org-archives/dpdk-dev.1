Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD3DC021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 269BC4042E;
	Mon, 24 Feb 2025 11:38:57 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by mails.dpdk.org (Postfix) with ESMTP id 50C48402A4;
 Mon, 24 Feb 2025 11:38:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUJwD8JA0xaPbzbHTXz0W3e7Kqqrlot2auRx9VLCIAhDOYujbyw3mk5r1q6kySnVlEed9AIkkLTER2FfuAr84MG12d12medlnbWDw4IgFEoaKFHhf+Pd+sgna9NFeGFYYWHgEnbrzBKRSYYr974+DT3JbycYpNs5dmRIJDK3iyCCLLHfVHNu9jPU56Nb/DtWFlMS4W7sy7ymKSBrR7hHyaLNHnSNhCnCO+DMMAvfqEMTDWhx1lc33pjERoWCxRbZQeyksKvr27IG1/Xo0UwUucxTmi2dhwdKKi/4dvje08zlhT7L4N4XNQkSk8/5Y6VW3dYKWKj0jSSemM32rsABQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGZXZYJY+aW0hmCKD7uVxdMiAZNP5ERji+dByUorLSc=;
 b=AV+JzfbbxIVzvn0il0IKBu8M1Yci/OSO3h2p7jxJmLVJHniIN1a7kpBtTLkVAkOWafWuU8J6lYe9XQbrUDyGbjsTiuGT7jjVZDqNS+3Ux7THFhrIDC96n/gv4EmEgFjZ35FDT7X2z23ETTzJvxeJQTUQrBpKXfSp3uK+582u1a5FXB9RzKm2bgsncwrNgeqsfgw8ixmMuq4o+QL4IIclaWerY3jfIWmGBvZPDDL+MogCkw28y4rEQPBpYCPQGbikU0yUm20f2m8dIKDf5QAdbhB3nfkfUnpGmYIwu0CfxmeiPq+ADHFHiuXMMJArRaVyhzTrYuc3tB80sYRpSDRIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGZXZYJY+aW0hmCKD7uVxdMiAZNP5ERji+dByUorLSc=;
 b=iwn/A6wT8zoiNbJzgMvASGmY872gO6fwKVfZeaRHBzuFjAyPCmhX8LwT2YeTkuJzn742onSqfPUtRyqDjDFAT32UzQpa8zDt5DLxQTiXuOEU/VfchADYDBvKD4Upm8KLFGY8ZgwiLMEFZGGnJ1D7z3GqO/iKKROZIyJIASLO0hSCsyxPBODsQrkQVQ4yKQcDAs0N6SvQrmygQMEO7/7YD0Aesi1eaOauRb87AQ49xWFT4YIvTwVn1RCkjW+hpHGlp7i6hIc3BmY4TdKdSkM8AjJgHPZWHjbiI+5k1xdcJSDaErJc6TVQfycpnwRAZTg66y/7hb19sZWbQ3XSY8DWAg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:38:48 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:38:48 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Junfeng Guo <junfengg@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "Minggang(Gavin) Li" <gavinl@nvidia.com>, "Jiawei(Jonny)
 Wang" <jiaweiw@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix err message overwrite for actions
 translation
Thread-Topic: [PATCH] net/mlx5: fix err message overwrite for actions
 translation
Thread-Index: AQHbg2Zs5ebHJsWiOU22122g7Ew2z7NWSYjp
Date: Mon, 24 Feb 2025 10:38:47 +0000
Message-ID: <CH3PR12MB8460B7F6DE2D6FBBD7B1BDE3CFC02@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250220070850.6661-1-junfengg@nvidia.com>
In-Reply-To: <20250220070850.6661-1-junfengg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|LV8PR12MB9155:EE_
x-ms-office365-filtering-correlation-id: 7f1f5b86-6e13-490c-a820-08dd54bf6bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SA/AV1yA+/aimMZhrpWqk6evFvti8LvVzpQbi9hKU0fxCPeRJW+UR5I8iS?=
 =?iso-8859-1?Q?LyqhmjICLWIA/MR6oAa68+ts6NpkQSEO/YefXZkc/YmbFh0uduc/bOqT8f?=
 =?iso-8859-1?Q?9b4ScbW/iWBIqasmIF3+E1MnDZkXxwxflDnRDvjt8BJXjmLnzLCjUvWgu2?=
 =?iso-8859-1?Q?PopoE6GdaP6G+J/RZ5fqQUrz/sJaa5OK/ns8JwEmHV7EgHGPp6+ONjBRfX?=
 =?iso-8859-1?Q?iP1CouyR9q5apf0Gt/F1gAycVk8T1FXyeQd8LachzwAWfkQCo8GZhhTVgh?=
 =?iso-8859-1?Q?fIGHRDFAI/Nrwz+P1yoUpdt+faDHwm99l9cX+9D5/+7iuOd0Gk6koLU4W3?=
 =?iso-8859-1?Q?aKnduRqYQtDTmNNePPt2fP/ERGJRBLt05I8e7PAJijTIDRjHUvM4ENwv3H?=
 =?iso-8859-1?Q?wO4nI3YFyOI5cxg/AuKwXO3BjOWogciT5n0PZvS8F5zPnAe+C/EK2SGxpc?=
 =?iso-8859-1?Q?fhvtRmwgo+GjxUWwR/6QWct2NqS1VpMQyEpzoXYgM+89J6EnkKmu2NARXq?=
 =?iso-8859-1?Q?zJzzizot6T4vOcS0fx9rahs8qIwP2DTsKpudCJIqvLVVv4onL76rdbGB6m?=
 =?iso-8859-1?Q?+oXLHigMtLc3JU9XWqPej4wOHfG1SP0AIyc9ADyq8TpL56f04fho6xe+FL?=
 =?iso-8859-1?Q?bCOqnbvqmBmJLRXFeb0lIe84PJYdgqSc9HHwbtKepcTFUWpWyYn9im9HMd?=
 =?iso-8859-1?Q?w318whrBwvDZQT96nRCH8UusBb3EfUi+s9AGlA905GGWSPU4ly1H6HAqsp?=
 =?iso-8859-1?Q?9qU3ITyeDu3Ujpf8/aGNrjGv3jzOPlN7LRQRcqS0jVo39HnO8hvMgOrk+V?=
 =?iso-8859-1?Q?8kMlxJC7lVExvaTLt/rTh34TNBz3G8jhjJ9nMMxWmHQrwsCcKWQKri7rcA?=
 =?iso-8859-1?Q?dX333gxfRqIP+ftrAOpDV5T1iZjojePnFfSjEe2gRv+9rj8NlYpreYgSWx?=
 =?iso-8859-1?Q?nQSh4Tnttsa8Tvwpb7ScM6XIn3PniRBAxmbXAcWsNim2BJHKAYo3a57vfg?=
 =?iso-8859-1?Q?Ov1IQs7LXvMp13woG1YZ1Mormb7+xX12vIFJRPyDT987+0MlCsJATSiIfZ?=
 =?iso-8859-1?Q?dxV+rJgL58UlKz6iVSTMIL2lKjqHEHhk7DO4+p6TpDF6wFwynzd5pJyK+r?=
 =?iso-8859-1?Q?5Diy+X9ovXsd1urgPSqZwd6ZNzo23zs6VnW6ssebB+P1He99LHh95siyyP?=
 =?iso-8859-1?Q?31FIxZNaFS+3GuC0tPh4LuU/+wwyFYVo8Cp6qgzkokcaSFnV4xtcUcSaQV?=
 =?iso-8859-1?Q?gXr/O6udOsc3RalJzB5IXrGHBflqFc4w2uf26NzStupvIKOWT4CtDzQGRX?=
 =?iso-8859-1?Q?LDPKQOiBul1eVJ6yKSc6cbGZ0XJJ4ck+NwyQw3xLK28X2Na5I4yM5z/SgA?=
 =?iso-8859-1?Q?BHdwjUKifjNTyr/56yYgZiV15zPpIQRHUj8BViX99B1d8+ZdvOJiq0bP43?=
 =?iso-8859-1?Q?pH5qBEFA3i9FwPqU4kGwsobk/SEQxD/wAlC/ZTkGg6wxQIs/lHCtJZcWEV?=
 =?iso-8859-1?Q?raJILldv5BPtY3zq8RGYJb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e+uwAw7uHRM2mGd9ohCTZgz037fCE10veabooKLR533W723Mu2R1a+vPpD?=
 =?iso-8859-1?Q?TvriOWMs6Sch1tRbqhPnrZZKdvQnQy520NovzEiCV9v8Dx+inrlfrDPmAZ?=
 =?iso-8859-1?Q?pC9ak8YkxzYtDevDaFONfcWFABB6+pv74FggEwuPz+c+9nR8hj0q3MjwKT?=
 =?iso-8859-1?Q?Vh7PzLJpWfHgOESRnLOyiWUdLMKbm8LSCgPEITl8HdqgHybSthF8B2ChR0?=
 =?iso-8859-1?Q?abeJQREJ9CsRGp/y8YPg5qtwYSs4B/8YyrZW3gIUXPRa+xn/gGOpnAe8b1?=
 =?iso-8859-1?Q?WQ2H+8h8CxaYEtSC8H3lrQt55gKHlCbkhLTD/RyaYXerUnghKNxeGCMpHc?=
 =?iso-8859-1?Q?wMs5bPX6s3yXAT7D5CrECQ64RS26zJEOFG8L68j8aczRD6omwz+yha0sQ4?=
 =?iso-8859-1?Q?xjcvImFWnjH7GAZ10UgFTRutdI6qH9GN2GIy5iJw0NxdMv840l28Zlndno?=
 =?iso-8859-1?Q?2plBg8t5O+YCoR2B2mWsrkWY4yRu7NotMxyh5XGpHwkG3fcXzJS/xwlzdD?=
 =?iso-8859-1?Q?50VHUNe0cfrFjd3f0BkLR4gr3Wr7xH0h6k/1HSvsQh3Tw95dhd2aN8Q+1t?=
 =?iso-8859-1?Q?39fp1cnxRdiFnYAywYh6yiUrEzrVjOfE68aTBPNrqmYDxDAr6rqpiBewQz?=
 =?iso-8859-1?Q?H5qjc1N5wCu0rw3sMKnF+hbxde7MqPzGC8o5NGss/zwyrZfURrzYMSr7BP?=
 =?iso-8859-1?Q?8aIpN67HH71uBYgJWXhmrDhCDpzKge4gEVY4ExDZR8WHld+JkJFjgjP9wn?=
 =?iso-8859-1?Q?1n3aLC77QEpp7sZEEuaKP4RBbW6PV/58MD1pV2beB51v6Ti8YMgPNj6yfQ?=
 =?iso-8859-1?Q?D+ElTGwNYZ7qWDRyxG2fvIeYDuDijJwwtkQKr5HZxG3KeTkKKnas5fEn1Z?=
 =?iso-8859-1?Q?4B0m2WLSUeS4t23VB8l9LdvM0lM/GUibgEqAhumY9HQGVgmPqbQTEAzJwp?=
 =?iso-8859-1?Q?sZhusqK7VS+JIQmt+FEmT/UbsAAuZ1wt974xob2x+QmYn+EYbSlyM80RFZ?=
 =?iso-8859-1?Q?0BJxn/pWUrfERKYWBRRIVoL+pa7HYMhlfyUfRa+6tgCtMfudg7RxxMZcPh?=
 =?iso-8859-1?Q?H5AeWrb78/Uhj106c3ef29s5W5XfV88LDltYT8nhr2IeYJ+Ozogun06VKB?=
 =?iso-8859-1?Q?ZCUdfKnUlTJDZ50s6koWPEetHXftNN4++MNtTBwJyDH3Ss5qsjAo9sStDj?=
 =?iso-8859-1?Q?d0yQCUSdE1ReQSGlKvBs0Ack8GGIiWM4m3ZusFp1LcCNsRXWnctDK++Ylo?=
 =?iso-8859-1?Q?qjdAHyUv8rApuI0Bhnxk6EGUiEQfr0CekfQKnj09kj15Aa2BoAnMfKPWby?=
 =?iso-8859-1?Q?uXuZcazBHLZ3gNzrh2nUvJgwer9l071gz7xKngsa9tb9Gy6WLpWiB9quGI?=
 =?iso-8859-1?Q?rwLwA22pSjlQ/j7zya4xmPpTgO/Wr3kkj6ReeIbAbyKD+o0wK7Lp9WJM1o?=
 =?iso-8859-1?Q?AH/qhk705fyyBDovNW1PXjwBv05RaFPD/hE83iAb0YHU1YVpnFiGTjW+2z?=
 =?iso-8859-1?Q?ctvofgBKtZjH8HF6ghyGsTqVgLOIW+HKTMmKhm2aR6QdDbZl1lX8eyt6K3?=
 =?iso-8859-1?Q?NDxpUMkhmgd2G/Xs3+gIEvNETXQm1ZukQAIN5kn9JwOunys0lGfK7G/SV3?=
 =?iso-8859-1?Q?IQDfex5Wyifhk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1f5b86-6e13-490c-a820-08dd54bf6bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 10:38:47.9733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DkbAJ+YXBxetiItB7/5TGORWRWPOFFC1eAt3ev3P7PwS37hVNy02DFJht8PEYADXr3F6oC0uNwqxp9VzAaZrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

Hi,=0A=
=0A=
From: Junfeng Guo <junfengg@nvidia.com>=0A=
Sent: Thursday, February 20, 2025 9:08 AM=0A=
To: dev@dpdk.org=0A=
Cc: Dariusz Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; M=
atan Azrad; Minggang(Gavin) Li; Jiawei(Jonny) Wang; stable@dpdk.org=0A=
Subject: [PATCH] net/mlx5: fix err message overwrite for actions translatio=
n=0A=
=0A=
Function __flow_hw_translate_actions_template contains several=0A=
encapsulated functions that already have internal error handling=0A=
process via rte_flow_error_set for each case.=0A=
=0A=
Thus the one (rte_flow_error_set) within the goto statement `err`=0A=
at the end of __flow_hw_translate_actions_template function may be=0A=
redundant for those failed cases. As a result, the error messages=0A=
would all be overwritten as "fail to create rte table", making it=0A=
displayed at quite large granularity.=0A=
=0A=
To prevent above error messages overwrite, this patch add a local=0A=
variable `struct rte_flow_error sub_error` to the function and pass=0A=
this `sub_error` instead of `error` to each sub-function. Under error=0A=
handling process (`err` label), if `sub_error` was updated, copy its=0A=
contents to `error` and return. If it was not updated, return default=0A=
error message (`fail to create rte table`).=0A=
=0A=
Also refactor the logic for SEND_TO_KERNEL, COUNT and AGE actions in=0A=
above function to align the error handling process.=0A=
=0A=
Fixes: f13fab23922b ("net/mlx5: add flow jump action")=0A=
Cc: suanmingm@nvidia.com=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Junfeng Guo <junfengg@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
