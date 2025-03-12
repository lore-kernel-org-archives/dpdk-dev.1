Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1890EC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 14:30:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6235A4029E;
	Wed, 12 Mar 2025 15:30:36 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by mails.dpdk.org (Postfix) with ESMTP id 9A13C40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 15:30:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvScQMikB1Ric/R85aY06+Yf5TOnvXdAd9vCfOAbaEbvl6ZKOWB3Wcc2TNqayB92WmFVU/pNcRY6LVP95afSJ2L+qjQQ/oZtNWoSuv1dovf6et2u3WcA6WLQSmmlt/QY+fUuDyZ/8PfBTh/poCgZeLQdMpDnlThWp84lMTyuE4jkmaGX2RChNhoSPS2TMiToklYw9v5GkDtwBLUDNsyAcauNJwv8KL0g0rmqvTw5msmQBYQYQZvGlQR76TVeyFe66WUJBbLaTeDCUGzGpfseRWPMamy07V4eof1+pV1zAJk6PkqtunGU1cdY+UZ8N7qRAYZlriN/L1Reh5gm/LQIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36iAfsCZL2+JHi37IyTgTGL3lcPVWNZ83SrcfXvWcz0=;
 b=Rz77B0Rq2fKo6YNI/lPMznHzrIkd80UZ0Yaid+DPyZEmrYCWqdaew9oW7p6Dhm/HEadjAwRVOHN2b0DDr5iMTf1YVXaH1fcJ2eNQ2qqJJS7IQ14b4JSjyDGDRyrhv16b7cl4eg9Mc5hygQwe1fZKfBV+tHy7O19jxoIJjJXHocHcyCF18FfA4WT0wprUU1MwSJeGAvalb5AmZ7UbeWnHnYscVcK4j+rzVNH/cWUEDnFmLF5JqmxnN29AaUU/dFaksMaLB0OdBJ6EuizqBO0VbugpLsPDCV+5GItaD96ZFI69K7xWnkN5bvqxfo+cFHWdsG9WhqMTtJuQMiuXr2IVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36iAfsCZL2+JHi37IyTgTGL3lcPVWNZ83SrcfXvWcz0=;
 b=toLn8XaKp5iGS+58Yj+gaeVymRuSZe6dQOhuWvQEzU0i8/Rg1cmAG0N5DWWs2M6TB0GCkiwoTPmdsu1j5Dr3wa5zkd5ipkteZMa70ktQWKyg7ejIWdawtxgBsXR2KRBBj8k2rssyW1eOkomlxfYQNOM7E+l5GXtzH+a0VZU9fy89+PdZDyBWAOLfTUv/WrwjwW1y8DTY8st+ppwSlhmPoHlF64cs7in+yByVB/v7MCwS8g+LeTvZP+aojsKu0GHDVt9ub8BmL54f1lyL64Mw4FAOBeP5nmfB7IVhPGzfCZvx3jmcspPZcYV5iOGvQ1UtSN+g5j7m98vFF1ECkf7PDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:30:29 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:30:29 +0000
Date: Wed, 12 Mar 2025 16:30:24 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org, thomas@monjalon.net, 
 mkashani@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <20250310091844.4a3ff0d1@hermes.local>
