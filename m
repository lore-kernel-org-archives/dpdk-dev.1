Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14AC87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 03:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A77740270;
	Fri,  8 Aug 2025 05:49:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by mails.dpdk.org (Postfix) with ESMTP id 64F4B40150;
 Fri,  8 Aug 2025 05:49:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS7Vd+v1OGgLUVBxX5ybfvDybOTPpKjQO+4+DPUGUQm/RzZjCOzKyg0FA0hBk9qX84k39I/KTRsG5ie03cc5dss7jj2/dqd9amReg2di50jhycqUBCPVj6ewArswAX3gtZ98h9L2rUJwfPsFMF6IGWDKRF6QM3Em4bo/c9CMpZwxu1kP9bjzfCRXlxA4y51iwFC7ZttJfPRfGgOrPgZgOKD+f1JP7x4eLa4M0Mnurbwkq6oYu3z5xRwIq3jcNiOXCnj9J7wWh8AZiU3K3PY6k4e445ss1Rd9svtUl5n+ah/tam4YNwrdt/Ytn7yrfhFbEutHjPn5GqyI+B8vhvbezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcqVcFhGnf9n6l9CMTlNtIimJgYdHHo74A0Z/zpi0Sk=;
 b=RXhq6VZ5fR4WwmE8JCJH0C3qjAIv3lZosczCzW0tcJXxFWe59yhwsSwmdt0Cbd5CdGctfEyEw0i3riBJBml9GkgfaH0TG8VGeNYxYeBnn93WoNwHYzpebVKuQEbbSRPIZ+Dt65tQR0+q+ZxUaaYRUJJdGNV+p38vGRJuJK1NIvFuMlwJzNgYj/wijDSZPiR/JL6U/SWDkqxoHQzmAtzb6t55fztQDZYV9B/RektgrGDw6A83YP4xHEe6GLazMYcx0DdnDVp21XdPmHa52rX65YYk0wHkFW8ibqkL45fSJ+iiNz8bDz3lzlxSKqZ+p/pDYzpZBZpRiAN+Kg4J93dPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcqVcFhGnf9n6l9CMTlNtIimJgYdHHo74A0Z/zpi0Sk=;
 b=PFHRnZet6agSW+5YImI3P+xuxWv80UmoZQ75Z1OJaf1ENXzyLTjS6W+NLiCDxcRrYRZH3v3TYwT9TZDWPYrb5g3/fBEDP8el2Rce71wteAfJSUgPJKn6n9QDiXZIIQtIAayeh2x0huETQSeStuO9VxU+JkGlLhr9wT/NzZf3it0=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 03:49:01 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 03:49:01 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Thread-Topic: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Thread-Index: AQHb/WN0TIA+slWBmUK4+lP+hWGsxrRIFzMAgACFKoCAAQnyAIAAfnsAgA4OFcA=
Date: Fri, 8 Aug 2025 03:49:01 +0000
Message-ID: <PH7PR12MB8596FA05DD99084208A31E50822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729143420.0fd7b627@hermes.local>
 <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-08T03:45:23.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SA5PPFE3F7EF2AE:EE_
