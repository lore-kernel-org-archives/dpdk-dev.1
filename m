Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ECCC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:55:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DC4B4064F;
	Wed, 26 Feb 2025 14:55:19 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by mails.dpdk.org (Postfix) with ESMTP id 627824026C;
 Wed, 26 Feb 2025 14:55:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdi8WeFaao9ftpIqgqh3eanQy0lkoEbJmU9S4uoXW/9AtsEd9pOr6uSuPD01eBJO0hp/Gktx4GBYb+JnPjLzqYiU9AhBg5agoqcogDTlRdsc+Q1d8i24xj1S2ef7GzpXJXz8sCTyeVlQJBYAVF8JZJtlIoHRP7aWIQVHhP6ACNJCHW9pZpPhn10obDIXqoxQOGVqxwAt8FOKa9W00cXU1aViky75U8P2wEGV6dySFz2aiiGLsCNcbp5GdnvfrvaPn5k+7zbdl7Sq/EhSnvZdCoxOpb0qTHSKGbi95Ek135VyjhS3yZPDII2OrqbzfpzWgcJ/cgdeXyPQ8q1B/ejSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7I2BWAuq3fLlhZVBV+iaYhsPI0zO84YgG8Ud0nCuA4=;
 b=O6VolhKHDEq+kyhCpq9HuEW0fzZqqB4ItQ0vY/jBExtX6aM0x3OceKQwMltO0PYBNhg9VBmF2KJ11RVXBOxxg3LebE8g9gaQyOkY90tGtMFNOn1RhywF+R/DKPZWvDwyED3LFs0TJmE4o6iybg/XPPJ+pDY7MMXOC7x9D/8xYvjHl41PDq/o0zaf66EsWBvB57kqLgSVSaEZ29+zvJ57ENC1/rtZEDLP74PGnj1H+DLUWvbHMJW08b8YBVMf9aWfS78rCZFfKWTP2RK/mafZJ24Z0C9tL5B0EGBxIoQXy+k0JTUc05Irs1kVBsmLLMvqxUJWSkIBG3oMV/YBCQfXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7I2BWAuq3fLlhZVBV+iaYhsPI0zO84YgG8Ud0nCuA4=;
 b=nsNLSIn2RrmNbdCeYKpCIq1lI3AZT1cL+k3uKCEVtAvE+5DOHAYBI2ZIelUUOA6R/fIXBVgmgzzW5ITrAgpwDkT48KmQm+UtA55UlCE1dnL8MObe+yXZ/5Q7rPeZnuermGiB3IxhPK4w7irYx8n53snm0pvvaJtYW6MVAI/OezMIRzDTgJiR6QsnFiG1ywtOnkRzyctjZxrl9HAmv3a83s6SWY+xegWeUpoalgNawpMpGOgBUETykPgNKCk8EfZ88izDYhrmaTlQdrOpLkW1TWyXuw3vs/cpcJRUQFBW0Nkyc3WZfZeuOcRKuCS8RCpr9MTJkXnQ/bMb92aM2zlXBw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 13:55:15 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:55:15 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, Tamar Mashiah <tmashiah@nvidia.com>, 
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone actions
Thread-Topic: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone
 actions
