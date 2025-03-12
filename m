Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5CC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 05:13:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80D2640265;
	Wed, 12 Mar 2025 06:13:05 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by mails.dpdk.org (Postfix) with ESMTP id ABC8540264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 06:13:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFOtke9MFkq9np+ogPpJX9hYZxMqixi1W6rWeyfbniPBfaA4iYLAAsRWS7OuaBj1+mwdvNUWSVWwVo8XUVaPk4dMMc44Oxn8RJYykrBnc+KJXBSVossAJOn0pJgfngaygDbGtbXr3//dK56iwqw6K75DzygyZrTQzsn+h0j0EppM1/uACK9thk1GeSPYxZbgEy0Ev3MfJ1oQ57WmyFwvEbjpdinNYYsC1WRcMYCvRlzub9Zh96kLJyZwlvlNntLu41XlHxoad085TkdVimFgeXYtM3NqkWz9oBUmu3PCZ+bMAIY1GbES5SjRqf7+BIKV7eSDx1reB6b8Hhr0F0cbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9CROJlWP7h//fVWrx+yD/kAwZZz+yi2MbiM0phofG8=;
 b=pdfPehVVihARsTrpicL7hClSy+y+Ob+EJ/VV5g11mWQtcaumKh0ZzqihaQCvISV1Az4JrI43ucYJvZ0ZRl/ohwvxCjKroHREsR+uFx0IgyYlALs3m4p3ezqFYZckHTsfpAhEZOKdGsPZXf5Laz1/q5CvbHsEidCmX0fqle25W9K7w40oaRt6hCa7530pYJhpIC7qw+8+wrd9dTDAOAYWkPDqT0jwslxtCht1LoyDOeCGXuTum7qpm67S/O9imzJdRW7GAu1LS471RKa59hgMDShUpZ3oEPXCdeI3VWiAm5KEWf5/nXyJphxj0yLH2e0pgOdoon2Nh9BoL8EnK0gWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9CROJlWP7h//fVWrx+yD/kAwZZz+yi2MbiM0phofG8=;
 b=g/YPrw7Nbh/M7ZcFkmk7pFoucKnvreDKYFa1WkLaUZTjCN5XH00vpRvLtGohVkbKB352pwVpazgU20g0dut1vYYEaDVf2NO0xiIWT/S9shqGjXm9KIxsuEM/pMTnmIMAlyvx0IkX9DYN9jtJ2FFrZpxnJbHh1U4toUd8qw9jmWMz8ipuOTcUUkuxDPkp1380Q0lEakKaBA5Kf2Z4cThuE+fe29+bl6/W99FXSXoYiDxSOuT9Ehfq+KxDxLr1rmBVsXWrS2JqVtiZtOfVHnWl2eeRTQmgelKfwK8gV1wl09p9dRWroEKuPUn0V/5E9jUwmygqITVsoug60WFDaY3MVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:13:01 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:13:01 +0000
Date: Wed, 12 Mar 2025 07:12:56 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org, thomas@monjalon.net, 
 mkashani@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <20250310080058.3ae00bd3@hermes.local>