x-ms-office365-filtering-correlation-id: e5af432a-4dd2-4aa1-8e1b-08ddd62e832c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?k18g4bbRuUSSjCMP0zvGfqLcrFPh1rZkrdNQ7oxETgAVl8pAQ3ursYX+8uCV?=
 =?us-ascii?Q?5yUJoHtb5X3sAAE02Tok70zIyDhDiRuT7MYPwNOJEsNzRNoq0a/PhWoHeiPC?=
 =?us-ascii?Q?vzP7RTR3bsVeKUxBqDxBQv2ULm5sglStRXGRtejtI0WiDkUgXx6ZcJNfhwca?=
 =?us-ascii?Q?jsvbDr41EauOf3G+BSFEs9GRvQjrZ45qMPb+0wCv6Er8L49DDoxRsp+MSKm1?=
 =?us-ascii?Q?DYtw7/fylAFBh3LuG8DOmpmRbQZ/7juO/0oaIEsdtysT5cD+zEvlgOZJfN+Y?=
 =?us-ascii?Q?Zran/SEIJd7VOgsNQ7/P6o+B5G1vMyvQaqVTISP67x1Mfc08uFBy3huSUxm+?=
 =?us-ascii?Q?za/TA1TSG7a+eV4YuD84xzmG+jUs152KPFrDI87Oz3tpBzsmlL920+npnHVb?=
 =?us-ascii?Q?uHzL5rLMrkHm8sM3RN+mQafcTqEsHXhdfX1qywujzAbyky9xstGqd8QYVGtK?=
 =?us-ascii?Q?jHhp3fYOD/LLcMxBHU5hKW2HVMEHOHIcKvuYpmxDSGIHRyCbPsXsvPUQXDGq?=
 =?us-ascii?Q?gX8SsAcApj0+pAth7ZbAJmoiNUq536LOu/59HZ1LzxeQSmKEtx4wAm5DJ6Xn?=
 =?us-ascii?Q?Ra9DJAMiawoMzRYzbejgdYZT7tV04Mk1ZAI2MMhLW7rcoR3QKD+U9FxjTim9?=
 =?us-ascii?Q?AaP4m7DRKLNu4HYPqP3BEXEu3MBZVHCBn/E4hUc1WE3aae25v+UsxdEvevBP?=
 =?us-ascii?Q?CJ2jKdzgKrxPE8WfcWboZwb72y6MT+luvPgASOQfdjPFDvlbHBr3z7R7Gi67?=
 =?us-ascii?Q?52prkFAVR9w/gvsVPAGgv3H1P1Iod/gZ3s1v9E0M/gxmTb6INiwMTw8x+gie?=
 =?us-ascii?Q?hGQgEOhWynLUyTXii3Ih58OOu1Qn5Uh8juzl+vcREFIB3VzRZdvpDitQgjts?=
 =?us-ascii?Q?VN3vM86L3WEONRAZuMAb2HPbkJ6T5JdoQVV0k4lvtceR/+NYJ66HfCJkswEh?=
 =?us-ascii?Q?8UqbkE+fUXsfV1ALlMaxdO4UZCmgQFl68ngEU9XzJ9MlD/+u/GZePz9P5L3C?=
 =?us-ascii?Q?pvDDFRoznp01sdacW2zMUVF4E9nWoE3X6QkkWKPpNynVhx3xRWTRlVYbbFO5?=
 =?us-ascii?Q?gnTxj67t5UJw9ym+ZvlEqHnY/dtN16ewHKAh8Ml9WJwzLUWO24e8wnZXyNXx?=
 =?us-ascii?Q?xhXTz9tdZv4F6igVGhxvj7haxDFAT3Q02PDZZKNUnTI6Pey3vGrYeLywYSV0?=
 =?us-ascii?Q?urJv+6OXKdpJBZRxZ5L4zzXouNSLNcDBDTVrrwvipLdQx0GOjH+IUADoAJvB?=
 =?us-ascii?Q?ZE8B7Ao4vThuRxu5Fos9HnOuRvnCqvIW1yC/45lWbVzwl09g/RUcxrmOHlIA?=
 =?us-ascii?Q?K8HoYkK4y/y5nyly9+iK8W88rGFlnb6B6rw/JY4trePlb4bC+89c7irjyNG3?=
 =?us-ascii?Q?KA3juoyYiJ3MIEq/yYNztUF/dR0nGtuQQ0e2puQyfz8R2wG3DJauGFrJ7xef?=
 =?us-ascii?Q?2/LBTBp8qU7SuLBWHEqLKKzYOfmYvhivjSCtLaORQL9VhWbjkCjP8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?27HbzUOl8AuvG89XWmox8C1uPEKiG5Cygcx4yXMJvScRqCN13plxXlMyF4tz?=
 =?us-ascii?Q?7ALP3WPavG0+MHhWHyzuQ/YaqslvKe0ToGOfKy689oQ4ZYFS+EziOOlO+LBb?=
 =?us-ascii?Q?HcxG8b2w2fRjrtx2Q7NItHv8J8WMXMgluQGxEnTranzi5vNCtXU17zWmN1U9?=
 =?us-ascii?Q?im6eMMK7xYrCHSc200l91uj0ympxCNPG7GVezg3XxPB67ZI+A6ZR+Tf9Jc5r?=
 =?us-ascii?Q?g1+TDqraBFzXRoroawQRWVZzLgrLW7YXQGEM4qbRY9bJLwayVYtowmKzSW0F?=
 =?us-ascii?Q?Zd1wfBUX6xFyotj1m42z57ZnShpdsaioMp0A1Mra8dsefZ6Sal0nd9IeKyX7?=
 =?us-ascii?Q?pyBqgWR+7InOD16bpjC88tjX4c4yUdcM8kVJa+rcP5qmA28Ky8MVetzfhgI9?=
 =?us-ascii?Q?d/bWi70l+gXKnkW+ehPvBbnWIauMDrjO7hd0Zxl1wp1itaQ5oMes25Dar/G4?=
 =?us-ascii?Q?hLiPfNTwm/iBq+tFberIyC9kCeuWXfXE3sw/V0/PJDMK04G8aKStdv3t76E6?=
 =?us-ascii?Q?HgXxY+f3poIAIAFD1StIuo/EXl33h3iNX6K0VU96dXnjHUp2PFjEUZ1K75Ce?=
 =?us-ascii?Q?+CGoCQ45RkKy0NxCaWkVcTZKWi+8KhdugP+3h8Faa2LIKL/MR+yNAyYToxcz?=
 =?us-ascii?Q?WpXk/NnzMXTyNtCCS1Y57S1Xs448+EMPpemIpp0omgbBeMTtHg1zna/W+aZL?=
 =?us-ascii?Q?Sn16CTGDr3qv5Jb3bOBGEqo2sA8YHQZTsKPAXKfkoN+L5MTnlRNSh1tzBHLD?=
 =?us-ascii?Q?TDTxqMeppOdOVOqwB+FM53ng8oXkWZcsRkQYnq6I0/nmS0U8WBpD9linO2Qx?=
 =?us-ascii?Q?S3K2dxBXxbdicjZG/3pcc+eYcMjG2eAApLHy9IxCThDAz3ScXQWFo5bRKCAq?=
 =?us-ascii?Q?GqWVUfw8jtYp2k9eleRodLjDtch2fvg2f1Z4sstauBAbV0/NbY3w5wwbePv8?=
 =?us-ascii?Q?K4HALfHPi0ErwxaDTsvpY2ykcLOnd+LNRLEO4HmxyckXmcFMFmpVSGtoXKp0?=
 =?us-ascii?Q?kN8pwA/6y5hTlm9plabXV3g7SY3WDiTzn6fWRYm2BUw4skj5teN04o8InQ0b?=
 =?us-ascii?Q?3+kUQKPrNBYmhz+kE43WmJSiStIWfot+odRV0RdOAyA4eNDIk/qBYzs9VE40?=
 =?us-ascii?Q?68YYAWtFxyV9oFkpromhj3xAm6gmoLvfTwHjvLWGZPbMStLRy3ZM3JKojGL4?=
 =?us-ascii?Q?n7ck7//50xzPGnyZaL34/GVOYuNqWpp4EzqQbPYVWrSrHUBRpFxdOmgLdpx5?=
 =?us-ascii?Q?Y5TPlXr9twkYqQcb6Tjuof1X+Vi0nuiYTHq1AO6wYQs5t8lr5Jksv4AX0vic?=
 =?us-ascii?Q?n/k0ffh6Ya2KXofhcAg8Luc9evv1V+9XD7RMMLpNebsPSFySomclKZot197P?=
 =?us-ascii?Q?D8iEzplQTswhUpmP5ozLzsaLo4kw3QVgS7I3UM3QDH3C69E6Z+XnoswI+n6L?=
 =?us-ascii?Q?hPBgjLC6hqZlDrlj7BzFus9lFhj0OT6lsZjBK9my10hoZ8xcY8fWWPCfcst9?=
 =?us-ascii?Q?IGGqJP91r7qOMyQzK9MQ1OpofUZI+m1Ir6fOICK/LHhYuMg88HV1DVrkNfGq?=
 =?us-ascii?Q?u1BNAd62g0A+2/z9UjISuSqrJ5uswoGCf3i2WsAn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af432a-4dd2-4aa1-8e1b-08ddd62e832c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 03:49:01.3903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQq1JA4PeoiknQrJ2Vn1xBGdgtqAa70PiyG+XKdnlmk49uEUItJAj1kJoyvHOiBtK3zm7KR3cPpzpU4UQart1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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

Since somehow the email are split it is difficult to see the indexing

>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Hi Stephen,
>
> Many thanks for diving deeper into the issue and sharing the insights.
>
> I agree. given that the primary tears down all the devices on exit, the s=
econdary is
> left with dangling pointers and inconsistent state.

Secondary if PMD should not be attempting to cleanup (especially for ethdev=
_ptr shared from primary) I agree to that.
But should not be covered in library or PMD. While cleanup for other needs =
to be done properly

 Without a mechanism to notify or synchronize that teardown,

You already have health check added in the code for identify if primay is s=
till alive or not..
There used to be MP thread spawned which actually piggy back the communicat=
ion. Is this broken? Can you please point to git-blame where MP thread does=
 not communicate or notify the cleanup or synchronise (lets fix it asap).


 I think it is the only option for the secondary to exit
> immediately, without attempting any cleanups, once it detects the primary=
 has
> exited.
>
>
> Best regards,
> Khadem