Thread-Index: AQHbffHvUrQfOT9x8k6xBO5bDo2OALNZsBXK
Date: Wed, 26 Feb 2025 13:55:14 +0000
Message-ID: <CH3PR12MB846056838053BC525FBF28FDCFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250213083239.94360-1-getelson@nvidia.com>
In-Reply-To: <20250213083239.94360-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MN0PR12MB6126:EE_
x-ms-office365-filtering-correlation-id: af717468-b2b0-4f4b-1330-08dd566d3235
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?umavHtUTaJsFX8jRqZLs8WsChK9HFSw/Xm5IMvD7boyoJd7+ddBSau7tdx?=
 =?iso-8859-1?Q?ymrTkP6HtyhS6K2+Uqy7SrEmtOcB2f+KYEvCsiIXOMxxAFASj2sj5zUbbS?=
 =?iso-8859-1?Q?ZoWWa4NiDQtfCPL/Uj08+M4OnHlH4qtqL9rO61ThEclRQvTkUxbl+X9FYp?=
 =?iso-8859-1?Q?QK0v0SirbBzdKKwzJDEuGRz95Q5MjWyaWSlgPITlJ+KXwnHfQxO12Xmrpl?=
 =?iso-8859-1?Q?KdUA+X1d/GVTFpmZ5Uk6OHY92RdBCc8vPqv9UZE6U+f9/GG6PbvDviITXr?=
 =?iso-8859-1?Q?qYyOJE6Rir64nFjFyUppqUpUoo19hJbUBzMgVIkcYzY+9DBsZXbW9HDiH+?=
 =?iso-8859-1?Q?RVHQ/U/430AVNy5QrxNHIh89mK0byo3IcGk+2Hd+LeO+45fN+CjkXLSeQS?=
 =?iso-8859-1?Q?UowGMZDHeZEaCyUuhHsLcvRTWtnIh3YaHCDMI2V6Bw+20Bmb8JDXS+LftB?=
 =?iso-8859-1?Q?JvL38J7ljnXVbetwtv+TJcD7vxSuXhIj4Gj0srr3k9MNNtZ4jxrSPZLxxV?=
 =?iso-8859-1?Q?k1R+V2Y6+5blSgbBii7VpsEEw1fT2h5FRM4Z/ctikJVfzgA0QYjbw+M+SO?=
 =?iso-8859-1?Q?+VgSgG0PceaPbx5Th78XPKLSBx1hpGdpY+Ah4G6xlZ+JSVNTtPEm0yUGKA?=
 =?iso-8859-1?Q?vkxePmha5J3e/uX2jQtD8hqpfD3CB3wIbheiUW2Vh7ydgxDc40zYVasmST?=
 =?iso-8859-1?Q?SuvqqtK41toVjF3T/9P67uAu/J5fzm6hGC+HUDq1gB/JDmyccpHFByLMT0?=
 =?iso-8859-1?Q?v+jrtQcgiyh9c+SWb0wAL54wUFxPznj7EM+pvAnGmRFv5LTE0ZSYwiS1IK?=
 =?iso-8859-1?Q?fhSHjn9R4G+9ktpmb2dJApt3oY15q+FkjjdCuIumU5JkpVmGPGn8YItN8w?=
 =?iso-8859-1?Q?DB+wbLK3EReIRzb6/QBq8KIKmzId3z4RkPG8NqXxTDRhIO6SpVFPMsRE6j?=
 =?iso-8859-1?Q?c+8nlofTgs6z3JX9KCM3edDXN27BTyB4LX8vI0B4lx47JQzzxGSkGgiC9r?=
 =?iso-8859-1?Q?Un0gLSOx54UMbH9De8u+KmubZyQEcgNSxiNllfUqxZTa7cxFsIarUKCoNp?=
 =?iso-8859-1?Q?PwbbvOEgyaN+94b4B9/VRWGSafLMssNBTX0Ly+YbBh7olADTi7HwPGAfDp?=
 =?iso-8859-1?Q?Ap/Z88P8g/USjv9wH3jgK4uNzc96cHAAQNmHWKUmmJV2BfWjXmWQgtFBWv?=
 =?iso-8859-1?Q?PqO/wE992W0/vPM3TrmHT1wL8HD31lqg2sUcm6SrX48YFRQouG5xFv75zG?=
 =?iso-8859-1?Q?I4ymVnyP3nYj19TjStWKhCJldNukVboAiaXN36a4L2qB6CwGu3FxewnUWA?=
 =?iso-8859-1?Q?NIZOI5h7SmgzV0rwJ5FqUyEX7kmRbO3X+E0o7T3tCq+LO15ruwro4r1nk/?=
 =?iso-8859-1?Q?MmUGMwTHN0q6i7MIzy5U1Ws9GNLIt017/ZGGOzclU31+AnimSGyaxw/DF8?=
 =?iso-8859-1?Q?gYTiGub1Bcls+DC65rNE7m/nwyiFgN3WuIC74NvskmIGtisEh81/RJmePd?=
 =?iso-8859-1?Q?MQLGMUjnyVhE2YUmjtRd94?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VMK57GHdX2pVc+GfsLcnFSIRHxXcEJaz9NZFJjT/Drya/C41cK3DvjYdUi?=
 =?iso-8859-1?Q?kPvC+nXw8PgoUPhwhmNA+TGASZlbJKy0eklFZ10vdON7E36p/iySX3Hkaj?=
 =?iso-8859-1?Q?mh0BrRQo6qVBA9SK+Z9P2ocxpRHTaN7rjuBo8RvmJ0Oa14gjJ7Zdi8AkLP?=
 =?iso-8859-1?Q?GnpmSAkBU8DAUXoooN9psLydetQGRCkAja5FUYA4nmkGskNac+/f83dYzS?=
 =?iso-8859-1?Q?k0NqOPYm+6yEpwFMqPJTkoSgUnUSEvsxTx5l36G1m2oRnP1TNF02QHYEOV?=
 =?iso-8859-1?Q?I862L++6Fc0q3u1dxRhV9Zee/zlq6hYi8NeJGFLDcTTyq/4bNQtIqZGIuO?=
 =?iso-8859-1?Q?Dkk8orKesgxdDy9cwKfJFd1Uds06YgrUriOTDMK5xkPUX+29ZAc/L3XsZP?=
 =?iso-8859-1?Q?Ax99H0ETm9dP6V9RCfGrvTNVOR57xz9Mub6eigq7oZTbo87SWuYb7JT/cZ?=
 =?iso-8859-1?Q?2HuC4/mM/VCJlA9Q2NpME0h4is15UBc846AZyXahzCd8NopBFp0HtQ8lKF?=
 =?iso-8859-1?Q?+rXoC10LIwHK5fF6n7ATYPAVgQZsOi14JP5eeQnhez8gEwCvRAiE+0z7kp?=
 =?iso-8859-1?Q?ByPEQnmY6MSEJKfpp22WwmUPAh0oIZusOkcuhhg+qqlMcJqi20XMtayiDr?=
 =?iso-8859-1?Q?NzWTlTvDCRgzYAGKPyQTG4DBfWTC8CdBzTpVJ3+cToNhnJUHCH2V9SEgI3?=
 =?iso-8859-1?Q?SqlhSiHtlcjP93vLcNGYTV8M+5cC8/1n5ISzBAaEK1zxdC8HIzy6NZv1zb?=
 =?iso-8859-1?Q?7YBpn8ceSr/Fe7ui6+T7G1PrTjxNA5XpYc9as6V/sqRR4H9i2ptVG298Zx?=
 =?iso-8859-1?Q?FQGP1wtUIkWf9Y+bEFqZJmyL42FneG7ZtUmDNeZ3jNmiyiesm/JJWMTHxy?=
 =?iso-8859-1?Q?g+EZzON0DxxY7Sd9NZUCVjfdXAxwaNO2Uc71GMwG1/DJFRVxS0cP78lg1g?=
 =?iso-8859-1?Q?rqju17lOhwLWF5oyVZfJ6ZuF6qCZvkO5fv3SY+ESm1fAmlKLY05sRH8CaF?=
 =?iso-8859-1?Q?dAjmjjZ59DQff0x/b8d1PYYsxb5LhjWdBF5IelwYputyANjYTA89hBZqhP?=
 =?iso-8859-1?Q?0FH0DyUeAhgy5S2pHHYXWHcoV82mYD9wHQEevqVlfC6fSK6wFuSjEUIuF/?=
 =?iso-8859-1?Q?PlJl4wZp6Nn7KfjhzJlfqxVhu0y6EWUjNvagwhfMhr9wdNGAY+csmK2fh6?=
 =?iso-8859-1?Q?DqRA1eMXk5frwwI1pybTTUgpePdFgDsiw/J3tjMysJjLQYY8o0dZmWkazX?=
 =?iso-8859-1?Q?3hkvT7RjWKOyviI3JN/R57MV8q35S4I5FPRTVo+CcFR007xS1xzggFeiyj?=
 =?iso-8859-1?Q?fSW7Qj5l7fbP7VQGp5i4f+z3f9AFeJEPK3r/30MmTfhS78dsuFoRww5oJi?=
 =?iso-8859-1?Q?kze4CwDgNmkskZXVuvPo96dtMdDalOSHHrOROXzn1tAnKZJZKu/VCAXjfK?=
 =?iso-8859-1?Q?X2OLk1dVnElllLOMVYdSsKsqb5VhZxXtx4LX1mRoDIzbNeg8sR+hbWuV8I?=
 =?iso-8859-1?Q?0dmjyBaZ1NZJF7Up1HMx7xRVA8Z5EwO8lTcN9+lTumIyJuwPZTwCCuvkls?=
 =?iso-8859-1?Q?FdbA1SB4pijzV1T7M6j/ni6PvI7cRm2egvoBTPmqvqKBRXifS7n1QuyOkl?=
 =?iso-8859-1?Q?pLVwFeqUFjC2uz+izS1md5GASO8Fgv3D9g?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af717468-b2b0-4f4b-1330-08dd566d3235
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:55:14.9949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcuwGq4DtOEhvu4D5MqCBr1dA2U67J70CzOmfIRhCHmhGBhr+mHgVMrc72JV76mqC62kLwi6O7hfmcMyYskzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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
From: Gregory Etelson <getelson@nvidia.com>=0A=
Sent: Thursday, February 13, 2025 10:32 AM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh; Tamar Mashiah; stabl=
e@dpdk.org=0A=
Subject: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone actions=
=0A=
=0A=
From: Tamar Mashiah <tmashiah@nvidia.com>=0A=
=0A=
Add DROP destination to mirror clone actions.=0A=
=0A=
cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Tamar Mashiah <tmashiah@nvidia.com>=0A=
=0A=
=0A=
Series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