Message-ID: <ff97cb36-d543-76c3-e810-0d4589f5aafb@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250310080058.3ae00bd3@hermes.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: LO6P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::20) To PH7PR12MB6811.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 41136caa-dc36-47cf-3635-08dd61248f84
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?opmjPYUFUxUvoXax6xLoRM7SLjgWIwAfL2XqpSc0TR7uRrGH3BmBBAJ3UaH3?=
 =?us-ascii?Q?a8unfH1lWtY9BooI3W5RbAPvh7/0H3FUnm4F8YMLojVX74zWWBh/U1BnlVr+?=
 =?us-ascii?Q?bhMCJgKJgGZrW2+1P2rxwqVP6mvyet3zUiOrqx6zqgUzrIXQCca67gyWsi17?=
 =?us-ascii?Q?fLpouL9OcvLgT4FvO+MhQvxGJXLU2S3Zsxi+egB8QBJnFvhBP4XKtn+Wgp7V?=
 =?us-ascii?Q?9hZNRCqslN8b6wmg+OhsFvmvnMNy6kPWmCKP99grs3YwH7OPWeOc4zjlBp2k?=
 =?us-ascii?Q?q/Th/hsdWKIPwrQG6JevQzNRhC7egzPIe1UvmM+Hwt2ZzW3zuv3A5RnPQWUR?=
 =?us-ascii?Q?6uoDsKQVhwPUnjxAt/Qeme14Vj7EJywPg3s2rwoLcKMHQThgKkuYgg4t2D6U?=
 =?us-ascii?Q?X8Zmg5LnS43xsQpi6G4YekwHm5qBZDPUpdGCGiI9bZoX5zG1RUnoEmxN5p/p?=
 =?us-ascii?Q?QPDjK4j9otwzHRgeLyLcMTsdOohV6mm4qD4yqpaXxbMMGAXQkcNMWFWtxm6i?=
 =?us-ascii?Q?5JCm0Unh5G+UZfPG3qbwQTCImAZpNwqZqQ5SbmiEQPq+EnyRZfwJrgVEJMqQ?=
 =?us-ascii?Q?o/m4BXMuVAvtcFr/0QZd2Q7+pmDmBrGnp3YraXBFXqK+GiwAyo45ewzKO6+Y?=
 =?us-ascii?Q?7/ZjX2/AcSQVPKmIsF4NGJNx+2vPejbeT2SrGi5/+4x3tpiuEUZhMSwf64eu?=
 =?us-ascii?Q?80uOBbj1i7CbzIZAwhPJfBGzy+Jita43QUeKdz06f9R4MoMzfWf/plALk/lY?=
 =?us-ascii?Q?ey1Q6jd+ODrXChBFVBvwgI4P+vd5d6Y7G9VKHd74xrzmDerLIgBWZb5zVlgA?=
 =?us-ascii?Q?Ht76OB56ghonXvhRywygiq9kBbMSo3kkm/tL3OltIWrG5WepJtepeV1+cpKQ?=
 =?us-ascii?Q?TH+f6Lr/eQSpZt8t55soa4CcT37u/iy0jlZ7L/ATPa5kRFGuH7zMB00WOvQk?=
 =?us-ascii?Q?YXkogj5vbRG7xP4blD42UMFI/yG3VYnczhlkcV38av1FP5H89D7x/AFm3Ar4?=
 =?us-ascii?Q?Dqkx+9PxV6UxlrFAAzi1/xgHH+PiXAzQSGXrIGohB5i996N+bCTPNAxQTLzG?=
 =?us-ascii?Q?HnyTVHmPGRPzT0gFUkNU4m1bknbCGuLTGJetgAP950CSA86MRFL4bBMPG0vm?=
 =?us-ascii?Q?5ENvpR8Y8jBbn7ek8O4EIO7ntcVjetVa+a4v4EQ4Ox7q+mBxFPuC/UTwPtte?=
 =?us-ascii?Q?A51/zY1eSTsxqAcoXp9/v0xBy2zLh2WmdN/LgcUOJvh+K0OsVXayd/6s0G3X?=
 =?us-ascii?Q?TXlKMja99LFw4s2FEEz0O0kyns1GAlHV6h2WEUtDxk+29xenLpvh+theNM2F?=
 =?us-ascii?Q?fOkJrPwmqYtfz6QGeQyRthchRtqJRMDSx10XlOjnY4uYGa8vOioUwUjMsgdV?=
 =?us-ascii?Q?Zb4vUTBtHkqwUoLWSk2iuU1juZUi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OG0o66s6SfulIskTedKUga64oJiZoS4WCrUkEEU3B299vNYMmOtHCufrP3Mi?=
 =?us-ascii?Q?ALEp6YFlWPefv9fhR2mXEEzA7DBvdz99E3fGwuH0l/nNFG2EMt3EJYP50sny?=
 =?us-ascii?Q?oWBKqskX1xhcMXnP1cZ7KgRQqeKypzvs3PgjVK3uyvBw7Wt1gNJPllcTJc4q?=
 =?us-ascii?Q?4QHThWIYhK2IBuFnb1zNBnLLfYH94Sn0Chz/a37PNXlQNfQH7ky4yZmLTiBv?=
 =?us-ascii?Q?wpuMF6o19vIltdm+26LkyPg1hKb6hxIX1BtClkXpLAlXrqr6P/iFaui93+dZ?=
 =?us-ascii?Q?oZd/Ear30PMvvKmRzEe1yOIphjcAO+XHyjtdkVK2tmzvsBnVbBFgwatyvM2r?=
 =?us-ascii?Q?z37VegUUndaIlNBLAg2UdSSDjiunKu2J8Ak+4PEajsbTPsxVwPcY6lpLIMxE?=
 =?us-ascii?Q?EhezzBT0MmDyS5HxMC98/XZgjamaiKe0RWkaWzHvFkMjD4FWwCovi9AB1ZLl?=
 =?us-ascii?Q?XZfmpu9EWGqbabNcw1zC2e+mqyToU1R59doKEMCAAwP54Nnkdnbniixq4pM0?=
 =?us-ascii?Q?KSUpL6rrTq1GvCq7beRlqLxe1MZ5DKZllY0MsA3e5Hg+YjcxEciJUypqw7ik?=
 =?us-ascii?Q?GQtmFJtD7ZdxKqnM4vk1joj1glqjYaNyWXMrUxDZrX2vehTDYtFpCDTjnWAr?=
 =?us-ascii?Q?/uO5l5/sRB2FNO1Xf6qpeaBKmwvy1TdJx9DoKvzzd5SU3tG99P2zddHqD6U+?=
 =?us-ascii?Q?boM7Y4vzEpNykN1IGZiAK5ytiyS+5Ns8zxI3m+ysWlmneijVeogrZqNihBsp?=
 =?us-ascii?Q?qmBri8B91txCaSyYrKVLYxYIyi1EETbFTS6DBWj7/LCXgPN4YmKBYrNWkO3n?=
 =?us-ascii?Q?90yGfZgcevD4pLSYXG2T+uzT1iYOURIq60q6XKOU2hsFo2z01xAKNXFtDrHg?=
 =?us-ascii?Q?vYRUVZbH+IYOFceqAQIGVcf92k8k0MJJ72cCUkHoJNIhCCMww0LEheepL4OB?=
 =?us-ascii?Q?7TeSNQxO+pshTA01aOeKFPvGO6+9wE4+PiwEldjai538J/OjNlJwX0lTHTcN?=
 =?us-ascii?Q?u0EzhuQzLpBtXfrF69WTCKLT6F0bTftE0aZ0KcPltqeEbZmufssNQAvyK8ta?=
 =?us-ascii?Q?UyiqBN7K0SbU4RG4hIPsE9iw3EzYTWajeM4gtfm61RiJLgiohcJXE2HMfpA2?=
 =?us-ascii?Q?Fo5Y2A4DLteQRCfPcEhYNEoPR/DEUflkBU9GAmAoOzr8vNxnAoCy3PbSyJmH?=
 =?us-ascii?Q?UHhTgDTPebIiCySFOjUSVCaD/PW1WcEEOAB6N42M5xclDsWJlGxlW74f7LDa?=
 =?us-ascii?Q?3pwHxlX8VkzG3lwrwIWH8Z3a3vPfu2a2u/c+HRR90dhL6LQbG7GqjDaqgEEA?=
 =?us-ascii?Q?6h4rzGlueFAfC4rH6tVKh6cgub4+cTr7eeYkG2gVL+ZHeYeobMey4zEp2F6L?=
 =?us-ascii?Q?V45rKC5fTWyibTEf5+4uFuOL6HV1gjRAmwhfEQWAIYpmZpyhH/ze4l14MeRH?=
 =?us-ascii?Q?POO+ZQ2MxG63iV0CjB7tzyXfINgOmnUeqNilNes0qgIvuvj6ohuxs20RTgBD?=
 =?us-ascii?Q?yc6A1Th28cfrhxTljsT622Lq4wziDr99HdosV08+tD2HCH3zBNNT1xSE6SgJ?=
 =?us-ascii?Q?pdfd863TVPeAxSZ9gZbYTOJQPo0rPzV/u9Ffifzn96IJ0JXRiVE56njR/yCh?=
 =?us-ascii?Q?hlKpLCw+5R7PfKy5368aJ2Z7QEBf6re6klt/LkWYJfS1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41136caa-dc36-47cf-3635-08dd61248f84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6811.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:13:01.2860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ViKpKAqm0wi41jAuSncixONZbk/sSzYooOA82P1dCZC8YFdcW83ZkCg9uDYZycnuf4aenlYSzQZPUzPjyI7XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

>> +[dependencies]
>> +dpdklib = {path = "MESON_INSTALL_DESTDIR_PREFIX/rust"}
>> \ No newline at end of file
>
> Bad practice.
> Don't forget EOL


I'll fix that