Message-ID: <d380333c-4c47-116e-f917-14b101898e6f@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250310091844.4a3ff0d1@hermes.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To PH7PR12MB6811.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: d89a5896-87b3-42ef-0946-08dd61726fef
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lrE8CDEo3MCEunAHM0j9D0t4uqngECihFTP7nTD4bj8A3E8NwCAd9cO1cglg?=
 =?us-ascii?Q?wh0FLWnyW/4yehPC/eTU7gWuUzLmRD+MDpWKisF3AiyxxV2qa1RhjXhqVTA3?=
 =?us-ascii?Q?0LnNccyhnk/ttCoiF6hRNDvMgfSBKyH8gfnBBKUz+CYHkc0J/A3dyJQOAfMz?=
 =?us-ascii?Q?zbGD14HnhqgqGLg2y++Iodtdc/7fDA1EHbCvUivMphWDNzEwXUIcmFhUFKfU?=
 =?us-ascii?Q?BB4BpPEABiPHeZ11kQZwqvncEELilifflRZPh/T1mUetkXAW8f4M6jWOxLAT?=
 =?us-ascii?Q?8kxyXr24PRi8esM/0qKqO240IAJam6fyr/f+JITJvqXuWBjsqAod7PsxHHx+?=
 =?us-ascii?Q?5QFXEyuLwyFK6hHAU5Qsc9wx2c9EkEkpCeKfwH7qrMluNyxpvur3ogBP5OY0?=
 =?us-ascii?Q?PcnQ6ND+E7hp1P55PxKc4mlOktzc7asXSC47Om+5h+0zKNGv+brdOQWTzwlw?=
 =?us-ascii?Q?Z1MRVJSFqnezmd4yZbMoBThLufI82y0VwiRA2t+ZQqa5/6beATHrM+6zz26t?=
 =?us-ascii?Q?de3PrzR907arySGCBNuiGuVUbkg7pzunTlphWbBN5IcisPhF69uo59PeL12Q?=
 =?us-ascii?Q?2tv9Pr1lcGMuxz+FEhDqAMk/ug58sLGs+SUQe7Nnfc8cMPeTCXbN3XUdme+C?=
 =?us-ascii?Q?isqipKxDuumSkxJS7qAAjXw/xl3JwThJEKy1DvhUkjUDvWBLqIcPMUVZbYwt?=
 =?us-ascii?Q?wOpz+wM9r3Rz2JoX+BBibHnBxmXKzUne5WqEDxsaJaWN7SQ2+cQAOytmnC+U?=
 =?us-ascii?Q?E4GU4DHsXPLZEwggtJ0rN9qX5t3vTNLVxAuyP4yVOB3nlf4tg+x6bonuPS33?=
 =?us-ascii?Q?l6Q0xqDt+m9uArwE0pE0E4e9VFOLBlYHYczcm7zTyCt0jie164aQYtchJQHs?=
 =?us-ascii?Q?jLLrnuGyJ+tKG2k+jYDFrNGpbvINTInP3PamNyhnj4xEVkGG5l1ORWkd9J/1?=
 =?us-ascii?Q?xMEy4Tiyg2qw9hdGDqoBuaUmjFIkgvK5FM1cAlHsihe/r6E/ydP7OLctPyZO?=
 =?us-ascii?Q?gTW2DFL0db+h2+T4fRTnv9t9MdIGTj1wVk2gwrxU3v24+eL4AkQ3VZQwEKH/?=
 =?us-ascii?Q?xeJf5aUD8WneeAF5BAw8UklZoJW97s4G4dU/w946TcC1ebQzirW5NhZUEtWT?=
 =?us-ascii?Q?LUYgGAPRTVpFtBgjmwa+VuNTymixiZQkoaDZg2P+84ZPbhkSKDJBktHPDEWW?=
 =?us-ascii?Q?1d0AM3XhpklpPc//ikmE1syPA1kRzv9v07/wAZTE+N1Tl4ZMy+xWm8hwOP+P?=
 =?us-ascii?Q?fcPWC4TTe+V53+zGRoPobnR5PgCHJGssAtahPZZo5ystHuWvzeT9vEmUGrOJ?=
 =?us-ascii?Q?V6c7b/k4BcyFTXsRv8YT0UM963gyjUcnYqyN/t66XfpzRrs8EJ8J4n7ss6TU?=
 =?us-ascii?Q?umSYpm8kn+EHira4MDc2S3Pe/2/z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yv+epg6fA/J8hlXtE9uFbHwUjFph4o5xVwT60mAWOCympP4eSxoP3J5kwYkJ?=
 =?us-ascii?Q?uqeMgDSDzyiyMmj7c/pcY1qgvtiHeU0rYG593cS34xeHHdhMwiguYUaJZTH7?=
 =?us-ascii?Q?UIMemWckHS0dJIF2XZLuZCvYtRRNfFfkLabUGjvVOljVkvq3D2emP7DutWt0?=
 =?us-ascii?Q?H+SzrFuYLTmAuS08juePamCajyHBf7ry4waCcM8VhEfBxCmOTBmLHBbY8Wve?=
 =?us-ascii?Q?8CoJScsJEIAYEUj+gCS1ZDBHQ4I2YNMWwGcbnSy6gH1GKd3b823wlzr93ZRi?=
 =?us-ascii?Q?gT/T6OmlSwiskeo8+HXYvFjCw6/hH8ov3idOboDEMgwvwSkdHAST+psyWzkk?=
 =?us-ascii?Q?JdkC/UkH7p1Qk0SEOrnzWb60s/39MwK0hg3BVn7Aibir0jAoyNkLpS0LuUUs?=
 =?us-ascii?Q?pDHOtIcFrxLZ97q28OCRFZn/LK9/+y9mXSjmda9UrCDiL06snC1CASEROq6r?=
 =?us-ascii?Q?BHwNiiKNtCeQ7qPTyA97cRawO69jQwMnQXzUS6DUeRh2bxxqZNP1OIyeMvst?=
 =?us-ascii?Q?EGOKDQOxPRsRPHVxpuzPqKaLDuVApZ9Fiv8/LnnmAaSt4QLRfksu9i7ZDD2d?=
 =?us-ascii?Q?n8ByVkXJ2n54FQoEbil1xHMuINVWhwbFYmDTekWTT2fG7bZEiedxqlkKXLnZ?=
 =?us-ascii?Q?pa4S0Lwq1OgNfipXkElGhz/m6h433DZIw9On+5o9Z43b0nIndRnLyQhZf3mM?=
 =?us-ascii?Q?T4ONa708ktLbwW9sJ8q7wQ6Zi0UE6GPr+kAIZbvHfwTpvz8xdctW3jU+o4x/?=
 =?us-ascii?Q?aOHpOWee7oXyLLhc3Mq+Fp1nt4spnauWG/vM6b03uzSimdSVcBfg7pn0QG/J?=
 =?us-ascii?Q?rwRUVhGRiP/uFV6ee5m4tCTYeM8lvooazGOnI4hXI3I1STUzeTGJm+yl1KqD?=
 =?us-ascii?Q?K77CB+jux9qfXwazRSl8VIYykbenahnGtWuPJm/p4m68LKxK3n+bMgADHSJa?=
 =?us-ascii?Q?igylXJryr4AsbJamnCYiM9LANKMC8Zsn+nWG4ynBeLadnbLfqA0wkU686kxI?=
 =?us-ascii?Q?Od5SgkZV8IIt7Dk/4jOmxOxNHc/d8/A7i8kkq6beR8BjP+Ox/7Rp0g++2cwW?=
 =?us-ascii?Q?lS+KiQiMlpxkZVzyaSv/kkyy+NnckeBQ+GZMnytxXdtyZhTLIQ5m5GqSOQDk?=
 =?us-ascii?Q?09q3eceQM31917XF4GUhhS4Zma6M2eOHmcP3L++hQmPsO6Hx1E0Y1FTsYgxg?=
 =?us-ascii?Q?G5fPrst3icGVHp7GPEy1OMlAlw96GfOjmmr4bjdMzr2MGoE+hGL51s/6aDu2?=
 =?us-ascii?Q?n18mifZmkDFoIMd0wbVBvqogyK/BTjD3VBVfVvtPdoSRkVUtv6VhoV7j+i9b?=
 =?us-ascii?Q?QeHwFOQmaGaMEv8uBss8aP+/R0W4QCxnupyXyNjNA7H9inLJ7ISmupVuiF2q?=
 =?us-ascii?Q?TiuIMIP1kZlJgOByRqqMmRFTbeS9uQk56yHbfU5V/L/Qcjhb0l2jPhaAuW3V?=
 =?us-ascii?Q?8OcyGLkiX6P7G2ThYh2Wf4czX2ph+0cmEXQffABIWRgkqAsRlSG6Sp8H21TI?=
 =?us-ascii?Q?kJt9K+006hnhGeLcRg0AKX4rwPCD8TYP1ezjWTUdLqZ6LM1PGK6SbFysGnsZ?=
 =?us-ascii?Q?QAQGTx4ufA0oci8HyRWFH6srVWs8hDwfyOmD48lrb0upSXXd3FBUoza6O+LP?=
 =?us-ascii?Q?jwG+ihkBKSxNywdGXTLHdFNv/nKdZ1sUL238uF+rvFA9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89a5896-87b3-42ef-0946-08dd61726fef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6811.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:30:29.6859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iqj0rVITQX7qcDcLDzWd7BmIgMP1juILUx4DhVqx5iq1znsPKqhIpjD54BgErtBddrjYvui/lVZ1KL81r/PYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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

>
> Re-implementing test-pmd, l3fwd, etc in Rust is OK but not huge leap.

DPDK examples and applications are part of inner infrastructure.
The patch allows external RUST application as well.


> The real benefit would the ability to support PMD's built in Rust.
> That would be much more invasive
>

It's not sure when and even if vendors decide to work on RUST PMD.
Before that happens, there must be native RUST API with RUST-DPDK library 
functions.

In the meanwhile, RUST application can use existing C API.
Also, having RUST inside DPDK can shape existing API for future conversion.
